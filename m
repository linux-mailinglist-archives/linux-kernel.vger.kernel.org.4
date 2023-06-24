Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3173C6AE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 06:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFXECn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 00:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFXECl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 00:02:41 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA591E5D;
        Fri, 23 Jun 2023 21:02:39 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-440b66adc81so497594137.1;
        Fri, 23 Jun 2023 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687579359; x=1690171359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCuh9aSXjoK8r6/sTg/D9QolCTlKGcoEEAFlcSDn2ec=;
        b=oor0mh/5vd4dlbNE/ceGHvKqW1/K/usscKJafysxBp0tZfDdnty1iJFYvDJTKDewzA
         KM5/9GpiMpdSpk0cTzc7FSkAhVt52BkL4JiSZgtgwqBNuhjrQnyM1G+52btiFT+GtXJC
         FJCW1EVLeFFw4zyEH9QUExqsiTSvSrTP93IyfwVrGTKVgsXfwKl3HzFatm6OL36kQYZd
         OEWZlQMsnvkLNzawFOFaDMgkeEeDJZWvbpCeUstUde5trH59QT42ueb3tbwQpQntAnn0
         XQ9JKwCDpgTdlgbRfHYYcQWOzdx9Lo1o13gByosoLZyTN1S6N9NRTkWVa3IQmUd5L3X8
         SYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687579359; x=1690171359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCuh9aSXjoK8r6/sTg/D9QolCTlKGcoEEAFlcSDn2ec=;
        b=hb4Rhtjt8oF1CQXdshpr6+hoeMjFk+axC8O+14isH1oGa2kXdFYEGytDdNOd4JxzE2
         qu/6/Nt0L62kDmNkgKkxcIzZSWdzvQy+fcmKn/7LBGajbEY8XcyaLcIKhkrkTKlOjmEH
         Oe+DR7XBwFNuytY8sro71/fBHN1sI7JllhV4D7Jn5Gf15ZaBY3eHO4DYTVCv7IPwMYJl
         WKlmlS9HiErNNwqdz6H8nu9V78+4B/hoQrHnGCQvJdSxPvRzZlO1XcUcc7zuX+Qz6U4w
         tadr+L9WJKMXc7eYrzguuVvMnq1cLTdgtNrlarG4PdKNqpN+8TUWQTWnNI+xuRqkr77Y
         DkPw==
X-Gm-Message-State: AC+VfDxchKWCFqr+lBNIXzYbCmYjwq+h2hZhzcF6WgVZGdMyzsB1GrzM
        uWLIqyQkLIbBmhRTmQL/A6GWToJHWEM6cGavOlg=
X-Google-Smtp-Source: ACHHUZ59y85cCOIjhzUCmisxmaFufaM/RI+H21zBNu45OBi6SS6CoT7usIN8Ff+AcfBVhQUd1LaT9J4+a0Qd6jor2LU=
X-Received: by 2002:a67:de81:0:b0:43f:4714:a03b with SMTP id
 r1-20020a67de81000000b0043f4714a03bmr12195580vsk.17.1687579358722; Fri, 23
 Jun 2023 21:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com> <ZJQ2yBX16gAg+n0L@shell.armlinux.org.uk>
In-Reply-To: <ZJQ2yBX16gAg+n0L@shell.armlinux.org.uk>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Sat, 24 Jun 2023 06:02:27 +0200
Message-ID: <CAJN1KkzOZ-aZ8JGL5fyQUnOuFkBDfONVLKP3Xe20HYtp7Not0g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
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

