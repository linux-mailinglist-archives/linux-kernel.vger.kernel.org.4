Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9446D572D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjDDDX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDDDXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF411FE3;
        Mon,  3 Apr 2023 20:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97AD62A9F;
        Tue,  4 Apr 2023 03:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18997C4339B;
        Tue,  4 Apr 2023 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680578597;
        bh=JE9c64nKJtiykelt3tg1vCQkNZtHlr4hO/oLF144Eos=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QNpMFDCPovbDd4f/YGdV+5wb+loJzDNkWGhziq91jaI/cAl6au6kONrWhkiO0Mks0
         WztCp33tvxv7SByUa7f4JQl9Hp0LWoOISUZFK1iqVZK6c6tgs9EWTYqzRo8stGey96
         uptaZ5SSawwnwfHC+BjDSoU8z86YjkhSx4qauQVLWg/ICOda6MAzScbJep0QJ/u4pw
         HDRoXRE12Ll7T1db4fMCIzj5w0GW1WNkWef6vmh3PiVb17K+bKbG3RObuwonWzmmZ/
         wLGUEdqij0FSCvF4p9eI0t/b53UEC5Nx9IjKlVxMeHapuU3/NiRApjNeuabI9G3Xuz
         s7QsRyyx/tEHw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A8F3815404B4; Mon,  3 Apr 2023 20:23:16 -0700 (PDT)
Date:   Mon, 3 Apr 2023 20:23:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>
Cc:     "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjJdIHJj?=
 =?utf-8?Q?u=3A_Make_sure_new_krc?= =?utf-8?Q?p?= free business is handled
 after the wanted rcu grace period.
Message-ID: <05e5ee11-d51c-4f96-832e-6208f0133706@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
 <105d5e6e-d0b7-46c6-8f8e-574091e45eb1@paulmck-laptop>
 <5300e9452fc24f7eb3f7921fac4ae2db@BJMBX01.spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5300e9452fc24f7eb3f7921fac4ae2db@BJMBX01.spreadtrum.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:49:15AM +0000, 代子为 (Ziwei Dai) wrote:
