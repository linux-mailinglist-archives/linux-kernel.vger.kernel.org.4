Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A15B865B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiINK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:28:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681DE7C762;
        Wed, 14 Sep 2022 03:28:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MSGhc64P3zKNZJ;
        Wed, 14 Sep 2022 18:26:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inPBrCFjuFVUAw--.57050S3;
        Wed, 14 Sep 2022 18:28:17 +0800 (CST)
Subject: Re: [PATCH v2 1/4] md/raid10: cleanup wait_barrier()
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
 <20220914014914.398712-2-yukuai1@huaweicloud.com>
 <0b67df9e-7f64-e710-5928-2098ed8d0f2d@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <302127e5-67fa-1ff0-0551-4719005640b8@huaweicloud.com>
Date:   Wed, 14 Sep 2022 18:28:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0b67df9e-7f64-e710-5928-2098ed8d0f2d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inPBrCFjuFVUAw--.57050S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWDWFyxJryUKFWrZw4Utwb_yoW7Xr4xpr
        n5JrWUJryUJrn5Jr1UJr1UAFyUJr18J3WDJr18XF1DJr4UAr1jgr1UXryvgr1UJr48Jr1U
        Jr1UJrnrZr1UJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul

在 2022/09/14 14:36, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for the improved patch. Three minor nits.
> 
> Am 14.09.22 um 03:49 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the summary/title, I’d spell *Clean up* with a space. Maybe even use:
> 
> md/raid10: Factor out code from wait_barrier() to stop_waiting_barrier()

Ok, sounds good, I'll change that in next version.
> 
>> Currently the nasty condition is wait_barrier() is hard to read. This
>> patch factor out the condition into a function.
> 
> The first *is* above can be removed, and factor*s* needs an s.

Yes, you're right.
>> There are no functional changes.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 56 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 32 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 64d6e4cd8a3a..56458a53043d 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -957,44 +957,52 @@ static void lower_barrier(struct r10conf *conf)
>>       wake_up(&conf->wait_barrier);
>>   }
>> +static bool stop_waiting_barrier(struct r10conf *conf)
>> +{
>> +    /* barrier is dropped */
>> +    if (!conf->barrier)
>> +        return true;
>> +
>> +    /*
>> +     * If there are already pending requests (preventing the barrier 
>> from
>> +     * rising completely), and the pre-process bio queue isn't empty, 
>> then
>> +     * don't wait, as we need to empty that queue to get the nr_pending
>> +     * count down.
>> +     */
>> +    if (atomic_read(&conf->nr_pending)) {
>> +        struct bio_list *bio_list = current->bio_list;
>> +
>> +        if (bio_list && (!bio_list_empty(&bio_list[0]) ||
>> +                 !bio_list_empty(&bio_list[1])))
>> +            return true;
>> +    }
>> +
>> +    /* move on if recovery thread is blocked by us */
>> +    if (conf->mddev->thread->tsk == current &&
>> +        test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
>> +        conf->nr_queued > 0)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>>   static bool wait_barrier(struct r10conf *conf, bool nowait)
>>   {
>>       bool ret = true;
>>       spin_lock_irq(&conf->resync_lock);
>>       if (conf->barrier) {
>> -        struct bio_list *bio_list = current->bio_list;
>> -        conf->nr_waiting++;
>> -        /* Wait for the barrier to drop.
>> -         * However if there are already pending
>> -         * requests (preventing the barrier from
>> -         * rising completely), and the
>> -         * pre-process bio queue isn't empty,
>> -         * then don't wait, as we need to empty
>> -         * that queue to get the nr_pending
>> -         * count down.
>> -         */
>>           /* Return false when nowait flag is set */
>>           if (nowait) {
>>               ret = false;
>>           } else {
>> +            conf->nr_waiting++;
>>               raid10_log(conf->mddev, "wait barrier");
>>               wait_event_lock_irq(conf->wait_barrier,
>> -                        !conf->barrier ||
>> -                        (atomic_read(&conf->nr_pending) &&
>> -                         bio_list &&
>> -                         (!bio_list_empty(&bio_list[0]) ||
>> -                          !bio_list_empty(&bio_list[1]))) ||
>> -                         /* move on if recovery thread is
>> -                          * blocked by us
>> -                          */
>> -                         (conf->mddev->thread->tsk == current &&
>> -                          test_bit(MD_RECOVERY_RUNNING,
>> -                               &conf->mddev->recovery) &&
>> -                          conf->nr_queued > 0),
>> +                        stop_waiting_barrier(conf),
>>                           conf->resync_lock);
>> +            conf->nr_waiting--;
>>           }
>> -        conf->nr_waiting--;
>>           if (!conf->nr_waiting)
>>               wake_up(&conf->wait_barrier);
>>       }
> 
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks,
Kuai
> 
> 
> Kind regards,
> 
> Paul
> 
> .
> 

