Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A46A6C57
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCAM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCAM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:28:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756186B8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:28:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so13033021wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ltz5EmItKTP39HJpFObu0oGvEY96YKQaBc1VsIgBjg=;
        b=FJMcLR/sqsobRCHQ2JpzuyCNTAZZD04Z69/2ppwGPn2QthLhzkXhsX6R68jsVqyxJN
         X0Jh1gT58b1rM4x5+wnZ0FsszyYdqRzkDYyDCSfmMszIgovwLZ/nUPG6cEuZE9b8UFtD
         oymYI2wlko+D97CsHbnY0QCGROpgshXEKepHuOgEwiugtuFf2nl+EhSEa/yE+uC5D2qp
         tHdnk3Cdl6PfoBg2/7XKnmY1FAfMyZUYwDOyX5SSFbqZDoPCVEy+tGEoqt/qUPfHmoNH
         WOVGutMwZKFcztTswttzVRUuFDSOMzvYEo/74KtzR19ku95fwzi/tFPPxXvkZ0chdfZm
         f1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ltz5EmItKTP39HJpFObu0oGvEY96YKQaBc1VsIgBjg=;
        b=fKaWoAw4q0YFFIlWOiYKyTc7g1A9ERVyXUPRE2Tn+nwsHq2LksYFDSkaEXgKzGElaM
         btKB9MRLevrtTWvVPY3bE8IrmBhgdMqFQWj4o5TTxReuw+Nzn0F/X+1McSSSqxK/gstC
         4UBGAqJyqs+m0jdljPQTYwlt0ny5gquKAeQkGWJ+xh3yGUsteEEuunQD6ms1aPFfXP07
         ecuwAGwyBkv+FMoAPYTEN4j0bIkvfMbxXU+9IbXL4w7dWuPy3McopU/WSiFBQmry5Jfd
         AX3/FrY4DYXCvhWfYi4cNK3S9xVhC9r/BpgFIT4dYWHdlScl/49aLwyPpJp57rbuIszU
         wRSQ==
X-Gm-Message-State: AO0yUKU30VuxvL0DUBjeNHs8YnslPNRv+KX/hujDO1nekELnV7+b02YR
        mQtgp7pktZ971brkjwx5ubAdDw==
X-Google-Smtp-Source: AK7set//iA9Ow5hZfVT5tSDKLS3Du3K+JL0roxEKmdv8rGHfy1TViVAwmqQt0ZroxfInQ3UKPWFwwg==
X-Received: by 2002:a5d:4b91:0:b0:2c7:3ee7:a453 with SMTP id b17-20020a5d4b91000000b002c73ee7a453mr4178764wrt.33.1677673735702;
        Wed, 01 Mar 2023 04:28:55 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003daf6e3bc2fsm1998727wmq.1.2023.03.01.04.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:28:54 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:28:52 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <20230301122852.zgzreby42lh2zf6w@airbuntu>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/7/SLzvK8LfB29z@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/23 08:31, Juri Lelli wrote:
