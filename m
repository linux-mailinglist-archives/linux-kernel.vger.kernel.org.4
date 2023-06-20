Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDF736D81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjFTNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjFTNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:39:09 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7E173B;
        Tue, 20 Jun 2023 06:38:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qlnl20n7Yz4f3mWj;
        Tue, 20 Jun 2023 21:38:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZS9q5FklceJMA--.2039S3;
        Tue, 20 Jun 2023 21:38:06 +0800 (CST)
Subject: Re: [PATCH -next 4/8] md/raid1: switch to use md_account_bio() for io
 accounting
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230619204826.755559-1-yukuai1@huaweicloud.com>
 <20230619204826.755559-5-yukuai1@huaweicloud.com>
 <CALTww28AYb3Gi0qKHqsRuFrS0_P9-Fo1BYhsvTsrTFKnu084SA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ae66036a-0673-297a-69b8-81721d6b8efc@huaweicloud.com>
Date:   Tue, 20 Jun 2023 21:38:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww28AYb3Gi0qKHqsRuFrS0_P9-Fo1BYhsvTsrTFKnu084SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZS9q5FklceJMA--.2039S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy3Xr1xAF13CryfZw4fKrg_yoW5Cry3pa
        1DGFWrCFWrJayj93sFqa47uF1Fyw4FgFy8CrWI9w17ZFnIqF90ga18WFWFgr1kAF93GFy7
        t3WvkFsruF47tFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
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

在 2023/06/20 17:07, Xiao Ni 写道:
> On Mon, Jun 19, 2023 at 8:49 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Two problems can be fixed this way:
>>
>> 1) 'active_io' will represent inflight io instead of io that is
>> dispatching.
>>
>> 2) If io accounting is enabled or disabled while io is still inflight,
>> bio_start_io_acct() and bio_end_io_acct() is not balanced and io
>> inflight counter will be leaked.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid1.c | 14 ++++++--------
>>   drivers/md/raid1.h |  1 -
>>   2 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index dd25832eb045..06fa1580501f 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -304,8 +304,6 @@ static void call_bio_endio(struct r1bio *r1_bio)
>>          if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
>>                  bio->bi_status = BLK_STS_IOERR;
>>
>> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> -               bio_end_io_acct(bio, r1_bio->start_time);
>>          bio_endio(bio);
>>   }
>>
>> @@ -1303,10 +1301,10 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
>>          }
>>
>>          r1_bio->read_disk = rdisk;
>> -
>> -       if (!r1bio_existed && blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> -               r1_bio->start_time = bio_start_io_acct(bio);
>> -
>> +       if (!r1bio_existed) {
>> +               md_account_bio(mddev, &bio);
>> +               r1_bio->master_bio = bio;
>> +       }
>>          read_bio = bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
>>                                     &mddev->bio_set);
>>
>> @@ -1500,8 +1498,8 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
>>                  r1_bio->sectors = max_sectors;
>>          }
>>
>> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> -               r1_bio->start_time = bio_start_io_acct(bio);
>> +       md_account_bio(mddev, &bio);
>> +       r1_bio->master_bio = bio;
>>          atomic_set(&r1_bio->remaining, 1);
>>          atomic_set(&r1_bio->behind_remaining, 0);
>>
>> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
>> index 468f189da7a0..14d4211a123a 100644
>> --- a/drivers/md/raid1.h
>> +++ b/drivers/md/raid1.h
>> @@ -157,7 +157,6 @@ struct r1bio {
>>          sector_t                sector;
>>          int                     sectors;
>>          unsigned long           state;
>> -       unsigned long           start_time;
>>          struct mddev            *mddev;
>>          /*
>>           * original bio going to /dev/mdx
>> --
>> 2.39.2
>>
> 
> Hi Kuai
> 
> After this patch, raid1 will have one more memory allocation in the
> I/O path. Not sure if it can affect performance. Beside this, the
> patch is good for me.

Yes, I'm aware of this additional memory allocation, however, raid1(and
similar to other levels) already need to allocate r1bio and some bios(1
for read, and copies for write), so this is not a none -> new case,
it's just a allocate 2 -> allocate 3 case.

I think performance under memory pressure are both bad with or without
this patch, and one one bio clone latency without memory reclaim should
be fine.

Thanks,
Kuai
> 
> Reviewed-by: Xiao Ni <xni@redhat.com>
> 
> .
> 

