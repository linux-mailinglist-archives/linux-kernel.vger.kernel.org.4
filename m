Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6379A613ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiJaPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiJaPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:53:58 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD26D120A6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:53:56 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id w13-20020a056e021c8d00b00300ad5b16a0so2073782ill.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz190STSH6PlF9/mgKfumBslVz5BxF1hLkltdFUJ3vI=;
        b=5Psh9s6dUUefgeYZvaXvUV+v62CT/U+Ef/kAEdBZlMTxVN/PHaGymmlIvUvSejB9Q6
         MRBt1ZCdgXCbUs0MkuyiKhUqqoK+LXSJpEFlRhavLqzAcIjHCg/cG83oku94mpAKKisR
         i24AThAQhYo74Ms7U7WtegO5J4JaZLdqiTsvKr7iSQtaw/+JAkwqJbfeoFHgl1xsT+F/
         WVooLT3qYZCjzQN8Jw5aQIY5AwPBkJZjoUem3rc8bdlLZDEd1CLMv28/rta/Rhrcv+oD
         Ioa4FMzm7lfh2xUcKCw7HJt6gK6Zgour6QLq0CHBu3f7B7NmtihjBdpMvd6CKhcHZiaj
         9mYQ==
X-Gm-Message-State: ACrzQf2xv9U3e8QMRAWv1s0UArnluMTmLRjEh8WkVMp/rDIeU1GZxbc1
        DbJcTb6+fLWwcip5a0eD5pkSE4tk6Rsy5S4srQChcrqEGjUg
X-Google-Smtp-Source: AMsMyM6zSNQ7WPv+C2mmVamW8ZsqaXhGY2P/EnLmFy91Kkuozo1LVToJEG0giIhPngIFLhCArHR5goix/sr/RgfUBolLa+pLoidu
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f02:b0:6a4:5b5d:9dbb with SMTP id
 q2-20020a0566022f0200b006a45b5d9dbbmr7491054iow.32.1667231635574; Mon, 31 Oct
 2022 08:53:55 -0700 (PDT)
Date:   Mon, 31 Oct 2022 08:53:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065986a05ec569d46@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_segctor_sync
From:   syzbot <syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169ba3e2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=f816fa82f8783f7a02bb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14687046880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dff35e880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/03acc269b955/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com

BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x28b/0x360 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff8880753301a4 by task syz-executor407/3709

CPU: 1 PID: 3709 Comm: syz-executor407 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x28b/0x360 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xbf/0x100 kernel/locking/spinlock.c:162
 finish_wait+0xba/0x1d0 kernel/sched/wait.c:406
 nilfs_segctor_sync+0x457/0x5c0 fs/nilfs2/segment.c:2197
 nilfs_construct_segment fs/nilfs2/segment.c:2251 [inline]
 nilfs_transaction_commit+0x593/0x760 fs/nilfs2/segment.c:285
 nilfs_evict_inode+0x322/0x3d0 fs/nilfs2/inode.c:945
 evict+0x2a4/0x620 fs/inode.c:664
 d_delete_notify include/linux/fsnotify.h:261 [inline]
 vfs_rmdir+0x37e/0x4b0 fs/namei.c:4133
 do_rmdir+0x39d/0x610 fs/namei.c:4181
 __do_sys_rmdir fs/namei.c:4200 [inline]
 __se_sys_rmdir fs/namei.c:4198 [inline]
 __x64_sys_rmdir+0x45/0x50 fs/namei.c:4198
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8b354df179
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b354692f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f8b355664b0 RCX: 00007f8b354df179
RDX: 00007f8b35469700 RSI: ed621b9e8ef83f76 RDI: 0000000020000040
RBP: 00007f8b35531720 R08: 00007f8b35469700 R09: 0000000000000000
R10: 00007f8b35469700 R11: 0000000000000246 R12: 00007f8b355312f8
R13: 00007f8b355310b8 R14: 0030656c69662f2e R15: 00007f8b355664b8
 </TASK>

Allocated by task 3700:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 nilfs_segctor_new fs/nilfs2/segment.c:2657 [inline]
 nilfs_attach_log_writer+0x133/0x8d0 fs/nilfs2/segment.c:2786
 nilfs_fill_super+0x38b/0x5d0 fs/nilfs2/super.c:1073
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3700:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3674
 nilfs_segctor_destroy fs/nilfs2/segment.c:2756 [inline]
 nilfs_detach_log_writer+0x8f3/0xbd0 fs/nilfs2/segment.c:2813
 nilfs_attach_log_writer+0xe8/0x8d0 fs/nilfs2/segment.c:2783
 nilfs_remount+0x382/0x410 fs/nilfs2/super.c:1171
 reconfigure_super+0x3bc/0x7b0 fs/super.c:934
 do_remount fs/namespace.c:2702 [inline]
 path_mount+0xd20/0x10c0 fs/namespace.c:3362
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888075330000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 420 bytes inside of
 1024-byte region [ffff888075330000, ffff888075330400)

The buggy address belongs to the physical page:
page:ffffea0001d4cc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75330
head:ffffea0001d4cc00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001f4c000 dead000000000002 ffff888012041dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3392, tgid 3392 (sshd), ts 33251724611, free_ts 32678605279
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4287
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5554
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node_track_caller+0x9c/0x1a0 mm/slab_common.c:975
 kmalloc_reserve net/core/skbuff.c:437 [inline]
 __alloc_skb+0x112/0x2b0 net/core/skbuff.c:509
 alloc_skb include/linux/skbuff.h:1267 [inline]
 __tcp_send_ack+0x98/0x5f0 net/ipv4/tcp_output.c:3960
 tcp_cleanup_rbuf net/ipv4/tcp.c:1628 [inline]
 tcp_recvmsg_locked+0x1cf3/0x25c0 net/ipv4/tcp.c:2649
 tcp_recvmsg+0x337/0x870 net/ipv4/tcp.c:2679
 inet_recvmsg+0x13a/0x250 net/ipv4/af_inet.c:859
 sock_recvmsg_nosec net/socket.c:995 [inline]
 sock_recvmsg net/socket.c:1013 [inline]
 sock_read_iter+0x3fa/0x530 net/socket.c:1086
 call_read_iter include/linux/fs.h:2185 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7ac/0xbf0 fs/read_write.c:470
 ksys_read+0x177/0x2a0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3482
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:702 [inline]
 alloc_buffer_head+0x20/0xf0 fs/buffer.c:2899
 alloc_page_buffers+0x179/0x460 fs/buffer.c:829
 create_empty_buffers+0x36/0xe30 fs/buffer.c:1543
 ext4_block_write_begin+0x2e5/0x2290 fs/ext4/inode.c:1074
 ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3003
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3753
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18d0
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637

Memory state around the buggy address:
 ffff888075330080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075330100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888075330180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888075330200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075330280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
