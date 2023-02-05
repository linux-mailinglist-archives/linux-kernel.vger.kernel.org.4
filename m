Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708068AEDD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBEId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBEId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:33:26 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5C222F0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:33:23 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id v17-20020a92ab11000000b00310c6708243so6226243ilh.23
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 00:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZjvr4k52QVu34Y3elCqz13BHrMLTeflVxDyu/cl1vA=;
        b=tVSYWtniAShPbQsxk03d6akQfbBjRaNeb5PMB19oW6apFbbct1bVErWGMbFnoLKpF6
         C71hnA6sWmTOKFSngEB2tLBD0lCSiQFxxVeK0IRoIkR1cW0xgQZJ4kW8D8Yq3DMC8iQ8
         wy4heRAlMpjLCJn4JaRzUmG2jRhZHnTZUMYirqd1aKSX5fNQWi0okDOoHVYrhv1XOH9F
         yawbIbLFpC1IBKvLesvM4salHqcC/MSgQNiDsQf48d9GDM5z/RwPIIrxh7ePc6KfKWh5
         iVT/00gQZ06uXe9luLp4mXggSfCCZItQqXdEdEMmX3Fk7ptzljuAn1H+AwEZqvEJOi+1
         8l8g==
X-Gm-Message-State: AO0yUKV8gepBJIAtJ0Dej9pl/FfedESmuvR7AokLAKzM7q8bLdbFS2pj
        BUKb/QM5cRKQRkQ4HIB/yYbDe1rhOKu8coomHjpYr+jJwZ+T
X-Google-Smtp-Source: AK7set+bvqWWcHv2n69eUm4nF9fKspFwGyPoSPYsgFvLUijoj753nJX5LQRyEDOtR/P8hBRJA7yk6IIs5A+i0DVHv0FFFxpjB9br
MIME-Version: 1.0
X-Received: by 2002:a92:1810:0:b0:310:c097:3433 with SMTP id
 16-20020a921810000000b00310c0973433mr3157369ily.92.1675586002528; Sun, 05 Feb
 2023 00:33:22 -0800 (PST)
Date:   Sun, 05 Feb 2023 00:33:22 -0800
In-Reply-To: <20230205080806.1306-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078b30d05f3efc442@google.com>
Subject: Re: [syzbot] WARNING in kernfs_get (4)
From:   syzbot <syzbot+9be7b6c4b696be5d83ef@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __tlb_remove_page_size

 filemap_readahead mm/filemap.c:2572 [inline]
 filemap_get_pages+0x6c5/0x16b0 mm/filemap.c:2612
 filemap_read+0x315/0xc00 mm/filemap.c:2690
 generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2836
 ext4_file_read_iter+0x1d9/0x690 fs/ext4/file.c:147
 __kernel_read+0x2ca/0x830 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:485
page_owner free stack trace missing
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:139!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5741 Comm: dhcpcd-run-hook Not tainted 6.2.0-rc6-next-20230131-syzkaller-09515-g80bd9028feca-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 8e 62 c1 ff 0f 0b e8 87 62 c1 ff 4c 89 f7 48 c7 c6 00 72 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 6d 62 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc900060c78d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900060c7cd8 RCX: 0000000000000000
RDX: ffff888024319d40 RSI: ffffffff81c353ac RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e74c317
R10: fffffbfff1ce9862 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0004ff8d00 R15: ffffc900060c7d00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc63210f8 CR3: 0000000071dca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __tlb_remove_page include/asm-generic/tlb.h:472 [inline]
 zap_pte_range mm/memory.c:1416 [inline]
 zap_pmd_range mm/memory.c:1536 [inline]
 zap_pud_range mm/memory.c:1565 [inline]
 zap_p4d_range mm/memory.c:1586 [inline]
 unmap_page_range+0x1226/0x3ce0 mm/memory.c:1607
 unmap_single_vma+0x194/0x2a0 mm/memory.c:1653
 unmap_vmas+0x234/0x380 mm/memory.c:1692
 exit_mmap+0x190/0x7d0 mm/mmap.c:3036
 __mmput+0x128/0x4c0 kernel/fork.c:1209
 mmput+0x60/0x70 kernel/fork.c:1231
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9d7/0x2b60 kernel/exit.c:856
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f36bdf61309
Code: Unable to access opcode bytes at 0x7f36bdf612df.
RSP: 002b:00007ffdc6321008 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00005598b8ccfe04 RCX: 00007f36bdf61309
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffffffffff88 R09: 0000000000000000
R10: 00005598b8ce05f0 R11: 0000000000000202 R12: 00005598b7637070
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 8e 62 c1 ff 0f 0b e8 87 62 c1 ff 4c 89 f7 48 c7 c6 00 72 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 6d 62 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc900060c78d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900060c7cd8 RCX: 0000000000000000
RDX: ffff888024319d40 RSI: ffffffff81c353ac RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e74c317
R10: fffffbfff1ce9862 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea0004ff8d00 R15: ffffc900060c7d00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc63210f8 CR3: 0000000071dca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         80bd9028 Add linux-next specific files for 20230131
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154f1123480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=904dc2f450eaad4a
dashboard link: https://syzkaller.appspot.com/bug?extid=9be7b6c4b696be5d83ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1331cbbb480000

