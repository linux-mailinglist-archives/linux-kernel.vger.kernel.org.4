Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2D68AAE5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBDPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBDPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:16:41 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E302C660;
        Sat,  4 Feb 2023 07:16:36 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314FGOvK018534;
        Sun, 5 Feb 2023 00:16:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Sun, 05 Feb 2023 00:16:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314FGOXH018531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Feb 2023 00:16:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <200ae3a7-eb78-1eae-e06c-a8dd6abda171@I-love.SAKURA.ne.jp>
Date:   Sun, 5 Feb 2023 00:16:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y95s7P+Z2nOz4lDE@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y95s7P+Z2nOz4lDE@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/04 23:34, Greg Kroah-Hartman wrote:
>>>> We can make this deadlock visible by applying [1], and we can confirm that
>>>> there is a deadlock problem that I think needs to be addressed in core code [2].
>>>
>>> Any reason why you didn't cc: us on these patches?
>>
>> We can't apply this "drivers/core: Remove lockdep_set_novalidate_class() usage" patch
> 
> What patch is that?  I do not see that in my inbox anywhere.  I don't
> even see it in my lkml archive, so I do not know what you are talking
> about.

Here is a copy. Please don't apply to git trees, or syzbot will fail to test kernels.

 From f7ff56455ae7813768c6ab85e8e3db374122f32b Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 23 Jan 2023 19:32:26 +0900
Subject: [PATCH] drivers/core: Remove lockdep_set_novalidate_class() usage

