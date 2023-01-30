Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D668137B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbjA3OiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjA3OiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:38:07 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B6383F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:38:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VaT7RNZ_1675089477;
Received: from 30.121.12.33(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VaT7RNZ_1675089477)
          by smtp.aliyun-inc.com;
          Mon, 30 Jan 2023 22:37:58 +0800
Message-ID: <f3921d86-d562-2167-680b-07604be7f46f@linux.alibaba.com>
Date:   Mon, 30 Jan 2023 22:37:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC] swiotlb: Add a new cc-swiotlb implementation for
 Confidential VMs
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        linux-coco@lists.linux.dev, hch@lst.de
References: <20230128083254.86012-1-GuoRui.Yu@linux.alibaba.com>
 <0ee204fa-091d-43d9-9c2c-0c64cf0c1fdd@arm.com>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <0ee204fa-091d-43d9-9c2c-0c64cf0c1fdd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

在 2023/1/30 21:03, Robin Murphy 写道:
> On 2023-01-28 08:32, GuoRui.Yu wrote:
>> This patch series adds a new swiotlb implementation, cc-swiotlb, for
>> Confidential VMs (such as TDX and SEV-SNP). The new cc-swiotlb allocates
>> the DMA TLB buffer dynamically in runtime instead of allocating at boot
>> with a fixed size. Furthermore, future optimization and security
>> enhancement could be applied on cc-swiotlb without "infecting" the
>> legacy swiotlb.
>>
>> Background
>> ==========
>> Under COnfidential COmputing (CoCo) scenarios, the VMM cannot access
>> guest memory directly but requires the guest to explicitly mark the
>> memory as shared (decrypted). To make the streaming DMA mappings work,
>> the current implementation relays on legacy SWIOTLB to bounce the DMA
>> buffer between private (encrypted) and shared (decrypted) memory.
>>
>> However, the legacy swiotlb is designed for compatibility rather than
>> efficiency and CoCo purpose, which will inevitably introduce some
>> unnecessary restrictions.
>>
>> 1. Fixed immutable swiotlb size cannot accommodate to requirements of
>> multiple devices. And 1GiB (current maximum size) of swiotlb in our
>> testbed cannot afford multiple disks reads/writes simultaneously.
> 
> That's not a very logical argument - if a particular use-case needs a 
> particular total amount of SWIOTLB capacity, then that's how much it 
> needs. Whether that capacity is allocated up-front or allocated 
> gradually over time doesn't affect that. The obvious solution to this 
> issue as presented is "make the maximum size bigger", not "add a whole 
> other SWIOTLB implementation".
> 

The reason is all about the hotplugged devices.

In public cloud scenarios, customers often need to hotplug disks. The 
number of disks can be up to about 50 disks, and the maximum IOPS of 
each disk may reach 1 million IOPS. It may be difficult for the user to 
estimate the SWIOTLB size he needs to use when the system starts. And 
the same story also applies to the NIC devices.

>> 2. Fixed immutable IO_TLB_SIZE (2KiB) cannot satisfy various kinds of
>> devices. At the moment, the minimal size of a swiotlb buffer is 2KiB,
>> which will waste memory on small network packets (under 256 bytes) and
>> decrease efficiency on a large block (up to 256KiB) size reads/writes of
>> disks. And it is hard to have a trade-off on legacy swiotlb to rule them
>> all.
> 
> That's clearly a general argument, so why should any improvement be 
> arbitrarily restricted to Confidential Compute scenarios?
> 
My idea is that other scenarios can generally support modern high-speed 
devices without swiotlb.

But almost all DMA allocations in CoCo scenarios need to go through 
swiotlb for bouncing DMA buffer between the private and shared memory, 
which makes this problem more prominent in CoCo scenarios.

I guess the same logic may also apply to Xen, but I am not sure so it is 
CoCo-limited feature for now.

>> 3. The legacy swiotlb cannot efficiently support larger swiotlb buffers.
>> In the worst case, the current implementation requires a full scan of
>> the entire swiotlb buffer, which can cause severe performance hits.
> 
> Isn't that the main reason we just recently introduced the multiple area 
> stuff?
> 

Yes, this issue is mitigated by multiple area stuff partially, and I am 
actually facing some issues current scanning logic (for example, it 
keeps scan the tlb buffer forever and causes soft lookups[1]). And I 
will keep track this issue (candidate) to give your more details about this.

