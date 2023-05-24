Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266E970EAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjEXBdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjEXBdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:33:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EEC135;
        Tue, 23 May 2023 18:33:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QQtx21SWTz4f3p0S;
        Wed, 24 May 2023 09:33:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHZQNTaW1kYjQoJQ--.1928S3;
        Wed, 24 May 2023 09:33:08 +0800 (CST)
Subject: Re: [PATCH v3] md: fix duplicate filename for rdev
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     pmenzel@molgen.mpg.de, akpm@linux-foundation.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230523012727.3042247-1-yukuai1@huaweicloud.com>
 <CAPhsuW5AERnf5D4804ksgZEB2ZP7gVAG8f5Fghwnn0FKseBG+g@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d8b3f930-0d58-81a8-449c-b39cd5f41983@huaweicloud.com>
Date:   Wed, 24 May 2023 09:33:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5AERnf5D4804ksgZEB2ZP7gVAG8f5Fghwnn0FKseBG+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHZQNTaW1kYjQoJQ--.1928S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyxuF17ZrW8uF1DGw1rJFb_yoW5Kry3pF
        WfKa43Gr4DAr4xCa1qqw1xW34rXws3KFW7J3sakF4jk345Zr9FgryfKa1v9r9YkrZa9r4j
        va18WFW5Ja4UCFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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

在 2023/05/24 2:05, Song Liu 写道:
> On Mon, May 22, 2023 at 6:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
>> from an md array via sysfs") delays the deletion of rdev, however, this
>> introduces a window that rdev can be added again while the deletion is
>> not done yet, and sysfs will complain about duplicate filename.
>>
>> Follow up patches try to fix this problem by flushing workqueue, however,
>> flush_rdev_wq() is just dead code, the progress in
>> md_kick_rdev_from_array():
>>
>> 1) list_del_rcu(&rdev->same_set);
>> 2) synchronize_rcu();
>> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>>
>> So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
>> never pass, in the meantime, if work is queued, then rdev can never be
>> found in the list.
>>
>> flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
>> this approach is not good:
>> - the workqueue is global, this synchronization for all raid disks is
>>    not necessary.
>> - flush_workqueue can't be called under 'reconfig_mutex', there is still
>>    a small window between flush_workqueue() and mddev_lock() that other
>>    contexts can queue new work, hence the problem is not solved completely.
>>
>> sysfs already has apis to support delete itself through writer, and
>> these apis, specifically sysfs_break/unbreak_active_protection(), is used
>> to support deleting rdev synchronously. Therefore, the above commit can be
>> reverted, and sysfs duplicate filename can be avoided.
>>
>> A new mdadm regression test is proposed as well([1]).
>>
>> [1] https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1@huaweicloud.com/
>> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device from an md array via sysfs")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Thanks for the fix! I made the following changes and applied it
> to md-next:
> 
> 1. remove md_rdev->del_work, which is not used any more;
> 2. change list_empty_safe to list_empty protected by the mutex, as
>     list_empty_safe doesn't seem safe here.
Yes, this make sense, we must make sure caller won't see stale rdev
through sysfs:

t1: remove rdev			t2:
mutex_lock(reconfig_mutex)
list_add
mutex_unlock(reconfig_mutex)
				mutex_lock(reconfig_mutex)
				mutex_unlock(reconfig_mutex)
				mutex_lock(delete_mutex)
				list_del_init
list_empty_careful
  -> list is empty now, return, caller will think rdev is removed,
  however, since export_rdev is not called yet, adding this rdev again
  will fail.
				kobject_del

hold mutex is safe, and I think performance should be ok because remove
rdev is not hot path. If we don't want to hold a new mutex in hot path,
perhaps list_empty_careful can work with following changes, remove rdev
from the list after sysfs entries is removed:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 296885798a2b..84dce5822f91 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -758,8 +758,8 @@ static void md_free_rdev(struct mddev *mddev)

         mutex_lock(&mddev->delete_mutex);
         list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
-               list_del_init(&rdev->same_set);
                 kobject_del(&rdev->kobj);
+               list_del_init(&rdev->same_set);
                 export_rdev(rdev);
         }
         mutex_unlock(&mddev->delete_mutex);

> 
> Please let me know if either change doesn't make sense.
> 
> Thanks,
> Song
> .
> 

