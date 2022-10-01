Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F475F1C61
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiJANgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJANgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:36:48 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3C7C195
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:36:38 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y187-20020a6bc8c4000000b006a4014e192fso4487551iof.21
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=lZrq325N5CoAwJpbha3EKwb0wIXv2j/NpUSPeKBVQGk=;
        b=MTvyKhsDDtRP2hdX5V1pr0gvScM5XnGFgN8E/C1dnhWOgT/XDBe5jqM1dvYTRXelx6
         Dov7snR64y4KDE8WV4e0EcTBqsf5DIAgn3PlMnaB5Aog6kDYMFPLZhuJc8FryT4AGPRL
         66zmtCoMSF/OL+Bz5uXSfVOFeFJ+zMHvENrG8rDwmjA906Li+l0j1hpV8YsNyTn1wNeJ
         PkfFskvtVN8tSHFOkz3TKI218Xy7tBFpM2MiJa4cYNSH2j789hvPsI+8hSpKQqOb0OcH
         CbEkPu9JAX4Y9ZGmlQWAxT0AlFqlY7PW1+VxYGO2/M5bFj0D5M2+r2v54Ic2FXK8kqs0
         MFiA==
X-Gm-Message-State: ACrzQf1qadRHICiXNW752rVIrl363Bt9K1MdabgUkxdaPG6pM82684r+
        zUQAUTLV9Yg1Gye/oX/9r+DyAU/22ud4Kff445cELW/fmMB5
X-Google-Smtp-Source: AMsMyM42c9lAzc9EtDH+gOAlqsDMqO96q9uzxCi000rBgVGVJkymabFPhnTY2qspD+tMJMW2+zGYSQg2Rp7CeJfXyFvnDVGPflI2
MIME-Version: 1.0
X-Received: by 2002:a02:3548:0:b0:362:4000:9010 with SMTP id
 y8-20020a023548000000b0036240009010mr346518jae.69.1664631397800; Sat, 01 Oct
 2022 06:36:37 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:36:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025ec9e05e9f933c9@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in diFree
From:   syzbot <syzbot+b4c57cb06cb5a53b7b06@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b106ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=b4c57cb06cb5a53b7b06
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f323ff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148a2804880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4c57cb06cb5a53b7b06@syzkaller.appspotmail.com

ERROR: (device loop0): xtTruncate_pmap: XT_GETPAGE: xtree page corrupt
ERROR: (device loop0): remounting filesystem as read-only
ERROR: (device loop0): txAbort: 
ERROR: (device loop0): xtTruncate: XT_GETPAGE: xtree page corrupt
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:881:9
shift exponent 8205 is too large for 64-bit type 'long long unsigned int'
CPU: 0 PID: 3614 Comm: syz-executor393 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 diFree.cold+0x17/0x68 fs/jfs/jfs_imap.c:881
 jfs_evict_inode+0x3c1/0x4a0 fs/jfs/inode.c:156
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
 shrink_dcache_parent+0x1fe/0x3c0 fs/dcache.c:1628
 do_one_tree fs/dcache.c:1682 [inline]
 shrink_dcache_for_umount+0x71/0x330 fs/dcache.c:1699
 generic_shutdown_super+0x68/0x400 fs/super.c:473
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x29b0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f72b3c35579
Code: Unable to access opcode bytes at RIP 0x7f72b3c3554f.
RSP: 002b:00007fff12fe7c88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f72b3cb8330 RCX: 00007f72b3c35579
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000555556c4c2c0 R11: 0000000000000246 R12: 00007f72b3cb8330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
