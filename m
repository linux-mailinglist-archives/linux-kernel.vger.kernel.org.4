Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57332717453
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjEaDU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjEaDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:20:25 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2BA0;
        Tue, 30 May 2023 20:20:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QWDzQ1Qp1z4f3khy;
        Wed, 31 May 2023 11:20:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77LyvHZkknNeKg--.6568S3;
        Wed, 31 May 2023 11:20:19 +0800 (CST)
Subject: Re: [PATCH v2] md/raid5: don't allow concurrent reshape with recovery
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
 <b9fd7105-eadc-29cb-fa2e-24109f4a99b7@linux.dev>
 <e26af7db-a283-47ca-fc61-89af99f52c17@huaweicloud.com>
 <e2c936ce-5832-9d69-919a-c98af673bb3a@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <98f285ff-5afb-1d12-f087-cf04a5208e21@huaweicloud.com>
Date:   Wed, 31 May 2023 11:20:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e2c936ce-5832-9d69-919a-c98af673bb3a@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77LyvHZkknNeKg--.6568S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kJF4rXr1UJr4kuF4UArb_yoWrJr18pa
        yktFs8urWUCrnayF4qqw1jvFyYkryUJa98Xrn8Xa4rCrs8tr1I9rWUWFn09r1UJr4Fqw4j
        qr1rtr9rur1jgFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
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

在 2023/05/31 9:49, Guoqing Jiang 写道:
> 
> 
> On 5/31/23 09:22, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/05/31 9:06, Guoqing Jiang 写道:
>>>
>>>
>>> On 5/29/23 21:34, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
>>>> is in progress") fixes that replacement can be set if reshape is
>>>> interrupted, which will cause that array can't be assembled.
> 
> I just pulled md tree, but can't find the commit id either in md-next or 
> md-fixes .
> gjiang@pc:~/storage/md> git branch
>   master
>   md-fixes
> * md-next
> gjiang@pc:~/storage/md> git branch --contain 0aecb06e2249
> error: malformed object name 0aecb06e2249
> 
>>>> There is a similar problem on the other side, if recovery is
>>>> interrupted, then reshape can start, which will cause the same problem.
>>>>
>>>> Fix the problem by not starting to reshape while recovery is still in
>>>> progress.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>> Changes in v2:
>>>>   - fix some typo in commit message.
>>>>
>>>>   drivers/md/raid5.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>>> index 8686d629e3f2..6615abf54d3f 100644
>>>> --- a/drivers/md/raid5.c
>>>> +++ b/drivers/md/raid5.c
>>>> @@ -8525,6 +8525,7 @@ static int raid5_start_reshape(struct mddev 
>>>> *mddev)
>>>>       struct r5conf *conf = mddev->private;
>>>>       struct md_rdev *rdev;
>>>>       int spares = 0;
>>>> +    int i;
>>>>       unsigned long flags;
>>>>       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>>> @@ -8536,6 +8537,13 @@ static int raid5_start_reshape(struct mddev 
>>>> *mddev)
>>>>       if (has_failed(conf))
>>>>           return -EINVAL;
>>>> +    /* raid5 can't handle concurrent reshape and recovery */
>>>> +    if (mddev->recovery_cp < MaxSector)
>>>> +        return -EBUSY;
>>>> +    for (i = 0; i < conf->raid_disks; i++)
>>>> +        if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
>>>> +            return -EBUSY;
>>>> +
>>>
>>> Does it mean reshape and recovery  can happen in parallel without the 
>>> change?
>>> I really doubt about it given any kind of internal io (resync, 
>>> reshape and recovery)
>>> is handled by resync thread. And IIUC either md_do_sync or 
>>> md_check_recovery
>>> should avoid it, no need to do it in personality layer.
>>>
>>
>> They can't, in this case recovery is interrupted, then recovery can't
>> make progress, and md_check_recovery() will start reshape, and after
>> reshape is done, recovery will continue, and data will be corrupted
>> because raid456 reshape doesn't handle replacement.
> 
> So, do reshape first then recovery, right? I don't see concurrent 
> reshape and recovery
> happen based on your description, if concurrent reshape and recovery is 
> possible
> then I believe we really have big trouble.

Yes, reshape first, and yes they can't concurrent.
> 
>> And by the way in raid456 is that if system reboot, this array can't be
>> assembled, raid5_run() will fail if reshape and replacement are both
>> set.
> 
> Assemble an array need to read data from sb, I don't know which place 
> record replacement,
> I probably misunderstand something.

It's in rdev->flags, if MD_FEATURE_REPLACEMENT is set in rdev
metadata(sb->feature_map), then this rdev will mark Replacement, and
later this rdev will set to mirros[]->replacement in setup_conf().

Thanks,
Kuai

