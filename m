Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8515F1249
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiI3TRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3TRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E39178A0F;
        Fri, 30 Sep 2022 12:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41BA062427;
        Fri, 30 Sep 2022 19:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9FEC433C1;
        Fri, 30 Sep 2022 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664565462;
        bh=eQ3OR6rdAgAUS1SAFVKPyGxUWmtoSIhePNLnOikpW9s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RdmDWAM5jyzrG0/5FKSkxD11bwTzMd1KwZClufYyZfe+PMqXatpV0+ZR7rcMrplr7
         e+oJ6aareVeRxHgUihqsX1UsYgyQqThvc6jr2mQ7eQl33bz/tKyoGbXJHPFm+V5lhz
         drUWKawadqeKm0GuZlfyUkuDvl13c9Z2epYXGGCVJI3GcC9lV36FJBe3JGeJOsVzLB
         xcf6uV8v9MDyXZitBpQsIXTHxNUJXPqPJfDwNh06LFPajEC8EtZMxUtVhFPhDR9u1W
         rh6Nx92/olJ+2UfgOx1guhW8vJB42dquHBvgYFucbBijNtgxMzUNSfTivZGxT7a8Ua
         GKQVzYN7q9q+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220603190509.45986-2-romain.perier@gmail.com>
References: <20220603190509.45986-1-romain.perier@gmail.com> <20220603190509.45986-2-romain.perier@gmail.com>
Subject: Re: [PATCH RESEND v5 1/1] clk: mstar: msc313 cpupll clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 30 Sep 2022 12:17:40 -0700
User-Agent: alot/0.10
Message-Id: <20220930191742.9A9FEC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Romain Perier (2022-06-03 12:05:09)
> From: Daniel Palmer <daniel@0x0f.com>
>=20
> Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> in MStar SoCs.
>=20
> Currently there is no documentation for this block so it's possible
> this driver isn't entirely correct.
>=20
> Only tested on the version of this IP in the MStar/SigmaStar
> ARMv7 SoCs.
>=20
> Co-authored-by: Willy Tarreau <w@1wt.eu>

This is not a standard tag, maybe Co-developed-by is what you want? A
Signed-off-by tag should be here from Willy Tarreau then.

> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Your Signed-off-by needs to be here. I can't apply this otherwise.

> diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
> index de37e1bce2d2..146eeb637318 100644
> --- a/drivers/clk/mstar/Kconfig
> +++ b/drivers/clk/mstar/Kconfig
> @@ -1,4 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config MSTAR_MSC313_CPUPLL
> +       bool "MStar CPUPLL driver"
> +       depends on ARCH_MSTARV7 || COMPILE_TEST
> +       default ARCH_MSTARV7
> +       help
> +         Support for the CPU PLL present on MStar/Sigmastar SoCs.
> +
>  config MSTAR_MSC313_MPLL
>         bool "MStar MPLL driver"
>         depends on ARCH_MSTARV7 || COMPILE_TEST
> @@ -7,3 +14,4 @@ config MSTAR_MSC313_MPLL
>         help
>           Support for the MPLL PLL and dividers block present on
>           MStar/Sigmastar SoCs.
> +
> diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
> index f8dcd25ede1d..21296a04e65a 100644
> --- a/drivers/clk/mstar/Makefile
> +++ b/drivers/clk/mstar/Makefile
> @@ -2,5 +2,5 @@
>  #
>  # Makefile for mstar specific clk
>  #
> -
> +obj-$(CONFIG_MSTAR_MSC313_CPUPLL) +=3D clk-msc313-cpupll.o
>  obj-$(CONFIG_MSTAR_MSC313_MPLL) +=3D clk-msc313-mpll.o
> diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/cl=
k-msc313-cpupll.c
> new file mode 100644
> index 000000000000..c57b509e8c20
> --- /dev/null
> +++ b/drivers/clk/mstar/clk-msc313-cpupll.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>

Ought to include kernel.h and device.h too.

> +
[...]
> +
> +static const struct clk_ops msc313_cpupll_ops =3D {
> +       .recalc_rate    =3D msc313_cpupll_recalc_rate,
> +       .round_rate     =3D msc313_cpupll_round_rate,
> +       .set_rate       =3D msc313_cpupll_set_rate,
> +};
> +
> +static const struct of_device_id msc313_cpupll_of_match[] =3D {
> +       { .compatible =3D "mstar,msc313-cpupll" },
> +       {}
> +};
> +
> +static const struct clk_parent_data cpupll_parent =3D {

Why not put this on the stack? It doesn't have to live forever.

> +       .index  =3D 0,
> +};
> +
> +static int msc313_cpupll_probe(struct platform_device *pdev)
> +{
> +       struct clk_init_data clk_init =3D {};
> +       struct device *dev =3D &pdev->dev;
> +       struct msc313_cpupll *cpupll;
> +       int ret;
> +
> +       cpupll =3D devm_kzalloc(&pdev->dev, sizeof(*cpupll), GFP_KERNEL);
> +       if (!cpupll)
> +               return -ENOMEM;
> +
> +       cpupll->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(cpupll->base))
> +               return PTR_ERR(cpupll->base);
> +
> +       /* LPF might not contain the current frequency so fix that up */
> +       msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L,
> +                                 msc313_cpupll_reg_read32(cpupll, REG_CU=
RRENT));
> +
> +       clk_init.name =3D dev_name(dev);
> +       clk_init.ops =3D &msc313_cpupll_ops;
> +       clk_init.parent_data =3D &cpupll_parent;
> +       clk_init.num_parents =3D 1;
> +       cpupll->clk_hw.init =3D &clk_init;
> +
> +       ret =3D devm_clk_hw_register(dev, &cpupll->clk_hw);
> +       if (ret)
> +               return ret;
> +
> +       return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_simple=
_get, &cpupll->clk_hw);

Use devm to add the provider too.
