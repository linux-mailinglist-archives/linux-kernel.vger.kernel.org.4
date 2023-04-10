Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54236DC4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDJJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDJJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:03:38 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57A19A9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:03:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pw30z1SlDz4f3snB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:03:31 +0800 (CST)
Received: from [10.174.179.189] (unknown [10.174.179.189])
        by APP4 (Coremail) with SMTP id gCh0CgCnXLDj0DNkTYRoHA--.49143S2;
        Mon, 10 Apr 2023 17:03:32 +0800 (CST)
Message-ID: <e64d8888-f00c-d360-b35c-54396c6fff2d@huaweicloud.com>
Date:   Mon, 10 Apr 2023 17:03:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCHv2] mm: introduce defer free for cma
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
References: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Language: en-US
From:   Wu Bo <wubo@huaweicloud.com>
In-Reply-To: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnXLDj0DNkTYRoHA--.49143S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyruFWkJry5AFyDXr48Xrb_yoW5ZrW7pF
        1rGry5ArWrJrnF9rW3ZaykuryYvrs2kFy3KrZ7C343JF9xJFnxXw48C3WUAF1rGrykWF4I
        qFWYgasF93WUtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: pzxe0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/10 16:46, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Continues page blocks are expensive for the system. Introducing defer free
> mechanism to buffer some which make the allocation easier. The shrinker will
> ensure the page block can be reclaimed when there is memory pressure.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: fix build warning and regist shrinker
> ---
> ---
>   mm/cma.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   mm/cma.h |  11 +++++
>   2 files changed, 160 insertions(+), 2 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 4a978e0..6d2fd24 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -39,6 +39,10 @@
>   unsigned cma_area_count;
>   static DEFINE_MUTEX(cma_mutex);
>   
> +static unsigned long cma_defer_free_count(struct shrinker *shrinker,
> +					struct shrink_control *sc);
> +static unsigned long cma_defer_free_scan(struct shrinker *shrinker,
> +					struct shrink_control *sc);
>   phys_addr_t cma_get_base(const struct cma *cma)
>   {
>   	return PFN_PHYS(cma->base_pfn);
> @@ -153,6 +157,20 @@ static int __init cma_init_reserved_areas(void)
>   }
>   core_initcall(cma_init_reserved_areas);
>   
> +static unsigned long cma_free_get(struct cma *cma)
> +{
> +	unsigned long used;
> +	unsigned long val;
> +
> +	spin_lock_irq(&cma->lock);
> +	/* pages counter is smaller than sizeof(int) */
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +	val = cma->count - ((u64)used << cma->order_per_bit);
> +	spin_unlock_irq(&cma->lock);
> +
> +	return val;
> +}
> +
>   void __init cma_reserve_pages_on_error(struct cma *cma)
>   {
>   	cma->reserve_pages_on_error = true;
> @@ -212,6 +230,13 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   	cma_area_count++;
>   	totalcma_pages += (size / PAGE_SIZE);
>   
> +	cma->batch = cma->count >> 1;
> +	cma->shrinker.count_objects = cma_defer_free_count;
> +	cma->shrinker.scan_objects = cma_defer_free_scan;
> +	cma->shrinker.seeks = DEFAULT_SEEKS;
> +	cma->shrinker.batch = 0;
> +
> +	register_shrinker(&cma->shrinker, "cma-shrinker");
>   	return 0;
>   }
>   
> @@ -411,6 +436,46 @@ static void cma_debug_show_areas(struct cma *cma)
>   static inline void cma_debug_show_areas(struct cma *cma) { }
>   #endif
>   
> +static int cma_defer_area_fetch(struct cma *cma, unsigned long pfn,
> +		unsigned long count)
> +{
> +	struct cma_defer_free_area *area;
> +	unsigned long new_pfn;
> +	int ret = -1;
> +
> +	if (!atomic64_read(&cma->defer_count))
> +		return ret;
> +	if (count <= atomic64_read(&cma->defer_count)) {
> +		spin_lock_irq(&cma->lock);
> +		list_for_each_entry(area, &cma->defer_free, list) {
> +			/*area found for given pfn and count*/
> +			if (pfn >= area->pfn && count <= area->count) {
> +				list_del(&area->list);
> +				/*set bits for allocated pfn*/
> +				bitmap_set(cma->bitmap, pfn - cma->base_pfn, count);
> +				kfree(area);
> +				atomic64_sub(count, &cma->defer_count);
> +				/*release the rest pfn to cma*/
> +				if (!list_empty(&cma->defer_free) && (pfn == area->pfn)) {
There is a null pointer reference here？

