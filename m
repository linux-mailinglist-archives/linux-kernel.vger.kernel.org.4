Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA95FD5C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJMHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:54:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE01DB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:54:35 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id t15-20020a5d81cf000000b006bc1ca3ae00so615697iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBB2JfHD6BC1GAkdvMOikiHG2EgwxF6IhXOcrtnyG/E=;
        b=s473sUR0Jx6TELEmF+qqwkOgG+rc9F5sFt0pNV2Sgr75TCO2tl6vikWcKubItX5hXV
         XKylbzPVG+3k1MtAnRAzEippScIxm9WV/yvOCCnbhCj0+HzOJPaEzxNX0fyGv5HUA84w
         md05v8kRrrZnCU+PYeeX3VwL1ytwV3e0O0jNcErS6AMfsBoTupWjb/EqsqVpdUVZJP7w
         idw92wE0Mddnx0wMbnq9CjEZpb7X/qnJiSa3Pdrje976rtV9GL7FUmX1TXRmaQv9Bkv1
         ERfBIFzZ/+ZSYSKwcYLwjRFQNsTnZTGhjjAwqrgRAs7JEhMQanJqyKfr2g99THT8jCT9
         KLdw==
X-Gm-Message-State: ACrzQf3TBRT8rfRWHacTH7RIckpEGAoZ35N8Two9SIFPYlXArCkHv0F3
        JqQuI3+g8Wvvgv/Et2kcePbKT2HjisPnjQZgRBAnErKfkYzW
X-Google-Smtp-Source: AMsMyM5BbBlIIjS2Mees0N/qPO9/79u+sdFa9hsrt87xuSU3KkvAUltoXw2DrhLqjg6r2hBsRGHVoxNPaAwfL2fjfANm5ftOXdwE
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:2f9:ec63:2e3e with SMTP id
 h5-20020a92c265000000b002f9ec632e3emr16809676ild.275.1665647675034; Thu, 13
 Oct 2022 00:54:35 -0700 (PDT)
Date:   Thu, 13 Oct 2022 00:54:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdd5dc05eae5d1af@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Write in kill_f2fs_super
From:   syzbot <syzbot+729c925c2d9fc495ddee@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15fc0252880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=729c925c2d9fc495ddee
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15714978880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1152f7cc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dd1108445544/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+729c925c2d9fc495ddee@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 3651456e
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:116 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: null-ptr-deref in get_task_struct include/linux/sched/task.h:110 [inline]
BUG: KASAN: null-ptr-deref in kthread_stop+0x2a/0x210 kernel/kthread.c:703
Write of size 4 at addr 000000000000001c by task syz-executor364/3613

CPU: 1 PID: 3613 Comm: syz-executor364 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_report+0xf1/0x1f0 mm/kasan/report.c:436
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:116 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:110 [inline]
 kthread_stop+0x2a/0x210 kernel/kthread.c:703
 kill_f2fs_super+0xe6/0x3c0 fs/f2fs/super.c:4522
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x6b2/0x2280 kernel/exit.c:813
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:943
 __do_sys_exit_group kernel/exit.c:954 [inline]
 __se_sys_exit_group kernel/exit.c:952 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:952
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8264e76359
Code: Unable to access opcode bytes at 0x7f8264e7632f.
RSP: 002b:00007fffe8489448 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8264eee410 RCX: 00007f8264e76359
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000180020 R11: 0000000000000246 R12: 00007f8264eee410
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
