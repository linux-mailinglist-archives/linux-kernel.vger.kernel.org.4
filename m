Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9A7147D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjE2KSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2KSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:18:32 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F583;
        Mon, 29 May 2023 03:18:30 -0700 (PDT)
X-GND-Sasl: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685355509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUyuxrjpFgblrxgFyN4LMCGNQnaGs9nK3yiZjdqa8co=;
        b=WYgn5Ck9kYUjG7GNjHvlrUTvNj4ZRLgl/6yS3N9FTeXdb84PzexkAoXW8IEqTub+6vL9Ex
        yLUtkei6fEgTUbXslUME+CCT8bp0YgAdVw2hWZzWDft5/++89DAfHalIFUE+Wp/CDBe1UW
        M6WxT/c9T4aARy1DodOaCxuFaHd0nq5gpg66/Dm0I+9TOyF8IDelS3bZ/gmBV5JY1Tdolk
        IMmybcpc6d36NKGNu1h+IAmxPO4kuFYBawo/EvwbOiUnAAQyxmbKfVDJn/M+hhdshA28lb
        zTBZiBm4WN8hmK+Qp6pfHmowgZ0jRc3HW0sHemZ7SBivWeLVjSfuay1YOPfqcA==
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83341240005;
        Mon, 29 May 2023 10:18:27 +0000 (UTC)
Date:   Mon, 29 May 2023 12:18:25 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <20230529121825.71e9b6d6@booty>
In-Reply-To: <20230508151756.785ec07e@booty>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
        <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <20230505120618.2f4cf22c@booty>
        <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
        <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
        <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
        <20230508151756.785ec07e@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jun,

On Mon, 8 May 2023 15:17:56 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hello Jun, Francesco,
> 
> On Mon, 8 May 2023 13:17:11 +0200
> Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > On Sat, May 06, 2023 at 09:02:39AM +0000, Jun Li wrote:  
> > > > -----Original Message-----
> > > > From: Francesco Dolcini <francesco@dolcini.it>
> > > > Sent: Friday, May 5, 2023 7:00 PM
> > > > To: Luca Ceresoli <luca.ceresoli@bootlin.com>; Jun Li <jun.li@nxp.com>
> > > > Cc: Francesco Dolcini <francesco@dolcini.it>; devicetree@vger.kernel.org;
> > > > festevam@gmail.com; gregkh@linuxfoundation.org; kernel@pengutronix.de;
> > > > linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > > > peter.chen@nxp.com; robh+dt@kernel.org; s.hauer@pengutronix.de;
> > > > shawnguo@kernel.org; Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> > > > Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
> > > > 
> > > > On Fri, May 05, 2023 at 12:06:18PM +0200, Luca Ceresoli wrote:    
> > > > > On Fri, 5 May 2023 09:49:16 +0000
> > > > > Jun Li <jun.li@nxp.com> wrote:    
> > > > > > Is your board design similar like Francesco's as below?    
> > > > >
> > > > > Possibly, but I'm afraid I can't say: I am using the Toradex Colibri
> > > > > i.MX6ULL SoM, whose schematics are not public.    
> > > > 
> > > > I can confirm that it's the same.    
> > > 
> > > Thanks Francesco for the confirmation, had a check with design team,
> > > there is no status bit which can be used to judge the VDD_USB_CAP is
> > > powered or not, so we have to add a board level dts property to tell
> > > this usb phy driver to bypass MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS.
> > > 
> > > Before send a formal patch, I want to confirm this should work for your
> > > HW design, like below simple hack:    
> > 
> > Thanks Li Jun, I tested it with v6.3.1 kernel and it's all good.
> > I would be happy to test the patch as soon as you send it.  
> 
> Thanks Jun, it works here as well, on 6.1.27!

Have you managed to make progress on the patch after Francesco's and my
tests?

As I see it, a proper fix for mainline could be as simple as a new DT
property to describe this specific hardware configuration and a patch
to ignore the flag when the property is present. Is my understanding
correct?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
