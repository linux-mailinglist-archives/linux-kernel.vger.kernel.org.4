Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5327340F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbjFQM0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFQM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:26:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34C10C0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/bjzQjV9WG/udgkWnOpVEkTtuTWRkA88JggE03WCnFQ=; b=CnoRBG5H/bPzMc8NP2bVF06BwS
        gE3Nwl6kTYovyqKGc41JMLfdtkpQ5AckMsOl9LqKG7K9tJc78TOzuMBSxt+FSJ5LW9NIDjs8oyfT0
        DeNPcUT/YscNA5meVNVfoqmwqpCt/38EjbJf0WF3SRwVf6QSOqsWVv/bWmPY5G73MoGXrb6qof6pj
        3NWVRmNoNCSuuU6E2NPF5VdRi00M3IfMGMrHWb+D3Ome1Jnyl771252O9eIdeOgh+P66/gIxM1Z1+
        YBoAfWkLaTiS8Accm9yvB7voBijILhLMCXn0jTvpW7OyUMBcnkV07H9pBjWOop6o20wcPpVHrid32
        LFeey1hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qAV0a-00Dc35-1M;
        Sat, 17 Jun 2023 12:26:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3B27300095;
        Sat, 17 Jun 2023 14:26:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C715924B5C281; Sat, 17 Jun 2023 14:26:22 +0200 (CEST)
Date:   Sat, 17 Jun 2023 14:26:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Use helper function task_current()
Message-ID: <20230617122622.GC1830050@hirez.programming.kicks-ass.net>
References: <20230617074305.1916633-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617074305.1916633-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 03:43:05PM +0800, Miaohe Lin wrote:
> Use helper function task_current() to check whether task is currently
> running on the runqueue. No functional change intended.

Why though? this makes no sense. Please leave perfectly fine code alone.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/deadline.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f827067ad03b..23284229e16b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2424,7 +2424,7 @@ static void pull_dl_task(struct rq *this_rq)
>  		 */
>  		if (p && dl_time_before(p->dl.deadline, dmin) &&
>  		    dl_task_is_earliest_deadline(p, this_rq)) {
> -			WARN_ON(p == src_rq->curr);
> +			WARN_ON(task_current(src_rq, p));
>  			WARN_ON(!task_on_rq_queued(p));
>  
>  			/*
> @@ -2636,7 +2636,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  		return;
>  	}
>  
> -	if (rq->curr != p) {
> +	if (!task_current(rq, p)) {
>  #ifdef CONFIG_SMP
>  		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
>  			deadline_queue_push_tasks(rq);
> -- 
> 2.27.0
> 
