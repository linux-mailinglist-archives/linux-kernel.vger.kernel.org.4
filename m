Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE069DCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjBUJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjBUJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:35:48 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249D24C95;
        Tue, 21 Feb 2023 01:35:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLZ063hBPz4f3n3k;
        Tue, 21 Feb 2023 17:35:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R9nkPRjmdvADg--.1845S3;
        Tue, 21 Feb 2023 17:35:36 +0800 (CST)
Subject: Re: [PATCH] block, bfq: free 'sync_bfqq' after bic_set_bfqq() in
 bfq_sync_bfqq_move()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        axboe@kernel.dk, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
 <20230221082905.3389012-1-yukuai1@huaweicloud.com>
 <78830e38-e7a4-24e5-277e-f8e5022c59ef@opensource.wdc.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <826a699f-8c35-700a-de54-e4bbfbc6e081@huaweicloud.com>
Date:   Tue, 21 Feb 2023 17:35:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <78830e38-e7a4-24e5-277e-f8e5022c59ef@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R9nkPRjmdvADg--.1845S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWDZr1rCF18XF1DArWUJwb_yoW8Aw18pw
        17KFs0kw48JrZ0g3W7A3W2qF1fXws5JryktryYgr4avF9xWr17tF4qkw15CFZagr1fCwsI
        qF98WrZ5Cr12ya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/02/21 17:14, Damien Le Moal 写道:
> On 2/21/23 17:29, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> As explained in commit b600de2d7d3a ("block, bfq: fix uaf for bfqq in
>> bic_set_bfqq()"), bfqq should not be freed before bic_set_bfqq().
>> However, this is broken while merging commit 9778369a2d6c ("block, bfq:
>> split sync bfq_queues on a per-actuator basis") from branch
>> for-6.3/block.
> 
> The patch looks OK to me, but the commit message is not super clear. What is
> broken exactly ?

1) bfq_sync_bfqq_move() is introduced in commit 9778369a2d6c ("block,
bfq: split sync bfq_queues on a per-actuator basis"), which is merged to
block/for-6.3 branch.

2) commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
is merged to mainline.

3) later, the fix for 2) b600de2d7d3a ("block, bfq: fix uaf for bfqq in
bic_set_bfqq()") is merged to mainline as well, however,
bfq_sync_bfqq_move() in block/for-6.3 branch is not changed.

4) At last, 1) is merged to mainline and bfq_sync_bfqq_move() is
still problematic.

Thanks,
Kuai
> 
>>
>> Fixes: 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bfq-cgroup.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index ea3638e06e04..89ffb3aa992c 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -746,8 +746,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>>   		 * old cgroup.
>>   		 */
>>   		bfq_put_cooperator(sync_bfqq);
>> -		bfq_release_process_ref(bfqd, sync_bfqq);
>>   		bic_set_bfqq(bic, NULL, true, act_idx);
>> +		bfq_release_process_ref(bfqd, sync_bfqq);
>>   	}
>>   }
>>   
> 

