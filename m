Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E355FD676
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJMIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJMIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:50:27 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7CD03A3;
        Thu, 13 Oct 2022 01:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665650999; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mAXTfNQx4KK9U3hKLTy2Vu1XiBfkJTEQgI+t2gr+tHIZwjiSpe4WpePGfugU5vLm0UjfgYLh/SKAzQydZT/N7Q+ARKGxowo6xQkyQqMPwBsQjgueCM/UrelMUsCzNstnuSlNpnPSlLvj85maTN16f/ucdiqI8IUTCET2TlEyRM4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665650999; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=h+wv9BWVpxAEeVBWGF8N5xlC4ECUzHofGlXe/WmnrJs=; 
        b=NUVJ6aPmn6fBNHnE3dW3SY0oM6InJa+Qx1d9G69TNW7K2WImfpRyXCQ3dnHdPPT7mLFwIaNj06VS49jmfG/6WjSEph0pmNtfV226t9Eic/MRKfOv4HGHzpTN7YnLLvIC4fp6T9t6JzcDpSX9a/tpfkzNxyZVBV4cluY+FLaYANY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665650999;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=h+wv9BWVpxAEeVBWGF8N5xlC4ECUzHofGlXe/WmnrJs=;
        b=LVp9SE8gVJU1f+WjTS3Iw7cWc4QspHdlvHzXmf9Oxy3mwzclD9hQpgVAJO0UcDLd
        xUSytzEPrRsDSJEiGYdItiKU4uah204LZhup02JQBBQsAXQWycS/jKZMEfHL9btMKbR
        IeNrlMDLpJHFsiS/E9YRJ33+x3KnuIOAo+fFeDxY=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665650997135403.57608440342176; Thu, 13 Oct 2022 01:49:57 -0700 (PDT)
Message-ID: <439b685e3aada19021d94669f6f855f1fc81d08e.camel@icenowy.me>
Subject: Re: [PATCH v2 04/10] phy: sun4i-usb: add support for the USB PHY on
 F1C100s SoC
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Jernej =?gb2312?Q?=810=947krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Date:   Thu, 13 Oct 2022 16:49:51 +0800
In-Reply-To: <4218006.ejJDZkT8p0@kista>
References: <20221012055602.1544944-1-uwu@icenowy.me>
         <20221012055602.1544944-5-uwu@icenowy.me> <4218006.ejJDZkT8p0@kista>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-10-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 23:21 +0200=EF=BC=
=8CJernej =C5=A0krabec=E5=86=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> Dne sreda, 12. oktober 2022 ob 07:55:56 CEST je Icenowy Zheng
> napisal(a):
> > The F1C100s SoC has one USB OTG port connected to a MUSB
> > controller.
> >=20
> > Add support for its USB PHY.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > No changes since v1.
> >=20
> > =C2=A0drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
> > =C2=A01 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> > b/drivers/phy/allwinner/phy-sun4i-usb.c index
> > 3a3831f6059a..2f94cb77637b
> > 100644
> > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > @@ -109,6 +109,7 @@ enum sun4i_usb_phy_type {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun8i_v3s_phy,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun50i_a64_phy,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun50i_h6_phy,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0suniv_f1c100s_phy,
> > =C2=A0};
> >=20
> > =C2=A0struct sun4i_usb_phy_cfg {
> > @@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct
> > platform_device
> > *pdev) return 0;
> > =C2=A0}
> >=20
> > +static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_phys =3D 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type =3D suniv_f1c100s_phy,
>=20
> I think you should just use sun4i_a10_phy. It has no special
> handling. I don't=20
> see a point adding new phy types if there is no special cases for it.

Sounds reasonable, although I think we should finally drop .type and
use only describing items.

>=20
> Best regards,
> Jernej
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.disc_thresh =3D 3,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.phyctl_offset =3D REG_PHYCT=
L_A10,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dedicated_clocks =3D true,
> > +};
> > +
> > =C2=A0static const struct sun4i_usb_phy_cfg sun4i_a10_cfg =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_phys =3D 3,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type =3D sun4i_a10_phy=
,
> > @@ -988,6 +997,8 @@ static const struct of_device_id
> > sun4i_usb_phy_of_match[] =3D { { .compatible =3D
> > "allwinner,sun50i-a64-usb-phy",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .data =3D &sun50=
i_a64_cfg},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allw=
inner,sun50i-h6-usb-phy", .data =3D=20
> &sun50i_h6_cfg },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwinner=
,suniv-f1c100s-usb-phy",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .data =3D &suniv_f1c1=
00s_cfg },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ },
> > =C2=A0};
> > =C2=A0MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> > --
> > 2.37.1
>=20
>=20
>=20

