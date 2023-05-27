Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DA71318F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbjE0BlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjE0BlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:41:19 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C96DF;
        Fri, 26 May 2023 18:41:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QSkyx1D6Cz4f3khL;
        Sat, 27 May 2023 09:41:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLO5X3FkxzUvKQ--.43805S3;
        Sat, 27 May 2023 09:41:14 +0800 (CST)
Subject: Re: [PATCH v2 2/4] md/raid10: improve code of mrdev in
 raid10_sync_request
To:     linan666@huaweicloud.com, song@kernel.org, bingjingc@synology.com,
        allenpeng@synology.com, alexwu@synology.com, shli@fb.com,
        neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230526074551.669792-1-linan666@huaweicloud.com>
 <20230526074551.669792-3-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a9a6bf58-65c2-9f8d-3ab1-c7722f55b25e@huaweicloud.com>
Date:   Sat, 27 May 2023 09:41:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230526074551.669792-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLO5X3FkxzUvKQ--.43805S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW3Jw1xAr43JFyUuw45Wrg_yoW5CF48p3
        y3tFySyry7J3yUGw1DA3WDuF1SvrZ7tFWjkr43G34fW3sIgryDuFyrWFW5Xr1qvFWrXw15
        Xw1DXws8Ca4IqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

ÔÚ 2023/05/26 15:45, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> 'need_recover' and 'mrdev' are equivalent in raid10_sync_request(), and
> inc mrdev->nr_pending is unreasonable if don't need recovery. Replace
> 'need_recover' with 'mrdev', and only inc nr_pending when needed.

LGTM, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Suggested-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index e21502c03b45..9de9eabff209 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3437,7 +3437,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   			sector_t sect;
>   			int must_sync;
>   			int any_working;
> -			int need_recover = 0;
>   			struct raid10_info *mirror = &conf->mirrors[i];
>   			struct md_rdev *mrdev, *mreplace;
>   
> @@ -3446,14 +3445,14 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   			mreplace = rcu_dereference(mirror->replacement);
>   
>   			if (mrdev != NULL &&
> -			    !test_bit(Faulty, &mrdev->flags) &&
> -			    !test_bit(In_sync, &mrdev->flags))
> -				need_recover = 1;
> +			    (test_bit(Faulty, &mrdev->flags) ||
> +			    test_bit(In_sync, &mrdev->flags)))
> +				mrdev = NULL;
>   			if (mreplace != NULL &&
>   			    test_bit(Faulty, &mreplace->flags))
>   				mreplace = NULL;
>   
> -			if (!need_recover && !mreplace) {
> +			if (!mrdev && !mreplace) {
>   				rcu_read_unlock();
>   				continue;
>   			}
> @@ -3487,7 +3486,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				rcu_read_unlock();
>   				continue;
>   			}
> -			atomic_inc(&mrdev->nr_pending);
> +			if (mrdev)
> +				atomic_inc(&mrdev->nr_pending);
>   			if (mreplace)
>   				atomic_inc(&mreplace->nr_pending);
>   			rcu_read_unlock();
> @@ -3574,7 +3574,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				r10_bio->devs[1].devnum = i;
>   				r10_bio->devs[1].addr = to_addr;
>   
> -				if (need_recover) {
> +				if (mrdev) {
>   					bio = r10_bio->devs[1].bio;
>   					bio->bi_next = biolist;
>   					biolist = bio;
> @@ -3619,7 +3619,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   					for (k = 0; k < conf->copies; k++)
>   						if (r10_bio->devs[k].devnum == i)
>   							break;
> -					if (!test_bit(In_sync,
> +					if (mrdev && !test_bit(In_sync,
>   						      &mrdev->flags)
>   					    && !rdev_set_badblocks(
>   						    mrdev,
> @@ -3645,12 +3645,14 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   				if (rb2)
>   					atomic_dec(&rb2->remaining);
>   				r10_bio = rb2;
> -				rdev_dec_pending(mrdev, mddev);
> +				if (mrdev)
> +					rdev_dec_pending(mrdev, mddev);
>   				if (mreplace)
>   					rdev_dec_pending(mreplace, mddev);
>   				break;
>   			}
> -			rdev_dec_pending(mrdev, mddev);
> +			if (mrdev)
> +				rdev_dec_pending(mrdev, mddev);
>   			if (mreplace)
>   				rdev_dec_pending(mreplace, mddev);
>   			if (r10_bio->devs[0].bio->bi_opf & MD_FAILFAST) {
> 

