Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1965FF85B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJOD6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJOD6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:58:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D4E7A773;
        Fri, 14 Oct 2022 20:58:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mq8ZH06P9zKFQl;
        Sat, 15 Oct 2022 11:56:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXmMrxL0pjAy0tAQ--.54884S3;
        Sat, 15 Oct 2022 11:58:42 +0800 (CST)
Subject: Re: [PATCH v2] blk-mq: fix null pointer dereference in
 blk_mq_clear_rq_mapping()
To:     Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        ming.lei@redhat.com, hare@suse.de, john.garry@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221011142253.4015966-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c69e005d-7088-c4cd-f584-c4cf5385cdcc@huaweicloud.com>
Date:   Sat, 15 Oct 2022 11:58:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221011142253.4015966-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXmMrxL0pjAy0tAQ--.54884S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15WF1rtr4kJw18JrWkWFg_yoW8Cw48pF
        4UGa1FkFZ0qr18ua1xXa9Fyryqga1kWr1rCa1Yv3s5Zry0kr17KF1vyrWUXr10yrs7CFZx
        tr4YkFW8Jr1Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens!

ÔÚ 2022/10/11 22:22, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a null pointer dereference, root cause is
> following:
> 
> __blk_mq_alloc_map_and_rqs
>   set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs
>    blk_mq_alloc_map_and_rqs
>     blk_mq_alloc_rqs
>      // failed due to oom
>      alloc_pages_node
>      // set->tags[hctx_idx] is still NULL
>      blk_mq_free_rqs
>       drv_tags = set->tags[hctx_idx];
>       // null pointer dereference is triggered
>       blk_mq_clear_rq_mapping(drv_tags, ...)
> 
> This is because commit 63064be150e4 ("blk-mq:
> Add blk_mq_alloc_map_and_rqs()") merged the two steps:
> 
> 1) set->tags[hctx_idx] = blk_mq_alloc_rq_map()
> 2) blk_mq_alloc_rqs(..., set->tags[hctx_idx])
> 
> into one step:
> 
> set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs()
> 
> Since tags is not initialized yet in this case, fix the problem by
> checking if tags is NULL pointer in blk_mq_clear_rq_mapping().
> 
> Fixes: 63064be150e4 ("blk-mq: Add blk_mq_alloc_map_and_rqs()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
> Changes in v2:
>   - fix spelling mistakes
>   - add review tag
> 
>   block/blk-mq.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
Can you apply this patch?

Thanks,
Kuai

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..33292c01875d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3112,8 +3112,11 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>   	struct page *page;
>   	unsigned long flags;
>   
> -	/* There is no need to clear a driver tags own mapping */
> -	if (drv_tags == tags)
> +	/*
> +	 * There is no need to clear mapping if driver tags is not initialized
> +	 * or the mapping belongs to the driver tags.
> +	 */
> +	if (!drv_tags || drv_tags == tags)
>   		return;
>   
>   	list_for_each_entry(page, &tags->page_list, lru) {
> 

