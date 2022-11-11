Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63D624F31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiKKA7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKA7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:59:08 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C6C48768;
        Thu, 10 Nov 2022 16:59:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7gM81Fpfz4f3kpJ;
        Fri, 11 Nov 2022 08:59:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdZVnm1jtHJLAQ--.61357S3;
        Fri, 11 Nov 2022 08:59:03 +0800 (CST)
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued
 tags
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221105231055.25953-1-krisman@suse.de>
 <2a445c5c-fd15-c0bf-8655-2fb5bde3fe67@huaweicloud.com>
 <20221110111636.ufgyp4tkbzexugk2@quack3>
 <210f2c3d-0bc1-0a5f-964b-d75020d3d9fb@huaweicloud.com>
 <20221110153533.go5qs3psm75h27mx@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <535d8806-9abb-4caf-d75b-4013a262415d@huaweicloud.com>
Date:   Fri, 11 Nov 2022 08:59:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221110153533.go5qs3psm75h27mx@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdZVnm1jtHJLAQ--.61357S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UZw48ZF15Aw47CFyrtFb_yoW5Xr1xpr
        WDG3WxCF4DXry7Kr4qqr4FvanavrW8t3s3Wr1rJa48Arn2yFsIvay8tr1F9r4kZr4kJw10
        qF15t39xWFyjva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

在 2022/11/10 23:35, Jan Kara 写道:
> Hi!
> 
> On Thu 10-11-22 21:18:19, Yu Kuai wrote:
>> 在 2022/11/10 19:16, Jan Kara 写道:
>>> Hi!
>>>
>>> On Thu 10-11-22 17:42:49, Yu Kuai wrote:
>>>> 在 2022/11/06 7:10, Gabriel Krisman Bertazi 写道:
>>>>> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>>>>>     {
>>>>> -	struct sbq_wait_state *ws;
>>>>> -	unsigned int wake_batch;
>>>>> -	int wait_cnt, cur, sub;
>>>>> -	bool ret;
>>>>> +	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
>>>>> +	struct sbq_wait_state *ws = NULL;
>>>>> +	unsigned int wakeups;
>>>>> -	if (*nr <= 0)
>>>>> -		return false;
>>>>> +	if (!atomic_read(&sbq->ws_active))
>>>>> +		return;
>>>>> -	ws = sbq_wake_ptr(sbq);
>>>>> -	if (!ws)
>>>>> -		return false;
>>>>> +	atomic_add(nr, &sbq->completion_cnt);
>>>>> +	wakeups = atomic_read(&sbq->wakeup_cnt);
>>>>> -	cur = atomic_read(&ws->wait_cnt);
>>>>>     	do {
>>>>> -		/*
>>>>> -		 * For concurrent callers of this, callers should call this
>>>>> -		 * function again to wakeup a new batch on a different 'ws'.
>>>>> -		 */
>>>>> -		if (cur == 0)
>>>>> -			return true;
>>>>> -		sub = min(*nr, cur);
>>>>> -		wait_cnt = cur - sub;
>>>>> -	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
>>>>> -
>>>>> -	/*
>>>>> -	 * If we decremented queue without waiters, retry to avoid lost
>>>>> -	 * wakeups.
>>>>> -	 */
>>>>> -	if (wait_cnt > 0)
>>>>> -		return !waitqueue_active(&ws->wait);
>>>>> +		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
>>>>> +			return;
>>>>
>>>> Should it be considered that completion_cnt overflow and becomes
>>>> negtive?
>>>
>>> Yes, the counters can (and will) certainly overflow but since we only care
>>> about (completion_cnt - wakeups), we should be fine - this number is always
>>> sane (and relatively small) and in the kernel we do compile with signed
>>> overflows being well defined.
>>
>> I'm worried about this: for example, the extreme scenaro that there
>> is only one tag, currently there are only one infight rq and one thread
>> is waiting for tag. When the infight rq complete, if 'completion_cnt'
>> overflow to negative, then 'atomic_read(&sbq->completion_cnt) - wakeups
>> < wake_batch' will be passed unexpected, then will the thread never be
>> woken up if there are no new io issued ?
> 
> Well but my point is that 'wakeups' is staying close to completion_cnt. So
> if completion_cnt wraps to INT_MIN, then 'wakeups' is close to INT_MAX and
> so completion_cnt - wakeups is going to wrap back and still result in a
> small number. That is simply how wrapping arithmetics works...

Yes, you're right, I'm being foolish here. 😆

Thanks,
Kuai
> 
> 								Honza
> 

