Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50DB714A78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjE2NhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjE2NhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:37:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D938E;
        Mon, 29 May 2023 06:37:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGlr3dx4z4f3lVp;
        Mon, 29 May 2023 21:36:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rF3qnRkMvboKQ--.57470S3;
        Mon, 29 May 2023 21:36:57 +0800 (CST)
Subject: Re: [PATCH -next] md/raid5: don't allow concurrent reshape with
 recovery
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230529031045.1760883-1-yukuai1@huaweicloud.com>
 <6074a7aa-bb9c-6803-dd94-bba208d47ba0@molgen.mpg.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7932f1dd-ad0a-a744-39f4-b38b364ab486@huaweicloud.com>
Date:   Mon, 29 May 2023 21:36:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6074a7aa-bb9c-6803-dd94-bba208d47ba0@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rF3qnRkMvboKQ--.57470S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7AFyDGw47tF45tw4fXwb_yoW8Kw13pa
        92yFZ8WrWUurn3tr4Dtr1UAFy5Jr48t34DtF1fXa4jq3W5AryI9rWUWrZ0gF1UJr40qw4j
        qw18Xr9rZr17JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/29 14:44, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patch. As always some minor commons, you can also 
> ignore.

Thanks for there comments, I'll update them in v2 except that 'unsigned
int i'.

Thanks,
Kuai
> 
> Am 29.05.23 um 05:10 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
> 
> I’d start with a capital letter: Commit …
> 
>> is in progress") fix that replacement can be set if reshape is
> 
> fixes
> 
>> interrupted, which will cause that array can't be assemebled.
> 
> assembled
> 
>> There is a similar on the other side, if recovery is interrupted, then
> 
> similar *problem*?
> 
>> reshape can start, which will cause the same problem.
>>
>> Fix the prblem by don't start reshape is recovery is still in progress.
> 
> •  problem
> •  … by not starting to reshape while recovery is still in progress
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid5.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 64865f9dd3f5..6db783ca71b7 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -8500,6 +8500,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>>       struct r5conf *conf = mddev->private;
>>       struct md_rdev *rdev;
>>       int spares = 0;
>> +    int i;
> 
> It won’t make a difference for the code I believe, but as the count 
> variable can’t be negative, I’d use `unsigned int`.
> 
>>       unsigned long flags;
>>       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> @@ -8511,6 +8512,13 @@ static int raid5_start_reshape(struct mddev 
>> *mddev)
>>       if (has_failed(conf))
>>           return -EINVAL;
>> +    /* raid5 can't handle concurrent reshape and recovery */
>> +    if (mddev->recovery_cp < MaxSector)
>> +        return -EBUSY;
>> +    for (i = 0; i < conf->raid_disks; i++)
>> +        if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
>> +            return -EBUSY;
>> +
>>       rdev_for_each(rdev, mddev) {
>>           if (!test_bit(In_sync, &rdev->flags)
>>               && !test_bit(Faulty, &rdev->flags))
> 
> 
> Kind regards,
> 
> Paul
> 
> .
> 

