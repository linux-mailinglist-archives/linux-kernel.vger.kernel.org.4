Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD65B9F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIOPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIOPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:40:41 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7D83BFD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:40:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id e14-20020a6b500e000000b006a13488a320so6992978iob.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3MuZ9lS5ghRfFo2i6mIb6NriDGfSjO9gHz3Coh3u8Hw=;
        b=RIOWMTL35NPhO6nsyYtrIE7HIhqXGM0mpaCUxBa3tWXK9VqUeX85apqTt97GPu7S3y
         apNDCrmzbuad8KkoAmMmzQmgFn5Fdlu/6ilc07MIfzQqpb1C0Wn1xShlSZeO1CZgyLQI
         YNIqQvWLvZPa9MFEhLSVIn3IqbdUmpV8IU7ijgrMrXFuy/XPpcS3JuD2UBSlRZQ7rC4E
         WFDtrp9K1Kunxva8d441fZorXBSe+ElqiJtWxryJIfIVIndhhtIvp3KZqA7JoTtha6S0
         qGIz4ApuSEQvhGkTJYjsR84pq/we3tH6B+x9gsVcLs4TA5/1jEJ0LufbIy9q70Y/+e9J
         E6sA==
X-Gm-Message-State: ACrzQf0JS+Btej6fFOojriNxdsVaDVbdqb9FOWbAFeg1GM3bgaBDQ/Xu
        +tX9dSs/h4DmbcpHAzGPCtV5OWvWGt9PApjEUWHXmSXU0HRn
X-Google-Smtp-Source: AMsMyM4weKJfciG4eOcaTRSDy1TEeHhwarRWmmNR8Yfq8MO4MQrjUNT0XcTsTPJVg0D+KIF7C/+3SyxT1ls5b6yQ9+DzM+MoOK67
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:2f0:6de5:50b0 with SMTP id
 l10-20020a056e0212ea00b002f06de550b0mr271940iln.276.1663256439738; Thu, 15
 Sep 2022 08:40:39 -0700 (PDT)
Date:   Thu, 15 Sep 2022 08:40:39 -0700
In-Reply-To: <000000000000c371f705e6259a38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042dafa05e8b911a6@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in init_sb (3)
From:   syzbot <syzbot+dcf33a7aae997956fe06@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, anprice@redhat.com, cluster-devel@redhat.com,
        fgheet255t@gmail.com, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e47eb90a0a9a Add linux-next specific files for 20220901
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14c90dbf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7933882276523081
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf33a7aae997956fe06
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179ef880880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17047887080000

Downloadable assets:
disk image: https://storage.googleapis.com/d3bf639370bc/disk-e47eb90a.raw.xz
vmlinux: https://storage.googleapis.com/1c9c27c6eeef/vmlinux-e47eb90a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcf33a7aae997956fe06@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
gfs2: fsid=loop0: Now mounting FS (format 1801)...
================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/ops_fstype.c:295:19
shift exponent 327683 is too large for 64-bit type 'long unsigned int'
CPU: 0 PID: 3611 Comm: syz-executor306 Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 gfs2_read_sb fs/gfs2/ops_fstype.c:295 [inline]
 init_sb.cold+0x19/0x109 fs/gfs2/ops_fstype.c:487
 gfs2_fill_super+0x17fe/0x27a0 fs/gfs2/ops_fstype.c:1209
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1325
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd9bd10d16a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd1985f38 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcd1985f90 RCX: 00007fd9bd10d16a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcd1985f50
RBP: 00007ffcd1985f50 R08: 00007ffcd1985f90 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000218
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000001
 </TASK>
================================================================================