But my more intuitive thought is why do we need such a complex 
allocation algorithm? If we only supported CoCo scenarios (or maybe 
Xen), we might be able to have a more deterministic algorithm instead of 
waiting for the results of the scan.

[1] some details about the soft lookup:

$ cat ./test.sh
count=0
while true; do
         for i in {1..21};do
                 mkfs.xfs -f /dev/nvme${i}n1 &> /dev/null &
         done
         wait
         count=$((count+1))
         echo $count
done

$ ./test.sh # It may take some time...

$ # The system is not fully operational from here...

$ echo l > /proc/sysrq-trigger
...

Every other CPU are waiting this core to exit the swiotlb_do_find_slots 
loop.

[10199.924385] NMI backtrace for cpu 49
[10199.924386] CPU: 49 PID: 951 Comm: kworker/49:1H Kdump: loaded 
Tainted: G            EL     6.2.0-rc6-swiotlb-upstream-bug-repreduce+ #70
[10199.924388] Workqueue: kblockd blk_mq_run_work_fn
[10199.924391] RIP: 0010:swiotlb_do_find_slots+0x1fe/0x3e0
[10199.924393] Code: 77 21 48 8b 54 24 28 44 8b 7c 24 38 4c 8b 52 48 48 
8d 14 49 48 c1 e2 03 45 39 7c 12 10 0f 83 f7 00 00 00 01 e8 bb 00 00 00 
00 <41> 39 c0 0f 46 c3 39 f8 0f 85 4f ff ff f
f 48 8b 74 24 40 48 8b 7c
[10199.924394] RSP: 0018:ffffc90003913bb0 EFLAGS: 00000002
[10199.924395] RAX: 00000000000000e5 RBX: 0000000000000000 RCX: 
00000000001880e1
[10199.924396] RDX: 00000000024c1518 RSI: 0000000000188000 RDI: 
000000000000030c
[10199.924397] RBP: 0000000000000004 R08: 0000000000008000 R09: 
0000000000000002
[10199.924397] R10: ffff88dad2400000 R11: 00000000001fffff R12: 
00000000d8400000
[10199.924398] R13: 000000012cc2a800 R14: 0000000000200000 R15: 
0000000000000002
[10199.924399] FS:  0000000000000000(0000) GS:ffff88dce5040000(0000) 
knlGS:0000000000000000
[10199.924400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10199.924401] CR2: 00007f8eb9dece80 CR3: 000000000640a004 CR4: 
0000000000770ee0
[10199.924401] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[10199.924402] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
0000000000000400
[10199.924403] PKRU: 55555554
[10199.924403] Call Trace:
[10199.924404]  <TASK>
[10199.924405]  swiotlb_tbl_map_single+0xec/0x1f0
[10199.924407]  swiotlb_map+0x5c/0x260
[10199.924409]  ? nvme_pci_setup_prps+0x1ed/0x340
[10199.924411]  dma_direct_map_page+0x12e/0x1c0
[10199.924413]  nvme_map_data+0x304/0x370
[10199.924415]  nvme_prep_rq.part.0+0x31/0x120
[10199.924417]  nvme_queue_rq+0x77/0x1f0
[10199.924420]  blk_mq_dispatch_rq_list+0x17e/0x670
[10199.924422]  __blk_mq_sched_dispatch_requests+0x129/0x140
[10199.924424]  blk_mq_sched_dispatch_requests+0x34/0x60
[10199.924426]  __blk_mq_run_hw_queue+0x91/0xb0
[10199.924428]  process_one_work+0x1df/0x3b0
[10199.924430]  worker_thread+0x49/0x2e0
[10199.924432]  ? rescuer_thread+0x390/0x390
[10199.924433]  kthread+0xe5/0x110
[10199.924435]  ? kthread_complete_and_exit+0x20/0x20
[10199.924436]  ret_from_fork+0x1f/0x30
[10199.924439]  </TASK>

