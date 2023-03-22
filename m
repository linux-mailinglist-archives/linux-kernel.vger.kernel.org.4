Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C596C5960
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:19:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9835B5;
        Wed, 22 Mar 2023 15:19:04 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3862A1BF207;
        Wed, 22 Mar 2023 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679523543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mjbfAka6B37e0KLGUhxUpe2dBgCPhl+V2vV2LCTJ5E=;
        b=BOJeM2ybRH5eO7IdR+XNOl1FwdIrfDZl8WJBfo05uMnsQ68RwMvKvYWarJNDKZQ/qFk5RQ
        iujueB5qtsuYAv9VKqSMoMoifOcac5tHFuuPw/gA5zZqsKqKNhq5I/rbAqOsHKx9Ucz5e6
        lOBvt3FfXcvcLX5HlnhedHCSVGthILVGJ3LrzWiVe64VPPZa1VuM2SVuujaucHV+iGupCb
        d11/XmzV6bcNets90AKh08DthMaYyJxs0V1SaR17bFGlVVE0Arc7fk0xE05fKdR1uY8/T4
        gv/OB2jEH0Awmzp5ZK8pgzjFkJcTYgP0LWMvG+h294ivNcXbjH6q/00KSoqO1A==
Date:   Wed, 22 Mar 2023 23:19:01 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Message-ID: <2023032222190171a38d5f@mail.local>
References: <20230201143431.863784-1-frieder@fris.de>
 <Y9qQHpySbrFcBB0P@mail.local>
 <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
 <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
 <da83fdd0-9eae-09ce-ff6f-47cc012f9628@kontron.de>
 <31b0a8b1-d027-d47a-e10d-614c09211734@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b0a8b1-d027-d47a-e10d-614c09211734@kontron.de>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 22/03/2023 14:14:50+0100, Frieder Schrempf wrote:
> On 06.03.23 14:27, Frieder Schrempf wrote:
> > On 13.02.23 10:18, Frieder Schrempf wrote:
> >> Hi Alexandre,
> >>
> >> On 01.02.23 17:26, Frieder Schrempf wrote:
> >>> On 01.02.23 17:15, Alexandre Belloni wrote:
> >>>> Hello,
> >>>>
> >>>> You can't do that, this breaks an important use case and it is the
> >>>> reason why I didn't use device tree in the beginning. What is wrong with
> >>>> setting BSM from userspace? You will anyway have to set the time and
> >>>> date from userspace for it to be saved.
> >>>
> >>> Ok, I was already afraid there is something I missed. Can you give a
> >>> short explanation of what use case this would break?
> >>>
> >>> There is nothing wrong with setting BSM from userspace. It's just the
> >>> fact that users expect BSM to be enabled in any case as there is a
> >>> battery on the board. It is much more effort to ensure that production,
> >>> user, etc. are aware of an extra step required than to let the kernel
> >>> deal with it behind the scenes.
> >>
> >> Would you mind elaborating on your argument that this would break stuff?
> >> I currently don't see how an additional optional devicetree property
> >> would break anything.
> > 
> > Ping!?
> 
> It seems like you decided to ignore me for whatever reasons there are.
> I'm sure we can sort it out in some way if you would respond, please.

I do what I can with the time I have.

There are 2 issues:
 - the first one is that this is encoding device configuration in the
   device tree which is forbidden. BSM is not really hardware related.
The worse that could happen is that the backup voltage is not present
and so the RTC will never switch to the backup source.

 - the second one is why I got to a userspace solution. There are RTC
   where it is crucial to be able to change BSM dynamically. Those RTCs
have a standby mode: they will only draw current from the backup source
once they have seen VDD once. This is useful when you install a battery
in a product and this products stays on the shelf for a while before
being used. However, if your production line needs to powerup the device
to flash it or perform tests, the RTC will get out of standby mode and
you need a way to get it back to standby. This is possible with the
current interface, I'm not going to have a second interface.

Regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
