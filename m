Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5055FFDAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJPGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJPGwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 02:52:47 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BE3D593
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 23:52:46 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so6887221ilu.17
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 23:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+T5aOHFBn0evAQz1vErQpfAFJ2574A0vi0Zz9LJdccA=;
        b=Sdv0eAnQ5XcP+mbZsxI3GAxSkp4Hi49NFM1P2zZXXjJdoBzXQbmjHVEFCda7EN2qoO
         ux1kzP7BUydkgMJDBjMoNBXGiyqvFN0tGuhgmnoJcUWA0+UWyCTF6Vl+mH8Hm/VcgBT+
         bIev5BOqjFEGgaS4Kn2g+9FPiLwhMFeWaFhHUWDZ98Z0qyTBrgH6K6vGQqnTTm746uH3
         wx6N7OwXBE2nHi3ydCmbGM8jCsZK3m13SRo+buskjWyZ9SVQTrhX0QJq/FWywRBMk2ct
         ua37Ot6OKvVNhSR7z0Z3e/C0vbbFPQUvmWPVM+VEGkke8fbKbVLqRKk+Dvqf6RBa45MT
         S4FA==
X-Gm-Message-State: ACrzQf2QnE3iHSTjMtwqAfuiXi0lr4pTEY8G5K9j133iKkUFSZ+gSe9J
        dOoQ6lgPIxkzOqU1VlYaIFaggAGZXxjSWsckLW1Qka5aJV3U
X-Google-Smtp-Source: AMsMyM6EUVKT4V8JbfjAjs94yP0uEUQFLuz12gSDUo05L3wQic671XTHtNh/yDdBKmYV/FRN+O2+batHaqElAZpScVs7iI2InzZv
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341c:b0:6bc:1c3d:836e with SMTP id
 n28-20020a056602341c00b006bc1c3d836emr2163062ioz.24.1665903165488; Sat, 15
 Oct 2022 23:52:45 -0700 (PDT)
Date:   Sat, 15 Oct 2022 23:52:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068cb2905eb214e9a@google.com>
Subject: [syzbot] WARNING in btf_type_id_size
From:   syzbot <syzbot+6280ebbcdba3e0c14fde@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yhs@fb.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1376ba52880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=796b7c2847a6866a
dashboard link: https://syzkaller.appspot.com/bug?extid=6280ebbcdba3e0c14fde
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e182aa880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1677bfcc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7cc67ced256d/disk-0326074f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86a7be29267c/vmlinux-0326074f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6280ebbcdba3e0c14fde@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3609 at kernel/bpf/btf.c:1946 btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
Modules linked in:
CPU: 0 PID: 3609 Comm: syz-executor361 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
Code: ef e8 7f 8e e4 ff 41 83 ff 0b 77 28 f6 44 24 10 18 75 3f e8 6d 91 e4 ff 44 89 fe bf 0e 00 00 00 e8 20 8e e4 ff e8 5b 91 e4 ff <0f> 0b 45 31 f6 e9 98 02 00 00 41 83 ff 12 74 18 e8 46 91 e4 ff 44
RSP: 0018:ffffc90003cefb40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880259c0000 RSI: ffffffff81968415 RDI: 0000000000000005
RBP: ffff88801270ca00 R08: 0000000000000005 R09: 000000000000000e
R10: 0000000000000011 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000011 R14: ffff888026ee6424 R15: 0000000000000011
FS:  000055555641b300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000f2e258 CR3: 000000007110e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
 btf_check_all_types kernel/bpf/btf.c:4723 [inline]
 btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
 btf_parse kernel/bpf/btf.c:5026 [inline]
 btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
 bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
 __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
 __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fbae41c69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8aeb6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0fbae41c69
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000012
RBP: 00007f0fbae05e10 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f0fbae05ea0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
