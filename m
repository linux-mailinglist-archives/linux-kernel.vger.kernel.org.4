Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA86E5C65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDRIrk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDRIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:47:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045F3AA2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:47:36 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pogza-0008QK-48; Tue, 18 Apr 2023 10:47:14 +0200
Message-ID: <426e901f14254cfcff87ba1747534f9b856ef738.camel@pengutronix.de>
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        m.szyprowski@samsung.com, Robert Foss <rfoss@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 18 Apr 2023 10:47:07 +0200
In-Reply-To: <56085a0f-02f7-6f45-f351-1f9ee612b748@denx.de>
References: <20230415104104.5537-1-aford173@gmail.com>
         <20230415104104.5537-3-aford173@gmail.com>
         <7eed74e8-9f67-a410-3cec-f61a6db85238@denx.de>
         <CAHCN7xKw26TQ=t75TEDbEkA0mb9rnEwNW=7ei1=WFBZjiJMf=g@mail.gmail.com>
         <56085a0f-02f7-6f45-f351-1f9ee612b748@denx.de>
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

Am Dienstag, dem 18.04.2023 um 10:30 +0200 schrieb Marek Vasut:
> On 4/18/23 04:29, Adam Ford wrote:
> > On Sun, Apr 16, 2023 at 5:08 PM Marek Vasut <marex@denx.de> wrote:
> > > 
> > > On 4/15/23 12:41, Adam Ford wrote:
> > > > Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
> > > > having an entry in the device tree for samsung,pll-clock-frequency.
> > > > 
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > ---
> > > >    drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
> > > >    1 file changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > index 9fec32b44e05..73f0c3fbbdf5 100644
> > > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > > @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
> > > >        struct device_node *node = dev->of_node;
> > > >        int ret;
> > > > 
> > > > -     ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
> > > > -                                    &dsi->pll_clk_rate);
> > > > -     if (ret < 0)
> > > > -             return ret;
> > > > -
> > > >        ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
> > > >                                       &dsi->burst_clk_rate);
> > > >        if (ret < 0)
> > > 
> > > Does this break compatibility with old samsung DTs ?
> > 
> > My goal here was to declutter the device tree stuff and fetch data
> > automatically if possible. What if I changed this to make them
> > optional?  If they exist, we can use them, if they don't exist, we
> > could read the clock rate.  Would that be acceptable?
> 
> If you do not see any potential problem with ignoring the DT property 
> altogether, that would be better of course, but I think you cannot do 
> that with old DTs, so you should retain backward compatibility fallback, 
> yes. What do you think ?

I'm very much in favor of this patch, but I also think we shouldn't
risk breaking Samsung devices, where we don't now 100% that the input
clock rate provided by the clock driver is correct.

So I think the right approach is to use "samsung,pll-clock-frequency"
when present in DT and get it from the clock provider otherwise. Then
just remove the property from the DTs where we can validate that the
input clock rate is correct, i.e. all i.MX8M*.

Regards,
Lucas
