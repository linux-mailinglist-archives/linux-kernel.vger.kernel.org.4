Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB796CBF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1MoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC1MoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:44:03 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD81AD22;
        Tue, 28 Mar 2023 05:43:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pm8Hn0YmLz9v7cL;
        Tue, 28 Mar 2023 20:33:57 +0800 (CST)
Received: from [10.48.131.174] (unknown [10.48.131.174])
        by APP1 (Coremail) with SMTP id LxC2BwC3QAza4CJklbTXAQ--.65267S2;
        Tue, 28 Mar 2023 13:43:16 +0100 (CET)
Message-ID: <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
Date:   Tue, 28 Mar 2023 14:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
        Alexander Graf <graf@amazon.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
 <20230328040724.GB25506@lst.de>
 <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwC3QAza4CJklbTXAQ--.65267S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4xXw18Ar43uFy8Aw4xJFb_yoW5tFWxpF
        y7ZF95KF4UWF4kC34Duw48GF1j9w4vk3yfW39Yvr1FkrnxXr95XF1DGrWYy3s5tr4vkF42
        qry093yYk3WUXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2023 9:54 AM, Petr Tesarik wrote:
> On 3/28/2023 6:07 AM, Christoph Hellwig wrote:
>> [adding Alex as he has been interested in this in the past]
>>
>[...]>> I'm a little worried about all that because it causes quite a bit
>> of overhead even for callers that don't end up going into the
>> dynamic range or do not use swiotlb at all.  I don't really have a
>> good answer here except for the usual avoid bounce buffering whenever
>> you can that might not always be easy to do.
> 
> I'm also worried about all this overhead.

Oh, wait! I can do at least something for devices which do not use
swiotlb at all.

If a device does not use bounce buffers, it cannot pass an address
that belongs to the swiotlb. Consequently, the potentially
expensive check can be skipped. This avoids the dynamic lookup
penalty for devices which do not need the swiotlb.

Note that the counter always remains zero if dma_io_tlb_mem is
NULL, so the NULL check is not required.

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..f36638f207b8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2957,6 +2957,7 @@ void device_initialize(struct device *dev)
 #endif
 #ifdef CONFIG_SWIOTLB
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
+	atomic_set(&dev->dma_io_tlb_cnt, 0);
 #endif
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..cfdddce4cc30 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -504,6 +504,7 @@ struct device_physical_location {
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
  * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
+ * @dma_io_tlb_cnt: Number of buffers mapped from the swiotlb pool.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -609,6 +610,7 @@ struct device {
 #endif
 #ifdef CONFIG_SWIOTLB
 	struct io_tlb_mem *dma_io_tlb_mem;
+	atomic_t dma_io_tlb_cnt;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 628e25ad7db7..7a115f4db49d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -122,7 +122,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem &&
+	return atomic_read(&dev->dma_io_tlb_cnt) &&
 		(is_swiotlb_fixed(mem, paddr) ||
 		 (mem->allow_dyn && is_swiotlb_dyn(mem, paddr)));
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 3efaefebb6af..3dda1d3a39e8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -954,6 +954,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return tlb_addr;
 	}
 
+	atomic_inc(&dev->dma_io_tlb_cnt);
+
 	/*
 	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
 	 * to the tlb buffer, if we knew for sure the device will
@@ -1030,6 +1032,7 @@ void swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 		swiotlb_release_slots(dev, tlb_addr);
 	else
 		swiotlb_dyn_unmap(dev, tlb_addr, dir);
+	atomic_dec(&dev->dma_io_tlb_cnt);
 }
 
 void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,

