Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207D6F7F80
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjEEJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEEJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:05:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660DD18860;
        Fri,  5 May 2023 02:05:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QCPsD683zz4f3k6T;
        Fri,  5 May 2023 17:05:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLO+xlRkaJ01Iw--.55955S3;
        Fri, 05 May 2023 17:05:03 +0800 (CST)
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com>
 <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
 <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com>
 <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
 <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com>
 <3fc2a539-e4cc-e057-6cf0-da7b3953be6e@linux.dev>
 <3aa073e9-5145-aae2-2201-5ba48c09c693@huaweicloud.com>
 <CAPhsuW7c2b4yYbwNcqKW+TBL=QYEzchnVQ4pDLBT-xoBoTvQmg@mail.gmail.com>
 <9d92a862-e728-5493-52c0-abc634eb6e97@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com>
Date:   Fri, 5 May 2023 17:05:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9d92a862-e728-5493-52c0-abc634eb6e97@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLO+xlRkaJ01Iw--.55955S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1kZr1rAryDGFy3ur1fXrb_yoWxXFyUpF
        y8GF15JrWkAw18Zr4Utw10qFy0vw4UXw1UXryfJF1xJwn8KrW2qFyUZF1j9FZ8Jr4xJw4j
        vay5JFZ3ZrWDArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Song and Guoqing

在 2023/04/06 16:53, Yu Kuai 写道:
> Hi,
> 
> 在 2023/03/29 7:58, Song Liu 写道:
>> On Wed, Mar 22, 2023 at 11:32 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2023/03/23 11:50, Guoqing Jiang 写道:
>>>
>>>> Combined your debug patch with above steps. Seems you are
>>>>
>>>> 1. add delay to action_store, so it can't get lock in time.
>>>> 2. echo "want_replacement"**triggers md_check_recovery which can 
>>>> grab lock
>>>>       to start sync thread.
>>>> 3. action_store finally hold lock to clear RECOVERY_RUNNING in reap 
>>>> sync
>>>> thread.
>>>> 4. Then the new added BUG_ON is invoked since RECOVERY_RUNNING is 
>>>> cleared
>>>>       in step 3.
>>>
>>> Yes, this is exactly what I did.
>>>
>>>> sync_thread can be interrupted once MD_RECOVERY_INTR is set which means
>>>> the RUNNING
>>>> can be cleared, so I am not sure the added BUG_ON is reasonable. And
>>>> change BUG_ON
>>>
>>> I think BUG_ON() is reasonable because only md_reap_sync_thread can
>>> clear it, md_do_sync will exit quictly if MD_RECOVERY_INTR is set, but
>>> md_do_sync should not see that MD_RECOVERY_RUNNING is cleared, otherwise
>>> there is no gurantee that only one sync_thread can be in progress.
>>>
>>>> like this makes more sense to me.
>>>>
>>>> +BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
>>>> +!test_bit(MD_RECOVERY_INTR, &mddev->recovery));
>>>
>>> I think this can be reporduced likewise, md_check_recovery clear
>>> MD_RECOVERY_INTR, and new sync_thread triggered by echo
>>> "want_replacement" won't set this bit.
>>>
>>>>
>>>> I think there might be racy window like you described but it should be
>>>> really small, I prefer
>>>> to just add a few lines like this instead of revert and introduce new
>>>> lock to resolve the same
>>>> issue (if it is).
>>>
>>> The new lock that I add in this patchset is just try to synchronize idle
>>> and forzen from action_store（patch 3), I can drop it if you think this
>>> is not necessary.
>>>
>>> The main changes is patch 4, new lines is not much and I really don't
>>> like to add new flags unless we have to, current code is already hard
>>> to understand...
>>>
>>> By the way, I'm concerned that drop the mutex to unregister sync_thread
>>> might not be safe, since the mutex protects lots of stuff, and there
>>> might exist other implicit dependencies.
>>>
>>>>
>>>> TBH, I am reluctant to see the changes in the series, it can only be
>>>> considered
>>>> acceptable with conditions:
>>>>
>>>> 1. the previous raid456 bug can be fixed in this way too, hopefully 
>>>> Marc
>>>> or others
>>>>       can verify it.

