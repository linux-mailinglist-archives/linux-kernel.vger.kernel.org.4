Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3A6BE160
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCQGjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCQGjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:39:41 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02A7C9C3;
        Thu, 16 Mar 2023 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1679035156; x=1710571156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+GGprb+XSzjmdDlXa4/4UaRSRUTLEq73/iJozAjmGA=;
  b=JT1zqcLKuVglRFgIUsSRnISBTS2/bRE5M+wkHicuqzGei/QbNTL7qSuf
   XawJqSulEmM8F7G1xchXR1TFk81+dct85LQC2CQruRMYuMUyvPggbPq1v
   ahwdRsJncxcvht5d/1H+gSwh62gCmfw9Tm+7rvrj3zO/7jE6m0Q97/geS
   y76T/gWBkjuBZWFTHTD4DSvdJ5DXLkrgaS4hLaPDK69AKiRSmbHbUPX38
   iYgXW2SAfLNhExZL33N4ikEEAdyVTeCnlTlhT+AEJavN8wN1YFVTIEujX
   unVHpJpoGLe2E6f2luMAhGHqShBiYOUuNv5iGlkXS4T/2maa81MI47kpM
   g==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="29753071"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Mar 2023 07:39:12 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 17 Mar 2023 07:39:12 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 17 Mar 2023 07:39:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1679035152; x=1710571152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+GGprb+XSzjmdDlXa4/4UaRSRUTLEq73/iJozAjmGA=;
  b=b8llSi/Zng3Huzj6sUN2ORzmOIZhqumYUu1RpckAgOIH2EO9InrngZht
   V1lBWAoV4vlbIVfMjYmIaANLf13y4MpMxR8nAIR3tq99nbyZbeR9Ff0CU
   wBG2SDQjtYYWAJ2qRtu1+4OeMNGEd8DW07bLYxGX3mU5FOUvK8Tv0e+V6
   OxCJOAffBaVe+gzC0esaeSQ6K0ghiFyUxviJacMglI8tFO7zzTfuj8/bZ
   DyH/p6ZhVIplL3/7ZpxuDEiJirKsRxUQWoZsvNlAzjNxyey6ya740FAgr
   ZhHUXdhwV6w7mDE+5DR788wiD0rMr7POk3OAmhgfeKmVQKXUKVfNf4Htk
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673910000"; 
   d="scan'208";a="29753070"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Mar 2023 07:39:12 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0E09A280056;
        Fri, 17 Mar 2023 07:39:12 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8qxp: add cadence usb3 support
Date:   Fri, 17 Mar 2023 07:39:09 +0100
Message-ID: <3810738.Icojqenx9y@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230316212712.2426542-3-Frank.Li@nxp.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com> <20230316212712.2426542-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. M=E4rz 2023, 22:27:10 CET schrieb Frank Li:
> There are cadence usb3.0 controller in 8qxp and 8qm.
> Add usb3 node at common connect subsystem.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-conn.dtsi      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi index
> 4852760adeee..389f52f16a5c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
> @@ -138,6 +138,56 @@ fec2: ethernet@5b050000 {
>  		status =3D "disabled";
>  	};
>=20
> +	usbotg3: usb@5b110000 {
> +		compatible =3D "fsl,imx8qm-usb3";

Mh, is imx8qm considered a subset of imx8qxp or vice versa?
Maybe it's worth adding a dedicated compatible for imx8qxp as well.

Best regards,
Alexander

> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +		reg =3D <0x5b110000 0x10000>;
> +		clocks =3D <&usb3_lpcg IMX_LPCG_CLK_1>,
> +			 <&usb3_lpcg IMX_LPCG_CLK_0>,
> +			 <&usb3_lpcg IMX_LPCG_CLK_7>,
> +			 <&usb3_lpcg IMX_LPCG_CLK_4>,
> +			 <&usb3_lpcg IMX_LPCG_CLK_5>;
> +		clock-names =3D "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
> +			      "usb3_ipg_clk", "usb3_core_pclk";
> +		assigned-clocks =3D <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
> +				  <&clk IMX_SC_R_USB_2=20
IMX_SC_PM_CLK_MISC>,
> +				  <&clk IMX_SC_R_USB_2=20
IMX_SC_PM_CLK_MST_BUS>;
> +		assigned-clock-rates =3D <125000000>, <12000000>,=20
<250000000>;
> +		power-domains =3D <&pd IMX_SC_R_USB_2>;
> +		status =3D "disabled";
> +
> +		usbotg3_cdns3: usb@5b120000 {
> +			compatible =3D "cdns,usb3";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			interrupt-parent =3D <&gic>;
> +			interrupts =3D <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 271=20
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 271=20
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 271=20
IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "host", "peripheral", "otg",=20
"wakeup";
> +			reg =3D <0x5b130000 0x10000>,     /* memory area=20
for HOST registers */
> +			      <0x5b140000 0x10000>,   /* memory area for=20
DEVICE registers */
> +			      <0x5b120000 0x10000>;   /* memory area for=20
OTG/DRD registers */
> +			reg-names =3D "xhci", "dev", "otg";
> +			phys =3D <&usb3_phy>;
> +			phy-names =3D "cdns3,usb3-phy";
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	usb3_phy: usb-phy@5b160000 {
> +		compatible =3D "nxp,salvo-phy";
> +		reg =3D <0x5b160000 0x40000>;
> +		clocks =3D <&usb3_lpcg IMX_LPCG_CLK_6>;
> +		clock-names =3D "salvo_phy_clk";
> +		power-domains =3D <&pd IMX_SC_R_USB_2_PHY>;
> +		#phy-cells =3D <0>;
> +		status =3D "disabled";
> +	};
> +
>  	/* LPCG clocks */
>  	sdhc0_lpcg: clock-controller@5b200000 {
>  		compatible =3D "fsl,imx8qxp-lpcg";
> @@ -234,4 +284,26 @@ usb2_lpcg: clock-controller@5b270000 {
>  		clock-output-names =3D "usboh3_ahb_clk",=20
"usboh3_phy_ipg_clk";
>  		power-domains =3D <&pd IMX_SC_R_USB_0_PHY>;
>  	};
> +
> +	usb3_lpcg: clock-controller@5b280000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x5b280000 0x10000>;
> +		#clock-cells =3D <1>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
> +				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>,
> +				<IMX_LPCG_CLK_6>, <IMX_LPCG_CLK_7>;
> +		clocks =3D <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
> +			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
> +			 <&conn_ipg_clk>,
> +			 <&conn_ipg_clk>,
> +			 <&conn_ipg_clk>,
> +			 <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
> +		clock-output-names =3D "usb3_app_clk",
> +				     "usb3_lpm_clk",
> +				     "usb3_ipg_clk",
> +				     "usb3_core_pclk",
> +				     "usb3_phy_clk",
> +				     "usb3_aclk";
> +		power-domains =3D <&pd IMX_SC_R_USB_2_PHY>;
> +	};
>  };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


