Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7C6062A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJTOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:14:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDC186793
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:14:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olWJ0-0002IF-Qs; Thu, 20 Oct 2022 16:13:54 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olWJ0-0006xn-2h; Thu, 20 Oct 2022 16:13:54 +0200
Date:   Thu, 20 Oct 2022 16:13:54 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/15] arm64: dts: imx8m[m, p]-evk: change to use
 off-on-delay-us in regulator
Message-ID: <20221020141354.jxyycnt3nzm7frcr@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-15-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020095934.1659449-15-peng.fan@oss.nxp.com>
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

On 22-10-20, Peng Fan (OSS) wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> After commit f7907e57aea2 ("regulator: fixed: add off-on-delay"), user
> can use "off-on-delay-us" to define the regulator off-delay time.
> 
> For SD card, according to the spec requirement, for sd card power reset
> operation, it need sd card supply voltage to be lower than 0.5v and keep
> over 1ms, otherwise, next time power back the sd card supply voltage to
> 3.3v, sd card can't support SD3.0 mode again.
> 
> This patch add the off-on-delay-us to each board, make sure the sd power
> reset behavior is align with the specification. Without this patch, when
> do quick system suspend/resume test, some sd card can't work at SD3.0 mode
> after system resume back.

Please mention that the real issue which is a capicity which gets
unloaded to slow. Please see the u-boot commit for this which explains
it better IMHO.

Regards,
  Marco


> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index c93387fcd498..898735965ac9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -22,7 +22,7 @@ reg_sd1_vmmc: sd1_regulator {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> -		off-on-delay = <20000>;
> +		off-on-delay-us = <20000>;
>  		startup-delay-us = <100>;
>  		enable-active-high;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index ce450965e837..fdbcd2483efc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -56,6 +56,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
>  		enable-active-high;
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 82387b9cb800..07d9fb2aacf8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -46,6 +46,7 @@ reg_usdhc2_vmmc: regulator-vsd-3v3 {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <20000>;
>  		enable-active-high;
>  	};
>  
> -- 
> 2.37.1
> 
> 
> 
