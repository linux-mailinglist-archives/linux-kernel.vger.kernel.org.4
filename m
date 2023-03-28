Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579006CB8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjC1Hzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC1Hza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:55:30 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2E358E;
        Tue, 28 Mar 2023 00:55:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pm1v06XbSz9xFr3;
        Tue, 28 Mar 2023 15:45:32 +0800 (CST)
Received: from [10.48.131.174] (unknown [10.48.131.174])
        by APP2 (Coremail) with SMTP id GxC2BwAX510+nSJk3K7UAQ--.16527S2;
        Tue, 28 Mar 2023 08:54:49 +0100 (CET)
Message-ID: <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
Date:   Tue, 28 Mar 2023 09:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Content-Language: en-US
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
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
In-Reply-To: <20230328040724.GB25506@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAX510+nSJk3K7UAQ--.16527S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DWFy8ZFWxAFWDZryftFb_yoWrtF1kpF
        WfKw4YvrWDJr1Iyry8Cw18W3W0ywsxAFy5GrySgr1avw45WryF9F1SkFW5Wa9rCwn3Xw1j
        qr4Yvw4kAas8Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2023 6:07 AM, Christoph Hellwig wrote:
> [adding Alex as he has been interested in this in the past]
> 
> On Mon, Mar 20, 2023 at 01:28:15PM +0100, Petr Tesarik wrote:
>> Second, on the Raspberry Pi 4, swiotlb is used by dma-buf for pages
>> moved from the rendering GPU (v3d driver), which can access all
>> memory, to the display output (vc4 driver), which is connected to a
>> bus with an address limit of 1 GiB and no IOMMU. These buffers can
>> be large (several megabytes) and cannot be handled by SWIOTLB,
>> because they exceed maximum segment size of 256 KiB. Such mapping
>> failures can be easily reproduced on a Raspberry Pi4: Starting
>> GNOME remote desktop results in a flood of kernel messages like
>> these:
> 
> Shouldn't we make sure dma-buf allocates the buffers for the most
> restricted devices, and more importantly does something like a dma
> coherent allocation instead of a dynamic mapping of random memory?
> 
> While a larger swiotlb works around this I don't think this fixes the root
> cause.

I tend to agree here. However, it's the DMABUF design itself that causes
some trouble. The buffer is allocated by the v3d driver, which does not
have the restriction, so the DMA API typically allocates an address
somewhere near the 4G boundary. Userspace then exports the buffer, sends
it to another process as a file descriptor and imports it into the vc4
driver, which requires DMA below 1G. In the beginning, v3d had no idea
that the buffer would be exported to userspace, much less that it would
be later imported into vc4.

Anyway, I suspected that the buffers need not be imported into the vc4
driver (also hinted by Eric Anholt in a 2018 blog post [1]), and it
seems I was right. I encountered the issue with Ubuntu 22.10; I
installed latest openSUSE Tumbleweed yesterday, and I was not able to
reproduce the issue there, most likely because the Mesa drivers have
been fixed meanwhile. This makes the specific case of the Raspberry Pi 4
drivers moot. The issue may still affect other combinations of drivers,
but I don't have any other real-world example ATM.

[1] https://anholt.github.io/twivc4/2018/02/12/twiv/

>> 1. The value is limited to ULONG_MAX, which is too little both for
>>    physical addresses (e.g. x86 PAE or 32-bit ARM LPAE) and DMA
>>    addresses (e.g. Xen guests on 32-bit ARM).
>>
>> 2. Since buffers are currently allocated with page granularity, a
>>    PFN can be used instead. However, some values are reserved by
>>    the maple tree implementation. Liam suggests to use
>>    xa_mk_value() in that case, but that reduces the usable range by
>>    half. Luckily, 31 bits are still enough to hold a PFN on all
>>    32-bit platforms.
>>
>> 3. Software IO TLB is used from interrupt context. The maple tree
>>    implementation is not IRQ-safe (MT_FLAGS_LOCK_IRQ does nothing
>>    AFAICS). Instead, I use an external lock, spin_lock_irqsave() and
>>    spin_unlock_irqrestore().
>>
>> Note that bounce buffers are never allocated dynamically if the
>> software IO TLB is in fact a DMA restricted pool, which is intended
>> to be stay in its designated location in physical memory.
> 
> I'm a little worried about all that because it causes quite a bit
> of overhead even for callers that don't end up going into the
> dynamic range or do not use swiotlb at all.  I don't really have a
> good answer here except for the usual avoid bounce buffering whenever
> you can that might not always be easy to do.

I'm also worried about all this overhead. OTOH I was not able to confirm
it, because the difference between two successive fio test runs on an
unmodified kernel was bigger than the difference between a vanilla and a
patched kernel, except the maximum completion latency, which OTOH
affected less than 0.01% of all requests.

BTW my testing also suggests that the streaming DMA API is quite
inefficient, because UAS performance _improved_ with swiotlb=force.
Sure, this should probably be addressed in the UAS and/or xHCI driver,
but what I mean is that moving away from swiotlb may even cause
performance regressions, which is counter-intuitive. At least I would
_not_ have expected it.

>> +	gfp = (attrs & DMA_ATTR_MAY_SLEEP) ? GFP_KERNEL : GFP_NOWAIT;
>> +	slot = kmalloc(sizeof(*slot), gfp | __GFP_NOWARN);
>> +	if (!slot)
>> +		goto err;
>> +
>> +	slot->orig_addr = orig_addr;
>> +	slot->alloc_size = alloc_size;
>> +	slot->page = dma_direct_alloc_pages(dev, PAGE_ALIGN(alloc_size),
>> +					    &slot->dma_addr, dir,
>> +					    gfp | __GFP_NOWARN);
>> +	if (!slot->page)
>> +		goto err_free_slot;
> 
> Without GFP_NOIO allocations this will deadlock eventually.

Ah, that would affect the non-sleeping case (GFP_KERNEL), right?

Petr T

