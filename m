Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5A682FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjAaOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAaOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:55:21 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660747EC6;
        Tue, 31 Jan 2023 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675176920; x=1706712920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCSsrKUiuMN0+pRrbKoNsUmN5hp7qg+hDzz5qrL82eg=;
  b=H8RydCYkCNrQgWcdpBjytfnFtgwyMx9xJQjxBhsnkoZlm5iTQyKWlwu/
   Mv8f4wRchfUFhpKP9F5l2Gg497iS6YWizxnnSES0Qvw42E9EHdUPi/M+x
   u7+usqdfeBXqUrxxviMhGfkLACBGnn2aCJg5D9mw5MggAvt3KZD3yRZLu
   I8UjUGdxG+cP9xmcXcW+Xjnugn2mDNHOhB7NILEls7A/Os02UjQ3LnfA5
   xmDDW4Y4u08OKHItPOAxxqjvYt7W/fBixPyocsyxZKeTyCA2QaAI+5db+
   ulZYofc2Nvow6MbbDPuTUa+lppIeTR/VTvmMQkDGjTSorgq2OV6HJratk
   w==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28776003"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 31 Jan 2023 15:55:18 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 31 Jan 2023 15:55:18 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 31 Jan 2023 15:55:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1675176918; x=1706712918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCSsrKUiuMN0+pRrbKoNsUmN5hp7qg+hDzz5qrL82eg=;
  b=XrlB2kNLY8dkB0qyDIz1+b7kus5YjW9V2j80740zwasb67bBDQ2gyfoi
   bpB7ePn731qw0PyjNSkiSr5PhfLgpPUjdoNRPi/IuQDxtQOnQy1vMiWI2
   U7CESQBaz1BeY+wV2qRWepjVAckjirbkh2Cm/xWZa+1/vE98vzHxyYH4g
   RvJGSFT/2kF262uOWhyJ1YQreRhzznSHw7KJP8/6ROa8xOjj62uCZ4fcu
   93XOW/8PnP2PfMj9Pvsw3xQQaykcWrBwiNWC9RTVQqX32BU2G0AKdeiTO
   rfYICL0P/MMW0CDvGfXsFWD6iqJ+mTwzz1UIdJ0fJ0k7OpDYGxZWJzBj/
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669071600"; 
   d="scan'208";a="28776002"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 31 Jan 2023 15:55:17 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9AECF280056;
        Tue, 31 Jan 2023 15:55:17 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v5 05/10] arm64: dts: imx8qxp: add flexcan in adma
Date:   Tue, 31 Jan 2023 15:55:14 +0100
Message-ID: <3220805.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230126110833.264439-6-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com> <20230126110833.264439-6-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Donnerstag, 26. Januar 2023, 12:08:28 CET schrieb Marcel Ziswiler:
> From: Joakim Zhang <qiangqing.zhang@nxp.com>
> 
> Add FlexCAN decive in adma subsystem.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

On TQMa8XQP (i.MX8QXP) using flexcan1 and flexcan2:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Best regards,
Alexander

> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - New patch combining the following downstream patches:
>   commit e8fe3f57223a ("arm64: dts: imx8qxp: add FlexCAN in adma")
>   commit 4e90361f1ed3 ("arm64: dts: imx8qxp: add multi-pd support for
> CAN1/2") commit 899f516e61f8 ("arm64: dts: imx8: dma: fully switched to new
> clk binding") commit 8a28ca15a058 ("arm64: dts: imx8qxp: drop multi-pd for
> CAN device") commit c493402197dd ("arm64: dts: imx8: update CAN
> fsl,clk-source and fsl,scu-index property")
> 
>  .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi index
> 6ccf926b77a5..2dce8f2ee3ea 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -298,6 +298,65 @@ adc1: adc@5a890000 {
>  		status = "disabled";
>  	};
> 
> +	flexcan1: can@5a8d0000 {
> +		compatible = "fsl,imx8qm-flexcan";
> +		reg = <0x5a8d0000 0x10000>;
> +		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		clocks = <&can0_lpcg 1>,
> +			 <&can0_lpcg 0>;
> +		clock-names = "ipg", "per";
> +		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates = <40000000>;
> +		power-domains = <&pd IMX_SC_R_CAN_0>;
> +		/* SLSlice[4] */
> +		fsl,clk-source = /bits/ 8 <0>;
> +		fsl,scu-index = /bits/ 8 <0>;
> +		status = "disabled";
> +	};
> +
> +	flexcan2: can@5a8e0000 {
> +		compatible = "fsl,imx8qm-flexcan";
> +		reg = <0x5a8e0000 0x10000>;
> +		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		/* CAN0 clock and PD is shared among all CAN instances as
> +		 * CAN1 shares CAN0's clock and to enable CAN0's clock it
> +		 * has to be powered on.
> +		 */
> +		clocks = <&can0_lpcg 1>,
> +			 <&can0_lpcg 0>;
> +		clock-names = "ipg", "per";
> +		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates = <40000000>;
> +		power-domains = <&pd IMX_SC_R_CAN_1>;
> +		/* SLSlice[4] */
> +		fsl,clk-source = /bits/ 8 <0>;
> +		fsl,scu-index = /bits/ 8 <1>;
> +		status = "disabled";
> +	};
> +
> +	flexcan3: can@5a8f0000 {
> +		compatible = "fsl,imx8qm-flexcan";
> +		reg = <0x5a8f0000 0x10000>;
> +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		/* CAN0 clock and PD is shared among all CAN instances as
> +		 * CAN2 shares CAN0's clock and to enable CAN0's clock it
> +		 * has to be powered on.
> +		 */
> +		clocks = <&can0_lpcg 1>,
> +			 <&can0_lpcg 0>;
> +		clock-names = "ipg", "per";
> +		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates = <40000000>;
> +		power-domains = <&pd IMX_SC_R_CAN_2>;
> +		/* SLSlice[4] */
> +		fsl,clk-source = /bits/ 8 <0>;
> +		fsl,scu-index = /bits/ 8 <2>;
> +		status = "disabled";
> +	};
> +
>  	i2c0_lpcg: clock-controller@5ac00000 {
>  		compatible = "fsl,imx8qxp-lpcg";
>  		reg = <0x5ac00000 0x10000>;
> @@ -369,4 +428,17 @@ adc1_lpcg: clock-controller@5ac90000 {
>  				     "adc1_lpcg_ipg_clk";
>  		power-domains = <&pd IMX_SC_R_ADC_1>;
>  	};
> +
> +	can0_lpcg: clock-controller@5acd0000 {
> +		compatible = "fsl,imx8qxp-lpcg";
> +		reg = <0x5acd0000 0x10000>;
> +		#clock-cells = <1>;
> +		clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>,
> +			 <&dma_ipg_clk>, <&dma_ipg_clk>;
> +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>, 
<IMX_LPCG_CLK_5>;
> +		clock-output-names = "can0_lpcg_pe_clk",
> +				     "can0_lpcg_ipg_clk",
> +				     "can0_lpcg_chi_clk";
> +		power-domains = <&pd IMX_SC_R_CAN_0>;
> +	};
>  };




