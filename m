Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33972616196
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKBLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:17:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADD2736
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667387867; x=1698923867;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7L5jtXqroh+dSe/5mpLCVCJI2n630bi0o3depG/Lmp4=;
  b=ec7gr9kezwQrpWn8jlPQ/E27zRff5ff0C6S2SsXj54e27tgRrZsgz6XL
   RXB85UM2bBTt57Zln55aGiZDr4STBlST1If6ZiwSxsHbpYgd+Kq417lnV
   zl/x51IaIQ3EU9MEXiavqFvrmFVZaKudLShwVoFeSR4/cJf1y96r0/Y32
   7/2Q/p9zig0tUa6VYztc4hCDMCcFVqZMf1Dqj0YgACQ5v9ixPa6ISA9Hn
   5FxV3yjqIp0gkYWTKs2TuIPXmplnaAO80k6YqkSBjwdlfWc6rTU9dJsvD
   c04kBgb5pDS3BxJm6QT/bIOQrxXKa/EzCnyrPDJ6EGK1g1uDYQ29b9zEn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296824251"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="296824251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:17:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="612206821"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="612206821"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.165]) ([10.254.215.165])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:17:44 -0700
Message-ID: <f38685a7-8411-60e2-71e1-277d0dafac22@linux.intel.com>
Date:   Wed, 2 Nov 2022 19:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     baolu.lu@linux.intel.com, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [core-for-CI][PATCH] iommu: Remove iova cpu hotplugging flushing
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
References: <20220922101036.87457-1-janusz.krzysztofik@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220922101036.87457-1-janusz.krzysztofik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 18:10, Janusz Krzysztofik wrote:
> From: Chris Wilson<chris@chris-wilson.co.uk>
> 
> Manual revert of commit f598a497bc7d ("iova: Add CPU hotplug handler to
> flush rcaches").  It is trying to instantiate a cpuhp notifier from inside
> a cpuhp callback.  That code replaced intel_iommu implementation of
> flushing per-IOVA domain CPU rcaches which used a single instance of cpuhp
> held for the module lifetime.
> 
> <4>[    6.928112] ======================================================
> <4>[    6.928621] WARNING: possible circular locking dependency detected
> <4>[    6.929225] 6.0.0-rc6-CI_DRM_12164-ga1f63e144e54+ #1 Not tainted
> <4>[    6.929818] ------------------------------------------------------
> <4>[    6.930415] cpuhp/0/15 is trying to acquire lock:
> <4>[    6.931011] ffff888100e02a78 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: blocking_notifier_call_chain+0x20/0x50
> <4>[    6.931533]
>                    but task is already holding lock:
> <4>[    6.931534] ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x48/0x1f0
> <4>[    6.933069]
>                    which lock already depends on the new lock.

Just FYI.

Hot plugging a PCI device will trigger a similar lockdep warning.

#echo 1 > /sys/bus/pci/devices/.../remove

With this patch applied, the warning disappeared.

[ 2598.661070]
[ 2598.663338] ======================================================
[ 2598.671360] WARNING: possible circular locking dependency detected
[ 2598.679361] 6.1.0-rc2+ #367 Tainted: G          I
[ 2598.686254] ------------------------------------------------------
[ 2598.694260] bash/828 is trying to acquire lock:
[ 2598.700249] ffffffff95a1e7f0 (dmar_global_lock){++++}-{3:3}, at: 
dmar_pci_bus_notifier+0x55/0x110
[ 2598.711680]
[ 2598.711680] but task is already holding lock:
[ 2598.719258] ff24417981dfee78 
(&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
blocking_notifier_call_chain+0x29/0x60
[ 2598.732692]
[ 2598.732692] which lock already depends on the new lock.
[ 2598.732692]
[ 2598.743174]
[ 2598.743174] the existing dependency chain (in reverse order) is:
[ 2598.752770]
[ 2598.752770] -> #4 (&(&priv->bus_notifier)->rwsem){++++}-{3:3}:
[ 2598.762268]        lock_acquire+0xc2/0x2e0
[ 2598.767645]        down_read+0x42/0x150
[ 2598.772743]        blocking_notifier_call_chain+0x29/0x60
[ 2598.779755]        device_add+0x403/0x980
[ 2598.785045]        platform_device_add+0x11c/0x240
[ 2598.791350]        coretemp_cpu_online+0xe5/0x180 [coretemp]
[ 2598.798757]        cpuhp_invoke_callback+0x179/0x8d0
[ 2598.805252]        cpuhp_thread_fun+0x19d/0x210
[ 2598.811249]        smpboot_thread_fn+0x11d/0x240
[ 2598.817349]        kthread+0xeb/0x120
[ 2598.822242]        ret_from_fork+0x1f/0x30
[ 2598.827645]
[ 2598.827645] -> #3 (cpuhp_state-up){+.+.}-{0:0}:
[ 2598.835559]        lock_acquire+0xc2/0x2e0
[ 2598.840945]        cpuhp_thread_fun+0xb3/0x210
[ 2598.846848]        smpboot_thread_fn+0x11d/0x240
[ 2598.852949]        kthread+0xeb/0x120
[ 2598.857842]        ret_from_fork+0x1f/0x30
[ 2598.864477]
[ 2598.864477] -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[ 2598.875039]        lock_acquire+0xc2/0x2e0
[ 2598.881692]        __cpuhp_state_add_instance+0x4c/0x1b0
[ 2598.889881]        iova_domain_init_rcaches+0x179/0x1a0
[ 2598.897840]        iommu_setup_dma_ops+0x135/0x440
[ 2598.905329]        bus_iommu_probe+0x276/0x2e0
[ 2598.912412]        iommu_device_register+0xd4/0x130
[ 2598.920029]        intel_iommu_init+0x3e1/0x6ea
[ 2598.927216]        pci_iommu_init+0x12/0x3a
[ 2598.933898]        do_one_initcall+0x65/0x320
[ 2598.940877]        kernel_init_freeable+0x293/0x2fc
[ 2598.948363]        kernel_init+0x1a/0x130
[ 2598.954749]        ret_from_fork+0x1f/0x30
[ 2598.961237]
[ 2598.961237] -> #1 (&domain->iova_cookie->mutex){+.+.}-{3:3}:
[ 2598.972616]        lock_acquire+0xc2/0x2e0
[ 2598.979115]        __mutex_lock+0x99/0xf40
[ 2598.985598]        iommu_setup_dma_ops+0xde/0x440
[ 2598.992878]        bus_iommu_probe+0x276/0x2e0
[ 2598.999750]        iommu_device_register+0xd4/0x130
[ 2599.007154]        intel_iommu_init+0x3e1/0x6ea
[ 2599.014120]        pci_iommu_init+0x12/0x3a
[ 2599.020583]        do_one_initcall+0x65/0x320
[ 2599.027278]        kernel_init_freeable+0x293/0x2fc
[ 2599.034576]        kernel_init+0x1a/0x130
[ 2599.040780]        ret_from_fork+0x1f/0x30
[ 2599.047070]
[ 2599.047070] -> #0 (dmar_global_lock){++++}-{3:3}:
[ 2599.056971]        check_prevs_add+0x160/0xee0
[ 2599.063745]        __lock_acquire+0x116a/0x15f0
[ 2599.070647]        lock_acquire+0xc2/0x2e0
[ 2599.076939]        down_write+0x3f/0xd0
[ 2599.082931]        dmar_pci_bus_notifier+0x55/0x110
[ 2599.090239]        notifier_call_chain+0x3a/0xa0
[ 2599.097234]        blocking_notifier_call_chain+0x43/0x60
[ 2599.105138]        device_del+0x2b4/0x420
[ 2599.111333]        pci_remove_bus_device+0x70/0x110
[ 2599.118640]        pci_stop_and_remove_bus_device_locked+0x22/0x30
[ 2599.127557]        remove_store+0x7d/0x90
[ 2599.133752]        kernfs_fop_write_iter+0x12a/0x1d0
[ 2599.141165]        vfs_write+0x313/0x4b0
[ 2599.147259]        ksys_write+0x60/0xe0
[ 2599.153250]        do_syscall_64+0x43/0x90
[ 2599.159550]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 2599.167665]
[ 2599.167665] other info that might help us debug this:
[ 2599.167665]
[ 2599.180634] Chain exists of:
[ 2599.180634]   dmar_global_lock --> cpuhp_state-up --> 
&(&priv->bus_notifier)->rwsem
[ 2599.180634]
[ 2599.198702]  Possible unsafe locking scenario:
[ 2599.198702]
[ 2599.208346]        CPU0                    CPU1
[ 2599.215281]        ----                    ----
[ 2599.222170]   lock(&(&priv->bus_notifier)->rwsem);
[ 2599.229474]                                lock(cpuhp_state-up);
[ 2599.238293] 
lock(&(&priv->bus_notifier)->rwsem);
[ 2599.248705]   lock(dmar_global_lock);
[ 2599.254593]
[ 2599.254593]  *** DEADLOCK ***
[ 2599.254593]
[ 2599.265197] 4 locks held by bash/828:
[ 2599.271076]  #0: ff2441798fc8f448 (sb_writers#4){.+.+}-{0:0}, at: 
ksys_write+0x60/0xe0
[ 2599.282218]  #1: ff24417992068288 (&of->mutex){+.+.}-{3:3}, at: 
kernfs_fop_write_iter+0xf7/0x1d0
[ 2599.294449]  #2: ffffffff959f6b28 
(pci_rescan_remove_lock){+.+.}-{3:3}, at: 
pci_stop_and_remove_bus_device_locked+0x12/0x30
[ 2599.309600]  #3: ff24417981dfee78 
(&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
blocking_notifier_call_chain+0x29/0x60
[ 2599.324534]
[ 2599.324534] stack backtrace:
[ 2599.332486] CPU: 0 PID: 828 Comm: bash Tainted: G          I 
6.1.0-rc2+ #367
[ 2599.343448] Hardware name: Intel Corporation BIRCHSTREAM/BIRCHSTREAM, 
BIOS BHSDREL1.86B.0014.D60.2205121929 05/12/2022
[ 2599.358107] Call Trace:
[ 2599.362685]  <TASK>
[ 2599.366778]  dump_stack_lvl+0x48/0x5f
[ 2599.372790]  check_noncircular+0x102/0x120
[ 2599.379400]  ? check_prevs_add+0x176/0xee0
[ 2599.385994]  check_prevs_add+0x160/0xee0
[ 2599.392392]  __lock_acquire+0x116a/0x15f0
[ 2599.398892]  lock_acquire+0xc2/0x2e0
[ 2599.404882]  ? dmar_pci_bus_notifier+0x55/0x110
[ 2599.411996]  ? lock_is_held_type+0x9d/0x110
[ 2599.418697]  down_write+0x3f/0xd0
[ 2599.424385]  ? dmar_pci_bus_notifier+0x55/0x110
[ 2599.431593]  dmar_pci_bus_notifier+0x55/0x110
[ 2599.438590]  notifier_call_chain+0x3a/0xa0
[ 2599.445189]  blocking_notifier_call_chain+0x43/0x60
[ 2599.452791]  device_del+0x2b4/0x420
[ 2599.458680]  pci_remove_bus_device+0x70/0x110
[ 2599.465583]  pci_stop_and_remove_bus_device_locked+0x22/0x30
[ 2599.474096]  remove_store+0x7d/0x90
[ 2599.479995]  kernfs_fop_write_iter+0x12a/0x1d0
[ 2599.487107]  vfs_write+0x313/0x4b0
[ 2599.492902]  ksys_write+0x60/0xe0
[ 2599.498587]  do_syscall_64+0x43/0x90
[ 2599.504581]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 2599.512292] RIP: 0033:0x7f04a9d18a98
[ 2599.518292] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 
00 f3 0f 1e fa 48 8d 05 05 26 0f 00 8b 00 85 c0 75 1f b8 01 00 00 00 0f 
05 <0f> 1f 84 00 00 00 00 00 48 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00
[ 2599.544235] RSP: 002b:00007ffc28cce9e8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[ 2599.555199] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f04a9d18a98
[ 2599.565713] RDX: 0000000000000002 RSI: 000055d272355f60 RDI: 
0000000000000001
[ 2599.576232] RBP: 000055d272355f60 R08: 000000000000000a R09: 
0000000000000001
[ 2599.586744] R10: 000000000000000a R11: 0000000000000246 R12: 
00007f04a9e06520
[ 2599.597247] R13: 0000000000000002 R14: 00007f04a9e07260 R15: 
00007f04a9e06720
[ 2599.607746]  </TASK>
[ 2599.612285] BUG: kernel NULL pointer dereference, address: 
0000000000000064
[ 2599.622454] #PF: supervisor read access in kernel mode
[ 2599.630460] #PF: error_code(0x0000) - not-present page
[ 2599.638473] PGD 109f7d067 P4D 0
[ 2599.644274] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 2599.651385] CPU: 0 PID: 828 Comm: bash Tainted: G          I 
6.1.0-rc2+ #367
[ 2599.662501] Hardware name: Intel Corporation BIRCHSTREAM/BIRCHSTREAM, 
BIOS BHSDREL1.86B.0014.D60.2205121929 05/12/2022
[ 2599.677439] RIP: 0010:do_raw_spin_lock+0xa/0xc0
[ 2599.684796] Code: 8d 88 80 0b 00 00 48 c7 c7 d8 39 cd 91 e8 c7 c2 06 
01 e9 e8 32 0e 01 66 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 
53 <8b> 47 04 48 89 fb 3d ad 4e ad de 75 4a 48 8b 53 10 65 48 8b 04 25
[ 2599.711073] RSP: 0018:ff5efa9101b27ca8 EFLAGS: 00010092
[ 2599.719254] RAX: 0000000000000000 RBX: 0000000000000206 RCX: 
0000000000000000
[ 2599.729869] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000060
[ 2599.740427] RBP: 0000000000000060 R08: 0000000000000001 R09: 
0000000000000000
[ 2599.750985] R10: 0000000000000000 R11: ffffffff95b0be60 R12: 
ff24417986fce000
[ 2599.761500] R13: ffffffff959f9bf0 R14: ff244179872d5058 R15: 
0000000000000003
[ 2599.772114] FS:  00007f04aa2b1740(0000) GS:ff244180dfc00000(0000) 
knlGS:0000000000000000
[ 2599.783841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2599.792747] CR2: 0000000000000064 CR3: 000000010a6a2004 CR4: 
0000000000771ef0
[ 2599.803372] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 2599.813976] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[ 2599.824572] PKRU: 55555554
[ 2599.829655] Call Trace:
[ 2599.834444]  <TASK>
[ 2599.838833]  _raw_spin_lock_irqsave+0x41/0x60
[ 2599.846048]  ? domain_update_iotlb+0x16/0x60
[ 2599.853147]  domain_update_iotlb+0x16/0x60
[ 2599.859946]  intel_iommu_release_device+0xc5/0xd0
[ 2599.867549]  iommu_release_device+0x49/0x80
[ 2599.874444]  iommu_bus_notifier+0x24/0x50
[ 2599.881139]  notifier_call_chain+0x3a/0xa0
[ 2599.887936]  blocking_notifier_call_chain+0x43/0x60
[ 2599.895736]  device_del+0x2b4/0x420
[ 2599.901829]  pci_remove_bus_device+0x70/0x110
[ 2599.909034]  pci_stop_and_remove_bus_device_locked+0x22/0x30
[ 2599.917852]  remove_store+0x7d/0x90
[ 2599.923949]  kernfs_fop_write_iter+0x12a/0x1d0
[ 2599.931253]  vfs_write+0x313/0x4b0
[ 2599.937247]  ksys_write+0x60/0xe0
[ 2599.943095]  do_syscall_64+0x43/0x90
[ 2599.949245]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 2599.957135] RIP: 0033:0x7f04a9d18a98
[ 2599.963213] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 
00 f3 0f 1e fa 48 8d 05 05 26 0f 00 8b 00 85 c0 75 1f b8 01 00 00 00 0f 
05 <0f> 1f 84 00 00 00 00 00 48 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00
[ 2599.989405] RSP: 002b:00007ffc28cce9e8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[ 2600.000537] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f04a9d18a98
[ 2600.011155] RDX: 0000000000000002 RSI: 000055d272355f60 RDI: 
0000000000000001
[ 2600.021748] RBP: 000055d272355f60 R08: 000000000000000a R09: 
0000000000000001
[ 2600.032334] R10: 000000000000000a R11: 0000000000000246 R12: 
00007f04a9e06520
[ 2600.042923] R13: 0000000000000002 R14: 00007f04a9e07260 R15: 
00007f04a9e06720
[ 2600.053527]  </TASK>
[ 2600.057993] Modules linked in: fuse x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel kvm irqbypass isst_if_mmio 
isst_if_common joydev intel_vsec idxd cxl_acpi cxl_core sunrpc 
crc32c_intel ixgbe mdio dca bochs drm_vram_helper drm_ttm_helper
[ 2600.088403] CR2: 0000000000000064
[ 2600.094376] ---[ end trace 0000000000000000 ]---
[ 2600.238419] RIP: 0010:do_raw_spin_lock+0xa/0xc0
[ 2600.245811] Code: 8d 88 80 0b 00 00 48 c7 c7 d8 39 cd 91 e8 c7 c2 06 
01 e9 e8 32 0e 01 66 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 
53 <8b> 47 04 48 89 fb 3d ad 4e ad de 75 4a 48 8b 53 10 65 48 8b 04 25
[ 2600.272091] RSP: 0018:ff5efa9101b27ca8 EFLAGS: 00010092
[ 2600.280345] RAX: 0000000000000000 RBX: 0000000000000206 RCX: 
0000000000000000
[ 2600.290980] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000060
[ 2600.301580] RBP: 0000000000000060 R08: 0000000000000001 R09: 
0000000000000000
[ 2600.312167] R10: 0000000000000000 R11: ffffffff95b0be60 R12: 
ff24417986fce000
[ 2600.322762] R13: ffffffff959f9bf0 R14: ff244179872d5058 R15: 
0000000000000003
[ 2600.333354] FS:  00007f04aa2b1740(0000) GS:ff244180dfc00000(0000) 
knlGS:0000000000000000
[ 2600.345062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2600.353949] CR2: 0000000000000064 CR3: 000000010a6a2004 CR4: 
0000000000771ef0
[ 2600.364571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 2600.375178] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
0000000000000400
[ 2600.385756] PKRU: 55555554
[ 2600.390848] note: bash[828] exited with preempt_count 1

Best regards,
baolu
