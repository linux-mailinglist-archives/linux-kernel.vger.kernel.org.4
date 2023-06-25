Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D085D73CFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFYJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:22:15 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA516D2;
        Sun, 25 Jun 2023 02:22:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QplqN4zBSz4f3kp9;
        Sun, 25 Jun 2023 17:22:08 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK9AB5hkSAb7MQ--.48063S3;
        Sun, 25 Jun 2023 17:22:10 +0800 (CST)
Message-ID: <907bbe2d-9cbf-480c-be57-3289d113c42a@huaweicloud.com>
Date:   Sun, 25 Jun 2023 17:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/4] block/badblocks: fix the bug of reverse order
To:     Ashok Raj <ashok_raj@linux.intel.com>, linan666@huaweicloud.com
Cc:     axboe@kernel.dk, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>, linan122@huawei.com
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-5-linan666@huaweicloud.com>
 <ZJMGDLkRbaVD9VA8@araj-dh-work>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZJMGDLkRbaVD9VA8@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK9AB5hkSAb7MQ--.48063S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDWryxuw13Aw1UXF1xuFg_yoW8GFy8pr
        n8J3Zakr1jgr1jg3WDX3WUKryIg34ftF4UGa1UXF1UCF9xGwn7KF1v9w4YgFy2qrsxGrnY
        v3W3uryYva4rCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
        4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUlQ6LUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/21 22:15, Ashok Raj 写道:
> On Thu, Jun 22, 2023 at 01:20:52AM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> Order of badblocks will be reversed if we set a large area at once. 'hi'
>> remains unchanged while adding continuous badblocks is wrong, the next
>> setting is greater than 'hi', it should be added to the next position.
>> Let 'hi' +1 each cycle.
> 
> The commitlog needs more work.

OK, I will improve this.

>>
>>    # echo 0 2048 > bad_blocks
>>    # cat bad_blocks
>>      1536 512
>>      1024 512
>>      512 512
>>      0 512
> 
> Is the above before or after this patch is applied?

All badblocks are arranged from small to large. after patch:

# cat bad_blocks
   0 512
   512 512
   1024 512
   1536 512

I will show it in next version. Thanks for your suggestion.

> 
>>
>> Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   block/badblocks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/badblocks.c b/block/badblocks.c
>> index 2c2ef8284a3f..3b816690b940 100644
>> --- a/block/badblocks.c
>> +++ b/block/badblocks.c
>> @@ -301,6 +301,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>>   			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
>>   			sectors -= this_sectors;
>>   			s += this_sectors;
>> +			hi++;
>>   			changed = true;
>>   		}
>>   	}
>> -- 
>> 2.39.2
>>
> 
> .

-- 
Thanks,
Nan

