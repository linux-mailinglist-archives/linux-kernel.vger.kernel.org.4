Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF46881A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBBPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBBPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:22:04 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD65FED;
        Thu,  2 Feb 2023 07:22:02 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EDF5020008;
        Thu,  2 Feb 2023 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675351320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XNx1XchKzZSpJj1ujuH5U8jbslu3IqnhbHCw5cDW5jA=;
        b=H4oDQ+Rr6ysWLSLtwPnOshk7gxyK4XPM8IhyHwwekTj89qge2tw0MGZKE2yyxZmoXIF3aI
        d2jyqmfARSMb9Px1aT4/kcyggNP5xc8QxbN/ejBPJX8mQSWIHr61pm9L42+/zt0TdAqllZ
        VG1SbAHJFYqWlN0WvhjCvfdZB0dQJ6P4ONDtCYVj7Puxgnvk9S33bYez3XyKbq3ioL8hoC
        ThE2ituKWy0IrzYunOJsC3WnKlkVUJKZAoGLm54qkrU9Naqj8NnUdocTSIUzlt+vy7sh16
        Oq9laYHpnjbQICtGKwFipH+TW49NsSrQcK15IimUGekqKnubwY851Kf+bbW2dQ==
Date:   Thu, 2 Feb 2023 16:21:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] rtc: pm8xxx: add support for nvmem offset
Message-ID: <Y9vVFtoIXglQpplh@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-17-johan+linaro@kernel.org>
 <Y9PpQkW3Rtm+bi2V@mail.local>
 <Y9Py/+GpI8x8ldDG@hovoldconsulting.com>
 <Y9P2L9sNiHIZt3On@mail.local>
 <Y9vS4TpVHDnGN0G/@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vS4TpVHDnGN0G/@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 16:12:33+0100, Johan Hovold wrote:
> On Fri, Jan 27, 2023 at 05:05:03PM +0100, Alexandre Belloni wrote:
> > On 27/01/2023 16:51:27+0100, Johan Hovold wrote:
> 
> > > > > @@ -380,9 +478,23 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
> > > > >  	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
> > > > >  						      "allow-set-time");
> > > > >  
> > > > > +	rtc_dd->nvmem_cell = devm_nvmem_cell_get(&pdev->dev, "offset");
> > > > 
> > > > Maybe we should get something more specific than just "offset" so this
> > > > could be parsed in the RTC core at some point (this is the second RTC to
> > > > behave like this)
> > > 
> > > Yes, that thought crossed my mind, but it's an nvmem cell name (label)
> > > and not a generic devicetree property. If you look at the binding
> > > document I think the name makes sense given the current description, and
> > > I'm not sure changing to something like 'base' would be much of an
> > > improvement.
> > > 
> > > I also don't expect there to be more broken RTCs out there like these
> > > ones. Hopefully Qualcomm will even get this fixed at some point
> > > themselves.
> > > 
> > > And I assume you were think of the old Atmel driver which uses a timer
> > > counter and a scratch register as a base? That one is also a bit
> > > different in that the timer can be reset, just not set.
> > 
> > Nope, I'm thinking about the gamecube one and probably the nintendo
> > switch one which seems to behave similarly (no driver in the kernel
> > though).
> 
> Found the gamecube one now (misread you comment above to imply that it
> was also out of tree).
> 
> That one is also different in that the timer in that RTC can also be
> set (e.g. like the atmel one), but for consistency with some firmware an
> offset also needs to be read from SRAM (not NVRAM) and applied. That
> offset is also never updated by Linux.

Yeah, I deally, the gamecube counter shouldn't be updated, the switch
one doesn't seem to be updatable. I guess the idea being that games need
to be able to know if you are messing with the RTC to get an advantage.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
