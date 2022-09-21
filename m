Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F75C0527
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIURPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIURPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:15:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C29E13F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663780516; x=1695316516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xo7/XFSY7kP5CTEiZhzZ2G2KF7thKs3aY+dQp7s+7A=;
  b=a6LyXQx0RccOOdhfdQUQo0IGeGSDrOYC3Z0g7vfeEaLXyalA+hwxMG8+
   AxUFZlaGHdA00CPNtDbZZTr3Ds3dC5AqMVppm84kjwLqmSV+JwLeRCKus
   17u8t/bBwrAFWsSHYg9HLyTrrjmqIXAwpaEfdgJk/XqPrPwqWs9BgIE0/
   pg6heieD4BpQS0EPv2jxZfdmTVpLkBm5iPKsiYTp9uipO/tkL83u1ky+s
   0OZNH18F/KSu+cnVx073ts8ZmtYWlWKS69TqrNnIQESrCc6kt3H+pAD2A
   7mBfpGCjofCtIS9uQbu9zLQhGkWKC2GmY/NHClEb4qErtYox71powBY9+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300910087"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300910087"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:15:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="681860701"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.27.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:15:06 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     intel-gfx@lists.freedesktop.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Karolina Drobnik <karolina.drobnik@intel.com>,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Yunfei Wang <yf.wang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Subject: Re: [Intel-gfx] [topic/core-for-CI] Revert "iommu/dma: Fix race condition during iova_domain initialization"
Date:   Wed, 21 Sep 2022 19:15:03 +0200
Message-ID: <3195806.44csPzL39Z@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
References: <20220914124045.903883-1-karolina.drobnik@intel.com> <20220914150121.y6ucj4mav65mt7we@ldmartin-desk2.lan> <c539a4fb-795b-0b33-2543-6a3e94164676@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wednesday, 14 September 2022 17:54:36 CEST Robin Murphy wrote:
> On 2022-09-14 16:01, Lucas De Marchi wrote:
> > On Wed, Sep 14, 2022 at 02:40:45PM +0200, Karolina Drobnik wrote:
> >> This reverts commit ac9a5d522bb80be50ea84965699e1c8257d745ce.
> >>
> >> This change introduces a regression on Alder Lake that completely
> >> blocks testing. To enable CI and avoid possible circular locking
> >> warning, revert the patch.
> > 
> > We are already on rc5. Are iommu authors involved aware of this issue?
> > We could do this in our "for CI only" branch, but it's equally important
> > that this is fixed for 6.0
> > 
> > Cc'ing them.
> 
> The lockdep report doesn't make much sense to me - the deadlock cycle 
> it's reporting doesn't even involve the mutex added by that commit, and 
> otherwise the lock ordering between the IOMMU bus notifier(s) and 
> cpu_hotplug_lock has existed for ages. 

Indeed, that lockdep report is not quite related, but there are other lockdep 
reports in our CI results that better justify the revert.

https://intel-gfx-ci.01.org/tree/drm-tip/TrybotIGT_595/bat-dg2-8/igt@core_hotunplug@unplug-rescan.html

