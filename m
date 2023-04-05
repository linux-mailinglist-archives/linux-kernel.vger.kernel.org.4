Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE76D875F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDETwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjDETvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908783FD;
        Wed,  5 Apr 2023 12:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA6C6408D;
        Wed,  5 Apr 2023 19:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C1C433EF;
        Wed,  5 Apr 2023 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680724289;
        bh=mvW0nhhXl+nnd8bnzJ8O2pejwz/b2+j8dEiIT4eeayA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f8EdbnTeU6l0SfDUvn9bh+Q0ooy6KRILcc75rV9+ZBfHDpdFrHMuxL+imnFbpU5Iz
         MIM82wzjFvMyBPeum0YTt38BB2PPmE+yCWzH8J4OOiWl0+xjJxFng5qkXlr2/GnETj
         aPf1ISYsPA09mlNu5ItWZPwrmHoz6KzglItnKJoJPZQ8othipbiZsP77WWMcWE63pE
         XVHSqf6FJju3ltmQGMqZOQxRylHkq/Qpt5KKi4DFjOzKvrc2KJ8BcqgayA6cjv43iS
         nIAwHoV82NSm/XvVBWVibt5NiFxU0uaBXDN7R6MJk+AlJIFvsDN0KbFRxgzhhW0QiM
         /QNolFPtxqWww==
Message-ID: <746f8ddc1036179c6f2569e0bc98033b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230329075104.165176-2-mmyangfl@gmail.com>
References: <20230329075104.165176-1-mmyangfl@gmail.com> <20230329075104.165176-2-mmyangfl@gmail.com>
Subject: Re: [PATCH v2 1/4] clk: hisilicon: Add helper functions for platform driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 05 Apr 2023 12:51:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-29 00:50:50)
> diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
> index 7a9b42e1b027..def94498e14d 100644
> --- a/drivers/clk/hisilicon/clk.h
> +++ b/drivers/clk/hisilicon/clk.h
> @@ -103,6 +105,38 @@ struct hisi_gate_clock {
>         const char              *alias;
>  };
> =20
> +struct hisi_clocks {
> +       int nr;
> +
> +       int (*prologue)(struct device *dev, struct hisi_clock_data *data);
> +
> +       const struct hisi_fixed_rate_clock *fixed_rate_clks;
> +       int fixed_rate_clks_num;

size_t for all these num types and 'nr'?

> +
> +       const struct hisi_fixed_factor_clock *fixed_factor_clks;
> +       int fixed_factor_clks_num;
> +
> +       const struct hisi_mux_clock *mux_clks;
> +       int mux_clks_num;
> +
> +       const struct hisi_phase_clock *phase_clks;
> +       int phase_clks_num;
> +
> +       const struct hisi_divider_clock *divider_clks;
> +       int divider_clks_num;
> +
> +       const struct hisi_gate_clock *gate_clks;
> +       int gate_clks_num;
> +
> +       const struct hisi_gate_clock *gate_sep_clks;
> +       int gate_sep_clks_num;
> +
> +       const void *customized_clks;
> +       int customized_clks_num;
> +       int (*clk_register_customized)(struct device *dev, const void *cl=
ks,
> +                                      int num, struct hisi_clock_data *d=
ata);
> +};
> +
>  struct clk *hisi_register_clkgate_sep(struct device *, const char *,
>                                 const char *, unsigned long,
>                                 void __iomem *, u8,
> @@ -134,7 +169,16 @@ void hisi_clk_register_gate_sep(const struct hisi_ga=
te_clock *,
>  void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
>                                 int, struct hisi_clock_data *);
> =20
> -#define hisi_clk_unregister(type) \
> +int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
> +                     struct hisi_clock_data *data);
> +
> +/* helper functions for platform driver */
> +
> +int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks=
 *clks);
> +int hisi_clk_probe(struct platform_device *pdev);
> +int hisi_clk_remove(struct platform_device *pdev);
> +
> +#define hisi_clk_unregister_fn(type) \
>  static inline \
>  void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
>                                 int nums, struct hisi_clock_data *data) \
> @@ -148,10 +192,10 @@ void hisi_clk_unregister_##type(const struct hisi_#=
#type##_clock *clks, \
>         } \
>  }
> =20
> -hisi_clk_unregister(fixed_rate)
> -hisi_clk_unregister(fixed_factor)
> -hisi_clk_unregister(mux)
> -hisi_clk_unregister(divider)
> -hisi_clk_unregister(gate)
> +hisi_clk_unregister_fn(fixed_rate)
> +hisi_clk_unregister_fn(fixed_factor)
> +hisi_clk_unregister_fn(mux)
> +hisi_clk_unregister_fn(divider)
> +hisi_clk_unregister_fn(gate)

What does this hunk have to do with the $subject patch? Can you break
this series down into smaller patches? This is probably clearing the way
for hisi_clk_unregister() being an actual function, but I don't know. It
can=20

> =20
>  #endif /* __HISI_CLK_H */
> diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
> index 803f6ba6d7a2..d9544f1f2625 100644
> --- a/drivers/clk/hisilicon/crg.h
> +++ b/drivers/clk/hisilicon/crg.h
> @@ -22,4 +22,9 @@ struct hisi_crg_dev {
>         const struct hisi_crg_funcs *funcs;
>  };
> =20
> +/* helper functions for platform driver */
> +
> +int hisi_crg_probe(struct platform_device *pdev);
> +int hisi_crg_remove(struct platform_device *pdev);
> +
>  #endif /* __HISI_CRG_H */
> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
> index 93cee17db8b1..3464e3b4d708 100644
> --- a/drivers/clk/hisilicon/reset.c
> +++ b/drivers/clk/hisilicon/reset.c
> @@ -5,12 +5,16 @@
>   * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
>   */
> =20
> +#include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
>  #include <linux/of_address.h>
> -#include <linux/platform_device.h>

Why?

> +#include <linux/of_device.h>

Why?

>  #include <linux/reset-controller.h>
> -#include <linux/slab.h>

Why?

>  #include <linux/spinlock.h>
> +
> +#include "clk.h"
> +#include "crg.h"
>  #include "reset.h"
> =20
>  #define        HISI_RESET_BIT_MASK     0x1f
