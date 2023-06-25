Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1EC73CDEE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFYCGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjFYCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:06:38 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7D124;
        Sat, 24 Jun 2023 19:06:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QpZ8l28xFz4f3q3c;
        Sun, 25 Jun 2023 10:06:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7MmoZdkMJvjMQ--.32219S3;
        Sun, 25 Jun 2023 10:06:32 +0800 (CST)
Subject: Re: [PATCH] md/raid1: prioritize adding disk to 'removed' mirror
To:     linan666@huaweicloud.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230623172525.2513235-1-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d02d4a53-84ed-cb65-b0d8-2a199bc068cd@huaweicloud.com>
Date:   Sun, 25 Jun 2023 10:06:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230623172525.2513235-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7MmoZdkMJvjMQ--.32219S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF17WrWDtryrur47XFyUAwb_yoW8ZFy8pa
        naqasxGF4UAr129r17JFWDCasavws2qF4kGFyfWw1Y9FZIqrWrG3y8KFW5Jr1DAFW8Aw15
        tF1akrZ8ta4j9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/24 1:25, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> New disk should be added to "removed" position first instead of to be a
> replacement. Commit 6090368abcb4 ("md/raid10: prioritize adding disk to
> 'removed' mirror") has fixed this issue for raid10. This patch fixes raid1.

This commit message "This patch ..." shound use imperative mood, other
than that, this patch LGTM.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid1.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 68a9e2d9985b..320bede4bfab 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1782,7 +1782,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   {
>   	struct r1conf *conf = mddev->private;
>   	int err = -EEXIST;
> -	int mirror = 0;
> +	int mirror = 0, repl_slot = -1;
>   	struct raid1_info *p;
>   	int first = 0;
>   	int last = conf->raid_disks - 1;
> @@ -1825,17 +1825,21 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   			break;
>   		}
>   		if (test_bit(WantReplacement, &p->rdev->flags) &&
> -		    p[conf->raid_disks].rdev == NULL) {
> -			/* Add this device as a replacement */
> -			clear_bit(In_sync, &rdev->flags);
> -			set_bit(Replacement, &rdev->flags);
> -			rdev->raid_disk = mirror;
> -			err = 0;
> -			conf->fullsync = 1;
> -			rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
> -			break;
> -		}
> +		    p[conf->raid_disks].rdev == NULL && repl_slot < 0)
> +			repl_slot = mirror;
>   	}
> +
> +	if (err && repl_slot >= 0) {
> +		/* Add this device as a replacement */
> +		p = conf->mirrors + repl_slot;
> +		clear_bit(In_sync, &rdev->flags);
> +		set_bit(Replacement, &rdev->flags);
> +		rdev->raid_disk = repl_slot;
> +		err = 0;
> +		conf->fullsync = 1;
> +		rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
> +	}
> +
>   	print_conf(conf);
>   	return err;
>   }
> 

