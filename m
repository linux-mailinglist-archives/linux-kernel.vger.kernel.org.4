Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC172D702
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjFMBfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFMBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE6F1711;
        Mon, 12 Jun 2023 18:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF7862F37;
        Tue, 13 Jun 2023 01:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FA1C433D2;
        Tue, 13 Jun 2023 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686620144;
        bh=EyKtx/gDko9LOVZRYx0rrPp+HzWImhwqZmdgxYsGfHk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IEhIJZftAkwCaFLqvA0d1c++2oY5umfjfor9LtyRx62u1UWPdZZBm5XGLUHcjPPy1
         GyG9oEw0h5y8N3HQ2UEA7sn5v4esxtoY+91sp0Iacil8GHN3ix6n4ngDlQlEf6kU/4
         HRmEj3r6PqD2jzc3qbC8AqX0ncT7xhXTlDH0lCK0r8c2vrjkJhDTQBsS0W7Awh3vJc
         RwyC3y+QrdshoIpWu38ckKmwmicaDm+ORMSH6fl3Hw1VD7Dek4mEkCzJewLOoZ0uk9
         FbULImDyIUgeDrex8Imf5Bbd5hh0KKZRD+RdWrfadP4QFPYxmvYbhSm05jlh86udiK
         3ZbRyN3zOaFQw==
Message-ID: <91c3373b5b00afc1910b704a16c1ac89.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230515054402.27633-3-frank.li@vivo.com>
References: <20230515054402.27633-1-frank.li@vivo.com> <20230515054402.27633-3-frank.li@vivo.com>
Subject: Re: [PATCH 2/3] clk: thead: add support for the T-HEAD TH1520 CCU
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        Yangtao Li <frank.li@vivo.com>, mturquette@baylibre.com
Date:   Mon, 12 Jun 2023 18:35:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2023-05-14 22:44:00)
> diff --git a/drivers/clk/clk-th1520.c b/drivers/clk/clk-th1520.c
> new file mode 100644
> index 000000000000..5dfa9e5207e2
> --- /dev/null
> +++ b/drivers/clk/clk-th1520.c
> @@ -0,0 +1,999 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
> + * Authors: Yangtao Li <frank.li@vivo.com>
> + */
> +
[....]
> +
> +
> +static CLK_FIXED_FACTOR_HW(pll_gmac_100m_clk, "pll-gmac-100m",
> +                          &pll_gmac_clk.common.hw,
> +                          10, 1, 0);
> +
> +static const char * const uart_parents[] =3D { "pll-gmac-100m", "osc24m"=
 };
> +struct ccu_mux uart_clk =3D {
> +       .mux    =3D TH_CCU_ARG(0, 1),
> +       .common =3D {
> +               .reg            =3D 0x210,
> +               .hw.init        =3D CLK_HW_INIT_PARENTS("uart",

Don't use strings for clk tree topology. Instead use clk_parent_data or
clk_hw pointers directly.

> +                                             uart_parents,
> +                                             &ccu_mux_ops,
> +                                             0),
> +       }
> +};
> +};
> +
> +static const struct regmap_config config =3D {

Namespace this, th1520_clk_regmap_config[]

> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .fast_io =3D true,
> +};
> +
> +static int th1520_clock_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct regmap *map;
> +       void __iomem *regs;
> +       int ret, i;
> +
> +       regs =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       map =3D devm_regmap_init_mmio(dev, regs, &config);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(th1520_clks); i++)
> +               th1520_clks[i]->map =3D map;
> +
> +       for (i =3D 0; i < th1520_hw_clks.num; i++) {
> +               ret =3D devm_clk_hw_register(dev, th1520_hw_clks.hws[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                       &th1520_hw_clks);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id clk_match_table[] =3D {

Namespace this, th1520_clk_match_table[]

> +       {
> +               .compatible =3D "thead,th1520-ccu",
> +       },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, clk_match_table);
> +
