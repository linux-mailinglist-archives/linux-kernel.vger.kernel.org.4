Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B46C2F85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCUKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCUKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:50:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BFFCC25
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K+47pFmtJRN8XvBP84rKwr7jkvxmpJlYJ7O+WJ3xa+c=; b=CMonzY/ypbt+qD+s8ym+vzOU2b
        ov8s8ZLZc9LvvZdq9Jj4DNluolJyk6T1Gd7KDV1PCtHkbFN9aTtHqg5sqQrhSZyYb+foUcU8xbHSW
        zGap5YfhJslugj7ZMsO5ndZt0ip+B/xocnkTrN3hykfghD09JKxZNZRP8nWc5PUF7bXOwE9UbR5mh
        ezTMZ7xyJz9HM3Fe/IjLv9KdcYSnYw7lS/B3BXi6pO1IeiFnCgqitYbgcFOjdvzeNutkOT9P+2Ezo
        eNurKApuEX6Ur3AW/nsisRYkzWfU6R5rzYzqtxTrBoWXiyHQWa/N/4ErJ2Sqexh7SMzdnGxWOfxF2
        2VmNZ/Aw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peZYt-004EWu-2R;
        Tue, 21 Mar 2023 10:49:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA8B83002FC;
        Tue, 21 Mar 2023 11:49:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BA3D2408A2FA; Tue, 21 Mar 2023 11:49:49 +0100 (CET)
Date:   Tue, 21 Mar 2023 11:49:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230321104949.GI2234901@hirez.programming.kicks-ass.net>
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
 <20230321100206.GE2234901@hirez.programming.kicks-ass.net>
 <7bba69e0-5261-9921-16b7-c8592b5d213b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bba69e0-5261-9921-16b7-c8592b5d213b@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:29:13AM +0100, Dietmar Eggemann wrote:
> On 21/03/2023 11:02, Peter Zijlstra wrote:
> > On Fri, Mar 17, 2023 at 05:08:10PM +0100, Vincent Guittot wrote:
> >> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> >> fixes an overflowing bug, but ignore a case that se->exec_start is reset
> >> after a migration.
> >>
> >> For fixing this case, we delay the reset of se->exec_start after
> >> placing the entity which se->exec_start to detect long sleeping task.
> >>
> >> In order to take into account a possible divergence between the clock_task
> >> of 2 rqs, we increase the threshold to around 104 days.
> >>
> >>
> >> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> >> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> > 
> > Blergh, this just isn't going to be nice. I'll go queue this for
> > sched/urgent and then we can forget about this for a little while.
> > 
> > Thanks!
> 
> Don't we miss setting `se->exec_start = 0` for fair task in
> move_queued_task()? ( ... and __migrate_swap_task())
> 
> https://lkml.kernel.org/r/df2cccda-1550-b06b-aa74-e0f054e9fb9d@arm.com

Ah, I see what you mean now... When I read your and Vincent's replies
earlier today I though you mean to avoid the extra ENQUEUE_MIGRATED use,
but your actual goal was to capure more sites.

Hmm, we could of course go add more ENQUEUE_MIGRATED, but you're right
in that TASK_ON_RQ_MIGRATING already captures that.

An alternative is something like the below, that matches
deactivate_task(), but still uses ENQUEUE_MIGRATED to pass it down into
the class methods.

Hmm?


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2084,6 +2084,9 @@ static inline void dequeue_task(struct r
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (task_on_rq_migrating(p))
+		flags |= ENQUEUE_MIGRATED;
+
 	enqueue_task(rq, p, flags);
 
 	p->on_rq = TASK_ON_RQ_QUEUED;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8726,7 +8726,7 @@ static void attach_task(struct rq *rq, s
 	lockdep_assert_rq_held(rq);
 
 	WARN_ON_ONCE(task_rq(p) != rq);
-	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_MIGRATED);
+	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	check_preempt_curr(rq, p, 0);
 }
 
