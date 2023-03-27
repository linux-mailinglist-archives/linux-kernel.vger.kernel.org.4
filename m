Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11916C9B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjC0G1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0G1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:27:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08564498;
        Sun, 26 Mar 2023 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1679898458; x=1711434458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUGZr001csTpDC6gvfZA1QE8lGdCVfjVc1sD6Q6zxms=;
  b=XR+KqMAy/Ck5DFeh2uzLXk0Myfazk+/zLBdczU9XjiZWBjE/sqtSlCY/
   YGZ60/H0qVXEbrG0lBSA7C/vvCnzFbOA2CtEJjUwJrcypibQDR1myDUH8
   7kAnyGByEs4jLKt68fjKJ7wuGNSTxJj40v5BpbQxavgRXthL+FTqzlUZs
   cIWgo6tYaYqg8pCLi1IEsgP/Xaz9aKcJIi69rw7cWw5aiNTQPRlbBpLSv
   RgVQgnzLTq9zzJ2kWPvyeoqY5hHc8Lm2u6sxr1XLA2Nif6vB9jl/34tfA
   k3dcsGc5rpqKdYbCBgjb+K7jFosVbXctpFXsd/xbjZSqgj2bng8zSvtGY
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="29940150"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Mar 2023 08:27:34 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 27 Mar 2023 08:27:34 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 27 Mar 2023 08:27:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1679898454; x=1711434454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUGZr001csTpDC6gvfZA1QE8lGdCVfjVc1sD6Q6zxms=;
  b=Fk9YqqG1VP1SBPwBqdPU0K8cjCVMcSjzO94ysOmSZ7yxfOBeon0VTf07
   Y9Lw0EMlYu3CON7N3CVnt7IKm9aNvKGtXsLGXsFxXkS2vLstsjT8KEuFB
   Ta8cNih7jlCeRwWqVRYn9BgXlRfBBO0iwIdvE9+KMWFbuHqPysl1Sky4P
   i+PH224JYIhd9u33HEJmM2RMkJPqdfk5oLnYDSsZBLwPGiYeXPTCNm6Cd
   TGQpwSqhTMsKJyyQ6lwQ11wMqXYlWHoUpaJ7ihwapKB6DtO05HmWNhWBI
   MYYU+uzDIhyom3nL2FrEcgZx/JhunecH53SxhPmsZl3B1HVXqVE6BYm24
   A==;
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="29940149"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Mar 2023 08:27:34 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 16D93280056;
        Mon, 27 Mar 2023 08:27:34 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     peng.fan@oss.nxp.com, linux-arm-kernel@lists.infradead.org
Cc:     Markus.Niebel@ew.tq-group.com, abailon@baylibre.com,
        abelvesa@kernel.org, aford173@gmail.com,
        devicetree@vger.kernel.org, djakov@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        marex@denx.de, paul.elder@ideasonboard.com, peng.fan@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        gerg@kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH V3 7/7] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Mon, 27 Mar 2023 08:27:31 +0200
Message-ID: <2678294.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230327045037.593326-1-gerg@linux-m68k.org>
References: <20220703091451.1416264-8-peng.fan@oss.nxp.com> <20230327045037.593326-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am Montag, 27. M=E4rz 2023, 06:50:37 CEST schrieb Greg Ungerer:
> On 2/3/22 17:13, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >=20
> > Add interconnect property for hsio blk ctrl
> >=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >=20
>  > arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
>  > 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> > 08bd57742294..9cceeeeb26be 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1109,6 +1109,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
> >=20
> >  						<&pgc_hsiomix>,=20
<&pgc_pcie_phy>;
> >  			=09
> >  				power-domain-names =3D "bus", "usb",=20
"usb-phy1",
> >  			=09
> >  						     "usb-phy2",=20
"pcie", "pcie-phy";
> >=20
> > +				interconnects =3D <&noc=20
IMX8MP_ICM_NOC_PCIE &noc IMX8MP_ICN_HSIO>,
> > +						<&noc=20
IMX8MP_ICM_USB1 &noc IMX8MP_ICN_HSIO>,
> > +						<&noc=20
IMX8MP_ICM_USB2 &noc IMX8MP_ICN_HSIO>,
> > +						<&noc=20
IMX8MP_ICM_PCIE &noc IMX8MP_ICN_HSIO>;
> > +				interconnect-names =3D "noc-pcie",=20
"usb1", "usb2", "pcie";
> >=20
> >  				#power-domain-cells =3D <1>;
> >  		=09
> >  			};
> >  	=09
> >  		};
>=20
> This change completely breaks USB for me on a new iMX8mp platform I am
> working with. Before this change normal USB probe looks good:
>=20
>     xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number=
 1
>     xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe6d hci version 0x110 qui=
rks
> 0x0000000000010010 xhci-hcd xhci-hcd.0.auto: irq 206, io mem 0x38100000
>     xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>     xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number=
 2
>     xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
>     usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002,
> bcdDevice=3D 6.03 usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
> SerialNumber=3D1 usb usb1: Product: xHCI Host Controller
>     usb usb1: Manufacturer: Linux 6.3.0-rc4-dirty xhci-hcd
>     ....
>=20
> But after this commit is applied, no USB probe messages at all.
>=20
> USB worked fine in 6.0 for me, but when I switched up to 6.1 USB was brok=
en,
> I bisected to this as being the offending commit. This is still broken for
> me in todays 6.3-rc4. If I revert this change (and only this change) USB
> works again.
>=20
> Any thoughts on why this breaks USB?

Maybe you are missing CONFIG_INTERCONNECT_IMX8MP?

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


