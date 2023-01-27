Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77567ED9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjA0Shf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjA0She (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:37:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7095677AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XV4f5nbXkEzWmDpQkXbkK8rNaOOMbsr58eOW1moNB+s=; b=Kpn1yX3q8FtLqTsvSN3LlSpOH6
        98SFyNkqIEnKLfHvm8plIQSRjgmAMGnHP+Tty6RPC7wrNMd+qFnqB43/x8uUsGowFuueCkKp9m2tE
        6g5/LVH7gPfAxyQ02/lx9jCDesthV/+T+LuAfSZWUzSOXbs60uMFKiOwtm9jiin2S+LDeb6pGRn23
        bTHNFRJ9rWiHBj8AXng6F8mxFMIrvLTP14EtJYIl1ownv1Tie8M46zutUsx1r+Z2PgDKPgjZpYF7U
        JHJQEzBLeVNVSXo9GLISZSwNZW/URalEMXdQN3cLBCuBMaJ9wQU+pGRun5H+ka7KG3InfoOnMtypN
        82nhSgzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLTap-007wZc-NA; Fri, 27 Jan 2023 18:36:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9364D300137;
        Fri, 27 Jan 2023 19:36:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F7E72081B27D; Fri, 27 Jan 2023 19:36:53 +0100 (CET)
Date:   Fri, 27 Jan 2023 19:36:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, qperret@google.com
Subject: Re: [PATCH v10 2/5] sched: Use user_cpus_ptr for saving user
 provided cpumask in sched_setaffinity()
Message-ID: <Y9QZxVPLYpH/srMw@hirez.programming.kicks-ass.net>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-3-longman@redhat.com>
 <20230117160825.GA17756@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117160825.GA17756@willie-the-truck>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:08:26PM +0000, Will Deacon wrote:
> Hi Waiman,
> 
> On Thu, Sep 22, 2022 at 02:00:38PM -0400, Waiman Long wrote:
> > The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
> > Introduce task_struct::user_cpus_ptr to track requested affinity"). It
> > is currently used only by arm64 arch due to possible asymmetric CPU
> > setup. This patch extends its usage to save user provided cpumask
> > when sched_setaffinity() is called for all arches. With this patch
> > applied, user_cpus_ptr, once allocated after a successful call to
> > sched_setaffinity(), will only be freed when the task exits.
> > 
> > Since user_cpus_ptr is supposed to be used for "requested
> > affinity", there is actually no point to save current cpu affinity in
> > restrict_cpus_allowed_ptr() if sched_setaffinity() has never been called.
> > Modify the logic to set user_cpus_ptr only in sched_setaffinity() and use
> > it in restrict_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
> > if defined but not changing it.
> > 
> > This will be some changes in behavior for arm64 systems with asymmetric
> > CPUs in some corner cases. For instance, if sched_setaffinity()
> > has never been called and there is a cpuset change before
> > relax_compatible_cpus_allowed_ptr() is called, its subsequent call will
> > follow what the cpuset allows but not what the previous cpu affinity
> > setting allows.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  kernel/sched/core.c  | 82 ++++++++++++++++++++------------------------
> >  kernel/sched/sched.h |  7 ++++
> >  2 files changed, 44 insertions(+), 45 deletions(-)
> 
> We've tracked this down as the cause of an arm64 regression in Android and I've
> reproduced the issue with mainline.
> 
> Basically, if an arm64 system is booted with "allow_mismatched_32bit_el0" on
> the command-line, then the arch code will (amongst other things) call
> force_compatible_cpus_allowed_ptr() and relax_compatible_cpus_allowed_ptr()
> when exec()'ing a 32-bit or a 64-bit task respectively.
> 
> If you consider a system where everything is 64-bit but the cmdline option
> above is present, then the call to relax_compatible_cpus_allowed_ptr() isn't
> expected to do anything in this case, and the old code made sure of that:
> 
> > @@ -3055,30 +3032,21 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
> >  
> >  /*
> >   * Restore the affinity of a task @p which was previously restricted by a
> > - * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
> > - * @p->user_cpus_ptr.
> > + * call to force_compatible_cpus_allowed_ptr().
> >   *
> >   * It is the caller's responsibility to serialise this with any calls to
> >   * force_compatible_cpus_allowed_ptr(@p).
> >   */
> >  void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> >  {
> > -	struct cpumask *user_mask = p->user_cpus_ptr;
> > -	unsigned long flags;
> > +	int ret;
> >  
> >  	/*
> > -	 * Try to restore the old affinity mask. If this fails, then
> > -	 * we free the mask explicitly to avoid it being inherited across
> > -	 * a subsequent fork().
> > +	 * Try to restore the old affinity mask with __sched_setaffinity().
> > +	 * Cpuset masking will be done there too.
> >  	 */
> > -	if (!user_mask || !__sched_setaffinity(p, user_mask))
> > -		return;
> 
> ... since it returned early here if '!user_mask' ...
> 
> > -
> > -	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > -	user_mask = clear_user_cpus_ptr(p);
> > -	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> > -
> > -	kfree(user_mask);
> > +	ret = __sched_setaffinity(p, task_user_cpus(p));
> > +	WARN_ON_ONCE(ret);
> 
> ... however, now we end up going down into __sched_setaffinity() with
> task_user_cpus(p) giving us the 'cpu_possible_mask'! This can lead to a mixture
> of WARN_ON()s and incorrect affinity masks (for example, a newly exec'd task
> ends up with the affinity mask of the online CPUs at the point of exec() and is
> unable to run on anything onlined later).
> 
> I've had a crack at fixing the code above to restore the old behaviour, and it
> seems to work for my basic tests (still pending confirmation from others):

This seems to cure things... cpuset is insane and insists on limiting
things to online CPUs for no real reason. It is perfectly fine to have
offline CPUs in the allowed mask (in fact, that's the default
behaviour).

With this on and "relax_compatible_cpus_allowed_ptr(current);" added to
the exec() path things seem to work as expected for me.

I'll clean up and post properly tomorrow (I think there's a simpler
version hiding in there)...

---

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706b..7a63416a46f3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -498,19 +498,33 @@ static inline bool partition_is_populated(struct cpuset *cs,
  *
  * Call with callback_lock or cpuset_rwsem held.
  */
-static void guarantee_online_cpus(struct task_struct *tsk,
-				  struct cpumask *pmask)
+static void guarantee_cs_cpus(struct task_struct *tsk, struct cpumask *pmask, bool online)
 {
-	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
+	const struct cpumask *task_possible_mask = task_cpu_possible_mask(tsk);
+	const struct cpumask *possible_mask = cpu_possible_mask;
+	const struct cpumask *cs_cpus;
 	struct cpuset *cs;
 
-	if (WARN_ON(!cpumask_and(pmask, possible_mask, cpu_online_mask)))
-		cpumask_copy(pmask, cpu_online_mask);
+	if (online)
+		possible_mask = cpu_online_mask;
+
+	if (WARN_ON(!cpumask_and(pmask, task_possible_mask, possible_mask)))
+		cpumask_copy(pmask, possible_mask);
 
 	rcu_read_lock();
 	cs = task_cs(tsk);
 
-	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
+	if (!parent_cs(cs)) {
+		cs_cpus = cpu_possible_mask;
+		if (online)
+			cs_cpus = cpu_online_mask;
+	} else {
+		cs_cpus = cs->cpus_allowed;
+		if (online)
+			cs_cpus = cs->effective_cpus;
+	}
+
+	while (!cpumask_intersects(cs_cpus, pmask)) {
 		cs = parent_cs(cs);
 		if (unlikely(!cs)) {
 			/*
@@ -523,7 +537,8 @@ static void guarantee_online_cpus(struct task_struct *tsk,
 			goto out_unlock;
 		}
 	}
-	cpumask_and(pmask, pmask, cs->effective_cpus);
+
+	cpumask_and(pmask, pmask, cs_cpus);
 
 out_unlock:
 	rcu_read_unlock();
@@ -2540,7 +2555,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(task, css, tset) {
 		if (cs != &top_cpuset)
-			guarantee_online_cpus(task, cpus_attach);
+			guarantee_cs_cpus(task, cpus_attach, true);
 		else
 			cpumask_copy(cpus_attach, task_cpu_possible_mask(task));
 		/*
@@ -3699,7 +3714,7 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	guarantee_online_cpus(tsk, pmask);
+	guarantee_cs_cpus(tsk, pmask, false);
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
