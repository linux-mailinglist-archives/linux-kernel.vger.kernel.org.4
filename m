Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47C96D8E09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjDFDqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDFDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DBC1FD2;
        Wed,  5 Apr 2023 20:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B9E64111;
        Thu,  6 Apr 2023 03:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3DEC4339C;
        Thu,  6 Apr 2023 03:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680752776;
        bh=k/jSvCY0GIxrYpmXt+5J1LnAgcQgsVkssDKVZDdHcC4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TLJfs9lj5jlzZMKh1FsHWME57ax6FdKswBAY+2wWUCt3OvyUkwD/pBO7C/q6E0qeN
         8WuSlnzCh3c7bAELKg04qiQV6qe5TwYkIqxfcSx5j+GKPnKI9FWt6I3muFxuYHXBPW
         yhrpTajjLG4owEELBqtwZm8yGCvAfKCpFk7MiX9juIrGgYGCF01zycCXtQ4fwKJcjj
         36iMJnaCfy+lfi8V/IGyC+YxlHjCiXOXZYIwhxnUoZwtiiRPhtijNGixOh54GAMlXt
         e2XVob10PwtIer3BVUO3CTqz29LmcvMqRwxPsYnRKyTpBJyDuu0mAaXe4rRVGgQcO+
         HCKnKJBQ8HRYA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DED6B15404B4; Wed,  5 Apr 2023 20:46:15 -0700 (PDT)
Date:   Wed, 5 Apr 2023 20:46:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
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
Message-ID: <6ff4eb09-13df-403f-ba4a-c5abb0f3fa8f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1680266529-28429-1-git-send-email-ziwei.dai@unisoc.com>
 <CAEXW_YR5MZhHuDsMVEB8A=80k3sjecp-yTXNLv6XCaq9h2JH2A@mail.gmail.com>
 <CAEXW_YRtV7pAYR-UyVNNsgPJ2dmBGrV+DkNROOivXj3MChDgGw@mail.gmail.com>
 <a1e006af-c935-4246-a239-669debb4717d@paulmck-laptop>
 <94c28b46617e46d1804a397a54f9fd8d@BJMBX01.spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94c28b46617e46d1804a397a54f9fd8d@BJMBX01.spreadtrum.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:38:09AM +0000, 代子为 (Ziwei Dai) wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Paul E. McKenney <paulmck@kernel.org>
