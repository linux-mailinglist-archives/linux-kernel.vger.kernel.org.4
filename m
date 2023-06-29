Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E02742BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjF2SO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF2SOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:14:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712D2D51
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:14:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688062490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zdxRTzndBW57lfegbn1CoeTXkaZu8rXXCLefAusQhY=;
        b=D7VKVU6GkSOMgUAO+7DUXnenF4A0pz65mNJSBqEazLVRm5Rik2Z1+SY9zQRjrJMZeBwW60
        I0YCkV1m/TZL9d+0smaCBOINH/RSlNPSYWo6Oyh/JmS6ARs34SjHxANTL4tgIO5yIYSuvx
        O7r0uC4DIJqppmKHjtvgzb3p7pW9iAytqd/XUTcCAYsbeyZp8CCGL2JyJwIkGl4nfkea5+
        7Nm942eLdE8+dnbzxtZAa6tkc1ifBXJEDyl9UkQ6pzaBU1SGIcPGX+Jn8++mKGK8w/rao2
        d0PLrqgVSKUKN5nGPcSaWZpLZrKQsqDtLzpAYkyf0NjI+3Yh8XCbUatbcCxunw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688062490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9zdxRTzndBW57lfegbn1CoeTXkaZu8rXXCLefAusQhY=;
        b=xjgHEnCfzb8hprsd4iEfT8SsJ6gGFY97u3tT+htkbdb+Nbd3bfEUn5wFRUZ3ejBLO2gRNy
        STl4srNTAP09UJDA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 09/45] posix-cpu-timers: Fix posix_cpu_timer_get()
 behaviour
In-Reply-To: <ZJoVLadeU9Y5KMO8@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.532247561@linutronix.de> <ZJoVLadeU9Y5KMO8@lothringen>
Date:   Thu, 29 Jun 2023 20:14:49 +0200
Message-ID: <871qhu2l0m.ffs@tglx>
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

On Tue, Jun 27 2023 at 00:46, Frederic Weisbecker wrote:> On Tue, Jun 06, 2023 at 04:37:33PM +0200, Thomas Gleixner wrote:
>> Aside of that posix_cpu_timer_set() pointlessly arms SIGEV_NONE timers
>> which are later disarmed when the initial expiry happens. That's bogus and
>> just keeping the process wide timer active for nothing.
>> 
>> Cure this by:
>> 
>>      1) Avoiding to arm SIGEV_NONE timers
>> 
>>      2) Forwarding interval timers in posix_cpu_timer_get()
>> 
>>      3) Taking SIGEV_NONE into account when a oneshot timer has expired
>
> This patch does too many things at once...

Let me try again to split it up. I failed before ...

>> -static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
>> +static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
>>  {
>> -	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
>> -	struct cpu_timer *ctmr = &timer->it.cpu;
>> -	u64 now, expires = cpu_timer_getexpires(ctmr);
>> -	struct task_struct *p;
>> -
>> -	rcu_read_lock();
>> -	p = cpu_timer_task_rcu(timer);
>> -	if (!p)
>> -		goto out;
>> +	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
>> +	u64 expires;
>>  
>>  	/*
>> -	 * Easy part: convert the reload time.
>> +	 * Make sure that interval timers are moved forward for the
>> +	 * following cases:
>> +	 *  - SIGEV_NONE timers which are never armed
>> +	 *  - Timers which expired, but the signal has not yet been
>> +	 *    delivered
>>  	 */
>> -	itp->it_interval = ktime_to_timespec64(timer->it_interval);
>> -
>> -	if (!expires)
>> -		goto out;
>> +	expires = bump_cpu_timer(timer, now);
>
> What if the expiration has been reached but we arrived here before
> handle_posix_cpu_timers() had a chance? In that case the call to
> bump_cpu_timer() may forward the timer and artificially create an
> overrun / missed event.

Bah. This clearly misses some conditionals so that it actually handles
the cases described in the comment above it...

Thanks,

        tglx


