Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3574AD81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjGGJGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGGJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:06:17 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699E11FFF;
        Fri,  7 Jul 2023 02:06:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qy6vN5XVwz4f3npx;
        Fri,  7 Jul 2023 17:06:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbGB1adkSIigNQ--.60410S3;
        Fri, 07 Jul 2023 17:06:10 +0800 (CST)
Subject: Re: [PATCH -next v2 2/2] md/raid5-cache: fix null-ptr-deref in
 r5l_reclaim_thread()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, logang@deltatee.com, hch@lst.de, shli@fb.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawwe.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230628010756.70649-1-yukuai1@huaweicloud.com>
 <20230628010756.70649-3-yukuai1@huaweicloud.com>
 <CAPhsuW500i9LEcSsAchje46b2maKdj4EVaefPtinZfdP+AqELw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e5d746d0-1d42-3d60-450b-2450f24f0915@huaweicloud.com>
Date:   Fri, 7 Jul 2023 17:06:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW500i9LEcSsAchje46b2maKdj4EVaefPtinZfdP+AqELw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbGB1adkSIigNQ--.60410S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuF4xGF1fGw1fWrWrGrg_yoWrArWfpF
        s3tay3Ww4kZryfAFnFqr1DuF9Yvw4j9r97Gr45C3WIyr4qqryUJFy7C3yUur98AFWUCryf
        Xr45tF93WrnrtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/07 16:52, Song Liu 写道:
> On Wed, Jun 28, 2023 at 9:08 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> r5l_reclaim_thread() already check that 'conf->log' is not NULL in the
>> beginning, however, r5c_do_reclaim() and r5l_do_reclaim() will
>> dereference 'conf->log' again, which will cause null-ptr-deref if
>> 'conf->log' is set to NULL from r5l_exit_log() concurrently.
> 
> r5l_exit_log() will wait until reclaim_thread() finishes, and then set
> conf->log to NULL. So this is not a problem, no?

Patch one just revert this, wait until reclaim_thread() then set
conf->log to NULL will cause deadlock, as I sescribled in patch 0.

Thanks,
Kuai
> 
> Thanks,
> Song
> 
>>
>> Fix this problem by don't dereference 'conf->log' again in
>> r5c_do_reclaim() and r5c_do_reclaim().
>>
>> Fixes: a39f7afde358 ("md/r5cache: write-out phase and reclaim support")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid5-cache.c | 20 ++++++++------------
>>   1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
>> index 083288e36949..ba6fc146d265 100644
>> --- a/drivers/md/raid5-cache.c
>> +++ b/drivers/md/raid5-cache.c
>> @@ -1148,10 +1148,9 @@ static void r5l_run_no_space_stripes(struct r5l_log *log)
>>    * for write through mode, returns log->next_checkpoint
>>    * for write back, returns log_start of first sh in stripe_in_journal_list
>>    */
>> -static sector_t r5c_calculate_new_cp(struct r5conf *conf)
>> +static sector_t r5c_calculate_new_cp(struct r5l_log *log)
>>   {
>>          struct stripe_head *sh;
>> -       struct r5l_log *log = conf->log;
>>          sector_t new_cp;
>>          unsigned long flags;
>>
>> @@ -1159,12 +1158,12 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
>>                  return log->next_checkpoint;
>>
>>          spin_lock_irqsave(&log->stripe_in_journal_lock, flags);
>> -       if (list_empty(&conf->log->stripe_in_journal_list)) {
>> +       if (list_empty(&log->stripe_in_journal_list)) {
>>                  /* all stripes flushed */
>>                  spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
>>                  return log->next_checkpoint;
>>          }
>> -       sh = list_first_entry(&conf->log->stripe_in_journal_list,
>> +       sh = list_first_entry(&log->stripe_in_journal_list,
>>                                struct stripe_head, r5c);
>>          new_cp = sh->log_start;
>>          spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
>> @@ -1173,10 +1172,8 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
>>
>>   static sector_t r5l_reclaimable_space(struct r5l_log *log)
>>   {
>> -       struct r5conf *conf = log->rdev->mddev->private;
>> -
>>          return r5l_ring_distance(log, log->last_checkpoint,
>> -                                r5c_calculate_new_cp(conf));
>> +                                r5c_calculate_new_cp(log));
>>   }
>>
>>   static void r5l_run_no_mem_stripe(struct r5l_log *log)
>> @@ -1419,9 +1416,9 @@ void r5c_flush_cache(struct r5conf *conf, int num)
>>          }
>>   }
>>
>> -static void r5c_do_reclaim(struct r5conf *conf)
>> +static void r5c_do_reclaim(struct r5l_log *log)
>>   {
>> -       struct r5l_log *log = conf->log;
>> +       struct r5conf *conf = log->rdev->mddev->private;
>>          struct stripe_head *sh;
>>          int count = 0;
>>          unsigned long flags;
>> @@ -1496,7 +1493,6 @@ static void r5c_do_reclaim(struct r5conf *conf)
>>
>>   static void r5l_do_reclaim(struct r5l_log *log)
>>   {
>> -       struct r5conf *conf = log->rdev->mddev->private;
>>          sector_t reclaim_target = xchg(&log->reclaim_target, 0);
>>          sector_t reclaimable;
>>          sector_t next_checkpoint;
>> @@ -1525,7 +1521,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
>>                                      log->io_list_lock);
>>          }
>>
>> -       next_checkpoint = r5c_calculate_new_cp(conf);
>> +       next_checkpoint = r5c_calculate_new_cp(log);
>>          spin_unlock_irq(&log->io_list_lock);
>>
>>          if (reclaimable == 0 || !write_super)
>> @@ -1554,7 +1550,7 @@ static void r5l_reclaim_thread(struct md_thread *thread)
>>
>>          if (!log)
>>                  return;
>> -       r5c_do_reclaim(conf);
>> +       r5c_do_reclaim(log);
>>          r5l_do_reclaim(log);
>>   }
>>
>> --
>> 2.39.2
>>
> .
> 

