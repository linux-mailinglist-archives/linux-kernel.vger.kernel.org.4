Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B721969EE04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjBVEqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVEqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:46:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05A34313
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:46:11 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so25031918edz.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpffytAxTvo5TkKslFaG+n/IZvOqJsFBwgdwbtWAk+c=;
        b=FCoQ2zDzymmFS+EjZIx7Oy0ljRSbnW3YyCHyrLscNQgZLqWalljiL6SI42rJy1hMvZ
         CJOxpaxDxvk+niIfZG2S71EUcBx8dPahLw3WOWbXea2vvmBVqN689R9jMWGND594geI9
         bBJ77TS1ws0McX6SBwIanOYrtr0lvpwaPwI4dcAQHEL9pG9ZpE8iADqEObzlv3KuR5f5
         rKNHYnmhjsWEAd83z0sdtFpNxz2piuPxMl+NSD6IaL4SKul3Qv/471L0/Xu8oCASGjQX
         afwM9U7/yuulsa+Wh2dK8b5cYbatqNW2giAU7e2ki8E+XCHotCBFBw9thKRUKEBD2tFa
         nUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpffytAxTvo5TkKslFaG+n/IZvOqJsFBwgdwbtWAk+c=;
        b=V73ZLuiG67mdipIjrwlClMpNG6TDT1Q+E7un/r12C3KlaB45eJXT4129Fl1uZ9k0Z8
         ySRVBruWAUKroArU/V1iIcgJghfPAtwDm5+F4sT2WBdwbDoj+RdKoQrbmYiJf254o+q8
         WIJwL22bAWsa/fpbB3VfH0XwrUXkZs9140eG2vcVdLjAjcqyJOt/0nMmaHbNNqKAsUO1
         IxEPMAFZyxSrHUX77u3DNpylN/OFCWL0tyALwrrUoV2FYfIbv5/q/PRP0xRt0w44ROg2
         ApfSGEt8dSVW54gFW0/0QjLU8oCMO8k/cr0gGZpyS8jyhLSBVdd/w1vnu7A2DnzkDYqc
         iW8g==
X-Gm-Message-State: AO0yUKWmsH6XYFA45a2w14oiqNAxLJYg3VIMEuKw/MKKS//LQAgsNUbW
        f+MOESB0icVdYLDIPAiAQFIaXYchh6lQVKf0uCc=
X-Google-Smtp-Source: AK7set+JZ8EUWx/LcHZpU4Qy4cfUr57fyidgHOHVZEuD+9yAL2uN3j/hLW5sSLtbskIcu8vwDdiyPCcBhN/wGxNYC2k=
X-Received: by 2002:a17:906:bce7:b0:8b1:28f6:8ab3 with SMTP id
 op7-20020a170906bce700b008b128f68ab3mr7092991ejb.15.1677041169815; Tue, 21
 Feb 2023 20:46:09 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Tue, 21 Feb 2023 20:45:58 -0800
Message-ID: <CAGyP=7dTnr6kW0UnwkrOXJcEv8MFFMLXNnaFudifH+gX1tA=Lw@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in ntfs_attr_find
To:     anton@tuxera.com, LKML <linux-kernel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net,
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

C Reproducer : https://gist.github.com/oswalpalash/cb298c137f3dbfb95a609671a61103fb
Kernel .config :
https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb

I found a related discussion in the past about a similar bug here :
https://groups.google.com/g/syzkaller-bugs/c/BFLa1ZwXyG0/m/UIh6Pl2GBAAJ

Console log :

loop3: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_attr_find+0xb87/0xce0
Read of size 2 at addr ffff888106fc30ab by task syz-executor.3/11599

CPU: 0 PID: 11599 Comm: syz-executor.3 Not tainted 6.0.8-pasta #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0xe5/0x63a
 kasan_report+0x8a/0x1b0
 ntfs_attr_find+0xb87/0xce0
 ntfs_attr_lookup+0x1051/0x2040
 ntfs_read_locked_inode+0xb0c/0x5ab0
 ntfs_iget+0x12d/0x180
 ntfs_fill_super+0x1ed0/0x8590
 mount_bdev+0x34d/0x410
 legacy_get_tree+0x105/0x220
 vfs_get_tree+0x89/0x2f0
 path_mount+0x121b/0x1cb0
 do_mount+0xf3/0x110
 __x64_sys_mount+0x18f/0x230
 do_syscall_64+0x35/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e85e9146e
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0e849fda08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0e85e9146e
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0e849fda60
RBP: 00007f0e849fdaa0 R08: 00007f0e849fdaa0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0e849fda60 R15: 0000000020000040
 </TASK>

Allocated by task 1:
 kasan_save_stack+0x1e/0x40
 __kasan_slab_alloc+0x85/0xb0
 kmem_cache_alloc+0x204/0xcc0
 __kernfs_new_node+0xd4/0x8b0
 kernfs_new_node+0x93/0x120
 __kernfs_create_file+0x51/0x350
 sysfs_add_file_mode_ns+0x20f/0x3f0
 internal_create_group+0x314/0xba0
 internal_create_groups.part.0+0x90/0x140
 sysfs_create_groups+0x25/0x50
 kobject_add_internal+0x318/0x8f0
 kobject_init_and_add+0x101/0x160
 netdev_queue_update_kobjects+0x1fe/0x4e0
 netdev_register_kobject+0x333/0x400
 register_netdevice+0xbe9/0x1390
 bond_create+0xb4/0x120
 bonding_init+0x9f/0x114
 do_one_initcall+0xfe/0x650
 kernel_init_freeable+0x6c3/0x74c
 kernel_init+0x1a/0x1d0
 ret_from_fork+0x1f/0x30

The buggy address belongs to the object at ffff888106fc3000
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 3 bytes to the right of
 168-byte region [ffff888106fc3000, ffff888106fc30a8)

The buggy address belongs to the physical page:
page:ffffea00041bf0c0 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x106fc3
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 ffffea00041bc848 ffffea00041a9fc8 ffff88810006f200
raw: 0000000000000000 ffff888106fc3000 0000000100000011 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE),
pid 1, tgid 1 (swapper/0), ts 8385653965, free_ts 0
 prep_new_page+0x2c6/0x350
 get_page_from_freelist+0xae9/0x3a80
 __alloc_pages+0x321/0x710
 cache_grow_begin+0x75/0x360
 kmem_cache_alloc+0xb69/0xcc0
 __kernfs_new_node+0xd4/0x8b0
 kernfs_new_node+0x93/0x120
 kernfs_create_dir_ns+0x48/0x150
 sysfs_create_dir_ns+0x127/0x290
 kobject_add_internal+0x2c9/0x8f0
 kobject_init_and_add+0x101/0x160
 net_rx_queue_update_kobjects+0x264/0x510
 netdev_register_kobject+0x278/0x400
 register_netdevice+0xbe9/0x1390
 bond_create+0xb4/0x120
 bonding_init+0x9f/0x114
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888106fc2f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888106fc3000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888106fc3080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
                                  ^
 ffff888106fc3100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888106fc3180: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
==================================================================
