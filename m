Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C268CBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBGBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBGBJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:09:30 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCC33444
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:09:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so9401698ilj.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNjAbBozyx7wcXpmtSzf0rJ2bv8MKI+lFFm4SBCspBA=;
        b=bej4EFTuZ1tv+XsGFlFPmNm0JbBzFDmqvCNp1xyt3mnC7JY9IfPgVTtHq8gT9lKLbM
         NidYPlalqMe7eWvywOKz1TYF1O8tTqrNEkocRDKL9t//tKOkntqChnMKg4WR2B3N8f/3
         4yadw65T71Z/O8RLL2CwCgnmfwQXNGakxtLvlI2h1pnlsCygsYfavvkB72hKqNeXgWXm
         vMnJH+CzhZ7pYCWhkWHpABTZVGyUnD0ij/hwYVvK3bCK93eBUbWfN+B7z6hx/jDA3gwp
         JhgcQRWy0/r2j5NWjJDNOSPJoPWDF6Ivc2uOfnCMzs3qmUkCacCb2s3AzohyddkhnW2Z
         e57Q==
X-Gm-Message-State: AO0yUKW3ElEbNAcMRmYmlSkqxF99/QbdM4FIpt+zmQ2CB/xhXKd7u2Cz
        55mxpQ44lpB5I2X5HmoB0PPkALOZvyeznSD5x34bpc5Hzsu5
X-Google-Smtp-Source: AK7set+ZeYTIBQQQOcCwO0qQigJ1lJxKsvVDNdV6w6NIuNwyisVlvNRCcm60+sSyvVUAyTwKnEuJKEVRAC/012c6aUvfgSqX6Pgd
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:313:ba55:a892 with SMTP id
 g14-20020a056e021a2e00b00313ba55a892mr619174ile.121.1675732168707; Mon, 06
 Feb 2023 17:09:28 -0800 (PST)
Date:   Mon, 06 Feb 2023 17:09:28 -0800
In-Reply-To: <20230207002846.844-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7975f05f411cc43@google.com>
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

 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 iov_iter_revert.part.0+0x402/0x730 lib/iov_iter.c:935
 iov_iter_revert+0x4c/0x60 lib/iov_iter.c:919
 __iomap_dio_rw+0x16cb/0x1d80 fs/iomap/direct-io.c:610
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
------------[ cut here ]------------
kernel BUG at mm/mmu_gather.c:143!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5736 Comm: dhcpcd-run-hook Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x25b/0x480 mm/mmu_gather.c:143
Code: 0f 82 d6 fe ff ff e9 4e ff ff ff e8 9f 63 c1 ff 0f 0b e8 98 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 55 0b fa ff <0f> 0b e8 8e 66 10 00 e9 94 fe ff ff e8 84 66 10 00 e9 2b fe ff ff
RSP: 0018:ffffc90005207700 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900052079d0 RCX: 0000000000000000
RDX: ffff888020ac3a80 RSI: ffffffff81c3071b RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffffea0000ab5f80 R15: ffffc900052079f8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7e7115829 CR3: 0000000070a22000 CR4: 00000000003506f0
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
RIP: 0033:0x7f9716b02337
Code: Unable to access opcode bytes at 0x7f9716b0230d.
RSP: 002b:00007ffd26cedb58 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000558ec09bde40 RCX: 00007f9716b02337
RDX: 0000558ec09bde68 RSI: 0000558ec09bde40 RDI: 0000558ec09bdef8
RBP: 0000558ec09bdef8 R08: 0000558ec09bdefd R09: 00007f9716cf4000
R10: 00007f9716998800 R11: 0000000000000246 R12: 0000558ec09bde68
R13: 00007f9716ca7ff4 R14: 0000558ec09bde68 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x25b/0x480 mm/mmu_gather.c:143
Code: 0f 82 d6 fe ff ff e9 4e ff ff ff e8 9f 63 c1 ff 0f 0b e8 98 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 55 0b fa ff <0f> 0b e8 8e 66 10 00 e9 94 fe ff ff e8 84 66 10 00 e9 2b fe ff ff
RSP: 0018:ffffc90005207700 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900052079d0 RCX: 0000000000000000
RDX: ffff888020ac3a80 RSI: ffffffff81c3071b RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffffea0000ab5f80 R15: ffffc900052079f8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7e7115829 CR3: 0000000070a22000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4295d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e01439480000

