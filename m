Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223A96DCEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDKBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:08:20 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663F1A7;
        Mon, 10 Apr 2023 18:08:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PwSQ6744Xz4f4NV9;
        Tue, 11 Apr 2023 09:08:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R_+sjRkkqc+Gg--.60813S3;
        Tue, 11 Apr 2023 09:08:16 +0800 (CST)
Subject: Re: [PATCH -next v5 6/6] md: protect md_thread with rcu
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
 <20230410113559.1610455-7-yukuai1@huaweicloud.com>
 <87c0efd2-c8b0-c6ab-764c-958883fe1d15@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1f5c8b12-5eb7-4e67-abac-5bead8382c6d@huaweicloud.com>
Date:   Tue, 11 Apr 2023 09:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87c0efd2-c8b0-c6ab-764c-958883fe1d15@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R_+sjRkkqc+Gg--.60813S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfZFWDJrW7tFWxXr4UXFb_yoW5ur1xpa
        yxKFyayr48ArWfZFW7JayUCFWYvw1IqFyjkryxG3yrGa4q9rW3tryUCFy8XFykAFyrJF4Y
        qw15Kan5WFWqgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/10 23:42, Logan Gunthorpe 写道:
> 
> 
> On 2023-04-10 05:35, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test reports a uaf for 'mddev->sync_thread':
>>
>> T1                      T2
>> md_start_sync
>>   md_register_thread
>>   // mddev->sync_thread is set
>> 			raid1d
>> 			 md_check_recovery
>> 			  md_reap_sync_thread
>> 			   md_unregister_thread
>> 			    kfree
>>
>>   md_wakeup_thread
>>    wake_up
>>    ->sync_thread was freed
>>
>> Root cause is that there is a small windown between register thread and
>> wake up thread, where the thread can be freed concurrently.
>>
>> Currently, a global spinlock 'pers_lock' is borrowed to protect
>> 'mddev->thread', this problem can be fixed likewise, however, there might
>> be similar problem elsewhere, and use a global lock for all the cases is
>> not good.
>>
>> This patch protect md_thread with rcu.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md-bitmap.c   | 29 ++++++++++++-----
>>   drivers/md/md.c          | 68 +++++++++++++++++++---------------------
>>   drivers/md/md.h          | 10 +++---
>>   drivers/md/raid1.c       |  4 +--
>>   drivers/md/raid1.h       |  2 +-
>>   drivers/md/raid10.c      | 10 ++++--
>>   drivers/md/raid10.h      |  2 +-
>>   drivers/md/raid5-cache.c | 15 +++++----
>>   drivers/md/raid5.c       |  4 +--
>>   drivers/md/raid5.h       |  2 +-
>>   10 files changed, 81 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index 29fd41ef55a6..b9baeea5605e 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1219,15 +1219,27 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
>>   					       int create);
>>   
>>   static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
>> -			      bool force)
>> +			      bool force, bool protected)
>>   {
>> -	struct md_thread *thread = mddev->thread;
>> +	struct md_thread *thread;
>> +
>> +	if (!protected) {
>> +		rcu_read_lock();
>> +		thread = rcu_dereference(mddev->thread);
>> +	} else {
>> +		thread = rcu_dereference_protected(mddev->thread,
>> +				lockdep_is_held(&mddev->reconfig_mutex));
>> +	}
> 
> Why not just always use rcu_read_lock()? Even if it's safe with
> reconfig_mutex, it wouldn't harm much and would make the code a bit less
> ugly.
> 
Of course, I'll do that in next version.

> 
>> @@ -458,8 +454,10 @@ static void md_submit_bio(struct bio *bio)
>>    */
>>   void mddev_suspend(struct mddev *mddev)
>>   {
>> -	WARN_ON_ONCE(mddev->thread && current == mddev->thread->tsk);
>> -	lockdep_assert_held(&mddev->reconfig_mutex);
>> +	struct md_thread *thread = rcu_dereference_protected(mddev->thread,
>> +			lockdep_is_held(&mddev->reconfig_mutex));
> 
> Do we know that reconfig_mutex is always held when we call
> md_unregister_thread()? Seems plausible, but maybe it's worth adding a
> lockdep_assert_held() to md_unregsiter_thread().

Unfortunally this is not true for now, md_unregister_thread() can be
called without this mutex from action_store(), and this is problematic,
I'm tring to revert this change in the other thread:

md: fix that MD_RECOVERY_RUNNING can be cleared while sync_thread is
still running.

I think it's not good to add lockdep_assert_held() for now...

Thanks,
Kuai
> 
> Thanks,
> 
> Logan
> .
> 