> Hi,
> 
> On 28/02/23 17:46, Qais Yousef wrote:
> > On 02/28/23 15:09, Dietmar Eggemann wrote:
> > 
> > > > IIUC you're suggesting to introduce some new mechanism to detect if hotplug has
> > > > lead to a cpu to disappear or not and use that instead? Are you saying I can
> > > > use arch_update_cpu_topology() for that? Something like this?
> > > > 
> > > > 	diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > > 	index e5ddc8e11e5d..60c3dcf06f0d 100644
> > > > 	--- a/kernel/cgroup/cpuset.c
> > > > 	+++ b/kernel/cgroup/cpuset.c
> > > > 	@@ -1122,7 +1122,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > > > 	 {
> > > > 		mutex_lock(&sched_domains_mutex);
> > > > 		partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > > 	-       if (update_dl_accounting)
> > > > 	+       if (arch_update_cpu_topology())
> > > > 			update_dl_rd_accounting();
> > > > 		mutex_unlock(&sched_domains_mutex);
> > > > 	 }
> > > 
> > > No, this is not what I meant. I'm just saying the:
> > > 
> > >   partition_sched_domains_locked()
> > >     new_topology = arch_update_cpu_topology();
> > > 
> > > has to be considered here as well since we do a
> > > `dl_clear_root_domain(rd)` (1) in partition_sched_domains_locked() for
> > > !new_topology.
> > 
> > Ah you're referring to the dl_clear_root_domain() call there. I thought this
> > doesn't trigger.
> > 
> > > 
> > > And (1) requires the `update_tasks_root_domain()` to happen later.
> > > 
> > > So there are cases now, e.g. `rebuild_sched_domains_energy()` in which
> > > `new_topology=0` and `update_dl_accounting=false` which now clean the rd
> > > but don't do a new DL accounting anymore.
> > > rebuild_root_domains() itself cleans the `default root domain`, not the
> > > other root domains which could exists as well.
> > > 
> > > Example: Switching CPUfreq policy [0,3-5] performance to schedutil (slow
> > > switching, i.e. we have sugov:X DL task(s)):
> > > 
> > > [  862.479906] CPU4 partition_sched_domains_locked() new_topology=0
> > > [  862.499073] Workqueue: events rebuild_sd_workfn
> > > [  862.503646] Call trace:
> > > ...
> > > [  862.520789]  partition_sched_domains_locked+0x6c/0x670
> > > [  862.525962]  rebuild_sched_domains_locked+0x204/0x8a0
> > > [  862.531050]  rebuild_sched_domains+0x2c/0x50
> > > [  862.535351]  rebuild_sd_workfn+0x38/0x54                        <-- !
> > > ...
> > > [  862.554047] CPU4 dl_clear_root_domain() rd->span=0-5 total_bw=0
> > > def_root_domain=0                                                  <-- !
> > > [  862.561597] CPU4 dl_clear_root_domain() rd->span= total_bw=0
> > > def_root_domain=1
> > > [  862.568960] CPU4 dl_add_task_root_domain() [sugov:0 1801]
> > > total_bw=104857 def_root_domain=0 rd=0xffff0008015f0000            <-- !
> > > 
> > > The dl_clear_root_domain() of the def_root_domain and the
> > > dl_add_task_root_domain() to the rd in use won't happen.
> > > 
> > > [sugov:0 1801] is only a simple example here. I could have spawned a
> > > couple of DL tasks before this to illustrate the issue more obvious.
> > > 
> > > ---
> > > 
> > > The same seems to happen during suspend/resume (system with 2 frequency
> > > domains, both with slow switching schedutil CPUfreq gov):
> > > 
> > > [   27.735821] CPU5 partition_sched_domains_locked() new_topology=0
> > > ...
> > > [   27.735864] Workqueue: events cpuset_hotplug_workfn
> > > [   27.735894] Call trace:
> > > ...
> > > [   27.735984]  partition_sched_domains_locked+0x6c/0x670
> > > [   27.736004]  rebuild_sched_domains_locked+0x204/0x8a0
> > > [   27.736026]  cpuset_hotplug_workfn+0x254/0x52c                  <-- !
> > > ...
> > > [   27.736155] CPU5 dl_clear_root_domain() rd->span=0-5 total_bw=0
> > > def_root_domain=0                                                  <-- !
> > > [   27.736178] CPU5 dl_clear_root_domain() rd->span= total_bw=0
> > > def_root_domain=1
> > > [   27.736296] CPU5 dl_add_task_root_domain() [sugov:0 80]         <-- !
> > >  total_bw=104857 def_root_domain=0 rd=0xffff000801728000
> > > [   27.736318] CPU5 dl_add_task_root_domain() [sugov:1 81]
> > > total_bw=209714 def_root_domain=0 rd=0xffff000801728000            <-- !
> > > ...
> > > 
> > > > I am not keen on this. arm64 seems to just read a value without a side effect.
> > > 
> > > Arm64 (among others) sets `update_topology=1` before
> > > `rebuild_sched_domains()` and `update_topology=0` after it in
> > > update_topology_flags_workfn(). This then makes `new_topology=1` in
> > > partition_sched_domains_locked().
> > > 
> > > > But x86 does reset this value so we can't read it twice in the same call tree
> > > > and I'll have to extract it.
> > > > 
> > > > The better solution that was discussed before is to not iterate through every
> > > > task in the system and let cpuset track when dl tasks are added to it and do
> > > > smarter iteration. ATM even if there are no dl tasks in the system we'll
> > > > blindly go through every task in the hierarchy to update nothing.
> > > 
> > > Yes, I can see the problem. And IMHO this solution approach seems to be
> > > better than parsing update_dl_accounting` through the stack of involved
> > > functions.
> > 
> > The best I can do is protect this dl_clear_root_domain() too. I really don't
> > have my heart in this but trying my best to help, but it has taken a lot of my
> > time already and would prefer to hand over to Juri to address this regression
> > if what I am proposing is not good enough.
> > 
> > FWIW, there are 0 dl tasks in the system where this was noticed. And this delay
> > is unbounded because it'll depend on how many tasks there are in the hierarchy.
> 
> Not ignoring you guys here, but it turns out I'm quite bogged down with
> other stuff at the moment. :/ So, apologies and I'll try to get to this
> asap. Thanks a lot for all your efforts and time reviewing so far!

Np, I can feel you :-)


Thanks

--
Qais Yousef
