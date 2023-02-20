Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB44069D2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjBTS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:28:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5B9EDC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:28:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h32so8290429eda.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1yJr+Lh+KtpPEt8GPzIBKGrtGOkTlJM4nS+qpJxbsI=;
        b=AtKurSvXjyUiYnoKFuhxFmL6ttE4u97AWOsTscKiKDuILxa+kRGjoQFnk3QkyWhcrK
         TZxWjIbGCsV56itsozn8XCdJaKN0U6MySJvkF/ptHtT9dzi6BuE86ApYELb6HbXpPBvG
         shlGU9eThAlYOjl/L1ny60GNqJ5uvMOsWfdlhqAEO9EgnC+PP2ZS1WV8vP1YPurFQ03e
         xYNBwCYrnBPLLCezorCeMPuGntU2BCynQxvf4ijphi7VADdTQ8iHm4ueA9s/US6S/XBU
         0CcJss2GBiufZ0Vi1vAnZW812sMaY8K17DhuCSGZf73COUUA3OCCMe9vu5UV9PsxpxgH
         5QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1yJr+Lh+KtpPEt8GPzIBKGrtGOkTlJM4nS+qpJxbsI=;
        b=Cef+3IBJTU0G/LIXNtcthOn10If8NDhydIvBo56nUi8jiMPETbfp2DBh1AHC132qfT
         R0cg+1B4o7f2CYozEvOSMM6gC7NwLk9SqkZf9H2kwzfWSM0ddfCwGIM5j7da8gmHRYe7
         btTVfwxqb926LB8J9NB949R+lf+oujakVx9elihMXYEnAiyGzCRcPSHuyRAAE00EzJs+
         THiM4j/5cgXF5Sa+1dCffYmrg6tDzD7tcovDZhvdnK3WH6OWJFOE7S40uWVo99EnMoPq
         2U2B187JRUJRRf9Gp0fQU1wSVsKS0xQsQr/v+VHGxDy7JTu6sE3OxyyOYZoWW8kiY8vk
         OCkw==
X-Gm-Message-State: AO0yUKXiH+3o+jV0w2P6U7Fd/bME2IAZ+8FP8jjcVx2T71w8dNH6HzVw
        4vqqcEUJ12uq01CQa+aTlhasfJipf3j9T8dU9eM=
X-Google-Smtp-Source: AK7set/KOw1mvXLdIietLvMSzmnt3rA8O6l6xpDvsfx+Wf6m7ZKkMfkj5pRCvX+xxCmUCDYGxz4pEigAqA+07j3xNYg=
X-Received: by 2002:a17:906:32c1:b0:8ca:d0ef:a603 with SMTP id
 k1-20020a17090632c100b008cad0efa603mr2475825ejk.15.1676917685478; Mon, 20 Feb
 2023 10:28:05 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Mon, 20 Feb 2023 10:27:53 -0800
Message-ID: <CAGyP=7dc__rx+r=rx=JBu3YgY=+N+1mVK4P=nCKbBUVHkKqViA@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in hdr_find_e
To:     almaz.alexandrovich@paragon-software.com,
        LKML <linux-kernel@vger.kernel.org>, ntfs3@lists.linux.dev,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller on:
HEAD commit : e60276b8c11ab4a8be23807bc67b04
8cfb937dfa (v6.0.8)
git tree: stable

C Reproducer : https://gist.github.com/oswalpalash/af178d2eb8f1ecb3edc400803c80e411
Kernel .config :
https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb

Console log :
==================================================================
BUG: KASAN: slab-out-of-bounds in hdr_find_e.isra.0+0x527/0x590
Read of size 2 at addr ffff888039fdb820 by task syz-executor.3/9218

CPU: 0 PID: 9218 Comm: syz-executor.3 Not tainted 6.0.8-pasta #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0xe5/0x63a
 kasan_report+0x8a/0x1b0
 hdr_find_e.isra.0+0x527/0x590
 indx_find+0x4f4/0x970
 dir_search_u+0x232/0x3f0
 ntfs_lookup+0x174/0x1e0
 lookup_open+0xa95/0x1640
 path_openat+0xa42/0x2840
 do_filp_open+0x1ca/0x2a0
 do_sys_openat2+0x61b/0x990
 do_sys_open+0xc3/0x140
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f564fa8eacd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5650853bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f564fbbbf80 RCX: 00007f564fa8eacd
RDX: 000000000000275a RSI: 00000000200001c0 RDI: ffffffffffffff9c
RBP: 00007f564fafcb05 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd2c9779f R14: 00007ffcd2c97940 R15: 00007f5650853d80
 </TASK>

Allocated by task 9097:
 kasan_save_stack+0x1e/0x40
 __kasan_slab_alloc+0x85/0xb0
 kmem_cache_alloc+0x204/0xcc0
 getname_flags+0xd2/0x5b0
 vfs_fstatat+0x73/0xb0
 __do_sys_newlstat+0x8b/0x110
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 9097:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0xf5/0x180
 kmem_cache_free.part.0+0xfc/0x4a0
 putname+0xfe/0x140
 vfs_fstatat+0x97/0xb0
 __do_sys_newlstat+0x8b/0x110
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888039fda800
 which belongs to the cache names_cache of size 4096
The buggy address is located 32 bytes to the right of
 4096-byte region [ffff888039fda800, ffff888039fdb800)

The buggy address belongs to the physical page:
page:ffffea0000e7f680 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x39fda
head:ffffea0000e7f680 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0000ea8c08 ffffea0000704a08 ffff888012391500
raw: 0000000000000000 ffff888039fda800 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask
0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE),
pid 9097, tgid 9097 (systemd-udevd), ts 83117357051, free_ts
82883501668
 prep_new_page+0x2c6/0x350
 get_page_from_freelist+0xae9/0x3a80
 __alloc_pages+0x321/0x710
 cache_grow_begin+0x75/0x360
 kmem_cache_alloc+0xb69/0xcc0
 getname_flags+0xd2/0x5b0
 vfs_fstatat+0x73/0xb0
 __do_sys_newlstat+0x8b/0x110
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 free_pcp_prepare+0x5ab/0xd00
 free_unref_page+0x19/0x410
 slab_destroy+0x14/0x50
 slabs_destroy+0x6a/0x90
 ___cache_free+0x1e3/0x3b0
 qlist_free_all+0x51/0x1c0
 kasan_quarantine_reduce+0x13d/0x180
 __kasan_slab_alloc+0x97/0xb0
 kmem_cache_alloc+0x204/0xcc0
 getname_flags+0xd2/0x5b0
 do_sys_openat2+0x448/0x990
 do_sys_open+0xc3/0x140
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888039fdb700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039fdb780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888039fdb800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888039fdb880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888039fdb900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
