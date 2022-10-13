Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2B5FE1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJMSqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJMSqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:46:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376B191D49;
        Thu, 13 Oct 2022 11:43:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so4168212wrp.10;
        Thu, 13 Oct 2022 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5L/tN8Nk5G1hFHXmpnHlaxEzIusr004HXV2igjx6Dg=;
        b=WaMkAHVPl8AWTlsWCOn5940xJ4n2+DGuI4BNxlNTPRVWDmpiouz4lLGIdgOc56G/S6
         iSHRYRPLpu31hPIR2oj21xQEuSdwrLDTdg/IugpMzX8dl4YOSahc+Yqf4kLYlruz8JzY
         64PxNCx8ufShrGobabHugKDumGeDPrBw9+AWABQqzAidTIT/coJDU4Tn5zSPLWr8sdEf
         oNp8J+itnMQD5L8G24GuDwqs4kj/GWhSmrVNWx4UmvfjtfwYAlO3E248VRJATnUSBFyS
         20aXm6B8tZUCaWd3U1V2l5NDledETwN6ROnHCmJiV5fH9PIprBjM0gH3bh3kAWQdj8xr
         54IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5L/tN8Nk5G1hFHXmpnHlaxEzIusr004HXV2igjx6Dg=;
        b=j6vz7WrqkhSvOisYXQ0MpTH7MYMrEAPwpjfdK3J7dK9vF09cbeGuIXpNA1ANqNaaMn
         BX6WBxz7qvtqwNMP1NmVZpkKO6shPOE7ZI51PZnuZeOUgHLlrdjYh14Q3QeTDklQNcKc
         6eKdHhGwJwDoa5x36MY4ttCxFRcrs5oEAx9gdv2YdycN0ssELlvDDLdaow6QBYoQ96A/
         rviRLxkt8yBldofAjXLEnCguZjcEx6sOpgdEApvLh7jWkmsfEvpgitvXeOQ2J8uaxA20
         D8bMffcsoVuWzZFYi/vTYVnFVSRGJAUzTBQ22sxta8cSy9/RTdzVwQHrEX2P4ZtNrbjT
         /WLg==
X-Gm-Message-State: ACrzQf3LvoP+o7B4IuTybBoGa9K8yu7+okLZaCyCW9xuY/nWylDgmGfZ
        eygLMPr7DRWKWgAAboBtqtgB57EoAwXMFAR5
X-Google-Smtp-Source: AMsMyM5D9VcyYdymrteUFP/uy7fZdMK47gw4RIDknOofM1/3bcKBsARkwBkRONaV/eI3T52TMYs+Xg==
X-Received: by 2002:a17:907:75ed:b0:78d:97ed:2894 with SMTP id jz13-20020a17090775ed00b0078d97ed2894mr732203ejc.739.1665685520104;
        Thu, 13 Oct 2022 11:25:20 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id i24-20020a056402055800b004588ef795easm283249edx.34.2022.10.13.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:25:19 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: Re: [PATCH v2 04/10] phy: sun4i-usb: add support for the USB PHY on F1C100s SoC
Date:   Thu, 13 Oct 2022 20:25:18 +0200
Message-ID: <3442772.V25eIC5XRa@kista>
In-Reply-To: <439b685e3aada19021d94669f6f855f1fc81d08e.camel@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me> <4218006.ejJDZkT8p0@kista> <439b685e3aada19021d94669f6f855f1fc81d08e.camel@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 13. oktober 2022 ob 10:49:51 CEST je Icenowy Zheng napisa=
l(a):
> =E5=9C=A8 2022-10-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 23:21 +0200=EF=
=BC=8CJernej =C5=A0krabec=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi Icenowy,
> >=20
> > Dne sreda, 12. oktober 2022 ob 07:55:56 CEST je Icenowy Zheng
> >=20
> > napisal(a):
> > > The F1C100s SoC has one USB OTG port connected to a MUSB
> > > controller.
> > >=20
> > > Add support for its USB PHY.
> > >=20
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > > No changes since v1.
> > >=20
> > >  drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > b/drivers/phy/allwinner/phy-sun4i-usb.c index
> > > 3a3831f6059a..2f94cb77637b
> > > 100644
> > > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > > @@ -109,6 +109,7 @@ enum sun4i_usb_phy_type {
> > >         sun8i_v3s_phy,
> > >         sun50i_a64_phy,
> > >         sun50i_h6_phy,
> > > +       suniv_f1c100s_phy,
> > >  };
> > >=20
> > >  struct sun4i_usb_phy_cfg {
> > > @@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct
> > > platform_device
> > > *pdev) return 0;
> > >  }
> > >=20
> > > +static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg =3D {
> > > +       .num_phys =3D 1,
> > > +       .type =3D suniv_f1c100s_phy,
> >=20
> > I think you should just use sun4i_a10_phy. It has no special
> > handling. I don't
> > see a point adding new phy types if there is no special cases for it.
>=20
> Sounds reasonable, although I think we should finally drop .type and
> use only describing items.

That would be even better. Will you do it?

>=20
> > Best regards,
> > Jernej
> >=20
> > > +       .disc_thresh =3D 3,
> > > +       .phyctl_offset =3D REG_PHYCTL_A10,
> > > +       .dedicated_clocks =3D true,
> > > +};
> > > +
> > >  static const struct sun4i_usb_phy_cfg sun4i_a10_cfg =3D {
> > >         .num_phys =3D 3,
> > >         .type =3D sun4i_a10_phy,
> > > @@ -988,6 +997,8 @@ static const struct of_device_id
> > > sun4i_usb_phy_of_match[] =3D { { .compatible =3D
> > > "allwinner,sun50i-a64-usb-phy",
> > >           .data =3D &sun50i_a64_cfg},
> > >         { .compatible =3D "allwinner,sun50i-h6-usb-phy", .data =3D
> >=20
> > &sun50i_h6_cfg },
> >=20
> > > +       { .compatible =3D "allwinner,suniv-f1c100s-usb-phy",
> > > +         .data =3D &suniv_f1c100s_cfg },
> > >         { },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> > > --
> > > 2.37.1


