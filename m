Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4935FDCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJMO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:58:45 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBAEC533
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:58:44 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so1207499ioa.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61lrL0z1ygxGVikDSISn8ZJPFTRdiiY1NbOxA+fanWc=;
        b=7zeji3jL13gLOtg8zVd8uqv+y9LhTgRzsaLJHRL/A0ArFHzfq72sITlzZ6RdaDahFD
         kSZuJ3GEaANVrOmiGIbyLXtpAtNJcOrdPmW201M7x6txx63Fh6Jp/PnBZNeBBi1PE6j/
         UgIa0DbZb8HwaMOztSbMr+udkdhKJiPlrdeEkg4VYAKJlZiVHCL2PEuF0Y4am2y92/tE
         qOIUtSZiK07sNV71WlYS957HCpxHTOmF/Hedhaefy+CAFuBlsN44DRk0uELf8VESrQVb
         KBgtF2mu3rcnPkxx7R7nTU21X1SuaDDSm8Sfl/DQMl3NubkIbNjKR31DeU3tcQWJmm7F
         +AoA==
X-Gm-Message-State: ACrzQf3uxa+fPKm4016x+4d8Exurwfd0ORj5rsKEX5x2JuUyMLsBz7W9
        2AhDGcJxIcT/PDbknjsCpYuYSu0x8SkQ7UbcTr2AaQTsIIrE
X-Google-Smtp-Source: AMsMyM5ETVAavyu10jJ+JwfKiYNU4c0y6MwdJoBF4+3vH5ThQX6NgQkAUf3QevsoIHGqpy/s3JmEKZ+AKONqNbOI2xmtmK5i0VsP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id
 i15-20020a056602134f00b006a4cd047842mr140695iov.172.1665673123563; Thu, 13
 Oct 2022 07:58:43 -0700 (PDT)
Date:   Thu, 13 Oct 2022 07:58:43 -0700
In-Reply-To: <000000000000b409e205eaea8714@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d790e505eaebbe23@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in gfs2_getbuf
From:   syzbot <syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, anprice@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176500c2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=87a187973530ac822e3c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174eb6aa880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1118d5a4880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/930c28d03062/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
gfs2: fsid=loop0: Now mounting FS (format 1801)...
================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/meta_io.c:128:16
shift exponent 4294967293 is too large for 64-bit type 'u64' (aka 'unsigned long long')
CPU: 1 PID: 3612 Comm: syz-executor373 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3a6/0x420 lib/ubsan.c:322
 gfs2_getbuf+0x759/0x7d0 fs/gfs2/meta_io.c:128
 gfs2_meta_read+0x16a/0x910 fs/gfs2/meta_io.c:265
 gfs2_meta_buffer+0x195/0x400 fs/gfs2/meta_io.c:491
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:72 [inline]
 gfs2_inode_refresh+0xd6/0xdc0 fs/gfs2/glops.c:472
 gfs2_instantiate+0x15e/0x220 fs/gfs2/glock.c:515
 gfs2_glock_holder_ready fs/gfs2/glock.c:1303 [inline]
 gfs2_glock_wait+0x1d9/0x2a0 fs/gfs2/glock.c:1323
 gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
 gfs2_lookupi+0x411/0x5f0 fs/gfs2/inode.c:306
 gfs2_lookup_simple+0xec/0x170 fs/gfs2/inode.c:258
 init_journal+0x1c3/0x2310 fs/gfs2/ops_fstype.c:739
 init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:882
 gfs2_fill_super+0x1be3/0x2710 fs/gfs2/ops_fstype.c:1240
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7caad9342a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc97eb3c68 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7caad9342a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc97eb3c80
RBP: 00007ffc97eb3c80 R08: 00007ffc97eb3cc0 R09: 0000555556b512c0
R10: 0000000000000008 R11: 0000000000000282 R12: 0000000000000004
R13: 00007ffc97eb3cc0 R14: 0000000000000001 R15: 0000000020000218
 </TASK>
================================================================================

