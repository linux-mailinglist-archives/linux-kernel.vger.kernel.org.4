Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E61601FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiJRAcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiJRAcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:32:17 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BF8E0CC;
        Mon, 17 Oct 2022 17:30:59 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id y10so8399840qvo.11;
        Mon, 17 Oct 2022 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D3MWEkQfeydukJjl+giuEoPzizUgXD2ubknINzkbqAo=;
        b=gfL7iLgWe6/53aJA4Y6pUs2fcfr5dZLQu+4wVpljWY8KKeaCWese6HITNbydvufEy0
         +yK5QTZSnB/JWWS2Q+GF9YSoYRDOm5bZtvRi3b7JyDUJBK0ecGCnQEf29TCtUDDAWe+B
         2nyNiKfs8SBzgq6NKoqJMWuT5tw/MXIlvtrf8XkselYm1TrKcmT7FE0TN7bu6xujJ4W3
         lulISPkPhjsGBF/2+wytoZwEku5R9O5UEHSQWStQpgBNv+bs9CIIMz8hP+FS2VJp/e/n
         1OpjmpW+5eN40ToP/yKJ/+1/o4knjntDeLI8mN6Udmc2/KMpH3lBaOcEvHoeWsDY0y3N
         xecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3MWEkQfeydukJjl+giuEoPzizUgXD2ubknINzkbqAo=;
        b=r3UAs0UzWhVXh2gxWgFgmk+VHqxTNfuuZ0WTVBkhFeo5HA6UgpYyzPKoqDWWgRfvCY
         AMYzfcSVXBKYByss0tuwGPiyfjkmZ7yJGu6M3p7xgOUG/fmjJZ67TezGWQ+CTF7ZFCNN
         Qxw4EESdxtO3+3Jw+S3XWK/eFAK5YPFs5S8FFKd/HXU2gmh+mSTipC520/ZRC6gGeXlW
         /LdeOAtw/dDdsyhAQlND9IKNNhSE087QcA+wSFHrFDGaP5IDaB2yLeMLnf2wQFosk8o5
         dxRJHzu7u5W7eOZMo5s6Lkd5HnRs5lJXaRMDofVRCpTtta+FxkQz4AvRUaJEGGYjdqUd
         YQ+A==
X-Gm-Message-State: ACrzQf2lI29pilsKf487qwEgdab5aDkTKJKF9PcDNb6saNVVUSqNYG6E
        TZb/H6tkovUCImFtN0JfHTDLjLIatL0NvYtZbhkMgow/s6Y=
X-Google-Smtp-Source: AMsMyM5XOhgg+avEx8COcXfDoCmT9yGaoGaTBoUhmGGo/JgWdOC6S+V9BV64Sv/LIZpWiexH61scxKWmPS1MRUcKQCo=
X-Received: by 2002:a67:b207:0:b0:3a7:a4ef:f42e with SMTP id
 b7-20020a67b207000000b003a7a4eff42emr138520vsf.68.1666052229392; Mon, 17 Oct
 2022 17:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff8d3505eb3645de@google.com>
