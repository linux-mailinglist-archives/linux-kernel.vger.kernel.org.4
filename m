Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78673CFA9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFYJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:16:38 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A163D2;
        Sun, 25 Jun 2023 02:16:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qplhw4sfRz4f4DhZ;
        Sun, 25 Jun 2023 17:16:32 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7PwBZhkKbn6MQ--.46979S3;
        Sun, 25 Jun 2023 17:16:33 +0800 (CST)
Message-ID: <1f48c2d9-3e51-d8bf-466a-bb1fe9e07282@huaweicloud.com>
Date:   Sun, 25 Jun 2023 17:16:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/4] block/badblocks: fix badblocks loss when badblocks
 combine
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     axboe@kernel.dk, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>, linan122@huawei.com
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-4-linan666@huaweicloud.com>
 <ZJMEtGw+FYT8mRG+@araj-dh-work>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZJMEtGw+FYT8mRG+@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7PwBZhkKbn6MQ--.46979S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF18ZFy3tF1DJr18Xw4UXFb_yoW8Zw17pw
        n5X3Wa9r1Igry09F1UX3WDGF1IganxJF4UGa15t3W5uryq9wn7KFn2qr1Yvry09F4xJFnY
        va1rWF9xXFy3G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E
        8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3
        JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IUbJ73PUUUUU==
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



在 2023/6/21 22:09, Ashok Raj 写道:
> On Thu, Jun 22, 2023 at 01:20:51AM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> badblocks will loss if we set it as below:
>>
>>    # echo 1 1 > bad_blocks
>>    # echo 3 1 > bad_blocks
>>    # echo 1 5 > bad_blocks
>>    # cat bad_blocks
>>      1 3
>>
>> In badblocks_set(), if there is an intersection between p[lo] and p[hi],
>> we will combine them. The end of new badblocks is p[hi]'s end now. but
>> p[lo] may cross p[hi] and new end should be the larger of p[lo] and p[hi].
> 
> Reconsider rewriting the commit log. It seems you converted code to
> sentence ;-).

I will rewrite log.

> 
> Also it might help to show after the patch how the above example would be
> for cat bad_blocks
> 

after patch:

# cat bad_blocks
   1 5

I will show it in next version. Thanks for your suggestion.

>>
>> Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/badblocks.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/badblocks.c b/block/badblocks.c
>> index 7e6ebe2ac12c..2c2ef8284a3f 100644
>> --- a/block/badblocks.c
>> +++ b/block/badblocks.c
>> @@ -267,16 +267,14 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>>   	if (sectors == 0 && hi < bb->count) {
>>   		/* we might be able to combine lo and hi */
>>   		/* Note: 's' is at the end of 'lo' */
>> -		sector_t a = BB_OFFSET(p[hi]);
>> -		int lolen = BB_LEN(p[lo]);
>> -		int hilen = BB_LEN(p[hi]);
>> -		int newlen = lolen + hilen - (s - a);
>> +		sector_t a = BB_OFFSET(p[lo]);
>> +		int newlen = max(s, BB_OFFSET(p[hi]) + BB_LEN(p[hi])) - a;
>>   
>> -		if (s >= a && newlen < BB_MAX_LEN) {
>> +		if (s >= BB_OFFSET(p[hi]) && newlen < BB_MAX_LEN) {
>>   			/* yes, we can combine them */
>>   			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
>>   
>> -			p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
>> +			p[lo] = BB_MAKE(a, newlen, ack);
>>   			memmove(p + hi, p + hi + 1,
>>   				(bb->count - hi - 1) * 8);
>>   			bb->count--;
>> -- 
>> 2.39.2
>>
> 
> .

-- 
Thanks,
Nan

