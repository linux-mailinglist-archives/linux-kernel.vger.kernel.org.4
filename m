Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282A8729822
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjFILZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbjFILZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:25:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F1130D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:24:44 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QczBb4gwjz18LrL;
        Fri,  9 Jun 2023 19:19:51 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 9 Jun
 2023 19:24:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [Question] report a race condition between CPU hotplug state machine
 and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Thomas Gleixner <tglx@linutronix.de>, <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>, <vdonnefort@google.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, <zhangqiao22@huawei.com>
Message-ID: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
Date:   Fri, 9 Jun 2023 19:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 When I do some low power tests, the following hung task is printed.

  Call trace:
   __switch_to+0xd4/0x160
   __schedule+0x38c/0x8c4
   __cond_resched+0x24/0x50
   unmap_kernel_range_noflush+0x210/0x240
   kretprobe_trampoline+0x0/0xc8
   __vunmap+0x70/0x31c
   __vfree+0x34/0x8c
   vfree+0x40/0x58
   free_vm_stack_cache+0x44/0x74
   cpuhp_invoke_callback+0xc4/0x71c
   _cpu_down+0x108/0x284
   kretprobe_trampoline+0x0/0xc8
   suspend_enter+0xd8/0x8ec
   suspend_devices_and_enter+0x1f0/0x360
   pm_suspend.part.1+0x428/0x53c
   pm_suspend+0x3c/0xa0
   devdrv_suspend_proc+0x148/0x248 [drv_devmng]
   devdrv_manager_set_power_state+0x140/0x680 [drv_devmng]
   devdrv_manager_ioctl+0xcc/0x210 [drv_devmng]
   drv_ascend_intf_ioctl+0x84/0x248 [drv_davinci_intf]
   __arm64_sys_ioctl+0xb4/0xf0
   el0_svc_common.constprop.0+0x140/0x374
   do_el0_svc+0x80/0xa0
   el0_svc+0x1c/0x28
   el0_sync_handler+0x90/0xf0
   el0_sync+0x168/0x180

After some analysis, I found it is caused by the following race condition.

1. A task running on CPU1 is throttled for cfs bandwidth. CPU1 starts the
hrtimer cfs_bandwidth 'period_timer' and enqueue the hrtimer on CPU1's rbtree.
2. Then the task is migrated to CPU2 and starts to offline CPU1. CPU1 starts
CPUHP AP steps, and then the hrtimer 'period_timer' expires and re-enqueued on CPU1.
3. CPU1 runs to take_cpu_down() and disable irq. After CPU1 finished CPUHP AP
steps, CPU2 starts the rest CPUHP step.
4. When CPU2 runs to free_vm_stack_cache(), it is sched out in __vunmap()
because it run out of CPU quota. start_cfs_bandwidth() does not restart the
hrtimer because 'cfs_b->period_active' is set.
5. The task waits the hrtimer 'period_timer' to expire to wake itself up, but
CPU1 has disabled irq and the hrtimer won't expire until it is migrated to CPU2
in hrtimers_dead_cpu(). But the task is blocked and cannot proceed to
hrtimers_dead_cpu() step. So the task hungs.

    CPU1      			                 	 CPU2
Task set cfs_quota
start hrtimer cfs_bandwidth 'period_timer'
						start to offline CPU1
CPU1 start CPUHP AP step
...
'period_timer' expired and re-enqueued on CPU1
...
disable irq in take_cpu_down()
...
						CPU2 start the rest CPUHP steps
						...
					      sched out in free_vm_stack_cache()
						wait for 'period_timer' expires


Appreciate it a lot if anyone can give some suggestion on how fix this problem !

Thanks,
Xiongfeng


