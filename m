Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2663FEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiLBDTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:19:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED7769CC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:19:36 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NNdSr3STjz15N2q;
        Fri,  2 Dec 2022 11:18:52 +0800 (CST)
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 11:19:34 +0800
From:   Hui Tang <tanghui20@huawei.com>
Subject: [bug-report] WARNING in sched_tick_remote
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Christian Brauner <brauner@kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <aef1e240-7e91-19bc-2de3-8109a795c15c@huawei.com>
Date:   Fri, 2 Dec 2022 11:19:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

An warning happen in sched_tick_remote when we do syzkaller test.
The syzkaller test run in a qemu with 4 cpus, and nohz_full=3.

The warn triggered by WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3).

	static void sched_tick_remote(struct work_struct *work)
	{
	[...]
			if (!is_idle_task(curr)) {
					/*
					 * Make sure the next tick runs within a reasonable
					 * amount of time.
					 */
					delta = rq_clock_task(rq) - curr->se.exec_start;
					WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
			}
	[...]
	}

I debug it and find that a syzkaller thread keep in kernel mode
more than 3s. And all unbound kworkers run on the same cpu as the
syzkaller thread. The kworker thread doing sched_tick_remote
is scheduled more than 3s since last run.

WARN log as follows:

WARNING: CPU: 2 PID: 23866 at kernel/sched/core.c:4142 queued_spin_lock arch/arm64/include/asm/paravirt.h:51 [inline]
WARNING: CPU: 2 PID: 23866 at kernel/sched/core.c:4142 do_raw_spin_lock include/linux/spinlock.h:183 [inline]
WARNING: CPU: 2 PID: 23866 at kernel/sched/core.c:4142 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:129 [inline]
WARNING: CPU: 2 PID: 23866 at kernel/sched/core.c:4142 rq_lock_irq kernel/sched/sched.h:1373 [inline]
WARNING: CPU: 2 PID: 23866 at kernel/sched/core.c:4142 sched_tick_remote+0x384/0x400 kernel/sched/core.c:4129
Modules linked in:
CPU: 2 PID: 23866 Comm: kworker/u8:3 Not tainted 5.10.0-02029-gf83322d59c08-dirty #1
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound sched_tick_remote
pstate: 20400085 (nzCv daIf +PAN -UAO -TCO BTYPE=--)
pc : sched_tick_remote+0x384/0x400 kernel/sched/core.c:4142
lr : sched_tick_remote+0x1e4/0x400 kernel/sched/core.c:4141
sp : ffffa00019347ba0
x29: ffffa00019347ba0 x28: ffff0000e2a8c110
x27: 0000000000000000 x26: ffffa00014af6e88
x25: ffff000224cbc4f8 x24: ffffa00014b45840
x23: 000000013afb24ae x22: 1ffff40003268f80
x21: ffff000224cbfa28 x20: ffff0000c0e53e80
x19: ffff000224cbbb40 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000000
x13: 0000000000000002 x12: ffff940003268f85
x11: 1ffff40003268f84 x10: ffff940003268f84
x9 : ffffa000101bece8 x8 : 0000000000000003
x7 : 0000000000000001 x6 : ffff940003268f84
x5 : ffff0000d63229c0 x4 : dfffa00000000000
x3 : ffffa000101c33f4 x2 : 0000000000000007
x1 : 0000026d1ef2161e x0 : 00000000b2d05e00
Call trace:
  queued_spin_lock arch/arm64/include/asm/paravirt.h:51 [inline]
  do_raw_spin_lock include/linux/spinlock.h:183 [inline]
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:129 [inline]
  rq_lock_irq kernel/sched/sched.h:1373 [inline]
  sched_tick_remote+0x384/0x400 kernel/sched/core.c:4129
  process_one_work+0x474/0xb20 kernel/workqueue.c:2280
  worker_thread+0x120/0x92c kernel/workqueue.c:2426
  kthread+0x20c/0x25c kernel/kthread.c:313
  ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:1034
