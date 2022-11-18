Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFA62F3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiKRLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiKRLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:39:44 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551091534
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:39:43 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so2455010iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppTKvV8lYR3unZFrcBmZF3Llxes3KRwDUc8+QbMX/1c=;
        b=e2je9LxF/6J9hGqFiMQEwIR/1VzXtBNQUSX++Qy7ATyeqXGeafkiVYgel3RRQD9me8
         +KG8rExZ9CY9MITyxMbVoi7vcmG/4Hfnqcjue9/eRtX/fY162CZk32OHC/LHUZ5srvPi
         K9hyAShgAFTuLbPKu60d1kbjEUAeheG+M8+Mdc1v3PtW54u4hmmVKmZNCYnK4M1VHpXY
         b79vXTrwJvPGDlcdkF6Qi4+TuWNhc52MEVDesXTuLV4Ftn6gQYKgrWWnfvoxvTKlsk2p
         asb/eiOd+Z9EGeVaoJg0+k8qPjHLsW8RV5Uzh00jlTwoSTCrEkInfOgX4RpPe+2Exu+q
         uWXg==
X-Gm-Message-State: ANoB5pnW6QPijDigztH1zGUHgUWa6q4evo5aGgdg0bCsSvmuDpkivnu+
        rYy9BmHXjdYIxVGk+bpEFNDlUL48tiG1vRfnL2tJ1efQmY1f
X-Google-Smtp-Source: AA0mqf4IiZFadVbZYZUvg5mm9XsL/5p4e8usiT/mABR+v8OHEIH8dCoTDUNvlw3FvjOP8w3csD0NKTpW1gzr62TrGD84mnnVhXyX
MIME-Version: 1.0
X-Received: by 2002:a02:a04d:0:b0:372:66fb:26ac with SMTP id
 f13-20020a02a04d000000b0037266fb26acmr2748475jah.312.1668771582832; Fri, 18
 Nov 2022 03:39:42 -0800 (PST)
Date:   Fri, 18 Nov 2022 03:39:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067f65105edbd295d@google.com>
Subject: [syzbot] KMSAN: uninit-value in bpf_prog_run_generic_xdp
From:   syzbot <syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com>
To:     ben-linux@fluff.org, bp@alien8.de, daniel.sneddon@linux.intel.com,
        dave.hansen@linux.intel.com, glider@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

HEAD commit:    cb231e2f67ec fs: more fsdata fixes
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14ef6401880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc6d7125db95a828
dashboard link: https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eabbc575a06/disk-cb231e2f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01e99c04e1d7/vmlinux-cb231e2f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67893482166a/bzImage-cb231e2f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_run_generic_xdp+0x13ff/0x1a30 net/core/dev.c:4782
 bpf_prog_run_generic_xdp+0x13ff/0x1a30 net/core/dev.c:4782
 netif_receive_generic_xdp+0x639/0x910 net/core/dev.c:4845
 do_xdp_generic net/core/dev.c:4904 [inline]
 __netif_receive_skb_core+0x290f/0x6360 net/core/dev.c:5310
 __netif_receive_skb_one_core net/core/dev.c:5487 [inline]
 __netif_receive_skb+0xc8/0x5d0 net/core/dev.c:5603
 process_backlog+0x45a/0x890 net/core/dev.c:5931
 __napi_poll+0xe6/0x920 net/core/dev.c:6498
 napi_poll net/core/dev.c:6565 [inline]
 net_rx_action+0x9e8/0x1a20 net/core/dev.c:6676
 __do_softirq+0x1c5/0x7b9 kernel/softirq.c:571
 invoke_softirq+0x8f/0x100 kernel/softirq.c:445
 __irq_exit_rcu+0x5a/0x110 kernel/softirq.c:650
 irq_exit_rcu+0xe/0x10 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x9a/0xc0 arch/x86/kernel/apic/apic.c:1107
 asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
 kmsan_get_shadow_origin_ptr+0x34/0xa0 mm/kmsan/shadow.c:97
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:36 [inline]
 __msan_metadata_ptr_for_load_8+0x20/0x30 mm/kmsan/instrumentation.c:78
 unwind_get_return_address_ptr+0x97/0xc0 arch/x86/kernel/unwind_frame.c:28
 update_stack_state+0x177/0x1e0 arch/x86/kernel/unwind_frame.c:251
 unwind_next_frame+0x119/0x360 arch/x86/kernel/unwind_frame.c:315
 arch_stack_walk+0x1b9/0x280 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xb2/0x100 kernel/stacktrace.c:122
 kmsan_save_stack_with_flags mm/kmsan/core.c:75 [inline]
 kmsan_internal_poison_memory+0x45/0x90 mm/kmsan/core.c:60
 kmsan_slab_free+0xcd/0x130 mm/kmsan/hooks.c:90
 slab_free_hook mm/slub.c:1694 [inline]
 slab_free_freelist_hook mm/slub.c:1750 [inline]
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0x365/0xdb0 mm/slub.c:3683
 security_file_free+0x15d/0x1a0 security/security.c:1548
 file_free fs/file_table.c:56 [inline]
 __fput+0xbed/0xea0 fs/file_table.c:333
 ____fput+0x1a/0x20 fs/file_table.c:348
 task_work_run+0x229/0x2c0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x2a9/0x320 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0x16e/0x220 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x23/0x40 kernel/entry/common.c:296
 __do_fast_syscall_32+0xb1/0x100 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:742 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x6ee/0xc90 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node_track_caller+0x117/0x3d0 mm/slab_common.c:975
 kmalloc_reserve net/core/skbuff.c:437 [inline]
 pskb_expand_head+0x23d/0x1970 net/core/skbuff.c:1832
 netif_receive_generic_xdp+0x4c6/0x910 net/core/dev.c:4837
 do_xdp_generic net/core/dev.c:4904 [inline]
 __netif_receive_skb_core+0x290f/0x6360 net/core/dev.c:5310
 __netif_receive_skb_one_core net/core/dev.c:5487 [inline]
 __netif_receive_skb+0xc8/0x5d0 net/core/dev.c:5603
 process_backlog+0x45a/0x890 net/core/dev.c:5931
 __napi_poll+0xe6/0x920 net/core/dev.c:6498
 napi_poll net/core/dev.c:6565 [inline]
 net_rx_action+0x9e8/0x1a20 net/core/dev.c:6676
 __do_softirq+0x1c5/0x7b9 kernel/softirq.c:571

CPU: 0 PID: 3506 Comm: syz-executor.2 Tainted: G        W          6.1.0-rc4-syzkaller-62821-gcb231e2f67ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
