Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B0720FF1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFCLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 07:39:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2651B7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 04:39:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso6426639276.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685792377; x=1688384377;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4te7o+PhhKmzmY3YctqcqLfBq7E7GPECAzNUOyZeI0U=;
        b=Zs2uaz+4lElF32GKWkfKtkxlNyVeG27S0OBUw146sCEkHbuh3mHeBgH4Kpxq+PUAbi
         XMYIx9BFzUFpinb4aaebCqyuZFF7zuSSZZDdB5e2sZLpXOpvodr/jHHorfrRLa6u0mg4
         8phDWX65rC2yF7FKwMwnon+23/ZLKiSYmvFCdXNnkWK8BfH/PCgBSCDAA18cpsadZdho
         FI+hWOAs4JfRvE9PYqgWA688eFChekPCWQ3/EpcBqY5GthuKC5kDP1lXGR7txH5X71Er
         s+MJraCt9A5bSqinnQe7ZrwmRxeV+qJfZVUujgDETiic2A2BNFYpLloZVzU306fIsLZv
         OsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685792377; x=1688384377;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4te7o+PhhKmzmY3YctqcqLfBq7E7GPECAzNUOyZeI0U=;
        b=gqEcxnJ4F99ephkJkF7768wFHBRjyGb9dtZRv/MxHCtscBVPHK+xiEKprXeWZ1YjTu
         xV7ND0d//lOsqj6kh2VxVUuUP1yK7l9aJBdCUy/DPa2Js20N3xL8uy3LtRI3yFmOZdI7
         v8mINwKtWN3Siu29Wm5W8MVZUYA5b2xJ6Ve/4sR5PGgVFBIL1uK3eybWyEJ02UWm3ian
         z0ZcjAU5Qk3voXcDatZ8+wuuIriILmPZcWmT1SEltkk4Y1LeYPcfnPWz/681sM6iozRK
         H/hCDHMocpWbHCFV7q0aOGd8bXrDBbB+7IgyP15oh8Rjbeey+72K2q+3eGgdpX06CX5q
         sy1w==
X-Gm-Message-State: AC+VfDyBmtnF6b9EzKyUz4mQc93ciPEB5cTs/49HYnM/QYqJreJqXpNx
        y49EAr6cTraMsKYh0tFAvNaN6cgRo0OlcBrdOW0=
X-Google-Smtp-Source: ACHHUZ63bZxGNmeBybOrv5+DW/Bfsjlon0EeDVf6Kam0JL8s8yblP4Dwvk4p42+l5U2SImZ91Qr8r3t6KjjrsWeG3RA=
X-Received: by 2002:a0d:dbd1:0:b0:568:ed48:21bb with SMTP id
 d200-20020a0ddbd1000000b00568ed4821bbmr2948648ywe.13.1685792376735; Sat, 03
 Jun 2023 04:39:36 -0700 (PDT)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Sat, 3 Jun 2023 04:39:25 -0700
Message-ID: <CAGyP=7eR9nQEdKhfLEzQ7kV9WbHeZV5gUQPL2Kf5OYXTu8tqjQ@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in ntfs_test_inode
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
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


loop2: detected capacity change from 0 to 4096
ntfs: volume version 3.1.
==================================================================
BUG: KASAN: slab-use-after-free in ntfs_test_inode+0x9a/0x2f0
Read of size 8 at addr ffff888042df75e0 by task syz-executor.2/5020
CPU: 1 PID: 5020 Comm: syz-executor.2 Not tainted
6.3.0-rc6-pasta-00035-g0bcc40255504 #1     Hardware name: QEMU
Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014

Call Trace:
 <TASK>
 dump_stack_lvl+0xd9/0x150
 print_address_description.constprop.0+0x2c/0x3c0
 kasan_report+0x11c/0x130
 kasan_check_range+0x141/0x190
 ntfs_test_inode+0x9a/0x2f0
 find_inode+0xe4/0x220
 iget5_locked+0xb5/0x2c0
 ntfs_iget+0xa1/0x180
 ntfs_fill_super+0x44bd/0x9400
 mount_bdev+0x351/0x410
 legacy_get_tree+0x109/0x220
 vfs_get_tree+0x8d/0x350
 path_mount+0x1342/0x1e40
 __x64_sys_mount+0x283/0x300
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f138809146e
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1388e1da08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f138809146e
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f1388e1da60
RBP: 00007f1388e1daa0 R08: 00007f1388e1daa0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f1388e1da60 R15: 0000000020079ca0
 </TASK>

Allocated by task 15621:
 kasan_save_stack+0x22/0x40
 kasan_set_track+0x25/0x30
 __kasan_slab_alloc+0x7f/0x90
 kmem_cache_alloc_lru+0x1e3/0x640
 reiserfs_alloc_inode+0x28/0xc0
 alloc_inode+0x61/0x230
 new_inode+0x2b/0x280
 reiserfs_mkdir+0x1f1/0x990
 reiserfs_xattr_init+0x57e/0xc30
 reiserfs_fill_super+0x2127/0x2ea0
 mount_bdev+0x351/0x410
 legacy_get_tree+0x109/0x220
 vfs_get_tree+0x8d/0x350
 path_mount+0x1342/0x1e40
 __x64_sys_mount+0x283/0x300
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40
 __kasan_record_aux_stack+0x7b/0x90
 __call_rcu_common.constprop.0+0x99/0x7e0
 destroy_inode+0x129/0x1b0
 iput.part.0+0x50a/0x740
 iput+0x5c/0x80
 reiserfs_new_inode+0x402/0x2190
 reiserfs_mkdir+0x4b8/0x990
 reiserfs_xattr_init+0x57e/0xc30
 reiserfs_fill_super+0x2127/0x2ea0
 mount_bdev+0x351/0x410
 legacy_get_tree+0x109/0x220
 vfs_get_tree+0x8d/0x350
 path_mount+0x1342/0x1e40
 __x64_sys_mount+0x283/0x300
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
The buggy address belongs to the object at ffff888042df7080
 which belongs to the cache reiser_inode_cache of size 1568
The buggy address is located 1376 bytes inside of
 freed 1568-byte region [ffff888042df7080, ffff888042df76a0)
The buggy address belongs to the physical page:
page:ffffea00010b7dc0 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888042df7ffe pfn:0x42df7
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8881031dba00 ffffea00010b2110 ffff888015cfb940
raw: ffff888042df7ffe ffff888042df7080 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask
0x2420d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|__GFP_RECLAIMABLE),
pid 15621, tgid 15617 (syz-executor.0), ts 208467737645, f
ree_ts 0
 get_page_from_freelist+0x1190/0x2e20
 __alloc_pages+0x1cb/0x4a0
 cache_grow_begin+0x9b/0x3b0
 cache_alloc_refill+0x27f/0x380
 kmem_cache_alloc_lru+0x540/0x640
 reiserfs_alloc_inode+0x28/0xc0
 alloc_inode+0x61/0x230
 iget5_locked+0x1cf/0x2c0
 reiserfs_fill_super+0xf84/0x2ea0
 mount_bdev+0x351/0x410
 legacy_get_tree+0x109/0x220
 vfs_get_tree+0x8d/0x350
 path_mount+0x1342/0x1e40
 __x64_sys_mount+0x283/0x300
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888042df7480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888042df7500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888042df7580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888042df7600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888042df7680: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
