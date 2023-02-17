Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1469A35E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBQBYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQBYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:24:49 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3D1518E6;
        Thu, 16 Feb 2023 17:24:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PHvHb3kt1z4f3jHx;
        Fri, 17 Feb 2023 09:24:43 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgAH_htc1+5jVaXADQ--.64748S2;
        Fri, 17 Feb 2023 09:24:45 +0800 (CST)
Subject: Re: [PATCH 13/21] ext4: remove dead check in mb_buddy_mark_free
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-14-shikemeng@huaweicloud.com>
 <Y+qUdLKXgWFrWlck@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <9f40d1c8-4aaa-2488-43e0-4c82aff0779a@huaweicloud.com>
Date:   Fri, 17 Feb 2023 09:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y+qUdLKXgWFrWlck@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgAH_htc1+5jVaXADQ--.64748S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykGF13Xr4kKFWDAr1DKFg_yoW8XrW7pF
        WfGasYkr1kGw1vkanrKr48K34kKw42gFyUArW5XF18CrZrJr9Y9F95tFn09F17urZ5A3WS
        qFsFqFZ8Cry3uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 2/14/2023 3:50 AM, Ojaswin Mujoo wrote:
> On Fri, Feb 10, 2023 at 03:48:17AM +0800, Kemeng Shi wrote:
>> We always adjust first to even number and adjust last to odd number, so
>> first == last will never happen. Remove this dead check.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index bdabe0d81d4a..0fdbf16ac180 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1718,7 +1718,8 @@ static void mb_buddy_mark_free(struct ext4_buddy *e4b, int first, int last)
>>  			break;
>>  		order++;
>>  
>> -		if (first == last || !(buddy2 = mb_find_buddy(e4b, order, &max))) {
>> +		buddy2 = mb_find_buddy(e4b, order, &max);
>> +		if (!buddy2) {
>>  			mb_clear_bits(buddy, first, last - first + 1);
>>  			e4b->bd_info->bb_counters[order - 1] += last - first + 1;
>>  			break;
>> -- 
>> 2.30.0
>>
> Okay, so I checked the code and seems like you are right. There is can't be any
> scenario where (first == last) after the calls to mb_buddy_adjust_border().
> 
> However, I'm a bit hesitant to give my Reviewed by since buddy algo is still a
> bit confusing to me and I might be missing some weird edge case.  Maybe someone
> can help double check this.
Hi, could anyone help double check this patch and patch 18/21 "ext4: remove
unnecessary goto in ext4_mb_mark_diskspace_used" in the same patchset. Thanks.

-- 
Best wishes
Kemeng Shi

