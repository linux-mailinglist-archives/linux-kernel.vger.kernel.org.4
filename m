Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263A6D9206
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjDFIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDFIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:53:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA6190;
        Thu,  6 Apr 2023 01:53:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PsZyn0004z4f3wQs;
        Thu,  6 Apr 2023 16:53:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R9wiC5kaAUNGQ--.21136S3;
        Thu, 06 Apr 2023 16:53:06 +0800 (CST)
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9d92a862-e728-5493-52c0-abc634eb6e97@huaweicloud.com>
Date:   Thu, 6 Apr 2023 16:53:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7c2b4yYbwNcqKW+TBL=QYEzchnVQ4pDLBT-xoBoTvQmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R9wiC5kaAUNGQ--.21136S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy3AFWDur13WF13XF4UXFb_yoW5uFy7pa
        yxK3WUKr4DAr42ya42qw1IqayFvr4jqryUWryrJFyxG3s8KrW7tryjkF1UCFWDZrn7Cw4j
        va1rtFZ3ZFWqv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/29 7:58, Song Liu 写道:
> On Wed, Mar 22, 2023 at 11:32 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/03/23 11:50, Guoqing Jiang 写道:
>>
>>> Combined your debug patch with above steps. Seems you are
>>>
>>> 1. add delay to action_store, so it can't get lock in time.
>>> 2. echo "want_replacement"**triggers md_check_recovery which can grab lock
>>>       to start sync thread.
>>> 3. action_store finally hold lock to clear RECOVERY_RUNNING in reap sync
>>> thread.
>>> 4. Then the new added BUG_ON is invoked since RECOVERY_RUNNING is cleared
>>>       in step 3.
>>
>> Yes, this is exactly what I did.
>>
>>> sync_thread can be interrupted once MD_RECOVERY_INTR is set which means
>>> the RUNNING
>>> can be cleared, so I am not sure the added BUG_ON is reasonable. And
>>> change BUG_ON
>>
>> I think BUG_ON() is reasonable because only md_reap_sync_thread can
>> clear it, md_do_sync will exit quictly if MD_RECOVERY_INTR is set, but
>> md_do_sync should not see that MD_RECOVERY_RUNNING is cleared, otherwise
>> there is no gurantee that only one sync_thread can be in progress.
>>
>>> like this makes more sense to me.
>>>
>>> +BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
>>> +!test_bit(MD_RECOVERY_INTR, &mddev->recovery));
>>
>> I think this can be reporduced likewise, md_check_recovery clear
>> MD_RECOVERY_INTR, and new sync_thread triggered by echo
>> "want_replacement" won't set this bit.
>>
>>>
>>> I think there might be racy window like you described but it should be
>>> really small, I prefer
>>> to just add a few lines like this instead of revert and introduce new
>>> lock to resolve the same
>>> issue (if it is).
>>
>> The new lock that I add in this patchset is just try to synchronize idle
>> and forzen from action_store（patch 3), I can drop it if you think this
>> is not necessary.
>>
>> The main changes is patch 4, new lines is not much and I really don't
>> like to add new flags unless we have to, current code is already hard
>> to understand...
>>
>> By the way, I'm concerned that drop the mutex to unregister sync_thread
>> might not be safe, since the mutex protects lots of stuff, and there
>> might exist other implicit dependencies.
>>
>>>
>>> TBH, I am reluctant to see the changes in the series, it can only be
>>> considered
>>> acceptable with conditions:
>>>
>>> 1. the previous raid456 bug can be fixed in this way too, hopefully Marc
>>> or others
>>>       can verify it.
>>> 2. pass all the tests in mdadm
> 
> AFAICT, this set looks like a better solution for this problem. But I agree
> that we need to make sure it fixes the original bug. mdadm tests are not
> in a very good shape at the moment. I will spend more time to look into
> these tests.

While I'm working on another thread to protect md_thread with rcu, I
found that this patch has other defects that can cause null-ptr-
deference in theory where md_unregister_thread(&mddev->sync_thread) can
concurrent with other context to access sync_thread, for example:

t1: md_set_readonly             t2: action_store
                                 md_unregister_thread
                                 // 'reconfig_mutex' is not held
// 'reconfig_mutex' is held by caller
if (mddev->sync_thread)
                                  thread = *threadp
                                  *threadp = NULL
  wake_up_process(mddev->sync_thread->tsk)
  // null-ptr-deference

So, I think this revert will make more sence. 😉

Thanks,
Kuai

