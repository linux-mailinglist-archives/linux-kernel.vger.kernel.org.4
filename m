Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775415FB363
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiJKNYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJKNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:24:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0285FB5;
        Tue, 11 Oct 2022 06:24:40 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmxJb2L6Hz67xKh;
        Tue, 11 Oct 2022 21:21:51 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:24:38 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:24:37 +0100
Message-ID: <cf3116cb-b238-56c0-c5bf-fd8fa5167f77@huawei.com>
Date:   Tue, 11 Oct 2022 14:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] blk-mq: fix null pointer dereference in
 blk_mq_clear_rq_mapping()
To:     Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>,
        <ming.lei@redhat.com>, <hare@suse.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
References: <20221011121051.3149442-1-yukuai1@huaweicloud.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221011121051.3149442-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 13:10, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a null pointer dereference, root cause is
> following:
> 
> __blk_mq_alloc_map_and_rqs
>   set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs
>    blk_mq_alloc_map_and_rqs
>     blk_mq_alloc_rqso

blk_mq_alloc_rqs

>      // failed due to oom
>      alloc_pages_node
>      // set->stags[hctx_idx] is still NULL

set->tags

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

We could have something like the following to ensure the drv tags are 
assigned before we try to allocate the rqs (and fail), but prob not 
worth the churn since it's not nice to pass &set->tags[hctx_idx]:

--->8---

-struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
+bool blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
                                              unsigned int hctx_idx,
-                                            unsigned int depth)
+                                            unsigned int depth,
+                                            struct blk_mq_tags **tags)
  {
-       struct blk_mq_tags *tags;
         int ret;

-       tags = blk_mq_alloc_rq_map(set, hctx_idx, depth, 
set->reserved_tags);
-       if (!tags)
-               return NULL;
+       *tags = blk_mq_alloc_rq_map(set, hctx_idx, depth, 
set->reserved_tags);
+       if (!*tags)
+               return false;

-       ret = blk_mq_alloc_rqs(set, tags, hctx_idx, depth);
+       ret = blk_mq_alloc_rqs(set, *tags, hctx_idx, depth);
         if (ret) {
                 blk_mq_free_rq_map(tags);
+		*tags = NULL;
-               return NULL;
+               return false;
         }

-       return tags;
+       return true;
  }

  static bool __blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
@@ -3632,10 +3632,9 @@ static bool __blk_mq_alloc_map_and_rqs(struct 
blk_mq_tag_set *set,
                 return true;
         }

-       set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs(set, hctx_idx,
-                                                      set->queue_depth);
-
-       return set->tags[hctx_idx];
+       return blk_mq_alloc_map_and_rqs(set, hctx_idx,
+                                      set->queue_depth,
+                                      &set->tags[hctx_idx]);
  }

---8<----


So,

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-mq.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
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