...
<7> [181.565177] [IGT] core_hotunplug: unplugging the device
<7> [181.565372] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling DC_off
<7> [181.565708] i915 0000:03:00.0: [drm:gen9_set_dc_state.part.15 [i915]] Setting DC state from 01 to 00
<7> [181.566060] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_2
<7> [181.566216] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_A
<7> [181.566447] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_B
<7> [181.566607] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_C
<7> [181.566765] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_D
<7> [181.570683] intel_gt_set_wedged called from intel_gt_set_wedged_on_fini+0x9/0x30 [i915]
<7> [181.659480] i915 0000:03:00.0: [drm:drm_client_release] drm_fb_helper
<6> [181.773310] pci 0000:03:00.0: Removing from iommu group 1
<7> [181.774416] [IGT] core_hotunplug: rediscovering the device
<6> [181.775800] pci 0000:03:00.0: [8086:56a0] type 00 class 0x030000
<6> [181.775833] pci 0000:03:00.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit]
<6> [181.775852] pci 0000:03:00.0: reg 0x18: [mem 0x4000000000-0x43ffffffff 64bit pref]
<6> [181.775886] pci 0000:03:00.0: reg 0x30: [mem 0xffe00000-0xffffffff pref]
<6> [181.776058] pci 0000:03:00.0: ASPM: overriding L1 acceptable latency from 0x0 to 0x7
<6> [181.776073] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
<6> [181.776209] pci 0000:03:00.0: PME# supported from D0 D3hot
<6> [181.776869] pci 0000:03:00.0: vgaarb: setting as boot VGA device
<6> [181.776878] pci 0000:03:00.0: vgaarb: bridge control possible
<6> [181.776881] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
<6> [181.777052] pci 0000:03:00.0: Adding to iommu group 1
<4> [181.777164] 
<4> [181.777169] ======================================================
<4> [181.777176] WARNING: possible circular locking dependency detected
<4> [181.777182] 6.0.0-rc5-CI_DRM_12145-g2dc9ea03abff+ #1 Not tainted
<4> [181.777189] ------------------------------------------------------
<4> [181.777196] core_hotunplug/1240 is trying to acquire lock:
<4> [181.777202] ffff8881029b33b0 (&domain->iova_cookie->mutex){+.+.}-{3:3}, at: iommu_setup_dma_ops+0xd7/0x440
<4> [181.777218] 
but task is already holding lock:
<4> [181.777225] ffff8881010c9e78 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x20/0x50
<4> [181.777242] 
which lock already depends on the new lock.
<4> [181.777250] 
the existing dependency chain (in reverse order) is:
<4> [181.777258] 
-> #3 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
<4> [181.777268]        lock_acquire+0xd3/0x310
<4> [181.777274]        down_read+0x39/0x140
<4> [181.777281]        blocking_notifier_call_chain+0x20/0x50
<4> [181.777289]        device_add+0x3c1/0x900
<4> [181.777295]        platform_device_add+0x108/0x240
<4> [181.777302]        coretemp_cpu_online+0xe1/0x15e [coretemp]
<4> [181.777310]        cpuhp_invoke_callback+0x181/0x8a0
<4> [181.777318]        cpuhp_thread_fun+0x188/0x1f0
<4> [181.777325]        smpboot_thread_fn+0x1b5/0x260
<4> [181.777332]        kthread+0xed/0x120
<4> [181.777337]        ret_from_fork+0x1f/0x30
<4> [181.777343] 
-> #2 (cpuhp_state-up){+.+.}-{0:0}:
<4> [181.777352]        lock_acquire+0xd3/0x310
<4> [181.777358]        cpuhp_thread_fun+0xa6/0x1f0
<4> [181.777364]        smpboot_thread_fn+0x1b5/0x260
<4> [181.777370]        kthread+0xed/0x120
<4> [181.777375]        ret_from_fork+0x1f/0x30
<4> [181.777381] 
-> #1 (cpu_hotplug_lock){++++}-{0:0}:
<4> [181.777390]        lock_acquire+0xd3/0x310
<4> [181.777395]        __cpuhp_state_add_instance+0x43/0x1c0
<4> [181.777402]        iova_domain_init_rcaches+0x199/0x1c0
<4> [181.777409]        iommu_setup_dma_ops+0x130/0x440
<4> [181.777415]        bus_iommu_probe+0x26a/0x2d0
<4> [181.777422]        bus_set_iommu+0x82/0xd0
<4> [181.777428]        intel_iommu_init+0xe33/0x1039
<4> [181.777435]        pci_iommu_init+0x9/0x31
<4> [181.777442]        do_one_initcall+0x53/0x2f0
<4> [181.777448]        kernel_init_freeable+0x18f/0x1e1
<4> [181.777455]        kernel_init+0x11/0x120
<4> [181.777461]        ret_from_fork+0x1f/0x30
<4> [181.777467] 
-> #0 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
<4> [181.777477]        validate_chain+0xb3f/0x2000
<4> [181.777484]        __lock_acquire+0x5a4/0xb70
<4> [181.777490]        lock_acquire+0xd3/0x310
<4> [181.777495]        __mutex_lock+0x97/0xf10
<4> [181.777501]        iommu_setup_dma_ops+0xd7/0x440
<4> [181.777507]        iommu_probe_device+0xa4/0x180
<4> [181.777514]        iommu_bus_notifier+0x2d/0x40
<4> [181.777521]        notifier_call_chain+0x31/0x90
<4> [181.777528]        blocking_notifier_call_chain+0x3a/0x50
<4> [181.777535]        device_add+0x3c1/0x900
<4> [181.777541]        pci_device_add+0x255/0x580
<4> [181.777548]        pci_scan_single_device+0xa6/0xd0
<4> [181.777555]        pci_scan_slot+0x7a/0x1b0
<4> [181.777561]        pci_scan_child_bus_extend+0x35/0x2a0
<4> [181.777568]        pci_scan_bridge_extend+0x588/0x650
<4> [181.777575]        pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.777582]        pci_scan_bridge_extend+0x588/0x650
<4> [181.777589]        pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.777596]        pci_scan_bridge_extend+0x588/0x650
<4> [181.777602]        pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.777609]        pci_rescan_bus+0xc/0x30
<4> [181.777616]        rescan_store+0x60/0x90
<4> [181.777622]        kernfs_fop_write_iter+0x121/0x1c0
<4> [181.777630]        vfs_write+0x34c/0x4e0
<4> [181.777636]        ksys_write+0x57/0xd0
<4> [181.777642]        do_syscall_64+0x37/0x90
<4> [181.777648]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4> [181.777655] 
other info that might help us debug this:
<4> [181.777664] Chain exists of:
  &domain->iova_cookie->mutex --> cpuhp_state-up --> &(&priv->bus_notifier)->rwsem
