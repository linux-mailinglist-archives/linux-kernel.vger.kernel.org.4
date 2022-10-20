Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F995605E65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJTLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiJTLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:03:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6B1CBAB9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:03:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTKE-0004VL-Qb; Thu, 20 Oct 2022 13:02:58 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTKD-0003RO-No; Thu, 20 Oct 2022 13:02:57 +0200
Date:   Thu, 20 Oct 2022 13:02:57 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Message-ID: <20221020110257.5ojjq2j2c53hevnt@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221020095934.1659449-4-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 22-10-20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per PCA9450C datasheet, the voltage range as below:
> BUCK1 0.6 - 2.1875
> BUCK2 0.6 - 2.1875
> BUCK4 0.6 - 3.4
> BUCK5 0.6 - 3.4
> BUCK6 0.6 - 3.4
> 
> LDO1 1.6-1.9, 3.0-3.3
> LDO2 0.8 – 1.15
> LDO3 0.8 - 3.3
> LDO4 0.8 - 3.3
> LDO5 1.8 - 3.3
> 
> So correct them, and also add LDO[2,4]

In the DTS you specify voltage constraints for a specific hardware and
not the one supported by the PMIC. What the PMIC supports (min/max) is
specified within the driver.

Regards,
  Marco

> 
> Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 +++++++++++++-------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index b4c1ef2559f2..a4cddc5a8620 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -248,8 +248,8 @@ pmic@25 {
>  		regulators {
>  			BUCK1 {
>  				regulator-name = "BUCK1";
> -				regulator-min-microvolt = <720000>;
> -				regulator-max-microvolt = <1000000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> @@ -257,8 +257,8 @@ BUCK1 {
>  
>  			reg_arm: BUCK2 {
>  				regulator-name = "BUCK2";
> -				regulator-min-microvolt = <720000>;
> -				regulator-max-microvolt = <1025000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> @@ -268,40 +268,56 @@ reg_arm: BUCK2 {
>  
>  			BUCK4 {
>  				regulator-name = "BUCK4";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3600000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
>  
>  			BUCK5 {
>  				regulator-name = "BUCK5";
> -				regulator-min-microvolt = <1650000>;
> -				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
>  
>  			BUCK6 {
>  				regulator-name = "BUCK6";
> -				regulator-min-microvolt = <1045000>;
> -				regulator-max-microvolt = <1155000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
>  
>  			LDO1 {
>  				regulator-name = "LDO1";
> -				regulator-min-microvolt = <1650000>;
> -				regulator-max-microvolt = <1950000>;
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1150000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
>  
>  			LDO3 {
>  				regulator-name = "LDO3";
> -				regulator-min-microvolt = <1710000>;
> -				regulator-max-microvolt = <1890000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
> -- 
> 2.37.1
> 
> 
> 
