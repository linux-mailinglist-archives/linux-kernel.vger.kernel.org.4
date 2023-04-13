Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46E6E15D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjDMU17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1976B4EE3;
        Thu, 13 Apr 2023 13:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A524664173;
        Thu, 13 Apr 2023 20:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3FAC433D2;
        Thu, 13 Apr 2023 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681417675;
        bh=tHQ8cwz6KhzRX4YpyXNpKVgdtMFBdTUZxRIs7jrGTT8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cwX6zoyA3cluykuo02MD/1bX+/U4EQAh4I/1OeyEXUSJOapwTNmTzGdSzCObhYBPB
         iYyHgdR0VT6mNMen0IcOTISqOIif5WrOOXyJQMxQXEJlQFPSHUgwMM5qTF1ZsMMwmN
         zJFyXmpotczIDTnE70RYeI7yQVdaCOoP0d4vtZTxHhGWegfIeib7Buo9X6uKK034Z/
         Xm15Sk4qSe3WtzIXKFM7UpQfU8tuB4Ht+oyrYop7A9j7nzQXAZLLNJYDW2FUt1/MXM
         kCRBma9acwG2tve3nzeg2mjIFU0bxukgRBFIgolq0nDdIu4RA0X31xS/y47YzYBEiE
         A6rnURs8vDcKw==
Message-ID: <4f57a7ccc946d18be5eb9a47fa69e5f8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230412053824.106-10-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com> <20230412053824.106-10-ychuang570808@gmail.com>
Subject: Re: [PATCH v7 09/12] clk: nuvoton: Add clock driver for ma35d1 clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Thu, 13 Apr 2023 13:27:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-04-11 22:38:21)
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-divider.c b/drivers/clk/nuvot=
on/clk-ma35d1-divider.c
> new file mode 100644
> index 000000000000..8d573ba3dfd3
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-divider.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
[...]
> +struct clk_hw *ma35d1_reg_adc_clkdiv(struct device *dev, const char *nam=
e,
> +                                    const char *parent_name,
> +                                    spinlock_t *lock,
> +                                    unsigned long flags, void __iomem *r=
eg,
> +                                    u8 shift, u8 width, u32 mask_bit)
> +{
> +       struct ma35d1_adc_clk_div *div;
> +       struct clk_init_data init;
> +       struct clk_div_table *table;
> +       u32 max_div, min_div;
> +       struct clk_hw *hw;
> +       int ret;
> +       int i;
> +
> +       div =3D devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +       if (!div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       max_div =3D clk_div_mask(width) + 1;
> +       min_div =3D 1;
> +
> +       table =3D devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERN=
EL);
> +       if (!table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < max_div; i++) {
> +               table[i].val =3D min_div + i;
> +               table[i].div =3D 2 * table[i].val;
> +       }
> +       table[max_div].val =3D 0;
> +       table[max_div].div =3D 0;
> +
> +       init.name =3D name;
> +       init.ops =3D &ma35d1_adc_clkdiv_ops;
> +       init.flags |=3D flags;
> +       init.parent_names =3D parent_name ? &parent_name : NULL;

Can you use parent_data instead?

> +       init.num_parents =3D parent_name ? 1 : 0;
> +
> +       div->reg =3D reg;
> +       div->shift =3D shift;
> +       div->width =3D width;
> +       div->mask =3D mask_bit ? BIT(mask_bit) : 0;
> +       div->lock =3D lock;
> +       div->hw.init =3D &init;
> +       div->table =3D table;
> +
> +       hw =3D &div->hw;
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1-pll.c b/drivers/clk/nuvoton/c=
lk-ma35d1-pll.c
> new file mode 100644
> index 000000000000..6de67c964a2d
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1-pll.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "clk-ma35d1.h"
> +
> +struct ma35d1_clk_pll {
> +       struct clk_hw hw;
> +       u8 type;
> +       u8 mode;
> +       void __iomem *ctl0_base;
> +       void __iomem *ctl1_base;
> +       void __iomem *ctl2_base;
> +};
> +
[..]
> +struct clk_hw *ma35d1_reg_clk_pll(enum ma35d1_pll_type type,
> +                                 struct device *dev,
> +                                 u8 u8mode, const char *name,
> +                                 const char *parent,
> +                                 void __iomem *base)
> +{
> +       struct ma35d1_clk_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data init =3D {};
> +       int ret;
> +
> +       pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pll->type =3D type;
> +       pll->mode =3D u8mode;
> +       pll->ctl0_base =3D base + REG_PLL_CTL0_OFFSET;
> +       pll->ctl1_base =3D base + REG_PLL_CTL1_OFFSET;
> +       pll->ctl2_base =3D base + REG_PLL_CTL2_OFFSET;
> +
> +       init.name =3D name;
> +       init.flags =3D 0;
> +       init.parent_names =3D &parent;

Can you use parent_data instead?

> +       init.num_parents =3D 1;
> +
> +       if (type =3D=3D MA35D1_CAPLL || type =3D=3D MA35D1_DDRPLL)
> +               init.ops =3D &ma35d1_clk_fixed_pll_ops;
> +       else
> +               init.ops =3D &ma35d1_clk_pll_ops;
> +
> +       pll->hw.init =3D &init;
> +       hw =3D &pll->hw;
> +
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +       return hw;
> +}
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-m=
a35d1.c
> new file mode 100644
> index 000000000000..066e1c6f2d35
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.c
> @@ -0,0 +1,897 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +#include "clk-ma35d1.h"
> +
> +static DEFINE_SPINLOCK(ma35d1_lock);
> +
> +static const struct clk_parent_data ca35clk_sel_clks[] =3D {
> +       { .fw_name =3D "hxt", .name =3D "hxt" },
> +       { .fw_name =3D "capll", .name =3D "capll" },
> +       { .fw_name =3D "ddrpll", .name =3D "ddrpll" },
> +       { .fw_name =3D "dummy", .name =3D "dummy" }

What is 'dummy'? Is that in the binding? Note, don't put both .fw_name
and .name in the binding. For new drivers, prefer to use .index or .hw
and never use .name to describe parents.

> +};
> +
> +static const char *const sysclk0_sel_clks[] =3D {
> +       "epll_div2", "syspll"
[...]
> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-m=
a35d1.h
> new file mode 100644
> index 000000000000..28c60f081788
> --- /dev/null
> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Nuvoton Technology Corp.
> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
> + */
> +
> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
> +#define __DRV_CLK_NUVOTON_MA35D1_H

Is this header included in one C file? If so, remove the header file and
put the contents in the C file.
