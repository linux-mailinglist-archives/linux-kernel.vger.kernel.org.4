Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260470BF12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjEVNDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjEVNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:03:15 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406492;
        Mon, 22 May 2023 06:03:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPyL66ljXz4f3nJL;
        Mon, 22 May 2023 21:03:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7MPaGtkIaznJw--.59248S3;
        Mon, 22 May 2023 21:03:11 +0800 (CST)
Subject: Re: [PATCH 3/3] md/raid10: fix io loss while replacement replace rdev
To:     linan666@huaweicloud.com, song@kernel.org, shli@fb.com,
        allenpeng@synology.com, alexwu@synology.com,
        bingjingc@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
 <20230522115449.2203939-4-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <28234b54-f7b1-0cd7-8955-a8ec64bc0212@huaweicloud.com>
Date:   Mon, 22 May 2023 21:03:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230522115449.2203939-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7MPaGtkIaznJw--.59248S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17Gw45WF13GFWDZr4Dtwb_yoW5JrWfpF
        4Dt3W5ZryUJwsFkFnxAF4DJa4S9rZ7tFs5Jr9xW343ua1rtrW8Cry7GrW3Zrs8ZFZ8WryY
        q3W3Kws3C3W2gFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/22 19:54, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> When we remove a disk which has replacement, first set rdev to NULL
> and then set replacement to rdev, finally set replacement to NULL (see
> raid10_remove_disk()). If io is submitted during the same time, it might
> read both rdev and replacement as NULL, and io will not be submitted.
> 
>    rdev -> NULL
> 			read rdev
>    replacement -> NULL
> 			read replacement
> 
> Fix it by reading replacement first and rdev later, meanwhile, use smp_mb()
> to prevent memory reordering.

Looks good, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Fixes: 475b0321a4df ("md/raid10: writes should get directed to replacement as well as original.")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 70cc87c7ee57..25a5a7b1e95c 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -779,8 +779,16 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>   		disk = r10_bio->devs[slot].devnum;
>   		rdev = rcu_dereference(conf->mirrors[disk].replacement);
>   		if (rdev == NULL || test_bit(Faulty, &rdev->flags) ||
> -		    r10_bio->devs[slot].addr + sectors > rdev->recovery_offset)
> +		    r10_bio->devs[slot].addr + sectors >
> +		    rdev->recovery_offset) {
> +			/*
> +			 * Read replacement first to prevent reading both rdev
> +			 * and replacement as NULL during replacement replace
> +			 * rdev.
> +			 */
> +			smp_mb();
>   			rdev = rcu_dereference(conf->mirrors[disk].rdev);
> +		    }
>   		if (rdev == NULL ||
>   		    test_bit(Faulty, &rdev->flags))
>   			continue;
> @@ -1479,9 +1487,15 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
>   
>   	for (i = 0;  i < conf->copies; i++) {
>   		int d = r10_bio->devs[i].devnum;
> -		struct md_rdev *rdev = rcu_dereference(conf->mirrors[d].rdev);
> -		struct md_rdev *rrdev = rcu_dereference(
> -			conf->mirrors[d].replacement);
> +		struct md_rdev *rdev, *rrdev;
> +
> +		rrdev = rcu_dereference(conf->mirrors[d].replacement);
> +		/*
> +		 * Read replacement first to Prevent reading both rdev and
> +		 * replacement as NULL during replacement replace rdev.
> +		 */
> +		smp_mb();
> +		rdev = rcu_dereference(conf->mirrors[d].rdev);
>   		if (rdev == rrdev)
>   			rrdev = NULL;
>   		if (rdev && (test_bit(Faulty, &rdev->flags)))
> 

