Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124B606708
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJTR3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJTR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23AF1C90E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666286977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQXgKbUKEd0FI2ap/xmYT1wD+dqAT2h28k3BQUOIDyY=;
        b=BXciggb8tRIho8VjZ3ZOUx5XGju9+BWrPbwjAQhk8gJiPifPwtAo+8ce0erwMia/I2tBKa
        gWkLwRWgdzZGnW9gXyt0GCr2S3JKnUqg8wi9W+P8LtuwlIRA56Yv08X75IKM4DjVxSojS8
        YHotUtNUeknOAkCdznpTrtKjiXg+Yec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-JzS2JGXHNIamf7cIEYsh9w-1; Thu, 20 Oct 2022 13:29:32 -0400
X-MC-Unique: JzS2JGXHNIamf7cIEYsh9w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B04071C0A102;
        Thu, 20 Oct 2022 17:29:31 +0000 (UTC)
Received: from [10.22.17.13] (unknown [10.22.17.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3575E49BB60;
        Thu, 20 Oct 2022 17:29:31 +0000 (UTC)
Message-ID: <d54972a2-c328-d753-afc2-ff0f5cf726f3@redhat.com>
Date:   Thu, 20 Oct 2022 13:29:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Content-Language: en-US
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     linux-kernel@vger.kernel.org, clm@meta.com, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
 <Y1ECHVUHilqgKD9o@feng-clx>
 <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221020140944.GK5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 10:09, Paul E. McKenney wrote:
> On Thu, Oct 20, 2022 at 04:09:01PM +0800, Feng Tang wrote:
>> On Wed, Oct 19, 2022 at 04:09:04PM -0700, Paul E. McKenney wrote:
>>> One remaining clocksource-skew issue involves extreme CPU overcommit,
>>> which can cause the clocksource watchdog measurements to be delayed by
>>> tens of seconds.  This in turn means that a clock-skew criterion that
>>> is appropriate for a 500-millisecond interval will instead give lots of
>>> false positives.
>> I remembered I saw logs that the watchdog were delayed to dozens of
>> or hundreds of seconds.
>>
>> Thanks for the fix which makes sense to me! with some nits below.
>>
>>> Therefore, check for the watchdog clocksource reporting much larger or
>>> much less than the time specified by WATCHDOG_INTERVAL.  In these cases,
>>> print a pr_warn() warning and refrain from marking the clocksource under
>>> test as being unstable.
>>>
>>> Reported-by: Chris Mason <clm@meta.com>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: John Stultz <jstultz@google.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>> Cc: Feng Tang <feng.tang@intel.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>>
>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>> index 8058bec87acee..dcaf38c062161 100644
>>> --- a/kernel/time/clocksource.c
>>> +++ b/kernel/time/clocksource.c
>>> @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
>>>   
>>>   static void clocksource_watchdog(struct timer_list *unused)
>>>   {
>>> -	u64 csnow, wdnow, cslast, wdlast, delta;
>>> +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
>>>   	int next_cpu, reset_pending;
>>>   	int64_t wd_nsec, cs_nsec;
>>>   	struct clocksource *cs;
>>> @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
>>>   		if (atomic_read(&watchdog_reset_pending))
>>>   			continue;
>>>   
>>> +		/* Check for bogus measurements. */
>>> +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
>>> +		if (wd_nsec < (wdi >> 2)) {
>>> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>>> +			continue;
>>> +		}
>> If this happens (500ms timer happens only after less than 125ms),
>> there is some severe problem with timer/interrupt system.
> Should I add ", suspect timer/interrupt bug" just after "jiffy time
> interval"?  Or would a comment before that pr_warn() work better for you?
>
>>> +		if (wd_nsec > (wdi << 2)) {
>>> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>>> +			continue;
>>> +		}
>> I agree with Waiman that some rate limiting may be needed. As there
>> were reports of hundreds of seconds of delay, 2 seconds delay could
>> easily happen if a system is too busy or misbehave to trigger this
>> problem.
> Good points, thank you both!
>
> Left to myself, I would use a capped power-of-two backoff that was reset
> any time that the interval was within bounds.  Maybe a cap of 10 minutes?

That sounds good to me.

Thanks,
Longman

