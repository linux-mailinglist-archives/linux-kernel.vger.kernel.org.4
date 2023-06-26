Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95E973D5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFZCmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFZCmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:42:16 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC7F3;
        Sun, 25 Jun 2023 19:42:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqBvN3fywz4f3knj;
        Mon, 26 Jun 2023 10:42:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMA+5hk6icyMg--.7443S3;
        Mon, 26 Jun 2023 10:42:10 +0800 (CST)
Subject: Re: [PATCH 3/3] md/raid10: handle replacement devices in
 fix_read_error
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
 <20230623173236.2513554-4-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <55b4bebc-0e78-92d9-9b0e-5869c6c04479@huaweicloud.com>
Date:   Mon, 26 Jun 2023 10:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230623173236.2513554-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLMA+5hk6icyMg--.7443S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4rtw1ktrW5Zr15XFyDGFg_yoWrJrW3pF
        WDGa4YvrZrJrZrur1UtrWDCa9Y9ryftFWFkr18Aw1xuwn5tr98KF1DGryY9ryUAFZxCr10
        qan0grsrCF9FgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6w
        ZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/24 1:32, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> In fix_read_error(), the handling of replacement devices is missing. If
> read replacement device errors, we will attempt to fix 'mirror->rdev'.
> It is wrong. Get rdev from r10bio to ensure that the fixed device is the
> one which read error occurred.
> 
I'll suggest not to fix read error for replacement, it's better to error
replacement directly instead of setting badblock, like what write does. 
Otherwise, there is risk of losing data after replacement replace rdev.

Thanks,
Kuai

> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index a36e53fce21f..4a7c8eaf6ea0 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2726,15 +2726,10 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   {
>   	int sect = 0; /* Offset from r10_bio->sector */
>   	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
> -	struct md_rdev *rdev;
> +	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
>   	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
>   	int d = r10_bio->devs[slot].devnum;
>   
> -	/* still own a reference to this rdev, so it cannot
> -	 * have been cleared recently.
> -	 */
> -	rdev = conf->mirrors[d].rdev;
> -
>   	if (test_bit(Faulty, &rdev->flags))
>   		/* drive has already been failed, just ignore any
>   		   more fix_read_error() attempts */
> @@ -2763,12 +2758,11 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			s = PAGE_SIZE >> 9;
>   
>   		rcu_read_lock();
> +		rdev = r10_bio->devs[slot].rdev;
>   		do {
>   			sector_t first_bad;
>   			int bad_sectors;
>   
> -			d = r10_bio->devs[sl].devnum;
> -			rdev = rcu_dereference(conf->mirrors[d].rdev);
>   			if (rdev &&
>   			    test_bit(In_sync, &rdev->flags) &&
>   			    !test_bit(Faulty, &rdev->flags) &&
> @@ -2790,6 +2784,8 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			sl++;
>   			if (sl == conf->copies)
>   				sl = 0;
> +			d = r10_bio->devs[sl].devnum;
> +			rdev = rcu_dereference(conf->mirrors[d].rdev);
>   		} while (sl != slot);
>   		rcu_read_unlock();
>   
> @@ -2798,9 +2794,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			 * as bad on the first device to discourage future
>   			 * reads.
>   			 */
> -			int dn = r10_bio->devs[slot].devnum;
> -			rdev = conf->mirrors[dn].rdev;
> -
> +			rdev = r10_bio->devs[slot].rdev;
>   			if (!rdev_set_badblocks(
>   				    rdev,
>   				    r10_bio->devs[slot].addr
> @@ -2820,8 +2814,12 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
> -			d = r10_bio->devs[sl].devnum;
> -			rdev = rcu_dereference(conf->mirrors[d].rdev);
> +			if (sl == slot) {
> +				rdev = r10_bio->devs[slot].rdev;
> +			} else {
> +				d = r10_bio->devs[sl].devnum;
> +				rdev = rcu_dereference(conf->mirrors[d].rdev);
> +			}
>   			if (!rdev ||
>   			    test_bit(Faulty, &rdev->flags) ||
>   			    !test_bit(In_sync, &rdev->flags))
> @@ -2854,8 +2852,12 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   			if (sl==0)
>   				sl = conf->copies;
>   			sl--;
> -			d = r10_bio->devs[sl].devnum;
> -			rdev = rcu_dereference(conf->mirrors[d].rdev);
> +			if (sl == slot) {
> +				rdev = r10_bio->devs[slot].rdev;
> +			} else {
> +				d = r10_bio->devs[sl].devnum;
> +				rdev = rcu_dereference(conf->mirrors[d].rdev);
> +			}
>   			if (!rdev ||
>   			    test_bit(Faulty, &rdev->flags) ||
>   			    !test_bit(In_sync, &rdev->flags))
> 

