Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC19362952E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiKOKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiKOKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:02:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359823BEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:02:54 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousmK-0001Jx-58; Tue, 15 Nov 2022 11:02:52 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ousmJ-0006wI-P5; Tue, 15 Nov 2022 11:02:51 +0100
Date:   Tue, 15 Nov 2022 11:02:51 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Message-ID: <20221115100251.7hwpnodgxzirgpw6@pengutronix.de>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
 <20221115091709.2865997-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115091709.2865997-8-peng.fan@oss.nxp.com>
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

On 22-11-15, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
> and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
> BUCK2 is for A53, which is handled by DVFS, so no need dvs property.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index 4eb467df5ba7..a5a7d74ec1d5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -47,6 +47,8 @@ buck1: BUCK1{
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <950000>;

One last question on this. According the schematic the max should be
0.88/0.945V and you are going to set it to 0.950V.

According the driver the nxp,dvs-run-voltage is just the same as the
normal regulator voltage. So I would suggest to just use the
nxp,dvs-standby-voltage property to enable the DVS feature since the run
voltage is already handled by the
regulator-min-microvolt/regulator-max-microvolt. So it would be just:

> +				nxp,dvs-standby-voltage = <750000>;

Regards,
  Marco

>  			};
>  
>  			buck2: BUCK2 {
> @@ -56,8 +58,6 @@ buck2: BUCK2 {
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> -				nxp,dvs-run-voltage = <950000>;
> -				nxp,dvs-standby-voltage = <850000>;
>  			};
>  
>  			buck4: BUCK4{
> -- 
> 2.37.1
> 
> 
> 
