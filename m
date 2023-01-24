Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46C767A1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjAXSqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjAXSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:46:11 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5848A00;
        Tue, 24 Jan 2023 10:45:39 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4CABE0007;
        Tue, 24 Jan 2023 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674585936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JphgYjEJiQnkqyd7jRw3NYGADyEgFfd5h5oQ31b9pNw=;
        b=Nj8Ors0ddwd4qOBGVYB4eRTEZNONT7RrlR578oyrMWcwP4dS78CyPDWbFzbA0UX8IBUfPz
        qT96dyR6O38PlLPcCr1ueEApoRJF6CBy3OCjT5yhAOPSD7iDTqPU1FEd2fmnim9DnH5hZK
        blSRCEJC1fF8GX7kPXj6XViOifi1hXdsWLYW6YPec8sEGrDmireGdq1qaEhHR1nih2nwS9
        jZzYdn3/n3WJxpU2ekqrrZFZOK9TuH+++dvBTcJhD4EzLNGNvfnU4zdOqb+EvOVYZNAz7m
        8ntgCcIFIyFrapTN4LKgJmNjeZ9o7vf6rjcU7IxEICArCksP6sxBhUfCSAoqtw==
Date:   Tue, 24 Jan 2023 19:45:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Doug Berger <opendmb@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] rtc: brcmstb-waketimer: add RTC alarm irq
Message-ID: <Y9AnTiM/dKMhc1eP@mail.local>
References: <20230120190147.718976-1-opendmb@gmail.com>
 <167451526504.1264870.8427240602882815591.b4-ty@bootlin.com>
 <4982a703-fc6b-b778-78a5-ada5ea5aedb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4982a703-fc6b-b778-78a5-ada5ea5aedb2@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 09:42:19-0800, Florian Fainelli wrote:
> On 1/23/23 15:08, 'Alexandre Belloni' via BCM-KERNEL-FEEDBACK-LIST,PDL
> wrote:
> > 
> > On Fri, 20 Jan 2023 11:01:41 -0800, Doug Berger wrote:
> > > Support is added for an interrupt that can be triggered from the
> > > brcmstb-waketimer hardware while the system is awake.
> > > 
> > > This interrupt allows the driver to pass the rtctest selftest.
> > > 
> > > Doug Berger (6):
> > >    rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
> > >    rtc: brcmstb-waketimer: non-functional code changes
> > >    rtc: brcmstb-waketimer: compensate for lack of wktmr disable
> > >    rtc: brcmstb-waketimer: rename irq to wake_irq
> > >    dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
> > >    rtc: brcmstb-waketimer: allow use as non-wake alarm
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/6] rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
> >        commit: 90226f6b17a3edcb0bddaf2f16991861c99d6a15
> > [2/6] rtc: brcmstb-waketimer: non-functional code changes
> >        commit: 2cd98b22c1443d1f2921a371baee658da184868e
> > [3/6] rtc: brcmstb-waketimer: compensate for lack of wktmr disable
> >        commit: 516ae02c38ff3ae867f9b19fa050f78157e2bdae
> > [4/6] rtc: brcmstb-waketimer: rename irq to wake_irq
> >        commit: eae258edcb8705932c9e5c61a99f91d8235f688b
> 
> That was quick, how about patch 6? It does not actually have a dependency on
> the Device Tree binding (patch 5) and the second interrupt is looked up by
> index.

My understanding is that if I take it, then the feature will not be
documented. I keep that as an incentive to send v2 ;)


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
