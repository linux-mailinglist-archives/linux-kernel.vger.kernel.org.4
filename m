Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5E710DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbjEYN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjEYN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:56:00 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F5189;
        Thu, 25 May 2023 06:55:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QRqMT6t0Mz4f3jLy;
        Thu, 25 May 2023 21:55:49 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHdaG9kQYvAKA--.6595S3;
        Thu, 25 May 2023 21:55:51 +0800 (CST)
Message-ID: <e93da9cc-d92d-34c8-a820-1f2b211caf53@huaweicloud.com>
Date:   Thu, 25 May 2023 21:55:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] md/raid10: fix null-ptr-deref of mreplace in
 raid10_sync_request
To:     Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
        song@kernel.org, shli@fb.com, allenpeng@synology.com,
        alexwu@synology.com, bingjingc@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
 <20230522115449.2203939-2-linan666@huaweicloud.com>
 <6c2d40de-7b8c-d84d-d9a2-7c5dce7471aa@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <6c2d40de-7b8c-d84d-d9a2-7c5dce7471aa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHdaG9kQYvAKA--.6595S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkuryDury7Cw4rCFWkCrg_yoW8Gr1Dpw
        4kXas7uryUGws2k3WDX3WDuFySgw1xt345Cry5Xa4rZr15JrW2gFW0grWYgF1DXF4rKa4j
        qr1UtFZxZF18taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/22 21:01, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/22 19:54, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> need_replace will be set to 1 if no-Faulty mreplace exists, and mreplace
>> will be deref later. However, the latter check of mreplace might set
>> mreplace to NULL, null-ptr-deref occurs if need_replace is 1 at this 
>> time.
>>
>> Fix it by merging two checks into one. And replace 'need_replace' with
>> 'mreplace' because their values are always the same.
>>
>> Fixes: ee37d7314a32 ("md/raid10: Fix raid10 replace hang when new 
>> added disk faulty")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/raid10.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 4fcfcb350d2b..e21502c03b45 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -3438,7 +3438,6 @@ static sector_t raid10_sync_request(struct mddev 
>> *mddev, sector_t sector_nr,
>>               int must_sync;
>>               int any_working;
>>               int need_recover = 0;
> 
> need_recover can be removed as well. Otherwise, this patch looks good to
> me.
> 

I agree. Let me improve this in v2.
-- 
Thanks,
Nan

