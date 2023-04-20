Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D346E955C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDTNHU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDTNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:07:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6E40E7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:07:17 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ppTzu-0005Ar-MN; Thu, 20 Apr 2023 15:06:50 +0200
Message-ID: <f42a2a11c1a2df4d773b61a449e8f4d5a9a010d1.camel@pengutronix.de>
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane
 calculations
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Thu, 20 Apr 2023 15:06:45 +0200
In-Reply-To: <CAHCN7xK8K+DsNAFTVAezwJQzZ7RCDb2CjCBZ8dNb=S8d1BmtMA@mail.gmail.com>
References: <20230415104104.5537-1-aford173@gmail.com>
         <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
         <CAHCN7xL4+9NogrnXA1PEWorwY7JpSGBozDtHT83JvzjfinmS+A@mail.gmail.com>
         <CAHCN7xK8K+DsNAFTVAezwJQzZ7RCDb2CjCBZ8dNb=S8d1BmtMA@mail.gmail.com>
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

Hi Adam,

Am Mittwoch, dem 19.04.2023 um 05:47 -0500 schrieb Adam Ford:
> On Mon, Apr 17, 2023 at 6:55 AM Adam Ford <aford173@gmail.com> wrote:
> > 
> > On Mon, Apr 17, 2023 at 3:43 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > 
> > > Hi Adam,
> > > 
> > > Am Samstag, dem 15.04.2023 um 05:40 -0500 schrieb Adam Ford:
> > > > If there is more than one lane, the HFP, HBP, and HSA is calculated in
> > > > bytes/pixel, then they are divided amongst the different lanes with some
> > > > additional overhead. This is necessary to achieve higher resolutions while
> > > > keeping the pixel clocks lower as the number of lanes increase.
> > > > 
> > > 
> > > In the testing I did to come up with my patch "drm: bridge: samsung-
> > > dsim: fix blanking packet size calculation" the number of lanes didn't
> > > make any difference. My testing might be flawed, as I could only
> > > measure the blanking after translation from MIPI DSI to DPI, so I'm
> > > interested to know what others did here. How did you validate the
> > > blanking with your patch? Would you have a chance to test my patch and
> > > see if it works or breaks in your setup?
> 
> Lucas,
> 
> I tried your patch instead of mine.  Yours is dependent on the
> hs_clock being always set to the burst clock which is configured by
> the device tree.  I unrolled a bit of my stuff and replaced it with
> yours.  It worked at 1080p, but when I tried a few other resolutions,
> they did not work.  I assume it's because the DSI clock is fixed and
> not changing based on the pixel clock.  In the version I did, I only
> did that math when the lanes were > 1. In your patch, you divide by 8,
> and in mine, I fetch the bits-per-pixel (which is 8) and I divide by
> that just in case the bpp ever changes from 8.  Overall,  I think our
> patches basically do the same thing.

The calculations in your and my patch are quite different. I'm not
taking into account the number of lanes or the MIPI format. I'm basing
the blanking size purely on the ratio between MIPI DSI byte clock and
the DPI interface clock. It's quite counter-intuitive that the host
would scale the blanking to the number of lanes automatically, but
still require the MIPI packet offset removed, but that's what my
measurements showed to produce the correct blanking after translation
to DPI by the TC358767 bridge chip.

If you dynamically scale the HS clock, then you would need to input the
real used HS clock to the calculation in my patch, instead of the fixed
burst mode rate.

Regards,
Lucas
