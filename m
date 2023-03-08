Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC296B0998
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCHNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCHNmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:42:44 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2733ABAD35
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:41:18 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso8663663ior.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282843;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmPMQpV14bZ7V4vdjMtIyt04KpDD160/Ar7BhRwdhwM=;
        b=2dTEeCUPjUxuPb3RaFC9zuL08GL09BWZGMMGJ+xTV2HeP//oky5EhdeJOTMyEFugwG
         3AqisXaxIN9HMRPiXeW5Iqn6Frr9HEhuI4BzhrodRf5XcusUarw0d7jCRtftJXcjoFeW
         oF44CoCC4I04SMo8w63oLxkZ3MeN+LkohGmyyMau/eIQVcq13BV9XpHiJVi1wDDGmMuS
         IhUFtPxcIwornSr1pU8pVfBbgbxMLQ/ys8TMjRs/vYRZVd4G4azTNY8h7+BnLVoCA7SQ
         HzLQqhtsBZeT9odPnglniTFzjLn25NcdYRqW3A8FJ5rpUlyZAFoqf/BnlZAyHN3Rc74U
         cByw==
X-Gm-Message-State: AO0yUKVpzOfIroQ+DOxvCS84XwQ4nEjBGyumyLUipji3P+E/HMQdeI2J
        /d7pdg4w5JyI4zszorUk44OAWL7ImtBNbhRiPOR8cJr/SAEA
X-Google-Smtp-Source: AK7set/m2dG7flJ4CSW6cAgeamKhHsRE/RvfNSf88RN4ln/wG7VFRhAtmqyN60SD8R0Fh5uV2hxBqpjaKupAu6warhiOmtkgMSKr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1091:b0:310:9d77:6063 with SMTP id
 r17-20020a056e02109100b003109d776063mr8618949ilj.5.1678282843004; Wed, 08 Mar
 2023 05:40:43 -0800 (PST)
Date:   Wed, 08 Mar 2023 05:40:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0a65805f663ace6@google.com>
Subject: [syzbot] [mm?] kernel BUG in find_mergeable_anon_vma
From:   syzbot <syzbot+8d95422d3537159ca390@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0988a0ea7919 Merge tag 'for-v6.3-part2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fc4754c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=8d95422d3537159ca390
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130602bcc80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b61b54c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2d28852dbc0/disk-0988a0ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ad7e6fa3a8d/vmlinux-0988a0ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7430e1576859/bzImage-0988a0ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d95422d3537159ca390@syzkaller.appspotmail.com

pgoff 20000 file 0000000000000000 private_data 0000000000000000
flags: 0x8102172(write|mayread|maywrite|mayexec|growsdown|locked|account|softdirty)
------------[ cut here ]------------
kernel BUG at mm/mmap.c:1108!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24456 Comm: syz-executor216 Not tainted 6.2.0-syzkaller-13467-g0988a0ea7919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:find_mergeable_anon_vma+0x6f0/0x840 mm/mmap.c:1108
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 6b 48 3b 6b 50 0f 85 08 fb ff ff e9 06 fb ff ff e8 58 ad bf ff 48 89 ef e8 70 a5 fa ff <0f> 0b 4c 89 f7 e8 06 29 11 00 e9 d2 f9 ff ff e8 fc 28 11 00 e9 a0
RSP: 0018:ffffc9000b61f888 EFLAGS: 00010286
RAX: 0000000000000130 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816931bc RDI: 0000000000000005
RBP: ffff8880783f97e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffc9000b61f8b0
R13: 1ffff920016c3f12 R14: ffff8880783f97e8 R15: fff0000000000fff
FS:  00007fe0f1f58700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc5b9a8960 CR3: 000000002bd88000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __anon_vma_prepare+0x7d/0x580 mm/rmap.c:199
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 do_anonymous_page mm/memory.c:4050 [inline]
 handle_pte_fault mm/memory.c:4907 [inline]
 __handle_mm_fault+0x3a8f/0x3e60 mm/memory.c:5051
 handle_mm_fault+0x2ba/0x9c0 mm/memory.c:5197
 faultin_page mm/gup.c:925 [inline]
 __get_user_pages+0x4da/0xf30 mm/gup.c:1147
 populate_vma_page_range+0x2df/0x420 mm/gup.c:1543
 __mm_populate+0x105/0x3b0 mm/gup.c:1652
 mm_populate include/linux/mm.h:3026 [inline]
 vm_mmap_pgoff+0x201/0x280 mm/util.c:547
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe0f1fa6959
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0f1f582f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe0f1fa6959
RDX: 0000000000000002 RSI: 0000000000001000 RDI: 0000000020002000
RBP: 00007fe0f202e3e8 R08: 00000000ffffffff R09: 0000000000000000
R10: 840000000000a132 R11: 0000000000000246 R12: 840000000000a132
R13: 00007fe0f202e3e0 R14: 00007fe0f202e3ec R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_mergeable_anon_vma+0x6f0/0x840 mm/mmap.c:1108
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 6b 48 3b 6b 50 0f 85 08 fb ff ff e9 06 fb ff ff e8 58 ad bf ff 48 89 ef e8 70 a5 fa ff <0f> 0b 4c 89 f7 e8 06 29 11 00 e9 d2 f9 ff ff e8 fc 28 11 00 e9 a0
RSP: 0018:ffffc9000b61f888 EFLAGS: 00010286
RAX: 0000000000000130 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816931bc RDI: 0000000000000005
RBP: ffff8880783f97e0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffc9000b61f8b0
R13: 1ffff920016c3f12 R14: ffff8880783f97e8 R15: fff0000000000fff
FS:  00007fe0f1f58700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0f1ffc01d CR3: 000000002bd88000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