czw., 22 cze 2023 o 13:55 Russell King (Oracle)
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Wed, Jun 21, 2023 at 09:12:56PM +0200, Pawel Dembicki wrote:
> > +     /* This driver does not make use of the speed, duplex, pause or t=
he
> > +      * advertisement in its mac_config, so it is safe to mark this dr=
iver
> > +      * as non-legacy.
> > +      */
> > +     config->legacy_pre_march2020 =3D false;
>
> Great stuff, thanks!
>
> > +static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port=
,
> > +                                    unsigned int mode,
> > +                                    const struct phylink_link_state *s=
tate)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
>
> Nit: normally have a blank line between function variable declarations
> and the rest of the function body.
>
> >       /* Special handling of the CPU-facing port */
> >       if (port =3D=3D CPU_PORT) {
> >               /* Other ports are already initialized but not this one *=
/
> > @@ -775,104 +803,92 @@ static void vsc73xx_adjust_link(struct dsa_switc=
h *ds, int port,
> >                             VSC73XX_ADVPORTM_ENA_GTX |
> >                             VSC73XX_ADVPORTM_DDR_MODE);
> >       }
> > +}
> >
> > -     /* This is the MAC confiuration that always need to happen
> > -      * after a PHY or the CPU port comes up or down.
> > -      */
> > -     if (!phydev->link) {
> > -             int maxloop =3D 10;
> > +static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int p=
ort,
> > +                                       unsigned int mode,
> > +                                       phy_interface_t interface)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u32 val;
> >
> > -             dev_dbg(vsc->dev, "port %d: went down\n",
> > -                     port);
> > +     int maxloop =3D VSC73XX_TABLE_ATTEMPTS;
>
> Reverse christmas-tree for variable declarations, and there shouldn't
> be a blank line between them. In any case, I don't think you need
> "maxloop" if you adopt my suggestion below.
>
> >
> > -             /* Disable RX on this port */
> > -             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > -                                 VSC73XX_MAC_CFG,
> > -                                 VSC73XX_MAC_CFG_RX_EN, 0);
> > +     dev_dbg(vsc->dev, "port %d: went down\n",
> > +             port);
> >
> > -             /* Discard packets */
> > -             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
> > -                                 VSC73XX_ARBDISC, BIT(port), BIT(port)=
);
> > +     /* Disable RX on this port */
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                         VSC73XX_MAC_CFG,
> > +                         VSC73XX_MAC_CFG_RX_EN, 0);
> > +
> > +     /* Discard packets */
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
> > +                         VSC73XX_ARBDISC, BIT(port), BIT(port));
> >
> > -             /* Wait until queue is empty */
> > +     /* Wait until queue is empty */
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> > +                  VSC73XX_ARBEMPTY, &val);
> > +     while (!(val & BIT(port))) {
> > +             msleep(1);
> >               vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> >                            VSC73XX_ARBEMPTY, &val);
> > -             while (!(val & BIT(port))) {
> > -                     msleep(1);
> > -                     vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
> > -                                  VSC73XX_ARBEMPTY, &val);
> > -                     if (--maxloop =3D=3D 0) {
> > -                             dev_err(vsc->dev,
> > -                                     "timeout waiting for block arbite=
r\n");
> > -                             /* Continue anyway */
> > -                             break;
> > -                     }
> > +             if (--maxloop =3D=3D 0) {
> > +                     dev_err(vsc->dev,
> > +                             "timeout waiting for block arbiter\n");
> > +                     /* Continue anyway */
> > +                     break;
> >               }
> > +     }
>
> I know you're only moving this code, but I think it would be good to
> _first_ have a patch that fixes this polling function:
>
>         int ret, err;
> ...
>                 ret =3D read_poll_timeout(vsc73xx_read, err,
>                                         err < 0 || (val & BIT(port)),
>                                         1000, 10000, false,
>                                         vsc, VSC73XX_BLOCK_ARBITER, 0,
>                                         VSC73XX_ARBEMPTY, &val);
>                 if (ret !=3D 0)
>                         dev_err(vsc->dev,
>                                 "timeout waiting for block arbiter\n");
>                 else if (err < 0)
>                         dev_err(vsc->dev,
>                                 "error reading arbiter\n");
>
> This avoids the issue that on the last iteration, the code reads the
> register, test it, find the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait.
>

Thank you for the tips. I will prepare additional commit in v2 series.

