Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21B5BC0EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISBIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 21:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiISBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 21:08:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2513F32;
        Sun, 18 Sep 2022 18:08:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MW62c583vzlC86;
        Mon, 19 Sep 2022 09:06:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgA3inMKwSdjvhA5BA--.41419S3;
        Mon, 19 Sep 2022 09:08:28 +0800 (CST)
Subject: Re: [PATCH v3 5/5] md/raid10: convert resync_lock to use seqlock
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        logang@deltatee.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-6-yukuai1@huaweicloud.com>
 <e73dc8e8-09a3-ecc8-3199-ac87e8b9ee55@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a6364e1e-f661-9e32-9d49-5ec421d77025@huaweicloud.com>
Date:   Mon, 19 Sep 2022 09:08:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e73dc8e8-09a3-ecc8-3199-ac87e8b9ee55@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3inMKwSdjvhA5BA--.41419S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1kJr15KF1kZr48JrWrZrb_yoW8Cw4fpa
        nagFyayFyDWrn3trsxXw4Y9Fy5A3s7Ka4DGryIqa18ZFWYvrW09F4UWr9YgryDZrZ3t340
        qFyYg3Z3uFyftFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/09/18 19:36, Guoqing Jiang 写道:
> 
> 
> On 9/16/22 7:34 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, wait_barrier() will hold 'resync_lock' to read 
>> 'conf->barrier',
>> and io can't be dispatched until 'barrier' is dropped.
>>
>> Since holding the 'barrier' is not common, convert 'resync_lock' to use
>> seqlock so that holding lock can be avoided in fast path.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid10.c | 87 ++++++++++++++++++++++++++++++---------------
>>   drivers/md/raid10.h |  2 +-
>>   2 files changed, 59 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>> index 9a28abd19709..2daa7d57034c 100644
>> --- a/drivers/md/raid10.c
>> +++ b/drivers/md/raid10.c
>> @@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
>>   #include "raid1-10.c"
>> +#define NULL_CMD
>> +#define cmd_before(conf, cmd) \
>> +    do { \
>> +        write_sequnlock_irq(&(conf)->resync_lock); \
>> +        cmd; \
>> +    } while (0)
>> +#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)
> 
> The two is not paired well given only cmd_before needs the 'cmd'.

May be should I just remove cmd_after?
> 
>> +
>> +#define wait_event_barrier_cmd(conf, cond, cmd) \
>> +    wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf, cmd), \
>> +               cmd_after(conf))
>> +
>> +#define wait_event_barrier(conf, cond) \
>> +    wait_event_barrier_cmd(conf, cond, NULL_CMD)
> 
> What is the issue without define NULL_CMD?
> 

Checkpatch will complain this:

ERROR: space prohibited before that close parenthesis ')'
#38: FILE: drivers/md/raid10.c:94:
+       wait_event_barrier_cmd(conf, cond, )

total: 1 errors, 0 warnings, 169 lines checked

Thanks,
Kuai
> Thanks,
> Guoqing
> .
> 

