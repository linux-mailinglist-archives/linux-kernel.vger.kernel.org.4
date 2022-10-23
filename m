Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19B160924E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJWKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiJWKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF15F7E1;
        Sun, 23 Oct 2022 03:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5621C60B78;
        Sun, 23 Oct 2022 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A2C433C1;
        Sun, 23 Oct 2022 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666520728;
        bh=xHTDzXr6yMemliNn/X5wJr/+HKi1d/u3kKmHEczRJ6c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=PNETu/wg6gI+HfefOSjm98ZXp1gaCUwQ282BKWbhbPtErarhdWqGOAMOR3aexaBG0
         e2Mv5TIbvMcQ2vKcU5kJd4VrYC7MPfTkifXDUIEB6JGQfzmL9SP4ECvnCDlU0efGUc
         1blQfkU7chk8nuMXdWPwD++UHOz5C/tiqcBHRIwlWBXfvG/bGL8ChARWeeEqNsvpl+
         3nl3RX/X0IGQP4WMFo7cd5l2Yu3PMBNwehajgllCQF35U5UeJceW8u80wezQiRXqOw
         RgqYck/Of9/WHyvNe/fdVlNfWIgDt2h/SVYUPCtjRaWctBEkyPgScNj3/1B/O6Iimy
         7tk62+vROPffA==
Date:   Sun, 23 Oct 2022 11:25:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_15/30=5D_clk=3A_starfive=3A_?= =?US-ASCII?Q?Use_regmap_APIs_to_operate_registers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <20220929175602.19946-1-hal.feng@linux.starfivetech.com> <20220930214824.A14ACC433D6@smtp.kernel.org> <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com> <20221012230525.C6E58C433D7@smtp.kernel.org> <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
Message-ID: <4AF0F174-CB35-447A-9F22-7D300B225011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 October 2022 05:11:41 IST, Hal Feng <hal=2Efeng@linux=2Estarfivetech=
=2Ecom> wrote:
>On Wed, 12 Oct 2022 16:05:23 -0700, Stephen Boyd wrote:
>> Quoting Emil Renner Berthing (2022-10-05 06:14:44)
>> > > > @@ -295,11 +296,13 @@ static int __init clk_starfive_jh7100_probe=
(struct platform_device *pdev)
>> > > >         if (!priv)
>> > > >                 return -ENOMEM;
>> > > >
>> > > > -       spin_lock_init(&priv->rmw_lock);
>> > > >         priv->dev =3D &pdev->dev;
>> > > > -       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>> > > > -       if (IS_ERR(priv->base))
>> > > > -               return PTR_ERR(priv->base);
>> > > > +       priv->regmap =3D device_node_to_regmap(priv->dev->of_node=
);
>> > >
>> > > This is sad=2E Why do we need to make a syscon? Can we instead use =
the
>> > > auxiliary bus to make a reset device that either gets a regmap made=
 here
>> > > in this driver or uses a void __iomem * mapped with ioremap
>> > > (priv->base)?
>> >=20
>> > In my original code the clock driver just registers the resets too
>> > similar to other combined clock and reset drivers=2E I wonder what yo=
u
>> > think about that approach:
>> > https://github=2Ecom/esmil/linux/commit/36f15e1b827b02d7f493dc5fce310=
60b21976e68
>> > and
>> > https://github=2Ecom/esmil/linux/commit/4ccafadb72968480aa3dd28c227fc=
ccae411c13b#diff-ffec81f902f810cb210012c25e8d88217ea5b4021419a4206d1fd4dd19=
edfce8R471
>>=20
>> I think we should use auxiliary bus and split the driver logically into
>> a reset driver in drivers/reset and a clk driver in drivers/clk=2E That
>> way the appropriate maintainers can review the code=2E There is only on=
e
>> platform device with a single reg property and node in DT, but there ar=
e
>> two drivers=2E=20
>
>Yes, I agree that the reset driver and the clock driver should be split=
=2E
>However, I think using auxiliary bus is a little bit complicated in this
>case, because the reset is not a part of functionality of the clock in=20
>JH7110=2E They just share a common register base address=2E I think it is=
=20
>better to use ioremap for the same address, and the dt will be like
>
>syscrg_clk: clock-controller@13020000 {
>	compatible =3D "starfive,jh7110-clkgen-sys";
>	reg =3D <0x0 0x13020000 0x0 0x10000>;
>	=2E=2E=2E
>};
>syscrg_rst: reset-controller@13020000 {
>	compatible =3D "starfive,jh7110-reset-sys";
>	reg =3D <0x0 0x13020000 0x0 0x10000>;
>	=2E=2E=2E
>};
>
>What do you think of this approach? I would appreciate your suggestions=
=2E

No, the dtb checks will all start warning for this=2E
Aux bus is not that difficult, you can likely copy much of what I did rece=
ntly in clk-mpfs=2Ec
>
>Best regards,
>Hal
