Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE666694C31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBMQQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBMQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:16:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A145E1CF69
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:15:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pRbUb-0002fq-Ro; Mon, 13 Feb 2023 17:15:49 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pRbUa-0007N9-T7; Mon, 13 Feb 2023 17:15:48 +0100
Date:   Mon, 13 Feb 2023 17:15:48 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Message-ID: <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213155833.1644366-7-frieder@fris.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

thanks for the patch.

On 23-02-13, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This fixes the LDO5 regulator handling of the pca9450 driver by
> taking the status of the SD_VSEL into account to determine which
> configuration register is used for the voltage setting.
> 
> Even without this change there is no functional issue, as the code
> for switching the voltage in sdhci.c currently switches both, the
> VSELECT/SD_VSEL signal and the regulator voltage at the same time
> and doesn't run into an invalid corner case.
> 
> We should still make sure, that we always use the correct register
> when controlling the regulator. At least in U-Boot this fixes an
> actual bug where the wrong IO voltage is used.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 6 +++---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts       | 6 +++---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   | 1 +
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi      | 1 +
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
> index 8b16bd68576c..bdcd9cd843c7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
> @@ -344,7 +344,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>  		>;
>  	};
>  
> @@ -357,7 +357,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>  		>;
>  	};
>  
> @@ -370,7 +370,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>  		>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> index a079322a3793..ba2a4491cf31 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
> @@ -321,7 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>  		>;
>  	};
>  
> @@ -334,7 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>  		>;
>  	};
>  
> @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0

The VSELECT pin should be driven by the (u)sdhc core...

>  		>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> index 5172883717d1..90daaf54e704 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
>  				regulator-name = "NVCC_SD (LDO5)";
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <3300000>;
> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;

and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
muxed as GPIO, which is not the case. So I think that u-boot have a bug
within the (u)sdhc core.

Regards,
  Marco

>  			};
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> index 1f8326613ee9..7468a8aa771d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
> @@ -195,6 +195,7 @@ reg_nvcc_sd: LDO5 {
>  				regulator-name = "NVCC_SD (LDO5)";
>  				regulator-min-microvolt = <1800000>;
>  				regulator-max-microvolt = <3300000>;
> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>  			};
>  		};
>  	};
> -- 
> 2.39.1
> 
> 
> 
