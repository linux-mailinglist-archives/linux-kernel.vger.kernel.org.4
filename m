Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2F5E7F44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIWQGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiIWQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:05:44 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BCFABF20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:05:41 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id e14-20020a6b500e000000b006a13488a320so185262iob.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xvB57lWg96bipqQd7JSN013EXMYj71I2FBKSizlUzC0=;
        b=eW7SOe1NmF0Yda+E8ZyP30ouxVZTh5U9HUf0lCS6w1412GQwYe0zOFVPtHHkoc5oaT
         KAro3XHiNku9O9LExJxkD70t3PSJj+m+f49bENnEQ3wop/+ST/DoUjjzApFnQhN2nsh7
         yzvuWQBUah9oHvHN7sejvOxugDT/7nCRz2zOS489J4n4QnqJnN+RfHdThISjKyuiC7cW
         O4954iawnFlJ3i5rpoOZHdl7bXySCNpexsJSG7qGwEA657aQNqWayoOyQUcDIPmoKVem
         SxAMoqv/M3g3t5dYFibNYRyRz8Zej0aIFLdFaFPzHeSejBphdH3ESEyOWqA9bPnW8vDY
         bJaA==
X-Gm-Message-State: ACrzQf1tPZIL6eJKsW325uqX3rb4zUwSzpaafTzyaQz53kvFRWwBio/u
        fyk6ZnkA/tI6768Iz9HzPZ9XGiq2g+0rDscvs1OQMO2JPiXT
X-Google-Smtp-Source: AMsMyM52Oi8jyoZPEsoqS27Q6toMMPpMDlP6zQbILEV2ExwDH0GrD15bw4aEQaFt3U3+FvzWjuMZ+igCfEutSaYGKGxN8NYCC/9Q
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:2f6:9a05:2230 with SMTP id
 h4-20020a056e021d8400b002f69a052230mr4575455ila.32.1663949140799; Fri, 23 Sep
 2022 09:05:40 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000763a6c05e95a5985@google.com>
Subject: [syzbot] WARNING in ovl_fh_to_dentry
From:   syzbot <syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    483fed3b5dc8 Add linux-next specific files for 20220921
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b13f30880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=849cb9f70f15b1ba
dashboard link: https://syzkaller.appspot.com/bug?extid=9d14351a171d0d1c7955
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14283ac4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156da4ef080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1cb3f4618323/disk-483fed3b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc02cb30b495/vmlinux-483fed3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com

------------[ cut here ]------------
memcpy: detected field-spanning write (size 93) of single field "&fh->fb" at fs/overlayfs/export.c:799 (size 21)
WARNING: CPU: 0 PID: 3608 at fs/overlayfs/export.c:799 ovl_fid_to_fh fs/overlayfs/export.c:799 [inline]
WARNING: CPU: 0 PID: 3608 at fs/overlayfs/export.c:799 ovl_fh_to_dentry+0x880/0x950 fs/overlayfs/export.c:812
Modules linked in:
CPU: 1 PID: 3608 Comm: syz-executor365 Not tainted 6.0.0-rc6-next-20220921-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2022
RIP: 0010:ovl_fid_to_fh fs/overlayfs/export.c:799 [inline]
RIP: 0010:ovl_fh_to_dentry+0x880/0x950 fs/overlayfs/export.c:812
Code: f9 ff ff e8 62 b6 ab fe b9 15 00 00 00 4c 89 f6 48 c7 c2 a0 0f 28 8a 48 c7 c7 00 10 28 8a c6 05 a7 86 fa 0a 01 e8 4d ad 76 06 <0f> 0b e9 ec f8 ff ff 49 c7 c6 ea ff ff ff bb ea ff ff ff c7 44 24
RSP: 0018:ffffc90003d7fb30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000060 RCX: 0000000000000000
RDX: ffff88801f9f8000 RSI: ffffffff81620348 RDI: fffff520007aff58
RBP: ffff88801798b900 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 203a7970636d656d R12: 00000000000000fb
R13: 1ffff920007aff6e R14: 000000000000005d R15: ffff88801798b903
FS:  0000555555748300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ec877aa70 CR3: 0000000021a2b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exportfs_decode_fh_raw+0x127/0x7d0 fs/exportfs/expfs.c:435
 exportfs_decode_fh+0x38/0x90 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x2b6/0x8b0 fs/fhandle.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa84bf85cc9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd45ccfbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa84bf85cc9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00007fa84bf49e70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000073 R11: 0000000000000246 R12: 00007fa84bf49f00
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
