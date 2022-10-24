Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2D60B378
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiJXRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiJXRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01D38A0E;
        Mon, 24 Oct 2022 08:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E156147B;
        Mon, 24 Oct 2022 15:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A39CC433D6;
        Mon, 24 Oct 2022 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625998;
        bh=5SnF9vxl+136rBbmVUjkeq17ik/FZ1rRbRG9l9DGkr4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Zlk050TS2+IHl/61JtVUJ5rYMywX9Ln0cMOhFJs8Pfrda4ei4+nHy703ofhkWrM+5
         oIDUrFincOmBBUOhvwftD+TXCyUX32RBb/j6ytxfjlBUwzBEbbnQDftJzu0hUJntq6
         gHSgX9aAEnCnD++sNuZfx8W77BPqDrkeMvUuSCvuWy78yeNOb21ic3NbPEE0ekWC3f
         akCYdw1oIvR5lJuO0GYdAKvW8qcszrFn4fC7XZT01NjCjKlXgmo1Jy2MTkJlQFI3fs
         ejTPEgY1z+X+Dc4zPPQG+jDUVvGQ69Tp9BZQLItPPRQSjFix/PC+Q+lBZWlW4EWBdA
         YW/vG0sx1YUkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3078C5C06CD; Mon, 24 Oct 2022 08:39:58 -0700 (PDT)
Date:   Mon, 24 Oct 2022 08:39:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <20221024153958.GY5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
 <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
 <Y1ZtyjxKCcV0Hfjn@pc636>
 <Y1aDy3maaO39ClSU@pc636>
 <Y1ahs83258Lok9+O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ahs83258Lok9+O@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:31:15PM +0000, Joel Fernandes wrote:
