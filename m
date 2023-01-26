Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACB67C2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjAZCeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZCeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:34:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316F611EE;
        Wed, 25 Jan 2023 18:33:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 285E9B819AE;
        Thu, 26 Jan 2023 02:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA85CC433EF;
        Thu, 26 Jan 2023 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674700436;
        bh=Il7LG4ejHekxUtc6VH+odoRiPLXcTpXSKfw7eUQYsFw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=phJuHk0FkgflVcJdesQNPhed6IEfKsW2IsoMBqDB/ugW0wjz9B0CGoW90lUS9wgC8
         Lblrw2Ws7KvDVDDWANZxW9FmEhpQmufYjraG5d32iWR/Or18FbCJdmR6OBO1qaSEHv
         GxTxEHi3oNQUNwGiX/UxGWEid0tgsP3y5Bq8L3NNua1frOydmG6DVSK+Xb/9kKuxfC
         /gNd24j7nE/TrMH9L/QXgykVEU63tsg1lPzigf2MasjQQSeG+cR9j/gsZEPaSQt7Td
         VTBjoYk5yLJ3fivRTZeO3C1GjkH9TZca5NAhMKvWTS5VuTZz2XPdlI+/0tlKtGrUmk
         9D2J0NIl5wnxQ==
Message-ID: <5bb5263d26b157548d7ba39f80989c69.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230120024445.244345-4-xingyu.wu@starfivetech.com>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com> <20230120024445.244345-4-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v1 03/11] clk: starfive: Add StarFive JH7110 System-Top-Group clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 25 Jan 2023 18:33:54 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-01-19 18:44:37)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk=
/starfive/clk-starfive-jh7110-stg.c
> new file mode 100644
> index 000000000000..c2740f44e796
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 System-Top-Group Clock Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>

Is this include used? If not, please remove.

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +#include "clk-starfive-jh71x0.h"
> +
[...]
> +static int jh7110_stgcrg_probe(struct platform_device *pdev)
> +{
> +       struct jh71x0_clk_priv *priv;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, reg, JH7110_STGCLK_END),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev =3D &pdev->dev;
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       dev_set_drvdata(priv->dev, priv->base);
> +
> +       for (idx =3D 0; idx < JH7110_STGCLK_END; idx++) {
> +               u32 max =3D jh7110_stgclk_data[idx].max;
> +               struct clk_parent_data parents[4] =3D {};
> +               struct clk_init_data init =3D {
> +                       .name =3D jh7110_stgclk_data[idx].name,
> +                       .ops =3D starfive_jh71x0_clk_ops(max),
> +                       .parent_data =3D parents,
> +                       .num_parents =3D
> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CL=
K_MUX_SHIFT) + 1,
> +                       .flags =3D jh7110_stgclk_data[idx].flags,
> +               };
> +               struct jh71x0_clk *clk =3D &priv->reg[idx];
> +               unsigned int i;
> +
> +               for (i =3D 0; i < init.num_parents; i++) {
> +                       unsigned int pidx =3D jh7110_stgclk_data[idx].par=
ents[i];
> +
> +                       if (pidx < JH7110_STGCLK_END)
> +                               parents[i].hw =3D &priv->reg[pidx].hw;
> +                       else if (pidx =3D=3D JH7110_STGCLK_OSC)
> +                               parents[i].fw_name =3D "osc";
> +                       else if (pidx =3D=3D JH7110_STGCLK_HIFI4_CORE)
> +                               parents[i].fw_name =3D "hifi4_core";
> +                       else if (pidx =3D=3D JH7110_STGCLK_STG_AXIAHB)
> +                               parents[i].fw_name =3D "stg_axiahb";
> +                       else if (pidx =3D=3D JH7110_STGCLK_USB_125M)
> +                               parents[i].fw_name =3D "usb_125m";
> +                       else if (pidx =3D=3D JH7110_STGCLK_CPU_BUS)
> +                               parents[i].fw_name =3D "cpu_bus";
> +                       else if (pidx =3D=3D JH7110_STGCLK_HIFI4_AXI)
> +                               parents[i].fw_name =3D "hifi4_axi";
> +                       else if (pidx =3D=3D JH7110_STGCLK_NOCSTG_BUS)
> +                               parents[i].fw_name =3D "nocstg_bus";
> +                       else if (pidx =3D=3D JH7110_STGCLK_APB_BUS)
> +                               parents[i].fw_name =3D "apb_bus";

Can this be an array lookup instead of a pile of conditions?

	if (pidx < JH7110_STGCLK_END)
		...
	else
		parents[i].fw_name =3D fw_table[pidx - JH7110_STGCLK_END];

Or even better, don't use strings at all and just make the 'pidx' number
(possibly minus the end constant) be the 'clocks' property index that
you want.

> +               }
> +
> +               clk->hw.init =3D &init;
> +               clk->idx =3D idx;
> +               clk->max_div =3D max & JH71X0_CLK_DIV_MASK;
> +
> +               ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_get=
, priv);
> +       if (ret)
> +               return ret;
> +
> +       return jh7110_reset_controller_register(priv, "reset-stg", 2);

Is this also devm-ified?
