Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C206C8E53
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjCYM76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:59:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D8F741
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679749195; x=1711285195;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5NFuuJ9R5/2GkZORxDmK/RXRm0Ius/GovOr57hhy0zw=;
  b=V/89RhurBB/zHvimKc/V18XdOJZZzYoF5g97reVeHcth+qWXcZB8sXCa
   /c8DNB1ouhZOs3+O2sqZkJaFULD0D3THIx2u1dw52duOHtTtv2OU0OxXK
   L1QHZOkYg/tiAc78OgCrwDPgkFA0GZN7Hit7814Tqeh1q5jCYQiwpri2h
   2rGJL1pC6SfA5KIvbmLoc5jLI7iOJqvv3F9biIuA68LsAweGx2MXFbynV
   u2IvxfgkTI9eQ3k6YJIaGV9elXjE+CQ9XjZWNM0CwxlC+5hbuFOpa2Jc1
   Muf1WACn7/+ia1syQDaRqwbW0wioX+NF0rtN6k9DiI1mlvCVUcTItOU0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323852282"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="323852282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 05:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="715548754"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="715548754"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.81]) ([10.254.208.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 05:59:52 -0700
Message-ID: <92d4e37f-9bc0-101d-dd78-ae9957348c0d@linux.intel.com>
Date:   Sat, 25 Mar 2023 20:59:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix a IOMMU perfmon warning when CPU hotplug
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230324151106.526132-1-kan.liang@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230324151106.526132-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/24 23:11, kan.liang@linux.intel.com wrote:
> From: Kan Liang<kan.liang@linux.intel.com>
> 
> A warning can be triggered when hotplug CPU 0.
>   $ echo 0 > /sys/devices/system/cpu/cpu0/online
> 
> [11958.737635] ------------[ cut here ]------------
> [11958.742882] Voluntary context switch within RCU read-side critical
> section!
> [11958.742891] WARNING: CPU: 0 PID: 19 at kernel/rcu/tree_plugin.h:318
> rcu_note_context_switch+0x4f4/0x580
> [11958.860095] RIP: 0010:rcu_note_context_switch+0x4f4/0x580
> [11958.960360] Call Trace:
> [11958.963161]  <TASK>
> [11958.965565]  ? perf_event_update_userpage+0x104/0x150
> [11958.971293]  __schedule+0x8d/0x960
> [11958.975165]  ? perf_event_set_state.part.82+0x11/0x50
> [11958.980891]  schedule+0x44/0xb0
> [11958.984464]  schedule_timeout+0x226/0x310
> [11958.989017]  ? __perf_event_disable+0x64/0x1a0
> [11958.994054]  ? _raw_spin_unlock+0x14/0x30
> [11958.998605]  wait_for_completion+0x94/0x130
> [11959.003352]  __wait_rcu_gp+0x108/0x130
> [11959.007616]  synchronize_rcu+0x67/0x70
> [11959.011876]  ? invoke_rcu_core+0xb0/0xb0
> [11959.016333]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
> [11959.022147]  perf_pmu_migrate_context+0x121/0x370
> [11959.027478]  iommu_pmu_cpu_offline+0x6a/0xa0
> [11959.032325]  ? iommu_pmu_del+0x1e0/0x1e0
> [11959.036782]  cpuhp_invoke_callback+0x129/0x510
> [11959.041825]  cpuhp_thread_fun+0x94/0x150
> [11959.046283]  smpboot_thread_fn+0x183/0x220
> [11959.050933]  ? sort_range+0x20/0x20
> [11959.054902]  kthread+0xe6/0x110
> [11959.058479]  ? kthread_complete_and_exit+0x20/0x20
> [11959.063911]  ret_from_fork+0x1f/0x30
> [11959.067982]  </TASK>
> [11959.070489] ---[ end trace 0000000000000000 ]---
> 
> The synchronize_rcu() will be invoked in the perf_pmu_migrate_context(),
> when migrating a PMU to a new CPU. However, the current for_each_iommu()
> is within RCU read-side critical section.
> 
> Use the dmar_global_lock to replace the RCU read lock when going through
> the drhd list.

This introduces the following lockdep warning.

The iommu_pmu_register() path holds the dmar_global_lock and applies for
cpuhp_state lock; On the contrary, the iommu_pmu_cpu_offline() path
holds the cpuhp_state and applies for the dmar_global_lock.

Can you please have a look into it?

[12861.883945] ======================================================
[12861.884750] WARNING: possible circular locking dependency detected
[12861.885556] 6.3.0-rc3-00033-g5ff8930d087a #491 Not tainted
[12861.886272] ------------------------------------------------------
[12861.887077] cpuhp/0/19 is trying to acquire lock:
[12861.887703] ffffffff91c1d0d0 (dmar_global_lock){++++}-{3:3}, at: 
iommu_pmu_cpu_offline+0x62/0xd0
[12861.888839]
                but task is already holding lock:
[12861.889605] ffffffff8e26ed40 (cpuhp_state-down){+.+.}-{0:0}, at: 
cpuhp_thread_fun+0x4b/0x210
[12861.890701]
                which lock already depends on the new lock.

[12861.891747]
                the existing dependency chain (in reverse order) is:
[12861.892713]
                -> #2 (cpuhp_state-down){+.+.}-{0:0}:
[12861.893525]        lock_acquire+0xc2/0x2a0
[12861.894074]        cpuhp_kick_ap_work+0x5b/0x1d0
[12861.894692]        _cpu_down+0xc3/0x300
[12861.895210]        cpu_down+0x2e/0x50
[12861.895708]        device_offline+0x8c/0xc0
[12861.896266]        online_store+0x4e/0xa0
[12861.896804]        kernfs_fop_write_iter+0x12a/0x1d0
[12861.897462]        vfs_write+0x313/0x4c0
[12861.897989]        ksys_write+0x60/0xe0
[12861.898507]        do_syscall_64+0x43/0x90
[12861.899055]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
[12861.899783]
                -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[12861.900595]        lock_acquire+0xc2/0x2a0
[12861.901143]        __cpuhp_setup_state+0x5b/0x1f0
[12861.901772]        iommu_pmu_register+0x1a2/0x200
[12861.902400]        intel_iommu_init+0x5de/0x880
[12861.903009]        pci_iommu_init+0x12/0x40
[12861.903567]        do_one_initcall+0x65/0x290
[12861.904155]        kernel_init_freeable+0x3cf/0x560
[12861.904804]        kernel_init+0x1a/0x140
[12861.905342]        ret_from_fork+0x29/0x50
[12861.905890]
                -> #0 (dmar_global_lock){++++}-{3:3}:
[12861.906702]        check_prevs_add+0x160/0xee0
[12861.907300]        __lock_acquire+0x143b/0x18c0
[12861.907909]        lock_acquire+0xc2/0x2a0
[12861.908457]        down_write+0x3f/0xc0
[12861.908976]        iommu_pmu_cpu_offline+0x62/0xd0
[12861.909614]        cpuhp_invoke_callback+0x175/0x670
[12861.910273]        cpuhp_thread_fun+0x19d/0x210
[12861.910882]        smpboot_thread_fn+0x11d/0x240
[12861.911501]        kthread+0xeb/0x120
[12861.911998]        ret_from_fork+0x29/0x50
[12861.912546]
                other info that might help us debug this:

[12861.913572] Chain exists of:
                  dmar_global_lock --> cpu_hotplug_lock --> cpuhp_state-down

[12861.914977]  Possible unsafe locking scenario:

[12861.915753]        CPU0                    CPU1
[12861.916358]        ----                    ----
[12861.916963]   lock(cpuhp_state-down);
[12861.917460]                                lock(cpu_hotplug_lock);
[12861.918269]                                lock(cpuhp_state-down);
[12861.919077]   lock(dmar_global_lock);
[12861.919575]
                 *** DEADLOCK ***

[12861.920350] 2 locks held by cpuhp/0/19:
[12861.920865]  #0: ffffffff8e26ebd0 (cpu_hotplug_lock){++++}-{0:0}, at: 
cpuhp_thread_fun+0x47/0x210
[12861.922014]  #1: ffffffff8e26ed40 (cpuhp_state-down){+.+.}-{0:0}, at: 
cpuhp_thread_fun+0x4b/0x210
[12861.923162]
                stack backtrace:
[12861.923747] CPU: 0 PID: 19 Comm: cpuhp/0 Not tainted 
6.3.0-rc3-00033-g5ff8930d087a #491
[12861.924775] Hardware name: Intel Corporation BIRCHSTREAM/BIRCHSTREAM, 
BIOS BHSDREL1.86B.0018.D47.2211031932 11/03/2022
[12861.926133] Call Trace:
[12861.926478]  <TASK>
[12861.926783]  dump_stack_lvl+0x4a/0x80
[12861.927282]  check_noncircular+0x102/0x120
[12861.927833]  ? alloc_list_entry+0x13/0x130
[12861.928384]  check_prevs_add+0x160/0xee0
[12861.928918]  __lock_acquire+0x143b/0x18c0
[12861.929461]  lock_acquire+0xc2/0x2a0
[12861.929950]  ? iommu_pmu_cpu_offline+0x62/0xd0
[12861.930550]  ? lock_is_held_type+0x9d/0x110
[12861.931113]  down_write+0x3f/0xc0
[12861.931572]  ? iommu_pmu_cpu_offline+0x62/0xd0
[12861.932171]  iommu_pmu_cpu_offline+0x62/0xd0
[12861.932749]  ? __pfx_iommu_pmu_cpu_offline+0x10/0x10
[12861.933408]  cpuhp_invoke_callback+0x175/0x670
[12861.934007]  ? lock_release+0xc3/0x250
[12861.934519]  cpuhp_thread_fun+0x19d/0x210
[12861.935059]  ? smpboot_thread_fn+0x2f/0x240
[12861.935618]  ? smpboot_thread_fn+0x69/0x240
[12861.936177]  ? smpboot_thread_fn+0x125/0x240
[12861.936757]  smpboot_thread_fn+0x11d/0x240
[12861.937308]  ? __pfx_smpboot_thread_fn+0x10/0x10
[12861.937927]  kthread+0xeb/0x120
[12861.938365]  ? __pfx_kthread+0x10/0x10
[12861.938874]  ret_from_fork+0x29/0x50
[12861.939370]  </TASK>

Best regards,
baolu
