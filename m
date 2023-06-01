Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43A71F23B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFASnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFASnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:43:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC2E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:43:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685644999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyFON+nxk2A5/kg6X5Qv6OwhBLXdPK0urAgWXEZqX2U=;
        b=UzAXAQ8Hc0yFYDPFDOPnkqcGhGu6mC2eGLwJKC9q1v50jeClbv7tX58uBNLzZb6FgvaiaE
        x5q1pKJhNnSgdgPFymElQg9cZIn0YPRK9LbvInITF4n2CSsGXZm2qhnFdsNIKNRI6dpTvD
        CS98MG9/QZ6nhkHLqijouwPFHqqU/dSZTqy8pBEwR5ZsQbBlRqArQGA3qd49x3kyRaR5J3
        9uXr5WyBLF6Ty0CzQ+y6afhnlbxwefyWWx3QtTGuKKjsaFJiD5JcyMMlEFfyRN3mFMqUV6
        er/Bmaecs8W8zdxMAQzp/Cum9VTfuUKoVynO4MrKbEUV7CSMw24q19Ur0Rz7Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685644999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyFON+nxk2A5/kg6X5Qv6OwhBLXdPK0urAgWXEZqX2U=;
        b=p6J0aiOebK7dCr7Fn1VLhf/1ge5rRbdGcssAhMF02q7oTUB0iD+JajpZc9/3ZFrs6pAVb9
        VXfvY2qixT6bKUDw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 18/20] posix-timers: Clarify posix_timer_fn() comments
In-Reply-To: <ZHibcwrDgegKwQeQ@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.777610259@linutronix.de> <ZHibcwrDgegKwQeQ@lothringen>
Date:   Thu, 01 Jun 2023 20:43:19 +0200
Message-ID: <87edmvdnw8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2023 at 15:21, Frederic Weisbecker wrote:
> On Tue, Apr 25, 2023 at 08:49:24PM +0200, Thomas Gleixner wrote:
>> Make the issues vs. SIG_IGN understandable and remove the 15 years old
>> promise that a proper solution is already on the horizon.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  kernel/time/posix-timers.c |   56 +++++++++++++++++++++------------------------
>>  1 file changed, 27 insertions(+), 29 deletions(-)
>> 
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -325,11 +325,11 @@ int posix_timer_event(struct k_itimer *t
>>  }
>>  
>>  /*
>> - * This function gets called when a POSIX.1b interval timer expires.  It
>> - * is used as a callback from the kernel internal timer.  The
>> - * run_timer_list code ALWAYS calls with interrupts on.
>> -
>> - * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
>> + * This function gets called when a POSIX.1b interval timer expires from
>> + * the HRTIMER soft interrupt with interrupts enabled.
>
> BTW, what arranges for this to be called in softirq with interrupts enabled?
> The modes I see used here are HRTIMER_MODE_ABS or HRTIMER_MODE_REL and not
> their _SOFT counterparts.

Duh. My RT biased brain tricked me.

>> + *
>> + * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
>> + * based timers.
>>   */
>>  static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
>>  {
>> @@ -358,34 +359,31 @@ static enum hrtimer_restart posix_timer_
>>  			 * FIXME: What we really want, is to stop this
>>  			 * timer completely and restart it in case the
>>  			 * SIG_IGN is removed. This is a non trivial
>> -			 * change which involves sighand locking
>> -			 * (sigh !), which we don't want to do late in
>> -			 * the release cycle.
>> +			 * change to the signal handling code.
>> +			 *
>> +			 * For now let timers with an interval less than a
>> +			 * jiffie expire every jiffie to avoid softirq
>
> Or rather at least to the next jiffie, right? Because then in the next jiffie
> it gets re-evaluated in case a real signal handler might have been set
> in-between.
>
> Or it could be:
>
>  +                      * For now let timers with an interval less than a
>  +                      * jiffie expire every jiffie (until a real sig handler
>  +			* is found set) to avoid softirq...

Let me rephrase that.

>> +			 * starvation in case of SIG_IGN and a very small
>> +			 * interval, which would put the timer right back
>> +			 * on the softirq pending list. Moving now ahead of
>> +			 * time tricks hrtimer_forward() to expire the
>> +			 * timer later, while it still maintains the
>> +			 * overrun accuracy for the price of a slightly
>> +			 * inconsistency in the timer_gettime() case. This
>> +			 * is at least better than a starved softirq.
> [...]
>>  			 */
>> -#ifdef CONFIG_HIGH_RES_TIMERS
>> -			{
>> +			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
>>  				ktime_t kj = NSEC_PER_SEC / HZ;
>
> Could be TICK_NSECS?

Yep. Fixed it up.