> On Mon, Oct 24, 2022 at 02:23:39PM +0200, Uladzislau Rezki wrote:
> > > > On Sun, Oct 23, 2022 at 08:36:00PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Oct 19, 2022 at 6:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > From: Uladzislau Rezki <urezki@gmail.com>
> > > > > >
> > > > > > call_rcu() changes to save power will slow down RCU workqueue items
> > > > > > queued via queue_rcu_work(). This may not be an issue, however we cannot
> > > > > > assume that workqueue users are OK with long delays. Use
> > > > > > call_rcu_flush() API instead which reverts to the old behavio
> > > > > 
> > > > > On ChromeOS, I can see that queue_rcu_work() is pretty noisy and the
> > > > > batching is much better if we can just keep it as call_rcu() instead
> > > > > of call_rcu_flush().
> > > > > 
> > > > > Is there really any reason to keep it as call_rcu_flush() ?  If I
> > > > > recall, the real reason Vlad's system was slowing down was because of
> > > > > scsi and the queue_rcu_work() conversion was really a red herring.
> > > > 
> > > <snip>
> > > *** drivers/acpi/osl.c:
> > > acpi_os_drop_map_ref[401]      queue_rcu_work(system_wq, &map->track.rwork);
> > > 
> > > *** drivers/gpu/drm/i915/gt/intel_execlists_submission.c:
> > > virtual_context_destroy[3653]  queue_rcu_work(system_wq, &ve->rcu);
> > > 
> > > *** fs/aio.c:
> > > free_ioctx_reqs[632]           queue_rcu_work(system_wq, &ctx->free_rwork);
> > > 
> > > *** fs/fs-writeback.c:
> > > inode_switch_wbs[604]          queue_rcu_work(isw_wq, &isw->work);
> > > cleanup_offline_cgwb[676]      queue_rcu_work(isw_wq, &isw->work);
> > > 
> > > *** include/linux/workqueue.h:
> > > __printf[446]                  extern bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork);
> > > 
> > > *** kernel/cgroup/cgroup.c:
> > > css_release_work_fn[5253]      queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> > > css_create[5384]               queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> > > 
> > > *** kernel/rcu/tree.c:
> > > kfree_rcu_monitor[3192]        queue_rcu_work(system_wq, &krwp->rcu_work);
> > > 
> > > *** net/core/skmsg.c:
> > > sk_psock_drop[852]             queue_rcu_work(system_wq, &psock->rwork);
> > > 
> > > *** net/sched/act_ct.c:
> > > tcf_ct_flow_table_put[355]     queue_rcu_work(act_ct_wq, &ct_ft->rwork);
> > > 
> > > *** net/sched/cls_api.c:
> > > tcf_queue_work[225]            return queue_rcu_work(tc_filter_wq, rwork);
> > > <snip>
> > > There are 9 users of the queue_rcu_work() functions. I think there can be
> > > a side effect if we keep it as lazy variant. Please note that i have not
> > > checked all those users.
> > > 
> > > > There are less than 20 invocations of queue_rcu_work(), so it should
> > > > be possible look through each.  The low-risk approach is of course to
> > > > have queue_rcu_work() use call_rcu_flush().
> 
> Yes, once I get to a device (tomorrow), I'll look more. Last I checked it was
> kvfree_rcu() -- this was a few weeks/months ago though.
> 
> > > > The next approach might be to have a Kconfig option and/or kernel
> > > > boot parameter that allowed a per-system choice.
> > > > 
> > > > But it would not hurt to double-check on Android.
> > > > 
> > > I did not see such noise but i will come back some data on 5.10 kernel
> > > today.
> > > 
> > Home screen swipe:
> > <snip>
> >        <...>-15      [003] d..1   202.142205: rcu_batch_start: rcu_preempt CBs=105 bl=10
> >        <...>-55      [001] d..1   202.166174: rcu_batch_start: rcu_preempt CBs=135 bl=10
> >        <...>-26      [001] d..1   202.402182: rcu_batch_start: rcu_preempt CBs=221 bl=10
> >      rcuop/3-40      [003] d..1   202.650323: rcu_batch_start: rcu_preempt CBs=213 bl=10
> >      rcuop/3-40      [000] d..1   203.210537: rcu_batch_start: rcu_preempt CBs=90 bl=10
> >      rcuop/5-55      [001] d..1   204.675671: rcu_batch_start: rcu_preempt CBs=14 bl=10
> >      rcuop/2-33      [002] d..1   205.162229: rcu_batch_start: rcu_preempt CBs=649 bl=10
> >      rcuop/3-40      [000] d..1   205.418214: rcu_batch_start: rcu_preempt CBs=291 bl=10
> >      rcuop/3-40      [003] d..1   206.134204: rcu_batch_start: rcu_preempt CBs=174 bl=10
> >      rcuop/0-15      [003] d..1   206.726311: rcu_batch_start: rcu_preempt CBs=738 bl=10
> >      rcuop/1-26      [001] d..1   206.814168: rcu_batch_start: rcu_preempt CBs=865 bl=10
> >      rcuop/3-40      [003] d..1   207.278178: rcu_batch_start: rcu_preempt CBs=287 bl=10
> >      rcuop/1-26      [001] d..1   208.826279: rcu_batch_start: rcu_preempt CBs=506 bl=10
> > <snip>
> 
> This looks fine to me, but..
> 
> > An app launch:
> > <snip>
> >          rcuop/3-40      [002] d..1   322.118620: rcu_batch_start: rcu_preempt CBs=99 bl=10
> >          rcuop/4-48      [005] dn.1   322.454052: rcu_batch_start: rcu_preempt CBs=270 bl=10
> >          rcuop/5-55      [005] d..1   322.454109: rcu_batch_start: rcu_preempt CBs=91 bl=10
> >          rcuop/5-55      [007] d..1   322.470054: rcu_batch_start: rcu_preempt CBs=106 bl=10
> >          rcuop/6-62      [005] d..1   322.482120: rcu_batch_start: rcu_preempt CBs=231 bl=10
> >          rcuop/4-48      [001] d..1   322.494150: rcu_batch_start: rcu_preempt CBs=227 bl=10
> >            <...>-69      [002] d..1   322.502442: rcu_batch_start: rcu_preempt CBs=3350 bl=26
> >          rcuop/1-26      [001] d..1   322.646099: rcu_batch_start: rcu_preempt CBs=1685 bl=13
> >          rcuop/2-33      [001] d..1   322.670071: rcu_batch_start: rcu_preempt CBs=438 bl=10
> >          rcuop/1-26      [001] d..1   322.674120: rcu_batch_start: rcu_preempt CBs=18 bl=10
> >          rcuop/2-33      [003] d..1   322.690152: rcu_batch_start: rcu_preempt CBs=10 bl=10
> >          rcuop/1-26      [002] d..1   322.698104: rcu_batch_start: rcu_preempt CBs=10 bl=10
> >          rcuop/3-40      [002] d..1   322.706167: rcu_batch_start: rcu_preempt CBs=313 bl=10
> >          rcuop/2-33      [003] d..1   322.710075: rcu_batch_start: rcu_preempt CBs=15 bl=10
> 
> The above does not look fine to me (^^^) from a Lazu-RCU PoV.  Here, RCU
> callbacks are being invoked every 10-20ms.  The batching I seek is of the
> order of seconds, when the system is relatively idle.
> 
> Why is Lazy-RCU not in effect for app launch? IOW, which callback is causing
> Lazy-RCU to not be lazy here?  Could it be queue_rcu_work()?  Whenever a
> non-lazy callback is queued, all the lazy ones are 'promoted' to non-lazy.
> That's why I am asking. Even if you queue one non-lazy callback at a high
> enough frequency, the lazy ones will no longer giving you batching or the
> benefits of laziness.
> 
> >          rcuop/3-40      [002] d..1   322.742137: rcu_batch_start: rcu_preempt CBs=13 bl=10
> >          rcuop/5-55      [000] d..1   322.754270: rcu_batch_start: rcu_preempt CBs=157 bl=10
> >          rcuop/3-40      [000] d..1   322.762182: rcu_batch_start: rcu_preempt CBs=17 bl=10
> >          rcuop/2-33      [003] d..1   322.774088: rcu_batch_start: rcu_preempt CBs=38 bl=10
> >          rcuop/3-40      [000] d..1   322.778131: rcu_batch_start: rcu_preempt CBs=23 bl=10
> >          rcuop/1-26      [002] d..1   322.790105: rcu_batch_start: rcu_preempt CBs=33 bl=10
> >          rcuop/4-48      [001] d..1   322.798074: rcu_batch_start: rcu_preempt CBs=340 bl=10
> >          rcuop/2-33      [002] d..1   322.806158: rcu_batch_start: rcu_preempt CBs=18 bl=10
> >          rcuop/1-26      [002] d..1   322.814057: rcu_batch_start: rcu_preempt CBs=18 bl=10
> >          rcuop/0-15      [001] d..1   322.822476: rcu_batch_start: rcu_preempt CBs=333 bl=10
> >          rcuop/4-48      [003] d..1   322.830102: rcu_batch_start: rcu_preempt CBs=11 bl=10
> >          rcuop/2-33      [001] d..1   322.846109: rcu_batch_start: rcu_preempt CBs=80 bl=10
> >          rcuop/3-40      [001] d..1   322.854162: rcu_batch_start: rcu_preempt CBs=145 bl=10
> >          rcuop/4-48      [003] d..1   322.874129: rcu_batch_start: rcu_preempt CBs=21 bl=10
> >          rcuop/3-40      [001] d..1   322.878149: rcu_batch_start: rcu_preempt CBs=43 bl=10
> >          rcuop/3-40      [001] d..1   322.906273: rcu_batch_start: rcu_preempt CBs=10 bl=10
> >          rcuop/4-48      [001] d..1   322.918201: rcu_batch_start: rcu_preempt CBs=23 bl=10
> >          rcuop/2-33      [001] d..1   322.926212: rcu_batch_start: rcu_preempt CBs=86 bl=10
> >          rcuop/2-33      [001] d..1   322.946251: rcu_batch_start: rcu_preempt CBs=12 bl=10
> >          rcuop/5-55      [003] d..1   322.954482: rcu_batch_start: rcu_preempt CBs=70 bl=10
> >          rcuop/2-33      [003] d..1   322.978146: rcu_batch_start: rcu_preempt CBs=20 bl=10
> >          rcuop/1-26      [002] d..1   323.014290: rcu_batch_start: rcu_preempt CBs=230 bl=10
> >          rcuop/4-48      [001] d..1   323.026119: rcu_batch_start: rcu_preempt CBs=73 bl=10
> >          rcuop/5-55      [003] d..1   323.026175: rcu_batch_start: rcu_preempt CBs=94 bl=10
> >          rcuop/3-40      [001] d..1   323.035310: rcu_batch_start: rcu_preempt CBs=70 bl=10
> >          rcuop/0-15      [001] d..1   323.046231: rcu_batch_start: rcu_preempt CBs=165 bl=10
> >          rcuop/6-62      [005] d..1   323.066132: rcu_batch_start: rcu_preempt CBs=179 bl=10
> >          rcuop/1-26      [002] d..1   323.174202: rcu_batch_start: rcu_preempt CBs=61 bl=10
> >          rcuop/2-33      [003] d..1   323.190203: rcu_batch_start: rcu_preempt CBs=80 bl=10
> >          rcuop/3-40      [003] d..1   323.206210: rcu_batch_start: rcu_preempt CBs=84 bl=10
> >          rcuop/2-33      [003] d..1   323.226880: rcu_batch_start: rcu_preempt CBs=5 bl=10
> 
> And for several seconds you have the same thing going ^^^.
> 
> > <snip>
> > 
> > It is on Android with 5.10 kernel running. I do not see that queue_rcu_work() makes
> > some noise.
> 
> Your rcu_batch_start tracepoint output above does not really reveal much
> information about which callbacks are lazy and which are not.
> rcu_invoke_callback is better in the sense at least you have the name of the
> callback and can take a guess.
> 
> > Joel Could you please post your batch_start trace point output where you see the noise?
> 
> Sure, I'll do that once I get to a device.

You guys might need to agree on the definition of "good" here.  Or maybe
understand the differences in your respective platforms' definitions of
"good".  ;-)

							Thanx, Paul