...
[ 9639.596311] NMI backtrace for cpu 48
[ 9639.596313] CPU: 48 PID: 1215 Comm: kworker/48:1H Kdump: loaded 
Tainted: G            E      6.2.0-rc6-swiotlb-upstream-bug-repreduce+ #70
[ 9639.596315] Workqueue: kblockd blk_mq_run_work_fn
[ 9639.596319] RIP: 0010:native_queued_spin_lock_slowpath+0x18/0x2c0
[ 9639.596322] Code: 75 02 5a c3 56 0f b6 f0 e8 c5 ff ff ff 5e 5a c3 66 
90 0f 1f 44 00 00 41 55 41 54 55 48 89 fd 53 66 90 ba 01 00 00 00 8b 45 
00 <85> c0 75 10 f0 0f b1 55 00 85 c0 75 f0 5
b 5d 41 5c 41 5d c3 f3 90
[ 9639.596323] RSP: 0018:ffffc90003e5fb38 EFLAGS: 00000002
[ 9639.596325] RAX: 0000000000000001 RBX: ffff88de5e459adc RCX: 
0000000000001000
[ 9639.596326] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff88de5e459adc
[ 9639.596327] RBP: ffff88de5e459adc R08: 0000000000000000 R09: 
ffff888102ab6090
[ 9639.596328] R10: ffff88dad2400000 R11: 00000000001fffff R12: 
0000000000000293
[ 9639.596329] R13: 000000000730d000 R14: 0000000000200000 R15: 
ffffffff83540160
[ 9639.596330] FS:  0000000000000000(0000) GS:ffff88dce5000000(0000) 
knlGS:0000000000000000
[ 9639.596331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9639.596332] CR2: 00007fc091da0000 CR3: 000000000640a002 CR4: 
0000000000770ee0
[ 9639.596334] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 9639.596334] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
0000000000000400
[ 9639.596335] PKRU: 55555554
[ 9639.596336] Call Trace:
[ 9639.596337]  <TASK>
[ 9639.596338]  _raw_spin_lock_irqsave+0x37/0x40
[ 9639.596341]  swiotlb_do_find_slots+0xef/0x3e0
[ 9639.596344]  swiotlb_tbl_map_single+0xec/0x1f0
[ 9639.596347]  swiotlb_map+0x5c/0x260
[ 9639.596349]  dma_direct_map_sg+0x7a/0x280
[ 9639.596352]  __dma_map_sg_attrs+0x30/0x70
[ 9639.596355]  dma_map_sgtable+0x1d/0x30
[ 9639.596356]  nvme_map_data+0xce/0x370
[ 9639.596359]  nvme_prep_rq.part.0+0x31/0x120
[ 9639.596362]  nvme_queue_rq+0x77/0x1f0
[ 9639.596364]  blk_mq_dispatch_rq_list+0x17e/0x670
[ 9639.596367]  __blk_mq_sched_dispatch_requests+0x129/0x140
[ 9639.596370]  blk_mq_sched_dispatch_requests+0x34/0x60
[ 9639.596372]  __blk_mq_run_hw_queue+0x91/0xb0
[ 9639.596374]  process_one_work+0x1df/0x3b0
[ 9639.596377]  worker_thread+0x49/0x2e0
[ 9639.596379]  ? rescuer_thread+0x390/0x390
[ 9639.596380]  kthread+0xe5/0x110
[ 9639.596382]  ? kthread_complete_and_exit+0x20/0x20
[ 9639.596383]  ret_from_fork+0x1f/0x30
[ 9639.596387]  </TASK>

...

[ 9639.595665] NMI backtrace for cpu 50
[ 9639.595667] CPU: 50 PID: 0 Comm: swapper/50 Kdump: loaded Tainted: G 
           E      6.2.0-rc6-swiotlb-upstream-bug-repreduce+ #70
