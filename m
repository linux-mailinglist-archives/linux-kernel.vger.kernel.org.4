Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9613D6B877B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCNBQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNBQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:16:44 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B214A1ED;
        Mon, 13 Mar 2023 18:16:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PbFwj06XMz4f3m6t;
        Tue, 14 Mar 2023 09:16:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyH0yg9k1BaGEw--.43581S3;
        Tue, 14 Mar 2023 09:16:38 +0800 (CST)
Subject: Re: [PATCH v2 1/6] md/raid10: don't call bio_start_io_acct twice for
 bio which experienced read error
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, jgq516@gmail.com, neilb@suse.de,
        shli@fb.com, lzhong@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
 <20230310073855.1337560-2-yukuai1@huaweicloud.com>
 <CAPhsuW5nw0tgVmm-iB++_x2K=dBNSyHNtfpLyKBArn6YZVoteA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6f6172df-7953-078e-1310-eccf0ca4f47b@huaweicloud.com>
Date:   Tue, 14 Mar 2023 09:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5nw0tgVmm-iB++_x2K=dBNSyHNtfpLyKBArn6YZVoteA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyH0yg9k1BaGEw--.43581S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4UKr1UZr4rWF43CF17Jrb_yoW8AF13p3
        ykGFyYvFZ8JayDuw47J34UZrnavayUWrW2yrWfAw13Xw17ZF95JF18GFW0grn5XF95u342
        v3Wq9rWDGr4DtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/14 6:08, Song Liu 写道:
> On Thu, Mar 9, 2023 at 11:39 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> handle_read_error() will resumit r10_bio by raid10_read_request(), which
>> will call bio_start_io_acct() again, while bio_end_io_acct() will only
>> be called once.
>>
>> Fix the problem by don't account io again from handle_read_error().
>>
>> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> 
> I would rather keep same argument lists for raid10_read_request
> and raid10_write_request. How about we do something like this
> instead?
> 
> diff --git i/drivers/md/raid10.c w/drivers/md/raid10.c
> index 6b39e6c7ada3..13f33a8a8fe8 100644
> --- i/drivers/md/raid10.c
> +++ w/drivers/md/raid10.c
> @@ -1248,7 +1248,8 @@ static void raid10_read_request(struct mddev
> *mddev, struct bio *bio,
>          }
>          slot = r10_bio->read_slot;
> 
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> +       if (!r10_bio->start_time &&
> +           blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>                  r10_bio->start_time = bio_start_io_acct(bio);
>          read_bio = bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set);
> 
> @@ -1578,6 +1579,7 @@ static void __make_request(struct mddev *mddev,
> struct bio *bio, int sectors)
>          r10_bio->sector = bio->bi_iter.bi_sector;
>          r10_bio->state = 0;
>          r10_bio->read_slot = -1;
> +       r10_bio->start_time = 0;
>          memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
>                          conf->geo.raid_disks);
> 
> Thanks,
> Song

Of course, this looks better. I'll send a new verison for this patch.

Thanks,
Kuai

