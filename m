Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE168CCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBGCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGCrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:47:18 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B323C76
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:47:16 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b10-20020a5ea70a000000b0071a96a509a7so8319715iod.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9LC2tPa4BEj35+AqKSCADQQwrolY8Ls2H7/MLFWbXI=;
        b=E6oTACe8H5PL/bNQmKLdmRRpy0AC3Ztd0jDqFrsvhBHbURtsDI+CNeI+hMI+BrwYcU
         bR/ceHMoMS6R2GS/YLc082x6cbfMz4gLxjyehPvukXDyUYDzBGHilrvoVJDxOdIE/hxL
         b3PEW7UdMbPH5oCc3itSKakV9zx1lA7D8Y2dqZN6KEEBZpBhhwM5MWyXr8PT+Uenno3q
         ig1PT3aJ5LN8nGymFnsqXbwff8Yf1+WEF0wxNzunLTSk8TDfxUIdlaqmVYIdVxWp19aj
         QOMD4aEY2DLzJSDuU+tVNSF97xJWjLu5YRs0PM9CwUUFWtbqhVZ9dpTpQ/5YNf6Rrjrb
         pwpw==
X-Gm-Message-State: AO0yUKXtbjv0jmCnwrJ3wkLLDPKhMq9KPkIxYEycsMw8sxNXQW0SONB8
        bBIiLNl7FDu25wgYY4rlBecJkwJpsYbdtXszw3RdUyOg8lIf
X-Google-Smtp-Source: AK7set9vjsa3/S9a5S62+01Bt6AN0t9KoWXq+sofxDZOPY6aSYivseIp0P3pBRqgZu6entPPqe8eJ1MXqs2/lGuY39SDSQzl+aab
MIME-Version: 1.0
X-Received: by 2002:a6b:3e09:0:b0:731:b0cf:1742 with SMTP id
 l9-20020a6b3e09000000b00731b0cf1742mr833888ioa.78.1675738035743; Mon, 06 Feb
 2023 18:47:15 -0800 (PST)
Date:   Mon, 06 Feb 2023 18:47:15 -0800
In-Reply-To: <20230207023236.975-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b75e305f4132a17@google.com>
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

page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3390 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3485
 free_reserved_page include/linux/mm.h:2796 [inline]
 free_reserved_area+0x15d/0x200 mm/page_alloc.c:8538
 free_init_pages+0x94/0xc0 arch/x86/mm/init.c:915
 kernel_init+0x32/0x2c0 init/main.c:1531
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:139!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5672 Comm: dhcpcd-run-hook Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90005a6f5d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90005a6f9d0 RCX: 0000000000000000
RDX: ffff88801ed80000 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea00003fde40 R15: ffffc90005a6f9f8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6eb4c40900 CR3: 0000000071157000 CR4: 00000000003506e0
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
RIP: 0033:0x7f6eb4bb0337
Code: Unable to access opcode bytes at 0x7f6eb4bb030d.
RSP: 002b:00007ffe1aff9aa8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 000055f08f0f5e40 RCX: 00007f6eb4bb0337
RDX: 000055f08f0f5e68 RSI: 000055f08f0f5e40 RDI: 000055f08f0f5ef8
RBP: 000055f08f0f5ef8 R08: 000055f08f0f5efd R09: 00007f6eb4da2000
R10: 00007f6eb4a46800 R11: 0000000000000246 R12: 000055f08f0f5e68
R13: 00007f6eb4d55ff4 R14: 000055f08f0f5e68 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x24c/0x480 mm/mmu_gather.c:139
Code: 01 00 00 8b 6d 0c e9 e1 fe ff ff e8 ae 63 c1 ff 0f 0b e8 a7 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 64 0b fa ff <0f> 0b e8 8d 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc90005a6f5d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90005a6f9d0 RCX: 0000000000000000
RDX: ffff88801ed80000 RSI: ffffffff81c3070c RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffffea00003fde40 R15: ffffc90005a6f9f8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6eb4bb030d CR3: 0000000071157000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13b20813480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163a5987480000

