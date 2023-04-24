Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCF6DC50E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDJJYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:24:12 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062E1730
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:24:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfkPxk1_1681118645;
Received: from 30.97.49.25(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfkPxk1_1681118645)
          by smtp.aliyun-inc.com;
          Mon, 10 Apr 2023 17:24:06 +0800
Message-ID: <723ddab6-9298-6021-27a9-872aa389ef16@linux.alibaba.com>
Date:   Mon, 10 Apr 2023 17:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [syzbot] BUG: spinlock bad magic in erofs_pcpubuf_growsize
To:     syzbot <syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <00000000000012002d05bf8dec8d@google.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000012002d05bf8dec8d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(avoid Cc such many people...)

On 2021/4/10 01:59, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c54130c Add linux-next specific files for 20210406
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1654617ed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d125958c3995ddcd
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6a0e4b80bd39f54c2f6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101a5786d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1147dd0ed00000
> 
> The issue was bisected to:
> 
> commit 997acaf6b4b59c6a9c259740312a69ea549cc684
> Author: Mark Rutland <mark.rutland@arm.com>
> Date:   Mon Jan 11 15:37:07 2021 +0000
> 
>      lockdep: report broken irq restoration
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d8d7aad00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d8d7aad00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d8d7aad00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d6a0e4b80bd39f54c2f6@syzkaller.appspotmail.com
> Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")
> 
> loop0: detected capacity change from 0 to 31
> BUG: spinlock bad magic on CPU#1, syz-executor062/8434
>   lock: 0xffff8880b9c31d60, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 1 PID: 8434 Comm: syz-executor062 Not tainted 5.12.0-rc6-next-20210406-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>   debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>   do_raw_spin_lock+0x216/0x2b0 kernel/locking/spinlock_debug.c:112
>   erofs_pcpubuf_growsize+0x36f/0x620 fs/erofs/pcpubuf.c:83

This issue only existed in some linux-next (2021/04/06 ~ 2021/04/06) and
Linux upstream never hitted such issue, so:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.3-rc6

#syz invalid

Thanks,
Gao Xiang

>   z_erofs_load_lz4_config+0x1ef/0x3e0 fs/erofs/decompressor.c:64
>   erofs_read_superblock fs/erofs/super.c:331 [inline]
>   erofs_fc_fill_super+0xe84/0x1d10 fs/erofs/super.c:499
>   get_tree_bdev+0x440/0x760 fs/super.c:1293
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1498
>   do_new_mount fs/namespace.c:2905 [inline]
>   path_mount+0x132a/0x1fa0 fs/namespace.c:3235
>   do_mount fs/namespace.c:3248 [inline]
>   __do_sys_mount fs/namespace.c:3456 [inline]
>   __se_sys_mount fs/namespace.c:3433 [inline]
>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x444f7a
> Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe1fa3c2a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffe1fa3c300 RCX: 0000000000444f7a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffe1fa3c2c0
> RBP: 00007ffe1fa3c2c0 R08: 00007ffe1fa3c300 R09:
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