This patch experimentally removes lockdep_set_novalidate_class() call
 from device_initialize() introduced by commit 1704f47b50b5 ("lockdep:
Add novalidate class for dev->mutex conversion"), for this commit made it
impossible to find real deadlocks unless timing dependent testings manage
to trigger hung task like [1] and [2]. Let's try if we can find remaining
drivers which need to use separate classes without causing too many crashes
to continue.

[1] https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
[2] https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/base/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..68189722e343 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2941,7 +2941,6 @@ void device_initialize(struct device *dev)
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
-	lockdep_set_novalidate_class(&dev->mutex);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
-- 
2.18.4


> 
>> until we fix all lockdep warnings that happen during the boot stage;
> 
> What lockdep warnings?

Here is an example that you will be able to observe by applying the patch above.

----------
[    2.276394][    T9] Trying to unpack rootfs image as initramfs...
[    2.276394][    T1] software IO TLB: mapped [mem 0x00000000bbed0000-0x00000000bfed0000] (64MB)
[    2.276394][    T1] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    2.276394][    T1] SGI XFS with ACLs, security attributes, verbose warnings, quota, no debug enabled
[    2.276394][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.837244][    T1] 
[    2.837244][    T1] ============================================
[    2.837244][    T1] WARNING: possible recursive locking detected
[    2.837244][    T1] 6.2.0-rc5+ #10 Not tainted
[    2.837244][    T1] --------------------------------------------
[    2.837244][    T1] swapper/0/1 is trying to acquire lock:
[    2.837244][    T1] ffff984dc3d50108 (&dev->mutex){+.+.}-{3:3}, at: __device_attach+0x35/0x1a0
[    2.837244][    T1] 
[    2.837244][    T1] but task is already holding lock:
[    2.837244][    T1] ffff984dc1b5e1b8 (&dev->mutex){+.+.}-{3:3}, at: __device_driver_lock+0x28/0x40
[    2.837244][    T1] 
[    2.837244][    T1] other info that might help us debug this:
[    2.837244][    T1]  Possible unsafe locking scenario:
[    2.837244][    T1] 
[    2.837244][    T1]        CPU0
[    2.837244][    T1]        ----
[    2.837244][    T1]   lock(&dev->mutex);
[    2.837244][    T1]   lock(&dev->mutex);
[    2.837244][    T1] 
[    2.837244][    T1]  *** DEADLOCK ***
[    2.837244][    T1] 
[    2.837244][    T1]  May be due to missing lock nesting notation
[    2.837244][    T1] 
[    2.837244][    T1] 1 lock held by swapper/0/1:
[    2.837244][    T1]  #0: ffff984dc1b5e1b8 (&dev->mutex){+.+.}-{3:3}, at: __device_driver_lock+0x28/0x40
[    2.837244][    T1] 
[    2.837244][    T1] stack backtrace:
[    2.837244][    T1] CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc5+ #10
[    2.837244][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[    2.837244][    T1] Call Trace:
[    2.837244][    T1]  <TASK>
[    2.837244][    T1]  dump_stack_lvl+0x49/0x5e
[    2.837244][    T1]  dump_stack+0x10/0x12
[    2.837244][    T1]  __lock_acquire.cold.73+0x12e/0x2c7
[    2.837244][    T1]  lock_acquire+0xc7/0x2e0
[    2.837244][    T1]  ? __device_attach+0x35/0x1a0
[    2.837244][    T1]  __mutex_lock+0x99/0xf00
[    2.837244][    T1]  ? __device_attach+0x35/0x1a0
[    2.837244][    T1]  ? __this_cpu_preempt_check+0x13/0x20
[    2.837244][    T1]  ? __device_attach+0x35/0x1a0
[    2.837244][    T1]  ? kobject_uevent_env+0x12f/0x770
[    2.837244][    T1]  mutex_lock_nested+0x16/0x20
[    2.837244][    T1]  ? mutex_lock_nested+0x16/0x20
[    2.837244][    T1]  __device_attach+0x35/0x1a0
[    2.837244][    T1]  device_initial_probe+0xe/0x10
[    2.837244][    T1]  bus_probe_device+0x9b/0xb0
[    2.837244][    T1]  device_add+0x3e1/0x900
[    2.837244][    T1]  ? __init_waitqueue_head+0x4a/0x70
[    2.837244][    T1]  device_register+0x15/0x20
[    2.837244][    T1]  pcie_portdrv_probe+0x3e3/0x670
[    2.837244][    T1]  ? trace_hardirqs_on+0x3b/0x100
[    2.837244][    T1]  pci_device_probe+0xa8/0x150
[    2.837244][    T1]  really_probe+0xd9/0x340
[    2.837244][    T1]  ? pm_runtime_barrier+0x52/0xb0
[    2.837244][    T1]  __driver_probe_device+0x78/0x170
[    2.837244][    T1]  driver_probe_device+0x1f/0x90
[    2.837244][    T1]  __driver_attach+0xaa/0x160
[    2.837244][    T1]  ? __device_attach_driver+0x100/0x100
[    2.837244][    T1]  bus_for_each_dev+0x75/0xb0
[    2.837244][    T1]  driver_attach+0x19/0x20
[    2.837244][    T1]  bus_add_driver+0x1be/0x210
[    2.837244][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.837244][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.837244][    T1]  ? rdinit_setup+0x27/0x27
[    2.837244][    T1]  driver_register+0x6b/0xc0
[    2.837244][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.837244][    T1]  __pci_register_driver+0x7c/0x80
[    2.837244][    T1]  pcie_portdrv_init+0x3d/0x45
[    2.837244][    T1]  do_one_initcall+0x58/0x300
[    2.837244][    T1]  ? rdinit_setup+0x27/0x27
[    2.837244][    T1]  ? rcu_read_lock_sched_held+0x4a/0x70
[    2.837244][    T1]  kernel_init_freeable+0x181/0x1d2
[    2.837244][    T1]  ? rest_init+0x190/0x190
[    2.837244][    T1]  kernel_init+0x15/0x120
[    2.837244][    T1]  ret_from_fork+0x1f/0x30
[    2.837244][    T1]  </TASK>
[    4.126397][    T1] pcieport 0000:00:15.0: PME: Signaling with IRQ 24
[    4.126397][    T1] pcieport 0000:00:15.0: pciehp: Slot #160 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    4.126397][    T1] pcieport 0000:00:15.1: PME: Signaling with IRQ 25
----------

# ./scripts/faddr2line --list vmlinux __device_attach+0x35/0x1a0 __device_driver_lock+0x28/0x40
__device_attach+0x35/0x1a0:

__device_attach at drivers/base/dd.c:984
 979    {
 980            int ret = 0;
 981            bool async = false;
 982
 983            device_lock(dev);
>984<           if (dev->p->dead) {
 985                    goto out_unlock;
 986            } else if (dev->driver) {
 987                    if (device_is_bound(dev)) {
 988                            ret = 1;
 989                            goto out_unlock;

__device_driver_lock+0x28/0x40:

__device_driver_lock at drivers/base/dd.c:1074
 1069   static void __device_driver_lock(struct device *dev, struct device *parent)
 1070   {
 1071           if (parent && dev->bus->need_parent_lock)
 1072                   device_lock(parent);
 1073           device_lock(dev);
>1074<  }
 1075
 1076   /*
 1077    * __device_driver_unlock - release locks needed to manipulate dev->drv
 1078    * @dev: Device we will update driver info for
 1079    * @parent: Parent device. Needed if the bus requires parent lock

# ./scripts/faddr2line vmlinux __device_attach+0x35/0x1a0 device_initial_probe+0xe/0x10 bus_probe_device+0x9b/0xb0 device_add+0x3e1/0x900 device_register+0x15/0x20 pcie_portdrv_probe+0x3e3/0x670 pci_device_probe+0xa8/0x150 really_probe+0xd9/0x340 __driver_probe_device+0x78/0x170 driver_probe_device+0x1f/0x90 __driver_attach+0xaa/0x160 bus_for_each_dev+0x75/0xb0 driver_attach+0x19/0x20 bus_add_driver+0x1be/0x210 driver_register+0x6b/0xc0
__device_attach+0x35/0x1a0:
__device_attach at drivers/base/dd.c:984

device_initial_probe+0xe/0x10:
device_initial_probe at drivers/base/dd.c:1058

bus_probe_device+0x9b/0xb0:
bus_probe_device at drivers/base/bus.c:487

device_add+0x3e1/0x900:
device_add at drivers/base/core.c:3485

device_register+0x15/0x20:
device_register at drivers/base/core.c:3560

pcie_portdrv_probe+0x3e3/0x670:
pcie_device_init at drivers/pci/pcie/portdrv.c:310
(inlined by) pcie_port_device_register at drivers/pci/pcie/portdrv.c:363
(inlined by) pcie_portdrv_probe at drivers/pci/pcie/portdrv.c:696

pci_device_probe+0xa8/0x150:
local_pci_probe at drivers/pci/pci-driver.c:324
(inlined by) pci_call_probe at drivers/pci/pci-driver.c:392
(inlined by) __pci_device_probe at drivers/pci/pci-driver.c:417
(inlined by) pci_device_probe at drivers/pci/pci-driver.c:460

really_probe+0xd9/0x340:
call_driver_probe at drivers/base/dd.c:560
(inlined by) really_probe at drivers/base/dd.c:639

__driver_probe_device+0x78/0x170:
__driver_probe_device at drivers/base/dd.c:778

driver_probe_device+0x1f/0x90:
driver_probe_device at drivers/base/dd.c:808

__driver_attach+0xaa/0x160:
__driver_attach at drivers/base/dd.c:1195

bus_for_each_dev+0x75/0xb0:
bus_for_each_dev at drivers/base/bus.c:300

driver_attach+0x19/0x20:
driver_attach at drivers/base/dd.c:1212

bus_add_driver+0x1be/0x210:
bus_add_driver at drivers/base/bus.c:619

driver_register+0x6b/0xc0:
driver_register at drivers/base/driver.c:246

> 
>> otherwise syzbot testing can't work which is more painful than
>> applying this patch now.
> 
> Again, I'm totally confused.  What is the real bug/problem/issue here?

Since the possibility of deadlock is not reported by lockdep, we can't find
real deadlocks unless khungtaskd reports it as a hung task.

> 
> Where is the deadlock?

In driver core code (an example shown above) and in many driver codes
(an example shown below). Since dev->mutex is hidden from lockdep checks,
real deadlocks cannot be reported until khungtaskd reports as hung tasks.

----------
INFO: task syz-executor145:4505 blocked for more than 143 seconds.
Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor145 state:D stack:21896 pid:4505 ppid:3645 flags:0x00004002
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5191 [inline]
__schedule+0x8c9/0xd70 kernel/sched/core.c:6503
schedule+0xcb/0x190 kernel/sched/core.c:6579
schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6638
__mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
__mutex_lock kernel/locking/mutex.c:747 [inline]
mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
rfkill_unregister+0xcb/0x220 net/rfkill/core.c:1130
nfc_unregister_device+0xba/0x290 net/nfc/core.c:1167
virtual_ncidev_close+0x55/0x90 drivers/nfc/virtual_ncidev.c:166
__fput+0x3ba/0x880 fs/file_table.c:320
task_work_run+0x243/0x300 kernel/task_work.c:179
exit_task_work include/linux/task_work.h:38 [inline]
do_exit+0x664/0x2070 kernel/exit.c:820
do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
__do_sys_exit_group kernel/exit.c:961 [inline]
__se_sys_exit_group kernel/exit.c:959 [inline]
__x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc8e3d92af9
RSP: 002b:00007fff2cfab0b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fc8e3e06330 RCX: 00007fc8e3d92af9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fc8e3e06330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
</TASK> 
INFO: task syz-executor145:4516 blocked for more than 144 seconds.
Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor145 state:D stack:23096 pid:4516 ppid:3647 flags:0x00004004
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5191 [inline]
__schedule+0x8c9/0xd70 kernel/sched/core.c:6503
schedule+0xcb/0x190 kernel/sched/core.c:6579
schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6638
__mutex_lock_common+0xe4f/0x26e0 kernel/locking/mutex.c:679
__mutex_lock kernel/locking/mutex.c:747 [inline]
mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
device_lock include/linux/device.h:835 [inline]
nfc_dev_down+0x33/0x260 net/nfc/core.c:143
nfc_rfkill_set_block+0x28/0xc0 net/nfc/core.c:179
rfkill_set_block+0x1e7/0x430 net/rfkill/core.c:345
rfkill_fop_write+0x5db/0x790 net/rfkill/core.c:1286
vfs_write+0x303/0xc50 fs/read_write.c:582
ksys_write+0x177/0x2a0 fs/read_write.c:637
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc8e3d93e69
RSP: 002b:00007fff2cfab108 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007fc8e3d93e69
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000000d60b
R13: 00007fff2cfab11c R14: 00007fff2cfab130 R15: 00007fff2cfab120
</TASK> 
----------

----------
2 locks held by syz-executor145/4505:
#0: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
#0: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x87/0x290 net/nfc/core.c:1165
#1: ffffffff8e787b08 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unregister+0xcb/0x220 net/rfkill/core.c:1130
2 locks held by syz-executor145/4516:
#0: ffffffff8e787b08 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1b3/0x790 net/rfkill/core.c:1278
#1: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
#1: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down+0x33/0x260 net/nfc/core.c:143
----------

> 
>> Therefore, I locally tested this patch (in order not to be applied now).
> 
> What patch?  I'm totally confused.

The "drivers/core: Remove lockdep_set_novalidate_class() usage" shown above.

> 
>> And I got a lockdep warning on the perf_event code.
> 
> What warning?

Here is a copy.

----------
[    2.241650][    T9] Trying to unpack rootfs image as initramfs...
[    2.241630][    T1] software IO TLB: mapped [mem 0x00000000bbed0000-0x00000000bfed0000] (64MB)
[    2.241670][    T1] workingset: timestamp_bits=46 max_order=21 bucket_order=0
[    2.241670][    T1] SGI XFS with ACLs, security attributes, verbose warnings, quota, no debug enabled
[    2.241670][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.798150][    T1] 
[    2.798660][    T1] ======================================================
[    2.798660][    T1] WARNING: possible circular locking dependency detected
[    2.798660][    T1] 6.2.0-rc5+ #9 Not tainted
[    2.798660][    T1] ------------------------------------------------------
[    2.798660][    T1] swapper/0/1 is trying to acquire lock:
[    2.798660][    T1] ffffffffb002e888 (cpu_add_remove_lock){+.+.}-{3:3}, at: cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1] 
[    2.798660][    T1] but task is already holding lock:
[    2.798660][    T1] ffff941940a161b8 (&dev->mutex){+.+.}-{3:3}, at: __device_driver_lock+0x28/0x40
[    2.798660][    T1] 
[    2.798660][    T1] which lock already depends on the new lock.
[    2.798660][    T1] 
[    2.798660][    T1] 
[    2.798660][    T1] the existing dependency chain (in reverse order) is:
[    2.798660][    T1] 
[    2.798660][    T1] -> #3 (&dev->mutex){+.+.}-{3:3}:
[    2.798660][    T1]        lock_acquire+0xc7/0x2e0
[    2.798660][    T1]        __mutex_lock+0x99/0xf00
[    2.798660][    T1]        mutex_lock_nested+0x16/0x20
[    2.798660][    T1]        __device_attach+0x35/0x1a0
[    2.798660][    T1]        device_initial_probe+0xe/0x10
[    2.798660][    T1]        bus_probe_device+0x9b/0xb0
[    2.798660][    T1]        device_add+0x3e1/0x900
[    2.798660][    T1]        pmu_dev_alloc+0x98/0xf0
[    2.798660][    T1]        perf_event_sysfs_init+0x56/0x8f
[    2.798660][    T1]        do_one_initcall+0x58/0x300
[    2.798660][    T1]        kernel_init_freeable+0x181/0x1d2
[    2.798660][    T1]        kernel_init+0x15/0x120
[    2.798660][    T1]        ret_from_fork+0x1f/0x30
[    2.798660][    T1] 
[    2.798660][    T1] -> #2 (pmus_lock){+.+.}-{3:3}:
[    2.798660][    T1]        lock_acquire+0xc7/0x2e0
[    2.798660][    T1]        __mutex_lock+0x99/0xf00
[    2.798660][    T1]        mutex_lock_nested+0x16/0x20
[    2.798660][    T1]        perf_event_init_cpu+0x4c/0x110
[    2.798660][    T1]        cpuhp_invoke_callback+0x17a/0x880
[    2.798660][    T1]        __cpuhp_invoke_callback_range+0x77/0xb0
[    2.798660][    T1]        _cpu_up+0xdc/0x240
[    2.798660][    T1]        cpu_up+0x8c/0xa0
[    2.798660][    T1]        bringup_nonboot_cpus+0x56/0x60
[    2.798660][    T1]        smp_init+0x25/0x5f
[    2.798660][    T1]        kernel_init_freeable+0xb4/0x1d2
[    2.798660][    T1]        kernel_init+0x15/0x120
[    2.798660][    T1]        ret_from_fork+0x1f/0x30
[    2.798660][    T1] 
[    2.798660][    T1] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[    2.798660][    T1]        lock_acquire+0xc7/0x2e0
[    2.798660][    T1]        percpu_down_write+0x44/0x2c0
[    2.798660][    T1]        _cpu_up+0x35/0x240
[    2.798660][    T1]        cpu_up+0x8c/0xa0
[    2.798660][    T1]        bringup_nonboot_cpus+0x56/0x60
[    2.798660][    T1]        smp_init+0x25/0x5f
[    2.798660][    T1]        kernel_init_freeable+0xb4/0x1d2
[    2.798660][    T1]        kernel_init+0x15/0x120
[    2.798660][    T1]        ret_from_fork+0x1f/0x30
[    2.798660][    T1] 
[    2.798660][    T1] -> #0 (cpu_add_remove_lock){+.+.}-{3:3}:
[    2.798660][    T1]        check_prevs_add+0x16a/0x1070
[    2.798660][    T1]        __lock_acquire+0x11bd/0x1670
[    2.798660][    T1]        lock_acquire+0xc7/0x2e0
[    2.798660][    T1]        __mutex_lock+0x99/0xf00
[    2.798660][    T1]        mutex_lock_nested+0x16/0x20
[    2.798660][    T1]        cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1]        pci_device_probe+0x8c/0x150
[    2.798660][    T1]        really_probe+0xd9/0x340
[    2.798660][    T1]        __driver_probe_device+0x78/0x170
[    2.798660][    T1]        driver_probe_device+0x1f/0x90
[    2.798660][    T1]        __driver_attach+0xaa/0x160
[    2.798660][    T1]        bus_for_each_dev+0x75/0xb0
[    2.798660][    T1]        driver_attach+0x19/0x20
[    2.798660][    T1]        bus_add_driver+0x1be/0x210
[    2.798660][    T1]        driver_register+0x6b/0xc0
[    2.798660][    T1]        __pci_register_driver+0x7c/0x80
[    2.798660][    T1]        pcie_portdrv_init+0x3d/0x45
[    2.798660][    T1]        do_one_initcall+0x58/0x300
[    2.798660][    T1]        kernel_init_freeable+0x181/0x1d2
[    2.798660][    T1]        kernel_init+0x15/0x120
[    2.798660][    T1]        ret_from_fork+0x1f/0x30
[    2.798660][    T1] 
[    2.798660][    T1] other info that might help us debug this:
[    2.798660][    T1] 
[    2.798660][    T1] Chain exists of:
[    2.798660][    T1]   cpu_add_remove_lock --> pmus_lock --> &dev->mutex
[    2.798660][    T1] 
[    2.798660][    T1]  Possible unsafe locking scenario:
[    2.798660][    T1] 
[    2.798660][    T1]        CPU0                    CPU1
[    2.798660][    T1]        ----                    ----
[    2.798660][    T1]   lock(&dev->mutex);
[    2.798660][    T1]                                lock(pmus_lock);
[    2.798660][    T1]                                lock(&dev->mutex);
[    2.798660][    T1]   lock(cpu_add_remove_lock);
[    2.798660][    T1] 
[    2.798660][    T1]  *** DEADLOCK ***
[    2.798660][    T1] 
[    2.798660][    T1] 1 lock held by swapper/0/1:
[    2.798660][    T1]  #0: ffff941940a161b8 (&dev->mutex){+.+.}-{3:3}, at: __device_driver_lock+0x28/0x40
[    2.798660][    T1] 
[    2.798660][    T1] stack backtrace:
[    2.798660][    T1] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc5+ #9
[    2.798660][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[    2.798660][    T1] Call Trace:
[    2.798660][    T1]  <TASK>
[    2.798660][    T1]  dump_stack_lvl+0x49/0x5e
[    2.798660][    T1]  dump_stack+0x10/0x12
[    2.798660][    T1]  print_circular_bug.isra.46.cold.66+0x13e/0x143
[    2.798660][    T1]  check_noncircular+0xfe/0x110
[    2.798660][    T1]  check_prevs_add+0x16a/0x1070
[    2.798660][    T1]  __lock_acquire+0x11bd/0x1670
[    2.798660][    T1]  lock_acquire+0xc7/0x2e0
[    2.798660][    T1]  ? cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1]  __mutex_lock+0x99/0xf00
[    2.798660][    T1]  ? cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1]  ? pci_match_device+0xd5/0x130
[    2.798660][    T1]  ? __this_cpu_preempt_check+0x13/0x20
[    2.798660][    T1]  ? cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1]  ? kernfs_add_one+0xf1/0x130
[    2.798660][    T1]  mutex_lock_nested+0x16/0x20
[    2.798660][    T1]  ? mutex_lock_nested+0x16/0x20
[    2.798660][    T1]  cpu_hotplug_disable+0x12/0x30
[    2.798660][    T1]  pci_device_probe+0x8c/0x150
[    2.798660][    T1]  really_probe+0xd9/0x340
[    2.798660][    T1]  ? pm_runtime_barrier+0x52/0xb0
[    2.798660][    T1]  __driver_probe_device+0x78/0x170
[    2.798660][    T1]  driver_probe_device+0x1f/0x90
[    2.798660][    T1]  __driver_attach+0xaa/0x160
[    2.798660][    T1]  ? __device_attach_driver+0x100/0x100
[    2.798660][    T1]  bus_for_each_dev+0x75/0xb0
[    2.798660][    T1]  driver_attach+0x19/0x20
[    2.798660][    T1]  bus_add_driver+0x1be/0x210
[    2.798660][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.798660][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.798660][    T1]  ? rdinit_setup+0x27/0x27
[    2.798660][    T1]  driver_register+0x6b/0xc0
[    2.798660][    T1]  ? dmi_pcie_pme_disable_msi+0x1f/0x1f
[    2.798660][    T1]  __pci_register_driver+0x7c/0x80
[    2.798660][    T1]  pcie_portdrv_init+0x3d/0x45
[    2.798660][    T1]  do_one_initcall+0x58/0x300
[    2.798660][    T1]  ? rdinit_setup+0x27/0x27
[    2.798660][    T1]  ? rcu_read_lock_sched_held+0x4a/0x70
[    2.798660][    T1]  kernel_init_freeable+0x181/0x1d2
[    2.798660][    T1]  ? rest_init+0x190/0x190
[    2.798660][    T1]  kernel_init+0x15/0x120
[    2.798660][    T1]  ret_from_fork+0x1f/0x30
[    2.798660][    T1]  </TASK>
[    3.991673][   T92] tsc: Refined TSC clocksource calibration: 2611.210 MHz
[    3.991673][   T92] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25a399d04c4, max_idle_ns: 440795206293 ns
[    4.992946][   T92] clocksource: Switched to clocksource tsc
----------


> 
>> I got next lockdep warning on the driver core code when I tried a fix
>> for the perf_event code suggested by Peter Zijlstra.
> 
> Again, what warning?

Shown above.

[    2.837244][    T1] swapper/0/1 is trying to acquire lock:
[    2.837244][    T1] ffff984dc3d50108 (&dev->mutex){+.+.}-{3:3}, at: __device_attach+0x35/0x1a0
[    2.837244][    T1] 
[    2.837244][    T1] but task is already holding lock:
[    2.837244][    T1] ffff984dc1b5e1b8 (&dev->mutex){+.+.}-{3:3}, at: __device_driver_lock+0x28/0x40
[    2.837244][    T1] 
[    2.837244][    T1] other info that might help us debug this:
[    2.837244][    T1]  Possible unsafe locking scenario:
[    2.837244][    T1] 
[    2.837244][    T1]        CPU0
[    2.837244][    T1]        ----
[    2.837244][    T1]   lock(&dev->mutex);
[    2.837244][    T1]   lock(&dev->mutex);
[    2.837244][    T1] 
[    2.837244][    T1]  *** DEADLOCK ***

> 
>> Since Peter confirmed that this is a problem that led to commit
>> 1704f47b50b5 ("lockdep: Add novalidate class for dev->mutex
>> conversion"), this time I'm reporting this problem to you (so that you
>> can propose a fix for the driver core code).
> 
> Again, I have no idea what the real problem is!

Since dev->mutex is hidden from lockdep checks, real deadlocks cannot be
reported until khungtaskd reports as hung tasks.

> 
> Please show me in the driver core code, where the deadlock is that needs
> to be resolved.  Without that, I can't answer anything...
> 
> totally and throughly confused,
> 
> greg k-h

