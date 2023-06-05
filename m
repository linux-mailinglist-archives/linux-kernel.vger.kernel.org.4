Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD29721B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 02:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjFEARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 20:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEARr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 20:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9368CC;
        Sun,  4 Jun 2023 17:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630EA60F1A;
        Mon,  5 Jun 2023 00:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681DFC433D2;
        Mon,  5 Jun 2023 00:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685924264;
        bh=Zs6jqBTfPSCRUeatCIGSWI6VZKKS80cfuK2pqFhs6UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHNvpo5UYRn2fUo9z38jlZbp5GYUlT2nx3pspRK1qZpEs5A41l6/cTPER0kmIgD9t
         jKvwbsiSb+9fKIqOPdL0ycU97IVAw5+bS1ywPmBSql+2OHUKpYLmw25tA3pcbihMWA
         IFDpaPixdYyV+PSvQaqBQFSxvH5w7ogX++x6XMA3UXaQ/elkr9EedHedXm/Ci5Mfr7
         UblrolIo7UvA9mp8Rpz8MdqZHkFwiq+00wT4fdahUK9irGzy9XsynCD3DYfseQpnNj
         whotXa41OcQhf6C8Bs6OEizl+kjL4uZ+vx2+RX2RPGbEJ8gGyqHQakCVGkVYA+KHqf
         vsvbcKpjl8+MA==
Date:   Mon, 5 Jun 2023 08:17:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn-beacon: Add HDMI video with sound
Message-ID: <20230605001730.GS4199@dragon>
References: <20230601031527.271232-1-aford173@gmail.com>
 <20230601031527.271232-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601031527.271232-2-aford173@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:15:25PM -0500, Adam Ford wrote:
> The Beacon Embedded imx8mn development kit has a DSI
> to HDMI bridge chip.  The bridge supports stereo audio
> and hot-plugging.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> index 1392ce02587b..3758c46c7162 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> @@ -16,4 +16,138 @@ / {
>  	chosen {
>  		stdout-path = &uart2;
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&adv7535_out>;
> +			};
> +		};
> +	};
> +
> +	reg_hdmi: regulator-hdmi-dvdd {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_hdmi>;
> +		compatible = "regulator-fixed";

Can we start properties from 'compatible'?

> +		regulator-name = "hdmi_pwr_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <70000>;
> +		regulator-always-on;
> +	};
> +
> +	sound-hdmi {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "sound-hdmi";
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai5 0>;
> +			system-clock-direction-out;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&adv_bridge>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	adv_bridge: hdmi@3d {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hdmi_bridge>;
> +		compatible = "adi,adv7535";

Same here.

Shawn

> +		reg = <0x3d>, <0x3b>;
> +		reg-names = "main", "cec";
> +		adi,dsi-lanes = <4>;
> +		adi,fixed-lanes;
> +		dvdd-supply = <&reg_hdmi>;
> +		v3p3-supply = <&reg_hdmi>;
> +		v1p2-supply = <&reg_hdmi>;
> +		a2vdd-supply = <&reg_hdmi>;
> +		avdd-supply = <&reg_hdmi>;
> +		pvdd-supply = <&reg_hdmi>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +		#sound-dai-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				adv7535_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				adv7535_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&lcdif {
> +	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
> +	assigned-clock-rates = <594000000>;
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,esc-clock-frequency = <20000000>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			dsi_out: endpoint {
> +				remote-endpoint = <&adv7535_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&sai5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai5>;
> +	assigned-clocks = <&clk IMX8MN_CLK_SAI5>;
> +	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_hdmi_bridge: hdmibridgegrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_hdmi: reghdmigrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11              0x16
> +		>;
> +	};
> +
> +	pinctrl_sai5: sai5grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0	0xd6
> +			MX8MN_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK	0xd6
> +			MX8MN_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC	0xd6
> +		>;
> +	};
>  };
> -- 
> 2.39.2
> 
