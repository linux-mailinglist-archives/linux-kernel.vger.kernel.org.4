Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE956617423
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697512760
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667442215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8g8rzVnyDMzf34NBIIB+w4gRKgK+DC+eLN6Wiz0+7MI=;
        b=LtWyl7sXSNwzavYtPDfDjqQqryC0u58nSpCkZxN7rwCIujcOC0Fap25y01TvHXe07AH5Dc
        YrcxATWH+sv8vwh917KxhYUREmiBjX7v1C8XL6dAvKesYwI1WyMDVCOFQgMpyaAl4d4vP8
        U6R6aQUWv34iNgmV3NPScxJOKHk/uE4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-V5JUA4PWOYGntZp4ISEVfw-1; Wed, 02 Nov 2022 22:23:26 -0400
X-MC-Unique: V5JUA4PWOYGntZp4ISEVfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06FBD3801F50;
        Thu,  3 Nov 2022 02:23:26 +0000 (UTC)
Received: from [10.22.32.82] (unknown [10.22.32.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67161FD48;
        Thu,  3 Nov 2022 02:23:25 +0000 (UTC)
Message-ID: <7339298b-1156-2d24-7dd9-e7fae690773c@redhat.com>
Date:   Wed, 2 Nov 2022 22:23:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH clocksource 1/2] clocksource: Add comments to classify
 bogus measurements
To:     "Paul E. McKenney" <paulmck@kernel.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        John Stultz <jstultz@google.com>
References: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
 <20221102184009.1306751-1-paulmck@kernel.org>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221102184009.1306751-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 14:40, Paul E. McKenney wrote:
> An extremely busy system can delay the clocksource watchdog, so that
> the corresponding too-long bogus-measurement error does not necessarily
> imply an error in the system.  However, a too-short bogus-measurement
> error likely indicates a bug in hardware, firmware or software.
>
> Therefore, add comments clarifying these bogus-measurement pr_warn()s.
>
> Reported-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
>   kernel/time/clocksource.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index dcaf38c062161..3f5317faf891f 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -443,10 +443,12 @@ static void clocksource_watchdog(struct timer_list *unused)
>   		/* Check for bogus measurements. */
>   		wdi = jiffies_to_nsecs(WATCHDOG_INTERVAL);
>   		if (wd_nsec < (wdi >> 2)) {
> +			/* This usually indicates broken timer code or hardware. */
>   			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced only %lld ns during %d-jiffy time interval, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>   			continue;
>   		}
>   		if (wd_nsec > (wdi << 2)) {
> +			/* This can happen on busy systems, which can delay the watchdog. */
>   			pr_warn("timekeeping watchdog on CPU%d: Watchdog clocksource '%s' advanced an excessive %lld ns during %d-jiffy time interval, probable CPU overutilization, skipping watchdog check.\n", smp_processor_id(), watchdog->name, wd_nsec, WATCHDOG_INTERVAL);
>   			continue;
>   		}

Looks good.

Reviewed-by: Waiman Long <longman@redhat.com>