<4> [181.777680]  Possible unsafe locking scenario:
<4> [181.777686]        CPU0                    CPU1
<4> [181.777691]        ----                    ----
<4> [181.777696]   lock(&(&priv->bus_notifier)->rwsem);
<4> [181.777703]                                lock(cpuhp_state-up);
<4> [181.777710]                                lock(&(&priv->bus_notifier)->rwsem);
<4> [181.777719]   lock(&domain->iova_cookie->mutex);
<4> [181.777725] 
 *** DEADLOCK ***
<4> [181.777732] 5 locks held by core_hotunplug/1240:
<4> [181.777738]  #0: ffff888106e3c430 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x57/0xd0
<4> [181.777752]  #1: ffff888118f92688 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xee/0x1c0
<4> [181.777764]  #2: ffff8881010952a0 (kn->active#405){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf7/0x1c0
<4> [181.777778]  #3: ffffffff827a48c8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: rescan_store+0x54/0x90
<4> [181.777792]  #4: ffff8881010c9e78 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x20/0x50
<4> [181.777807] 
stack backtrace:
<4> [181.777813] CPU: 9 PID: 1240 Comm: core_hotunplug Not tainted 6.0.0-rc5-CI_DRM_12145-g2dc9ea03abff+ #1
<4> [181.777824] Hardware name: Intel Corporation CoffeeLake Client Platform/CoffeeLake S UDIMM RVP, BIOS CNLSFWR1.R00.X220.B00.2103302221 03/30/2021
<4> [181.777837] Call Trace:
<4> [181.777840]  <TASK>
<4> [181.777844]  dump_stack_lvl+0x56/0x7f
<4> [181.777851]  check_noncircular+0x132/0x150
<4> [181.777858]  ? validate_chain+0x247/0x2000
<4> [181.777867]  validate_chain+0xb3f/0x2000
<4> [181.777876]  __lock_acquire+0x5a4/0xb70
<4> [181.777883]  lock_acquire+0xd3/0x310
<4> [181.777889]  ? iommu_setup_dma_ops+0xd7/0x440
<4> [181.777897]  __mutex_lock+0x97/0xf10
<4> [181.777903]  ? iommu_setup_dma_ops+0xd7/0x440
<4> [181.777910]  ? iommu_setup_dma_ops+0xd7/0x440
<4> [181.777918]  ? iommu_setup_dma_ops+0xd7/0x440
<4> [181.777924]  iommu_setup_dma_ops+0xd7/0x440
<4> [181.777931]  ? __mutex_unlock_slowpath+0x3e/0x2b0
<4> [181.777939]  iommu_probe_device+0xa4/0x180
<4> [181.777947]  iommu_bus_notifier+0x2d/0x40
<4> [181.777953]  notifier_call_chain+0x31/0x90
<4> [181.777961]  blocking_notifier_call_chain+0x3a/0x50
<4> [181.777968]  device_add+0x3c1/0x900
<4> [181.777974]  ? _raw_read_unlock+0x24/0x40
<4> [181.777980]  ? region_intersects+0x95/0xb0
<4> [181.777988]  pci_device_add+0x255/0x580
<4> [181.777994]  ? pci_setup_device.cold.56+0x318/0x5b6
<4> [181.778003]  pci_scan_single_device+0xa6/0xd0
<4> [181.778010]  pci_scan_slot+0x7a/0x1b0
<4> [181.778017]  pci_scan_child_bus_extend+0x35/0x2a0
<4> [181.778026]  pci_scan_bridge_extend+0x588/0x650
<4> [181.778034]  pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.778042]  pci_scan_bridge_extend+0x588/0x650
<4> [181.778051]  pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.778059]  pci_scan_bridge_extend+0x588/0x650
<4> [181.778068]  pci_scan_child_bus_extend+0xd7/0x2a0
<4> [181.778076]  pci_rescan_bus+0xc/0x30
<4> [181.778082]  rescan_store+0x60/0x90
<4> [181.778089]  kernfs_fop_write_iter+0x121/0x1c0
<4> [181.778096]  vfs_write+0x34c/0x4e0
<4> [181.778104]  ksys_write+0x57/0xd0
<4> [181.778111]  do_syscall_64+0x37/0x90
<4> [181.778117]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
<4> [181.778123] RIP: 0033:0x7f43eb46e2f7
<4> [181.778129] Code: 75 05 48 83 c4 58 c3 e8 f7 33 ff ff 0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
<4> [181.778148] RSP: 002b:00007ffe001a12a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4> [181.778158] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f43eb46e2f7
<4> [181.778166] RDX: 0000000000000001 RSI: 0000559c8480518a RDI: 0000000000000005
<4> [181.778173] RBP: 0000559c8480518a R08: 0000000000000000 R09: 0000000000000000
<4> [181.778181] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
<4> [181.778189] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
<4> [181.778200]  </TASK>
...

