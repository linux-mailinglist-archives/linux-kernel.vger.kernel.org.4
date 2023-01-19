Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A507674772
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjASXwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjASXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:52:07 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E29F398;
        Thu, 19 Jan 2023 15:52:04 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD2D2240003;
        Thu, 19 Jan 2023 23:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674172323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoYj7soWc4efzFRwg0HwkO/RREKv/HkGYPmHsNZ+ugg=;
        b=d+y5aB5liVdDMNs7xy/6ser1eaS/Q+e/szVENUA6+MN/ibCLTHG1X49FjOax+oSxE7mRq2
        4j1OwduPkI86qwr1fL+L1LPsBVD8u02UGU9xMt8QZ/7L314Z+XL6sPsXFTFDPiTLt7bjtn
        xstpFREEmVXK5iaI2lXD0VINT71EVT1rkBWEVHiIpU1gmhRtjF8NSMNPckNGb9oiDWsKSo
        ty/LbAD6z4dcbIMSNzCyerTVOdgIVWHPpcyrak7pcPjJf5mgpGtP/8uUaczX2J7Y3k4MjH
        A+DHST1lpvP80rsurh5g3iXwZETlIY41FZOQsqx6YpJswprAZVRiGi28pb3p2A==
Date:   Fri, 20 Jan 2023 00:52:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dennis Lambe <dennis@sparkcharge.io>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance
 from DT
Message-ID: <Y8nXoZjco8uIrtFJ@mail.local>
References: <20230119213903.899756-1-dennis@sparkcharge.io>
 <Y8nBloQfBPK3t5ce@mail.local>
 <CAKYiA1Dr0TAmsqDf1wMeeysN4N8K+KJL6onCgQL98LVV5L7Vmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYiA1Dr0TAmsqDf1wMeeysN4N8K+KJL6onCgQL98LVV5L7Vmg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 18:27:44-0500, Dennis Lambe wrote:
> On Thu, Jan 19, 2023 at 5:18 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> 
> > I need to find time to think about it because while setting the analog
> > trimming statically from the device tree solves your immediate problem,
> > it will also remove the possibility to handle it from userspace later
> > on. I would really prefer this uses the offset interface or a better
> > interface that unfortunately doesn't exist yet.
> 
> Thanks for letting me know what you're thinking about this. I think I
> see what you're getting at.
> 
> However, I think this is more complex than either of us had
> considered. The M41T82 has two different calibration capabilities:
> 
> 1. Digital calibration. This looks to me like it behaves similarly to
> the digital calibration feature of the M41T00, which ds1307.c exposes
> through the offset interface. The M41T8x driver doesn't currently
> expose the digital calibration register at all, but if it did I would
> agree that the offset interface looks appropriate.
> 
> 2. Analog calibration -- that's what the datasheet calls it, but the
> range on it is very big -- 3.5 pF all the way up to 17.4 pF -- and
> their reference design uses it as the only xtal load capacitance in
> the circuit. Most of the values you could set for this would be wildly
> inappropriate for any given design's choice of xtal oscillator.
> 
> Between these, I don't know if you'd want to expose just one, the
> other, or some synthesis of both via the offset interface or some new
> interface.
> 
> I'd make the case that the xtal's required load capacitance is a
> hardware requirement that's appropriate to configure via the Device
> Tree. Even if you did want to allow some amount of runtime fine-tuning
> of this register, you'd still want to document a rational starting
> value chosen based on the hardware.
> 
> I agree with you, though, that if a runtime fine-tuning feature were
> added, we'd have to find a way to choose whether to initialize the
> register on boot or not, so that we didn't overwrite the fine-tuning.
> 
> Just to demonstrate something that could work, and would be
> backward-compatible with this patchset, here's a hypothetical design:
> * dt-bindings: add quartz-load-femtofarad-tuning-min and
> quartz-load-femtofarad-tuning-max
> * Limit run-time tuning adjustments to be within that range
> * Only overwrite the analog calibration register on start-up if its
> value is outside that range
> 
> After thinking through all this, I'd still advocate for merging this
> patchset in some form and leaving integration with runtime APIs as a
> potential future enhancement. I look forward to hearing your thoughts
> about it.

I specifically referred to analog trimming in my reply because I knew it
could do digital trimming and I also said that we will probably need a
new interface for this.
The main existing issue is that the register changes the capacitance but
the datasheet doesn't give the actual effect in ppm which doesn't
integrate well with the existing userspace tooling.

I advocate against merging as is without more thought because changing
anything later will mean breaking the DT ABI and this is not allowed.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
