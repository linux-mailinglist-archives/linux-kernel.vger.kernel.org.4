Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DD6EECDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 05:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbjDZD5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 23:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDZD5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 23:57:39 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95D187;
        Tue, 25 Apr 2023 20:57:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5lSY0LR1z4f6Rdv;
        Wed, 26 Apr 2023 11:57:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAsoUhkg+SsIA--.31415S3;
        Wed, 26 Apr 2023 11:57:34 +0800 (CST)
Subject: Re: [PATCH -next v7 5/5] md: protect md_thread with rcu
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
 <20230425115256.3663932-6-yukuai1@huaweicloud.com>
 <CAPhsuW4_tDcmPZbo8Qs32LRxLAQfE6SNNTDys8bOoeHwx-1N=A@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <059a8c6a-628f-ed18-0d5e-7ad3cad93813@huaweicloud.com>
Date:   Wed, 26 Apr 2023 11:57:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4_tDcmPZbo8Qs32LRxLAQfE6SNNTDys8bOoeHwx-1N=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAsoUhkg+SsIA--.31415S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1DJw45Kw47Zr1UJw1fJFb_yoW8tr43pa
        yfJFW3uFyjkFsrurWaqa4Uua4Yyw4IqrWUKry3Z3yfJ34avryaqF4UWFykWFyDZFyfWr43
        tr15tws5GFnYk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/26 11:20, Song Liu 写道:
> On Tue, Apr 25, 2023 at 4:54 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test reports a uaf for 'mddev->sync_thread':
>>
>> T1                      T2
>> md_start_sync
>>   md_register_thread
>>   // mddev->sync_thread is set
>>                          raid1d
>>                           md_check_recovery
>>                            md_reap_sync_thread
>>                             md_unregister_thread
>>                              kfree
>>
>>   md_wakeup_thread
>>    wake_up
>>    ->sync_thread was freed
>>
>> Root cause is that there is a small windown between register thread and
>> wake up thread, where the thread can be freed concurrently.
>>
>> Currently, a global spinlock 'pers_lock' is borrowed to protect
>> 'mddev->thread', this problem can be fixed likewise, however, there are
>> similar problems elsewhere, and use a global lock for all the cases is
>> not good.
>>
>> This patch protect all md_thread with rcu.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-cgroup.c        |  3 ++
>>   drivers/md/md-bitmap.c    | 10 ++++--
>>   drivers/md/md-cluster.c   | 17 ++++++----
>>   drivers/md/md-multipath.c |  4 +--
>>   drivers/md/md.c           | 69 ++++++++++++++++++---------------------
>>   drivers/md/md.h           |  8 ++---
>>   drivers/md/raid1.c        |  7 ++--
>>   drivers/md/raid1.h        |  2 +-
>>   drivers/md/raid10.c       | 20 +++++++-----
>>   drivers/md/raid10.h       |  2 +-
>>   drivers/md/raid5-cache.c  | 22 ++++++++-----
>>   drivers/md/raid5.c        | 15 +++++----
>>   drivers/md/raid5.h        |  2 +-
>>   13 files changed, 100 insertions(+), 81 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 1c1ebeb51003..0ecb4cce8af2 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -527,6 +527,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>>          list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>>                  struct blkcg *blkcg = blkg->blkcg;
>>
>> +               if (hlist_unhashed(&blkg->blkcg_node))
>> +                       continue;
>> +
> 
> This change is not related, right?

Yes, it's not related. Sorry that I missed another fix patch into
this...

> 
> I don't think we can rush this change in the 6.4 merge window. Let's
> test it more thoroughly and ship it in the next merge window.

Of course.

Thanks,
Kuai

