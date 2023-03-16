Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BA6BC38C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCPCCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPCCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:02:08 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D2BAD02
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 19:02:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VdxtHh3_1678932119;
Received: from 127.0.0.1(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VdxtHh3_1678932119)
          by smtp.aliyun-inc.com;
          Thu, 16 Mar 2023 10:02:02 +0800
Message-ID: <49d6a3df-4507-599c-8f4b-3f2ba78ac535@linux.alibaba.com>
Date:   Thu, 16 Mar 2023 10:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2] swiotlb: fix the deadlock in swiotlb_do_find_slots
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230222165315.89135-1-GuoRui.Yu@linux.alibaba.com>
 <20230315144737.GA28864@lst.de>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <20230315144737.GA28864@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for your reply, and this new version looks go to me.

Yours sincerely,
Guorui

在 2023/3/15 22:47, Christoph Hellwig 写道:
> I think this looks generall fine, but the index_nowrap variable
> name seems very confusing.  What about this slighlt adjusted
> version?
> 
> ---
>  From 11559745f0920b53ba5f8b2fc6241891e1dfcf4b Mon Sep 17 00:00:00 2001
> From: "GuoRui.Yu" <GuoRui.Yu@linux.alibaba.com>
> Subject: swiotlb: fix the deadlock in swiotlb_do_find_slots
> 
> In general, if swiotlb is sufficient, the logic of index =
> wrap_area_index(mem, index + 1) is fine, it will quickly take a slot and
> release the area->lock; But if swiotlb is insufficient and the device
> has min_align_mask requirements, such as NVME, we may not be able to
> satisfy index == wrap and exit the loop properly. In this case, other
> kernel threads will not be able to acquire the area->lock and release
> the slot, resulting in a deadlock.
> 
> The current implementation of wrap_area_index does not involve a modulo
> operation, so adjusting the wrap to ensure the loop ends is not trivial.
> Introduce a new variable to record the number of loops and exit the loop
> after completing the traversal.
> 
> Backtraces:
> Other CPUs are waiting this core to exit the swiotlb_do_find_slots
> loop.
> [10199.924391] RIP: 0010:swiotlb_do_find_slots+0x1fe/0x3e0
> [10199.924403] Call Trace:
> [10199.924404]  <TASK>
> [10199.924405]  swiotlb_tbl_map_single+0xec/0x1f0
> [10199.924407]  swiotlb_map+0x5c/0x260
> [10199.924409]  ? nvme_pci_setup_prps+0x1ed/0x340
> [10199.924411]  dma_direct_map_page+0x12e/0x1c0
> [10199.924413]  nvme_map_data+0x304/0x370
> [10199.924415]  nvme_prep_rq.part.0+0x31/0x120
> [10199.924417]  nvme_queue_rq+0x77/0x1f0
> 
> ...
> [ 9639.596311] NMI backtrace for cpu 48
> [ 9639.596336] Call Trace:
> [ 9639.596337]
> [ 9639.596338] _raw_spin_lock_irqsave+0x37/0x40
> [ 9639.596341] swiotlb_do_find_slots+0xef/0x3e0
> [ 9639.596344] swiotlb_tbl_map_single+0xec/0x1f0
> [ 9639.596347] swiotlb_map+0x5c/0x260
> [ 9639.596349] dma_direct_map_sg+0x7a/0x280
> [ 9639.596352] __dma_map_sg_attrs+0x30/0x70
> [ 9639.596355] dma_map_sgtable+0x1d/0x30
> [ 9639.596356] nvme_map_data+0xce/0x370
> 
> ...
> [ 9639.595665] NMI backtrace for cpu 50
> [ 9639.595682] Call Trace:
> [ 9639.595682]
> [ 9639.595683] _raw_spin_lock_irqsave+0x37/0x40
> [ 9639.595686] swiotlb_release_slots.isra.0+0x86/0x180
> [ 9639.595688] dma_direct_unmap_sg+0xcf/0x1a0
> [ 9639.595690] nvme_unmap_data.part.0+0x43/0xc0
> 
> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> Signed-off-by: GuoRui.Yu <GuoRui.Yu@linux.alibaba.com>
> Signed-off-by: Xiaokang Hu <xiaokang.hxk@alibaba-inc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/swiotlb.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 03e3251cd9d2b6..91454b513db069 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -625,8 +625,8 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>   	unsigned int iotlb_align_mask =
>   		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>   	unsigned int nslots = nr_slots(alloc_size), stride;
> -	unsigned int index, wrap, count = 0, i;
>   	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> +	unsigned int index, slots_checked, count = 0, i;
>   	unsigned long flags;
>   	unsigned int slot_base;
>   	unsigned int slot_index;
> @@ -649,15 +649,16 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>   		goto not_found;
>   
>   	slot_base = area_index * mem->area_nslabs;
> -	index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
> +	index = wrap_area_index(mem, ALIGN(area->index, stride));
>   
> -	do {
> +	for (slots_checked = 0; slots_checked < mem->area_nslabs; ) {
>   		slot_index = slot_base + index;
>   
>   		if (orig_addr &&
>   		    (slot_addr(tbl_dma_addr, slot_index) &
>   		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
>   			index = wrap_area_index(mem, index + 1);
> +			slots_checked++;
>   			continue;
>   		}
>   
> @@ -673,7 +674,8 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>   				goto found;
>   		}
>   		index = wrap_area_index(mem, index + stride);
> -	} while (index != wrap);
> +		slots_checked += stride;
> +	}
>   
>   not_found:
>   	spin_unlock_irqrestore(&area->lock, flags);
