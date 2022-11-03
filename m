Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A4617497
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKCC4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiKCCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:55:45 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7013F81;
        Wed,  2 Nov 2022 19:55:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2pGW6c8Vz6S341;
        Thu,  3 Nov 2022 10:53:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgCXfdKpLWNjnAoYBQ--.5634S3;
        Thu, 03 Nov 2022 10:55:38 +0800 (CST)
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
To:     Khazhismel Kumykov <khazhy@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221103013937.603626-1-khazhy@google.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
Date:   Thu, 3 Nov 2022 10:55:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221103013937.603626-1-khazhy@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCXfdKpLWNjnAoYBQ--.5634S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45JF15Ww1xZF1fWw1rJFb_yoW5Cryfpr
        4fW3yj9r47J3Wa9FZrCa18uF1Fga1fWr9xJr4Fg3y7Jw17JF1IyFsIkw1Y9Fs3GrWvyry3
        ZF10ga4Dur4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/11/03 9:39, Khazhismel Kumykov Ð´µÀ:
> This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> but woken_list_node still being hashed. This would happen when
> bfq_init_rq() expects a brand new allocated queue to be returned from

 From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
here...

> bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> without resetting woken_list_node. Since we can always return oom_bfqq
> when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
> We must either reset woken_list_node, or avoid setting woken_list at all
> for oom_bfqq - opt to do the former.

Once oom_bfqq is used, I think the io is treated as issued from root
group. Hence I don't think it's necessary to set woken_list or
waker_bfqq for oom_bfqq.

Thanks,
Kuai
> 
> Crashes would have a stacktrace like:
> [160595.656560]  bfq_add_bfqq_busy+0x110/0x1ec
> [160595.661142]  bfq_add_request+0x6bc/0x980
> [160595.666602]  bfq_insert_request+0x8ec/0x1240
> [160595.671762]  bfq_insert_requests+0x58/0x9c
> [160595.676420]  blk_mq_sched_insert_request+0x11c/0x198
> [160595.682107]  blk_mq_submit_bio+0x270/0x62c
> [160595.686759]  __submit_bio_noacct_mq+0xec/0x178
> [160595.691926]  submit_bio+0x120/0x184
> [160595.695990]  ext4_mpage_readpages+0x77c/0x7c8
> [160595.701026]  ext4_readpage+0x60/0xb0
> [160595.705158]  filemap_read_page+0x54/0x114
> [160595.711961]  filemap_fault+0x228/0x5f4
> [160595.716272]  do_read_fault+0xe0/0x1f0
> [160595.720487]  do_fault+0x40/0x1c8
> 
> Tested by injecting random failures into bfq_get_queue, crashes go away
> completely.
> 
> Fixes: 8ef3fc3a043c ("block, bfq: make shared queues inherit wakers")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
> RFC mainly because it's not clear to me the best policy here - but the
> patch is tested and fixes a real crash we started seeing in 5.15
> 
> This is following up my ramble over at
> https://lore.kernel.org/lkml/CACGdZYLMnfcqwbAXDx+x9vUOMn2cz55oc+8WySBS3J2Xd_q7Lg@mail.gmail.com/
> 
>   block/bfq-iosched.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 7ea427817f7f..5d2861119d20 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6793,7 +6793,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
>   				 * reset. So insert new_bfqq into the
>   				 * woken_list of the waker. See
>   				 * bfq_check_waker for details.
> +				 *
> +				 * Also, if we got oom_bfqq, we must check if
> +				 * it's already in a woken_list
>   				 */
> +				if (unlikely(!hlist_unhashed(&bfqq->woken_list_node)))
> +					hlist_del_init(&bfqq->woken_list_node);
>   				if (bfqq->waker_bfqq)
>   					hlist_add_head(&bfqq->woken_list_node,
>   						       &bfqq->waker_bfqq->woken_list);
> 

