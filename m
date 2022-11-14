Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305862849C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiKNQGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:06:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555451EC45;
        Mon, 14 Nov 2022 08:06:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D676C611C9;
        Mon, 14 Nov 2022 16:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA7EC433D6;
        Mon, 14 Nov 2022 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668441990;
        bh=1bk0AnWKz2pGMBw0RDYCYU72ZJzXPFusRlNLD8zoGwI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gc5TvUwsvZx1IBYQ3SKqXGpVQqNwiZzIDGrTW9zribBXVetCNI2bID3Ly2mTKEvl8
         0wCQ0zJygSrkfh0cbk+5bVn7qJsUNznzw+Pe3FZDPhUHCToor2YFHkj9jtFKIRRTtk
         brPzhRot++9n1NTo+rKLPnXQcTL6BEcT5X1DCay5kmpjIyjmIrxtU7VxB9RT8e8Lja
         +xnwaWt8Ryd9cA97LdwdtClaQHfOIVL6AvM8SdJRNKFZAGHryYOSyDMpONErYBxH9I
         fMzfjHnASnU+SC/LY0nDxOc8J4ucGFlG5MTqybXg1MDmPplGddvQURRaYC6QoiJ8p7
         lSlM3aOOi3d2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3E895C0F9C; Mon, 14 Nov 2022 08:06:29 -0800 (PST)
Date:   Mon, 14 Nov 2022 08:06:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Dump memory object info if callback function is
 invalid
Message-ID: <20221114160629.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111102822.224-1-thunder.leizhen@huawei.com>
 <PH0PR11MB5880E3A11437CD0402941F4DDA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ed264f0e-bc13-5662-1a71-1458952ffd71@huawei.com>
 <PH0PR11MB5880FEAD72BAE59185256195DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221111184238.GX725751@paulmck-ThinkPad-P17-Gen-1>
 <abff0a08-d5a0-6cea-ef69-c74a9aff8731@huawei.com>
 <20221112060815.GC725751@paulmck-ThinkPad-P17-Gen-1>
 <f056db41-daa4-0697-1baa-99121f2a43e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f056db41-daa4-0697-1baa-99121f2a43e2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:18:10PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/12 14:08, Paul E. McKenney wrote:
> > On Sat, Nov 12, 2022 at 10:32:32AM +0800, Leizhen (ThunderTown) wrote:
> >> On 2022/11/12 2:42, Paul E. McKenney wrote:
> >>> On Fri, Nov 11, 2022 at 01:05:56PM +0000, Zhang, Qiang1 wrote:
> >>>> On 2022/11/11 19:54, Zhang, Qiang1 wrote:
> >>>>>> When a structure containing an RCU callback rhp is (incorrectly) 
> >>>>>> freed and reallocated after rhp is passed to call_rcu(), it is not 
> >>>>>> unusual for
> >>>>>> rhp->func to be set to NULL. This defeats the debugging prints used 
> >>>>>> rhp->by
> >>>>>> __call_rcu_common() in kernels built with 
> >>>>>> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, which expect to identify the 
> >>>>>> offending code using the identity of this function.
> >>>>>>
> >>>>>> And in kernels build without CONFIG_DEBUG_OBJECTS_RCU_HEAD=y, things 
> >>>>>> are even worse, as can be seen from this splat:
> >>>>>>
> >>>>>> Unable to handle kernel NULL pointer dereference at virtual address 0 
> >>>>>> ... ...
> >>>>>> PC is at 0x0
> >>>>>> LR is at rcu_do_batch+0x1c0/0x3b8
> >>>>>> ... ...
> >>>>>> (rcu_do_batch) from (rcu_core+0x1d4/0x284)
> >>>>>> (rcu_core) from (__do_softirq+0x24c/0x344)
> >>>>>> (__do_softirq) from (__irq_exit_rcu+0x64/0x108)
> >>>>>> (__irq_exit_rcu) from (irq_exit+0x8/0x10)
> >>>>>> (irq_exit) from (__handle_domain_irq+0x74/0x9c)
> >>>>>> (__handle_domain_irq) from (gic_handle_irq+0x8c/0x98)
> >>>>>> (gic_handle_irq) from (__irq_svc+0x5c/0x94)
> >>>>>> (__irq_svc) from (arch_cpu_idle+0x20/0x3c)
> >>>>>> (arch_cpu_idle) from (default_idle_call+0x4c/0x78)
> >>>>>> (default_idle_call) from (do_idle+0xf8/0x150)
> >>>>>> (do_idle) from (cpu_startup_entry+0x18/0x20)
> >>>>>> (cpu_startup_entry) from (0xc01530)
> >>>>>>
> >>>>>> This commit therefore adds calls to mem_dump_obj(rhp) to output some 
> >>>>>> information, for example:
> >>>>>>
> >>>>>>  slab kmalloc-256 start ffff410c45019900 pointer offset 0 size 256
> >>>>>>
> >>>>>> This provides the rough size of the memory block and the offset of 
> >>>>>> the rcu_head structure, which as least provides at least a few clues 
> >>>>>> to help locate the problem. If the problem is reproducible, 
> >>>>>> additional slab debugging can be enabled, for example, 
> >>>>>> CONFIG_DEBUG_SLAB=y, which can provide significantly more information.
> >>>>>>
> >>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>>> ---
> >>>>>> kernel/rcu/rcu.h      | 7 +++++++
> >>>>>> kernel/rcu/srcutiny.c | 1 +
> >>>>>> kernel/rcu/srcutree.c | 1 +
> >>>>>> kernel/rcu/tasks.h    | 1 +
> >>>>>> kernel/rcu/tiny.c     | 1 +
> >>>>>> kernel/rcu/tree.c     | 1 +
> >>>>>> 6 files changed, 12 insertions(+)
> >>>>>>
> >>>>>> v1 --> v2:
> >>>>>> 1. Remove condition "(unsigned long)rhp->func & 0x3", it have problems on x86.
> >>>>>> 2. Paul E. McKenney helped me update the commit message, thanks.
> >>>>>>
> >>>>>
> >>>>> Hi, Zhen Lei
> >>>>>
> >>>>> Maybe the following scenarios should be considered:
> >>>>>
> >>>>>                 CPU 0
> >>>>> tasks context
> >>>>>    spin_lock(&vmap_area_lock)
> >>>>>           Interrupt 
> >>>>> 	 RCU softirq
> >>>>> 	      rcu_do_batch
> >>>>> 		mem_dump_obj
> >>>>>                                   vmalloc_dump_obj
> >>>>>                                        spin_lock(&vmap_area_lock)   <--  deadlock     
> >>>>
> >>>>> Right, thanks. I just saw the robot's report. So this patch should be dropped.
> >>>>> I'll try to add an helper in mm, where I can check whether the lock has been held, and dump the content of memory object.
> >>>>
> >>>> This is a workaround, or maybe try a modification like the following, 
> >>>> of course, need to ask Paul's opinion.
> >>>
> >>> Another approach is to schedule a workqueue handler to do the
> >>> mem_dump_obj().  This would allow mem_dump_obj() to run in a clean
> >>> environment.
> >>
> >> It's about to panic, so no chance to schedule.
> > 
> > It won't panic if you drop the callback on the floor.
> > 
> > Though to your point, the ->next pointer is likely also trashed.  So you
> > could just drop the remainder of the callback list on the floor.  That
> > might provide a good (though not perfect) chance of getting decent output.
> 
> OK, I think I understand what you mean.
> if (!f)
> 	schedule_work(&work);
> else
> 	f(rhp)

