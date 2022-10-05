Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDC5F5199
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJEJMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJEJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:12:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC912087
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:11:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o7so17397340lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SDe0+Lq5A7T3T5V4bqCepXUSsoPnia3SrOKQ29XsETY=;
        b=HTOiI2oIJqx2QI2q8KHo0kj74p6LUcfkW+1ursG+2I5888YkRgqVVoNw3tL27mIpht
         liJa+Cq4m8RFny7Lw7MAMRHzOoMx08vP1xfVC/+LEEs5Yiz2lX/plpX6R3XWwKp3vHLQ
         ZKOpQdFF0xgdXHlQcuIku7N6uMFROxYOr72IjGhGnFkZO+ZIR28CC79I/LrurkL5Vfpz
         iKaOmVJi/GtjW/HCG/8EvPZeKPxH1+xGwi81cIY+3C6qIAM3vxPGXaak0HVbiIN3wHWl
         CkX9Y9xq2DGqiiTT0Dd30QBvFiZBJmWEYpGYfI1O1a6wIuWvhGTVyi27Aj3lc0E84ClN
         hWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SDe0+Lq5A7T3T5V4bqCepXUSsoPnia3SrOKQ29XsETY=;
        b=GJ4VwTxmPm/XbZ2IUUyJLJIDcWxe75e5sq0mRDc68ioaeeJrcSdMyhJzdJhKRsvZG3
         Et4taq5Qp7xwaxt3uhqY6dcVIVbfZUR8mvUVj89IFXDpI71Z/QVYHiAldzoCcE2kw5wx
         v2dR5P6lqGjxWzryDt0r5TmAV5AwxnKsUpwm8ukN7S6RZl+zuFR95LfSZQE/rJ3x39Y5
         dvAdH4l0s0FlJpR6Iy7BmQXrSjdUtX1lsANL5+iLmXLCc1OUQpVX103/Tmi84qCDHg7A
         uGfIzvO/AEcWGcYnKBahcRB9oSyyplZ6A0YDPoMO8UFhft8Chwwps12SeC5y5g2f6rkY
         Gs+w==
X-Gm-Message-State: ACrzQf3w262/ySbCP0+NSYMEIH281D2vC2LiiR51GQB3CZXAn25egCPo
        pbMhwCZFuSdpxRtCXnx7XFRE8s6lEyOQXmySj4vXQQ==
X-Google-Smtp-Source: AMsMyM7XazNRvqzB0F7VsyQbTin+CgdGiF0g57+ej4LbOfdPt3bDMeTVDfsPOV7aIyuLTK1/+Sr8piLRjiTdkWKS85Y=
X-Received: by 2002:a05:6512:3297:b0:4a2:3f76:486a with SMTP id
 p23-20020a056512329700b004a23f76486amr5029411lfe.137.1664961041753; Wed, 05
 Oct 2022 02:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000de6f3305ea3bc044@google.com>
In-Reply-To: <000000000000de6f3305ea3bc044@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Oct 2022 11:10:30 +0200
Message-ID: <CACT4Y+bSdKYNTGrp89aDaJ-g9qJrUi3FEbhxcWwUBH824AeU=g@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ea_get
To:     syzbot <syzbot+cfd8fb005ec6f019dd45@syzkaller.appspotmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022 at 23:00, syzbot
<syzbot+cfd8fb005ec6f019dd45@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a5088ee7251e Merge tag 'thermal-6.1-rc1' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1211c8cc880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8b8947ea4cc7fb5d
> dashboard link: https://syzkaller.appspot.com/bug?extid=cfd8fb005ec6f019dd45
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13441df4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10133a82880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e107029667b6/disk-a5088ee7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8e538d6b0960/vmlinux-a5088ee7.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/dc07001c8be9/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cfd8fb005ec6f019dd45@syzkaller.appspotmail.com
>
> ffff888073928860: 00 02 00 00 00 00 00 00 68 88 92 73 80 88 ff ff  ........h..s....
> ffff888073928870: 68 88 92 73 80 88 ff ff 00 00 00 00 00 00 00 00  h..s............
> ffff888073928880: 80 88 92 73 80 88 ff ff 80 88 92 73 80 88 ff ff  ...s.......s....
> ffff888073928890: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
> ffff8880739288a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> ffff8880739288b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0x72a/0xb80 lib/hexdump.c:193
> Read of size 1 at addr ffff8880739288c0 by task syz-executor200/3608
>
> CPU: 0 PID: 3608 Comm: syz-executor200 Not tainted 6.0.0-syzkaller-00372-ga5088ee7251e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  print_address_description+0x65/0x4b0 mm/kasan/report.c:317
>  print_report+0x108/0x220 mm/kasan/report.c:433
>  kasan_report+0xfb/0x130 mm/kasan/report.c:495
>  hex_dump_to_buffer+0x72a/0xb80 lib/hexdump.c:193
>  print_hex_dump+0x13e/0x270 lib/hexdump.c:276

