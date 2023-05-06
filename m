Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E557F6F8DD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEFCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFCCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:02:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203B5B8A;
        Fri,  5 May 2023 19:02:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QCrRB5L2fz4f3pF9;
        Sat,  6 May 2023 10:02:30 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLA3tVVk3P5mIw--.60188S3;
        Sat, 06 May 2023 10:02:31 +0800 (CST)
Subject: Re: [PATCH v2 3/4] md/raid10: fix wrong setting of
 max_corr_read_errors
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-4-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ddec947c-d2b9-e4fe-30e6-02c76f162ab3@huaweicloud.com>
Date:   Sat, 6 May 2023 10:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230506012315.3370489-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLA3tVVk3P5mIw--.60188S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xWrWDKr4rXw18AryrWFg_yoW8tw48pa
        ykAas8Zr1UA34UAasrJFyDua4FywnYyayjyryrAw4fXa4fGr98K3W8Gayqgr1kWF1ft3W3
        XFWDKrZrCa1UtFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
> max_corr_read_errors should not be negative number. Change it to
> unsigned int where use it.
> 

Looks good, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c     | 2 +-
>   drivers/md/raid10.c | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index fd5c3babcd6d..4a1e566d6bdc 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4486,7 +4486,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_stor
>   
>   static ssize_t
>   max_corrected_read_errors_show(struct mddev *mddev, char *page) {
> -	return sprintf(page, "%d\n",
> +	return sprintf(page, "%u\n",
>   		       atomic_read(&mddev->max_corr_read_errors));
>   }
>   
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..4d615fcc6a50 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2727,7 +2727,8 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   	int sect = 0; /* Offset from r10_bio->sector */
>   	int sectors = r10_bio->sectors;
>   	struct md_rdev *rdev;
> -	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
> +	unsigned int max_read_errors =
> +			atomic_read(&mddev->max_corr_read_errors);
>   	int d = r10_bio->devs[r10_bio->read_slot].devnum;
>   
>   	/* still own a reference to this rdev, so it cannot
> @@ -2743,7 +2744,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   	check_decay_read_errors(mddev, rdev);
>   	atomic_inc(&rdev->read_errors);
>   	if (atomic_read(&rdev->read_errors) > max_read_errors) {
> -		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
> +		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
>   			  mdname(mddev), rdev->bdev,
>   			  atomic_read(&rdev->read_errors), max_read_errors);
>   		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> 

