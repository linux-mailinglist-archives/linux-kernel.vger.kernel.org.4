Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBC677DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjAWOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjAWOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:11:16 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27131113F9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:11:13 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30NEBB6C071018;
        Mon, 23 Jan 2023 23:11:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 23 Jan 2023 23:11:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30NEB1Rd070983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Jan 2023 23:11:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp>
Date:   Mon, 23 Jan 2023 23:10:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [perf] lockdep warning between cpu_add_remove_lock and
 &dev->mutex.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp>
 <Y85yadQes4fSwCZm@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y85yadQes4fSwCZm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/23 20:41, Peter Zijlstra wrote:
> On Mon, Jan 23, 2023 at 07:39:24PM +0900, Tetsuo Handa wrote:
>> Hello.
>>
>> I tried to apply below patch, and hit lockdep warning during boot.
>> Can you break this dependency?
> 
>   cpu_add_remove_lock
>     cpu_hotplug_lock
>       pmus_lock
>         dev->mutex		(pmu_dev_alloc)
> 
> vs
> 
>   dev->mutex
>     cpu_add_remove_lock		(pci_device_probe)
> 
> 
> Possibly something like this might do -- I'm not entirely sure it's
> fully correct, needs a bit of auditing.
> 

After applying your diff, lockdep message changed like below. Is this
the reason commit 1704f47b50b5 ("lockdep: Add novalidate class for
dev->mutex conversion") was applied?

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


