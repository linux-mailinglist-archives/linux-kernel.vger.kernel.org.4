Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D772B262
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjFKPMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFKPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:12:00 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B719A;
        Sun, 11 Jun 2023 08:11:58 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686496317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Ko8eHdReoKk8tFjBUwiHeCPmlbto/75VVvMbtm6gyc=;
        b=dF28w9/iXOEAEeRxze3GlJFtgYV+C4VW4RJrdy1WdGrixwIe2AeUAxUl/vZ3X2y+RwgP51
        ypadoJQTLeYv0g/K4D84V2n7QYwSG3Jq5ORv0jVoo4EqWFLHsG9x1UKmEq51TC7QKcE1uq
        alOC085wZfLCHc82134UbPEy7rlh51obnRGs2NaWol4z1WCXmoZ/x1IHBC5RiGlW0MxD1h
        oyJVy6pN43XsagoWkUniEWwwqiqzTv5FjtrfsYtThb5Jgp0LpXKlF87fxgovK020RSmwhM
        Slco58chmLL1uqpus+RXM/qE5X8rzScyvuHXvIzGvdA+5p6VJO639JEmgiOgdw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57DA6C0004;
        Sun, 11 Jun 2023 15:11:56 +0000 (UTC)
Date:   Sun, 11 Jun 2023 17:11:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage
 via RTC_VL_BACKUP_LOW
Message-ID: <202306111511569834cac2@mail.local>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2023 15:38:04+0200, Jan Kiszka wrote:
> On 10.06.23 10:31, Alexandre Belloni wrote:
> > Hello Jan,
> > 
> > On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> The VL bit in the seconds register remains set only until seconds are
> >> written under main power. As this often happens during boot-up after
> >> picking up a network time, make sure to preserve the low battery state
> >> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
> >>
> >> To permit userspace clearing this state during runtime, also implement
> >> RTC_VL_CLR that works against the cached state.
> >>
> >> This is emulating RTCs which have a battery voltage check that works
> >> under main power as well.
> >>
> > 
> > Emulating doesn't work well and I deliberately chose to not implement
> > it. For example, in your scenario, if you boot twice without using
> > VL_READ, you anyway have lost the information. This makes emulating
> > unreliabl. The fix you need is in userspace where you have to ensure you
> > read the status before setting the time.
> 
> Then let's make sure the bit is also set in the hardware register. Then
> also the reboot issue (which is practically a minor one) is solved. The
> current situation is far from optimal.

This doesn't work because then the time will be considered invalid. I'm
not sure why you don't want to fix your userspace.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
