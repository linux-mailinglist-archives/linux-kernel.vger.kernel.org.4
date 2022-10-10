Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E165F9F36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJJNNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJJNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:13:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90D15718
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:13:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q9so20278036ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iVz/ilvfdwAMO4gMvquqTbDyou12ZbtZ1DVV4h6QMb8=;
        b=Eq70yP1A3s/A8dyvDwdecm+5TckomJqpKFTdoCU/RMAlXtp7G9g5S8UTrGzGq4qp5j
         FyWku7HerBs8RAL7xhTHuXVCh+2YkSOZV1TaIOPBvsB6YoCy0h2XupBOaAAkFJM9mg6e
         wG69+FV9jlJ9T7aOBZSFArhYpiI7iKJ49KCGIm7+TkDy+XOgVqU6Nw73EQsb/2m71Nzv
         K1XZHiQOlH5Ho1xZJSKlJFukbsm/jTZ5jDTd/QEA4uDIfVHDrjxRpYy28jBqeZlMfeLT
         Irz2ZdnfgwdRIf33iUXnWxtAFMfwNM1Z7Y2x7R9jfoHfnjbd0gLreJqN8YnvI/eA9kOj
         EBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVz/ilvfdwAMO4gMvquqTbDyou12ZbtZ1DVV4h6QMb8=;
        b=QxBydJIfzdoFP6Mb7sboM0E/23bzbY1G+hvjxOMIiAjH5UTyCH+r0vgFpEU+aJOnUl
         nY88FLZr8jVBO2AWPhdAIGIiSJrmTexXLiK0Xz+ySRoGRTVdCCKwOci0MJMqE9M2v/Mr
         sjpMhWu1oLtOYjjyPnlYbaRMSj+M1axjqRz8T9g/SUFdWZziB1dXLYjdSpKR7uxRs6Ap
         ZROuBoHg+EfW8KKWa2lpdBiRfTMgZlWtg+QBfNOWh9t+jj+kzRMuQP9K+p5ga0rAE8eF
         NnuZCl11rSHsaHbhQb3+425dPsbMefPUEkgFcqkmWeG720vJ8L6pqWPSyaUlDpGKpdzT
         SfOg==
X-Gm-Message-State: ACrzQf07pMj6akRCVHjy9rMd1G2klHsqYkbWqwRutTr1Q/AM+Xd7zBbE
        0pImZ3NSFqkIfiobZVr9m7NSkMTkv4DlmTXhwuI4XWDaryI=
X-Google-Smtp-Source: AMsMyM6DcAFmcdF2KusTivt7NHfO3GCaKcw/MIlHQd+NNr8HzclkftXh18VU5jAsb72woxXBVD97URkIGhKyR+o/J8A=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr2288103ejc.235.1665407624268; Mon, 10
 Oct 2022 06:13:44 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 21:13:09 +0800
Message-ID: <CAO4mrffPq=UEadx8ky=FkH-qk__LoV22Rb4BFGPa9EF+v=+v5Q@mail.gmail.com>
Subject: KASAN: use-after-free Read in raw_notifier_call_chain
To:     bigeasy@linutronix.de, bp@suse.de, stern@rowland.harvard.edu
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: c5eb0a61238d Linux 5.18-rc6
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/18zXJUa02xIJTl7FgYkXLMtCmDVz1SGYt/view?usp=sharing
kernel config: https://drive.google.com/file/d/12fNP5UArsFqTi2jjGomWuCk5evtgU0Gu/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

BUG: KASAN: use-after-free in raw_notifier_call_chain+0x3e/0x170
Read of size 8 at addr ffff8880243a01f8 by task syz-executor/7401

CPU: 0 PID: 7401 Comm: syz-executor Not tainted 5.18.0-rc6 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1b1/0x28e
 print_address_description+0x65/0x4b0
 print_report+0xf4/0x1e0
 kasan_report+0xc3/0xf0
 raw_notifier_call_chain+0x3e/0x170
 netdev_run_todo+0x97e/0x1120
 tun_chr_close+0x11f/0x130
 __fput+0x3f3/0x860
 task_work_run+0x146/0x1c0
 do_exit+0x55d/0x1ef0
 do_group_exit+0x23b/0x2f0
 get_signal+0x2310/0x2360
 arch_do_signal_or_restart+0x7b/0x710
 exit_to_user_mode_prepare+0x154/0x210
 syscall_exit_to_user_mode+0x26/0x60
 do_syscall_64+0x4c/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5556695c4d
Code: Unable to access opcode bytes at RIP 0x7f5556695c23.
RSP: 002b:00007f5557863cd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f55567bc0a0 RCX: 00007f5556695c4d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f55567bc0a8
RBP: 00007f55567bc0a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f55567bc0ac
R13: 00007ffcf6f9e50f R14: 00007ffcf6f9e6b0 R15: 00007f5557863dc0
 </TASK>

Allocated by task 6553:
 __kasan_slab_alloc+0xa3/0xd0
 kmem_cache_alloc+0x1c0/0x300
 copy_net_ns+0x13c/0x5c0
 create_new_namespaces+0x4ce/0xa00
 unshare_nsproxy_namespaces+0x11e/0x180
 ksys_unshare+0x573/0xb60
 __x64_sys_unshare+0x34/0x40
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 81:
 kasan_set_track+0x3d/0x60
 kasan_set_free_info+0x1f/0x40
 ____kasan_slab_free+0x130/0x1d0
 slab_free_freelist_hook+0x12e/0x1a0
 kmem_cache_free+0xc6/0x2c0
 cleanup_net+0xb81/0xc40
 process_one_work+0x83c/0x11a0
 worker_thread+0xa6c/0x1290
 kthread+0x266/0x300
 ret_from_fork+0x1f/0x30

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50
 __kasan_record_aux_stack+0xac/0xc0
 insert_work+0x54/0x3e0
 __queue_work+0x979/0xcc0
 call_timer_fn+0xf5/0x210
 __run_timers+0x792/0x970
 __do_softirq+0x372/0x783

The buggy address belongs to the object at ffff8880243a0000
 which belongs to the cache net_namespace of size 6656
The buggy address is located 504 bytes inside of
 6656-byte region [ffff8880243a0000, ffff8880243a1a00)

The buggy address belongs to the physical page:
page:ffffea000090e800 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x243a0
head:ffffea000090e800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00008af200 dead000000000002 ffff8880115c73c0
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 6553, tgid 6553 (syz-executor), ts 38572126085, free_ts
38569018784
 get_page_from_freelist+0x708/0xab0
 __alloc_pages+0x26c/0x5f0
 alloc_slab_page+0x70/0xf0
 allocate_slab+0x5d/0x380
 ___slab_alloc+0x3de/0xc30
 kmem_cache_alloc+0x26d/0x300
 copy_net_ns+0x13c/0x5c0
 create_new_namespaces+0x4ce/0xa00
 unshare_nsproxy_namespaces+0x11e/0x180
 ksys_unshare+0x573/0xb60
 __x64_sys_unshare+0x34/0x40
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 free_pcp_prepare+0xd20/0xec0
 free_unref_page+0x7d/0x560
 __unfreeze_partials+0x1ab/0x200
 put_cpu_partial+0x106/0x170
 ___cache_free+0x10f/0x1b0
 kasan_quarantine_reduce+0x127/0x190
 __kasan_slab_alloc+0x2f/0xd0
 kmem_cache_alloc+0x1c0/0x300
 getname_flags+0xba/0x650
 do_sys_openat2+0xba/0x4e0
 __x64_sys_open+0x221/0x270
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff8880243a0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880243a0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880243a0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff8880243a0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880243a0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Best,
Wei