Yes, except that the "schedule_work()" also needs to be accompanied
by something that refuses to execute the rest of those callbacks.
This needs to break out of the loop (or return) and to adjust counts,
among other things.  This might be as easy as setting count to the
negative of the length of the "rcl" list, but does need some attention
to the code following the callback-invocation loop.

							Thanx, Paul

> >>> This would allow vmalloc_dump_obj() to be called unconditionally.
> >>>
> >>> Other thoughts?
> >>
> >> locked = spin_is_locked(&vmap_area_lock);
> >> if (!locked)
> >>     spin_lock(&vmap_area_lock)
> >>
> >> Careful analysis is required, which may cause other problems.
> >>
> >> Or in new function:
> >> if (locked)
> >>     return;
> >> spin_lock(&vmap_area_lock);
> >>
> >> If there is a chance to dump the data, dump the data. If there is no
> >> chance to dump the data, do not dump the data. This is the fate of
> >> debugging information.
> > 
> > My concern is that there will be increasing numbers of special cases
> > over time.
> 
> OK, I got it.
> 
> > 
> > 							Thanx, Paul
> > 
> >>>> diff --git a/mm/util.c b/mm/util.c
> >>>> index 12984e76767e..86da0739fe5d 100644
> >>>> --- a/mm/util.c
> >>>> +++ b/mm/util.c
> >>>> @@ -1119,14 +1119,18 @@ void mem_dump_obj(void *object)
> >>>>  {
> >>>>         const char *type;
> >>>>
> >>>> +       if (is_vmalloc_addr(object)) {
> >>>> +               if (in_task() && vmalloc_dump_obj(object))
> >>>> +                       return;
> >>>> +               type = "vmalloc memory";
> >>>> +               goto end;
> >>>> +       }
> >>>> +
> >>>>         if (kmem_valid_obj(object)) {
> >>>>                 kmem_dump_obj(object);
> >>>>                 return;
> >>>>         }
> >>>>
> >>>> -       if (vmalloc_dump_obj(object))
> >>>> -               return;
> >>>> -
> >>>>         if (virt_addr_valid(object))
> >>>>                 type = "non-slab/vmalloc memory";
> >>>>         else if (object == NULL)
> >>>> @@ -1135,7 +1139,7 @@ void mem_dump_obj(void *object)
> >>>>                 type = "zero-size pointer";
> >>>>         else
> >>>>                 type = "non-paged memory";
> >>>> -
> >>>> +end:
> >>>>         pr_cont(" %s\n", type);
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(mem_dump_obj);
> >>>>
> >>>> Thanks
> >>>> Zqiang
> >>>>
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>> Zqiang
> >>>>>
> >>>>>
> >>>>>> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index 
> >>>>>> 65704cbc9df7b3d..32ab45fabf8eebf 100644
> >>>>>> --- a/kernel/rcu/rcu.h
> >>>>>> +++ b/kernel/rcu/rcu.h
> >>>>>> @@ -10,6 +10,7 @@
> >>>>>> #ifndef __LINUX_RCU_H
> >>>>>> #define __LINUX_RCU_H
> >>>>>>
> >>>>>> +#include <linux/mm.h>
> >>>>>> #include <trace/events/rcu.h>
> >>>>>>
> >>>>>> /*
> >>>>>> @@ -211,6 +212,12 @@ static inline void debug_rcu_head_unqueue(struct 
> >>>>>> rcu_head *head) }
> >>>>>> #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> >>>>>>
> >>>>>> +static inline void debug_rcu_head_callback(struct rcu_head *rhp) {
> >>>>>> +	if (unlikely(!rhp->func))
> >>>>>> +		mem_dump_obj(rhp);
> >>>>>> +}
> >>>>>> +
> >>>>>> extern int rcu_cpu_stall_suppress_at_boot;
> >>>>>>
> >>>>>> static inline bool rcu_stall_is_suppressed_at_boot(void)
> >>>>>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c index 
> >>>>>> 33adafdad261389..5e7f336baa06ae0 100644
> >>>>>> --- a/kernel/rcu/srcutiny.c
> >>>>>> +++ b/kernel/rcu/srcutiny.c
> >>>>>> @@ -138,6 +138,7 @@ void srcu_drive_gp(struct work_struct *wp)
> >>>>>> 	while (lh) {
> >>>>>> 		rhp = lh;
> >>>>>> 		lh = lh->next;
> >>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>> 		local_bh_disable();
> >>>>>> 		rhp->func(rhp);
> >>>>>> 		local_bh_enable();
> >>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index 
> >>>>>> ca4b5dcec675bac..294972e66b31863 100644
> >>>>>> --- a/kernel/rcu/srcutree.c
> >>>>>> +++ b/kernel/rcu/srcutree.c
> >>>>>> @@ -1631,6 +1631,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >>>>>> 	rhp = rcu_cblist_dequeue(&ready_cbs);
> >>>>>> 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
> >>>>>> 		debug_rcu_head_unqueue(rhp);
> >>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>> 		local_bh_disable();
> >>>>>> 		rhp->func(rhp);
> >>>>>> 		local_bh_enable();
> >>>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index 
> >>>>>> b0b885e071fa8dc..b7f8c67c586cdc4 100644
> >>>>>> --- a/kernel/rcu/tasks.h
> >>>>>> +++ b/kernel/rcu/tasks.h
> >>>>>> @@ -478,6 +478,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
> >>>>>> 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >>>>>> 	len = rcl.len;
> >>>>>> 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = 
> >>>>>> rcu_cblist_dequeue(&rcl)) {
> >>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>> 		local_bh_disable();
> >>>>>> 		rhp->func(rhp);
> >>>>>> 		local_bh_enable();
> >>>>>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c index 
> >>>>>> bb8f7d270f01747..56e9a5d91d97ec5 100644
> >>>>>> --- a/kernel/rcu/tiny.c
> >>>>>> +++ b/kernel/rcu/tiny.c
> >>>>>> @@ -97,6 +97,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head 
> >>>>>> *head)
> >>>>>>
> >>>>>> 	trace_rcu_invoke_callback("", head);
> >>>>>> 	f = head->func;
> >>>>>> +	debug_rcu_head_callback(head);
> >>>>>> 	WRITE_ONCE(head->func, (rcu_callback_t)0L);
> >>>>>> 	f(head);
> >>>>>> 	rcu_lock_release(&rcu_callback_map);
> >>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 
> >>>>>> 15aaff3203bf2d0..ed93ddb8203d42c 100644
> >>>>>> --- a/kernel/rcu/tree.c
> >>>>>> +++ b/kernel/rcu/tree.c
> >>>>>> @@ -2088,6 +2088,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >>>>>> 		trace_rcu_invoke_callback(rcu_state.name, rhp);
> >>>>>>
> >>>>>> 		f = rhp->func;
> >>>>>> +		debug_rcu_head_callback(rhp);
> >>>>>> 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> >>>>>> 		f(rhp);
> >>>>>>
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>
> >>>>> .
> >>>>>
> >>>>
> >>>> --
> >>>> Regards,
> >>>>   Zhen Lei
> >>> .
> >>>
> >>
> >> -- 
> >> Regards,
> >>   Zhen Lei
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
