Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2C607391
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJUJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJUJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:10:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2F1EAD8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:09:20 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olo1f-00031B-Cg; Fri, 21 Oct 2022 11:09:11 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olo1e-0002Kv-N3; Fri, 21 Oct 2022 11:09:10 +0200
Date:   Fri, 21 Oct 2022 11:09:10 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
Message-ID: <20221021090910.zkijqqt6mpukzqdp@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-6-peng.fan@oss.nxp.com>
 <20221020110723.udftsfrfdnghudto@pengutronix.de>
 <7ede9de4-75ba-6ebf-60a3-fee98e050ea9@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ede9de4-75ba-6ebf-60a3-fee98e050ea9@oss.nxp.com>
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

On 22-10-21, Peng Fan wrote:
> Hi Marco,
> 
> On 10/20/2022 7:07 PM, Marco Felsch wrote:
> > Hi Peng,
> > 
> > On 22-10-20, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > Enable uart1/3 ports for evk board.
> > > 
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >   arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
> > >   1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > index 2e29bb3c041c..366f709f8790 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > > @@ -428,6 +428,15 @@ &snvs_pwrkey {
> > >   	status = "okay";
> > >   };
> > > +&uart1 { /* BT */
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_uart1>;
> > > +	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
> > > +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> > 
> > I'm curious, what is the default parent and why is this wrong? For the
> > already exisiting uart2 we don't do that. Same applies for uart3.
> 
> The default parent is OSC_24M. The uart2 is for console, so 24M is ok.
> As I recall, we met issue 24M not able to get higher baudrate.

What did you mean by higher baudrate, is it everything > 115200? When
the console baudrates can be fullfilled with the PLL1_80M as well
wouldn't it be worth to fix the imx8mp.dtsi instead?

Regards,
  Marco
