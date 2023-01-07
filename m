Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE9660C89
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 06:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAGFUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 00:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjAGFUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 00:20:41 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5E90858
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:20:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id u1-20020a5d8181000000b006ee29a8c421so1851271ion.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 21:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FADCNy7n38CfYDntPx+PQhFQ1Q2bB204nONFeBWUtX0=;
        b=TuAbImyxWyLL+UF23LXqOCF2jm4s1PKWvdcToTx/d7o8rCI4f35QGLRVY9pP1xqLW3
         Jwf1ELXwnfHK1DfSwREOLYsdmJ6xYITuFBl8ZNXtU+XQNYGuL7i5SA8U2UK+a1/KuZ25
         VIRaqb5l/kxOlVORUy7mQtGeLL2BZb5ufBFFo3JBgSbEWRI60PxSNjOAIynmtSSsSO3E
         Z+Pav7BKGMOLcLmMZ1XRGkD0NPIvwI7jgIMvY69/mLALlme1kIJmVxaz5PmKlWOYbd3L
         rX9r8Rl3EzmVQdVoepjQbyO5JL5mQLlGOhRY5YsqwntFXveESBTICxZ6JUvctmT21+3c
         yeRQ==
X-Gm-Message-State: AFqh2kpOAMVZe/5nsYkVlE+cWMTmTE7i8kpRl1oLppU4i3FhJKyNFOrL
        yho7KvmQiaM0xIxf8LWf4hbjrqtoOrnjnQGx69PG6mgfPLVC
X-Google-Smtp-Source: AMrXdXsuOpgpxz+Hll+aX0jrSkxxnROnc4NnvAsS6IryfstKcSPrcjOgF22uyGaOa2xhP6KApZ4p9wtRYHXhcdE6seWSwJwdUpFz
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2426:b0:6e5:d22f:f298 with SMTP id
 g6-20020a056602242600b006e5d22ff298mr4247661iob.158.1673068839335; Fri, 06
 Jan 2023 21:20:39 -0800 (PST)
Date:   Fri, 06 Jan 2023 21:20:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da806205f1a5b139@google.com>
Subject: [syzbot] KASAN: wild-memory-access Read in io_wq_worker_running
From:   syzbot <syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=119ff44b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=d56ec896af3637bdb7e4
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in io_wq_worker_running+0x3e/0xda fs/io-wq.c:684
Read of size 4 at addr 4d019002494080eb by task kworker/u4:4/2069

CPU: 0 PID: 2069 Comm: kworker/u4:4 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue:  0x0 (events_unbound)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff80474da6>] __kasan_report mm/kasan/report.c:446 [inline]
[<ffffffff80474da6>] kasan_report+0x1de/0x1e0 mm/kasan/report.c:459
[<ffffffff804759f4>] check_region_inline mm/kasan/generic.c:183 [inline]
[<ffffffff804759f4>] __asan_load4+0x6e/0x96 mm/kasan/generic.c:255
[<ffffffff805d049e>] io_wq_worker_running+0x3e/0xda fs/io-wq.c:684
[<ffffffff831a698a>] sched_update_worker kernel/sched/core.c:6358 [inline]
[<ffffffff831a698a>] schedule+0x100/0x14c kernel/sched/core.c:6372
[<ffffffff80094966>] worker_thread+0x478/0x8fa kernel/workqueue.c:2475
[<ffffffff800a7f58>] kthread+0x19e/0x1fa kernel/kthread.c:377
==================================================================
Unable to handle kernel paging request at virtual address 4d019002494080eb
Oops [#1]
Modules linked in:
CPU: 1 PID: 2069 Comm: kworker/u4:4 Tainted: G    B             5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue:  0x0 (events_unbound)
epc : io_wq_worker_running+0x3e/0xda fs/io-wq.c:684
 ra : io_wq_worker_running+0x3e/0xda fs/io-wq.c:684
epc : ffffffff805d049e ra : ffffffff805d049e sp : ffffaf800bb37d80
 gp : ffffffff85863ac0 tp : ffffaf800bf7e100 t0 : 00000000000001f8
 t1 : fffff5ef0181524a t2 : 0000000000000008 s0 : ffffaf800bb37db0
 s1 : 4d019002494080e7 a0 : 0000000000000001 a1 : 0000000000000007
 a2 : 1ffff5f0017efc20 a3 : ffffffff831a6b2e a4 : 0000000000000000
 a5 : ffffaf800bf7f100 a6 : 0000000000f00000 a7 : ffffaf800c0a9253
 s2 : ffffaf800bf7e100 s3 : ffffaf800bf7e13c s4 : ffffaf800bf7f100
 s5 : ffffaf8007229860 s6 : ffffffff84a0c540 s7 : ffffaf8007229858
 s8 : ffffaf8007229850 s9 : ffffffff84c3efc0 s10: ffffaf8009eaaa40
 s11: 0000000100012ed1 t3 : 00007fffb787228c t4 : fffff5ef0181524a
 t5 : fffff5ef0181524b t6 : 762d766373000000
status: 0000000000000120 badaddr: 4d019002494080eb cause: 000000000000000d
[<ffffffff831a698a>] sched_update_worker kernel/sched/core.c:6358 [inline]
[<ffffffff831a698a>] schedule+0x100/0x14c kernel/sched/core.c:6372
[<ffffffff80094966>] worker_thread+0x478/0x8fa kernel/workqueue.c:2475
[<ffffffff800a7f58>] kthread+0x19e/0x1fa kernel/kthread.c:377
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
