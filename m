Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD96E54C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDQWtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:49:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23721BF6;
        Mon, 17 Apr 2023 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681771789; x=1713307789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yEfjoJ9tK27gThlmren9CZn/INA0Jiv3W+xlgj/ZAF4=;
  b=Kh/VfIu9N5kJA0BVVnNBGCKd0cEKUxwhtyujiow+fLYuMAq8KBkJFqAr
   corQOEzyrUXZ7NrSdnQpWjzUOTx7qioko2rmwiYHB5BZ3J3QyztCXS+aJ
   LskZMpx/nKv/SAdpkt3fsVfHsFx6y9UYg15+RX6qwzxxOPeL5z390yUZk
   XuhxC0JpNYXwbaYu1FTaT/VjwZYjXg5tNJU2lK+FtIoVZFzxXqqQoMtES
   qRgeHmZnpylaIaspbvFU9arRUwDqjqyI168uW2HhvGBpaQGf9kSA+Q+eb
   qDQ0YvGBTG7kh9bslgOQ1skAWmyOX+ByMAzi1+abc6t8YT7hONmp1ftd8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="347772792"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="347772792"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 15:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="721294982"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="721294982"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2023 15:49:48 -0700
Date:   Mon, 17 Apr 2023 15:52:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 07/24] sched/fair: Compute IPC class scores for load
 balancing
Message-ID: <20230417225252.GA6156@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-8-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_jZ6q0+9cWxjNZD9gLi-Ts_o_HfBZdiebZz89rHA6iw@mail.gmail.com>
 <20230330020724.GA26315@ranerica-svr.sc.intel.com>
 <CAKfTPtB3CDDXgFxswsY=mq-H9A+DeW1qE9HWfUbCeaN2V3XBjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB3CDDXgFxswsY=mq-H9A+DeW1qE9HWfUbCeaN2V3XBjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:20:11PM +0200, Vincent Guittot wrote:
> On Thu, 30 Mar 2023 at 03:56, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 12:00:58PM +0200, Vincent Guittot wrote:
> > > On Tue, 7 Feb 2023 at 06:01, Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > Compute the joint total (both current and prospective) IPC class score of
> > > > a scheduling group and the local scheduling group.
> > > >
> > > > These IPCC statistics are used during idle load balancing. The candidate
> > > > scheduling group will have one fewer busy CPU after load balancing. This
> > > > observation is important for cores with SMT support.
> > > >
> > > > The IPCC score of scheduling groups composed of SMT siblings needs to
> > > > consider that the siblings share CPU resources. When computing the total
> > > > IPCC score of the scheduling group, divide score of each sibling by the
> > > > number of busy siblings.
> > > >
> > > > Collect IPCC statistics for asym_packing and fully_busy scheduling groups.
> > >
> > > IPCC statistics collect scores of current tasks, so they are
> > > meaningful only when trying to migrate one of those running tasks.
> > > Using such score when pulling other tasks is just meaningless. And I
> > > don't see how you ensure such correct use of ipcc score
> >
> > Thank you very much for your feedback Vincent!
> >
> > It is true that the task that is current when collecting statistics may be
> > different from the task that is current when we are ready to pluck tasks.
> >
> > Using IPCC scores for load balancing benefits large, long-running tasks
> > the most. For these tasks, the current task is likely to remain the same
> > at the two mentioned points in time.
> 
> My point was mainly about the fact that the current running task is
> the last one to be pulled. And this happens only when no other task
> was pulled otherwise.

(Thanks again for your feedback, Vincent. I am sorry for the late reply. I
needed some more time to think about it.)

Good point! It is smarter to compare and pull from the back of the queue,
rather than comparing curr and pulling from the back. We are more likely
to break the tie correctly without being too complex.

Here is an incremental patch with the update. I'll include this change in
my next version.

@@ -9281,24 +9281,42 @@ static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
 	sgs->min_score = ULONG_MAX;
 }
 
+static int rq_last_task_ipcc(int dst_cpu, struct rq *rq, unsigned short *ipcc)
+{
+	struct list_head *tasks = &rq->cfs_tasks;
+	struct task_struct *p;
+	struct rq_flags rf;
+	int ret = -EINVAL;
+
+	rq_lock_irqsave(rq, &rf);
+	if (list_empty(tasks))
+		goto out;
+
+	p = list_last_entry(tasks, struct task_struct, se.group_node);
+	if (p->flags & PF_EXITING || is_idle_task(p) ||
+	    !cpumask_test_cpu(dst_cpu, p->cpus_ptr))
+		goto out;
+
+	ret = 0;
+	*ipcc = p->ipcc;
+out:
+	rq_unlock(rq, &rf);
+	return ret;
+}
+
 /* Called only if cpu_of(@rq) is not idle and has tasks running. */
 static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
 				    struct rq *rq)
 {
-	struct task_struct *curr;
 	unsigned short ipcc;
 	unsigned long score;
 
 	if (!sched_ipcc_enabled())
 		return;
 
-	curr = rcu_dereference(rq->curr);
-	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr) ||
-	    task_is_realtime(curr) ||
-	    !cpumask_test_cpu(dst_cpu, curr->cpus_ptr))
+	if (rq_last_task_ipcc(dst_cpu, rq, &ipcc))
 		return;
 
-	ipcc = curr->ipcc;
 	score = arch_get_ipcc_score(ipcc, cpu_of(rq));
 
> 
> >
> > My patchset proposes to use IPCC clases to break ties between otherwise
> > identical sched groups in update_sd_pick_busiest(). Its use is limited to
> > asym_packing and fully_busy types. For these types, it is likely that there
> > will not be tasks wanting to run other than current. need_active_balance()
> > will return true and we will migrate the current task.
> 
> I disagree with your assumption above, asym_packing and fully_busy
> types doesn't put any mean on the number of running tasks

Agreed. What I stated was not correct.

o> 
> >
> > You are correct, by only looking at the current tasks we risk overlooking
> > other tasks in the queue and the statistics becoming meaningless. A fully
> > correct solution would need to keep track of the the types of tasks in
> > all runqueues as they come and go. IMO, the increased complexity of such
> > approach does not justify the benefit. We give the load balancer extra
> > information to decide between otherwise identical sched groups using the
> > IPCC statistics of big tasks.
> 
> because IPCC are meaningful only when there is only 1 running task and
> during active migration, you should collect them only for such
> situation

I think that if we compute the IPCC statistics using the tasks at the back
of the runqueue, then IPCC statistics remain meaningful for nr_running >= 1.

