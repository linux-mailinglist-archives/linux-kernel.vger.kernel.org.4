Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5F772F227
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjFNBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFNBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:48:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219CCA;
        Tue, 13 Jun 2023 18:48:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgpHM04h8z4f3w3w;
        Wed, 14 Jun 2023 09:48:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLB6HIlk7TudLg--.34871S3;
        Wed, 14 Jun 2023 09:48:43 +0800 (CST)
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor
 idle/frozen_sync_thread() to fix deadlock
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com>
 <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com>
Date:   Wed, 14 Jun 2023 09:48:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLB6HIlk7TudLg--.34871S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5Xw48ur1fZr4fGr4rZrb_yoW3CF1fp3
        yktF98ArW5Cws3Xr1Ut3WDuFyrXw1Uta4DtryfWa47Jrs8ur42qF1Uur1jgFyDA3yfGr4U
        Jw1rXFZ3ZF17Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
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

在 2023/06/13 22:50, Xiao Ni 写道:
> 
> 在 2023/5/29 下午9:20, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test found a following deadlock in raid10:
>>
>> 1) Issue a normal write, and such write failed:
>>
>>    raid10_end_write_request
>>     set_bit(R10BIO_WriteError, &r10_bio->state)
>>     one_write_done
>>      reschedule_retry
>>
>>    // later from md thread
>>    raid10d
>>     handle_write_completed
>>      list_add(&r10_bio->retry_list, &conf->bio_end_io_list)
>>
>>    // later from md thread
>>    raid10d
>>     if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>>      list_move(conf->bio_end_io_list.prev, &tmp)
>>      r10_bio = list_first_entry(&tmp, struct r10bio, retry_list)
>>      raid_end_bio_io(r10_bio)
>>
>> Dependency chain 1: normal io is waiting for updating superblock
> 
> Hi Kuai
> 
> It looks like the above situation is more complex. It only needs a 
> normal write and md_write_start needs to
> 
> wait until the metadata is written to member disks, right? If so, it 
> doesn't need to introduce raid10 write failure
> 
> here. I guess, it should be your test case. It's nice, if you can put 
> your test steps in the patch. But for the analysis
> 
> of the deadlock here, it's better to be simple.

Test script can be found here, it's pretty easy to trigger:

https://patchwork.kernel.org/project/linux-raid/patch/20230529132826.2125392-4-yukuai1@huaweicloud.com/

While reviewing the related code, I found that io can only be added to
list bio_end_io_list from handle_write_completed() if such io failed, so
I think io failure is needed to trigger deadlock from daemon thread.

I think the key point is how MD_SB_CHANGE_PENDING is set:

1) raid10_error() and rdev_set_badblocks(), trigger by io failure;
2) raid10_write_request() related to reshape;
3) md_write_start() and md_allow_write(), and mddev->in_sync is set,
however, I was thinking this is not a common case;

1) is used here because it's quite easy to trigger and this is what
we meet in real test. 3) is possible but I will say let's keep 1), I
don't think it's necessary to reporduce this deadlock through another
path again.

