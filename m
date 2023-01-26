Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0567C2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjAZClL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:41:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D031845BD6;
        Wed, 25 Jan 2023 18:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD2561588;
        Thu, 26 Jan 2023 02:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94ADC4339B;
        Thu, 26 Jan 2023 02:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674700866;
        bh=XPbqSTeptf7tgqTXA+MY73A0B0SBbzewXCpchE//tUo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GCraw7pWDawA5eEM1iWFjD4jw7ezL+NpFe5UCksCsqUZRc+aLjC2G9SdExvNu0XVt
         x36AsztqNgxjAA5NXWB/P5nDqjpF52osXKlYvgQbLTXK44gYtOQkXNEhHphXQDuwk3
         eHEWSiJHjxeMW+cPdqEBfokd+6b39z+Zi21Uyr7j0YPfoqBtVbV3Cg5FfHcKJDwDwR
         dfPDhZBovLbHJRY56bh0x/3nXjmOaSI+574uXNU/JMLjaRSdXEgImfcspIXDWUhYAL
         ylYHycjHWZmbLsKcJaxRzCseXh7Xi61kh3nXwWVei5lQB5M6cN9X3bOuOuLBPK6ZuN
         Igaimmy0Xnyww==
Message-ID: <f9bf509f45550996bda8a79ee145f4b1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1iPmy-fvqqAwBuoskR18v0dPVwYm0tEcE5h1g8fOiOQvg@mail.gmail.com>
References: <20221211204324.169991-1-tmaimon77@gmail.com> <20221211204324.169991-2-tmaimon77@gmail.com> <20221216184402.8A426C433D2@smtp.kernel.org> <CAP6Zq1iPmy-fvqqAwBuoskR18v0dPVwYm0tEcE5h1g8fOiOQvg@mail.gmail.com>
Subject: Re: [PATCH v14 1/1] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au,
        mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 25 Jan 2023 18:41:04 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2023-01-17 09:35:33)
> Hi Stephen,
>=20
> Very sorry for the late reply.
>=20
> On Fri, 16 Dec 2022 at 20:44, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2022-12-11 12:43:24)
> > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > new file mode 100644
> > > index 000000000000..08ee7bea6f3a
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-npcm8xx.c
> > > @@ -0,0 +1,650 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > [...]
> > > +#define NPCM8XX_CLK_S_RCP        "rcp"
> > > +
> > > +static const u32 pll_mux_table[] =3D { 0, 1, 2, 3 };
> > > +static const struct clk_parent_data pll_mux_parents[] =3D {
> > > +       { .fw_name =3D NPCM8XX_CLK_S_PLL0, .name =3D NPCM8XX_CLK_S_PL=
L0 },
> >
> > As this is a new driver either you should only have .fw_name here. The
> > .name field is a backup to migrate code over to a new binding. When
> > .fw_name is used there should be an associated DT binding update. I
> What do you mean by associated DT binding? does the.fw_name, for
> example, NPCM8XX_CLK_S_PLL0 need to represent in the device tree?

Yes it should match a string in the "clock-names" property for this clk
provider's device node.

> > doubt the usage of .fw_name is correct though, because aren't these clks
> > internal to the controller? The .fw_name field is about describing does=
 the
> yes the PLL clocks are internal.

Ok.

> > parents that are an input to the clk controller node in DT (because the
> > controller is a consumer of these clks that are external to the device).
> >
> > So can you use the .hw field for these internal clks? Check out
> > CLK_HW_INIT_HWS() macro and friends for a possible way to initialize
> > this.
> but still, I have used devm_clk_hw_register_mux_parent_data_table
> function to register the clock mux,
> should I use  devm_clk_hw_register_mux_parent_hws function instead?

Probably, yes.

> Does this modification need to be done in all the mux parent struct?
> could you point me to some example in the Linux kernel how do you
> think that I should represent the mux clock in the NPCM8XX clock
> driver?

I don't know. If the clk is external to the provider, then it should be
in .fw_name or .index and be provided through DT. Otherwise, if the clk
is internal to the clk provider use direct pointers.

> >
> > > +       { .fw_name =3D NPCM8XX_CLK_S_PLL1, .name =3D NPCM8XX_CLK_S_PL=
L1 },
> > > +       { .fw_name =3D NPCM8XX_CLK_S_REFCLK, .name =3D NPCM8XX_CLK_S_=
REFCLK },
> >
> > Maybe this is external? If so, it would be great to have this in the
> > binding as a `clocks` property.
> O.K.
>=20

Is it external? If so, then fw_name would be correct. You can look at
the kernel-doc above clk_core_get(), but I really just need to spend a
few hours and write a proper kernel-doc for this stuff.
