Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB946D8638
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjDESqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDESqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:46:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E035B1;
        Wed,  5 Apr 2023 11:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 370BC62751;
        Wed,  5 Apr 2023 18:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEFAC4339B;
        Wed,  5 Apr 2023 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680720389;
        bh=CM88OyRuXt5Nz34MLnx99LMdo/1InHP1WGoiFvOi9zE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SmAzOziaIHXPnNYaxHor7w62u8cZawNv4wBEkhesDWLnUx+hZCpqiobwpQINOywI4
         sX89QGTMM3UCdXX+TwulQHdMnrwJXNn3NVSXyVf1bd56OefdlVDSUSwbmha9Sd22wf
         IjYkXWXhZ3gYoB2Mek+p3wcaXjZOoz3fgOBVdQamih7zmtExX/xtnEKzKnkxlkmVDC
         Y8JWzWPFcjtdU7ALWIcCfV2KrTTf/JGTqxeRBMYAEsBUhP7UuiDUtW4Vucl0BfxaKj
         0tEmMvnPdbHRjg6NdqUZoL5X4+q6lW4XsljJApsevN1YMe+ssEePz4rF5F201cEln/
         pwUXDTbpdhI6Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 36D4615404B4; Wed,  5 Apr 2023 11:46:29 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:46:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ziwei Dai <ziwei.dai@unisoc.com>, urezki@gmail.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuang.wang@unisoc.com, yifan.xin@unisoc.com, ke.wang@unisoc.com,
        xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [PATCH V2] rcu: Make sure new krcp free business is handled
 after the wanted rcu grace period.
Message-ID: <a1e006af-c935-4246-a239-669debb4717d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
 <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
 <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:12:02PM -0400, Joel Fernandes wrote:
> On Wed, Apr 5, 2023 at 1:39 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Mar 31, 2023 at 8:43 AM Ziwei Dai <ziwei.dai@unisoc.com> wrote:
> > >
> > > In kfree_rcu_monitor(), new free business at krcp is attached to any free
> > > channel at krwp. kfree_rcu_monitor() is responsible to make sure new free
> > > business is handled after the rcu grace period. But if there is any none-free
> > > channel at krwp already, that means there is an on-going rcu work,
> > > which will cause the kvfree_call_rcu()-triggered free business is done
> > > before the wanted rcu grace period ends.
> > >
> > > This commit ignore krwp which has non-free channel at kfree_rcu_monitor(),
> > > to fix the issue that kvfree_call_rcu() loses effectiveness.
> > >
> > > Below is the css_set obj "from_cset" use-after-free case caused by
> > > kvfree_call_rcu() losing effectiveness.
> > > CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq comes,
> > > the task is schedule out.
> > > CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
> > > But "from_cset" is freed right after current gp end. "from_cset" is reallocated.
> > > CPU 0 's task arrives back, references "from_cset"'s member, which causes crash.
> > >
> > > CPU 0                                   CPU 1
> > > count_memcg_event_mm()
> > > |rcu_read_lock()  <---
> > > |mem_cgroup_from_task()
> > >  |// css_set_ptr is the "from_cset" mentioned on CPU 1
> > >  |css_set_ptr = rcu_dereference((task)->cgroups)
> > >  |// Hard irq comes, current task is scheduled out.
> > >
> > >                                         cgroup_attach_task()
> > >                                         |cgroup_migrate()
> > >                                         |cgroup_migrate_execute()
> > >                                         |css_set_move_task(task, from_cset, to_cset, true)
> > >                                         |cgroup_move_task(task, to_cset)
> > >                                         |rcu_assign_pointer(.., to_cset)
> > >                                         |...
> > >                                         |cgroup_migrate_finish()
> > >                                         |put_css_set_locked(from_cset)
> > >                                         |from_cset->refcount return 0
> > >                                         |kfree_rcu(cset, rcu_head) // means to free from_cset after new gp
> > >                                         |add_ptr_to_bulk_krc_lock()
> > >                                         |schedule_delayed_work(&krcp->monitor_work, ..)
> > >
> > >                                         kfree_rcu_monitor()
> > >                                         |krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
> > >                                         |queue_rcu_work(system_wq, &krwp->rcu_work)
> > >                                         |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
> > >                                         |call_rcu(&rwork->rcu, rcu_work_rcufn) <--- request a new gp
> > >
> > >                                         // There is a perious call_rcu(.., rcu_work_rcufn)
> > >                                         // gp end, rcu_work_rcufn() is called.
> > >                                         rcu_work_rcufn()
> > >                                         |__queue_work(.., rwork->wq, &rwork->work);
> > >
> > >                                         |kfree_rcu_work()
> > >                                         |krwp->bulk_head_free[0] bulk is freed before new gp end!!!
> > >                                         |The "from_cset" is freed before new gp end.
> > >
> > > // the task is scheduled in after many ms.
> > >  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.
> > >
> > > v2: Use helper function instead of inserted code block at kfree_rcu_monitor().
> > >
> > > Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of kfree_rcu() work")
> > > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> >
> > Please update the fixes tag to:
> > 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")
> 
> Vlad pointed out in another thread that the fix is actually to 34c881745549.
> 
> So just to be sure, it could be updated to:
> Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()")
> Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")

Ziwei Dai, does this change in Fixes look good to you?

If so, I will update the commit log in this commit that I am planning
to submit into v6.3.  It is strictly speaking not a v6.3 regression,
but it is starting to show up in the wild and the patch is contained
enough to be considered an urgent fix.

							Thanx, Paul