[ 9639.595669] RIP: 0010:native_queued_spin_lock_slowpath+0x2e/0x2c0
[ 9639.595672] Code: 00 41 55 41 54 55 48 89 fd 53 66 90 ba 01 00 00 00 
8b 45 00 85 c0 75 10 f0 0f b1 55 00 85 c0 75 f0 5b 5d 41 5c 41 5d c3 f3 
90 <eb> e5 81 fe 00 01 00 00 74 4e 40 30 f6 8
5 f6 75 71 f0 0f ba 6d 00
[ 9639.595673] RSP: 0018:ffffc90000c38e28 EFLAGS: 00000002
[ 9639.595674] RAX: 0000000000000001 RBX: ffff88de5e459adc RCX: 
0000000000000001
[ 9639.595675] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff88de5e459adc
[ 9639.595675] RBP: ffff88de5e459adc R08: ffff88dad2400000 R09: 
0000000000001000
[ 9639.595676] R10: 0000005b9c570000 R11: ffffc90000c38ff8 R12: 
0000000000000087
[ 9639.595677] R13: ffff88de5e459ad0 R14: ffff88de5e459adc R15: 
00000000001882e0
[ 9639.595678] FS:  0000000000000000(0000) GS:ffff88dce5080000(0000) 
knlGS:0000000000000000
[ 9639.595679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9639.595679] CR2: 00007f256aa4d10c CR3: 000000010ade0005 CR4: 
0000000000770ee0
[ 9639.595680] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 9639.595681] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 
0000000000000400
[ 9639.595681] PKRU: 55555554
[ 9639.595682] Call Trace:
[ 9639.595682]  <IRQ>
[ 9639.595683]  _raw_spin_lock_irqsave+0x37/0x40
[ 9639.595686]  swiotlb_release_slots.isra.0+0x86/0x180
[ 9639.595688]  dma_direct_unmap_sg+0xcf/0x1a0
[ 9639.595690]  nvme_unmap_data.part.0+0x43/0xc0
[ 9639.595693]  nvme_pci_complete_batch+0x71/0xe0
[ 9639.595695]  nvme_irq+0x7b/0x90
[ 9639.595697]  ? nvme_prep_rq_batch+0xc0/0xc0
[ 9639.595700]  __handle_irq_event_percpu+0x46/0x170
[ 9639.595701]  handle_irq_event+0x3a/0x80
[ 9639.595703]  handle_edge_irq+0xae/0x290
[ 9639.595705]  __common_interrupt+0x62/0x100
[ 9639.595707]  common_interrupt+0xb3/0xd0
[ 9639.595709]  </IRQ>
[ 9639.595709]  <TASK>
[ 9639.595710]  asm_common_interrupt+0x22/0x40
[ 9639.595712] RIP: 0010:__tdx_hypercall+0x34/0x80

$ git diff # which allow me to allocate swiotlb memory bigger than 4GiB.
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..a6d7aae3c040 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -311,6 +311,7 @@ static void *swiotlb_memblock_alloc(unsigned long 
nslabs, unsigned int flags,
          * allow to pick a location everywhere for hypervisors with guest
          * memory encryption.
          */
+       flags |= SWIOTLB_ANY;
         if (flags & SWIOTLB_ANY)
                 tlb = memblock_alloc(bytes, PAGE_SIZE);
         else



Thank you very much for your time and careful reading.
Guorui

> Robin.
> 
>> Changes in this patch set
>> =========================
>> Instead of keeping "infecting" the legacy swiotlb code with CoCo logic,
>> this patch tries to introduce a new cc-swiotlb for Confidential VMs.
>>
>> Confidential VMs usually have reasonable modern devices (virtio devices,
>> NVME, etc.), which can access memory above 4GiB, cc-swiotlb could
>> allocate TLB buffers at any position dynamically. Since
>> set_memory_{decrypted,encrypted} is time-consuming and cannot be used in
>> interrupt context, a new kernel thread "kccd" has been added to populate
>> new TLB buffers on-demand, which solved the problem 1.
>>
>> In addition, the cc-swiotlb manages TLB buffers by different sizes
>> (512B, 2KiB, 4KiB, 16KiB, and 512KiB). The above values come from the
>> following observations (boot with 8core, 32 GiB, 1 nvme disk, and 1
>> virtio-net):
>> - Allocations of 512 bytes and below account for 3.5% of the total DMA
>>    cache allocations;
>> - Allocations of 2 KiB and below account for 57.7%;
>> - Allocations of 4 KiB and below account for 91.3%;
>> - Allocations of 16 KiB and below account for 96.0%;
>> - Allocations of 512 KiB and below accounted for 100%;
>> - At the end of booting, cc-swiotlb uses 288 MiB in total.
>>
>> For comparison, legacy swiotlb reserves memory at 6%, which requires
>> min(1GiB, 32GiB * 0.06) = 1GiB, and will hang when operating multiple
>> disks simultaneously due to no memory for the swiotlb buffer.
>>
>> These patches were tested with fio (using different iodepth and block
>> size) on a platform with 96 cores, 384 GiB, and 20 NVME disks, and no IO
>> hang or error was observed.
>>
>> For simplicity, the current RFC version cannot switch between legacy
>> implementation with cmdline but through compile options. I am open to
>> discussing how to integrate the cc-swiotlb into the legacy one.
>>
>> Patch Organization
>> ==================
>> - swiotlb: Split common code from swiotlb.{c,h}
>> - swiotlb: Add a new cc-swiotlb implementation for Confidential VMs
>> - swiotlb: Add tracepoint swiotlb_unbounced
>> - cc-swiotlb: Allow set swiotlb watermark from cmdline
>>
>> Thanks for your time!
>>
>> Have a nice day,
>> Guorui
>>
>>
