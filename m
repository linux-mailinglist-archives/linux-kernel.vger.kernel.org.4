Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014560ED6D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiJ0B0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiJ0B0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:26:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7872FD2;
        Wed, 26 Oct 2022 18:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29DDCB82487;
        Thu, 27 Oct 2022 01:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6769C433C1;
        Thu, 27 Oct 2022 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666833965;
        bh=hYASDY/RBPj7jGgnN4KncjSFTtzdy9NTDXP3AodJm+4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iJnBJo5BoHhr4k0kZgdsGd03Rb6LjjifodTow4Ad99tp1iDvTi0lPNFavQN8svbIV
         1xe8u+gUxpSkbNvVQ+Q6OyZGHH/0WLMnAHJQ2HcVTyq+4GR3huUcpkUZoeh8k68GSg
         7OCpRGxRk3ECJQ0YphQu2epB/pswj2RLrO9+uNNKwHglmXKp9ZmB7seyKd8ZX0z7C5
         PsyHMIacUFrHh8MJJUhZb2mMMLjvi7HSz5zo4tbV1hdYYeTuuWHOkL8QGOSSFfrAQm
         kc9TlU9xam3S2NTxl64v4XtZtBXIwEIk52XIoMZQDoI6pNOCbTvLSl3LFdSJ35kHwz
         1olplLQyy/lqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175602.19946-1-hal.feng@linux.starfivetech.com> <20220930214824.A14ACC433D6@smtp.kernel.org> <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com> <20221012230525.C6E58C433D7@smtp.kernel.org> <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
Subject: Re: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Date:   Wed, 26 Oct 2022 18:26:03 -0700
User-Agent: alot/0.10
Message-Id: <20221027012605.B6769C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2022-10-22 21:11:41)
> On Wed, 12 Oct 2022 16:05:23 -0700, Stephen Boyd wrote:
> > I think we should use auxiliary bus and split the driver logically into
> > a reset driver in drivers/reset and a clk driver in drivers/clk. That
> > way the appropriate maintainers can review the code. There is only one
> > platform device with a single reg property and node in DT, but there are
> > two drivers.=20
>=20
> Yes, I agree that the reset driver and the clock driver should be split.
> However, I think using auxiliary bus is a little bit complicated in this
> case, because the reset is not a part of functionality of the clock in=20
> JH7110. They just share a common register base address.

That is why auxiliary bus exists.

> I think it is=20
> better to use ioremap for the same address, and the dt will be like
>=20
> syscrg_clk: clock-controller@13020000 {
>         compatible =3D "starfive,jh7110-clkgen-sys";
>         reg =3D <0x0 0x13020000 0x0 0x10000>;
>         ...
> };
> syscrg_rst: reset-controller@13020000 {
>         compatible =3D "starfive,jh7110-reset-sys";
>         reg =3D <0x0 0x13020000 0x0 0x10000>;
>         ...
> };
>=20
> What do you think of this approach? I would appreciate your suggestions.
>=20

We shouldn't have two different nodes with the same reg property. Please
ioremap in whatever driver probes and creates the auxiliary device(s)
and then pass the void __iomem * to it.