> > +static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int por=
t,
> > +                                     unsigned int mode,
> > +                                     phy_interface_t interface,
> > +                                     struct phy_device *phydev,
> > +                                     int speed, int duplex,
> > +                                     bool tx_pause, bool rx_pause)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u32 val;
> >
> > +     switch (speed) {
> > +     case SPEED_1000:
> >               /* Set up default for internal port or external RGMII */
> > -             if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII)
> > +             if (interface =3D=3D PHY_INTERFACE_MODE_RGMII)
> >                       val =3D VSC73XX_MAC_CFG_1000M_F_RGMII;
> >               else
> >                       val =3D VSC73XX_MAC_CFG_1000M_F_PHY;
> > -             vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> > -     } else if (phydev->speed =3D=3D SPEED_100) {
> > -             if (phydev->duplex =3D=3D DUPLEX_FULL) {
> > -                     val =3D VSC73XX_MAC_CFG_100_10M_F_PHY;
> > -                     dev_dbg(vsc->dev,
> > -                             "port %d: 100 Mbit full duplex mode\n",
> > -                             port);
> > -             } else {
> > -                     val =3D VSC73XX_MAC_CFG_100_10M_H_PHY;
> > -                     dev_dbg(vsc->dev,
> > -                             "port %d: 100 Mbit half duplex mode\n",
> > -                             port);
> > -             }
> > -             vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> > -     } else if (phydev->speed =3D=3D SPEED_10) {
> > -             if (phydev->duplex =3D=3D DUPLEX_FULL) {
> > +             break;
> > +     case SPEED_100:
> > +     case SPEED_10:
> > +             if (duplex =3D=3D DUPLEX_FULL)
> >                       val =3D VSC73XX_MAC_CFG_100_10M_F_PHY;
> > -                     dev_dbg(vsc->dev,
> > -                             "port %d: 10 Mbit full duplex mode\n",
> > -                             port);
> > -             } else {
> > +             else
> >                       val =3D VSC73XX_MAC_CFG_100_10M_H_PHY;
> > -                     dev_dbg(vsc->dev,
> > -                             "port %d: 10 Mbit half duplex mode\n",
> > -                             port);
> > -             }
> > -             vsc73xx_adjust_enable_port(vsc, port, phydev, val);
> > -     } else {
> > -             dev_err(vsc->dev,
> > -                     "could not adjust link: unknown speed\n");
> > +             break;
> >       }
>
> Do the dev_dbg() add anything useful over what phylink prints when the
> link comes up?
>
> I don't think moving to a switch() statement for this is a good idea.
> Given that "val" may be uninitialised, I suspect the following may be
> a better solution:
>
>         if (speed =3D=3D SPEED_1000 || speed =3D=3D SPEED_100 || speed =
=3D=3D SPEED_10) {
>                 if (speed =3D=3D SPEED_1000) {
>                         ...
>                 } else {
>                         ...
>                 }
>
>                 ... set VSC73XX_BLOCK_ANALYZER and call
>                 vsc73xx_adjust_enable_port ...
>         }
>
> However, looking at the definitions of the various macros, it seems we
> can do a little better by not using the VSC73XX_MAC_CFG_*M_[FH]_*
> definitions:
>
>                 if (speed =3D=3D SPEED_1000) {
>                         val =3D VSC73XX_MAC_CFG_GIGA_MODE |
>                               VSC73XX_MAC_CFG_TX_IPG_1000M;
>
>                         if (interface =3D=3D PHY_INTERFACE_MODE_RGMII)
>                                 val |=3D VSC73XX_MAC_CFG_CLK_SEL_1000M;
>                         else
>                                 val |=3D VSC73XX_MAC_CFG_CLK_SEL_EXT;
>                 } else {
>                         val =3D VSC73XX_MAC_CFG_TX_IPG_100_10M |
>                               VSC73XX_MAC_CFG_CLK_SEL_EXT;
>                 }
>
>                 if (duplex =3D=3D DUPLEX_FULL)
>                         val |=3D VSC73XX_MAC_CFG_FDX;
>
> Now, this reveals a question: when operating in RGMII mode, why do we
> need VSC73XX_MAC_CFG_CLK_SEL_1000M for 1G, and
> VSC73XX_MAC_CFG_CLK_SEL_EXT for 10M and 100M, whereas "PHY" mode always
> uses CLK_SEL_EXT ?
>

VSC73XX_MAC_CFG_CLK_SEL_EXT should be used always when phy is used, no
matter what speed is. VSC73XX_MAC_CFG_CLK_SEL_1000M in RGMII mode. It
can be even more simplified:

if (speed =3D=3D SPEED_1000)
val =3D VSC73XX_MAC_CFG_GIGA_MODE | VSC73XX_MAC_CFG_TX_IPG_1000M;
else
val =3D VSC73XX_MAC_CFG_TX_IPG_100_10M;

if (interface =3D=3D PHY_INTERFACE_MODE_RGMII)
val |=3D VSC73XX_MAC_CFG_CLK_SEL_1000M;
else
val |=3D VSC73XX_MAC_CFG_CLK_SEL_EXT;

if (duplex =3D=3D DUPLEX_FULL)
val |=3D VSC73XX_MAC_CFG_FDX;

--
Pawel Dembicki