After reading the thread:

https://lore.kernel.org/linux-raid/5ed54ffc-ce82-bf66-4eff-390cb23bc1ac@molgen.mpg.de/T/#t

The deadlock in raid456 has same conditions as raid10:
1) echo idle hold mutex to stop sync thread;
2) sync thread wait for io to complete;
3) io can't be handled by daemon thread because sb flag is set;
4) sb flag can't be cleared because daemon thread can't hold mutex;

I tried to reporduce the deadlock with the reporducer provided in the
thread, howerver, the deadlock is not reporduced after running for more
than a day.

I changed the reporducer to below:

[root@fedora raid5]# cat test_deadlock.sh
#! /bin/bash

(
         while true; do
                 echo check > /sys/block/md0/md/sync_action
                 sleep 0.5
                 echo idle > /sys/block/md0/md/sync_action
         done
) &

echo 0 > /proc/sys/vm/dirty_background_ratio
(
         while true; do
                 fio -filename=/dev/md0 -bs=4k -rw=write -numjobs=1 
-name=xxx
         done
) &

And I finially able to reporduce the deadlock with this patch
reverted(running for about an hour):

[root@fedora raid5]# ps -elf | grep " D " | grep -v grep
1 D root         156       2 16  80   0 -     0 md_wri 06:51 ? 
00:19:15 [kworker/u8:11+flush-9:0]
5 D root        2239       1  2  80   0 -   992 kthrea 06:57 pts/0 
00:02:15 sh test_deadlock.sh
1 D root       42791       2  0  80   0 -     0 raid5_ 07:45 ? 
00:00:00 [md0_resync]
5 D root       42803   42797  0  80   0 - 92175 balanc 07:45 ? 
00:00:06 fio -filename=/dev/md0 -bs=4k -rw=write -numjobs=1 -name=xxx

[root@fedora raid5]# cat /proc/2239/stack
[<0>] kthread_stop+0x96/0x2b0
[<0>] md_unregister_thread+0x5e/0xd0
[<0>] md_reap_sync_thread+0x27/0x370
[<0>] action_store+0x1fa/0x490
[<0>] md_attr_store+0xa7/0x120
[<0>] sysfs_kf_write+0x3a/0x60
[<0>] kernfs_fop_write_iter+0x144/0x2b0
[<0>] new_sync_write+0x140/0x210
[<0>] vfs_write+0x21a/0x350
[<0>] ksys_write+0x77/0x150
[<0>] __x64_sys_write+0x1d/0x30
[<0>] do_syscall_64+0x45/0x70
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
[root@fedora raid5]# cat /proc/42791/stack
[<0>] raid5_get_active_stripe+0x606/0x960
[<0>] raid5_sync_request+0x508/0x570
[<0>] md_do_sync.cold+0xaa6/0xee7
[<0>] md_thread+0x266/0x280
[<0>] kthread+0x151/0x1b0
[<0>] ret_from_fork+0x1f/0x30

And with this patchset applied, I run the above reporducer for more than
a day now, and I think the deadlock in raid456 can be fixed.

Can this patchset be considered in next merge window? If so, I'll rebase
this patchset.

Thanks,
Kuai
>>>> 2. pass all the tests in mdadm
>>
>> AFAICT, this set looks like a better solution for this problem. But I 
>> agree
>> that we need to make sure it fixes the original bug. mdadm tests are not
>> in a very good shape at the moment. I will spend more time to look into
>> these tests.
> 
> While I'm working on another thread to protect md_thread with rcu, I
> found that this patch has other defects that can cause null-ptr-
> deference in theory where md_unregister_thread(&mddev->sync_thread) can
> concurrent with other context to access sync_thread, for example:
> 
> t1: md_set_readonly             t2: action_store
>                                  md_unregister_thread
>                                  // 'reconfig_mutex' is not held
> // 'reconfig_mutex' is held by caller
> if (mddev->sync_thread)
>                                   thread = *threadp
>                                   *threadp = NULL
>   wake_up_process(mddev->sync_thread->tsk)
>   // null-ptr-deference
> 
> So, I think this revert will make more sence. 😉
> 
> Thanks,
> Kuai
> 
> .
> 