The same test on kernel with the revert applied
(https://intel-gfx-ci.01.org/tree/drm-tip/TrybotIGT_598/bat-dg2-8/igt@core_hotunplug@unplug-rescan.html):

...
<7> [172.263693] [IGT] core_hotunplug: unplugging the device
<7> [172.263862] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling DC_off
<7> [172.264185] i915 0000:03:00.0: [drm:gen9_set_dc_state.part.15 [i915]] Setting DC state from 01 to 00
<7> [172.264535] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_2
<7> [172.264707] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_A
<7> [172.264931] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_B
<7> [172.265098] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_C
<7> [172.265264] i915 0000:03:00.0: [drm:intel_power_well_enable [i915]] enabling PW_D
<7> [172.268842] intel_gt_set_wedged called from intel_gt_set_wedged_on_fini+0x9/0x30 [i915]
<7> [172.346115] i915 0000:03:00.0: [drm:drm_client_release] drm_fb_helper
<6> [172.467208] pci 0000:03:00.0: Removing from iommu group 1
<7> [172.468877] [IGT] core_hotunplug: rediscovering the device
<6> [172.470464] pci 0000:03:00.0: [8086:56a0] type 00 class 0x030000
<6> [172.470504] pci 0000:03:00.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit]
<6> [172.470527] pci 0000:03:00.0: reg 0x18: [mem 0x4000000000-0x43ffffffff 64bit pref]
<6> [172.470567] pci 0000:03:00.0: reg 0x30: [mem 0xffe00000-0xffffffff pref]
<6> [172.470821] pci 0000:03:00.0: ASPM: overriding L1 acceptable latency from 0x0 to 0x7
<6> [172.470840] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
<6> [172.471014] pci 0000:03:00.0: PME# supported from D0 D3hot
<6> [172.471890] pci 0000:03:00.0: vgaarb: setting as boot VGA device
<6> [172.471903] pci 0000:03:00.0: vgaarb: bridge control possible
<6> [172.471906] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
<6> [172.472135] pci 0000:03:00.0: Adding to iommu group 1
<6> [172.472911] pci 0000:03:00.0: BAR 2: assigned [mem 0x4000000000-0x43ffffffff 64bit pref]
<6> [172.472932] pci 0000:03:00.0: BAR 0: assigned [mem 0x90000000-0x90ffffff 64bit]
<7> [172.474922] i915 0000:03:00.0: [drm:i915_driver_probe [i915]] WOPCM: 2048K
...

For completeness of the picture, here is a list of kernel commits present in 
TrybotIGT_598 and not present in TrybotIGT_595:

a7c48a0ab87ae52c087d663e83e56b8225ac4cce drm/panel: simple: Fix innolux_g121i1_l01 bus_format
521a547ced6477c54b4b0cc206000406c221b4d6 Linux 6.0-rc6
c989a62484ad75e0a06f2ffe67886e7cb6d41659 drm/gma500: Call acpi_video_register_backlight()
a7b98d4dfe68654641d56cdc7eace2c36be93a2d drm/gma500: Don't register backlight when another backlight should be used
fbf3093466d05461e3f307ffe6b1150daa4b065b drm/gma500: Use backlight_get_brightness() to get the brightness
dec4ddbe1d4a4414092309611cc97e6b9dc7ec3f drm/gma500: Change registered backlight device type to raw/native
1f90b1232773249d924868bec3c31525a69fd482 drm/gma500: Refactor backlight support (v2)
9bd3f728223ebcfef8e9d087bdd142f0e388215d io_uring/opdef: rename SENDZC_NOTIF to SEND_ZC
e3366e0234971a09f0e16f0e6fa16f4cbae45e47 io_uring/net: fix zc fixed buf lifetime
e10ea7b9b90219da305a16b3c1252169715a807b drm: panel-orientation-quirks: Add quirk for Aya Neo Air
74f481f187ce8b37ec5143cee19147da5243009c drm/gma500: Remove unnecessary suspend/resume wrappers
672c473576ca5c9f5a40ac848c938e6898a5aac8 drm/gma500: Rewrite power management code
d35a4bf66079b92e232ac85b08f19312be9b7eca drm/gma500: Remove a couple of not useful function wrappers
f3b173e9094f5b02fb92d641e3e71fee0bcda73a drm/gma500: Remove never set dev_priv->rpm_enabled flag
49da26d7b418cfc99ad2473a2e3dee2e08c5ba4a drm/gma500: Remove runtime_allowed dead code in psb_unlocked_ioctl()
9b6a16575ebf23a98a9ff84aedde9f3b25731714 drm/gma500: Fix (vblank) IRQs not working after suspend/resume
2830ca9e5b98bee82f1d1e284ce23fe7fb244ea8 drm/vboxvideo: fix repeated words in comments
770e19076065e079a32f33eb11be2057c87f1cde drm: panel-orientation-quirks: Add quirk for Anbernic Win600
8401bd361f5991ccfe9377e502fa37203ad70320 drm/plane-helper: Add a drm_plane_helper_atomic_check() helper
01f0ce3e859619ea84104d668a87ace924bd12df drm/i915/guc: Fix release build bug in 'remove log size module parameters'
bc79ef6d5a223ea59acf874f0493b79c835b17d4 Revert "iommu/dma: Fix race condition during iova_domain initialization"
835a4d18353492577093eff7cb6fa866f6e7014f drm/i915/rps: Freq caps for MTL
1551b9164f6194ffee78935d1ff515f697619483 drm/i915/mtl: PERF_LIMIT_REASONS changes for MTL
fe5979665f6408092ff6072dc894b74a192cbb53 drm/i915/debugfs: Add perf_limit_reasons in debugfs
f569ae759472fbe1f6fdddc7398360d43fdcc199 drm/i915: Handle all GTs on driver (un)load paths
4b3823ff7fa5bd000aa73384ec1f611980d00855 drm/i915: Make GEM suspend all GTs
e23a40040819a7a3fcda3c6cedaeff80ad20c231 drm/i915: Make GEM resume all engines
78a033433a5ae4fee85511ee075bc9a48312c79e drm/i915/gt: Cleanup partial engine discovery failures
e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86 drm/sched: Use parent fence instead of finished
b96fb1e724ae6839d5bffcf42dd3503db7cc7df5 dma-buf: dma_fence_wait must enable signaling
d62c43a953ce02d54521ec06217d0c2ed6d489af dma-buf: Enable signaling on fence for selftests
c85d00d4fd8b98ea4d16817f397a4de5e177afd6 dma-buf: set signaling bit for the stub fence
6ad9aa476ce23be45de9dcb03edcdbfdf6117c25 dma-buf: Remove the signaled bit status check
fc7222c3a9f56271fba02aabbfbae999042f1679 io_uring/msg_ring: check file type before putting
c4fa368466cc1b60bb92f867741488930ddd6034 blk-lib: fix blkdev_issue_secure_erase
805ce8614958c925877ba6b6dc26cdf9f8800474 parisc: Allow CONFIG_64BIT with ARCH=parisc
e359b70cc1c51138e166bd4a560e5c5995369a99 parisc: remove obsolete manual allocation aligning in iosapic
c297561bc98ad0f2a37ce0178ee3ba89ab586d70 pinctrl: ocelot: Fix interrupt controller
09eed5a1ed3c752892663976837eb4244c2f1984 gpio: mt7621: Make the irqchip immutable
8af8aed97bebe8b26a340da5236e277c3d84a8ec cifs: update internal module number
621a41ae0834cec9cab312d600d2b9de41dc6eac cifs: add missing spinlock around tcon refcount
bedc8f76b3539ac4f952114b316bcc2251e808ce cifs: always initialize struct msghdr smb_msg completely
17d3df38dc5f4cec9b0ac6eb79c1859b6e2693a4 cifs: don't send down the destination address to sendmsg for a SOCK_STREAM
56f99b8d06ef1ed1c9730948f9f05ac2b930a20b block: blk_queue_enter() / __bio_queue_enter() must return -EAGAIN for nowait
de11663b75b0a8f1cfeb00d3b4acec9bd5a49cad dt-bindings: pinctrl: qcom: drop non-working codeaurora.org emails
969d373228f6624de87aa0982d89a756e8e77471 dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org emails
94e9bc73d85aa6ecfe249e985ff57abe0ab35f34 gpio: ixp4xx: Make irqchip immutable
1660c679d6d4779fbce937d0c9dc2af56e66e62d MAINTAINERS: Update HiSilicon GPIO Driver maintainer
62bb0647b14646fa6c9aa25ecdf67ad18f13523c io_uring/rw: fix error'ed retry return values
da3b1c294d470b2cf3c7046cc9e0d5c66f0a6c65 dt-bindings: apple,aic: Fix required item "apple,fiq-index" in affinity description
95363747a6f39e88a3052fcf6ce6237769495ce0 tools/include/uapi: Fix <asm/errno.h> for parisc and xtensa
4b9d1bc7911c9d9159c4881455c584cde99fbb19 Input: hp_sdc: fix spelling typo in comment
38238be4e881a5d0abbe4872b4cd6ed790be06c8 parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()
bfbfb6182ad1d7d184b16f25165faad879147f79 nfsd_splice_actor(): handle compound pages
7500a99281dfed2d4a84771c933bcb9e17af279b cifs: revalidate mapping when doing direct writes
00801cd92d91e94aa04d687f9bb9a9104e7c3d46 NFSD: fix regression with setting ACLs.
13bd9014180425f5a35eaf3735971d582c299292 Revert "SUNRPC: Remove unreachable error condition"
d7a5118635e725d195843bda80cc5c964d93ef31 NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
12ef2508f33db1654de2f22f75dd868141b8b305 dt-bindings: interconnect: fsl,imx8m-noc: drop Leonard Crestez
279c12df8d2efb28def9d037f288cbfb97c30fe2 gpio: mpc8xxx: Fix support for IRQ_TYPE_LEVEL_LOW flow_type in mpc85xx
f0880e2cb7e1f8039a048fdd01ce45ab77247221 Drivers: hv: Never allocate anything besides framebuffer from framebuffer memory region
2a8a8afba0c3053d0ea8686182f6b2104293037e Drivers: hv: Always reserve framebuffer region for Gen1 VMs
8409fe92d88c332923130149fe209d1c882b286e PCI: Move PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to pci_ids.h
2258954234db7530e9d86bb32cd6ad54485ff926 tools: hv: kvp: remove unnecessary (void*) conversions
676576d164b34a98589a9efee85f57240c07fef3 Drivers: hv: remove duplicate word in a comment
2a9d683b48c8a87e61a4215792d44c90bcbbb536 NFSv4: Turn off open-by-filehandle and NFS re-export for NFSv4.0
17814819ac9829a437e06fbb5c7056a1f4f893da SUNRPC: Fix call completion races with call_decode()
76648c867c6c03b8a468d9c9222025873ecc613d pinctrl: sunxi: Fix name for A100 R_PIO
40bfe7a86d84cf08ac6a8fe2f0c8bf7a43edd110 of/device: Fix up of_dma_configure_id() stub
b871656aa4f54e04207f62bdd0d7572be1d86b36 pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH
48ec73395887694f13c9452b4dcfb43710451757 pinctrl: qcom: sc8180x: Fix wrong pin numbers
6124cec530c7d8faab96d340ab2df5161e5d1c8a pinctrl: qcom: sc8180x: Fix gpio_wakeirq_map
c6a43fb3487f7e040170e60cdb9b030c669e9cf5 MAINTAINERS: Update email of Neil Armstrong
2f945a792f67815abca26fa8a5e863ccf3fa1181 of: fdt: fix off-by-one error in unflatten_dt_nodes()
f15f39fabed2248311607445ddfa6dba63abebb9 tools: hv: Remove an extraneous "the"
f1f63cbb705dc38826369496c6fc12c1b8db1324 drm/hyperv: Fix an error handling path in hyperv_vmbus_probe() 

