Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5978F6F5EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:08:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1AB6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:08:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puHpb-0005mD-Kq; Wed, 03 May 2023 21:08:03 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1puHpZ-0005aB-UM; Wed, 03 May 2023 21:08:01 +0200
Date:   Wed, 3 May 2023 21:08:01 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jun Li <jun.li@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andreas Henriksson <andreas@fatal.se>,
        Xu Yang <xu.yang_2@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add dual-role usb port1 support
Message-ID: <20230503190801.5glkm3n5sn5tvg7m@pengutronix.de>
References: <20230323105826.2058003-1-m.felsch@pengutronix.de>
 <PA4PR04MB964081F4DB2E16D8E300B08389849@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230327084947.dcguxgyo2lfen2ms@fatal.se>
 <DB9PR04MB96282C22D3AC853F325373CD898B9@DB9PR04MB9628.eurprd04.prod.outlook.com>
 <20230503184834.qln2wwvf3pgitkmp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503184834.qln2wwvf3pgitkmp@pengutronix.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-03, Marco Felsch wrote:
> Hi Li, Andreas,

...

> > Thanks for the advice.
> > 
> > *reuse* compatible = "gpio-sbu-mux"; can make the basic *function* work,
> > but that's not the right direction, SBU has its own signal in typec connector,
> > here what we need is the Super Speed signal switch, you can see iMX8MP EVK
> > use 2 GPIOs control the SS for 3 states(normal orientation, reserve orientation,
> > places all channels in high impedance state), but SBU will disable both channels
> > at TYPEC_STATE_USB, this is not correct for USB data, so logically we cannot
> > reuse SBU either. But I think this gpio-sbu-mux.c driver can be extended to
> > add support super speed signal orientation.
> 
> Thanks for the useful input :) I was dug into the usb-c hole and now I'm
> back. The "gpio-sbu-mux" should fit perfectly for our use-case, we only
> have to tell the driver to act as 'orientation-switch' only. All pieces
> are in place so just dts work to do. I will test my new patch and send a
> new version which should support super-speed to (fingers crossed).

Now I see problem you mentioned, let's see if we can extent the driver.
Sorry for the noise.

Regards,
  Marco
