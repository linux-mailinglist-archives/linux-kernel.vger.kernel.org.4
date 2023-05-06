Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5496F8DDD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjEFCOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjEFCOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:14:38 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C55B86;
        Fri,  5 May 2023 19:14:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QCrj50TSjz4f3v5B;
        Sat,  6 May 2023 10:14:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLMIuFVkhJhnIw--.19200S3;
        Sat, 06 May 2023 10:14:34 +0800 (CST)
Subject: Re: [PATCH v2 4/4] md/raid10: optimize check_decay_read_errors()
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-5-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <aaece788-8892-1412-793e-b381b33d951b@huaweicloud.com>
Date:   Sat, 6 May 2023 10:14:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230506012315.3370489-5-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLMIuFVkhJhnIw--.19200S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxAF4UZw4rGFWxGrWktFb_yoWrKrW3pa
        n8AasxJr4UJry7ArnrJrWqyasYvrySyayjyryxta1xXwn5Jrn8tFy5GFyjg348Gas8Jw15
        XFZ8Wrs8CF4DKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/06 9:23, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> check_decay_read_errors() is used to handle rdev->read_errors. But
> read_errors is inc and read after check_decay_read_errors() is invoked
> in fix_read_error().
> 
> Put all operations of read_errors into check_decay_read_errors() and
> clean up unnecessary atomic_read of read_errors.
> 
> Suggested-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 66 ++++++++++++++++++++++++---------------------
>   1 file changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4d615fcc6a50..79f94882227d 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2655,39 +2655,53 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
>   }
>   
>   /*
> - * Used by fix_read_error() to decay the per rdev read_errors.
> + * Used by fix_read_error() to decay the per rdev read_errors and check if
> + * read_error > max_read_errors.
>    * We halve the read error count for every hour that has elapsed
>    * since the last recorded read error.
>    *
>    */
> -static void check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
> +static bool check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
>   {
> -	long cur_time_mon;
> +	time64_t cur_time_mon = ktime_get_seconds();
>   	unsigned long hours_since_last;
> -	unsigned int read_errors = atomic_read(&rdev->read_errors);
> -
> -	cur_time_mon = ktime_get_seconds();
> +	unsigned int read_errors;
> +	unsigned int max_read_errors =
> +			atomic_read(&mddev->max_corr_read_errors);
>   
>   	if (rdev->last_read_error == 0) {
>   		/* first time we've seen a read error */
>   		rdev->last_read_error = cur_time_mon;
> -		return;
> -	}

I prefer to use a goto tag here, so that following code doesn't need to
be changed. Other than that, this patch looks good to me.

Thanks,
Kuai
> +	} else {
> +		hours_since_last = (long)(cur_time_mon -
> +				    rdev->last_read_error) / 3600;
>   
> -	hours_since_last = (long)(cur_time_mon -
> -			    rdev->last_read_error) / 3600;
> +		rdev->last_read_error = cur_time_mon;
>   
> -	rdev->last_read_error = cur_time_mon;
> +		/*
> +		 * if hours_since_last is > the number of bits in read_errors
> +		 * just set read errors to 0. We do this to avoid
> +		 * overflowing the shift of read_errors by hours_since_last.
> +		 */
> +		read_errors = atomic_read(&rdev->read_errors);
> +		if (hours_since_last >= 8 * sizeof(read_errors))
> +			atomic_set(&rdev->read_errors, 0);
> +		else
> +			atomic_set(&rdev->read_errors,
> +				   read_errors >> hours_since_last);
> +	}
>   
> -	/*
> -	 * if hours_since_last is > the number of bits in read_errors
> -	 * just set read errors to 0. We do this to avoid
> -	 * overflowing the shift of read_errors by hours_since_last.
> -	 */
> -	if (hours_since_last >= 8 * sizeof(read_errors))
> -		atomic_set(&rdev->read_errors, 0);
> -	else
> -		atomic_set(&rdev->read_errors, read_errors >> hours_since_last);
> +	read_errors = atomic_inc_return(&rdev->read_errors);
> +	if (read_errors > max_read_errors) {
> +		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
> +			  mdname(mddev), rdev->bdev, read_errors, max_read_errors);
> +		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> +			  mdname(mddev), rdev->bdev);
> +		md_error(mddev, rdev);
> +		return false;
> +	}
> +
> +	return true;
>   }
>   
>   static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
> @@ -2727,8 +2741,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   	int sect = 0; /* Offset from r10_bio->sector */
>   	int sectors = r10_bio->sectors;
>   	struct md_rdev *rdev;
> -	unsigned int max_read_errors =
> -			atomic_read(&mddev->max_corr_read_errors);
>   	int d = r10_bio->devs[r10_bio->read_slot].devnum;
>   
>   	/* still own a reference to this rdev, so it cannot
> @@ -2741,15 +2753,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   		   more fix_read_error() attempts */
>   		return;
>   
> -	check_decay_read_errors(mddev, rdev);
> -	atomic_inc(&rdev->read_errors);
> -	if (atomic_read(&rdev->read_errors) > max_read_errors) {
> -		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
> -			  mdname(mddev), rdev->bdev,
> -			  atomic_read(&rdev->read_errors), max_read_errors);
> -		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> -			  mdname(mddev), rdev->bdev);
> -		md_error(mddev, rdev);
> +	if (check_decay_read_errors(mddev, rdev)) {
>   		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
>   		return;
>   	}
> 

