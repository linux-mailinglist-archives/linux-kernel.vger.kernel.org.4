Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA84A72ED42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbjFMUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbjFMUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B5E53;
        Tue, 13 Jun 2023 13:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1374F617E3;
        Tue, 13 Jun 2023 20:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64003C433C0;
        Tue, 13 Jun 2023 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689091;
        bh=197GhMaGHAg2n1nbm70axBPdT5BZD1C6NILjDiLPZjI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=U9x36Wd+JZDMSDouThk/NP+nQrM/qtILqn89gaQyKEuQ4epArY8F0zmiUQpOXW/rj
         s2dCMJ0O9K4UyxqjImAK/N/9wTWPYU/FaweNxg+pYTaC8mHrrYm5EIPhx75n3z0iO2
         IOBMCybzq99OtMPjVZE93No0zLhdNUYbMNnuYEKMMfCJlk0i+BSVzgiLoSoM+fvXl+
         3E9ArlAa1zWnTa84kunzuaMR+L9+2rkoo6hOgzThbW7HOvbLh6lzDRAOy5jS1XF+ep
         Zgg1L75/2Hy3Fn9ZD8t8ivwGz90WsyADUmLaxNWKHDvtR6ziefAZmCxzXrSRFjYipL
         1K55p38MJiS4g==
Message-ID: <d47d0ceb834ca56a4733e226e89a4f2b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e8ee511863ce2aa9b09b7f0c4fa9b6919603c8f0.camel@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230424123522.18302-13-nikita.shubin@maquefel.me> <d15b580f84ac89274cde3785168b0e26.sboyd@kernel.org> <e8ee511863ce2aa9b09b7f0c4fa9b6919603c8f0.camel@maquefel.me>
Subject: Re: [PATCH 12/43] clk: ep93xx: add DT support for Cirrus EP93xx
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Date:   Tue, 13 Jun 2023 13:44:49 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Shubin (2023-05-15 06:31:41)
> Hello Stephen!
>=20
> Thank you for your review.
>=20
> Acknowledged all remarks, however, i didn't fully understood some of
> the requirements:

When the reply is taken out of context it is harder for me to recall
what we're talking about.

>=20
> > And maybe this can be registered from wherever the regmap is created?
>=20
> Are you suggesting that all clock from init, i.e. "pll1", "pll2",
> "hclk", "fclk", "pclk"
>=20
> Should be moved to=C2=A0SoC driver instead:
>=20
> https://lore.kernel.org/all/20230424123522.18302-3-nikita.shubin@maquefel=
.me/
>=20
> ?

Sure? That looks like a possibility.

>=20
> > Does some interrupt or timer driver use dma? Why are these registered
> > early?
>=20
> ep93xx_dma uses subsys_initcall(ep93xx_dma_module_init)
>=20
> https://elixir.bootlin.com/linux/v6.3.2/source/drivers/dma/ep93xx_dma.c#L=
1430
>=20
> I can move clk to using arch_initcall and move all stuff to probe, i
> think...

Sounds like the answer to my question is no. In which case moving to
arch_initcall() or probe will work. Please try.

>=20
> > Why is this in arm/ directory? Isn't it a clock controller?
>=20
> ep93xx clocks, reboot, pinctrl use syscon regmap and some special
> functions from SoC, i.e. "Syscon Software Lock Register" - so we are
> able to write to some registers only after writing some magik value
> there.
>=20
> So all above use regmap from SoC.

There can be an API in a header located in include/soc/ that implements
the magik value unlock sequence?

>=20
> Should make a separate clock controller like one i did for pinctrl ?
> Then it should look like:
>=20
> syscon@80930000 {
>   compatible =3D "cirrus,ep9301-syscon",
>                "syscon", "simple-mfd";
>   reg =3D <0x80930000 0x1000>;
>   #reset-cells =3D <1>;
>      =20
>   clocks {
>     xtali: oscillator {
>       compatible =3D "fixed-clock";
>       #clock-cells =3D <0>;
>       clock-frequency =3D <14745600>;
>     };
>   };
>      =20
>   clock-controller {
>     #clock-cells =3D <1>;
>     compatible =3D "cirrus,ep9301-clk";
>     clocks =3D <&xtali>;
>   };
> };
>=20
> Or even simply:
>=20
> clocks {
>   xtali: oscillator {
>     compatible =3D "fixed-clock";
>     #clock-cells =3D <0>;
>     clock-frequency =3D <14745600>;
>   };
> };
>      =20
> clock-controller {
>   #clock-cells =3D <1>;
>   compatible =3D "cirrus,ep9301-clk";
>   clocks =3D <&xtali>;
> };

The DT binding shouldn't be making sub-nodes to match driver structure
of the kernel. Instead, there should be a node for a register range that
represents a device on the bus. That device may be multipurpose, in
which case it can probe as a platform driver and that platform driver
can create some number of auxiliary bus devices for the sub
functionality of the device. We shouldn't be prescribing Linux software
constructs onto the DT binding.
