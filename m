Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C3720FFB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFCMDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjFCMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:03:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45374196
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 05:03:32 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565eaf83853so33337027b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685793811; x=1688385811;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eX7YG6BVEMEP21fHKJSG6/RY6jlCr7dwM5TuWcCpLgc=;
        b=KQiHel4kJtRadP0r1mR2IdN4mKuJIsTjIIv5i7D1C3nHwMBkfkJuNsFfkCxJ6ox4bl
         Nebv3AhH0NaEsTk0DWZTZwazQpOKA79QznovF1I6issYYturJMTT6L//PiG1qVIR+9u9
         WzUPt6m6KwIhzcUB3pzhy4Bbf1wMEJhkFrX77BY0cSOfQu50KPRX8u33QSLBPARRdzjx
         0IwUa0A0uNqlklTdk+jIQ6IfD1IU4cT/o6uIlxZuTIqhmy2joI6ozgx5RRa4GCQVWnsU
         fMcoNV79SoqIQiN40YUQgyCcazFMWQ/RicqUqTpdtawkRQ+k4Ug7H3xrUpUKpSqFFKhC
         d9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685793811; x=1688385811;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eX7YG6BVEMEP21fHKJSG6/RY6jlCr7dwM5TuWcCpLgc=;
        b=L2KkQ5+Pxs+7lPkumvuLTRjipOVN9q/sJVdar0Qt4ItC70uZUkpUk0a+/uKFvvMJX+
         5nF6EeURCvqGTHk3QDzLUyWRCf7HTtxxwgfVfPTknrkBj7lUbMqTgo57m/T/KCU7P4Nm
         AJfSUQjJnKzz72aKNscrfPDw1ufdJEKZcs9FGip9a8S/mRZ8iabrWems8Iki5uNSajUw
         6k7cjXR7wse1HfkMC+wPW70MOYOYQ49TmHWQghan0DpiRiNqZXbVR0oLCUqfXnsiWjHQ
         gfpO2C5TsQBpCR5+Ct9MBvugrsq3uadEYsCk33v08Km7QMKz4dTqpwY0hJV3g7Nnn/0H
         HoEw==
X-Gm-Message-State: AC+VfDx5VEF7V8T1hAcdgNB3FPosLXoqcFJ32oZhTZrTWNZ95wiUA9KP
        XjOtkyf/mmFTRgh1Lq9p2Chgbu00vx9EUZzwOKs=
X-Google-Smtp-Source: ACHHUZ54mTZOjJU/PPYwJ6rqKSDi6UQVA6Y3vsmuU11PYee7prXPtq877zS4//Rk0YYsbvnlJMNviCW9Wmwweet4oWA=
X-Received: by 2002:a0d:e88a:0:b0:565:ba08:12b6 with SMTP id
 r132-20020a0de88a000000b00565ba0812b6mr3755987ywe.17.1685793809329; Sat, 03
 Jun 2023 05:03:29 -0700 (PDT)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Sat, 3 Jun 2023 05:03:17 -0700
Message-ID: <CAGyP=7fGKFnJzZ5D_DrzPGLOZgoCL3P_eo7CCXgXi1L2QZgGFg@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in debug_check_no_obj_freed
To:     Waiman Long <longman@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        wuchi <wuchi.zero@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller with enriched corpus[1] on:
HEAD commit : 0bcc4025550403ae28d2984bddacafbca0a2f112
git tree: linux
C Reproducer : I do not have a C reproducer yet. I will update this
thread when I get one.
Kernel .config :
https://gist.github.com/oswalpalash/d9580b0bfce202b37445fa5fd426e41f

Link:
1. https://github.com/cmu-pasta/linux-kernel-enriched-corpus

Console log :
==================================================================
BUG: KASAN: slab-use-after-free in debug_check_no_obj_freed+0x1ef/0x420
Read of size 8 at addr ffff88802b99d498 by task systemd-journal/4432

CPU: 1 PID: 4432 Comm: systemd-journal Not tainted
6.3.0-rc6-pasta-00035-g0bcc40255504 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xd9/0x150
 print_address_description.constprop.0+0x2c/0x3c0
 kasan_report+0x11c/0x130
 debug_check_no_obj_freed+0x1ef/0x420
 __kmem_cache_free+0x194/0x2c0
 do_coredump+0x15f3/0x3cc0
 get_signal+0x1bff/0x25b0
 arch_do_signal_or_restart+0x79/0x5c0
 exit_to_user_mode_prepare+0x11f/0x240
 irqentry_exit_to_user_mode+0x9/0x40
 exc_page_fault+0xc0/0x170
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x7effa68f9be0
Code: 47 08 c3 0f 1f 80 00 00 00 00 31 c0 c3 0f 1f 00 66 2e 0f 1f 84
00 00 00 00 00 48 85 ff 74 1b 8b 47 08 85 c0 74 14 48 8b 47 10 <48> 8b
00 c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 31 c0 c3 0f 1f 00
RSP: 002b:00007ffc44762a18 EFLAGS: 00010206

