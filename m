Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB966E19A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNB0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:26:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E092F7;
        Thu, 13 Apr 2023 18:26:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PyJgv6gMMz4f3y0B;
        Fri, 14 Apr 2023 09:26:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R_LqzhkaVQBGw--.6718S3;
        Fri, 14 Apr 2023 09:26:37 +0800 (CST)
Subject: Re: [PATCH -next v6 5/5] md: protect md_thread with rcu
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
 <20230413113217.1934353-6-yukuai1@huaweicloud.com>
 <961691d0-7224-caad-6c19-d9c8ca07a801@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <720261bf-2dfd-1298-4664-853a8e5cf132@huaweicloud.com>
Date:   Fri, 14 Apr 2023 09:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <961691d0-7224-caad-6c19-d9c8ca07a801@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R_LqzhkaVQBGw--.6718S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7GF4ktrWfKw48ZF13urg_yoWrCw15pa
        yIga43CrWUAr4xur47Xa4DZFW5tw10gFWUKry7C34fZ3Wq9rZxXFyUGF9xZr1DCFyrXFsF
        qr15Kw4DuFWDKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/13 23:10, Logan Gunthorpe 写道:
> 
> 
> On 2023-04-13 05:32, Yu Kuai wrote:
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
>> 'mddev->thread', this problem can be fixed likewise, however, there are
>> similar problems elsewhere, and use a global lock for all the cases is
>> not good.
>>
>> This patch protect all md_thread with rcu.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md-bitmap.c    | 10 ++++--
>>   drivers/md/md-cluster.c   |  7 ++--
>>   drivers/md/md-multipath.c |  4 +--
>>   drivers/md/md.c           | 69 ++++++++++++++++++---------------------
>>   drivers/md/md.h           |  8 ++---
>>   drivers/md/raid1.c        |  7 ++--
>>   drivers/md/raid1.h        |  2 +-
>>   drivers/md/raid10.c       | 21 +++++++-----
>>   drivers/md/raid10.h       |  2 +-
>>   drivers/md/raid5-cache.c  | 22 ++++++++-----
>>   drivers/md/raid5.c        | 15 +++++----
>>   drivers/md/raid5.h        |  2 +-
>>   12 files changed, 91 insertions(+), 78 deletions(-)
>>
>> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
>> index 29fd41ef55a6..ab27f66dbb1f 100644
>> --- a/drivers/md/md-bitmap.c
>> +++ b/drivers/md/md-bitmap.c
>> @@ -1221,13 +1221,19 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
>>   static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
>>   			      bool force)
>>   {
>> -	struct md_thread *thread = mddev->thread;
>> +	struct md_thread *thread;
>> +
>> +	rcu_read_lock();
>> +	thread = rcu_dereference(mddev->thread);
>>   
>>   	if (!thread)
>> -		return;
>> +		goto out;
>>   
>>   	if (force || thread->timeout < MAX_SCHEDULE_TIMEOUT)
>>   		thread->timeout = timeout;
>> +
>> +out:
>> +	rcu_read_unlock();
>>   }
>>   
>>   /*
>> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
>> index 10e0c5381d01..672dfa6a40ec 100644
>> --- a/drivers/md/md-cluster.c
>> +++ b/drivers/md/md-cluster.c
>> @@ -362,8 +362,8 @@ static void __recover_slot(struct mddev *mddev, int slot)
>>   
>>   	set_bit(slot, &cinfo->recovery_map);
>>   	if (!cinfo->recovery_thread) {
>> -		cinfo->recovery_thread = md_register_thread(recover_bitmaps,
>> -				mddev, "recover");
>> +		rcu_assign_pointer(cinfo->recovery_thread,
>> +			md_register_thread(recover_bitmaps, mddev, "recover"));
>>   		if (!cinfo->recovery_thread) {
>>   			pr_warn("md-cluster: Could not create recovery thread\n");
>>   			return;
>> @@ -889,7 +889,8 @@ static int join(struct mddev *mddev, int nodes)
>>   	}
>>   	/* Initiate the communication resources */
>>   	ret = -ENOMEM;
>> -	cinfo->recv_thread = md_register_thread(recv_daemon, mddev, "cluster_recv");
>> +	rcu_assign_pointer(cinfo->recv_thread,
>> +			md_register_thread(recv_daemon, mddev, "cluster_recv"));
>>   	if (!cinfo->recv_thread) {
> 
> This looks like it'll hit sparse warnings. without an
> rcu_access_pointer(). Might be nicer to use a temporary variable, check
> that it's not null, then call rcu_assign_pointer().

Sorry this is because I missed following change:

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 672dfa6a40ec..2f64673b6ed2 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -75,14 +75,14 @@ struct md_cluster_info {
         sector_t suspend_hi;
         int suspend_from; /* the slot which broadcast suspend_lo/hi */

-       struct md_thread *recovery_thread;
+       struct md_thread __rcu *recovery_thread;
         unsigned long recovery_map;
         /* communication loc resources */
         struct dlm_lock_resource *ack_lockres;
         struct dlm_lock_resource *message_lockres;
         struct dlm_lock_resource *token_lockres;
         struct dlm_lock_resource *no_new_dev_lockres;
-       struct md_thread *recv_thread;
+       struct md_thread __rcu *recv_thread;
         struct completion newdisk_completion;
         wait_queue_head_t wait;
         unsigned long state;

Thanks,
Kuai

