Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE845F1530
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiI3Vse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiI3Vs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:48:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6B16F9D6;
        Fri, 30 Sep 2022 14:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E377B82A41;
        Fri, 30 Sep 2022 21:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14ACC433D6;
        Fri, 30 Sep 2022 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574504;
        bh=izJxWplvzIJrIzy3GFzhPnsHaw/msyKEzMvL2GdfOdk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ulfKvln9/9OiPB0Yt7T+U2aiGnYSLYbQGreKUjNApStfnfj0mljm4baPsKq4Kjf2P
         c8A9dAyvDuw/obUE4EhrVGxNosN0Kp30uST7roL0ZPVma1b7Hl4k3YiXJw3U6iu6mk
         gWdXJhUwM6l+Yaz+2jmk7UsYaXj7VEtXdsJGSZUuRmoiKwWBY2RR9vOimsSZ39kcyl
         KPlp5d4y1Us24706Fpojqn//wRfrVlq+lMPbhManGWzl0fZP0dZiRkT4JE4+I8g2y3
         oWrC8avhCZAvXK/tfaVivy4Ddup6vU3AKqKmEbsOoPK6DsLAbpyDZlydpYHMaTB5Ox
         I2elxjYH6qiog==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220929175602.19946-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175602.19946-1-hal.feng@linux.starfivetech.com>
Subject: Re: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Fri, 30 Sep 2022 14:48:21 -0700
User-Agent: alot/0.10
Message-Id: <20220930214824.A14ACC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2022-09-29 10:56:02)
> Clock registers address region is shared with reset controller
> on the new StarFive JH7110 SoC. Change to use regmap framework
> to allow base address sharing and preparation for JH7110 clock
> support.

Do the reset and clk parts share actual registers, where we would need
to lock between rmw? Or is regmap just nice to have because it wraps up
the register APIs with some extra features?

>=20
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> ---
[...]
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/sta=
rfive/clk-starfive-jh7100.c
> index 014e36f17595..410aa6e06842 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> =20
> @@ -295,11 +296,13 @@ static int __init clk_starfive_jh7100_probe(struct =
platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
> =20
> -       spin_lock_init(&priv->rmw_lock);
>         priv->dev =3D &pdev->dev;
> -       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(priv->base))
> -               return PTR_ERR(priv->base);
> +       priv->regmap =3D device_node_to_regmap(priv->dev->of_node);

This is sad. Why do we need to make a syscon? Can we instead use the
auxiliary bus to make a reset device that either gets a regmap made here
in this driver or uses a void __iomem * mapped with ioremap
(priv->base)?

> +       if (IS_ERR(priv->regmap)) {
> +               dev_err(priv->dev, "failed to get regmap (error %ld)\n",
> +                       PTR_ERR(priv->regmap));
> +               return PTR_ERR(priv->regmap);
