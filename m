Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836264B344
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiLMKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiLMKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:32:27 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383CB8;
        Tue, 13 Dec 2022 02:32:25 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NWZYv2YXNz4f3kpT;
        Tue, 13 Dec 2022 18:32:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgCH6bS0VJhjUsCFCA--.4892S3;
        Tue, 13 Dec 2022 18:32:22 +0800 (CST)
Subject: Re: [PATCH] block, bfq: fix possible uaf for 'bfqq->bic'
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221210102537.655670-1-yukuai1@huaweicloud.com>
 <20221212133537.hrs5t32ijj6lxoaf@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ba364ff7-c6eb-9005-2c4d-04857a7298c5@huaweicloud.com>
Date:   Tue, 13 Dec 2022 18:32:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221212133537.hrs5t32ijj6lxoaf@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCH6bS0VJhjUsCFCA--.4892S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kGF43WFWfZF45Zr4rGrg_yoWrWw15pr
        ZxJayxAw48JrWagw47Zw18t3WfXws3Wr47Jr1Sgr1xKrW5Ar13XFZ2yF1UZrWfWrykuay3
        WF1DJrZ7XryIva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jan!

在 2022/12/12 21:35, Jan Kara 写道:
> On Sat 10-12-22 18:25:37, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Our test report a uaf for 'bfqq->bic' in 5.10:
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30
>> Read of size 8 at addr ffff88810efb42d8 by task fsstress/2318352
>>
>> CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
>> Call Trace:
> ...
>>   bfq_select_queue+0x378/0xa30
>>   __bfq_dispatch_request+0x1c4/0x220
>>   bfq_dispatch_request+0xe8/0x130
>>   __blk_mq_do_dispatch_sched+0x3f4/0x560
>>   blk_mq_do_dispatch_sched+0x62/0xb0
>>   __blk_mq_sched_dispatch_requests+0x215/0x2a0
>>   blk_mq_sched_dispatch_requests+0x8f/0xd0
>>   __blk_mq_run_hw_queue+0x98/0x180
>>   __blk_mq_delay_run_hw_queue+0x22b/0x240
>>   blk_mq_run_hw_queue+0xe3/0x190
>>   blk_mq_sched_insert_requests+0x107/0x200
>>   blk_mq_flush_plug_list+0x26e/0x3c0
>>   blk_finish_plug+0x63/0x90
>>   __iomap_dio_rw+0x7b5/0x910
>>   iomap_dio_rw+0x36/0x80
>>   ext4_dio_read_iter+0x146/0x190 [ext4]
>>   ext4_file_read_iter+0x1e2/0x230 [ext4]
>>   new_sync_read+0x29f/0x400
>>   vfs_read+0x24e/0x2d0
>>   ksys_read+0xd5/0x1b0
> 
> Perhaps we can trim this UAF report a bit to what I've left above? That
> should be enough to give idea about the problem.
Yes, of course.
> 
>> Commit 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
>> changes that move process to a new cgroup will allocate a new bfqq to
>> use, however, the old bfqq and new bfqq can point to the same bic:
>>
>> 1) Initial state, two process with io in the same cgroup.
>>
>> Process 1       Process 2
>>   (BIC1)          (BIC2)
>>    |  Λ            |  Λ
>>    |  |            |  |
>>    V  |            V  |
>>    bfqq1           bfqq2
>>
>> 2) bfqq1 is merged to bfqq2.
>>
>> Process 1       Process 2（cg1)
>>   (BIC1)          (BIC2)
>>    |               |
>>     \-------------\|
>>                    V
>>    bfqq1           bfqq2(coop)
>>
>> 3) Process 1 exit, then issue new io(denoce IOA) from Process 2.
>>
>>   (BIC2)
>>    |  Λ
>>    |  |
>>    V  |
>>    bfqq2(coop)
>>
>> 4) Before IOA is completed, move Process 2 to another cgroup and issue io.
>>
>> Process 2
>>   (BIC2)
>>     Λ
>>     |\--------------\
>>     |                V
>>    bfqq2           bfqq3
>>
>> Now that BIC2 points to bfqq3, while bfqq2 and bfqq3 both point to BIC2.
>> If all the requests are completed, and Process 2 exit, BIC2 will be
>> freed while there is no guarantee that bfqq2 will be freed before BIC2.
>>
>> Fix the problem by clearing bfqq->bic if process references is decreased
>> to zero, since that they are not related anymore.
>>
>> Fixes: 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Thanks for the analysis and the patch! I agree this is a problem.
> 
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index a72304c728fc..6eada99d1b34 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -3036,6 +3036,14 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>>   
>>   	bfq_reassign_last_bfqq(bfqq, NULL);
>>   
>> +	/*
>> +	 * __bfq_bic_change_cgroup() just reset bic->bfqq so that a new bfqq
>> +	 * will be created to handle new io, while old bfqq will stay around
>> +	 * until all the requests are completed. It's unsafe to keep bfqq->bic
>> +	 * since they are not related anymore.
>> +	 */
>> +	if (bfqq_process_refs(bfqq) == 1)
>> +		bfqq->bic = NULL;
>>   	bfq_put_queue(bfqq);
> 
> Rather than changing bfq_release_process_ref() I think it would be more
> logical to change bic_set_bfqq() like:
> 
> 	struct bfq_queue *old_bfqq = bic->bfqq[is_sync];
> 
> 	/* Clear bic pointer if we are detaching bfqq from its bic */
> 	if (old_bfqq && old_bfqq->bic == bic)
> 		old_bfqq->bic = NULL;
> 
> And then we can also remove several explicit bfqq->bic = NULL statements
> from bfq code.

Yes, I agree. I'll send a new patch soon.

Thanks,
Kuai
> 
> 								Honza
> 

