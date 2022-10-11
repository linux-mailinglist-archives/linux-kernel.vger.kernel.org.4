Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09B5FB4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJKOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJKOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:47:41 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED8D95AC6F;
        Tue, 11 Oct 2022 07:47:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5A59A80F9;
        Tue, 11 Oct 2022 14:38:52 +0000 (UTC)
Date:   Tue, 11 Oct 2022 17:47:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0WCCw8k+KTuvdWX@atomide.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com>
 <Y0V99Agad6Ma+yTC@atomide.com>
 <Y0V/82JsRVZh6PlL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0V/82JsRVZh6PlL@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 14:30]:
> On Tue, Oct 11, 2022 at 05:30:12PM +0300, Tony Lindgren wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 13:57]:
> > > Hi Sebastian,
> > > 
> > > On Tue, Oct 11, 2022 at 02:37:26PM +0200, Sebastian Reichel wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
> > > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> > > > > > The LCD driver (panel-sony-acx565akm), when probing, starts with line
> > > > > > driven low, and then toggles it to high and keeps it there. Also, the
> > > > > > line is driven low when powering off the device, and ls released when
> > > > > > powering it back on. This means that the reset line should be described
> > > > > > as "active low" in DTS. This will be important when the driver is
> > > > > > converted to gpiod API which respects the polarity declared in DTS.
> > > > > 
> > > > > We should ensure these patches get merged together with the driver
> > > > > change to avoid breaking LCD for booting. Probably no need to have
> > > > > the driver quirk handling for inverted polartity in this case.
> > > > > 
> > > > > It's probably easiest to have an immutable branch for the driver
> > > > > changes I can base the dts changes on. Or I can ack the dts changes
> > > > > if they get merged with the driver.
> > > > 
> > > > Both drivers are already using gpiod API:
> > > > 
> > > > drivers/gpu/drm/panel/panel-sony-acx565akm.c
> > > > drivers/gpu/drm/panel/panel-dsi-cm.c
> > > 
> > > I was looking at
> > > 
> > > drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> > > drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> > 
> > Ah OK that explains :)
> > 
> > > which are not using gpiod. Should they be retired?
> > 
> > Yes we should just get rid of them with omapdrm working just fine.
> 
> Will you be submitting such patches? I'd like to get rid of
> of_get_named_gpio() and friends if I can...

Adding Tomi to Cc, my guess is he already has such patches and knows
better which ones can go :)

> > > > So this just breaks things.
> > > 
> > > I missed the drivers in drivers/gpu/... and I see that they essentially
> > > abuse gpiod API as gpiod_set_value() operates on logical level
> > > (active/inactive) and not absolute (high/low). They should either use
> > > the gpiod_*_raw() variants, or they should be adjusted to do the proper
> > > thing together with the accompanying DTS change.
> > > 
> > > What are your preferences?
> > 
> > Seems like high/low at the connected device end is what we should use,
> > right? Otherwise things will misbehave if the panel is connected to
> > some other SoC possibly.
> 
> It is exactly because of this case the driver should use active/inactive
> and follow polarity described in DTS. If the driver does:
> 
> 	gpiod_set_value_cansleep(d->reset, 1);
> 
> then if DTS is saying that the reset line is active low, under the wraps
> the line will be driven to "0", but if DTS is saying that the line is
> active high, then the very same call will drive the line to "1".
> 
> This allows accommodating different designs without having to change the
> driver code.

OK

Thanks,

Tony
