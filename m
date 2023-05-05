Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81DE6F808C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjEEKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEEKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:06:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB0199D;
        Fri,  5 May 2023 03:06:24 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 394D41C000B;
        Fri,  5 May 2023 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683281183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9a6n7DwxZclGXMi3qvsG0oZbkEqa2URoW/Q1gWp3eig=;
        b=L9RcZyhKswX31T7f9QBhd8sR7VkQlmtGRM7fC4zdmhlkD1h9JjVmqTjwgkaNq+4GnBSNA3
        Teb010QpYvH6ycpVHUVSCvYkxaS/fvvjnG0LlMg+32jBeHAXgjaTgUMsGFE0M02b8O2CIi
        d3ZNYmT+Ywc78TBke0IXkmo/h+bUqxMTi20rDNx4l+IydrD1j3N99gn9UEZNs8mLbalDYu
        RHp6mgKMQ/f2ltydN5Px5PPnqZfi2FZDKlwFYVR8792QSoYCDLYv8bt9w3HFOd5ah49C8U
        o0FpU0i80D2J0xYOQ2ADi3Xta6W7Qj1KJgTS2pLYx9FAPISx7tjkzWVldQpHcA==
Date:   Fri, 5 May 2023 12:06:18 +0200
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
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <20230505120618.2f4cf22c@booty>
In-Reply-To: <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
        <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
        <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jun,

On Fri, 5 May 2023 09:49:16 +0000
Jun Li <jun.li@nxp.com> wrote:

> > -----Original Message-----
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Friday, May 5, 2023 12:50 AM
> > To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Cc: devicetree@vger.kernel.org; festevam@gmail.com;
> > gregkh@linuxfoundation.org; Jun Li <jun.li@nxp.com>;
> > kernel@pengutronix.de; linux-arm-kernel@lists.infradead.org;
> > dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
> > linux-usb@vger.kernel.org; peter.chen@nxp.com; robh+dt@kernel.org;
> > s.hauer@pengutronix.de; shawnguo@kernel.org; Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>
> > Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
> >
> > Hello Luca,
> > I guess your mail to Philippe bounced, let me try to answer since I am aware
> > of the issue here.
> >
> > On Thu, May 04, 2023 at 06:23:12PM +0200, Luca Ceresoli wrote:  
> > > I found this thread after several hours spent in debugging why USB host  
> > is  
> > > not detecting new devices on a custom board using the iMX6ULL Colibri
> > > SoM.
> > >
> > > My best workaround at the moment is:  
> > We have the same workaround in our BSP since quite some time, see
> > https://git.t/
> > oradex.com%2Fcgit%2Fmeta-toradex-bsp-common.git%2Ftree%2Frecipes-kernel
> > %2Flinux%2Flinux-toradex-mainline-git%2F0002-drivers-chipidea-disable-r
> > untime-pm-for-imx6ul.patch&data=05%7C01%7Cjun.li%40nxp.com%7C776dc1e71a
> > 554ee20ed908db4cbfa5aa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > 188158228795706%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> > uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3cFsUurgKBfic
> > LNfRxMOErukGiMczhJREFGvaFYTH34%3D&reserved=0
> >  
> > > I haven't found any follow-up patches from you, so I'm wondering whether
> > > you have made any progress on this issue.  
> > You can find the latest discussion on that regard here
> > https://lore/.
> > kernel.org%2Fall%2FY1vLpaxpc5WBCuGD%40francesco-nb.int.toradex.com%2F&d
> > ata=05%7C01%7Cjun.li%40nxp.com%7C776dc1e71a554ee20ed908db4cbfa5aa%7C686
> > ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638188158228795706%7CUnknown%7C
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C3000%7C%7C%7C&sdata=xgIAlY5Az9zQgOBaUTHeGJDXNIyNRmEBlcR49JOVB
> > sI%3D&reserved=0
> >  
> > > As I see it, a quirk in the driver would make sense.  
> > I am not sure.
> >
> > The reason this is not working is that the VBUS is not directly
> > connected to the SOC and the USB IP is powered in a different way (all
> > of that was reviewed/acked by NXP when the board was designed).  
> 
> Hi Luca,
> 
> Is your board design similar like Francesco's as below?

Possibly, but I'm afraid I can't say: I am using the Toradex Colibri
i.MX6ULL SoM, whose schematics are not public.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
