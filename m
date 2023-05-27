Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1F713170
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjE0BVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE0BVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:21:33 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EDDD9;
        Fri, 26 May 2023 18:21:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QSkX66FCPz4f3s5k;
        Sat, 27 May 2023 09:21:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAXW3Fk4y8uKQ--.56326S3;
        Sat, 27 May 2023 09:21:28 +0800 (CST)
Subject: Re: [PATCH v2 1/4] md/raid10: fix null-ptr-deref of mreplace in
 raid10_sync_request
To:     linan666@huaweicloud.com, song@kernel.org, bingjingc@synology.com,
        allenpeng@synology.com, alexwu@synology.com, shli@fb.com,
        neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230526074551.669792-1-linan666@huaweicloud.com>
 <20230526074551.669792-2-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <261a87ef-341e-67ff-f804-9e6f354452dc@huaweicloud.com>
Date:   Sat, 27 May 2023 09:21:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230526074551.669792-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAXW3Fk4y8uKQ--.56326S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xuF43tr1DWr43Zr4UCFg_yoW5JFW8p3
        y7JF97Gr1UJ3yjk3WDA3ZrWFyS93Z7J3s8Cry5W34fAr1agrZrCFW0gFWYvF1DZF4Fqw4Y
        q3Wjyws5uFWIqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWr
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/26 15:45, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> need_replace will be set to 1 if no-Faulty mreplace exists, and mreplace
> will be deref later. However, the latter check of mreplace might set
> mreplace to NULL, null-ptr-deref occurs if need_replace is 1 at this time.
> 
> Fix it by merging two checks into one. And replace 'need_replace' with
> 'mreplace' because their values are always the same.
> 
> Fixes: ee37d7314a32 ("md/raid10: Fix raid10 replace hang when new added disk faulty")
> Signed-off-by: Li Nan <linan122@huawei.com>

Other than some nits below, this patch looks good to me, feel free too
add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..e21502c03b45 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3438,7 +3438,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   			int must_sync;
>   			int any_working;
>   			int need_recover = 0;
> -			int need_replace = 0;
>   			struct raid10_info *mirror = &conf->mirrors[i];
>   			struct md_rdev *mrdev, *mreplace;
>   
> @@ -3451,10 +3450,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   			    !test_bit(In_sync, &mrdev->flags))
>   				need_recover = 1;
>   			if (mreplace != NULL &&
> -			    !test_bit(Faulty, &mreplace->flags))
> -				need_replace = 1;
> +			    test_bit(Faulty, &mreplace->flags))
This can be keeped in one line.

> +				mreplace = NULL;
>   
> -			if (!need_recover && !need_replace) {
> +			if (!need_recover && !mreplace) {
>   				rcu_read_unlock();
>   				continue;
>   			}
> @@ -3470,8 +3469,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				rcu_read_unlock();
>   				continue;
>   			}
> -			if (mreplace && test_bit(Faulty, &mreplace->flags))
> -				mreplace = NULL;
>   			/* Unless we are doing a full sync, or a replacement
>   			 * we only need to recover the block if it is set in
>   			 * the bitmap
> @@ -3594,11 +3591,11 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				bio = r10_bio->devs[1].repl_bio;
>   				if (bio)
>   					bio->bi_end_io = NULL;
> -				/* Note: if need_replace, then bio
> +				/* Note: if replace is not NULL, then bio
>   				 * cannot be NULL as r10buf_pool_alloc will
>   				 * have allocated it.
>   				 */
> -				if (!need_replace)
> +				if (!mreplace)
>   					break;
>   				bio->bi_next = biolist;
>   				biolist = bio;
> 

