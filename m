Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4AC6B1BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCIG5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCIG5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:57:01 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870C87D87;
        Wed,  8 Mar 2023 22:56:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXKjY6ZvLz4f3jZ2;
        Thu,  9 Mar 2023 14:56:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CEygwlk8ydoEg--.54429S3;
        Thu, 09 Mar 2023 14:56:51 +0800 (CST)
Subject: Re: [PATCH -next] raid10: fix leak of io accounting
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230304070133.1134975-1-yukuai1@huaweicloud.com>
 <a2551c50-feea-bcbe-00ed-802456b5a19f@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <76d32496-641e-c93a-df77-9ce9d9c1a1e1@huaweicloud.com>
Date:   Thu, 9 Mar 2023 14:56:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a2551c50-feea-bcbe-00ed-802456b5a19f@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CEygwlk8ydoEg--.54429S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UKry3ZryDtFWfKw4xCrg_yoW8Zw13pa
        ykJa90yrW5CrWkuw1DJ3yDA3sYvw4Dtay7tFWfA3W3Jr12vr9YqF4UXFWYgrn8XFZ5WF17
        XF1kWrsruFsrtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/09 14:36, Guoqing Jiang 写道:
> Hi,
> 
> What do you mean 'leak' here?

I try to mean that inflight counting is leaked, because it's increased
twice for one io.
> 
> On 3/4/23 15:01, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> handle_read_error() will resumit r10_bio by raid10_read_request(), which
>> will call bio_start_io_acct() again, while bio_end_io_acct() will only
>> be called once.
>>
>> Fix the problem by don't account io again from handle_read_error().
> 
> My understanding is it caused inaccurate io stats for bio which had a read
> error.
> 
>> Fixes: 528bc2cf2fcc ("md/raid10: enable io accounting")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 6c66357f92f5..4f8edb6ea3e2 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -1173,7 +1173,7 @@ static bool regular_request_wait(struct mddev 
>> *mddev, struct r10conf *conf,
>>   }
>>   static void raid10_read_request(struct mddev *mddev, struct bio *bio,
>> -                struct r10bio *r10_bio)
>> +                struct r10bio *r10_bio, bool handle_error)
>>   {
>>       struct r10conf *conf = mddev->private;
>>       struct bio *read_bio;
>> @@ -1244,7 +1244,7 @@ static void raid10_read_request(struct mddev 
>> *mddev, struct bio *bio,
>>       }
>>       slot = r10_bio->read_slot;
>> -    if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>> +    if (!handle_error && 
>> blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
>>           r10_bio->start_time = bio_start_io_acct(bio);
> 
> I think a simpler way is just check R10BIO_ReadError here.

No, I'm afraid this is incorrect because handle_read_error clears the
state before resubmiting the r10bio.

Thanks,
Kuai
> 
> Thanks,
> Guoqing
> .
> 

