Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716B95F16BD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiI3XmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI3XmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:42:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A394713C217
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F5CCB82985
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA3C433C1;
        Fri, 30 Sep 2022 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664581333;
        bh=SjHTCnm0eXfkdSaDjkhKhnduXwqLaczAAiDOXXWH3NM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vS2lHNnzRZUzRFfv6DBPeWPyPiDiKl63dtUNRWsw4nVcjpqA5LXyE8QFbcuNStQqx
         s2fZseZLoQodLRvYiGml7QFGUDqbwUDxL1/Cjho8RwP8JEsbUlz7Qijtw4UuI6pdz6
         gx+APAx7IVi/q7yrDHPNYvhG/u3l16xxuDPQG8jk=
Date:   Fri, 30 Sep 2022 16:42:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Edward Liaw <edliaw@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [syzbot] WARNING in change_protection
Message-Id: <20220930164211.b8215770d44e1a3803f1e660@linux-foundation.org>
In-Reply-To: <00000000000046580505e9dea8e4@google.com>
References: <00000000000046580505e9dea8e4@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 22:56:38 -0700 syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com> wrote:

> Hello,

Thanks.  Let's cc a few userfaultfd people.

> syzbot found the following issue on:
> 
> HEAD commit:    511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=135cf5c4880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b9b4f0895be09a6dec3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164d0ec880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3c2e0880000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker_entry include/linux/swapops.h:323 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker include/linux/swapops.h:346 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pte_range mm/mprotect.c:270 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pmd_range mm/mprotect.c:409 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pud_range mm/mprotect.c:438 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_p4d_range mm/mprotect.c:459 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection_range mm/mprotect.c:483 [inline]
> WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection+0x16e9/0x4280 mm/mprotect.c:505
> Modules linked in:
> CPU: 1 PID: 3612 Comm: syz-executor181 Not tainted 6.0.0-rc7-syzkaller-00130-g511cce163b75 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:make_pte_marker_entry include/linux/swapops.h:323 [inline]
> RIP: 0010:make_pte_marker include/linux/swapops.h:346 [inline]
> RIP: 0010:change_pte_range mm/mprotect.c:270 [inline]
> RIP: 0010:change_pmd_range mm/mprotect.c:409 [inline]
> RIP: 0010:change_pud_range mm/mprotect.c:438 [inline]
> RIP: 0010:change_p4d_range mm/mprotect.c:459 [inline]
> RIP: 0010:change_protection_range mm/mprotect.c:483 [inline]
> RIP: 0010:change_protection+0x16e9/0x4280 mm/mprotect.c:505
> Code: ff 48 8b 84 24 90 00 00 00 80 38 00 0f 85 25 29 00 00 48 8b 44 24 10 48 83 b8 90 00 00 00 00 0f 84 8f f9 ff ff e8 a7 d6 c3 ff <0f> 0b 48 ba 00 00 00 00 00 fc ff df 48 8b 04 24 48 c1 e8 03 80 3c
> RSP: 0018:ffffc90002fbf968 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: ffff888073714180 RSI: ffffffff81b76079 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8880000001e8 R14: 0000000000000000 R15: 000000002063e000
> FS:  000055555624d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005d84c8 CR3: 000000007c916000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  uffd_wp_range+0xf0/0x180 mm/userfaultfd.c:718
>  mwriteprotect_range+0x2ea/0x420 mm/userfaultfd.c:768
>  userfaultfd_writeprotect fs/userfaultfd.c:1827 [inline]
>  userfaultfd_ioctl+0x438/0x43a0 fs/userfaultfd.c:1999
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f77d7707bb9
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe74be7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f77d7707bb9
> RDX: 00000000200000c0 RSI: 00000000c018aa06 RDI: 0000000000000003
> RBP: 00007f77d76cbd60 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f77d76cbdf0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
