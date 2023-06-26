Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6373D5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFZC2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFZC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:28:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29AB1;
        Sun, 25 Jun 2023 19:28:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqBbD054cz4f3nbl;
        Mon, 26 Jun 2023 10:28:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LO395hkXGkxMg--.37238S3;
        Mon, 26 Jun 2023 10:28:08 +0800 (CST)
Subject: Re: [PATCH 1/3] md/raid10: optimize fix_read_error
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <20230623173236.2513554-2-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <292862ac-f0e0-6068-eb16-511a01f185b2@huaweicloud.com>
Date:   Mon, 26 Jun 2023 10:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230623173236.2513554-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LO395hkXGkxMg--.37238S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfCw1DXr43tF4kJF1DKFg_yoW5ZryUpF
        WDua4FvrWDJFyUZF17tFWDC3ZYy34fGFWUKr4rt34fWw1Skr9xKF18Wryavr1kJF93uw17
        Zas8ursrCFs7tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/24 1:32, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> We dereference r10_bio->read_slot too many times in fix_read_error().
> Optimize it by using a variable to store read_slot.
> 

Other than a nit below, this patch LGTM.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 381c21f7fb06..94ae294c8a3c 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2725,10 +2725,10 @@ static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
>   static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10bio *r10_bio)
>   {
>   	int sect = 0; /* Offset from r10_bio->sector */
> -	int sectors = r10_bio->sectors;
> +	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
>   	struct md_rdev *rdev;
>   	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
> -	int d = r10_bio->devs[r10_bio->read_slot].devnum;
> +	int d = r10_bio->devs[slot].devnum;
>   
>   	/* still own a reference to this rdev, so it cannot
>   	 * have been cleared recently.
> @@ -2749,13 +2749,13 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
>   			  mdname(mddev), rdev->bdev);
>   		md_error(mddev, rdev);
> -		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
> +		r10_bio->devs[slot].bio = IO_BLOCKED;
>   		return;
>   	}
>   
>   	while(sectors) {
>   		int s = sectors;
> -		int sl = r10_bio->read_slot;
> +		int sl = slot;
>   		int success = 0;
>   		int start;
>   
> @@ -2790,7 +2790,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			sl++;
>   			if (sl == conf->copies)
>   				sl = 0;
> -		} while (!success && sl != r10_bio->read_slot);
> +		} while (!success && sl != slot);
>   		rcu_read_unlock();
>   
>   		if (!success) {
> @@ -2798,16 +2798,16 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			 * as bad on the first device to discourage future
>   			 * reads.
>   			 */
> -			int dn = r10_bio->devs[r10_bio->read_slot].devnum;
> +			int dn = r10_bio->devs[slot].devnum;
>   			rdev = conf->mirrors[dn].rdev;
>   
>   			if (!rdev_set_badblocks(
>   				    rdev,
> -				    r10_bio->devs[r10_bio->read_slot].addr
> +				    r10_bio->devs[slot].addr
>   				    + sect,
>   				    s, 0)) {
>   				md_error(mddev, rdev);
> -				r10_bio->devs[r10_bio->read_slot].bio
> +				r10_bio->devs[slot].bio
>   					= IO_BLOCKED;

There is no need to split lines now.

Thanks,
Kuai
>   			}
>   			break;
> @@ -2816,7 +2816,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   		start = sl;
>   		/* write it back and re-read */
>   		rcu_read_lock();
> -		while (sl != r10_bio->read_slot) {
> +		while (sl != slot) {
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
> @@ -2850,7 +2850,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			rcu_read_lock();
>   		}
>   		sl = start;
> -		while (sl != r10_bio->read_slot) {
> +		while (sl != slot) {
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
> 