In-Reply-To: <000000000000ff8d3505eb3645de@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 18 Oct 2022 09:16:52 +0900
Message-ID: <CAKFNMonGi18JhrRxTP2rEFgpjCaqAgJRV5rw7BBk5Gi_TYeJwQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in nilfs_update_inode
To:     syzbot <syzbot+ddb45ee60a8ea1b7a21f@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 4:53 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1241e73a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
> dashboard link: https://syzkaller.appspot.com/bug?extid=ddb45ee60a8ea1b7a21f
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd6daa880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16594b8a880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/9097ed9eaf36/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ddb45ee60a8ea1b7a21f@syzkaller.appspotmail.com
>
> syz-executor141: attempt to access beyond end of device
> loop0: rw=0, sector=15744656570680999970, nr_sectors = 2 limit=2048
> syz-executor141: attempt to access beyond end of device
> loop0: rw=0, sector=15744656570680999970, nr_sectors = 2 limit=2048
> ==================================================================
> BUG: KASAN: use-after-free in nilfs_update_inode+0x72/0x1c0 fs/nilfs2/inode.c:788
> Read of size 8 at addr ffff88801f816230 by task syz-executor141/3606
>
> CPU: 1 PID: 3606 Comm: syz-executor141 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>  print_address_description+0x65/0x4b0 mm/kasan/report.c:317
>  print_report+0x108/0x1f0 mm/kasan/report.c:433
>  kasan_report+0xc3/0xf0 mm/kasan/report.c:495
>  nilfs_update_inode+0x72/0x1c0 fs/nilfs2/inode.c:788
>  __nilfs_mark_inode_dirty+0xc2/0x250 fs/nilfs2/inode.c:1079
>  nilfs_mark_inode_dirty fs/nilfs2/nilfs.h:288 [inline]
>  nilfs_mkdir+0x24e/0x320 fs/nilfs2/namei.c:255
>  vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
>  do_mkdirat+0x279/0x550 fs/namei.c:4038
>  __do_sys_mkdirat fs/namei.c:4053 [inline]
>  __se_sys_mkdirat fs/namei.c:4051 [inline]
>  __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f5c14d482e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdc679fd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f5c14d482e9
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 00007f5c14d07ab0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5c14d07b40
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> Allocated by task 3606:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:437 [inline]
>  ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
>  kasan_kmalloc include/linux/kasan.h:234 [inline]
>  kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  nilfs_find_or_create_root+0x142/0x4f0 fs/nilfs2/the_nilfs.c:747
>  nilfs_attach_checkpoint+0xcd/0x4a0 fs/nilfs2/super.c:519
>  nilfs_fill_super+0x2e8/0x5d0 fs/nilfs2/super.c:1064
>  nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>  vfs_get_tree+0x88/0x270 fs/super.c:1530
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 3606:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
>  kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
>  ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
>  kasan_slab_free include/linux/kasan.h:200 [inline]
>  slab_free_hook mm/slub.c:1759 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
>  slab_free mm/slub.c:3539 [inline]
>  kfree+0xda/0x210 mm/slub.c:4567
>  nilfs_evict_inode+0x253/0x3d0 fs/nilfs2/inode.c:924
>  evict+0x2a4/0x620 fs/inode.c:664
>  nilfs_new_inode+0x6b8/0x8a0
>  nilfs_mkdir+0xfc/0x320 fs/nilfs2/namei.c:218
>  vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
>  do_mkdirat+0x279/0x550 fs/namei.c:4038
>  __do_sys_mkdirat fs/namei.c:4053 [inline]
>  __se_sys_mkdirat fs/namei.c:4051 [inline]
>  __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff88801f816200
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 48 bytes inside of
>  256-byte region [ffff88801f816200, ffff88801f816300)
>
> The buggy address belongs to the physical page:
> page:ffffea00007e0580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f816
> head:ffffea00007e0580 order:1 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 ffffea00004b9200 dead000000000004 ffff888012041b40
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 6665465857, free_ts 0
>  prep_new_page mm/page_alloc.c:2532 [inline]
>  get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
>  __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
>  alloc_slab_page+0x70/0xf0 mm/slub.c:1829
>  allocate_slab+0x5e/0x520 mm/slub.c:1974
>  new_slab mm/slub.c:2034 [inline]
>  ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
>  __slab_alloc mm/slub.c:3123 [inline]
>  slab_alloc_node mm/slub.c:3214 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  kmem_cache_alloc_trace+0x25f/0x310 mm/slub.c:3287
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  set_kthread_struct+0xb1/0x1f0 kernel/kthread.c:117
>  copy_process+0x134a/0x4000 kernel/fork.c:2182
>  kernel_clone+0x21f/0x790 kernel/fork.c:2673
>  kernel_thread+0x150/0x1d0 kernel/fork.c:2726
>  create_kthread kernel/kthread.c:399 [inline]
>  kthreadd+0x57c/0x750 kernel/kthread.c:746
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> page_owner free stack trace missing
>
> Memory state around the buggy address:
>  ffff88801f816100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88801f816180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88801f816200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff88801f816280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88801f816300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

This is the same UAF bug as below:

#syz dup: KASAN: use-after-free Read in nilfs_segctor_confirm

The bugfix for this is the patch titled "nilfs2: fix use-after-free
bug of struct nilfs_root", which was merged in the mainline after the
tested commit.

I confirmed this patch fixes the UAF bug with the reproducer.

Ryusuke Konishi
