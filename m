Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C567A652DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiLUIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiLUIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:03:48 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3921810
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:03:47 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id f23-20020a5d8157000000b006dfb209094fso6565757ioo.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcpYeLe28CqPmFqlo0JZbFBlBQjAkRrx+VpXaCL5upY=;
        b=h8epAaQhMi/ZyNDMYYaK/H8ah7hY/i+JKldBC8mEvmrEf/4hzGIMrpQoRU6gYSpwFr
         IJbA/Lqh2Iau/u+2kFJJB1GlaD91wUIPrsvR5XgjMsbAuPgOX1XvQ6s9YCmdoVDTi28J
         HxWhhIyXizI61G+Wcc5JT8gBtGgRU0UB4Nvvj8zBRLXPGnR2jN6bes7qV3cWbeOcmgUU
         Ib4Bx4qjVZdnUdcNhJddfWubfDzf7ySsv4jb4kulcf9ISG8D+DShVvjMll7InhwcZRLJ
         6KeTdNxep5p9Bpo0B+tgSqtwsYNYXuhp/pgnugeNTJ0+KPKpntxrZQ4DubTbOoD/xOvN
         2riA==
X-Gm-Message-State: AFqh2kor64Xj0GHg4YntA6H3uURAxisH0lLtVvoj1jPgpVP8yQ+IAlrQ
        AgL2whTSjVbj7Hj02Z/PDks20WN3cC0+UswipMQr0tsy7eTH
X-Google-Smtp-Source: AMrXdXt/V+efK9DnSiMUcUwxMyt9SpO2bacPrJu9U2geyQJAhySb/bEGvNsgFb01hq7PqH0K9F1ExtaWhI7Qn4cMt7vahzGqvg+G
MIME-Version: 1.0
X-Received: by 2002:a92:d94e:0:b0:303:27a5:b9d7 with SMTP id
 l14-20020a92d94e000000b0030327a5b9d7mr114126ilq.12.1671609826570; Wed, 21 Dec
 2022 00:03:46 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:03:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea7a5c05f051fd00@google.com>
Subject: [syzbot] riscv/fixes boot error: WARNING in __apply_to_page_range (2)
From:   syzbot <syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com>
To:     andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org,
        bjorn@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, luke.r.nels@gmail.com,
        martin.lau@linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        xi.wang@gmail.com, yhs@fb.com
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

HEAD commit:    eb67d239f3aa Merge tag 'riscv-for-linus-6.2-mw1' of git://..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=16672680480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be108b5bcf4ef832
dashboard link: https://syzkaller.appspot.com/bug?extid=5702f46b5b22bdb38b7e
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_pmd_range mm/memory.c:2637 [inline]
WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_pud_range mm/memory.c:2680 [inline]
WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 apply_to_p4d_range mm/memory.c:2716 [inline]
WARNING: CPU: 0 PID: 2760 at mm/memory.c:2637 __apply_to_page_range+0x988/0x1212 mm/memory.c:2750
Modules linked in:
CPU: 0 PID: 2760 Comm: dhcpcd Not tainted 6.1.0-syzkaller-13662-geb67d239f3aa #0
Hardware name: riscv-virtio,qemu (DT)
epc : apply_to_pmd_range mm/memory.c:2637 [inline]
epc : apply_to_pud_range mm/memory.c:2680 [inline]
epc : apply_to_p4d_range mm/memory.c:2716 [inline]
epc : __apply_to_page_range+0x988/0x1212 mm/memory.c:2750
 ra : apply_to_pmd_range mm/memory.c:2637 [inline]
 ra : apply_to_pud_range mm/memory.c:2680 [inline]
 ra : apply_to_p4d_range mm/memory.c:2716 [inline]
 ra : __apply_to_page_range+0x988/0x1212 mm/memory.c:2750