This is the same as:

#syz dup: KASAN: slab-out-of-bounds Read in hex_dump_to_buffer

https://syzkaller.appspot.com/bug?id=25e21194d00c9199ff645f8e82625559368f723b

>  ea_get+0xccc/0x1280 fs/jfs/xattr.c:561
>  __jfs_getxattr+0xd0/0x390 fs/jfs/xattr.c:807
>  __vfs_getxattr+0x3de/0x410 fs/xattr.c:411
>  smk_fetch+0xb0/0x140 security/smack/smack_lsm.c:295
>  smack_d_instantiate+0x5c4/0xa10 security/smack/smack_lsm.c:3410
>  security_d_instantiate+0xa5/0x100 security/security.c:2056
>  d_splice_alias+0x6e/0x3b0 fs/dcache.c:3155
>  jfs_lookup+0x2b9/0x400 fs/jfs/namei.c:1467
>  __lookup_slow+0x286/0x3e0 fs/namei.c:1685
>  lookup_slow+0x53/0x70 fs/namei.c:1702
>  walk_component+0x2e1/0x410 fs/namei.c:1993
>  lookup_last fs/namei.c:2450 [inline]
>  path_lookupat+0x17d/0x450 fs/namei.c:2474
>  do_o_path+0x91/0x230 fs/namei.c:3662
>  path_openat+0x2824/0x2e00 fs/namei.c:3684
>  do_filp_open+0x275/0x500 fs/namei.c:3718
>  do_sys_openat2+0x13b/0x500 fs/open.c:1313
>  do_sys_open fs/open.c:1329 [inline]
>  __do_sys_open fs/open.c:1337 [inline]
>  __se_sys_open fs/open.c:1333 [inline]
>  __x64_sys_open+0x221/0x270 fs/open.c:1333
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f9104172109
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc9f9e17b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f9104172109
> RDX: 0000000000000000 RSI: 0000000000212041 RDI: 0000000020000040
> RBP: 00007f91041318d0 R08: 00005555570102c0 R09: 0000000000000000
> R10: 00007ffc9f9e1680 R11: 0000000000000246 R12: 00000000f8008000
> R13: 0000000000000000 R14: 00080000000000f8 R15: 0000000000000000
>  </TASK>
>
> Allocated by task 3608:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:437 [inline]
>  __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:470
>  kasan_slab_alloc include/linux/kasan.h:224 [inline]
>  slab_post_alloc_hook mm/slab.h:727 [inline]
>  slab_alloc_node mm/slub.c:3248 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
>  kmem_cache_alloc_lru+0x175/0x2d0 mm/slub.c:3280
>  alloc_inode_sb include/linux/fs.h:3103 [inline]
>  jfs_alloc_inode+0x21/0x60 fs/jfs/super.c:105
>  alloc_inode fs/inode.c:260 [inline]
>  iget_locked+0x191/0x830 fs/inode.c:1287
>  jfs_iget+0x20/0x3b0 fs/jfs/inode.c:29
>  jfs_lookup+0x221/0x400 fs/jfs/namei.c:1462
>  __lookup_slow+0x286/0x3e0 fs/namei.c:1685
>  lookup_slow+0x53/0x70 fs/namei.c:1702
>  walk_component+0x2e1/0x410 fs/namei.c:1993
>  lookup_last fs/namei.c:2450 [inline]
>  path_lookupat+0x17d/0x450 fs/namei.c:2474
>  do_o_path+0x91/0x230 fs/namei.c:3662
>  path_openat+0x2824/0x2e00 fs/namei.c:3684
>  do_filp_open+0x275/0x500 fs/namei.c:3718
>  do_sys_openat2+0x13b/0x500 fs/open.c:1313
>  do_sys_open fs/open.c:1329 [inline]
>  __do_sys_open fs/open.c:1337 [inline]
>  __se_sys_open fs/open.c:1333 [inline]
>  __x64_sys_open+0x221/0x270 fs/open.c:1333
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff888073928000
>  which belongs to the cache jfs_ip of size 2240
> The buggy address is located 0 bytes to the right of
>  2240-byte region [ffff888073928000, ffff8880739288c0)
>
> The buggy address belongs to the physical page:
> page:ffffea0001ce4a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x73928
> head:ffffea0001ce4a00 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888146477c80
> raw: 0000000000000000 00000000800d000d 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 3608, tgid 3608 (syz-executor200), ts 50651788147, free_ts 11286970323
>  prep_new_page mm/page_alloc.c:2532 [inline]
>  get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4283
>  __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
>  alloc_slab_page+0x70/0xf0 mm/slub.c:1829
>  allocate_slab+0x5e/0x520 mm/slub.c:1974
>  new_slab mm/slub.c:2034 [inline]
>  ___slab_alloc+0x42e/0xce0 mm/slub.c:3036
>  __slab_alloc mm/slub.c:3123 [inline]
>  slab_alloc_node mm/slub.c:3214 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
>  kmem_cache_alloc_lru+0x225/0x2d0 mm/slub.c:3280
>  alloc_inode_sb include/linux/fs.h:3103 [inline]
>  jfs_alloc_inode+0x21/0x60 fs/jfs/super.c:105
>  alloc_inode fs/inode.c:260 [inline]
>  iget_locked+0x191/0x830 fs/inode.c:1287
>  jfs_iget+0x20/0x3b0 fs/jfs/inode.c:29
>  jfs_lookup+0x221/0x400 fs/jfs/namei.c:1462
>  __lookup_slow+0x286/0x3e0 fs/namei.c:1685
>  lookup_slow+0x53/0x70 fs/namei.c:1702
>  walk_component+0x2e1/0x410 fs/namei.c:1993
>  lookup_last fs/namei.c:2450 [inline]
>  path_lookupat+0x17d/0x450 fs/namei.c:2474
>  do_o_path+0x91/0x230 fs/namei.c:3662
>  path_openat+0x2824/0x2e00 fs/namei.c:3684
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1449 [inline]
>  free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
>  free_unref_page_prepare mm/page_alloc.c:3380 [inline]
>  free_unref_page+0x7d/0x630 mm/page_alloc.c:3476
>  free_contig_range+0xa3/0x160 mm/page_alloc.c:9453
>  destroy_args+0xfe/0x971 mm/debug_vm_pgtable.c:1031
>  debug_vm_pgtable+0x454/0x4ad mm/debug_vm_pgtable.c:1354
>  do_one_initcall+0xbd/0x2b0 init/main.c:1296
>  do_initcall_level+0x168/0x218 init/main.c:1369
>  do_initcalls+0x4b/0x8c init/main.c:1385
>  kernel_init_freeable+0x43a/0x5c3 init/main.c:1623
>  kernel_init+0x19/0x2b0 init/main.c:1512
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>
> Memory state around the buggy address:
>  ffff888073928780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888073928800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888073928880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>                                            ^
>  ffff888073928900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888073928980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000de6f3305ea3bc044%40google.com.
