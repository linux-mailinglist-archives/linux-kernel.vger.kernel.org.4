Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF2372A875
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjFJCc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjFJCc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:32:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846AE35B5;
        Fri,  9 Jun 2023 19:32:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QdMS25FF1z4f3l2C;
        Sat, 10 Jun 2023 10:32:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK_S4INkrTpkLQ--.11723S3;
        Sat, 10 Jun 2023 10:32:51 +0800 (CST)
Subject: Re: [PATCH] md/raid10: Only check QUEUE_FLAG_IO_STAT when issuing io
To:     linan666@huaweicloud.com, song@kernel.org, jgq516@gmail.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230609094320.2397604-1-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8d2134a6-90dc-822b-52ef-cd7cc8060b36@huaweicloud.com>
Date:   Sat, 10 Jun 2023 10:32:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230609094320.2397604-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK_S4INkrTpkLQ--.11723S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13tFWDGFW3Gry8XrWrKrg_yoW8CrW7p3
        9rCw1Fq3y5Wa12kFyqgayDGa4rKa9FkrW0yrn7J3yUXa4avry2k3WqqFZ0gr1kGrZ3CFW2
        qF109anrGa90yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
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

ÔÚ 2023/06/09 17:43, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> /sys/block/[device]/queue/iostats is used to control whether to count io
> stat. Write 0 to it will clear queue_flags QUEUE_FLAG_IO_STAT which means
> iostats is disabled. If we disable iostats and later endable it, the io
> issued during this period will be counted incorrectly, inflight will be
> decreased to -1.
> 
>    //T1 set iostats
>    echo 0 > /sys/block/md0/queue/iostats
>     clear QUEUE_FLAG_IO_STAT
> 
> 			//T2 issue io
> 			if (QUEUE_FLAG_IO_STAT) -> false
> 			 bio_start_io_acct
> 			  inflight++
> 
>    echo 1 > /sys/block/md0/queue/iostats
>     set QUEUE_FLAG_IO_STAT
> 
> 					//T3 io end
> 					if (QUEUE_FLAG_IO_STAT) -> true
> 					 bio_end_io_acct
> 					  inflight--	-> -1
> 
> Also, if iostats is enabled while issuing io but disabled while io end,
> inflight will never be decreased.
> 
> Fix it by checking start_time when io end. Only check QUEUE_FLAG_IO_STAT
> while issuing io, just like request based devices.
> 
> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 381c21f7fb06..bf9dca5c25c3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -325,7 +325,7 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
>   	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
>   		bio->bi_status = BLK_STS_IOERR;
>   
> -	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> +	if (r10_bio->start_time)
>   		bio_end_io_acct(bio, r10_bio->start_time);

This patch LGTM, can you change this for raid1 as well? raid0 and
raid456 is using md_account_bio(), and they don't have such problem.

Thanks,
Kuai
>   	bio_endio(bio);
>   	/*
> 

