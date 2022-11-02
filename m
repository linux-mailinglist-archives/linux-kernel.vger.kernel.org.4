Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A70616298
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiKBMUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:20:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535323BE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667391646; x=1698927646;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SLZ2iSsXMcu2nemCpm4wg2YGE2ZvCmm+bfrQdo5YmmI=;
  b=MoAp8lk1OJojuiXYo9dNeIlnxT6e3YG3crxzziobKSQFfFONZDAwe3/R
   EkCpjAPLdPchad/hElTrdyI1WjlKYhsF8MsEhJQPv0QZI6H9VafVY6gP+
   So7R75Msk1uYuQO2lrt9mr+bqcBkKgjr7ZprYPXLsSs3oes4anQI+SIcC
   9oKXc7MRiAh66k76ZzG9jg6bTu8HAuKSuz8BV/ySfOH3X2ZngOyVH/lVQ
   S42F7+jlwiG5POgkjaihE66kX45Ug3FA0V/3c3EbiyevEMZvSPsMDr7/S
   ZUj2gqPFh2Z4ZG0LZko22eQfkU076PmVKIBEThrdKati9O6asb2l1+278
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310497914"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310497914"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:20:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585377901"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="585377901"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.165]) ([10.254.215.165])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:20:43 -0700
Message-ID: <c5dd30ca-f760-aef8-8c29-400f08cf0edd@linux.intel.com>
Date:   Wed, 2 Nov 2022 20:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Cc:     baolu.lu@linux.intel.com, intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [core-for-CI][PATCH] iommu: Remove iova cpu hotplugging flushing
Content-Language: en-US
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
References: <20220922101036.87457-1-janusz.krzysztofik@linux.intel.com>
 <f38685a7-8411-60e2-71e1-277d0dafac22@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f38685a7-8411-60e2-71e1-277d0dafac22@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/2 19:17, Baolu Lu wrote:
