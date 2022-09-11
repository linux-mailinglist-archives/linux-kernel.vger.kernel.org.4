Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A765B4FE7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIKQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:12:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2B2A97C;
        Sun, 11 Sep 2022 09:12:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r17so14932714ejy.9;
        Sun, 11 Sep 2022 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=hJ+e1XeZm7JvbKoyrv/rO2Ob1FAmtRjWjX/U6v/BW8c=;
        b=aqL5tyqT2dBJQXOD7BO+QiMrPRsJgTKqA81lToLsQtKvWPAYziAyTyUAngDSiPiILc
         UuPyWS6qZBHWEBmXYNM9/muD32S4IduugF6YyzLdLF/iBD5/GiLIYojslmsvFJUGEJg+
         oLWjpWABmCp4iuOJxQhpaTtwWm8QMrUca0B76ZFbH4xoHSK9LmjHrpdQ7OJSEliPay2c
         Qx01hMxjZ7gffAoNYhcWolaful59mZulD1Bn8qz6zTLtCxAd+wlcC8hXXKHOIIJeU+95
         zA03ETbktj33Y8yhcqqqCkc78StVNK5SgMLpdZHVDUKLowLqVEjqUzBCC0hV43LHZrzB
         wx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hJ+e1XeZm7JvbKoyrv/rO2Ob1FAmtRjWjX/U6v/BW8c=;
        b=3A+6rF8i8asjCQtRat9oWEj5EO35+6D3vsjgpDnjgunEFnegK+h/W5OnS6trKpBfbx
         9AyAynewY1oUmYFcqvWraLJNx6eHlhLlEI/IMwCHroa71sHTf5NNuCUbBJyAjx7LvFYk
         uQwfKQX/L8ZHexvUErOx0moPlEFAOzK0wGNOgKsEr/lc+8PDojr46azYeMxWTumMtgQE
         xHkm6hMnOJQmvzK1rJa5HFy67a/8xhvMGCDcez3uyDF7J7s5UIKbGpKZu+kPU4NAxpAT
         v9oVGwjFyZBQ5IYUPt/aKTxpWJNrsHuWXgHB7bWNXZV3zOtF/i8GW15NGQmn1rTgnItO
         o0IA==
X-Gm-Message-State: ACgBeo2hcXnkMpq3N+1vywBtA0JwGFMt/QtzqyXAyQ5ljPvzYfHePLhP
        M/WpvtX9kmWpL3RmAk4rotXMDxFszvhyNH7/lZ4IJQK17tT8lwSk
X-Google-Smtp-Source: AA6agR63L9wzsGtfPmSrLrHLW7XeAUElmg2ezRCAbl6X0aiLIEFrV2cFCs2BDvowKwLH7WGNQlaMJkdNOg9B7VCWRLs=
X-Received: by 2002:a17:907:2cce:b0:77a:6958:5aaa with SMTP id
 hg14-20020a1709072cce00b0077a69585aaamr6890242ejc.245.1662912762587; Sun, 11
 Sep 2022 09:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220911072251.25024-1-keguang.zhang@gmail.com> <20220911152725.xp6kvrh7542bjep6@mobilestation>
