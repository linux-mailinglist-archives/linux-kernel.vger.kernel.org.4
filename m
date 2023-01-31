Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12C8682177
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAaBnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:43:08 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63215CB8;
        Mon, 30 Jan 2023 17:43:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P5SVX3C7kz4f3jLs;
        Tue, 31 Jan 2023 09:43:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiAkcthjLPbnCQ--.15264S3;
        Tue, 31 Jan 2023 09:43:02 +0800 (CST)
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
To:     jejb@linux.ibm.com, Yu Kuai <yukuai1@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        hare@suse.de, bvanassche@acm.org, emilne@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
 <1b466057ed2e91b05388afbb5791639eb8abdd59.camel@linux.ibm.com>
 <c3e58056-942a-f829-ecf6-1342c65b6865@huaweicloud.com>
 <7c5c38f128910f89f20533b7fd51453a32ff4f5c.camel@linux.ibm.com>
 <19ad8dd7-482e-dad0-8465-f78f7f9c154d@huaweicloud.com>
 <5b1605cceba6e7de753bce8a78e1ce5c2d545546.camel@linux.ibm.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <69a9000f-541e-c182-44c9-75337094de4a@huaweicloud.com>
Date:   Tue, 31 Jan 2023 09:43:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5b1605cceba6e7de753bce8a78e1ce5c2d545546.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiAkcthjLPbnCQ--.15264S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kAF45WFW7Xw1xZw1rXrb_yoWrur4fpF
        WfJa43Kr4kXwnrtw4vv3ykX348tw4kAry5WF15tr18GryqvryIyrsYyayq9FyDWr97Ja15
        WF4UJa97J3yUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/01/30 21:17, James Bottomley 写道:
> On Mon, 2023-01-30 at 11:46 +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/01/30 11:29, James Bottomley 写道:
>>> On Mon, 2023-01-30 at 11:07 +0800, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2023/01/30 1:30, James Bottomley 写道:
>>>>> On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
>>>>>> This error will cause a warning:
>>>>>> kobject_add_internal failed for block (error: -2 parent:
>>>>>> 1:0:0:1). In the lower version (such as 5.10), there is no
>>>>>> corresponding error handling, continuing to go down will
>>>>>> trigger a kernel panic, so cc stable.
>>>>>
>>>>> Is this is important point and what you're saying is that this
>>>>> only panics on kernels before 5.10 or so because after that
>>>>> it's correctly failed by block device error handling so there's
>>>>> nothing to fix in later kernels?
>>>>>
>>>>> In that case, isn't the correct fix to look at backporting the
>>>>> block device error handling:
>>>>
>>>> This is the last commit that support error handling, and there
>>>> are many relied patches, and there are lots of refactor in block
>>>> layer. It's not a good idea to backport error handling to lower
>>>> version.
>>>> Althrough error handling can prevent kernel crash in this case, I
>>>> still think it make sense to make sure kobject is deleted in
>>>> order, parent should not be deleted before child.
>>>
>>> Well, look, you've created a very artificial situation where a
>>> create closely followed by a delete of the underlying sdev races
>>> with the create of the block gendisk devices of sd that bind
>>> asynchronously to the created sdev.  The asynchronous nature of the
>>> bind gives the elongated race window so the only real fix is some
>>> sort of check that the sdev is still viable by the time the bind
>>> occurs ... probably in sd_probe(), say a scsi_device_get of sdp at
>>> the top which would ensure viability of the sdev for the entire
>>> bind or fail the probe if the sdev can't be got.
>>
>> Sorry, I don't follow here. 😟
> 
> In the current kernel the race is mitigated because add_device fails
> due to the parent being torn down.  That parent is the sdev->gendev so
> it seems we can detect this in the probe by looking at the sdev->gendev
> state, which scsi_device_get() will do.
> 
>> I agree this is a very artificial situation, however I can't tell our
>> tester not to test this way...
>>
>> The problem is that kobject session is deleted and then sd_probe()
>> tries to create a new kobject under hostx/sessionx/x:x:x:x/. I don't
>> see how scsi_device_get() can prevent that, it only get a kobject
>> reference and can prevent kobject to be released, however,
>> kobject_del() can still be done.
> 
> So your contention is there's no way that we could make scsi_device_get
> see the kernfs deactivation?  I would have thought checking sdev-
>> sdev_gendev.kobj.sd.active would give that ... although the check
> would have to be via an API since KN_DEACTIVATED_BIAS is internal.

I'm still not sure if such checking is enough.

session1/target1:0:0/1:0:0:0/block

1) t1 is deleting target, and t1 already set 1:0:0:0 to SDEV_CANCEL, and
1:0:0:0 is not deleted yet.
2) t2 is deleting session1, 1:0:0:0 state is SDEV_CACEL, so 1:0:0:0 is
skipped, and session1 is deleted before 1:0:0:0, which will cause
1:0:0:0 to be not active.
3) t3 create block, it can happen because 1:0:0:0 is still not deleted,
and later kobject_add() will found 1:0:0:0 is not active and hence
faild.

The problem is that deleting parent kobject will cause child kobject not
to be active, and in 3) device_lock is not hold for parents, hence just
checking if this scsi_device is active is not enough, we have to make
sure parents won't be deleted concurrently, for example, a litter
adjustment for above procedures:

1) ...(the same)
2) t3 create block, it check kobject state is still active
3) t2 delete session1 ...(the same), 1:0:0:0 is not active anymore.
4) t3 continue to create block undre 1:0:0:0, which will fail.

By the way, I think such problem exist because scsi_device state is
SDEV_CANCEL doesn't mean that the device is deleted, simply skip such
device while removing session is not right.

Do you found other problems if we make sure that kobject is deleted in
order?

Thanks,
Kuai
> 
> James
> 
>> In this patch, we make sure remove session and sd_probe() won't
>> concurrent, remove session will wait for all child kobject to be
>> deleted, what do you think?
>>
>> Thanks,
>> Kuai
>>
> 
> .
> 

