Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C95FCEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJLXFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJLXF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:05:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D957256;
        Wed, 12 Oct 2022 16:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3887AB81BE1;
        Wed, 12 Oct 2022 23:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E58C433D7;
        Wed, 12 Oct 2022 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665615925;
        bh=RKsj6eaHS0Dlw6VvnuAF/Tpwhbi5fwGsQ2fzFSv0svI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QZHwE+fLiMLo4PpvLTomPm8Ro5c5NMVrF8ZoCdlQQd5wWk6Ohfth8VQBz7+rF9Jdv
         +E0mhSK3p271mheOinlAZmc6ucgmdHYDQAbHf8akVVVoS0oqDY9/OVyh9190/tUuVo
         jZe9OUvEFpXGufIEn8ntGJwp0DDPW65/M9r89CEWWCuhdHtE7ouGygKMkmBRIOakCi
         UNwiEE7F1eZwVy4xoUCtog9qSYlnpapphrMio5xezduhDkuSk4l7n9MaAYjJBTM3Ha
         dVtvTTjgck6LkLhjF9ssfqgRxnynfvkYN6vlsO5ICfgeA/ZrZCk6qQhWvZk7yh0ek6
         1sQVgAiWPGmkA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175602.19946-1-hal.feng@linux.starfivetech.com> <20220930214824.A14ACC433D6@smtp.kernel.org> <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com>
Subject: Re: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 12 Oct 2022 16:05:23 -0700
User-Agent: alot/0.10
Message-Id: <20221012230525.C6E58C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-10-05 06:14:44)
> > > @@ -295,11 +296,13 @@ static int __init clk_starfive_jh7100_probe(str=
uct platform_device *pdev)
> > >         if (!priv)
> > >                 return -ENOMEM;
> > >
> > > -       spin_lock_init(&priv->rmw_lock);
> > >         priv->dev =3D &pdev->dev;
> > > -       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > -       if (IS_ERR(priv->base))
> > > -               return PTR_ERR(priv->base);
> > > +       priv->regmap =3D device_node_to_regmap(priv->dev->of_node);
> >
> > This is sad. Why do we need to make a syscon? Can we instead use the
> > auxiliary bus to make a reset device that either gets a regmap made here
> > in this driver or uses a void __iomem * mapped with ioremap
> > (priv->base)?
>=20
> In my original code the clock driver just registers the resets too
> similar to other combined clock and reset drivers. I wonder what you
> think about that approach:
> https://github.com/esmil/linux/commit/36f15e1b827b02d7f493dc5fce31060b219=
76e68
> and
> https://github.com/esmil/linux/commit/4ccafadb72968480aa3dd28c227fcccae41=
1c13b#diff-ffec81f902f810cb210012c25e8d88217ea5b4021419a4206d1fd4dd19edfce8=
R471

I think we should use auxiliary bus and split the driver logically into
a reset driver in drivers/reset and a clk driver in drivers/clk. That
way the appropriate maintainers can review the code. There is only one
platform device with a single reg property and node in DT, but there are
two drivers.