Thanks,
Kuai
> 
>>
>> 2) Trigger a recovery:
>>
>>    raid10_sync_request
>>     raise_barrier
>>
>> Dependency chain 2: sync thread is waiting for normal io
>>
>> 3) echo idle/frozen to sync_action:
>>
>>    action_store
>>     mddev_lock
>>      md_unregister_thread
>>       kthread_stop
>>
>> Dependency chain 3: drop 'reconfig_mutex' is waiting for sync thread
>>
>> 4) md thread can't update superblock:
>>
>>    raid10d
>>     md_check_recovery
>>      if (mddev_trylock(mddev))
>>       md_update_sb
>>
>> Dependency chain 4: update superblock is waiting for 'reconfig_mutex'
>>
>> Hence cyclic dependency exist, in order to fix the problem, we must
>> break one of them. Dependency 1 and 2 can't be broken because they are
>> foundation design. Dependency 4 may be possible if it can be guaranteed
>> that no io can be inflight, however, this requires a new mechanism which
>> seems complex. Dependency 3 is a good choice, because idle/frozen only
>> requires sync thread to finish, which can be done asynchronously that is
>> already implemented, and 'reconfig_mutex' is not needed anymore.
>>
>> This patch switch 'idle' and 'frozen' to wait sync thread to be done
>> asynchronously, and this patch also add a sequence counter to record how
>> many times sync thread is done, so that 'idle' won't keep waiting on new
>> started sync thread.
> 
> In the patch, sync_seq is added in md_reap_sync_thread. In 
> idle_sync_thread, if sync_seq isn't equal
> 
> mddev->sync_seq, it should mean there is someone that stops the sync 
> thread already, right? Why do
> 
> you say 'new started sync thread' here?
> 
> Regards
> 
> Xiao
> 
> 
>>
>> Noted that raid456 has similiar deadlock([1]), and it's verified[2] this
>> deadlock can be fixed by this patch as well.
>>
>> [1] 
>> https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t 
>>
>> [2] 
>> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/ 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 23 +++++++++++++++++++----
>>   drivers/md/md.h |  2 ++
>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 63a993b52cd7..7912de0e4d12 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -652,6 +652,7 @@ void mddev_init(struct mddev *mddev)
>>       timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
>>       atomic_set(&mddev->active, 1);
>>       atomic_set(&mddev->openers, 0);
>> +    atomic_set(&mddev->sync_seq, 0);
>>       spin_lock_init(&mddev->lock);
>>       atomic_set(&mddev->flush_pending, 0);
>>       init_waitqueue_head(&mddev->sb_wait);
>> @@ -4776,19 +4777,27 @@ static void stop_sync_thread(struct mddev *mddev)
>>       if (work_pending(&mddev->del_work))
>>           flush_workqueue(md_misc_wq);
>> -    if (mddev->sync_thread) {
>> -        set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> -        md_reap_sync_thread(mddev);
>> -    }
>> +    set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> +    /*
>> +     * Thread might be blocked waiting for metadata update which will 
>> now
>> +     * never happen
>> +     */
>> +    md_wakeup_thread_directly(mddev->sync_thread);
>>       mddev_unlock(mddev);
>>   }
>>   static void idle_sync_thread(struct mddev *mddev)
>>   {
>> +    int sync_seq = atomic_read(&mddev->sync_seq);
>> +
>>       mutex_lock(&mddev->sync_mutex);
>>       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>       stop_sync_thread(mddev);
>> +
>> +    wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
>> +            !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> +
>>       mutex_unlock(&mddev->sync_mutex);
>>   }
>> @@ -4797,6 +4806,10 @@ static void frozen_sync_thread(struct mddev 
>> *mddev)
>>       mutex_init(&mddev->delete_mutex);
>>       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>       stop_sync_thread(mddev);
>> +
>> +    wait_event(resync_wait, mddev->sync_thread == NULL &&
>> +            !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> +
>>       mutex_unlock(&mddev->sync_mutex);
>>   }
>> @@ -9472,6 +9485,8 @@ void md_reap_sync_thread(struct mddev *mddev)
>>       /* resync has finished, collect result */
>>       md_unregister_thread(&mddev->sync_thread);
>> +    atomic_inc(&mddev->sync_seq);
>> +
>>       if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
>>           !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
>>           mddev->degraded != mddev->raid_disks) {
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 2fa903de5bd0..7cab9c7c45b8 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -539,6 +539,8 @@ struct mddev {
>>       /* Used to synchronize idle and frozen for action_store() */
>>       struct mutex            sync_mutex;
>> +    /* The sequence number for sync thread */
>> +    atomic_t sync_seq;
>>       bool    has_superblocks:1;
>>       bool    fail_last_dev:1;
> 
> -- 
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel

