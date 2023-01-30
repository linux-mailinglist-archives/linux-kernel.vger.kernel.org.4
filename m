Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2281F6813F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjA3O7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3O7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:59:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6F72D16B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:59:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3081E19F0;
        Mon, 30 Jan 2023 06:59:49 -0800 (PST)
Received: from [10.57.89.162] (unknown [10.57.89.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF2623F882;
        Mon, 30 Jan 2023 06:59:05 -0800 (PST)
Message-ID: <6da0519b-5541-3590-ec3e-43c75f3a73b8@arm.com>
Date:   Mon, 30 Jan 2023 14:59:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/8] iommu: Add lockdep annotations for group list
 iterators
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        jgg@nvidia.com
References: <cover.1674753627.git.robin.murphy@arm.com>
 <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
 <66867d21-3412-9050-5e8d-2071c6896f54@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <66867d21-3412-9050-5e8d-2071c6896f54@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-28 12:20, Baolu Lu wrote:
> On 2023/1/27 2:26, Robin Murphy wrote:
>> Before we add any more common helpers for iterating or otherwise
>> accessing the group device list, let's start the good habit of
>> annotating their locking expectations for robustness.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v2: New. Note that I've left the group_pasid helpers, since they're
>>      pretty much right next to where the relevant locking happens, and
>>      highly unlikely to be reused from anywhere else anyway.
>>
>>   drivers/iommu/iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d48e5499e0fa..77f076030995 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/iommu.h>
>>   #include <linux/idr.h>
>>   #include <linux/err.h>
>> +#include <linux/lockdep.h>
>>   #include <linux/pci.h>
>>   #include <linux/pci-ats.h>
>>   #include <linux/bitops.h>
>> @@ -1100,6 +1101,7 @@ static int iommu_group_device_count(struct 
>> iommu_group *group)
>>       struct group_device *entry;
>>       int ret = 0;
>> +    lockdep_assert_held(&group->mutex);
>>       list_for_each_entry(entry, &group->devices, list)
>>           ret++;
>> @@ -1112,6 +1114,7 @@ static int __iommu_group_for_each_dev(struct 
>> iommu_group *group, void *data,
>>       struct group_device *device;
>>       int ret = 0;
>> +    lockdep_assert_held(&group->mutex);
> 
> When I tested this patch on an Intel platform, I found that the
> bus_iommu_probe() path iterates the group device list but does not hold
> the lock.

Urgh, that's what I get for being in a hurry and not boot-testing it 
myself :(

> 1831 static void __iommu_group_dma_finalize(struct iommu_group *group)
> 1832 {
> 1833         __iommu_group_for_each_dev(group, group->default_domain,
> 1834                                    iommu_group_do_probe_finalize);
> 1835 }
> 
> bus_iommu_probe:
> 
> 1873                 /* Try to allocate default domain */
> 1874                 probe_alloc_default_domain(group);
> 1875
> 1876                 if (!group->default_domain) {
> 1877                         mutex_unlock(&group->mutex);
> 1878                         continue;
> 1879                 }
> 1880
> 1881                 iommu_group_create_direct_mappings(group);
> 1882
> 1883                 ret = __iommu_group_dma_first_attach(group);
> 1884
> 1885                 mutex_unlock(&group->mutex);
> 1886
> 1887                 if (ret)
> 1888                         break;
> 1889
> 1890                 __iommu_group_dma_finalize(group);

...and of course it's the one case where the reason for not holding the 
lock is a bit dodgy, but most definitely intentional. I can see ways to 
hack around it further, but frankly I think the most practical solution 
would be to just drop this patch for now until I've sorted out the ARM 
stuff.

Thanks,
Robin.

> The lockdep_assert_held() caused below kernel trace:
> 
> [   70.022590] ------------[ cut here ]------------
> [   70.027967] WARNING: CPU: 1 PID: 1 at drivers/iommu/iommu.c:1135 
> __iommu_group_for_each_dev+0x72/0x80
> [   70.038672] Modules linked in:
> [   70.042264] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W 
>   6.2.0-rc5+ #421
> [   70.063860] RIP: 0010:__iommu_group_for_each_dev+0x72/0x80
> [   70.070267] Code: 5c 41 5d c3 cc cc cc cc 5b 31 c0 5d 41 5c 41 5d c3 
> cc cc cc cc 48 8d bf 10 01 00 00 be ff ff ff ff e8 92 7b 8f 00 85 c0 75 
> ac <0f> 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> [   70.091981] RSP: 0000:ffffad104006fd30 EFLAGS: 00010246
> [   70.098058] RAX: 0000000000000000 RBX: ffff9f490bb95600 RCX: 
> 0000000000000001
> [   70.106378] RDX: 0000000000000001 RSI: ffff9f490bb95710 RDI: 
> ffff9f4900b10d88
> [   70.114674] RBP: ffff9f490bb95600 R08: ffffcd26844fde80 R09: 
> ffffcd26844fde40
> [   70.122970] R10: 0000000000000000 R11: 0000000000000000 R12: 
> ffff9f490bb95ed0
> [   70.131265] R13: ffffffff8aadd520 R14: ffffffff8aade3a0 R15: 
> 0000000000000000
> [   70.139561] FS:  0000000000000000(0000) GS:ffff9f583ff00000(0000) 
> knlGS:0000000000000000
> [   70.148969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   70.155667] CR2: 0000000000000000 CR3: 0000000cc2012001 CR4: 
> 0000000000370ee0
> [   70.163963] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   70.172282] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 
> 0000000000000400
> [   70.180559] Call Trace:
> [   70.183469]  <TASK>
> [   70.185972]  bus_iommu_probe+0xee/0x1e0
> [   70.190496]  iommu_device_register+0xaf/0x100
> [   70.195580]  intel_iommu_init+0x3e9/0x6f2
> [   70.200271]  ? __pfx_pci_iommu_init+0x10/0x10
> [   70.205381]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
> [   70.211564]  pci_iommu_init+0x12/0x3a
> [   70.215870]  do_one_initcall+0x65/0x330
> [   70.220376]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
> [   70.226577]  ? rcu_read_lock_sched_held+0x5a/0x80
> [   70.232076]  kernel_init_freeable+0x287/0x2f0
> [   70.237914]  ? __pfx_kernel_init+0x10/0x10
> [   70.241979]  kernel_init+0x1a/0x130
> [   70.246075]  ret_from_fork+0x29/0x50
> [   70.251014]  </TASK>
> [   70.252867] irq event stamp: 16350051
> [   70.257167] hardirqs last  enabled at (16350061): 
> [<ffffffff8a1c3ed2>] __up_console_sem+0x52/0x60
> [   70.267468] hardirqs last disabled at (16350070): 
> [<ffffffff8a1c3eb7>] __up_console_sem+0x37/0x60
> [   70.277768] softirqs last  enabled at (16350006): 
> [<ffffffff8b3edd03>] __do_softirq+0x283/0x451
> [   70.287859] softirqs last disabled at (16350001): 
> [<ffffffff8a132c6a>] irq_exit_rcu+0xaa/0xc0
> [   70.297777] ---[ end trace 0000000000000000 ]---
> 
>>       list_for_each_entry(device, &group->devices, list) {
>>           ret = fn(device->dev, data);
>>           if (ret)
> 
> Best regards,
> baolu