epc : ffffffff8042aac8 ra : ffffffff8042aac8 sp : ff20000004d57290
 gp : ffffffff85cdd280 tp : ff6000000e206200 t0 : ff60000010988a00
 t1 : 00000000000f0000 t2 : ffffffff804616b4 s0 : ff20000004d57380
 s1 : 0000000000000006 a0 : 0000000000000007 a1 : 00000000000f0000
 a2 : ffffffff8042aac8 a3 : 0000000000000002 a4 : ff6000000e207200
 a5 : 0000000000000000 a6 : 0000000000000003 a7 : 0000000000000000
 s2 : fffffffeef001000 s3 : 00000000371000e7 s4 : ff6000007a660bc0
 s5 : 0000000000001000 s6 : fffffffeef001000 s7 : 0000000000000001
 s8 : ffffffff804d8484 s9 : 0000000000000000 s10: fffffffeef000000
 s11: 0000000000000000 t3 : fffffffff3f3f300 t4 : fffffffef0a07c70
 t5 : fffffffef0a07c71 t6 : ff6000000ebcccb8
status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff8042b386>] apply_to_page_range+0x34/0x46 mm/memory.c:2769
[<ffffffff804d872a>] kasan_populate_vmalloc+0x52/0x5e mm/kasan/shadow.c:315
[<ffffffff804619e0>] alloc_vmap_area+0x4a6/0x1636 mm/vmalloc.c:1647
[<ffffffff80462de2>] __get_vm_area_node+0x272/0x3b0 mm/vmalloc.c:2515
[<ffffffff8046917c>] __vmalloc_node_range+0x280/0xdb8 mm/vmalloc.c:3187
[<ffffffff800192c0>] bpf_jit_alloc_exec+0x46/0x52 arch/riscv/net/bpf_jit_core.c:190
[<ffffffff80282f10>] bpf_jit_binary_alloc+0x96/0x13c kernel/bpf/core.c:1027
[<ffffffff8001904c>] bpf_int_jit_compile+0x87a/0xa8c arch/riscv/net/bpf_jit_core.c:112
[<ffffffff80284d76>] bpf_prog_select_runtime+0x1a2/0x22e kernel/bpf/core.c:2191
[<ffffffff828a6840>] bpf_migrate_filter+0x258/0x2be net/core/filter.c:1298
[<ffffffff828acbec>] bpf_prepare_filter+0x10e/0x1b4 net/core/filter.c:1346
[<ffffffff828acfbc>] __get_filter+0x148/0x1a0 net/core/filter.c:1515
[<ffffffff828b3e7c>] sk_attach_filter+0x22/0x11a net/core/filter.c:1530
[<ffffffff827f1af4>] sk_setsockopt+0x144e/0x270c net/core/sock.c:1297
[<ffffffff827f2dfa>] sock_setsockopt+0x48/0x58 net/core/sock.c:1549
[<ffffffff827dfcc8>] __sys_setsockopt+0x3f0/0x418 net/socket.c:2242
[<ffffffff827dfd2a>] __do_sys_setsockopt net/socket.c:2257 [inline]
[<ffffffff827dfd2a>] sys_setsockopt+0x3a/0x4c net/socket.c:2254
[<ffffffff80005ff6>] ret_from_syscall+0x0/0x2
irq event stamp: 940
hardirqs last  enabled at (939): [<ffffffff833903b0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (939): [<ffffffff833903b0>] _raw_spin_unlock_irqrestore+0x68/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (940): [<ffffffff800105e0>] __trace_hardirqs_off+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
softirqs last  enabled at (888): [<ffffffff8339107a>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (888): [<ffffffff8339107a>] __do_softirq+0x640/0x930 kernel/softirq.c:600
softirqs last disabled at (883): [<ffffffff80069192>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (883): [<ffffffff80069192>] invoke_softirq kernel/softirq.c:452 [inline]
softirqs last disabled at (883): [<ffffffff80069192>] __irq_exit_rcu+0x154/0x1ea kernel/softirq.c:650
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
