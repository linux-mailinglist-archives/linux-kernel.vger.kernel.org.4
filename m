Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55E6CA226
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjC0LHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjC0LHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:32 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCBE49E9;
        Mon, 27 Mar 2023 04:07:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PlVCg3M3Bz9v7gX;
        Mon, 27 Mar 2023 18:58:07 +0800 (CST)
Received: from [10.81.213.122] (unknown [10.81.213.122])
        by APP2 (Coremail) with SMTP id GxC2BwAH3GK8eCFkLgbRAQ--.30794S2;
        Mon, 27 Mar 2023 12:06:46 +0100 (CET)
Message-ID: <630334b5-05d0-0152-7c2c-79174703f0ed@huaweicloud.com>
Date:   Mon, 27 Mar 2023 13:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v1 0/4] Allow dynamic allocation of software IO TLB bounce
 buffers
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
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
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Language: en-US
In-Reply-To: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAH3GK8eCFkLgbRAQ--.30794S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47GFyUXF4kur15XFW7CFg_yoWxWw4DpF
        W3CryY9rn8tr1fuw1xCw4Iqas5Aws5AFW5KF9Ygr1UZr15JFyI9r17tay3WF9xCrs2g3Wj
        qryYva4DCFyvvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello after a week,

I'm top-posting, because I'm not replying to anything particular in my
original RFC. It seems there are no specific comments from other people
either. My understanding is that the general idea of making SWIOTLB grow
and shrink as needed is welcome, but nobody can suggest a good method to
measure the expected performance impact.

FWIW I have seen zero impact if the patches are applied, but not enabled
through "swiotlb=dynamic" boot parameter. I believe this is sufficient
to start developing dynamic SWIOTLB as an experimental feature.

@Christoph: I was kind of expecting you to jump up and tell me that the
non-coherent DMA API cannot be used to allocate bounce buffers. ;-) But
since that has not happened, I will assume that there is no weird
architecture which treats SWIOTLB differently from other DMA-capable
regions.

Anyway, I have some comments of my own to the v1 RFC series.

First, the maple tree cannot be used to track buffers, because it is not
safe to use from interrupt context. The maple tree implementation
currently allocates new nodes with kmem_cache_alloc_bulk(), which must
be called with interrupts enabled. This can be changed in the maple tree
code, but I could also pre-allocate nodes from non-irq context, or use
another data structure instead.

Second, based on discussions with my dear colleague Roberto, I have
considered alternative approaches:

A. Keep track of SWIOTLB utilization and allocate additional io_tlb_mem
structures from a separate kernel thread when necessary. The advantage
is that allocations are moved away from the hot path (map/unmap). The
disadvantage is that these additional tables would necessarily be small
(limited by MAX_ORDER and physical memory fragmentation). Another
disadvantage is that such a multi-table SWIOTLB is not very likely to
shrink, because a table can be freed only if ALL slots are free.

B. Allocate a very big SWIOTLB, but allow to use it for normal
allocations (similar to the CMA approach). The advantage is that there
is only one table, pushing performance impact down to almost zero. The
main challenge is migrating pages to/from the SWIOTLB. Existing CMA code
cannot be reused, because CMA cannot be used from atomic contexts,
unlike SWIOTLB.

For the time being, I propose to start with my RFC series, accepting
some performance drop if the feature is explicitly enabled. With more
feedback from the field (especially from you, SEV SNP guys), I can work
on improving performance.

Petr T

On 3/20/2023 1:28 PM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The goal of my work is to provide more flexibility in the sizing of
> SWIOTLB. This patch series is a request for comments from the wider
> community. The code is more of a crude hack than final solution.
> 
> I would appreciate suggestions for measuring the performance impact
> of changes in SWIOTLB. More info at the end of this cover letter.
> 
> The software IO TLB was designed with these assumptions:
> 
> 1. It would not be used much, especially on 64-bit systems.
> 2. A small fixed memory area (64 MiB by default) is sufficient to
>    handle the few cases which require a bounce buffer.
> 3. 64 MiB is little enough that it has no impact on the rest of the
>    system.
> 
> First, if SEV is active, all DMA must be done through shared
> unencrypted pages, and SWIOTLB is used to make this happen without
> changing device drivers. The software IO TLB size is increased to
> 6% of total memory in sev_setup_arch(), but that is more of an
> approximation. The actual requirements may vary depending on the
> amount of I/O and which drivers are used. These factors may not be
> know at boot time, i.e. when SWIOTLB is allocated.
> 
> Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
> moved from the rendering GPU (v3d driver), which can access all
> memory, to the display output (vc4 driver), which is connected to a
> bus with an address limit of 1 GiB and no IOMMU. These buffers can
> be large (8 MiB with a FullHD monitor, 34 MiB with a 4K monitor)
> and cannot be even handled by current SWIOTLB, because they exceed
> the maximum segment size of 256 KiB.  Mapping failures can be
> easily reproduced with GNOME remote desktop on a Raspberry Pi 4.
> 
> Third, other colleagues have noticed that they can reliably get rid
> of occasional OOM kills on an Arm embedded device by reducing the
> SWIOTLB size. This can be achieved with a kernel parameter, but
> determining the right value puts additional burden on pre-release
> testing, which could be avoided if SWIOTLB is allocated small and
> grows only when necessary.
> 
> I have tried to measure the expected performance degradation so
> that I could reduce it and/or compare it to alternative approaches.
> I have performed all tests on an otherwise idle Raspberry Pi 4 with
> swiotlb=force (which, addmittedly, is a bit artificial). I quickly
> ran into trouble.
> 
> I ran fio against an ext3 filesystem mounted from a UAS drive. To
> my surprise, forcing swiotlb (without my patches) *improved* IOPS
> and bandwidth for 4K and 64K blocks by 3 to 7 percent, and made no
> visible difference for 1M blocks. I also observed smaller minimum
> and average completion latencies, and even smaller maximum
> latencies for 4K blocks. However, when I ran the tests again later
> to verify some oddities, there was a performance drop. It appears
> that I/O, bandwidth and latencies reported by two consecutive fio
> runs may differ by as much as 10%, so the results are invalid.
> 
> I tried to make a micro-benchmark on dma_map_page_attrs() using the
> bcc tool funclatency, but just loading the eBPF program was enough
> to change the behaviour of the system wildly.
> 
> I wonder if anyone can give me advice on measuring SWIOTLB
> performance. I can see that AMD, IBM and Microsoft people have
> mentioned performance in their patches, but AFAICS without
> explaining how it was measured. Knowing a bit more would be much
> appreciated.
> 
> Petr Tesarik (4):
>   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
>   swiotlb: Move code around in preparation for dynamic bounce buffers
>   swiotlb: Allow dynamic allocation of bounce buffers
>   swiotlb: Add an option to allow dynamic bounce buffers
> 
>  .../admin-guide/kernel-parameters.txt         |   6 +-
>  Documentation/core-api/dma-attributes.rst     |  10 +
>  include/linux/dma-mapping.h                   |   6 +
>  include/linux/swiotlb.h                       |  17 +-
>  kernel/dma/swiotlb.c                          | 233 +++++++++++++++---
>  5 files changed, 241 insertions(+), 31 deletions(-)
> 