> Hello Paul!
> 
> > -----邮件原件-----
> > 发件人: Paul E. McKenney <paulmck@kernel.org>
> > 发送时间: 2023年4月4日 6:58
> > 收件人: 代子为 (Ziwei Dai) <Ziwei.Dai@unisoc.com>
> > 抄送: urezki@gmail.com; frederic@kernel.org; quic_neeraju@quicinc.com;
> > josh@joshtriplett.org; rostedt@goodmis.org;
> > mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com;
> > joel@joelfernandes.org; rcu@vger.kernel.org; linux-kernel@vger.kernel.org;
> > 王双 (Shuang Wang) <shuang.wang@unisoc.com>; 辛依凡 (Yifan Xin)
> > <Yifan.Xin@unisoc.com>; 王科 (Ke Wang) <Ke.Wang@unisoc.com>; 闫学文
> > (Xuewen Yan) <Xuewen.Yan@unisoc.com>; 牛志国 (Zhiguo Niu)
> > <Zhiguo.Niu@unisoc.com>; 黄朝阳 (Zhaoyang Huang)
> > <zhaoyang.huang@unisoc.com>
> > 主题: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after
> > the wanted rcu grace period.
> > 
> > 
> > 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任
> > 何链接和附件。
> > CAUTION: This email originated from outside of the organization. Do not click
> > links or open attachments unless you recognize the sender and know the
> > content is safe.
> > 
> > 
> > 
> > On Fri, Mar 31, 2023 at 08:42:09PM +0800, Ziwei Dai wrote:
> > > In kfree_rcu_monitor(), new free business at krcp is attached to any
> > > free channel at krwp. kfree_rcu_monitor() is responsible to make sure
> > > new free business is handled after the rcu grace period. But if there
> > > is any none-free channel at krwp already, that means there is an
> > > on-going rcu work, which will cause the kvfree_call_rcu()-triggered
> > > free business is done before the wanted rcu grace period ends.
> > >
> > > This commit ignore krwp which has non-free channel at
> > > kfree_rcu_monitor(), to fix the issue that kvfree_call_rcu() loses
> > effectiveness.
> > >
> > > Below is the css_set obj "from_cset" use-after-free case caused by
> > > kvfree_call_rcu() losing effectiveness.
> > > CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq
> > > comes, the task is schedule out.
> > > CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new
> > gp.
> > > But "from_cset" is freed right after current gp end. "from_cset" is
> > reallocated.
> > > CPU 0 's task arrives back, references "from_cset"'s member, which causes
> > crash.
> > >
> > > CPU 0                                 CPU 1
> > > count_memcg_event_mm()
> > > |rcu_read_lock()  <---
> > > |mem_cgroup_from_task()
> > >  |// css_set_ptr is the "from_cset" mentioned on CPU 1  |css_set_ptr =
> > > rcu_dereference((task)->cgroups)  |// Hard irq comes, current task is
> > > scheduled out.
> > >
> > >                                       cgroup_attach_task()
> > >                                       |cgroup_migrate()
> > >                                       |cgroup_migrate_execute()
> > >                                       |css_set_move_task(task,
> > from_cset, to_cset, true)
> > >                                       |cgroup_move_task(task,
> > to_cset)
> > >                                       |rcu_assign_pointer(.., to_cset)
> > >                                       |...
> > >                                       |cgroup_migrate_finish()
> > >
> > |put_css_set_locked(from_cset)
> > >                                       |from_cset->refcount return 0
> > >                                       |kfree_rcu(cset, rcu_head) //
> > means to free from_cset after new gp
> > >                                       |add_ptr_to_bulk_krc_lock()
> > >
> > > |schedule_delayed_work(&krcp->monitor_work, ..)
> > >
> > >                                       kfree_rcu_monitor()
> > >                                       |krcp->bulk_head[0]'s work
> > attached to krwp->bulk_head_free[]
> > >                                       |queue_rcu_work(system_wq,
> > &krwp->rcu_work)
> > >                                       |if rwork->rcu.work is not in
> > WORK_STRUCT_PENDING_BIT state,
> > >                                       |call_rcu(&rwork->rcu,
> > > rcu_work_rcufn) <--- request a new gp
> > >
> > >                                       // There is a perious call_rcu(..,
> > rcu_work_rcufn)
> > >                                       // gp end, rcu_work_rcufn() is
> > called.
> > >                                       rcu_work_rcufn()
> > >                                       |__queue_work(.., rwork->wq,
> > > &rwork->work);
> > >
> > >                                       |kfree_rcu_work()
> > >                                       |krwp->bulk_head_free[0] bulk
> > is freed before new gp end!!!
> > >                                       |The "from_cset" is freed
> > before new gp end.
> > >
> > > // the task is scheduled in after many ms.
> > >  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because
> > css_set_ptr is freed.
> > >
> > > v2: Use helper function instead of inserted code block at
> > kfree_rcu_monitor().
> > >
> > > Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of
> > > kfree_rcu() work")
> > > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> > 
> > Good catch, thank you!!!
> > 
> > How difficult was this to trigger?  If it can be triggered easily, this of course
> > needs to go into mainline sooner rather than later.
> 
> Roughly we can reproduce this issue within two rounds of 48h stress test, 
> with 20 k5.15 devices. If KASAN is enabled, the reproduce rate is higher.
> So I think sooner is better.

Thank you for the info!  This is in theory an old bug, but if you can
easily find out, does it trigger for you on v6.2 or earlier?

