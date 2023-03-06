Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D826ABDAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCFLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCFLGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:06:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6D26879
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1CE8fSTpaRcdlAJvWYeyw+Ukb/NZvDGilp+kVQs+LA=; b=dCLQ33gMQi9eZnUuXag/owBMe3
        JcJWpsVVR6X9LMgNUcsF+AG+dsFG1wGAeX7NXhT3N3vkdNa3uOVzNvophS/HEzy6vtz5CLPml157O
        VWLS6hegbmER1T5HMNRXXulyh/TP/Vf++o6CUQNOldclP09SgocOHHip3+/AN+yuYqzzFI/q8Dh33
        c5B4ivnEKlcQy2ogFcPjFEKNz+f8WvW7NGKJoi951vdHzLXX8w0Y2GeTEOpBbESHRzEL+7KyuL+A2
        tTzLloWYlcyfTMIKmVjFDv3lQUBcqUkwWDez8FoQO5wXHalUINLUAg/dlHHndTOY4QBAwrrFTQcRm
        AHlAWakg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ8fT-005Hfa-Eu; Mon, 06 Mar 2023 11:06:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B54D4300487;
        Mon,  6 Mar 2023 12:06:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6395623B53549; Mon,  6 Mar 2023 12:06:09 +0100 (CET)
Date:   Mon, 6 Mar 2023 12:06:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Make hrtimer callback execute in the hard
 interrupt context
Message-ID: <20230306110609.GA1267364@hirez.programming.kicks-ass.net>
References: <20230306070938.3099273-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306070938.3099273-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:09:38PM +0800, Zqiang wrote:
> The scheduler related hrtimers callback will be executed in softirqd
> context for PREEMPT_RT enabled kernel, this commit therefore mark
> hrtimers as harded even on PREEMPT_RT enabled kernels, there is no
> functional change.

There very much is a functional change, also your reasoning is
non-existant.

Also:

  https://lkml.kernel.org/r/Y1F5sDVGen7ZVW+U@hirez.programming.kicks-ass.net

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c36aa54ae071..98c48d144089 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5610,7 +5610,7 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
>  
>  	hrtimer_start(&cfs_b->slack_timer,
>  			ns_to_ktime(cfs_bandwidth_slack_period),
> -			HRTIMER_MODE_REL);
> +			HRTIMER_MODE_REL_HARD);
>  }
>  
>  /* we know any runtime found here is valid as update_curr() precedes return */
> @@ -5813,9 +5813,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  	cfs_b->burst = 0;
>  
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> -	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> +	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>  	cfs_b->period_timer.function = sched_cfs_period_timer;
> -	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
>  	cfs_b->slack_started = false;
>  }
> @@ -5835,7 +5835,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  
>  	cfs_b->period_active = 1;
>  	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> +	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED_HARD);
>  }
>  
>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> -- 
> 2.25.1
> 
