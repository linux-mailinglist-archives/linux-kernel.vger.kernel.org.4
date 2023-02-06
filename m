Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3A68C45E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBFRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:15:26 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1534A9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:15:24 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so7437183iog.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 09:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAFIHoZK4oXTM9BR3uhuEh3VJPkIFolIRLKEJmYp24A=;
        b=Oq/rECrSjn0q8ArKSgBkJ8FLI739VaCmGgnZ4QNbYVzdWVL/34r+3tAOa1Gm7Hceps
         1ouDtzzlUFfT15nj5pnyW3LyGbyl+MrliuJqSOIXQcoS70yVwjfef75njOK/ZScfSzBT
         KPRSNKBku127bDOPKmG+ZeZqJ2F78WP12W5XRXybmKfGR+IU59Zl8Kc6Mmt8z2EPbpEz
         fszVcpat2AyX94JRejbUBQs7+NCmTgJjaptfrGMOpgYVKwOFWuiRozpojJg1cVJ65fJF
         SvV/dMXXsir3OE6KOBnUjy2qAzErt7bQqdeZFNcHSRGkv/xabc8NACFe+xzcRrY7mzck
         yLAw==
X-Gm-Message-State: AO0yUKW4YCVEaky6OK6iyyILJoXeTd7EaqxMiK8k7dB9+GYN4fBKd8Fb
        wb8wNC0Ao8kZcDy1ELOGOx6T3ZzKmp8qTuB7JkxZR8VvV8hV
X-Google-Smtp-Source: AK7set+OQwJz7E8M+1y1vTgnyepKHSiFVPw3cLIeWryHsdk5l3CRzhOQhzzEWrlo4gNxArURrx1ityQ/3H6u+MB07lylu0wo53+K
MIME-Version: 1.0
X-Received: by 2002:a02:9f8f:0:b0:3a5:e7ba:45ab with SMTP id
 a15-20020a029f8f000000b003a5e7ba45abmr4062jam.120.1675703724007; Mon, 06 Feb
 2023 09:15:24 -0800 (PST)
Date:   Mon, 06 Feb 2023 09:15:23 -0800
In-Reply-To: <20230206140214.1911-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037e95405f40b2d24@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
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

 exit_mmap+0x205/0x7d0 mm/mmap.c:3047
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
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:139!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5610 Comm: dhcpcd-run-hook Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000556f700 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000556f9d0 RCX: 0000000000000000
RDX: ffff88802c0a57c0 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea00009b4f40 R15: ffffc9000556f9f8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b779edb950 CR3: 000000002c188000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tlb_remove_page_size include/asm-generic/tlb.h:466 [inline]
 tlb_remove_page+0x12/0x30 include/asm-generic/tlb.h:481
 paravirt_tlb_remove_table arch/x86/include/asm/paravirt.h:92 [inline]
 ___pte_free_tlb+0x123/0x1a0 arch/x86/mm/pgtable.c:57
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte_range mm/memory.c:179 [inline]
 free_pmd_range mm/memory.c:197 [inline]
 free_pud_range mm/memory.c:231 [inline]
 free_p4d_range mm/memory.c:265 [inline]
 free_pgd_range+0x497/0xbf0 mm/memory.c:345
 free_pgtables+0x2d6/0x420 mm/memory.c:386
 exit_mmap+0x1f3/0x7d0 mm/mmap.c:3045
 __mmput+0x128/0x4c0 kernel/fork.c:1209
 mmput+0x60/0x70 kernel/fork.c:1231
 exec_mmap fs/exec.c:1034 [inline]
 begin_new_exec+0xf69/0x2e60 fs/exec.c:1293
 load_elf_binary+0x801/0x4ff0 fs/binfmt_elf.c:1001
 search_binary_handler fs/exec.c:1736 [inline]
 exec_binprm fs/exec.c:1778 [inline]
 bprm_execve fs/exec.c:1853 [inline]
 bprm_execve+0x7fd/0x1b00 fs/exec.c:1809
 do_execveat_common+0x72c/0x8e0 fs/exec.c:1961
 do_execve fs/exec.c:2035 [inline]
 __do_sys_execve fs/exec.c:2111 [inline]
 __se_sys_execve fs/exec.c:2106 [inline]
 __x64_sys_execve+0x93/0xc0 fs/exec.c:2106
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f634f470337
Code: Unable to access opcode bytes at 0x7f634f47030d.
RSP: 002b:00007ffd71eedd08 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055b779eecd88 RCX: 00007f634f470337
RDX: 000055b779eecde8 RSI: 000055b779eecd88 RDI: 000055b779eece70
RBP: 000055b779eece70 R08: 000055b779eece75 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 000055b779eecde8
R13: 00007f634f615ff4 R14: 000055b779eecde8 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000556f700 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000556f9d0 RCX: 0000000000000000
RDX: ffff88802c0a57c0 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea00009b4f40 R15: ffffc9000556f9f8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f634f47030d CR3: 000000002c188000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1107ca0f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d29897480000

