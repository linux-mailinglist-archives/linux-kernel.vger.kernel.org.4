Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F31612F11
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaClh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaClf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:41:35 -0400
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24765ED
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 19:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=XqvOP23v9VU4lIYlxWoKfNiHpfHj592K4E9OcpW4ARM=; b=NOHyu7UiwEzxeUdl9nT23yE8k2
        OdHRdjfG+Ok8k2c34eDKx9e+uXhWs0MMpOBIZ9VjDDq4rY5CuGxve/cUmtS3eIhIEwKHBnnmWnDGj
        veEspM/ncTZHrVddoHKscDQ5bGbDUnnsuL8OAPH/u6GC8HCISSQL09lwy+ZRWWZIjlm0Y0WWgMPou
        jOBqr18GLySLbyQjnt5P++qgLDyGiaQGJREJy9rwEK8RvX9Hz1dMH8QRGJ68E4hMLlmrNLl1qfACP
        Rc+xTjWWr2BhIS1H0YpsqrYAn71aCU/RkyJtEU+UX8VrwF/uh/2rxVapcwWzj4hiJGtee0HXaXFz8
        sHIrzJDg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1opKjx-00CIUC-5s; Mon, 31 Oct 2022 02:41:29 +0000
Date:   Mon, 31 Oct 2022 02:41:29 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     syzbot <syzbot+9cd47a3d9ebd6776eb03@syzkaller.appspotmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in diAlloc
Message-ID: <Y1812bdYPcOn4lll@gallifrey>
References: <000000000000427b1a05e997130a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <000000000000427b1a05e997130a@google.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-12-amd64 (x86_64)
X-Uptime: 02:37:53 up 233 days, 13:03,  1 user,  load average: 0.00, 0.01,
 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_FAKE_RF_SHORT,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* syzbot (syzbot+9cd47a3d9ebd6776eb03@syzkaller.appspotmail.com) wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1017fb54880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
> dashboard link: https://syzkaller.appspot.com/bug?extid=9cd47a3d9ebd6776eb03
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbd0d4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153195ef080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9cd47a3d9ebd6776eb03@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 66104
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:1357:9
> shift exponent 218103809 is too large for 64-bit type 'u64' (aka 'unsigned long long')

My reading of this is that jfs does ~no sanity checking of the
structure read from disk when mounting;

int dbMount(struct inode *ipbmap)
...
  bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);

The line that triggers it is:
  agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));

which is:
121:#define BLKTOAG(b,sbi)  ((b) >> ((sbi)->bmap->db_agl2size))

so if the mount is given garbage, then that's what it'll shift by.

this is probably the least of the worries of an unchecked disk structure.

Dave


> CPU: 1 PID: 3607 Comm: syz-executor161 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:151 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
>  diAlloc+0x141a/0x1700 fs/jfs/jfs_imap.c:1357
>  ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
>  jfs_create+0x13a/0xb10 fs/jfs/namei.c:92
>  lookup_open fs/namei.c:3413 [inline]
>  open_last_lookups fs/namei.c:3481 [inline]
>  path_openat+0x12d0/0x2df0 fs/namei.c:3688
>  do_filp_open+0x264/0x4f0 fs/namei.c:3718
>  do_sys_openat2+0x124/0x4e0 fs/open.c:1313
>  do_sys_open fs/open.c:1329 [inline]
>  __do_sys_creat fs/open.c:1405 [inline]
>  __se_sys_creat fs/open.c:1399 [inline]
>  __x64_sys_creat+0x11f/0x160 fs/open.c:1399
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f60b0aa1f09
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc52136898 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f60b0aa1f09
> RDX: 00007f60b0a60403 RSI: 0000000000000000 RDI: 0000000020000040
> RBP: 00007f60b0a616d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffc52136760 R11: 0000000000000246 R12: 00000000f8008000
> R13: 0000000000000000 R14: 00080000000000fc R15: 0000000000000000
>  </TASK>
> ================================================================================
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
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
