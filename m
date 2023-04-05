Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5476D868B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjDETJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDETJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B184ED2;
        Wed,  5 Apr 2023 12:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5A863D39;
        Wed,  5 Apr 2023 19:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A187BC433D2;
        Wed,  5 Apr 2023 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680721751;
        bh=veS5PP6wsJDCVk4tZWNSoKTVnJNfOSHkHbVmPeuAOv8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nG7fYdveHgxqZSjemxhtaTnjPeNNHfVk9qBCzEwzlcHGko/Ea2rdTmFyPS2DBbUVD
         ewZOdz6eKJE4PFkFDZ+rycKtaEZBAi3Nh3b13JJhS7DfLel5ToHTZj2w3kYm8eZhYN
         JeoHY0Qgk0gNcL8mGIshljfIjGrEe9EfUtoEH8W6XzusQrblg9ktBwViV8C7fyX4af
         kv9/uiD6D9Svq8e7ghnymJ2Zq9jhBifMsh5dPaiZSsTCH0/avsGKh0sZqqWM7ke3Sn
         ufBbVKu53840bbRXqOxgsy69s/pXHBEjgO9xjj/oQZKw4LkI7SQ6e2E50ZLhJjUOFj
         fHUH++Idn00wQ==
Message-ID: <099514a84f97c694d2382812b03aad1e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1hOHJWQSmGoVDz5bSjwdhNyQmaZVOEE8_dX6S4HCFQ2Jg@mail.gmail.com>
References: <20230309194402.119562-1-tmaimon77@gmail.com> <20230309194402.119562-2-tmaimon77@gmail.com> <495fcc93ab28ff8949569ededee954c1.sboyd@kernel.org> <CAP6Zq1hOHJWQSmGoVDz5bSjwdhNyQmaZVOEE8_dX6S4HCFQ2Jg@mail.gmail.com>
Subject: Re: [PATCH v15 1/1] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au,
        mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 05 Apr 2023 12:09:09 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2023-03-31 11:07:19)
> On Mon, 20 Mar 2023 at 21:50, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2023-03-09 11:44:02)
> > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > new file mode 100644
> > > index 000000000000..67058f121251
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-npcm8xx.c
> > > +       { NPCM8XX_CLK_S_PLL0, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPC=
M8XX_PLLCON0, 0 },
> > > +       { NPCM8XX_CLK_S_PLL1, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPC=
M8XX_PLLCON1, 0 },
> > > +       { NPCM8XX_CLK_S_PLL2, { .name =3D NPCM8XX_CLK_S_REFCLK }, NPC=
M8XX_PLLCON2, 0 },
> > > +       { NPCM8XX_CLK_S_PLL_GFX, { .name =3D NPCM8XX_CLK_S_REFCLK }, =
NPCM8XX_PLLCONG, 0 },
> > > +};
> > > +
> > > +static const u32 cpuck_mux_table[] =3D { 0, 1, 2, 7 };
> > > +static const struct clk_parent_data cpuck_mux_parents[] =3D {
> > > +       { .fw_name =3D NPCM8XX_CLK_S_PLL0, .name =3D NPCM8XX_CLK_S_PL=
L0 },
> >
> > You should only have .fw_name or .index when introducing new drivers.
> > The .name field is for existing drivers that want to migrate to
> > clk_parent_data.
> I thought using .name was done when the clock defines in the DT, like
> the ref clock.
> If the other clocks are not defined both .fw_name and .name the clocks
> are not registered properly.

Are you saying that having .name fixes it?

> >
> > > +       { .fw_name =3D NPCM8XX_CLK_S_PLL1, .name =3D NPCM8XX_CLK_S_PL=
L1 },
> > > +       { .name =3D NPCM8XX_CLK_S_REFCLK },
> >
> > Note, this line says to use '.index =3D 0', and .name will be ignored.
> > Maybe just use the index for everything? That makes it simpler and
> > potentially faster because we don't have to do string comparisons
> > anywhere.
> Should the clk_parent_data mux use only .index? if yes how should the
> clock tree have a connection between the parent's clock and the mux
> for example:
> for example, how should the driver connect between
> NPCM8XX_CLK_S_PLL1_DIV2 and the index number in the clk_parent_data?

It's not required, but it makes things simpler to only use .index or
direct clk_hw pointers (.hw). I'm working on a clk documentation
overhaul series right now, about 4 years later than I should have done
it. It will cover this.

The .index field corresponds to the cell index in your devicetree
'clocks' property of the clk provider (the node with #clock-cells
property). If the clk is internal, just use a .hw member and point to it
directly. Don't consume your own clks in DT. If NPCM8XX_CLK_S_PLL1_DIV2
is a clk provided/registered by this device then it should be pointed to
directly with the clk_hw pointer. If NPCM8XX_CLK_S_PLL1_DIV2 is an
external clk that is consumed via the 'clocks' property in DT, then it
should be specified as a parent via the .index member.

> > > +
> > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > +{
> > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       void __iomem *clk_base;
> > > +       struct resource *res;
> > > +       struct clk_hw *hw;
> > > +       unsigned int i;
> > > +       int err;
> > > +
> > > +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_cl=
k_data, hws,
> > > +                                                        NPCM8XX_NUM_=
CLOCKS),
> > > +                                       GFP_KERNEL);
> > > +       if (!npcm8xx_clk_data)
> > > +               return -ENOMEM;
> > > +
> > > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       clk_base =3D devm_ioremap(dev, res->start, resource_size(res)=
);
> >
> > Can you use devm_platform_ioremap_resource() instead?
> We should use devm_ioremap since the clock register is used for the
> reset driver as well.

Are the clk and reset drivers sharing the register range? If so, please
use auxiliary bus to register the reset driver, and map the register
region once in the driver that registers the auxiliary device. Pass the
iomem pointer to the auxiliary device.
