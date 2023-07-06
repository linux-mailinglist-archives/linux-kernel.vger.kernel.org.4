Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C774976D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGFIYT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:24:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CE130
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:24:16 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qHKHH-0004UP-82; Thu, 06 Jul 2023 10:23:51 +0200
Message-ID: <0125c54fd1617f3f945bc3f4bbef5b914b701c24.camel@pengutronix.de>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid
 at etm nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Date:   Thu, 06 Jul 2023 10:23:48 +0200
In-Reply-To: <9405224.NyiUUSuA9g@steina-w>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
         <9405224.NyiUUSuA9g@steina-w>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Am Donnerstag, dem 06.07.2023 um 07:06 +0200 schrieb Alexander Stein:
> Hi Frank,
> 
> Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
> > The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
> > leads to a crash when calling amba_read_periphid().  After corrected reg
> > size, amba_read_periphid() retrieve the correct periphid.
> > arm,primecell-periphid were removed from the etm nodes.
> 
> So this means the reference manual is wrong here? It clearly states the size 
> is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
> On a side note: Is imx8mq affected by this as well? The DAP memory table lists 
> similar sizes in the RM .
> 
Note that the 64K MMIO space per device is really an alignment thing.
It's a recommendation from ARM to allow individual device MMIO regions
to be mapped on kernels with 64K page size. Most of the time the real
MMIO space occupied by the device is actually much smaller than 64K.

Regards,
Lucas

> Best regards,
> Alexander
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> > cc406bb338fe..e0ca82ff6f15 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -306,8 +306,7 @@ soc: soc@0 {
> > 
> >  		etm0: etm@28440000 {
> >  			compatible = "arm,coresight-etm4x", 
> "arm,primecell";
> > -			reg = <0x28440000 0x10000>;
> > -			arm,primecell-periphid = <0xbb95d>;
> > +			reg = <0x28440000 0x1000>;
> >  			cpu = <&A53_0>;
> >  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
> >  			clock-names = "apb_pclk";
> > @@ -323,8 +322,7 @@ etm0_out_port: endpoint {
> > 
> >  		etm1: etm@28540000 {
> >  			compatible = "arm,coresight-etm4x", 
> "arm,primecell";
> > -			reg = <0x28540000 0x10000>;
> > -			arm,primecell-periphid = <0xbb95d>;
> > +			reg = <0x28540000 0x1000>;
> >  			cpu = <&A53_1>;
> >  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
> >  			clock-names = "apb_pclk";
> > @@ -340,8 +338,7 @@ etm1_out_port: endpoint {
> > 
> >  		etm2: etm@28640000 {
> >  			compatible = "arm,coresight-etm4x", 
> "arm,primecell";
> > -			reg = <0x28640000 0x10000>;
> > -			arm,primecell-periphid = <0xbb95d>;
> > +			reg = <0x28640000 0x1000>;
> >  			cpu = <&A53_2>;
> >  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
> >  			clock-names = "apb_pclk";
> > @@ -357,8 +354,7 @@ etm2_out_port: endpoint {
> > 
> >  		etm3: etm@28740000 {
> >  			compatible = "arm,coresight-etm4x", 
> "arm,primecell";
> > -			reg = <0x28740000 0x10000>;
> > -			arm,primecell-periphid = <0xbb95d>;
> > +			reg = <0x28740000 0x1000>;
> >  			cpu = <&A53_3>;
> >  			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
> >  			clock-names = "apb_pclk";
> 
> 