In-Reply-To: <20220911152725.xp6kvrh7542bjep6@mobilestation>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Mon, 12 Sep 2022 00:12:29 +0800
Message-ID: <CAJhJPsWYqVoMtLs_YpYKDKg3+YSGGiYfRLGtyUbvW48OfmRLJw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson32: Fix PHY-mode being left unspecified
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Serge,

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8811=E6=
=97=A5=E5=91=A8=E6=97=A5 23:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Kelvin
>
> On Sun, Sep 11, 2022 at 03:22:51PM +0800, Kelvin Cheung wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >
> > commit 0060c8783330 ("net: stmmac: implement support for passive mode
> > converters via dt") has changed the plat->interface field semantics fro=
m
> > containing the PHY-mode to specifying the MAC-PCS interface mode. Due t=
o
> > that the loongson32 platform code will leave the phylink interface
> > uninitialized with the PHY-mode intended by the means of the actual
> > platform setup. The commit-author most likely has just missed the
> > arch-specific code to fix. Let's mend the Loongson32 platform code then=
 by
> > assigning the PHY-mode to the phy_interface field of the STMMAC platfor=
m
> > data.
> >
>
> > Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode c=
onverters via dt")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>
> Your SoB tag should be here too right between mine SoB and TB
> tags [1].

Done.
Just sent PATCH v2.

>
> [1] Documentation/process/submitting-patches.rst, line 419 - 423.
>
> -Sergey
>
> > Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
>
> > ---
> >  arch/mips/loongson32/common/platform.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongso=
n32/common/platform.c
> > index 794c96c2a4cd..311dc1580bbd 100644
> > --- a/arch/mips/loongson32/common/platform.c
> > +++ b/arch/mips/loongson32/common/platform.c
> > @@ -98,7 +98,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev, v=
oid *priv)
> >       if (plat_dat->bus_id) {
> >               __raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART=
1 |
> >                            GMAC1_USE_UART0, LS1X_MUX_CTRL0);
> > -             switch (plat_dat->interface) {
> > +             switch (plat_dat->phy_interface) {
> >               case PHY_INTERFACE_MODE_RGMII:
> >                       val &=3D ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> >                       break;
> > @@ -107,12 +107,12 @@ int ls1x_eth_mux_init(struct platform_device *pde=
v, void *priv)
> >                       break;
> >               default:
> >                       pr_err("unsupported mii mode %d\n",
> > -                            plat_dat->interface);
> > +                            plat_dat->phy_interface);
> >                       return -ENOTSUPP;
> >               }
> >               val &=3D ~GMAC1_SHUT;
> >       } else {
> > -             switch (plat_dat->interface) {
> > +             switch (plat_dat->phy_interface) {
> >               case PHY_INTERFACE_MODE_RGMII:
> >                       val &=3D ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> >                       break;
> > @@ -121,7 +121,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev,=
 void *priv)
> >                       break;
> >               default:
> >                       pr_err("unsupported mii mode %d\n",
> > -                            plat_dat->interface);
> > +                            plat_dat->phy_interface);
> >                       return -ENOTSUPP;
> >               }
> >               val &=3D ~GMAC0_SHUT;
> > @@ -131,7 +131,7 @@ int ls1x_eth_mux_init(struct platform_device *pdev,=
 void *priv)
> >       plat_dat =3D dev_get_platdata(&pdev->dev);
> >
> >       val &=3D ~PHY_INTF_SELI;
> > -     if (plat_dat->interface =3D=3D PHY_INTERFACE_MODE_RMII)
> > +     if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> >               val |=3D 0x4 << PHY_INTF_SELI_SHIFT;
> >       __raw_writel(val, LS1X_MUX_CTRL1);
> >
> > @@ -146,9 +146,9 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata =
=3D {
> >       .bus_id                 =3D 0,
> >       .phy_addr               =3D -1,
> >  #if defined(CONFIG_LOONGSON1_LS1B)
> > -     .interface              =3D PHY_INTERFACE_MODE_MII,
> > +     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> >  #elif defined(CONFIG_LOONGSON1_LS1C)
> > -     .interface              =3D PHY_INTERFACE_MODE_RMII,
> > +     .phy_interface          =3D PHY_INTERFACE_MODE_RMII,
> >  #endif
> >       .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> >       .dma_cfg                =3D &ls1x_eth_dma_cfg,
> > @@ -186,7 +186,7 @@ struct platform_device ls1x_eth0_pdev =3D {
> >  static struct plat_stmmacenet_data ls1x_eth1_pdata =3D {
> >       .bus_id                 =3D 1,
> >       .phy_addr               =3D -1,
> > -     .interface              =3D PHY_INTERFACE_MODE_MII,
> > +     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> >       .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> >       .dma_cfg                =3D &ls1x_eth_dma_cfg,
> >       .has_gmac               =3D 1,
> >
> > base-commit: 727488e305b223ca69205ca5a3b99ace21bbbf5f
> > --
> > 2.34.1
> >



--=20
Best regards,

Kelvin Cheung
