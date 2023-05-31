Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74948717852
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjEaHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjEaHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:34:08 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [IPv6:2001:41d0:1004:224b::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D253C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:34:05 -0700 (PDT)
Message-ID: <3f6fdbfc-9c35-2bc0-2b44-0e312f89455b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685518443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TMi838RK67CcEqqTNCbZ89BYFAIJ+LkmU3Cg3dLgM4=;
        b=ZKynHhuvxzXdH4/QmG+UKaBnmNx2K/hesoDvXlJhLSGXnVsV81mK4CiBfpUmUPzMQCez+j
        GHhH4lAlITzM2UWSLjDbAR8+0Je1cXuVPljOYSTFDWmdofXTbkKvmDHbNvNIIQvh5PGWen
        78Estzyq8xwcV8RuYoAeWeHNdqjLfQg=
Date:   Wed, 31 May 2023 15:33:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] md/raid5: don't allow concurrent reshape with recovery
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
 <b9fd7105-eadc-29cb-fa2e-24109f4a99b7@linux.dev>
 <e26af7db-a283-47ca-fc61-89af99f52c17@huaweicloud.com>
 <e2c936ce-5832-9d69-919a-c98af673bb3a@linux.dev>
 <98f285ff-5afb-1d12-f087-cf04a5208e21@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <98f285ff-5afb-1d12-f087-cf04a5208e21@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/23 11:20, Yu Kuai wrote:
> Hi,
>
> 在 2023/05/31 9:49, Guoqing Jiang 写道:
>>
>>
>> On 5/31/23 09:22, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2023/05/31 9:06, Guoqing Jiang 写道:
>>>>
>>>>
>>>> On 5/29/23 21:34, Yu Kuai wrote:
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> Commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
>>>>> is in progress") fixes that replacement can be set if reshape is
>>>>> interrupted, which will cause that array can't be assembled.
>>
>> I just pulled md tree, but can't find the commit id either in md-next 
>> or md-fixes .
>> gjiang@pc:~/storage/md> git branch
>>   master
>>   md-fixes
>> * md-next
>> gjiang@pc:~/storage/md> git branch --contain 0aecb06e2249
>> error: malformed object name 0aecb06e2249
>>
>>>>> There is a similar problem on the other side, if recovery is
>>>>> interrupted, then reshape can start, which will cause the same 
>>>>> problem.
>>>>>
>>>>> Fix the problem by not starting to reshape while recovery is still in
>>>>> progress.
>>>>>
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>   - fix some typo in commit message.
>>>>>
>>>>>   drivers/md/raid5.c | 8 ++++++++
>>>>>   1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>>>> index 8686d629e3f2..6615abf54d3f 100644
>>>>> --- a/drivers/md/raid5.c
>>>>> +++ b/drivers/md/raid5.c
>>>>> @@ -8525,6 +8525,7 @@ static int raid5_start_reshape(struct mddev 
>>>>> *mddev)
>>>>>       struct r5conf *conf = mddev->private;
>>>>>       struct md_rdev *rdev;
>>>>>       int spares = 0;
>>>>> +    int i;
>>>>>       unsigned long flags;
>>>>>       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>>>> @@ -8536,6 +8537,13 @@ static int raid5_start_reshape(struct mddev 
>>>>> *mddev)
>>>>>       if (has_failed(conf))
>>>>>           return -EINVAL;
>>>>> +    /* raid5 can't handle concurrent reshape and recovery */
>>>>> +    if (mddev->recovery_cp < MaxSector)
>>>>> +        return -EBUSY;
>>>>> +    for (i = 0; i < conf->raid_disks; i++)
>>>>> +        if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
>>>>> +            return -EBUSY;
>>>>> +
>>>>
>>>> Does it mean reshape and recovery  can happen in parallel without 
>>>> the change?
>>>> I really doubt about it given any kind of internal io (resync, 
>>>> reshape and recovery)
>>>> is handled by resync thread. And IIUC either md_do_sync or 
>>>> md_check_recovery
>>>> should avoid it, no need to do it in personality layer.
>>>>
>>>
>>> They can't, in this case recovery is interrupted, then recovery can't
>>> make progress, and md_check_recovery() will start reshape, and after
>>> reshape is done, recovery will continue, and data will be corrupted
>>> because raid456 reshape doesn't handle replacement.
>>
>> So, do reshape first then recovery, right? I don't see concurrent 
>> reshape and recovery
>> happen based on your description, if concurrent reshape and recovery 
>> is possible
>> then I believe we really have big trouble.
>
> Yes, reshape first, and yes they can't concurrent.

Then the subject, commit message and above comment are confusing given 
they can't happen
even without your change.

>
>>
>>> And by the way in raid456 is that if system reboot, this array can't be
>>> assembled, raid5_run() will fail if reshape and replacement are both
>>> set.
>>
>> Assemble an array need to read data from sb, I don't know which place 
>> record replacement,
>> I probably misunderstand something.
>
> It's in rdev->flags, if MD_FEATURE_REPLACEMENT is set in rdev
> metadata(sb->feature_map), then this rdev will mark Replacement, and
> later this rdev will set to mirros[]->replacement in setup_conf().

Yes, I missed that.

Thanks,
Guoqing