> On 2022/9/22 18:10, Janusz Krzysztofik wrote:
>> From: Chris Wilson<chris@chris-wilson.co.uk>
>>
>> Manual revert of commit f598a497bc7d ("iova: Add CPU hotplug handler to
>> flush rcaches").  It is trying to instantiate a cpuhp notifier from 
>> inside
>> a cpuhp callback.  That code replaced intel_iommu implementation of
>> flushing per-IOVA domain CPU rcaches which used a single instance of 
>> cpuhp
>> held for the module lifetime.
>>
>> <4>[    6.928112] ======================================================
>> <4>[    6.928621] WARNING: possible circular locking dependency detected
>> <4>[    6.929225] 6.0.0-rc6-CI_DRM_12164-ga1f63e144e54+ #1 Not tainted
>> <4>[    6.929818] ------------------------------------------------------
>> <4>[    6.930415] cpuhp/0/15 is trying to acquire lock:
>> <4>[    6.931011] ffff888100e02a78 
>> (&(&priv->bus_notifier)->rwsem){++++}-{3:3}, at: 
>> blocking_notifier_call_chain+0x20/0x50
>> <4>[    6.931533]
>>                    but task is already holding lock:
>> <4>[    6.931534] ffffffff826490c0 (cpuhp_state-up){+.+.}-{0:0}, at: 
>> cpuhp_thread_fun+0x48/0x1f0
>> <4>[    6.933069]
>>                    which lock already depends on the new lock.
> 
> Just FYI.
> 
> Hot plugging a PCI device will trigger a similar lockdep warning.
> 
> #echo 1 > /sys/bus/pci/devices/.../remove
> 
> With this patch applied, the warning disappeared.

The following kernel trace is generated by my experimental code. Please
ignore it. Sorry for the inconvenience.

> [ 2599.612285] BUG: kernel NULL pointer dereference, address: 
> 0000000000000064
> [ 2599.622454] #PF: supervisor read access in kernel mode
> [ 2599.630460] #PF: error_code(0x0000) - not-present page
> [ 2599.638473] PGD 109f7d067 P4D 0
> [ 2599.644274] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ 2599.651385] CPU: 0 PID: 828 Comm: bash Tainted: G          I 
> 6.1.0-rc2+ #367
> [ 2599.677439] RIP: 0010:do_raw_spin_lock+0xa/0xc0
> [ 2599.684796] Code: 8d 88 80 0b 00 00 48 c7 c7 d8 39 cd 91 e8 c7 c2 06 
> 01 e9 e8 32 0e 01 66 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 
> 53 <8b> 47 04 48 89 fb 3d ad 4e ad de 75 4a 48 8b 53 10 65 48 8b 04 25
> [ 2599.711073] RSP: 0018:ff5efa9101b27ca8 EFLAGS: 00010092
> [ 2599.719254] RAX: 0000000000000000 RBX: 0000000000000206 RCX: 
> 0000000000000000
> [ 2599.729869] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
> 0000000000000060
> [ 2599.740427] RBP: 0000000000000060 R08: 0000000000000001 R09: 
> 0000000000000000
> [ 2599.750985] R10: 0000000000000000 R11: ffffffff95b0be60 R12: 
> ff24417986fce000
> [ 2599.761500] R13: ffffffff959f9bf0 R14: ff244179872d5058 R15: 
> 0000000000000003
> [ 2599.772114] FS:  00007f04aa2b1740(0000) GS:ff244180dfc00000(0000) 
> knlGS:0000000000000000
> [ 2599.783841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2599.792747] CR2: 0000000000000064 CR3: 000000010a6a2004 CR4: 
> 0000000000771ef0
> [ 2599.803372] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [ 2599.813976] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
> 0000000000000400
> [ 2599.824572] PKRU: 55555554
> [ 2599.829655] Call Trace:
> [ 2599.834444]  <TASK>
> [ 2599.838833]  _raw_spin_lock_irqsave+0x41/0x60
> [ 2599.846048]  ? domain_update_iotlb+0x16/0x60
> [ 2599.853147]  domain_update_iotlb+0x16/0x60
> [ 2599.859946]  intel_iommu_release_device+0xc5/0xd0
> [ 2599.867549]  iommu_release_device+0x49/0x80
> [ 2599.874444]  iommu_bus_notifier+0x24/0x50
> [ 2599.881139]  notifier_call_chain+0x3a/0xa0
> [ 2599.887936]  blocking_notifier_call_chain+0x43/0x60
> [ 2599.895736]  device_del+0x2b4/0x420
> [ 2599.901829]  pci_remove_bus_device+0x70/0x110
> [ 2599.909034]  pci_stop_and_remove_bus_device_locked+0x22/0x30
> [ 2599.917852]  remove_store+0x7d/0x90
> [ 2599.923949]  kernfs_fop_write_iter+0x12a/0x1d0
> [ 2599.931253]  vfs_write+0x313/0x4b0
> [ 2599.937247]  ksys_write+0x60/0xe0
> [ 2599.943095]  do_syscall_64+0x43/0x90
> [ 2599.949245]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 2599.957135] RIP: 0033:0x7f04a9d18a98
> [ 2599.963213] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 
> 00 f3 0f 1e fa 48 8d 05 05 26 0f 00 8b 00 85 c0 75 1f b8 01 00 00 00 0f 
> 05 <0f> 1f 84 00 00 00 00 00 48 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00
> [ 2599.989405] RSP: 002b:00007ffc28cce9e8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000001
> [ 2600.000537] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
> 00007f04a9d18a98
> [ 2600.011155] RDX: 0000000000000002 RSI: 000055d272355f60 RDI: 
> 0000000000000001
> [ 2600.021748] RBP: 000055d272355f60 R08: 000000000000000a R09: 
> 0000000000000001
> [ 2600.032334] R10: 000000000000000a R11: 0000000000000246 R12: 
> 00007f04a9e06520
> [ 2600.042923] R13: 0000000000000002 R14: 00007f04a9e07260 R15: 
> 00007f04a9e06720
> [ 2600.053527]  </TASK>
> [ 2600.057993] Modules linked in: fuse x86_pkg_temp_thermal 
> intel_powerclamp coretemp kvm_intel kvm irqbypass isst_if_mmio 
> isst_if_common joydev intel_vsec idxd cxl_acpi cxl_core sunrpc 
> crc32c_intel ixgbe mdio dca bochs drm_vram_helper drm_ttm_helper
> [ 2600.088403] CR2: 0000000000000064
> [ 2600.094376] ---[ end trace 0000000000000000 ]---
> [ 2600.238419] RIP: 0010:do_raw_spin_lock+0xa/0xc0
> [ 2600.245811] Code: 8d 88 80 0b 00 00 48 c7 c7 d8 39 cd 91 e8 c7 c2 06 
> 01 e9 e8 32 0e 01 66 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f 44 00 00 
> 53 <8b> 47 04 48 89 fb 3d ad 4e ad de 75 4a 48 8b 53 10 65 48 8b 04 25
> [ 2600.272091] RSP: 0018:ff5efa9101b27ca8 EFLAGS: 00010092
> [ 2600.280345] RAX: 0000000000000000 RBX: 0000000000000206 RCX: 
> 0000000000000000
> [ 2600.290980] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
> 0000000000000060
> [ 2600.301580] RBP: 0000000000000060 R08: 0000000000000001 R09: 
> 0000000000000000
> [ 2600.312167] R10: 0000000000000000 R11: ffffffff95b0be60 R12: 
> ff24417986fce000
> [ 2600.322762] R13: ffffffff959f9bf0 R14: ff244179872d5058 R15: 
> 0000000000000003
> [ 2600.333354] FS:  00007f04aa2b1740(0000) GS:ff244180dfc00000(0000) 
> knlGS:0000000000000000
> [ 2600.345062] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2600.353949] CR2: 0000000000000064 CR3: 000000010a6a2004 CR4: 
> 0000000000771ef0
> [ 2600.364571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [ 2600.375178] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
> 0000000000000400
> [ 2600.385756] PKRU: 55555554
> [ 2600.390848] note: bash[828] exited with preempt_count 1

Best regards,
baolu
