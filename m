Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECF73577F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFSNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjFSNAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:00:12 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DD119;
        Mon, 19 Jun 2023 06:00:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ql8xd3QFYz4f3rKQ;
        Mon, 19 Jun 2023 21:00:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rFQUZBkmWM9MA--.52075S3;
        Mon, 19 Jun 2023 21:00:02 +0800 (CST)
Subject: Re: [PATCH] raid10: avoid spin_lock from fastpath from
 raid10_unplug()
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     aligrudi@gmail.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230618142520.14662-1-yukuai1@huaweicloud.com>
 <ac4c9d48-b8d2-b847-2721-11179fd922de@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4c729ee3-ad63-1928-0113-19b576b09b24@huaweicloud.com>
Date:   Mon, 19 Jun 2023 21:00:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ac4c9d48-b8d2-b847-2721-11179fd922de@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rFQUZBkmWM9MA--.52075S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UJFyrKrWkWr4kZF17GFg_yoW5Ww45pa
        yktFWYyrWDuryvqw4DJ3WUZa4Ygw4kt3Zrtr95A3WDXr1jgFyaqr4jqr4q9r4DZrs7GFyU
        Aa15JrykZF1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
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

在 2023/06/19 18:26, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patch. Some minor nits from my side, you can also 
> ignore.
> 
> Am 18.06.23 um 16:25 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 0c0be98bbe67 ("md/raid10: prevent unnecessary calls to wake_up()
>> in fast path") missed one place, for example, while testing with:
> 
> … one place. For example, with
> 
>>
>> fio -direct=1 -rw=write/randwrite -iodepth=1 ...
>>
>> Then plug and unplug will be called for each io, then wake_up() from
> 
> Maybe:
> 
>      fio -direct=1 -rw=write/randwrite -iodepth=1 ...
> 
> plug und unplug are called for each io, then …
> 
>> raid10_unplug() will cause lock contention as well.
> 
> Maybe paste the perf command and output?

Related test and test result and perf result can be found in the below
Link.

By the way, I'll wait for more review to send a v2 to optmize commit
message.

Thanks,
Kuai

> 
>> Avoid this contention by using wake_up_barrier() instead of wake_up(),
>> where spin_lock is not held while waitqueue is empty.
> 
> It’d be great if you added also the test results to the commit message.
> 
>> By the way, in this scenario, each blk_plug_cb() will be allocated and
>> freed for each io, this seems need to be optimized as well.
>>
>> Reported-and-tested-by: Ali Gholami Rudi <aligrudi@gmail.com>
>> Link: https://lore.kernel.org/all/20231606122233@laper.mirepesht/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index d0de8c9fb3cf..fbaaa5e05edc 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -1118,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb 
>> *cb, bool from_schedule)
>>           spin_lock_irq(&conf->device_lock);
>>           bio_list_merge(&conf->pending_bio_list, &plug->pending);
>>           spin_unlock_irq(&conf->device_lock);
>> -        wake_up(&conf->wait_barrier);
>> +        wake_up_barrier(conf);
>>           md_wakeup_thread(mddev->thread);
>>           kfree(plug);
>>           return;
>> @@ -1127,7 +1127,7 @@ static void raid10_unplug(struct blk_plug_cb 
>> *cb, bool from_schedule)
>>       /* we aren't scheduling, so we can do the write-out directly. */
>>       bio = bio_list_get(&plug->pending);
>>       raid1_prepare_flush_writes(mddev->bitmap);
>> -    wake_up(&conf->wait_barrier);
>> +    wake_up_barrier(conf);
>>       while (bio) { /* submit pending writes */
>>           struct bio *next = bio->bi_next;
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
> 
> .
> 