> > 发送时间: 2023年4月6日 2:46
> > 收件人: Joel Fernandes <joel@joelfernandes.org>
> > 抄送: 代子为 (Ziwei Dai) <Ziwei.Dai@unisoc.com>; urezki@gmail.com; frederic@kernel.org; quic_neeraju@quicinc.com;
> > josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; rcu@vger.kernel.org;
> > linux-kernel@vger.kernel.org; 王双 (Shuang Wang) <shuang.wang@unisoc.com>; 辛依凡 (Yifan Xin) <Yifan.Xin@unisoc.com>; 王科
> > (Ke Wang) <Ke.Wang@unisoc.com>; 闫学文 (Xuewen Yan) <Xuewen.Yan@unisoc.com>; 牛志国 (Zhiguo Niu)
> > <Zhiguo.Niu@unisoc.com>; 黄朝阳 (Zhaoyang Huang) <zhaoyang.huang@unisoc.com>
> > 主题: Re: [PATCH V2] rcu: Make sure new krcp free business is handled after the wanted rcu grace period.
> > 
> > 
> > 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the
> > sender and know the content is safe.
> > 
> > 
> > 
> > On Wed, Apr 05, 2023 at 02:12:02PM -0400, Joel Fernandes wrote:
> > > On Wed, Apr 5, 2023 at 1:39 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Mar 31, 2023 at 8:43 AM Ziwei Dai <ziwei.dai@unisoc.com> wrote:
> > > > >
> > > > > In kfree_rcu_monitor(), new free business at krcp is attached to
> > > > > any free channel at krwp. kfree_rcu_monitor() is responsible to
> > > > > make sure new free business is handled after the rcu grace period.
> > > > > But if there is any none-free channel at krwp already, that means
> > > > > there is an on-going rcu work, which will cause the
> > > > > kvfree_call_rcu()-triggered free business is done before the wanted rcu grace period ends.
> > > > >
> > > > > This commit ignore krwp which has non-free channel at
> > > > > kfree_rcu_monitor(), to fix the issue that kvfree_call_rcu() loses effectiveness.
> > > > >
> > > > > Below is the css_set obj "from_cset" use-after-free case caused by
> > > > > kvfree_call_rcu() losing effectiveness.
> > > > > CPU 0 calls rcu_read_lock(), then use "from_cset", then hard irq
> > > > > comes, the task is schedule out.
> > > > > CPU 1 calls kfree_rcu(cset, rcu_head), willing to free "from_cset" after new gp.
> > > > > But "from_cset" is freed right after current gp end. "from_cset" is reallocated.
> > > > > CPU 0 's task arrives back, references "from_cset"'s member, which causes crash.
> > > > >
> > > > > CPU 0                                   CPU 1
> > > > > count_memcg_event_mm()
> > > > > |rcu_read_lock()  <---
> > > > > |mem_cgroup_from_task()
> > > > >  |// css_set_ptr is the "from_cset" mentioned on CPU 1
> > > > > |css_set_ptr = rcu_dereference((task)->cgroups)  |// Hard irq
> > > > > comes, current task is scheduled out.
> > > > >
> > > > >                                         cgroup_attach_task()
> > > > >                                         |cgroup_migrate()
> > > > >                                         |cgroup_migrate_execute()
> > > > >                                         |css_set_move_task(task, from_cset, to_cset, true)
> > > > >                                         |cgroup_move_task(task, to_cset)
> > > > >                                         |rcu_assign_pointer(.., to_cset)
> > > > >                                         |...
> > > > >                                         |cgroup_migrate_finish()
> > > > >                                         |put_css_set_locked(from_cset)
> > > > >                                         |from_cset->refcount return 0
> > > > >                                         |kfree_rcu(cset, rcu_head) // means to free from_cset after new gp
> > > > >                                         |add_ptr_to_bulk_krc_lock()
> > > > >
> > > > > |schedule_delayed_work(&krcp->monitor_work, ..)
> > > > >
> > > > >                                         kfree_rcu_monitor()
> > > > >                                         |krcp->bulk_head[0]'s work attached to krwp->bulk_head_free[]
> > > > >                                         |queue_rcu_work(system_wq, &krwp->rcu_work)
> > > > >                                         |if rwork->rcu.work is not in WORK_STRUCT_PENDING_BIT state,
> > > > >                                         |call_rcu(&rwork->rcu,
> > > > > rcu_work_rcufn) <--- request a new gp
> > > > >
> > > > >                                         // There is a perious call_rcu(.., rcu_work_rcufn)
> > > > >                                         // gp end, rcu_work_rcufn() is called.
> > > > >                                         rcu_work_rcufn()
> > > > >                                         |__queue_work(..,
> > > > > rwork->wq, &rwork->work);
> > > > >
> > > > >                                         |kfree_rcu_work()
> > > > >                                         |krwp->bulk_head_free[0] bulk is freed before new gp end!!!
> > > > >                                         |The "from_cset" is freed before new gp end.
> > > > >
> > > > > // the task is scheduled in after many ms.
> > > > >  |css_set_ptr->subsys[(subsys_id) <--- Caused kernel crash, because css_set_ptr is freed.
> > > > >
> > > > > v2: Use helper function instead of inserted code block at kfree_rcu_monitor().
> > > > >
> > > > > Fixes: c014efeef76a ("rcu: Add multiple in-flight batches of
> > > > > kfree_rcu() work")
> > > > > Signed-off-by: Ziwei Dai <ziwei.dai@unisoc.com>
> > > >
> > > > Please update the fixes tag to:
> > > > 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")
> > >
> > > Vlad pointed out in another thread that the fix is actually to 34c881745549.
> > >
> > > So just to be sure, it could be updated to:
> > > Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in
> > > kfree_rcu()")
> > > Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc
> > > ptrs")
> > 
> > Ziwei Dai, does this change in Fixes look good to you?
> > 
> > If so, I will update the commit log in this commit that I am planning to submit into v6.3.  It is strictly speaking not a v6.3 regression,
> > but it is starting to show up in the wild and the patch is contained enough to be considered an urgent fix.
> > 
> >                                                         Thanx, Paul
> 
> Hi Paul, it looks good to me and thanks!

Thank you, and I will fix on my next rebase.

							Thanx, Paul
