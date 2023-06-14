Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83CB72F171
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbjFNBPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFNBPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:15:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE761BE8;
        Tue, 13 Jun 2023 18:15:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgnXW2scnz4f3mVx;
        Wed, 14 Jun 2023 09:15:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLOaFIlkEF+bLg--.21440S3;
        Wed, 14 Jun 2023 09:15:08 +0800 (CST)
Subject: Re: [dm-devel] [PATCH -next v2 3/6] md: add a mutex to synchronize
 idle and frozen in action_store()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-4-yukuai1@huaweicloud.com>
 <c96f2604-e1ef-c3ad-9d15-5e0efa5f222b@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <254fc651-aa75-074d-f567-49bafc437e9c@huaweicloud.com>
Date:   Wed, 14 Jun 2023 09:15:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c96f2604-e1ef-c3ad-9d15-5e0efa5f222b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLOaFIlkEF+bLg--.21440S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1kJrWfAr1xArW3JrWfGrg_yoW5CFWrpF
        WktFWrArZ0yws3Xr1UJwsrZay5Xr18KayDKryfGa4UJF13Cr4qqF1jgF4j9FykC3y8Cr1U
        tw18XFZ3ZF18Xr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/13 22:43, Xiao Ni 写道:
> 
> 在 2023/5/29 下午9:20, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, for idle and frozen, action_store will hold 'reconfig_mutex'
>> and call md_reap_sync_thread() to stop sync thread, however, this will
>> cause deadlock (explained in the next patch). In order to fix the
>> problem, following patch will release 'reconfig_mutex' and wait on
>> 'resync_wait', like md_set_readonly() and do_md_stop() does.
>>
>> Consider that action_store() will set/clear 'MD_RECOVERY_FROZEN'
>> unconditionally, which might cause unexpected problems, for example,
>> frozen just set 'MD_RECOVERY_FROZEN' and is still in progress, while
>> 'idle' clear 'MD_RECOVERY_FROZEN' and new sync thread is started, which
>> might starve in progress frozen. A mutex is added to synchronize idle
>> and frozen from action_store().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 5 +++++
>>   drivers/md/md.h | 3 +++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 23e8e7eae062..63a993b52cd7 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -644,6 +644,7 @@ void mddev_init(struct mddev *mddev)
>>       mutex_init(&mddev->open_mutex);
>>       mutex_init(&mddev->reconfig_mutex);
>>       mutex_init(&mddev->delete_mutex);
>> +    mutex_init(&mddev->sync_mutex);
>>       mutex_init(&mddev->bitmap_info.mutex);
>>       INIT_LIST_HEAD(&mddev->disks);
>>       INIT_LIST_HEAD(&mddev->all_mddevs);
>> @@ -4785,14 +4786,18 @@ static void stop_sync_thread(struct mddev *mddev)
>>   static void idle_sync_thread(struct mddev *mddev)
>>   {
>> +    mutex_lock(&mddev->sync_mutex);
>>       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>       stop_sync_thread(mddev);
>> +    mutex_unlock(&mddev->sync_mutex);
>>   }
>>   static void frozen_sync_thread(struct mddev *mddev)
>>   {
>> +    mutex_init(&mddev->delete_mutex);
> 
> 
> typo error? It should be mutex_lock(&mddev->sync_mutex); ?
> 

Yes, and thanks for spotting this, this looks like I did this while
rebasing.

Thanks,
Kuai
> Regards
> 
> Xiao
> 
>>       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>       stop_sync_thread(mddev);
>> +    mutex_unlock(&mddev->sync_mutex);
>>   }
>>   static ssize_t
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index bfd2306bc750..2fa903de5bd0 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -537,6 +537,9 @@ struct mddev {
>>       /* Protect the deleting list */
>>       struct mutex            delete_mutex;
>> +    /* Used to synchronize idle and frozen for action_store() */
>> +    struct mutex            sync_mutex;
>> +
>>       bool    has_superblocks:1;
>>       bool    fail_last_dev:1;
>>       bool    serialize_policy:1;
> 
> .
> 

