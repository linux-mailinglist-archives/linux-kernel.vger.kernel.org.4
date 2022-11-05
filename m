Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B926261A701
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKECuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKECuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD53FB98
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667616559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g96g4MFcAmtYBqMpkUTTLyO9wItCS21W5ZNz6tq6CYM=;
        b=OU6SHkakdxN7lGB3nnwDu5FsMEpm7qDIzQrhTZ6C2rDCsceHLGlwBXoEA3N+I6wp9eGCEe
        0q5nac1hY7Yo9PF4IWNoKEII2QciczC0cBLJW6fhAA5wlbDIrUHz5bH8jC1YJdut2bS1TC
        5Qr2KeYlcriE2dA5tRhGnNv97y2j1Os=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-XFi7s8DXNfmsw2q59EJDxQ-1; Fri, 04 Nov 2022 22:49:15 -0400
X-MC-Unique: XFi7s8DXNfmsw2q59EJDxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE28B101A54E;
        Sat,  5 Nov 2022 02:49:14 +0000 (UTC)
Received: from [10.22.8.59] (unknown [10.22.8.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19CBD492B0D;
        Sat,  5 Nov 2022 02:49:14 +0000 (UTC)
Message-ID: <b4312465-91b1-4d05-ab77-703396c81d21@redhat.com>
Date:   Fri, 4 Nov 2022 22:49:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH clocksource 2/2] clocksource: Exponential backoff for
 load-induced bogus watchdog reads
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, John Stultz <jstultz@google.com>
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-2-paulmck@kernel.org>
 <1fdbdf78-cdca-975f-7f57-e391263d0aec@redhat.com>
 <20221103204910.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <61470eb8-fc3c-7f95-881e-03da1805b5ac@redhat.com>
 <20221104002616.GH5600@paulmck-ThinkPad-P17-Gen-1>
 <d6e2029d-8390-908b-577d-8724706ee652@redhat.com>
 <20221104022336.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <17b8ade1-2676-d243-dc60-57b82c8f6802@redhat.com>
 <20221105023824.GA28461@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221105023824.GA28461@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/4/22 22:38, Paul E. McKenney wrote:
> On Fri, Nov 04, 2022 at 09:55:02AM -0400, Waiman Long wrote:
>> On 11/3/22 22:23, Paul E. McKenney wrote:
>>> On Thu, Nov 03, 2022 at 09:01:45PM -0400, Waiman Long wrote:
>>>> On 11/3/22 20:26, Paul E. McKenney wrote:
>>>>> On Thu, Nov 03, 2022 at 08:20:27PM -0400, Waiman Long wrote:
>>>>>> On 11/3/22 16:49, Paul E. McKenney wrote:
> [ . . . ]
>
>>>>>>> +					needwarn = true;
>>>>>>> +			}
>>>>>>> +			if (needwarn) {
>>>>>>> +				/* This can happen on busy systems, which can delay the watchdog. */
>>>>>>> +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu additional), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count);
>>>>>> Just one question, does "%lu additional" means the number of bogus count
>>>>>> that doesn't meet the needwarn requirement and hence skipped. If so, I think
>>>>>> you have to use "cs->wd_bogus_cnt - 1". Other than that, the change looks
>>>>>> good to me.
>>>>> It means the number since the last report, or, for the first report,
>>>>> the number since boot.
>>>>>
>>>>> Does that work for you?
>>>> OK, I think the word "additional" tricks me into thinking about extra bogus
>>>> messages in additional to the current one. Using another word like "total"
>>>> may be less confusing.
>>> My concern with "total" is that people might think that the numbers
>>> meant the total number of instances since boot.
>>>
>>> So how about "(9 since last message)" or similar?
>>>
>>> 							Thanx, Paul
>> Yes, that looks good to me.
> Thank you, and please see below for the updated patch.
>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit a7dc308e8359eafb58df360e06b66ecbf79a4d0b
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Oct 28 10:38:58 2022 -0700
>
>      clocksource: Exponential backoff for load-induced bogus watchdog reads
>      
>      The clocksource watchdog will reject measurements that are excessively
>      delayed, that is, by more than 1.5 seconds beyond the intended 0.5-second
>      watchdog interval.  On an extremely busy system, this can result in a
>      console message being printed every two seconds.  This is excessively
>      noisy for a non-error condition.
>      
>      Therefore, apply exponential backoff to these messages.  This exponential
>      backoff is capped at 1024 times the watchdog interval, which comes to
>      not quite one message per ten minutes.
>      
>      Please note that the bogus watchdog reads that occur when the watchdog
>      interval is less than 0.125 seconds are still printed unconditionally
>      because these likely correspond to a serious error condition in the
>      timer code or hardware.
>      
>      [ paulmck: Apply Feng Tang feedback. ]
>      [ paulmck: Apply Waiman Long feedback. ]
>      
>      Reported-by: Waiman Long <longman@redhat.com>
>      Reported-by: Feng Tang <feng.tang@intel.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>      Reviewed-by: Feng Tang <feng.tang@intel.com>
>      Cc: John Stultz <jstultz@google.com>
>      Cc: Thomas Gleixner <tglx@linutronix.de>
>      Cc: Stephen Boyd <sboyd@kernel.org>
>      Cc: Waiman Long <longman@redhat.com>
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 1d42d4b173271..23b73f2293d6d 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -125,6 +125,9 @@ struct clocksource {
>   	struct list_head	wd_list;
>   	u64			cs_last;
>   	u64			wd_last;
> +	u64			wd_last_bogus;
> +	int			wd_bogus_shift;
> +	unsigned long		wd_bogus_count;
>   #endif
>   	struct module		*owner;
>   };
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 3f5317faf891f..4015ec6503a52 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -442,14 +442,33 @@ static void clocksource_watchdog(struct timer_list *unused)
>   
>   		/* Check for bogus measurements. */
>   		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> -		if (wd_nsec < (wdi >> 2)) {
> -			/* This usually indicates broken timer code or hardware. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +		if (wd_nsec > (wdi << 2) || cs_nsec > (wdi << 2)) {
> +			bool needwarn = false;
> +			u64 wd_lb;
> +
> +			cs->wd_bogus_count++;
> +			if (!cs->wd_bogus_shift) {
> +				needwarn = true;
> +			} else {
> +				delta = clocksource_delta(wdnow, cs->wd_last_bogus, watchdog->mask);
> +				wd_lb = clocksource_cyc2ns(delta, watchdog->mult, watchdog->shift);
> +				if ((1 << cs->wd_bogus_shift) * wdi <= wd_lb)
> +					needwarn = true;
> +			}
> +			if (needwarn) {
> +				/* This can happen on busy systems, which can delay the watchdog. */
> +				pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval (%lu since last message), probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL, cs->wd_bogus_count);
> +				cs->wd_last_bogus = wdnow;
> +				if (cs->wd_bogus_shift < 10)
> +					cs->wd_bogus_shift++;
> +				cs->wd_bogus_count = 0;
> +			}
>   			continue;
>   		}
> -		if (wd_nsec > (wdi << 2)) {
> -			/* This can happen on busy systems, which can delay the watchdog. */
> -			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +		/* Check too-short measurements second to handle wrap. */
> +		if (wd_nsec < (wdi >> 2) || cs_nsec < (wdi >> 2)) {
> +			/* This usually indicates broken timer code or hardware. */
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>   			continue;
>   		}
>   
>
Looks good to me.

Reviewed-by: Waiman Long <longman@redhat.com>

