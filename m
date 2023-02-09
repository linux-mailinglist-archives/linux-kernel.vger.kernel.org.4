Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD12690D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjBIPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjBIPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:40:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275245B74F;
        Thu,  9 Feb 2023 07:40:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675957250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVFhlR2M6tNz8ldOCJ24pLZnOnnyeNs58Qt9EziV6CM=;
        b=JW7EI1gy7ShLJfGdxUahI0jE6ujpSPzquuMDqkeDl1wd0R1Rdca3VNsHVCn0f4e8fq3JKq
        zZY+/EBDJH0zjuegVMTrKh2nFkMP0Z2TS2QmRl2Ma76vQ8B7BH8RgJbJ9QnWUz44XaXy9O
        RKfxQVSJj9SN1nilyERF8ZHFX5CIBivr75l8U60ExWteFiVwwpiouSMfy6f33y/OZGYuXe
        F3KBCHkONxaqNGTPnIegaW57YEG3eHeHvlyG+NV/NkPu/01ap8Y79zO4N57JbNttCVcr2I
        pur3/b95DWulKg/YKW1hCvYfIPDTf6oKMORsv1k5+ZAmuJ1k+HzdorIf5ECMQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675957250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVFhlR2M6tNz8ldOCJ24pLZnOnnyeNs58Qt9EziV6CM=;
        b=Uvene4wD+DyhDsbTMc4drDy2TYTCbUgnzBHvIRIRsrmwLaDxc7QkMPcZtjQsRXYkCuMsV+
        qFSpFcfPM/4sOaAA==
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Michael <michael@mipisi.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time
 delta is zero
In-Reply-To: <CAOf5uwn1SKBR+pREZy9f-wnQf6Lw3epyHxiX_hjf_pOaiiSDWA@mail.gmail.com>
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de>
 <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
 <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de>
 <alpine.DEB.2.21.1909040047210.1902@nanos.tec.linutronix.de>
 <Y+O+VBSNywC7LKhn@panicking> <87edr02fsc.ffs@tglx>
 <CAOf5uwn1SKBR+pREZy9f-wnQf6Lw3epyHxiX_hjf_pOaiiSDWA@mail.gmail.com>
Date:   Thu, 09 Feb 2023 16:40:49 +0100
Message-ID: <87zg9m26f2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael!

On Thu, Feb 09 2023 at 12:19, Michael Nazzareno Trimarchi wrote:
> On Wed, Feb 8, 2023 at 7:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> I wrote that patch against the back then mainline code. No idea if it's
>> still applying, but the underlying issue is still the same AFAICT.
>>
>> It needs some polishing and a proper changelog.
>>
> Ok, I will try to update it on some mainline kernel in my environment
> and test it back. I need
> a little information if it's possible. Consider that I have no
> experience in this area. I understand how
> code was designed in general but the part around the freezer and all
> those code you remove, what was the logic behind in the removed code?

What I can oracle out of that well commented gem is:

  A userspace task invokes clock_nanosleep(CLOCK_*_ALARM, ...), which
  arms an alarm timer. The expiry of an alarmtimer causes the system to
  come out of suspend.

  As the task invokes schedule() it can also be brought back from
  schedule() via a signal. If that happens then the task cancels the
  alarmtimer and returns to handle the signal. While doing that it can
  be frozen, which means the alarm and therefore the wake from suspend
  is lost.

  To prevent that the code tries to save the earliest expiring alarm if
  the task is marked freezing() and the suspend code takes that into
  account.

John, did I summarize that correctly?

The change I made remove that magic and marks the task freezable when it
goes to schedule, which prevents the signal wakeup. That ensures that
the alarm stays armed during freeze/suspend.

That obviously needs some testing and scrunity by the folks which use
this mechanism. IIRC that's used by android, but I might be wrong.

Thanks,

        tglx


