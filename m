Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7E677956
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjAWKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjAWKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:39:28 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923BFEB51
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:39:26 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 30NAdO2Y029962;
        Mon, 23 Jan 2023 19:39:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 23 Jan 2023 19:39:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 30NAdOg3029957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Jan 2023 19:39:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp>
Date:   Mon, 23 Jan 2023 19:39:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [perf] lockdep warning between cpu_add_remove_lock and &dev->mutex.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I tried to apply below patch, and hit lockdep warning during boot.
Can you break this dependency?

----------
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
----------

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
