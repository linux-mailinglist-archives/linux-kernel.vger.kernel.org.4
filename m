Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3186652BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLUD1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLUD1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091F1CB10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671593182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eeE01qwsWJaU6Iz/QOnp7NA+lSRSeVOQIa7i08gmTds=;
        b=djBhJatW/tLrumiyxWBVmDrCfzgz2hHUXW/As+Q1khYqDjDK6774aKu7FwILdWo90COlol
        GbmutbeKYlNRf05XOVPa0B4LzNrqcqjcKhp8UTyJ0cHnTxiymO0DdqhFuCutljN3lDUH4O
        OJqpVEf5CYqVq2p+iNywuXoN8SrIcPI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-HkGABoJGOi6m5pWQocGiQQ-1; Tue, 20 Dec 2022 22:26:16 -0500
X-MC-Unique: HkGABoJGOi6m5pWQocGiQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04332280559D;
        Wed, 21 Dec 2022 03:26:16 +0000 (UTC)
Received: from [10.22.16.19] (unknown [10.22.16.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89CE9400D79E;
        Wed, 21 Dec 2022 03:26:15 +0000 (UTC)
Message-ID: <8a9bed0d-c166-37e9-24c3-8cea7a336c76@redhat.com>
Date:   Tue, 20 Dec 2022 22:26:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>
References: <20221220082512.186283-1-feng.tang@intel.com>
 <6fb04ee9-ce77-4835-2ad1-b7f8419cfb77@redhat.com>
 <20221220183400.GY4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6Ja+kYQAi4pppV6@feng-clx>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y6Ja+kYQAi4pppV6@feng-clx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/22 20:01, Feng Tang wrote:
> Using correct email address of John Stultz.
>
> On Tue, Dec 20, 2022 at 10:34:00AM -0800, Paul E. McKenney wrote:
>> On Tue, Dec 20, 2022 at 11:11:08AM -0500, Waiman Long wrote:
>>> On 12/20/22 03:25, Feng Tang wrote:
>>>> There were bug reported on 8 sockets x86 machines that TSC was wrongly
>>>> disabled when system is under heavy workload.
>>>>
>>>>    [ 818.380354] clocksource: timekeeping watchdog on CPU336: hpet wd-wd read-back delay of 1203520ns
>>>>    [ 818.436160] clocksource: wd-tsc-wd read-back delay of 181880ns, clock-skew test skipped!
>>>>    [ 819.402962] clocksource: timekeeping watchdog on CPU338: hpet wd-wd read-back delay of 324000ns
>>>>    [ 819.448036] clocksource: wd-tsc-wd read-back delay of 337240ns, clock-skew test skipped!
>>>>    [ 819.880863] clocksource: timekeeping watchdog on CPU339: hpet read-back delay of 150280ns, attempt 3, marking unstable
>>>>    [ 819.936243] tsc: Marking TSC unstable due to clocksource watchdog
>>>>    [ 820.068173] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
>>>>    [ 820.092382] sched_clock: Marking unstable (818769414384, 1195404998)
>>>>    [ 820.643627] clocksource: Checking clocksource tsc synchronization from CPU 267 to CPUs 0,4,25,70,126,430,557,564.
>>>>    [ 821.067990] clocksource: Switched to clocksource hpet
>>>>
>>>> This can be reproduced when system is running memory intensive 'stream'
>>>> test, or some stress-ng subcases like 'ioport'.
>>>>
>>>> The reason is when system is under heavy load, the read latency of
>>>> clocksource can be very high, it can be seen even with lightweight
>>>> TSC read, and is much worse on MMIO or IO port read based external
>>>> clocksource. Causing the watchdog check to be inaccurate.
>>>>
>>>> As the clocksource watchdog is a lifetime check with frequency of
>>>> twice a second, there is no need to rush doing it when the system
>>>> is under heavy load and the clocksource read latency is very high,
>>>> suspend the watchdog timer for 5 minutes.
>>>>
>>>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>>>> ---
>>>>    kernel/time/clocksource.c | 45 ++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 32 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>> index 9cf32ccda715..8cd74b89d577 100644
>>>> --- a/kernel/time/clocksource.c
>>>> +++ b/kernel/time/clocksource.c
>>>> @@ -384,6 +384,15 @@ void clocksource_verify_percpu(struct clocksource *cs)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
>>>> +static inline void clocksource_reset_watchdog(void)
>>>> +{
>>>> +	struct clocksource *cs;
>>>> +
>>>> +	list_for_each_entry(cs, &watchdog_list, wd_list)
>>>> +		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
>>>> +}
>>>> +
>>>> +
>>>>    static void clocksource_watchdog(struct timer_list *unused)
>>>>    {
>>>>    	u64 csnow, wdnow, cslast, wdlast, delta;
>>>> @@ -391,6 +400,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>    	int64_t wd_nsec, cs_nsec;
>>>>    	struct clocksource *cs;
>>>>    	enum wd_read_status read_ret;
>>>> +	unsigned long extra_wait = 0;
>>>>    	u32 md;
>>>>    	spin_lock(&watchdog_lock);
>>>> @@ -410,13 +420,30 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>    		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
>>>> -		if (read_ret != WD_READ_SUCCESS) {
>>>> -			if (read_ret == WD_READ_UNSTABLE)
>>>> -				/* Clock readout unreliable, so give it up. */
>>>> -				__clocksource_unstable(cs);
>>>> +		if (read_ret == WD_READ_UNSTABLE) {
>>>> +			/* Clock readout unreliable, so give it up. */
>>>> +			__clocksource_unstable(cs);
>>>>    			continue;
>>>>    		}
>>>> +		/*
>>>> +		 * When WD_READ_SKIP is returned, it means the system is likely
>>>> +		 * under very heavy load, where the latency of reading
>>>> +		 * watchdog/clocksource is very big, and affect the accuracy of
>>>> +		 * watchdog check. So give system some space and suspend the
>>>> +		 * watchdog check for 5 minutes.
>>>> +		 */
>>>> +		if (read_ret == WD_READ_SKIP) {
>>>> +			/*
>>>> +			 * As the watchdog timer will be suspended, and
>>>> +			 * cs->last could keep unchanged for 5 minutes, reset
>>>> +			 * the counters.
>>>> +			 */
>>>> +			clocksource_reset_watchdog();
>>>> +			extra_wait = HZ * 300;
>>>> +			break;
>>>> +		}
>>>> +
>>>>    		/* Clocksource initialized ? */
>>>>    		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
>>>>    		    atomic_read(&watchdog_reset_pending)) {
>>>> @@ -512,7 +539,7 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>>    	 * pair clocksource_stop_watchdog() clocksource_start_watchdog().
>>>>    	 */
>>>>    	if (!timer_pending(&watchdog_timer)) {
>>>> -		watchdog_timer.expires += WATCHDOG_INTERVAL;
>>>> +		watchdog_timer.expires += WATCHDOG_INTERVAL + extra_wait;
>>>>    		add_timer_on(&watchdog_timer, next_cpu);
>>>>    	}
>>>>    out:
>>>> @@ -537,14 +564,6 @@ static inline void clocksource_stop_watchdog(void)
>>>>    	watchdog_running = 0;
>>>>    }
>>>> -static inline void clocksource_reset_watchdog(void)
>>>> -{
>>>> -	struct clocksource *cs;
>>>> -
>>>> -	list_for_each_entry(cs, &watchdog_list, wd_list)
>>>> -		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
>>>> -}
>>>> -
>>>>    static void clocksource_resume_watchdog(void)
>>>>    {
>>>>    	atomic_inc(&watchdog_reset_pending);
>>> It looks reasonable to me. Thanks for the patch.
>>>
>>> Acked-by: Waiman Long <longman@redhat.com>
>> Queued, thank you both!
> Thanks for reviewing and queueing!
>
>> If you would like this to go in some other way:
>>
>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
>>
>> And while I am remembering it...  Any objections to reversing the role of
>> TSC and the other timers on systems where TSC is believed to be accurate?
>> So that if there is clocksource skew, HPET is marked unstable rather than
>> TSC?
> For the bug in commit log, I think it's the 8 sockets system with
> hundreds of CPUs causing the big latency, while the HPET itself may
> not be broken, and if we switched to ACPI PM_TIMER as watchdog, we
> could see similar big latency.
>
> I used to only see this issue with stress tool like stress-ng, but
> seems with larger and larger system, even the momory intensive load
> can easily trigger this.
>
>> This would preserve the diagnostics without hammering performance
>> when skew is detected.  (Switching from TSC to HPET hammers performance
>> enough that our automation usually notices and reboots the system.)
> Yes, switching to HPET is a disaster for performance, we've seen
> from 30% to 90% drop in different benchmarks.

Switching to hpet is very bad for performance. That is the main reason 
why I posted clocksource patches in the past to avoid this as much as 
possible. I think your patch is also a good countermeasure to avoid this.

Thanks,
Longman