RAX: 00000000a68541c0 RBX: 000055f2474fd200 RCX: 0000000000000000
RDX: 000055f2474fd270 RSI: 0000000032bd0c3f RDI: 000055f2474fe840
RBP: 000055f2474fd270 R08: 0000000000000353 R09: 00007ffc4477e080
R10: 00007ffc4477e0f0 R11: 00000000000298d6 R12: 0000000032bd0c3f
R13: 0000000000000001 R14: 00007ffc44762a4c R15: 00007ffc44762a4c
 </TASK>

Allocated by task 7970:
 kasan_save_stack+0x22/0x40
 kasan_set_track+0x25/0x30
 __kasan_slab_alloc+0x7f/0x90
 kmem_cache_alloc_lru+0x251/0x640
 __d_alloc+0x32/0x980
 d_alloc+0x4e/0x240
 d_alloc_parallel+0xe8/0x1530
 lookup_open.isra.0+0xb03/0x1400
 path_openat+0x953/0x26c0
 do_filp_open+0x1ba/0x410
 do_sys_openat2+0x16d/0x4c0
 __x64_sys_open+0x11d/0x1c0
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 0:
 kasan_save_stack+0x22/0x40
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2b/0x40
 ____kasan_slab_free+0x13b/0x1a0
 kmem_cache_free+0x105/0x370
 rcu_core+0x814/0x1960
 __do_softirq+0x1d4/0x905

Last potentially related work creation:
 kasan_save_stack+0x22/0x40
 __kasan_record_aux_stack+0x7b/0x90
 __call_rcu_common.constprop.0+0x99/0x7e0
 dentry_free+0xc3/0x160
 __dentry_kill+0x4cb/0x640
 shrink_dentry_list+0x12c/0x4f0
 shrink_dcache_parent+0x202/0x400
 d_invalidate+0x143/0x280
 proc_invalidate_siblings_dcache+0x3db/0x680
 release_task+0xcb0/0x1870
 wait_consider_task+0x306d/0x3ce0
 do_wait+0x799/0xc30
 kernel_wait4+0x150/0x260
 __do_sys_wait4+0x13f/0x150
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40
 __kasan_record_aux_stack+0x7b/0x90
 __call_rcu_common.constprop.0+0x99/0x7e0
 dentry_free+0xc3/0x160
 __dentry_kill+0x4cb/0x640
 shrink_dentry_list+0x12c/0x4f0
 shrink_dcache_parent+0x202/0x400
 vfs_rmdir.part.0+0x272/0x5a0
 do_rmdir+0x3a8/0x420
 __x64_sys_unlinkat+0xef/0x130
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802b99d370
 which belongs to the cache dentry of size 312
The buggy address is located 296 bytes inside of
 freed 312-byte region [ffff88802b99d370, ffff88802b99d4a8)

The buggy address belongs to the physical page:
page:ffffea0000ae6740 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x2b99d
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888014fdf900 ffffea0000ad2050 ffffea0001102fd0
raw: 0000000000000000 ffff88802b99d080 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask
0x2420d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|__GFP_RECLAIMABLE),
pid 8036, tgid 8036 (syz-executor.0), ts 565348161366, free_ts
561755114619
 get_page_from_freelist+0x1190/0x2e20
 __alloc_pages+0x1cb/0x4a0
 cache_grow_begin+0x9b/0x3b0
 cache_alloc_refill+0x27f/0x380
 kmem_cache_alloc_lru+0x540/0x640
 __d_alloc+0x32/0x980
 d_alloc+0x4e/0x240
 __lookup_hash+0xc8/0x180
 filename_create+0x1d6/0x4a0
 do_mkdirat+0x9d/0x310
 __x64_sys_mkdirat+0x119/0x170
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 free_pcp_prepare+0x5d5/0xa50
 free_unref_page+0x1d/0x490
 drain_freelist.isra.0+0xdd/0x130
 cache_reap+0x1bd/0x2e0
 process_one_work+0x991/0x15c0
 worker_thread+0x669/0x1090
 kthread+0x2e8/0x3a0
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff88802b99d380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b99d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b99d480: fb fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00
                            ^
ffff88802b99d500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802b99d580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
