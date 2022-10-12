Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7845FBED9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJLBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJLBdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:33:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AE82D14;
        Tue, 11 Oct 2022 18:33:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MnFVW4z6fzKF7N;
        Wed, 12 Oct 2022 09:31:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnKMp6GUZjH6SIAA--.46401S3;
        Wed, 12 Oct 2022 09:33:48 +0800 (CST)
Subject: Re: [PATCH -next 4/5] blk-iocost: bypass if only one cgroup issues io
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-5-yukuai1@huaweicloud.com>
 <Y0WhpuqK/8CEZAGc@slm.duckdns.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c19008c3-512e-92cc-6be1-3ecc24e74341@huaweicloud.com>
Date:   Wed, 12 Oct 2022 09:33:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y0WhpuqK/8CEZAGc@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnKMp6GUZjH6SIAA--.46401S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww47Xr1kXr1fZw17Kw45Jrb_yoW8WFWkpr
        ZrGanYya98Wr92k3ZagaySq34Fq3yvg3W0yr1fCw15Ar9xCr9IyFs7Ar45CF18Zrs3XrWI
        qFsxJryrCF1UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tejun!

ÔÚ 2022/10/12 1:02, Tejun Heo Ð´µÀ:
> On Tue, Oct 11, 2022 at 04:35:46PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> In this special case, there is no need to throttle io.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-iocost.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 5acc5f13bbd6..32e7e416d67c 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -2564,8 +2564,13 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
>>   	bool use_debt, ioc_locked;
>>   	unsigned long flags;
>>   
>> -	/* bypass IOs if disabled, still initializing, or for root cgroup */
>> -	if (!ioc->enabled || !iocg || !iocg->level)
>> +	/*
>> +	 * bypass IOs if disabled, still initializing, for root cgroup,
>> +	 * or the cgroup is the only cgroup with io.
>> +	 */
>> +	if (!ioc->enabled || !iocg || !iocg->level ||
>> +	    (iocg->hweight_inuse == WEIGHT_ONE &&
>> +	     atomic_read(&ioc->hweight_gen) == iocg->hweight_gen))
> 
> I'm not sure about this one. Bypassing here means that we lose track of how
> much IO it's issuing which can affect future throttling decisions, right?

Yes, you're right, this patch doesn't look good in this case.

The reason why I tried to do this is because during test, I found that
io performance is affected when I only issue io from one cgroup£¨only
happened in some environment with default configuration£©, and I found
out that each io is throttled for some time before dispatching.

Perhaps a suitable configuration can avoid this problem.

Thanks,
Kuai

> 
> Thanks.
> 

