Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3471FA69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjFBG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjFBG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:57:58 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F217184;
        Thu,  1 Jun 2023 23:57:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXYjQ72lBz4f3l1s;
        Fri,  2 Jun 2023 14:57:46 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHqknlkL8gCKw--.48920S3;
        Fri, 02 Jun 2023 14:57:48 +0800 (CST)
Message-ID: <917d7c23-eefc-efc5-1b12-949a684900bc@huaweicloud.com>
Date:   Fri, 2 Jun 2023 14:57:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/2] md/raid10: fix incorrect done of recovery
To:     Paul Menzel <pmenzel@molgen.mpg.de>, linan666@huaweicloud.com
Cc:     song@kernel.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230601062424.3613218-1-linan666@huaweicloud.com>
 <20230601062424.3613218-2-linan666@huaweicloud.com>
 <2e36d874-4dd3-080c-3499-44f2f09b9169@molgen.mpg.de>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <2e36d874-4dd3-080c-3499-44f2f09b9169@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHqknlkL8gCKw--.48920S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3WryrAryxur1rKF4rKrg_yoW5Cr17pr
        4kJrZ8JryUJwn3Jw1UAryUJFy5Ary8Ja4DJr18W3WUXrW3JryjgFWUXr1jgryUXr48tF1U
        Jw1UXrW5ZF1UKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/1 15:06, Paul Menzel 写道:
> Dear Li,
> 
> 
> Thank you for your patch.
> 
> Am 01.06.23 um 08:24 schrieb linan666@huaweicloud.com:
>> From: Li Nan <linan122@huawei.com>
> 
> Unfortunately, I do not understand your commit message summary “fix 
> incorrect done of recovery”. Maybe:
> 
> Do not add sparse disk when recovery aborts
> 

"recovery fail" is better?

>> In raid10_sync_request(), if data cannot be read from any disk for
>> recovery, it will go to 'giveup' and let 'chunks_skipped' + 1. After
>> multiple 'giveup', when 'chunks_skipped >= geo.raid_disks', it will
>> return 'max_sector', indicating that the recovery has been completed.
>> However, the recovery is just aborted and the data remains inconsistent.
>>
>> Fix it by setting mirror->recovery_disabled, which will prevent the spare
>> disk from being added to this mirror. The same issue also exists during
>> resync, it will be fixed afterwards.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/raid10.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index d93d8cb2b620..3ba1516ea160 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev 
>> *mddev, sector_t sector_nr,
>>       int chunks_skipped = 0;
>>       sector_t chunk_mask = conf->geo.chunk_mask;
>>       int page_idx = 0;
>> +    int error_disk = -1;
>>       /*
>>        * Allow skipping a full rebuild for incremental assembly
>> @@ -3386,7 +3387,20 @@ static sector_t raid10_sync_request(struct 
>> mddev *mddev, sector_t sector_nr,
>>           return reshape_request(mddev, sector_nr, skipped);
>>       if (chunks_skipped >= conf->geo.raid_disks) {
>> -        /* if there has been nothing to do on any drive,
>> +        pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
>> +            test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" 
>> : "recovery");
>> +        if (error_disk >= 0 &&
>> +            !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
>> +            /*
>> +             * recovery fail, set mirrors.recovory_disabled,
> 
> recov*e*ry
> 
>> +             * device shouldn't be added to there.
>> +             */
>> +            conf->mirrors[error_disk].recovery_disabled =
>> +                        mddev->recovery_disabled;
>> +            return 0;
>> +        }
>> +        /*
>> +         * if there has been nothing to do on any drive,
>>            * then there is nothing to do at all..
> 
> Just one dot/period at the end?
>
Thanks for your suggestion. I will change it in next version.

-- 
Thanks,
Nan

