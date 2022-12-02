Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5505863FE30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiLBCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLBCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:34:52 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A3BC5B2;
        Thu,  1 Dec 2022 18:34:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NNcTw5WQ5z4f3lXp;
        Fri,  2 Dec 2022 10:34:44 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgA3Lq1GZIljssOsBQ--.4730S2;
        Fri, 02 Dec 2022 10:34:47 +0800 (CST)
Subject: Re: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to
 avoid lost wakeups
To:     Jens Axboe <axboe@kernel.dk>, Kemeng Shi <shikemeng@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang@huawei.com
References: <20221201045408.21908-1-shikemeng@huawei.com>
 <20221201045408.21908-2-shikemeng@huawei.com>
 <81e3f861-f163-c17c-49d4-2408f16c3350@huaweicloud.com>
 <e6a984e9-f597-d987-2eef-9c3dd8ae7f0e@kernel.dk>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <30ddb1b7-e4c6-50c5-6042-2c2bd13bb6b1@huaweicloud.com>
Date:   Fri, 2 Dec 2022 10:34:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <e6a984e9-f597-d987-2eef-9c3dd8ae7f0e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgA3Lq1GZIljssOsBQ--.4730S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15CrWkWw45Gry3KrW5Awb_yoW5Xr4Dpr
        48GFySy3W0qrW2krW7Xw1qqFya93ykKrsrGF4rK34qkanFvr9aqr40kF4j9FW8CFs5tFWj
        yr47X3sxGa4UXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 12/2/2022 8:58 AM, Jens Axboe wrote:
> On 12/1/22 12:21?AM, Kemeng Shi wrote:
>>
>>
>> on 12/1/2022 12:54 PM, Kemeng Shi wrote:
>>> If we decremented queue without waiters, we should not decremente freed
>>> bits number "nr", or all "nr" could be consumed in a empty queue and no
>>> wakeup will be called.
>>> Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
>>> decremented queue without watiers and retry is returned to avoid lost
>>> wakeups. However for case "wait_cnt == 0", "nr" will be decremented
>>> unconditionally and maybe decremented to zero. Although retry is
>>> returned by active state of queue, it's not actually executed for "nr"
>>> is zero.
>>>
>>> Fix this by only decrementing "nr" for active queue when "wait_cnt ==
>>> 0". After this fix, "nr" will always be non-zero when we decremented
>>> inactive queue for case "wait_cnt == 0", so the need to retry could
>>> be returned by "nr" and active state of waitqueue returned for the same
>>> purpose is not needed.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>>> ---
>>>  lib/sbitmap.c | 13 ++++++-------
>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>>> index 7280ae8ca88c..e40759bcf821 100644
>>> --- a/lib/sbitmap.c
>>> +++ b/lib/sbitmap.c
>>> @@ -604,7 +604,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>>  	struct sbq_wait_state *ws;
>>>  	unsigned int wake_batch;
>>>  	int wait_cnt, cur, sub;
>>> -	bool ret;
>>>  
>>>  	if (*nr <= 0)
>>>  		return false;
>>> @@ -632,15 +631,15 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>>  	if (wait_cnt > 0)
>>>  		return !waitqueue_active(&ws->wait);
>>>  
>>> -	*nr -= sub;
>>> -
>>>  	/*
>>>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>>>  	 * responsible to reset wait_cnt regardless whether we've actually
>>> -	 * woken up anybody. But in case we didn't wakeup anybody, we still
>>> -	 * need to retry.
>>> +	 * woken up anybody. But in case we didn't wakeup anybody, we should
>>> +	 * not consume nr and need to retry to avoid lost wakeups.
>>>  	 */
>>> -	ret = !waitqueue_active(&ws->wait);
>> There is a warnning reported by checkpatch.pl which is
>> "WARNING:waitqueue_active without comment" but I don't know why.
> 
> Most likely because waitqueue_active() could be racy, so a comment is
> warranted on why it's safe rather than using wq_has_sleeper().
Thanks for explanation, so the patch seems fine as comment is present
already though it doesn't mention sting "waitqueue_active" directly.
No bother anymore, this patch will be dropped as the fixed code is
stale.
Thanks again.

-- 
Best wishes
Kemeng Shi

