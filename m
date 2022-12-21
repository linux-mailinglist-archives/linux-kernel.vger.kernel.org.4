Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43386533A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiLUPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:52:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772951A38C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:52:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 253D4B81BA7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F1EC433D2;
        Wed, 21 Dec 2022 15:52:04 +0000 (UTC)
Date:   Wed, 21 Dec 2022 10:52:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, yu.c.chen@intel.com
Subject: Re: [PATCH v5 1/2] sched/core: Minor optimize ttwu_runnable()
Message-ID: <20221221105202.52a0d793@gandalf.local.home>
In-Reply-To: <20221208032007.94459-1-zhouchengming@bytedance.com>
References: <20221208032007.94459-1-zhouchengming@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Dec 2022 11:20:06 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

One nit.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3718,9 +3718,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
> -		/* check_preempt_curr() may use rq clock */
> -		update_rq_clock(rq);
> -		ttwu_do_wakeup(rq, p, wake_flags, &rf);
> +		if (!task_on_cpu(rq, p)) {
> +			/*
> +			 * When on_rq && !on_cpu the task is preempted, see if
> +			 * it should preempt whatever is current there now.

			* it should preempt the task that is current now.

Other than that.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> +			 */
> +			update_rq_clock(rq);
> +			check_preempt_curr(rq, p, wake_flags);
> +		}
> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> +		trace_sched_wakeup(p);
>  		ret = 1;
>  	}
>  	__task_rq_unlock(rq, &rf);

