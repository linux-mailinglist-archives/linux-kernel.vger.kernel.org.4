Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE876624311
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKJNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKJNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:18:29 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1663A3;
        Thu, 10 Nov 2022 05:18:25 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N7Mpf1KwYz4f3vfX;
        Thu, 10 Nov 2022 21:18:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdYb+mxjjHEvAQ--.62147S3;
        Thu, 10 Nov 2022 21:18:21 +0800 (CST)
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <210f2c3d-0bc1-0a5f-964b-d75020d3d9fb@huaweicloud.com>
Date:   Thu, 10 Nov 2022 21:18:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221110111636.ufgyp4tkbzexugk2@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdYb+mxjjHEvAQ--.62147S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5Gr1DJF1ktr47Gw45ZFb_yoW8urWxpr
        WDGF17ZF4DXry7KrWDJw4FvayfZrWxt3s3Gr15JFy8A39Fyr4av3y8Kr1rCr4kZr4kG3W8
        tF4Yg39xW3Wjya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
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

Hi,

在 2022/11/10 19:16, Jan Kara 写道:
> Hi!
> 
> On Thu 10-11-22 17:42:49, Yu Kuai wrote:
>> 在 2022/11/06 7:10, Gabriel Krisman Bertazi 写道:
>>> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>>>    {
>>> -	struct sbq_wait_state *ws;
>>> -	unsigned int wake_batch;
>>> -	int wait_cnt, cur, sub;
>>> -	bool ret;
>>> +	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
>>> +	struct sbq_wait_state *ws = NULL;
>>> +	unsigned int wakeups;
>>> -	if (*nr <= 0)
>>> -		return false;
>>> +	if (!atomic_read(&sbq->ws_active))
>>> +		return;
>>> -	ws = sbq_wake_ptr(sbq);
>>> -	if (!ws)
>>> -		return false;
>>> +	atomic_add(nr, &sbq->completion_cnt);
>>> +	wakeups = atomic_read(&sbq->wakeup_cnt);
>>> -	cur = atomic_read(&ws->wait_cnt);
>>>    	do {
>>> -		/*
>>> -		 * For concurrent callers of this, callers should call this
>>> -		 * function again to wakeup a new batch on a different 'ws'.
>>> -		 */
>>> -		if (cur == 0)
>>> -			return true;
>>> -		sub = min(*nr, cur);
>>> -		wait_cnt = cur - sub;
>>> -	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
>>> -
>>> -	/*
>>> -	 * If we decremented queue without waiters, retry to avoid lost
>>> -	 * wakeups.
>>> -	 */
>>> -	if (wait_cnt > 0)
>>> -		return !waitqueue_active(&ws->wait);
>>> +		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
>>> +			return;
>>
>> Should it be considered that completion_cnt overflow and becomes
>> negtive?
> 
> Yes, the counters can (and will) certainly overflow but since we only care
> about (completion_cnt - wakeups), we should be fine - this number is always
> sane (and relatively small) and in the kernel we do compile with signed
> overflows being well defined.

I'm worried about this: for example, the extreme scenaro that there
is only one tag, currently there are only one infight rq and one thread
is waiting for tag. When the infight rq complete, if 'completion_cnt'
overflow to negative, then 'atomic_read(&sbq->completion_cnt) - wakeups
< wake_batch' will be passed unexpected, then will the thread never be
woken up if there are no new io issued ?

Thanks,
Kuai
> 
> 								Honza
> 

