Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFD6A8C65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCBW64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCBW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:58:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084134018
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:58:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677797930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzWVnM0EnAyX2RJN5dijy7rNGWLip36D2Ua6AcIH1F4=;
        b=lA7UjLET8nOYD7QNw1/34QONCHO4CEJBQRLTle305nloCs0qBaNfp9o3IEeEmx+0YNOhYb
        1z/FgC4zzLp017pTC3HJtuM/dC8FHgSG4BZ4XqiKaaPLFYi8kXU3y9DfBhXVSO/SpULfH0
        7IIvsNAcuSvrSJCL+AegYmI1rkX/90G0qTogNQPIKg1ImVS/0mICKJ5o3WpwjIu8jadX2j
        K5YAGwVqygAraXCg3vyJgv1yo+s9QtP8q5ZlR7SJvdvnHEGfAi8AZVOgVPhy2iQ+6h4AEe
        QzC/Ir3Pu/YJiJbrd3ZSzv0B8GINJvwk6bjLNnXEegHja6X52DhTDZtx+SnnTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677797930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzWVnM0EnAyX2RJN5dijy7rNGWLip36D2Ua6AcIH1F4=;
        b=3kWZdVRdDHIlDtBt3yF5bNrVVlXurBzlsYpPNGZ8jj7O1mFue/ZRXh65rv0DUl4Gqg11Gc
        E2ClHJbbz75rQbAg==
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <87zg8ukd54.ffs@tglx>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx>
 <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx>
 <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
 <CAJZ5v0iWZqAcbqdTuKbo35Gk6vNS0h9De20GDNZeZvqfhQiSWA@mail.gmail.com>
 <87zg8ukd54.ffs@tglx>
Date:   Thu, 02 Mar 2023 23:58:49 +0100
Message-ID: <87wn3ykbfa.ffs@tglx>
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

On Thu, Mar 02 2023 at 23:21, Thomas Gleixner wrote:
> On Thu, Mar 02 2023 at 15:32, Rafael J. Wysocki wrote:
>> On Mon, Feb 20, 2023 at 10:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>> +static atomic_t alarmtimer_wakeup;
>>>
>>>  /**
>>>   * alarmtimer_fired - Handles alarm hrtimer being fired.
>>> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
>>>         int ret = HRTIMER_NORESTART;
>>>         int restart = ALARMTIMER_NORESTART;
>>>
>>> +       atomic_inc(&alarmtimer_wakeup);
>>> +
>>
>> This appears to be still somewhat racy, because the notifier can run
>> at this point AFAICS.
>
> Indeed it is. Let me think more about this.

All of this is inherently racy as there is zero feedback whether the
event has been consumed or not. Making this feedback based is not
necessarily trivial, but let me stare into that.

Thanks,

        tglx

