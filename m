Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0926E0C52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDMLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDMLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A5BF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A72663B19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B08C433D2;
        Thu, 13 Apr 2023 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681384751;
        bh=Jv03DFXreBUp9HPDfssz5sRD4SZ+45nNpF3tiOc82Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQ67Xb+AVuYEm7Dyzlfl3L2yDsr1YZ0gi2GKJrbbdV58zn4F4oQ4IPxdKU8fAfI0J
         ES9qpGO3Y/SS8Irs2F6ZGLZ+KAtLH9ktMq8JcEyowrZpYEx5uQ/vsiQl5TNfV8pNXb
         SMmnPgxoRR2pCQccjssKF7BZr6bDefDLtb9/SOzWlXgP3VUZjCnNytonyE0TL1ydke
         TWFS8HUKKaBkxpuECBFMqPIuocu7/VJQ49ybnJpxzhF+9Jktj5AD3aLbMj/QbsQr1Z
         +PYsub+Ah58TU5c2TjFrqOu07wpNJHXEHFXVm2r3hrxF6yMXj48mmdW71xlTgXibne
         cqFzb6ME45rJQ==
Date:   Thu, 13 Apr 2023 13:19:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>, Jens Axboe <axboe@kernel.dk>
Cc:     lihuafei1@huawei.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        quic_neeraju@quicinc.com, paulmck@kernel.org, heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDflLOCujdBNXl3D@lothringen>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <ZDdsz+5/QehZ25hg@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDdsz+5/QehZ25hg@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:45:35AM +0800, Pengfei Xu wrote:
> Hi Huafei and kernel experts,
> 
> It's a soft remind.
> This issue could be reproduced in v6.3-rc6 kernel.
> It could be reproduced on Alder lake, Raptor lake and so on x86 platforms.
> After reverted the commit "0e792b89e6800c:ftrace: Fix use-after-free for
> dynamic ftrace_ops" on top of v6.3-rc6 kernel, this issue was gone.
> 
> New syzkaller reproduced code, repro.report, bisect_info.log and detailed logs
> are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/230412_031722_synchronize_rcu

I just tested against v6.3-rc6 and again all I get is this io_ring related
issue:

[  448.290752] INFO: task kworker/u4:0:9 blocked for more than 294 seconds.
[  448.293868]       Not tainted 6.3.0-rc6-kvm #1
[  448.296019] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  448.299592] task:kworker/u4:0    state:D stack:0     pid:9     ppid:2      flags:0x00004000
[  448.303397] Workqueue: events_unbound io_ring_exit_work
[  448.305884] Call Trace:
[  448.307147]  <TASK>
[  448.308166]  __schedule+0x422/0xc90
[  448.309824]  ? wait_for_completion+0x77/0x170
[  448.311870]  schedule+0x63/0xd0
[  448.313346]  schedule_timeout+0x2fe/0x4c0
[  448.315255]  ? __this_cpu_preempt_check+0x1c/0x30
[  448.317360]  ? _raw_spin_unlock_irq+0x27/0x60
[  448.319400]  ? lockdep_hardirqs_on+0x88/0x120
[  448.321395]  ? wait_for_completion+0x77/0x170
[  448.323462]  wait_for_completion+0x9e/0x170
[  448.325356]  io_ring_exit_work+0x2b0/0x810
[  448.327300]  ? __pfx_io_tctx_exit_cb+0x10/0x10
[  448.329345]  ? _raw_spin_unlock_irq+0x27/0x60
[  448.331397]  process_one_work+0x34e/0x720
[  448.333212]  ? __pfx_io_ring_exit_work+0x10/0x10
[  448.335377]  ? process_one_work+0x34e/0x720
[  448.337295]  worker_thread+0x4e/0x530
[  448.339079]  ? __pfx_worker_thread+0x10/0x10
[  448.341008]  kthread+0x128/0x160
[  448.342513]  ? __pfx_kthread+0x10/0x10
[  448.344305]  ret_from_fork+0x2c/0x50
[  448.346016]  </TASK>
[  448.347176] 
[  448.347176] Showing all locks held in the system:
[  448.349887] 2 locks held by kworker/u4:0/9:
[  448.351829]  #0: ffff88807eb6dd38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
[  448.356362]  #1: ffffc9000005fe68 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x2b4/0x720
[  448.361052] 1 lock held by rcu_tasks_kthre/11:
[  448.363142]  #0: ffffffff83963450 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
[  448.367396] 1 lock held by rcu_tasks_rude_/12:
[  448.369387]  #0: ffffffff839631d0 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
[  448.373808] 1 lock held by rcu_tasks_trace/13:
[  448.375852]  #0: ffffffff83962f10 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0x440
[  448.380434] 1 lock held by khungtaskd/30:
[  448.382219]  #0: ffffffff83963e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x17/0x1d0
[  448.386291] 
[  448.387159] =============================================
[  448.387159] 
