Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90821637A21
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKXNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKXNo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:44:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD83F5A1B;
        Thu, 24 Nov 2022 05:44:26 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHzjh4zthz15MqW;
        Thu, 24 Nov 2022 21:43:52 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:44:24 +0800
Subject: Re: [PATCH] block: fix crash in 'blk_mq_elv_switch_none'
To:     Ye Bin <yebin@huaweicloud.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221107033956.3276891-1-yebin@huaweicloud.com>
CC:     <ming.lei@redhat.com>,
        <syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <637F7538.1050002@huawei.com>
Date:   Thu, 24 Nov 2022 21:44:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221107033956.3276891-1-yebin@huaweicloud.com>
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

ping...

On 2022/11/7 11:39, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Syzbot found the following issue:
> general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
> CPU: 0 PID: 5234 Comm: syz-executor931 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:__elevator_get block/elevator.h:94 [inline]
> RIP: 0010:blk_mq_elv_switch_none block/blk-mq.c:4593 [inline]
> RIP: 0010:__blk_mq_update_nr_hw_queues block/blk-mq.c:4658 [inline]
> RIP: 0010:blk_mq_update_nr_hw_queues+0x304/0xe40 block/blk-mq.c:4709
> RSP: 0018:ffffc90003cdfc08 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 000000000000001d RSI: 0000000000000002 RDI: 00000000000000e8
> RBP: ffff88801dbd0000 R08: ffff888027c89398 R09: ffffffff8de2e517
> R10: fffffbfff1bc5ca2 R11: 0000000000000000 R12: ffffc90003cdfc70
> R13: ffff88801dbd0008 R14: ffff88801dbd03f8 R15: ffff888027c89380
> FS:  0000555557259300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005d84c8 CR3: 000000007a7cb000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   nbd_start_device+0x153/0xc30 drivers/block/nbd.c:1355
>   nbd_start_device_ioctl drivers/block/nbd.c:1405 [inline]
>   __nbd_ioctl drivers/block/nbd.c:1481 [inline]
>   nbd_ioctl+0x5a1/0xbd0 drivers/block/nbd.c:1521
>   blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> As after dd6f7f17bf58 commit move '__elevator_get(qe->type)' before set
> 'qe->type', so will lead to access wild pointer.
> To solve above issue get 'qe->type' after set 'qe->type'.
>
> Reported-by: syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com
> Fixes:dd6f7f17bf58("block: add proper helpers for elevator_type module refcount management")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2757368dc83f..3173d621f1f7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4589,9 +4589,9 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
>   
>   	INIT_LIST_HEAD(&qe->node);
>   	qe->q = q;
> +	qe->type = q->elevator->type;
>   	/* keep a reference to the elevator module as we'll switch back */
>   	__elevator_get(qe->type);
> -	qe->type = q->elevator->type;
>   	list_add(&qe->node, head);
>   	elevator_disable(q);
>   	mutex_unlock(&q->sysfs_lock);

