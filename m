Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89168046E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjA3Dqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjA3Dq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:46:28 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0151D900;
        Sun, 29 Jan 2023 19:46:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P4vHJ3gmRz4f3v4f;
        Mon, 30 Jan 2023 11:46:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R+MPddjoCS0CQ--.41891S3;
        Mon, 30 Jan 2023 11:46:22 +0800 (CST)
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <19ad8dd7-482e-dad0-8465-f78f7f9c154d@huaweicloud.com>
Date:   Mon, 30 Jan 2023 11:46:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7c5c38f128910f89f20533b7fd51453a32ff4f5c.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R+MPddjoCS0CQ--.41891S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4rAr15KF4xXr15CrykXwb_yoW8Kw4kpF
        WfKFZIkrWkGwn3Jw1vyayrZw10yw4kAw45JF15Kr17Ja4UCF9aqrW5Ka9Y9FyUWryxX3WY
        qF4rGa9Ik34qyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/01/30 11:29, James Bottomley 写道:
> On Mon, 2023-01-30 at 11:07 +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/01/30 1:30, James Bottomley 写道:
>>> On Sat, 2023-01-28 at 17:41 +0800, Zhong Jinghua wrote:
>>>> This error will cause a warning:
>>>> kobject_add_internal failed for block (error: -2 parent:
>>>> 1:0:0:1). In the lower version (such as 5.10), there is no
>>>> corresponding error handling, continuing to go down will trigger
>>>> a kernel panic, so cc stable.
>>>
>>> Is this is important point and what you're saying is that this only
>>> panics on kernels before 5.10 or so because after that it's
>>> correctly failed by block device error handling so there's nothing
>>> to fix in later kernels?
>>>
>>> In that case, isn't the correct fix to look at backporting the
>>> block device error handling:
>>
>> This is the last commit that support error handling, and there are
>> many relied patches, and there are lots of refactor in block layer.
>> It's not a good idea to backport error handling to lower version.
>>
>> Althrough error handling can prevent kernel crash in this case, I
>> still think it make sense to make sure kobject is deleted in order,
>> parent should not be deleted before child.
> 
> Well, look, you've created a very artificial situation where a create
> closely followed by a delete of the underlying sdev races with the
> create of the block gendisk devices of sd that bind asynchronously to
> the created sdev.  The asynchronous nature of the bind gives the
> elongated race window so the only real fix is some sort of check that
> the sdev is still viable by the time the bind occurs ... probably in
> sd_probe(), say a scsi_device_get of sdp at the top which would ensure
> viability of the sdev for the entire bind or fail the probe if the sdev
> can't be got.

Sorry, I don't follow here. 😟

I agree this is a very artificial situation, however I can't tell our
tester not to test this way...

The problem is that kobject session is deleted and then sd_probe() tries
to create a new kobject under hostx/sessionx/x:x:x:x/. I don't see how
scsi_device_get() can prevent that, it only get a kobject reference and
can prevent kobject to be released, however, kobject_del() can still be
done.

In this patch, we make sure remove session and sd_probe() won't
concurrent, remove session will wait for all child kobject to be
deleted, what do you think?

Thanks,
Kuai
> 
> James
> 
> 
> .
> 