Thanks,
Janusz


> Has lockdep somehow got multiple 
> different and unrelated bus notifiers mixed up, maybe?
> 
> FWIW nobody else has reported anything, and that mutex addresses a 
> real-world concurrency issue, so I'm not convinced a revert is 
> appropriate without at least a much clearer justification.
> 
> Robin.
> 
> > thanks
> > Lucas De Marchi
> > 
> >>
> >> kernel log:
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1 Not tainted
> >> ------------------------------------------------------
> >> cpuhp/0/15 is trying to acquire lock:
> >> ffff8881013df278 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
> >> blocking_notifier_call_chain+0x20/0x50
> >>              but task is already holding lock:
> >> ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
> >> cpuhp_thread_fun+0x48/0x1f0
> >>              which lock already depends on the new loc
> >>              the existing dependency chain (in reverse order) is:
> >>              -> #3 (cpuhp_state-up){+.+.}-{0:0}:
> >>       lock_acquire+0xd3/0x310
> >>       cpuhp_thread_fun+0xa6/0x1f0
> >>       smpboot_thread_fn+0x1b5/0x260
> >>       kthread+0xed/0x120
> >>       ret_from_fork+0x1f/0x30
> >>              -> #2 (cpu_hotplug_lock){++++}-{0:0}:
> >>       lock_acquire+0xd3/0x310
> >>       __cpuhp_state_add_instance+0x43/0x1c0
> >>       iova_domain_init_rcaches+0x199/0x1c0
> >>       iommu_setup_dma_ops+0x130/0x440
> >>       bus_iommu_probe+0x26a/0x2d0
> >>       bus_set_iommu+0x82/0xd0
> >>       intel_iommu_init+0xe33/0x1039
> >>       pci_iommu_init+0x9/0x31
> >>       do_one_initcall+0x53/0x2f0
> >>       kernel_init_freeable+0x18f/0x1e1
> >>       kernel_init+0x11/0x120
> >>       ret_from_fork+0x1f/0x30
> >>              -> #1 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
> >>       lock_acquire+0xd3/0x310
> >>       __mutex_lock+0x97/0xf10
> >>       iommu_setup_dma_ops+0xd7/0x440
> >>       iommu_probe_device+0xa4/0x180
> >>       iommu_bus_notifier+0x2d/0x40
> >>       notifier_call_chain+0x31/0x90
> >>       blocking_notifier_call_chain+0x3a/0x50
> >>       device_add+0x3c1/0x900
> >>       pci_device_add+0x255/0x580
> >>       pci_scan_single_device+0xa6/0xd0
> >>       pci_scan_slot+0x7a/0x1b0
> >>       pci_scan_child_bus_extend+0x35/0x2a0
> >>       vmd_probe+0x5cd/0x970
> >>       pci_device_probe+0x95/0x110
> >>       really_probe+0xd6/0x350
> >>       __driver_probe_device+0x73/0x170
> >>       driver_probe_device+0x1a/0x90
> >>       __driver_attach+0xbc/0x190
> >>       bus_for_each_dev+0x72/0xc0
> >>       bus_add_driver+0x1bb/0x210
> >>       driver_register+0x66/0xc0
> >>       do_one_initcall+0x53/0x2f0
> >>       kernel_init_freeable+0x18f/0x1e1
> >>       kernel_init+0x11/0x120
> >>       ret_from_fork+0x1f/0x30
> >>              -> #0 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
> >>       validate_chain+0xb3f/0x2000
> >>       __lock_acquire+0x5a4/0xb70
> >>       lock_acquire+0xd3/0x310
> >>       down_read+0x39/0x140
> >>       blocking_notifier_call_chain+0x20/0x50
> >>       device_add+0x3c1/0x900
> >>       platform_device_add+0x108/0x240
> >>       coretemp_cpu_online+0xe1/0x15e [coretemp]
> >>       cpuhp_invoke_callback+0x181/0x8a0
> >>       cpuhp_thread_fun+0x188/0x1f0
> >>       smpboot_thread_fn+0x1b5/0x260
> >>       kthread+0xed/0x120
> >>       ret_from_fork+0x1f/0x30
> >>              other info that might help us debug thi
> >> Chain exists of                 &(&priv->bus_notifier)->rwsem --> 
> >> cpu_hotplug_lock --> cpuhp_state-
> >> Possible unsafe locking scenari
> >>       CPU0                    CPU1
> >>       ----                    ----
> >>  lock(cpuhp_state-up);
> >>                               lock(cpu_hotplug_lock);
> >>                               lock(cpuhp_state-up);
> >>  lock(&(&priv->bus_notifier)->rwsem);
> >>               *** DEADLOCK *
> >> 2 locks held by cpuhp/0/15:
> >> #0: ffffffff82648f10 (cpu_hotplug_lock){++++}-{0:0}, at: 
> >> cpuhp_thread_fun+0x48/0x1f0
> >> #1: ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
> >> cpuhp_thread_fun+0x48/0x1f0
> >>              stack backtrace:
> >> CPU: 0 PID: 15 Comm: cpuhp/0 Not tainted 
> >> 6.0.0-rc5-CI_DRM_12132-g6c93e979e542+ #1
> >> Hardware name: Intel Corporation Alder Lake Client 
> >> Platform/AlderLake-P DDR4 RVP, BIOS ADLPFWI1.R00.3135.A00.2203251419 
> >> 03/25/2022
> >> Call Trace:
> >> <TASK>
> >> dump_stack_lvl+0x56/0x7f
> >> check_noncircular+0x132/0x150
> >> validate_chain+0xb3f/0x2000
> >> __lock_acquire+0x5a4/0xb70
> >> lock_acquire+0xd3/0x310
> >> ? blocking_notifier_call_chain+0x20/0x50
> >> down_read+0x39/0x140
> >> ? blocking_notifier_call_chain+0x20/0x50
> >> blocking_notifier_call_chain+0x20/0x50
> >> device_add+0x3c1/0x900
> >> ? dev_set_name+0x4e/0x70
> >> platform_device_add+0x108/0x240
> >> coretemp_cpu_online+0xe1/0x15e [coretemp]
> >> ? create_core_data+0x550/0x550 [coretemp]
> >> cpuhp_invoke_callback+0x181/0x8a0
> >> cpuhp_thread_fun+0x188/0x1f0
> >> ? smpboot_thread_fn+0x1e/0x260
> >> smpboot_thread_fn+0x1b5/0x260
> >> ? sort_range+0x20/0x20
> >> kthread+0xed/0x120
> >> ? kthread_complete_and_exit+0x20/0x20
> >> ret_from_fork+0x1f/0x30
> >> </TASK>
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/6641
> >>
> >> Signed-off-by: Karolina Drobnik <karolina.drobnik@intel.com>
> >> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> >> ---
> >> drivers/iommu/dma-iommu.c | 17 ++++-------------
> >> 1 file changed, 4 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index 17dd683b2fce..9616b473e4c7 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -65,7 +65,6 @@ struct iommu_dma_cookie {
> >>
> >>     /* Domain for flush queue callback; NULL if flush queue not in use */
> >>     struct iommu_domain        *fq_domain;
> >> -    struct mutex            mutex;
> >> };
> >>
> >> static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> >> @@ -312,7 +311,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
> >>     if (!domain->iova_cookie)
> >>         return -ENOMEM;
> >>
> >> -    mutex_init(&domain->iova_cookie->mutex);
> >>     return 0;
> >> }
> >>
> >> @@ -563,33 +561,26 @@ static int iommu_dma_init_domain(struct 
> >> iommu_domain *domain, dma_addr_t base,
> >>     }
> >>
> >>     /* start_pfn is always nonzero for an already-initialised domain */
> >> -    mutex_lock(&cookie->mutex);
> >>     if (iovad->start_pfn) {
> >>         if (1UL << order != iovad->granule ||
> >>             base_pfn != iovad->start_pfn) {
> >>             pr_warn("Incompatible range for DMA domain\n");
> >> -            ret = -EFAULT;
> >> -            goto done_unlock;
> >> +            return -EFAULT;
> >>         }
> >>
> >> -        ret = 0;
> >> -        goto done_unlock;
> >> +        return 0;
> >>     }
> >>
> >>     init_iova_domain(iovad, 1UL << order, base_pfn);
> >>     ret = iova_domain_init_rcaches(iovad);
> >>     if (ret)
> >> -        goto done_unlock;
> >> +        return ret;
> >>
> >>     /* If the FQ fails we can simply fall back to strict mode */
> >>     if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> >>         domain->type = IOMMU_DOMAIN_DMA;
> >>
> >> -    ret = iova_reserve_iommu_regions(dev, domain);
> >> -
> >> -done_unlock:
> >> -    mutex_unlock(&cookie->mutex);
> >> -    return ret;
> >> +    return iova_reserve_iommu_regions(dev, domain);
> >> }
> >>
> >> /**
> >>
> 




