Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8868AEB6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 08:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBEHkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 02:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEHkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 02:40:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A9234C6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 23:40:19 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id p18-20020a92d692000000b00313bc1cbec3so810054iln.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 23:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j57TLy4Q0J2aFbL2VyTzxMcAEOEsdfNl9GyMGOcH5v0=;
        b=Af7gl29W1KMd7HNd+IrKqLcK01VdhDKK+f+c+IEuN2IerzL9HEjvdPsKBAv4Ewdi+K
         TFC7lPBcQYp+6N/xsMWvxofOIfqQ8olPlRLKi0oE21QzH/HXY4WetcMwNPNkAHT5rEX4
         PtaGcjbUTxoyhvgRpEPhlwLaxTSjDb1aEgNdqkGy0W7wJ2h/HKMpthEnp4ik4vVpePqG
         5OaGyC73nNEFYGxNr5ib5lPA6LrhOWmxevFTgrkWxy+4iraq8u8KYLy+hhx15LT2rXbP
         msDNTc0ZMZRtuamHkTfy87exkCxcBNoFnROWG4+DWZ5wAy+Io7Pnv3lhOt3lYxwdohOu
         RueQ==
X-Gm-Message-State: AO0yUKXIzkQRH4TEknkCT716EGEJQg/m26pJBHLc7k5eMVW1gSuBGprB
        nJ7gHlyVIqCSsVyainb+unvGoo1bxsbE6I5p3GS5FynaYrit
X-Google-Smtp-Source: AK7set8VtOr0sg0calLctW9zRm45YeyZDUaJ85pDbbypUE3vZUZ/HMwR3WyHH/4NCB1k9+WWBrUR6GxJBP+erRwLCWI2ghC81GHq
MIME-Version: 1.0
X-Received: by 2002:a02:cbcc:0:b0:3ad:800c:6c7a with SMTP id
 u12-20020a02cbcc000000b003ad800c6c7amr4122876jaq.9.1675582818868; Sat, 04 Feb
 2023 23:40:18 -0800 (PST)
Date:   Sat, 04 Feb 2023 23:40:18 -0800
In-Reply-To: <20230205072452.1229-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5e8a305f3ef06e2@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size (2)
From:   syzbot <syzbot+d87dd8e018fd2cc2528b@syzkaller.appspotmail.com>
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

 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
 ondemand_readahead+0x6b3/0x1080 mm/readahead.c:682
 page_cache_async_ra mm/readahead.c:731 [inline]
 page_cache_async_ra+0x117/0x150 mm/readahead.c:713
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
kernel BUG at mm/mmu_gather.c:141!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6123 Comm: rm Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__tlb_remove_page_size+0x25e/0x490 mm/mmu_gather.c:141
Code: 0f 85 d3 fe ff ff e9 4b ff ff ff e8 9c 63 c1 ff 0f 0b e8 95 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 52 0b fa ff <0f> 0b e8 7b 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000acef8d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000acefcd8 RCX: 0000000000000000
RDX: ffff88807fa50000 RSI: ffffffff81c3071e RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffea0004ffbec0 R15: ffffc9000acefd00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa85e158300 CR3: 0000000027f28000 CR4: 00000000003506f0
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
RIP: 0033:0x7fa85e236309
Code: Unable to access opcode bytes at 0x7fa85e2362df.
RSP: 002b:00007ffca8049e88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa85e324780 RCX: 00007fa85e236309
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffff88 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fa85e324780
R13: 0000000000000001 R14: 00007fa85e329c88 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tlb_remove_page_size+0x25e/0x490 mm/mmu_gather.c:141
Code: 0f 85 d3 fe ff ff e9 4b ff ff ff e8 9c 63 c1 ff 0f 0b e8 95 63 c1 ff 4c 89 f7 48 c7 c6 c0 77 58 8a 48 83 e7 fc e8 52 0b fa ff <0f> 0b e8 7b 63 c1 ff 4c 8d 6b 24 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000acef8d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000acefcd8 RCX: 0000000000000000
RDX: ffff88807fa50000 RSI: ffffffff81c3071e RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8e751757
R10: fffffbfff1cea2ea R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffffea0004ffbec0 R15: ffffc9000acefd00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa85e158300 CR3: 000000000c56f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6ec5d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=d87dd8e018fd2cc2528b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1060626b480000

