Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDD67A766
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 01:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjAYAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 19:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAYAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 19:16:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C573349969
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 16:16:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA5861301
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D35C4339B;
        Wed, 25 Jan 2023 00:16:24 +0000 (UTC)
Date:   Tue, 24 Jan 2023 19:16:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 3/4] sched/rt: use put_task_struct_atomic_safe() to
 avoid potential splat
Message-ID: <20230124191622.6d0b8680@gandalf.local.home>
In-Reply-To: <20230120150246.20797-4-wander@redhat.com>
References: <20230120150246.20797-1-wander@redhat.com>
        <20230120150246.20797-4-wander@redhat.com>
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

On Fri, 20 Jan 2023 12:02:41 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> rto_push_irq_work_func() is called in hardirq context, and it calls
> push_rt_task(), which calls put_task_struct().
> 
> If the kernel is compiled with PREEMPT_RT and put_task_struct() reaches
> zero usage count, it triggers a splat because __put_task_struct()
> indirectly acquires sleeping locks.
> 
> The put_task_struct() call pairs with an earlier get_task_struct(),
> which makes the probability of the usage count reaches zero pretty
> low. In any case, let's play safe and use the atomic safe version.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/rt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

For what it's worth:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..30a4e9607bec 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2147,7 +2147,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>  		/*
>  		 * Something has shifted, try again.
>  		 */
> -		put_task_struct(next_task);
> +		put_task_struct_atomic_safe(next_task);
>  		next_task = task;
>  		goto retry;
>  	}
> @@ -2160,7 +2160,7 @@ static int push_rt_task(struct rq *rq, bool pull)
>  
>  	double_unlock_balance(rq, lowest_rq);
>  out:
> -	put_task_struct(next_task);
> +	put_task_struct_atomic_safe(next_task);
>  
>  	return ret;
>  }

