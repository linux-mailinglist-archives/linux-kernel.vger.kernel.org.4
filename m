Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8770F654020
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiLVLyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiLVLwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:52:40 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253682B268;
        Thu, 22 Dec 2022 03:49:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nd7rQ5mnrz4f3jJ9;
        Thu, 22 Dec 2022 19:49:10 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgBXDbE4RKRjA31EAQ--.22363S2;
        Thu, 22 Dec 2022 19:49:13 +0800 (CST)
Subject: Re: [PATCH RESEND v2 2/5] sbitmap: remove redundant check in
 __sbitmap_queue_get_batch
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-3-shikemeng@huaweicloud.com>
 <20221222112319.26wtwxeyry6ybvse@quack3>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <792b0caa-0e99-94b2-60bf-90ad719c63d7@huaweicloud.com>
Date:   Thu, 22 Dec 2022 19:49:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221222112319.26wtwxeyry6ybvse@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBXDbE4RKRjA31EAQ--.22363S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rJw15Cry8tw1xJrWUArb_yoW8uw1xp3
        yUJa47Gw4vqFy7Zws7A3yUZF10ya1vkry3Gr4fKrZIkr1YkF1Yqr18Ca1S9F1xuFnYy3W7
        Z3yrXas7u3y5XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jan, thanks for review.
on 12/22/2022 7:23 PM, Jan Kara wrote:
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index cb5e03a2d65b..11e75f4040fb 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -518,11 +518,9 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>>  
>>  			get_mask = ((1UL << nr_tags) - 1) << nr;
>>  			val = READ_ONCE(map->word);
>> -			do {
>> -				if ((val & ~get_mask) != val)
>> -					goto next;
>> -			} while (!atomic_long_try_cmpxchg(ptr, &val,
>> -							  get_mask | val));
>> +			while (!atomic_long_try_cmpxchg(ptr, &val,
>> +							  get_mask | val))
>> +				;
>>  			get_mask = (get_mask & ~val) >> nr;
>>  			if (get_mask) {
>>  				*offset = nr + (index << sb->shift);
> 
> So I agree this will result in correct behavior but it can change
> performance. In the original code, we end up doing
> atomic_long_try_cmpxchg() only for words where we have a chance of getting
> all tags allocated. Now we just accept any word where we could allocate at
> least one bit. Frankly the original code looks rather restrictive and also
> the fact that we look only from the first zero bit in the word looks
> unnecessarily restrictive so maybe I miss some details about what's
> expected from __sbitmap_queue_get_batch(). So all in all I wanted to point
> out this needs more scrutiny from someone understanding better expectations
> from __sbitmap_queue_get_batch().
In the very beginning, __sbitmap_queue_get_batch will return if we only
get partial tags allocated. Recent commit fbb564a557809 ("lib/sbitmap: Fix
invalid loop in __sbitmap_queue_get_batch()") thought we may reuse busying
bits in old codes and change behavior of __sbitmap_queue_get_batch() to get
all tags. However we will not reuse busying bits in old codes actually. So
I try to revert this wrong fix and keep the behavior of
__sbitmap_queue_get_batch() as it designed to be at beginning.

Besides, if we keep to get all tags,the check below is redundant.
	get_mask = (get_mask & ~ret) >> nr;
	if (get_mask) {
		...
	}
As we only reach here if we get all tags and the check above will always
pass. So this check in old codes should be removed.

-- 
Best wishes
Kemeng Shi