> > Longer term, would it make sense to run the three channels through RCU
> > separately, in order to avoid one channel refraining from starting a grace
> > period just because some other channel has callbacks waiting for a grace
> > period to complete?  One argument against might be energy efficiency, but
> > perhaps the ->gp_snap field could be used to get the best of both worlds.
> 
> I see kvfree_rcu_drain_ready(krcp) is already called at the beginning of
> kfree_rcu_monitor(), which polls the ->gp_snap field, to decide
> whether to free channel objects immediately or after gp.
> Both energy efficiency and timing seems be considered?

My concern is that running the channels separately might mean more grace
periods (and thus more energy draw) on nearly idle devices, such devices
usually being the ones for which energy efficiency matters most.

But perhaps Vlad, Neeraj, or Joel has some insight on this, given
that they are the ones working on battery-powered devices.

> > Either way, this fixes only one bug of two.  The second bug is in the
> > kfree_rcu() tests, which should have caught this bug.  Thoughts on a good fix
> > for those tests?
> 
> I inserted a msleep() between "rcu_read_lock(), get pointer via rcu_dereference()"
> and "reference pointer, using the member", at the rcu scenario, then we can
> reproduce this issue very soon in stress test. Can kfree_rcu() tests insert msleep()?

Another approach is to separate concerns, so that readers interact with
grace periods in the rcutorture.c tests, and to add the interaction
of to-be-freed memory with grace periods in the rcuscale kvfree tests.
I took a step in this direction with this commit on the -rcu tree's
"dev" branch:

efbe7927f479 ("rcu/kvfree: Add debug to check grace periods")

Given this, might it be possible to make rcuscale.c's kfree_rcu()
testing create patterns of usage of the three channels so as to
catch this bug that way?

> > I have applied Uladzislau's and Mukesh's tags, and done the usual
> > wordsmithing as shown at the end of this message.  Please let me know if I
> > messed anything up.
> 
> Thank you for the improvement on the patch! It seems better now.

No problem and thank you again for the debugging and the fix!

							Thanx, Paul

