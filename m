Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719B629BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKOOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiKOOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:18:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E236E2C135;
        Tue, 15 Nov 2022 06:18:19 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBSqC1hj0zqSLC;
        Tue, 15 Nov 2022 22:14:31 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 22:18:17 +0800
Subject: Re: [PATCH -next] blk-mq: fix warning when unregister mq sysfs
To:     Ming Lei <ming.lei@redhat.com>, Ye Bin <yebin@huaweicloud.com>
References: <20221112082813.704873-1-yebin@huaweicloud.com>
 <Y3Gi+Yt0nyYPx6hX@T590>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63739FA9.2010701@huawei.com>
Date:   Tue, 15 Nov 2022 22:18:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <Y3Gi+Yt0nyYPx6hX@T590>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 10:07, Ming Lei wrote:
> On Sat, Nov 12, 2022 at 04:28:13PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows when do fault injection test:
>> ------------[ cut here ]------------
>> kernfs: can not remove 'nr_tags', no directory
>> WARNING: CPU: 8 PID: 2308 at fs/kernfs/dir.c:1635 kernfs_remove_by_name_ns+0xdd/0x100
>> Modules linked in: null_blk(-)
>> CPU: 8 PID: 2308 Comm: rmmod Not tainted 6.1.0-rc4-next-20221111+ #131
>> RIP: 0010:kernfs_remove_by_name_ns+0xdd/0x100
>> RSP: 0018:ffff88812149fbc8 EFLAGS: 00010282
>> RAX: 0000000000000000 RBX: ffffffffb8137508 RCX: 0000000000000000
>> RDX: 0000000000000001 RSI: ffffffffb6b49ae0 RDI: ffffed1024293f6b
>> RBP: ffffffffb8137600 R08: 0000000000000001 R09: ffffed1024293f3d
>> R10: ffff88812149f9e7 R11: ffffed1024293f3c R12: 0000000000000000
>> R13: ffffffffb6b2d2a0 R14: ffffffffb6b2d1e0 R15: ffff88822f7f14b8
>> FS:  00007f97eacb9740(0000) GS:ffff8883ace00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f97e9b72b81 CR3: 000000022fbda000 CR4: 00000000000006e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   remove_files.isra.0+0x6c/0x170
>>   sysfs_remove_group+0x9b/0x180
>>   sysfs_remove_groups+0x4f/0xa0
>>   __kobject_del+0x7d/0x1d0
>>   kobject_del+0x32/0x50
>>   blk_mq_sysfs_unregister.cold+0x8/0xd
>>   blk_unregister_queue+0xed/0x260
>>   del_gendisk+0x27e/0x900
>>   null_del_dev.part.0+0x166/0x510 [null_blk]
>>   null_destroy_dev+0x37/0x5c [null_blk]
>>   null_exit+0x4c/0x9d [null_blk]
>>   __do_sys_delete_module.isra.0+0x2f3/0x520
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>   </TASK>
>>
>> Fault injection context as follows:
>>   kobject_add
>>   blk_mq_register_hctx
>>   blk_mq_sysfs_register
>>   blk_register_queue
>>   device_add_disk
>>   null_add_dev.part.0 [null_blk]
>>
>> As 'blk_mq_sysfs_register' may failed, but when unregister mq sysfs don't
>> judge sysfs if registered. 'blk_mq_sysfs_register' also didn't handle
>> error correctly.
>> To solve above issue, if sysfs is unregstered just exit.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   block/blk-mq-sysfs.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>> index 93997d297d42..0cda0a729f3c 100644
>> --- a/block/blk-mq-sysfs.c
>> +++ b/block/blk-mq-sysfs.c
>> @@ -185,7 +185,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>>   {
>>   	struct request_queue *q = hctx->queue;
>>   	struct blk_mq_ctx *ctx;
>> -	int i, ret;
>> +	int i, j, ret;
>>   
>>   	if (!hctx->nr_ctx)
>>   		return 0;
>> @@ -197,9 +197,16 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>>   	hctx_for_each_ctx(hctx, ctx, i) {
>>   		ret = kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu);
>>   		if (ret)
>> -			break;
>> +			goto out;
>>   	}
>>   
>> +	return 0;
>> +out:
>> +	hctx_for_each_ctx(hctx, ctx, j) {
>> +		if (j < i)
>> +			kobject_del(&ctx->kobj);
>> +	}
>> +	kobject_del(&hctx->kobj);
> The above change looks fine.
I will send v2 patch for this part.
>>   	return ret;
>>   }
>>   
>> @@ -278,6 +285,8 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>>   	struct blk_mq_hw_ctx *hctx;
>>   	unsigned long i;
>>   
>> +	if (!q->mq_sysfs_init_done)
>> +		return;
> The above should be one warning, and I suggest to handle failure of blk_mq_sysfs_register
> from blk_register_queue() in this patch too.
>
> Thanks,
> Ming
>
> .
I think "[PATCH 3/5] block: fix error unwinding in blk_register_queue" 
already do what your suggest.

