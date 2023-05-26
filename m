Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10F711E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEZCzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:55:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99559BB;
        Thu, 25 May 2023 19:55:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QS8gH5Hmxz4f3pCR;
        Fri, 26 May 2023 10:55:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7OsH3BkvufoKA--.48588S3;
        Fri, 26 May 2023 10:55:40 +0800 (CST)
Subject: Re: [PATCH 2/3] md/raid10: fix incorrect done of recovery
To:     Li Nan <linan666@huaweicloud.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        shli@fb.com, allenpeng@synology.com, alexwu@synology.com,
        bingjingc@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
 <20230522115449.2203939-3-linan666@huaweicloud.com>
 <801a3a11-9a2c-dca2-cec4-4a9c71d3afb6@huaweicloud.com>
 <10e164cc-149f-baf6-de52-0b7d3c9468f6@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1398a108-90ab-3790-eb43-faeaacda2c99@huaweicloud.com>
Date:   Fri, 26 May 2023 10:55:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <10e164cc-149f-baf6-de52-0b7d3c9468f6@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7OsH3BkvufoKA--.48588S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5XF45ZF1xAr4UCFWfKrg_yoW8KrW3pw
        s7JFZIqryUG3s5Aw1jkryUAFyrt348t34UJr1xWa4fXFZIqryqgFy8Xr4vgFyDXr48tF1U
        tw1jqFW3uFy2yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
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

在 2023/05/25 22:00, Li Nan 写道:
> 
> 
> 在 2023/5/22 21:54, Yu Kuai 写道:
>> Hi,
>>
>> 在 2023/05/22 19:54, linan666@huaweicloud.com 写道:
>>> From: Li Nan <linan122@huawei.com>
>>>
>>> Recovery will go to giveup and let chunks_skipped++ in
>>> raid10_sync_request() if there are some bad_blocks, and it will return
>>> max_sector when chunks_skipped >= geo.raid_disks. Now, recovery fail and
>>> data is inconsistent but user think recovery is done, it is wrong.
>>>
>>> Fix it by set mirror's recovery_disabled and spare device shouln't be
>>> added to here.
>>>
>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>> ---
>>>   drivers/md/raid10.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>> index e21502c03b45..70cc87c7ee57 100644
>>> --- a/drivers/md/raid10.c
>>> +++ b/drivers/md/raid10.c
>>> @@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct 
>>> mddev *mddev, sector_t sector_nr,
>>>       int chunks_skipped = 0;
>>>       sector_t chunk_mask = conf->geo.chunk_mask;
>>>       int page_idx = 0;
>>> +    int error_disk = -1;
>>>       /*
>>>        * Allow skipping a full rebuild for incremental assembly
>>> @@ -3386,7 +3387,18 @@ static sector_t raid10_sync_request(struct 
>>> mddev *mddev, sector_t sector_nr,
>>>           return reshape_request(mddev, sector_nr, skipped);
>>>       if (chunks_skipped >= conf->geo.raid_disks) {
>>> -        /* if there has been nothing to do on any drive,
>>> +        pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
>>> +            test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" 
>>> : "recovery");
>>
>> Line exceed 80 columns, and following.
>>> +        if (error_disk >= 0 && !test_bit(MD_RECOVERY_SYNC, 
>>> &mddev->recovery)) {
>>
>> Resync has the same problem, right?
>>
> 
> Yes. But I have no idea to fix it. md_error disk nor set 
> recovery_disabled is a good solution. So, just print error message now.
> Do you have any ideas?

I'll look into this, in the meadtime, I don't suggest to apply this
patch because this is just temporary solution that only fix half of
the problem.

Thanks,
Kuai

