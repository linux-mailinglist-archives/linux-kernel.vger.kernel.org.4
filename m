Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97693745A79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGCKnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGCKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:43:04 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FCC2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:42:58 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-55bb3749006so393015a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380978; x=1690972978;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hTTuLmZnGpvEn8HYNxZkLSLDrqh7PUM5SevNCYkDSs=;
        b=F6axRPCZdh1YtGurs/B/NP8OWLpVybJD6QHTDPTAxEFd6RRZ9mDp5YqaOxh+pI4ke4
         D2ugKKaqCJpQQuMmgn9AN0oZKZHQFmlwXzxe91EJ6VWDdIorSB82wH51cW+KkfwGP88l
         78jxZ9/L/R2omKNclIy1lUslD2rNSnm0uUFVMD/M2KZclUKkLaZdzLP1h5WAy2RBMX77
         TzfLrnJFPDnAcITZvBVsGSvqX6wQuJlgTgLNBPawYEmJ+ZSzbHv5dseRqeYwPQrn4eiC
         ALQzfjcDrzycY7c4lMaTT53jvR0Hx3Bc1flhDrQZUguJujbE8phkerIiU0QlOc3+s++I
         aoGQ==
X-Gm-Message-State: ABy/qLYGdmoAMUZZllodK2u8cQn/CBY6tPEGFq8VHrtrG5BPszBvuqjJ
        2dWU8kqSdx+AXy6ffk5NuV43xHc/Ax3/VVJFvKvg8KA3TJHA
X-Google-Smtp-Source: APBJJlFNf0574orWPRyEjT20tj8wIh4w7qYtJOJcwIdo+/8lxNRYLtKzgHnaX6UN/64l9LW+qURvnupFshxYIIJJ+pN3QFkQPlD8
MIME-Version: 1.0
X-Received: by 2002:a17:902:8642:b0:1b8:9eca:d6a7 with SMTP id
 y2-20020a170902864200b001b89ecad6a7mr544505plt.7.1688380978400; Mon, 03 Jul
 2023 03:42:58 -0700 (PDT)
Date:   Mon, 03 Jul 2023 03:42:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076961f05ff92d4e0@google.com>
Subject: [syzbot] [modules?] WARNING in init_module_from_file
From:   syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b009e7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f4ca96cdf82c7
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1465b04f280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127c9dfb280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a940531a9b86/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f3cbae5be61/Image-3a8a670e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com

------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000083a x12: 00000000000002be
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000008a6 x12: 00000000000002e2
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000912 x12: 0000000000000306
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000097e x12: 000000000000032a
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000009ea x12: 000000000000034e
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000a56 x12: 0000000000000372
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ac2 x12: 0000000000000396
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000b2e x12: 00000000000003ba
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000b9a x12: 00000000000003de
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c06 x12: 0000000000000402
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 233598 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000c75 x12: 0000000000000427
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000ce1 x12: 000000000000044b
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000d4d x12: 000000000000046f
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000db9 x12: 0000000000000493
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000e25 x12: 00000000000004b7
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000e91 x12: 00000000000004db
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000efd x12: 00000000000004ff
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000f69 x12: 0000000000000523
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000000fd5 x12: 0000000000000547
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001041 x12: 000000000000056b
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
__do_kernel_fault: 219598 callbacks suppressed
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000010b0 x12: 0000000000000590
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : ffff00007f9b8cc8 x4 : 0000000000000000 x3 : ffff7ffffd5f8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 000000000000111c x12: 00000000000005b4
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001188 x12: 00000000000005d8
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000011f4 x12: 00000000000005fc
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001260 x12: 0000000000000620
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 00000000000012cc x12: 0000000000000644
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
lr : __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
sp : ffff800082b2baa0
x29: ffff800082b2baa0 x28: f4ff0000035fde80 x27: 0000000000000000
x26: ffff800082680358 x25: ffff80008267fb58 x24: f6ff000003101dc0
x23: 00000000a0400009 x22: 0000000000000025 x21: ffff800082833d08
x20: ffff800082b2bb60 x19: 0000000097c18007 x18: 00000000fffffffb
x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
x14: ffff80008240b048 x13: 0000000000001338 x12: 0000000000000668
x11: 2073736572646461 x10: ffff8000824bb048 x9 : 00000000ffffe000
x8 : ffff80008240b048 x7 : ffff8000824bb048 x6 : 0000000000000000
x5 : 0000000000017ff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000035fde80
Call trace:
 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
 do_bad_area arch/arm64/mm/fault.c:493 [inline]
 do_translation_fault+0x50/0xb8 arch/arm64/mm/fault.c:746
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:880
 el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:369
 el1h_64_sync_handler+0xd8/0xe4 arch/arm64/kernel/entry-common.c:429
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:586
 idempotent kernel/module/main.c:3077 [inline]
 init_module_from_file+0xd4/0x2b4 kernel/module/main.c:3124
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __arm64_sys_finit_module+0x64/0xa0 kernel/module/main.c:3154
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address ffff800082833d08
WARNING: CPU: 0 PID: 3090 at arch/arm64/mm/fault.c:388 __do_kernel_fault+0x158/0x1c0 arch/arm64/mm/fault.c:388
Modules linked in:
CPU: 0 PID: 3090 Comm: syz-executor297 Tainted: G        W          6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __do_kernel

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
