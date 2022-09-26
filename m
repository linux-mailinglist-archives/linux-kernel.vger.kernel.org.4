Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86A5EA8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiIZOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiIZOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:38:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82880BD0;
        Mon, 26 Sep 2022 06:00:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MbjWF1R2Rzl8LK;
        Mon, 26 Sep 2022 20:59:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXOAojFj4UO2BQ--.18700S3;
        Mon, 26 Sep 2022 21:00:50 +0800 (CST)
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, paolo.valente@linaro.org,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
 <Yy10vjnxAvca8Ee1@infradead.org>
 <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
 <20220923100659.a3atdanlvygffuxt@quack3>
 <95998ae6-8bbf-b438-801b-7033ceaf9c36@huaweicloud.com>
 <20220923110354.czvzm6rjm7mtqyh3@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5a2dba26-529d-295f-2e88-601475ff67bf@huaweicloud.com>
Date:   Mon, 26 Sep 2022 21:00:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220923110354.czvzm6rjm7mtqyh3@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXOAojFj4UO2BQ--.18700S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1fuFWkJFW7XFW8Zry3XFb_yoW5WrWxp3
        4fKay2kF48AFWxKwnFv348X34Fyw4xJr47WF1rA34kG3Z0vr1xJr1fKF4Y9a4q9r1xGw12
        yF98XrZxAr1kZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jan

在 2022/09/23 19:03, Jan Kara 写道:
> Hi Kuai!
> 
> On Fri 23-09-22 18:23:03, Yu Kuai wrote:
>> 在 2022/09/23 18:06, Jan Kara 写道:
>>> On Fri 23-09-22 17:50:49, Yu Kuai wrote:
>>>> Hi, Christoph
>>>>
>>>> 在 2022/09/23 16:56, Christoph Hellwig 写道:
>>>>> On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
>>>>>> wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED is disabled.
>>>>>
>>>>> Umm, wouldn't this be something decided at runtime, that is not
>>>>> if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel build
>>>>> if the hierarchical cgroup based scheduling is actually used for a
>>>>> given device?
>>>>> .
>>>>>
>>>>
>>>> That's a good point,
>>>>
>>>> Before this patch wbt is simply disabled if elevator is bfq.
>>>>
>>>> With this patch, if elevator is bfq while bfq doesn't throttle
>>>> any IO yet, wbt still is disabled unnecessarily.
>>>
>>> It is not really disabled unnecessarily. Have you actually tested the
>>> performance of the combination? I did once and the results were just
>>> horrible (which is I made BFQ just disable wbt by default). The problem is
>>> that blk-wbt assumes certain model of underlying storage stack and hardware
>>> behavior and BFQ just does not fit in that model. For example BFQ wants to
>>> see as many requests as possible so that it can heavily reorder them,
>>> estimate think times of applications, etc. On the other hand blk-wbt
>>> assumes that if request latency gets higher, it means there is too much IO
>>> going on and we need to allow less of "lower priority" IO types to be
>>> submitted. These two go directly against one another and I was easily
>>> observing blk-wbt spiraling down to allowing only very small number of
>>> requests submitted while BFQ was idling waiting for more IO from the
>>> process that was currently scheduled.
>>>
>>
>> Thanks for your explanation, I understand that bfq and wbt should not
>> work together.
>>
>> However, I wonder if CONFIG_BFQ_GROUP_IOSCHED is disabled, or service
>> guarantee is not needed, does the above phenomenon still exist? I find
>> it hard to understand... Perhaps I need to do some test.
> 
> Well, BFQ implements for example idling on sync IO queues which is one of
> the features that upsets blk-wbt. That does not depend on
> CONFIG_BFQ_GROUP_IOSCHED in any way. Also generally the idea that BFQ
> assigns storage *time slots* to different processes and IO from other
> processes is just queued at those times increases IO completion
> latency (for IOs of processes that are not currently scheduled) and this
> tends to confuse blk-wbt.
> 
Hi, Jan

Just to be curious, have you ever think about or tested wbt with
io-cost? And even more, how bfq work with io-cost?

I haven't tested yet, but it seems to me some of them can work well
together.

Thanks,
Kuai
> 								Honza
> 

