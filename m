Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B577466711B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjALLku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjALLje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:39:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1E18694;
        Thu, 12 Jan 2023 03:30:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nt2Qk4P7xz4f3r9D;
        Thu, 12 Jan 2023 19:30:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R89779jfPvFBQ--.32138S3;
        Thu, 12 Jan 2023 19:30:07 +0800 (CST)
Subject: Re: [PATCH] block: bfq fix null pointer dereference of bfqg in
 bfq_bio_bfqg()
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Anton Fadeev <anton.fadeev@red-soft.ru>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230112094358.451029-1-artem.chernyshev@red-soft.ru>
 <c72f2e00-1bd8-213c-585d-d465d6c34a14@huaweicloud.com>
 <Y7/uCLzIu7Ir6JtK@localhost.localdomain>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0e0c195e-5a92-732f-d0b4-2e0d9b33d742@huaweicloud.com>
Date:   Thu, 12 Jan 2023 19:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7/uCLzIu7Ir6JtK@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R89779jfPvFBQ--.32138S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1fJF4fuF1DGr1rZr1UZFb_yoWrCry3pF
        47JFsFkw4xtr1DZa1jv3WDJw10grs5AFnrXw129w13tFn0grnrJF1rJr4UWryDtw15Zr17
        Jwn8X340vr1qkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Jan.

在 2023/01/12 19:24, Artem Chernyshev 写道:
> Hi,
> On Thu, Jan 12, 2023 at 07:09:10PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/01/12 17:43, Artem Chernyshev 写道:
>>> It is possible for bfqg to be NULL after being initialized as result of
>>> blkg_to_bfqg() function.
>>>
>>> That was achieved on kernel 5.15.78, but should exist in mainline as
>>> well
>>
>> The problem is already fixed in mainline by following patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f02be9002c480cd3ec0fcf184ad27cf531bd6ece
>>
>> Thanks,
>> Kuai
>>>
>>> host1 login: [ 460.855794] watchdog: watchdog0: watchdog did not stop!
>>> [  898.944512] BUG: kernel NULL pointer dereference, address: 0000000000000094
>>> [  899.285776] #PF: supervisor read access in kernel mode
>>> [  899.536511] #PF: error_code(0x0000) - not-present page
>>> [  899.647305]  connection4:0: detected conn error (1020)
>>> [  899.786794] PGD 0 P4D 0
>>> [  899.786799] Oops: 0000 [#1] SMP PTI
>>> [  899.786802] CPU: 15 PID: 6073 Comm: ID iothread1 Not tainted 5.15.78-1.el7virt.x86_64 #1
>>> [  899.786804] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
>>> [  899.786806] RIP: 0010:bfq_bio_bfqg+0x26/0x80
>>> [  901.325944] Code: 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 89 f7 53 48 8b 56 48 48 85 d2
>>> 74 32 48 63 05 83 7f 35 01 48 83 c0 16 48 8b 5c c2 08 <80> bb 94 00 00 00 00 00
>>> [  902.237825] RSP: 0018:ffffae2649437688 EFLAGS: 00010002
>>> [  902.493396] RAX: 0000000000000019 RBX: 0000000000000000 RCX: dead000000000122
>>> [  902.841529] RDX: ffff8b6012cb3a00 RSI: ffff8b71002bbed0 RDI: ffff8b71002bbed0
>>> [  903.189374] RBP: ffff8b601c46e800 R08: ffffae26494377c8 R09: 0000000000000000
>>> [  903.532985] R10: 0000000000000001 R11: 0000000000000008 R12: ffff8b6f844c5b30
>>> [  903.880809] R13: ffff8b601c46e800 R14: ffffae2649437760 R15: ffff8b601c46e800
>>> [  904.220054] FS:  00007fec2fc4a700(0000) GS:ffff8b7f7f640000(0000) kn1GS:00000000000000000
>>> [  904.614349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  904.894717] CR2: 0000000000000094 CR3: 0000000111fd8002 CR4: 00000000003726e0
>>> [  905.243702] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [  905.592493] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [  905.936859] Call Trace:
>>> [  906.055955] <TASK>
>>> [  906.158109] bfq_bic_update_cgroup+0x2c/0x1f0
>>> [  906.371057] bfq_insert_requests+0x2c2/0x1fb0
>>> [  906.579207] blk_mq_sched_insert_request+0xc2/0x140
>>> [  906.817640] __blk_mq_try_issue_directly+0xe0/0x1f0
>>> [  907.055737] blk_mq_request_issue_directly+0x4e/0xa0
>>> [  907.298547] dm_mq_queue_rq+0x217/0x3e0
>>> [  907.485935] blk_mq_dispatch_rq_list+0x14b/0x860
>>> [  907.711973] ? sbitmap_get+0x87/0x1a0
>>> [  907.890370] blk_mq_do_dispatch_sched+0x350/0x3b0
>>> [  908.074869] NMI watchdog: Watchdog detected hard LOCKUP on cpu 40
>>>
>>> Fixes: 075a53b78b81 ("bfq: Make sure bfqg for which we are queueing requests is online")
>>> Co-developed-by: Anton Fadeev <anton.fadeev@red-soft.ru>
>>> Signed-off-by: Anton Fadeev <anton.fadeev@red-soft.ru>
>>> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
>>> ---
>>>    block/bfq-cgroup.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>>> index 1b2829e99dad..d4e9428cdbe5 100644
>>> --- a/block/bfq-cgroup.c
>>> +++ b/block/bfq-cgroup.c
>>> @@ -616,7 +616,7 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
>>>    			continue;
>>>    		}
>>>    		bfqg = blkg_to_bfqg(blkg);
>>> -		if (bfqg->online) {
>>> +		if (bfqg && bfqg->online) {
>>>    			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
>>>    			return bfqg;
>>>    		}
>>>
> 
> Sorry, forgot to mention, what behaviour was the same after we applied this patch. Issue
> was resolved only when we added NULL checking for bfqg.

So, you mean that blkg is still online, while blkg_to_bfqg() return
NULL. Can you explan how this is possible? I can't figure out how this
is possible...

Thanks,
Kuai
> 
> Thanks,
> Artem
> 
> .
> 

