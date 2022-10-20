Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8E6055B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJTDCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJTDB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783D16D884
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666234917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPx6biVCwCmDLHbyfgRVu6pD3jK8NBhZWYxkf20TYNE=;
        b=HM0A9+wNBjkMrgC89kjv1xAs7+9NqLRKnkk8MbftLQAgJVxu3SCPvsvMvXaHDECR86M14d
        VFK29QdvLbop8j1h83gVSQePKUm09FgGxp4O3NnwDH9cspsTJWbXNOY6nsCLR8jR2/IvzS
        zLIjXWmM6/m9jfb7fi+ejYTnvwPGW5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-klqOnZwrMn-qOD5VKe0MXQ-1; Wed, 19 Oct 2022 23:01:51 -0400
X-MC-Unique: klqOnZwrMn-qOD5VKe0MXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75C3A185A78B;
        Thu, 20 Oct 2022 03:01:51 +0000 (UTC)
Received: from [10.22.33.65] (unknown [10.22.33.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D63440C6EC2;
        Thu, 20 Oct 2022 03:01:51 +0000 (UTC)
Message-ID: <df0960dc-86d4-984f-8dd8-c9d118aae449@redhat.com>
Date:   Wed, 19 Oct 2022 23:01:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH clocksource] Reject bogus watchdog clocksource
 measurements
Content-Language: en-US
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     clm@meta.com, jstultz@google.com, tglx@linutronix.de,
        sboyd@kernel.org, feng.tang@intel.com
References: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221019230904.GA2502730@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 19:09, Paul E. McKenney wrote:
> One remaining clocksource-skew issue involves extreme CPU overcommit,
> which can cause the clocksource watchdog measurements to be delayed by
> tens of seconds.  This in turn means that a clock-skew criterion that
> is appropriate for a 500-millisecond interval will instead give lots of
> false positives.

CPU overcommit means it is running in a VM. Right? Unfortunately, there 
is not a consistent cross-arch way to check for running under a 
hypervisor or we may want to add such a test if available. However, 
CLOCKSOURCE_WATCHDOG is only enabled in x86 and mips. Maybe we can add a 
helper function to do that.


>
> Therefore, check for the watchdog clocksource reporting much larger or
> much less than the time specified by WATCHDOG_INTERVAL.  In these cases,
> print a pr_warn() warning and refrain from marking the clocksource under
> test as being unstable.
>
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 8058bec87acee..dcaf38c062161 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
>   
>   static void clocksource_watchdog(struct timer_list *unused)
>   {
> -	u64 csnow, wdnow, cslast, wdlast, delta;
> +	u64 csnow, wdnow, cslast, wdlast, delta, wdi;
>   	int next_cpu, reset_pending;
>   	int64_t wd_nsec, cs_nsec;
>   	struct clocksource *cs;
> @@ -440,6 +440,17 @@ static void clocksource_watchdog(struct timer_list *unused)
>   		if (atomic_read(&watchdog_reset_pending))
>   			continue;
>   
> +		/* Check for bogus measurements. */
> +		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
> +		if (wd_nsec < (wdi >> 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}
> +		if (wd_nsec > (wdi << 2)) {
> +			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
> +			continue;
> +		}
> +
>   		/* Check the deviation from the watchdog clocksource. */
>   		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>   		if (abs(cs_nsec - wd_nsec) > md) {

In the worst case, there will be a warning every half second or so. 
Should we rate limit the number of these warnings in some way?

Cheers,
Longman

