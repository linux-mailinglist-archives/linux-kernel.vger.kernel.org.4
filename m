Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C55B4C59
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiIKG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIKG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 02:27:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F89357FF;
        Sat, 10 Sep 2022 23:27:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so8398000edd.13;
        Sat, 10 Sep 2022 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=elgmNgCfXFZxV2r9JjcSrgNHyOg7gwBvXaPlEj5CKLo=;
        b=XiP1ez6pqfgDv916QNFqAjftoSMFu8BSePHPP3tEoVv/OfQNkouuu0pmEi0m+uj0DZ
         OcUACfute2ToigcENmw+VRPKq2w+KcamoLi2R4M+cZgFGaFl4FyM6BdPUJGux0Pqofv+
         9NGgkbijgVcPi75PSfcG4EIJO0m+wFsmlx81umSHIghucteWOWMqSLqt80KTojt821ys
         ycTZ49FuNVHoaOJaQtJ/ZbGlkfjXbwp7dEbJjK4w9TFEfKnXtYz5Sp32j3dWO0FslIdH
         7tyEDsbepPO7tGyjW5EljPlG1wL/p1uI77PnxjVMB31c+JqN3DzW2s63TlUeYqKBAWKt
         Ogfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=elgmNgCfXFZxV2r9JjcSrgNHyOg7gwBvXaPlEj5CKLo=;
        b=3cCJEA1ONCKjO/RTNnefydNmlWk/XJOdBjddpvAQJj4g8W15WIYfam3OcsRzckbJkl
         Azq04vQd7vBQnA99abWR3L124/8WVXTSUcxC4hHuOYacFxXnMkHaiKojqrq007rNDh8+
         qDvWy1oeA+ZARF9SrOjlCWkUJvI4JpUNTbLNmtsBMvirmD/Lkutk8aGVLVUxtvtS9sYU
         tIZ83qoCArMKn1fNar61Dqe1L2TV7f8a+um3Wx7c5g3XKe75l4GjzpWNlZlCmSfM/P/B
         8M0XLKoeqDpOLbF3L4RjJtoAxgFPtDgjTMomTE8yv6tT7hIikr/sUqd9kVqndkaFXJ0Y
         GhJQ==
X-Gm-Message-State: ACgBeo0M/Je88Cim4qIf8AyYJMSJBkyuWnsbGxZCV1faCAfHzra4DDQp
        1U0FqPt1YjO7Sho/31Hb4aMwKToO36cHfQViYn7czRZAAXyJFg==
X-Google-Smtp-Source: AA6agR4PWGoLKmarQ7MhRvaZYgkdEkj2Ne39l524qm4rbHmjmn6VBZaWzJ0NHXADRj9wsWjALrB6rDdsNdDmfbSeXdk=
X-Received: by 2002:a05:6402:35d6:b0:44e:f45a:8f79 with SMTP id
 z22-20020a05640235d600b0044ef45a8f79mr17888043edc.393.1662877636650; Sat, 10
 Sep 2022 23:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220818050019.1924408-1-keguang.zhang@gmail.com>
 <20220821171030.wc343w6zmrtcz5to@mobilestation> <CAJhJPsW0HTs+=PD2JvXZVTkm9zrnRYKtEwLNv3dsVsf1AUNjDQ@mail.gmail.com>
 <20220902224630.tik2zt7vpwv3pcww@mobilestation>
In-Reply-To: <20220902224630.tik2zt7vpwv3pcww@mobilestation>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sun, 11 Sep 2022 14:27:03 +0800
Message-ID: <CAJhJPsVMB83SxmRwurzjrM6MU_D-mQcaACcx9ksdO-OCx-reqg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B &
 LS1C Ethernet PHY
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>
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

Hi Serge,

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=85=AD 06:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Aug 28, 2022 at 09:31:25PM +0800, Kelvin Cheung wrote:
> > Hi Serge,
> > Your patch also works for me.
>
> Great. Could you submit it for review then with your tested-by tag
> added?

Sure.

>
> > But what about the plat_dat->interface? Is it obsolete?
>
> No. As I said in the patch log it's still used in the STMMAC driver
> but for the MAC-PCS mode setting. Such PCS isn't available on the most
> of the cases so the "phy_interface" field should be mainly utilized
> instead while the "interface" field is supposed to be left untouched.
> See the commit 0060c8783330 ("net: stmmac: implement support for
> passive mode converters via dt") for details.

Got it. Thanks!

>
> -Sergey
>
> >
> > Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=882=
2=E6=97=A5=E5=91=A8=E4=B8=80 01:10=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hello Keguang
> > >
> > > On Thu, Aug 18, 2022 at 01:00:19PM +0800, Keguang Zhang wrote:
> > > > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > > >
> > > > The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
> > > > using phylink_generic_validate() instead of stmmac_validate().
> > > > Moreover the driver assumes the PHY interface mode
> > > > passed in platform data is always supported.
> > > >
> > > > stmmaceth stmmaceth.0 eth0: validation of gmii with support 0000000=
0,00000000,000062cf and advertisement 00000000,00000000,000062cf failed: -E=
INVAL
> > > > stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (erro=
r: -22)
> > > >
> > > > This patch sets phy_interface field of platform data.
> > >
> > > I've got a similar fix in my repo, though didn't have a chance to tes=
t
> > > it out due to lacking any loongson hardware. I've discovered the
> > > issues on my still going way of the STMMAC driver refactoring. Anyway
> > > IMO the problem is a bit different than you describe and should be
> > > fixed in a bit different way. Please see a patch attached to this
> > > email. Could you test it out on your hw? If it fixes the problem you
> > > can resend it as v2 patch.
> > >
> > > -Sergey
> > >
> > > >
> > > > Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_valid=
ate()")
> > > > Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
> > > > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > > > ---
> > > >  arch/mips/loongson32/common/platform.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loo=
ngson32/common/platform.c
> > > > index 794c96c2a4cd..741aace80b80 100644
> > > > --- a/arch/mips/loongson32/common/platform.c
> > > > +++ b/arch/mips/loongson32/common/platform.c
> > > > @@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_p=
data =3D {
> > > >       .phy_addr               =3D -1,
> > > >  #if defined(CONFIG_LOONGSON1_LS1B)
> > > >       .interface              =3D PHY_INTERFACE_MODE_MII,
> > > > +     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> > > >  #elif defined(CONFIG_LOONGSON1_LS1C)
> > > >       .interface              =3D PHY_INTERFACE_MODE_RMII,
> > > > +     .phy_interface          =3D PHY_INTERFACE_MODE_RMII,
> > > >  #endif
> > > >       .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> > > >       .dma_cfg                =3D &ls1x_eth_dma_cfg,
> > > >
> > > > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > > > --
> > > > 2.34.1
> > > >
> >
> >
> >
> > --
> > Best regards,
> >
> > Kelvin Cheung



--=20
Best regards,

Kelvin Cheung