> > > ---
> > >  kernel/rcu/tree.c | 27 +++++++++++++++++++--------
> > >  1 file changed, 19 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> > > 8e880c0..7b95ee9 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3024,6 +3024,18 @@ static void kfree_rcu_work(struct work_struct
> > *work)
> > >       return !!READ_ONCE(krcp->head);
> > >  }
> > >
> > > +static bool
> > > +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp) {
> > > +     int i;
> > > +
> > > +     for (i = 0; i < FREE_N_CHANNELS; i++)
> > > +             if (!list_empty(&krwp->bulk_head_free[i]))
> > > +                     return true;
> > > +
> > > +     return !!krwp->head_free;
> > 
> > This is fixed from v1, good!
> > 
> > > +}
> > > +
> > >  static int krc_count(struct kfree_rcu_cpu *krcp)  {
> > >       int sum = atomic_read(&krcp->head_count); @@ -3107,15
> > +3119,14
> > > @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >       for (i = 0; i < KFREE_N_BATCHES; i++) {
> > >               struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> > >
> > > -             // Try to detach bulk_head or head and attach it over any
> > > -             // available corresponding free channel. It can be that
> > > -             // a previous RCU batch is in progress, it means that
> > > -             // immediately to queue another one is not possible so
> > > -             // in that case the monitor work is rearmed.
> > > -             if ((!list_empty(&krcp->bulk_head[0]) &&
> > list_empty(&krwp->bulk_head_free[0])) ||
> > > -                     (!list_empty(&krcp->bulk_head[1]) &&
> > list_empty(&krwp->bulk_head_free[1])) ||
> > > -                             (READ_ONCE(krcp->head)
> > && !krwp->head_free)) {
> > > +             // Try to detach bulk_head or head and attach it, only when
> > > +             // all channels are free.  Any channel is not free means at
> > krwp
> > > +             // there is on-going rcu work to handle krwp's free
> > business.
> > > +             if (need_wait_for_krwp_work(krwp))
> > > +                     continue;
> > >
> > > +             // kvfree_rcu_drain_ready() might handle this krcp, if so
> > give up.
> > > +             if (need_offload_krc(krcp)) {
> > >                       // Channel 1 corresponds to the SLAB-pointer
> > bulk path.
> > >                       // Channel 2 corresponds to vmalloc-pointer bulk
> > path.
> > >                       for (j = 0; j < FREE_N_CHANNELS; j++) {
> > > --
> > > 1.9.1
> > 
> > ------------------------------------------------------------------------
> > 
> > commit e222f9a512539c3f4093a55d16624d9da614800b
> > Author: Ziwei Dai <ziwei.dai@unisoc.com>
> > Date:   Fri Mar 31 20:42:09 2023 +0800
> > 
> >     rcu: Avoid freeing new kfree_rcu() memory after old grace period
> > 
> >     Memory passed to kvfree_rcu() that is to be freed is tracked by a
> >     per-CPU kfree_rcu_cpu structure, which in turn contains pointers
> >     to kvfree_rcu_bulk_data structures that contain pointers to memory
> >     that has not yet been handed to RCU, along with an kfree_rcu_cpu_work
> >     structure that tracks the memory that has already been handed to RCU.
> >     These structures track three categories of memory: (1) Memory for
> >     kfree(), (2) Memory for kvfree(), and (3) Memory for both that arrived
> >     during an OOM episode.  The first two categories are tracked in a
> >     cache-friendly manner involving a dynamically allocated page of pointers
> >     (the aforementioned kvfree_rcu_bulk_data structures), while the third
> >     uses a simple (but decidedly cache-unfriendly) linked list through the
> >     rcu_head structures in each block of memory.
> > 
> >     On a given CPU, these three categories are handled as a unit, with that
> >     CPU's kfree_rcu_cpu_work structure having one pointer for each of the
> >     three categories.  Clearly, new memory for a given category cannot be
> >     placed in the corresponding kfree_rcu_cpu_work structure until any old
> >     memory has had its grace period elapse and thus has been removed.
> > And
> >     the kfree_rcu_monitor() function does in fact check for this.
> > 
> >     Except that the kfree_rcu_monitor() function checks these pointers one
> >     at a time.  This means that if the previous kfree_rcu() memory passed
> >     to RCU had only category 1 and the current one has only category 2, the
> >     kfree_rcu_monitor() function will send that current category-2 memory
> >     along immediately.  This can result in memory being freed too soon,
> >     that is, out from under unsuspecting RCU readers.
> > 
> >     To see this, consider the following sequence of events, in which:
> > 
> >     o       Task A on CPU 0 calls rcu_read_lock(), then uses "from_cset",
> >             then is preempted.
> > 
> >     o       CPU 1 calls kfree_rcu(cset, rcu_head) in order to free
> > "from_cset"
> >             after a later grace period.  Except that "from_cset" is freed
> >             right after the previous grace period ended, so that
> > "from_cset"
> >             is immediately freed.  Task A resumes and references
> > "from_cset"'s
> >             member, after which nothing good happens.
> > 
> >     In full detail:
> > 
> >     CPU 0                                   CPU 1
> >     ----------------------                  ----------------------
> >     count_memcg_event_mm()
> >     |rcu_read_lock()  <---
> >     |mem_cgroup_from_task()
> >      |// css_set_ptr is the "from_cset" mentioned on CPU 1
> >      |css_set_ptr = rcu_dereference((task)->cgroups)
> >      |// Hard irq comes, current task is scheduled out.
> > 
> >                                             cgroup_attach_task()
> >                                             |cgroup_migrate()
> > 
> > |cgroup_migrate_execute()
> >                                             |css_set_move_task(task,
> > from_cset, to_cset, true)
> >                                             |cgroup_move_task(task,
> > to_cset)
> >                                             |rcu_assign_pointer(..,
> > to_cset)
> >                                             |...
> >                                             |cgroup_migrate_finish()
> > 
> > |put_css_set_locked(from_cset)
> >                                             |from_cset->refcount
> > return 0
> >                                             |kfree_rcu(cset, rcu_head)
> > // free from_cset after new gp
> > 
> > |add_ptr_to_bulk_krc_lock()
> > 
> > |schedule_delayed_work(&krcp->monitor_work, ..)
> > 
> >                                             kfree_rcu_monitor()
> >                                             |krcp->bulk_head[0]'s
> > work attached to krwp->bulk_head_free[]
> > 
> > |queue_rcu_work(system_wq, &krwp->rcu_work)
> >                                             |if rwork->rcu.work is not
> > in WORK_STRUCT_PENDING_BIT state,
> >                                             |call_rcu(&rwork->rcu,
> > rcu_work_rcufn) <--- request new gp
> > 
> >                                             // There is a perious
> > call_rcu(.., rcu_work_rcufn)
> >                                             // gp end,
> > rcu_work_rcufn() is called.
> >                                             rcu_work_rcufn()
> >                                             |__queue_work(..,
> > rwork->wq, &rwork->work);
> > 
> >                                             |kfree_rcu_work()
> >                                             |krwp->bulk_head_free[0]
> > bulk is freed before new gp end!!!
> >                                             |The "from_cset" is freed
> > before new gp end.
> > 
> >     // the task resumes some time later.
> >      |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because
> > css_set_ptr is freed.
> > 
> >     This commit therefore causes kfree_rcu_monitor() to refrain from
> > moving
> >     kfree_rcu() memory to the kfree_rcu_cpu_work structure until the RCU
> >     grace period has completed for all three categories.
> > 
> >     v2: Use helper function instead of inserted code block at
> > kfree_rcu_monitor().
> > 
> >     Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu()
> > work")
> >     Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >     Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> >     Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> > 859ee02f6614..e2dbea6cee4b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3051,6 +3051,18 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
> >         return !!READ_ONCE(krcp->head);
> >  }
> > 
> > +static bool
> > +need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp) {
> > +       int i;
> > +
> > +       for (i = 0; i < FREE_N_CHANNELS; i++)
> > +               if (!list_empty(&krwp->bulk_head_free[i]))
> > +                       return true;
> > +
> > +       return !!krwp->head_free;
> > +}
> > +
> >  static int krc_count(struct kfree_rcu_cpu *krcp)  {
> >         int sum = atomic_read(&krcp->head_count); @@ -3134,15
> > +3146,14 @@ static void kfree_rcu_monitor(struct work_struct *work)
> >         for (i = 0; i < KFREE_N_BATCHES; i++) {
> >                 struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
> > 
> > -               // Try to detach bulk_head or head and attach it over any
> > -               // available corresponding free channel. It can be that
> > -               // a previous RCU batch is in progress, it means that
> > -               // immediately to queue another one is not possible so
> > -               // in that case the monitor work is rearmed.
> > -               if ((!list_empty(&krcp->bulk_head[0]) &&
> > list_empty(&krwp->bulk_head_free[0])) ||
> > -                       (!list_empty(&krcp->bulk_head[1]) &&
> > list_empty(&krwp->bulk_head_free[1])) ||
> > -                               (READ_ONCE(krcp->head)
> > && !krwp->head_free)) {
> > +               // Try to detach bulk_head or head and attach it, only
> > when
> > +               // all channels are free.  Any channel is not free means at
> > krwp
> > +               // there is on-going rcu work to handle krwp's free
> > business.
> > +               if (need_wait_for_krwp_work(krwp))
> > +                       continue;
> > 
> > +               // kvfree_rcu_drain_ready() might handle this krcp, if so
> > give up.
> > +               if (need_offload_krc(krcp)) {
> >                         // Channel 1 corresponds to the SLAB-pointer
> > bulk path.
> >                         // Channel 2 corresponds to vmalloc-pointer bulk
> > path.
> >                         for (j = 0; j < FREE_N_CHANNELS; j++) {
