Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF29646661
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLHBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLHBRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:17:09 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C96343
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:17:07 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NSGPV05WzzJp9B;
        Thu,  8 Dec 2022 09:13:33 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 09:17:04 +0800
Message-ID: <4bde687f-b7d7-f7f5-685b-9aac1870e45e@huawei.com>
Date:   Thu, 8 Dec 2022 09:17:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_listxattr
Content-Language: en-US
To:     syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>,
        <almaz.alexandrovich@paragon-software.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <nathan@kernel.org>, <ndesaulniers@google.com>,
        <ntfs3@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>,
        <trix@redhat.com>
References: <000000000000ea3c3105ef377a12@google.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/7 15:00, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8ed710da2873 Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10027d97880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50de433dd4debef8
> dashboard link: https://syzkaller.appspot.com/bug?extid=9fcea5ef6dc4dc72d334
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e0797880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf79d5880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/75851d210874/disk-8ed710da.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c70846514634/vmlinux-8ed710da.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/34393d745af1/bzImage-8ed710da.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/ce942d5850e5/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com
>
> loop0: detected capacity change from 0 to 4096
> ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
> BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
> Read of size 1 at addr ffff888021acaf3d by task syz-executor128/3632
>
> CPU: 1 PID: 3632 Comm: syz-executor128 Not tainted 6.1.0-rc8-syzkaller-00014-g8ed710da2873 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>   print_address_description+0x74/0x340 mm/kasan/report.c:284
>   print_report+0x107/0x220 mm/kasan/report.c:395
>   kasan_report+0x139/0x170 mm/kasan/report.c:495
>   ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
>   ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
>   vfs_listxattr fs/xattr.c:457 [inline]
>   listxattr+0x293/0x2d0 fs/xattr.c:804
>   path_listxattr fs/xattr.c:828 [inline]
>   __do_sys_llistxattr fs/xattr.c:846 [inline]
>   __se_sys_llistxattr fs/xattr.c:843 [inline]
>   __x64_sys_llistxattr+0x174/0x230 fs/xattr.c:843
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fbd70b66749
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff05b9d818 EFLAGS: 00000246 ORIG_RAX: 00000000000000c3
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fbd70b66749
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
> RBP: 00007fbd70b25fe0 R08: 000000000001f6fe R09: 0000000000000000
> R10: 00007fff05b9d6e0 R11: 0000000000000246 R12: 00007fbd70b26070
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>
> Allocated by task 3632:
>   kasan_save_stack mm/kasan/common.c:45 [inline]
>   kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
>   ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>   __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   __do_kmalloc_node mm/slab_common.c:955 [inline]
>   __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
>   kmalloc include/linux/slab.h:558 [inline]
>   ntfs_read_ea+0x437/0x820 fs/ntfs3/xattr.c:110
>   ntfs_list_ea fs/ntfs3/xattr.c:168 [inline]
>   ntfs_listxattr+0x184/0x570 fs/ntfs3/xattr.c:710
>   vfs_listxattr fs/xattr.c:457 [inline]
>   listxattr+0x293/0x2d0 fs/xattr.c:804
>   path_listxattr fs/xattr.c:828 [inline]
>   __do_sys_llistxattr fs/xattr.c:846 [inline]
>   __se_sys_llistxattr fs/xattr.c:843 [inline]
>   __x64_sys_llistxattr+0x174/0x230 fs/xattr.c:843
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff888021acaf00
>   which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 61 bytes inside of
>   64-byte region [ffff888021acaf00, ffff888021acaf40)
>
> The buggy address belongs to the physical page:
> page:ffffea000086b280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888021aca080 pfn:0x21aca
> flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000200 ffffea0000796a40 dead000000000005 ffff888012841640
> raw: ffff888021aca080 000000008020001d 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 46, tgid 46 (kworker/u4:3), ts 7050450825, free_ts 6956530319
>   prep_new_page mm/page_alloc.c:2539 [inline]
>   get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4291
>   __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
>   alloc_slab_page+0xbd/0x190 mm/slub.c:1794
>   allocate_slab+0x5e/0x4b0 mm/slub.c:1939
>   new_slab mm/slub.c:1992 [inline]
>   ___slab_alloc+0x7f4/0xeb0 mm/slub.c:3180
>   __slab_alloc mm/slub.c:3279 [inline]
>   slab_alloc_node mm/slub.c:3364 [inline]
>   __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
>   kmalloc_node_trace+0x23/0x60 mm/slab_common.c:1058
>   kmalloc_node include/linux/slab.h:575 [inline]
>   kzalloc_node include/linux/slab.h:700 [inline]
>   __get_vm_area_node+0x13f/0x380 mm/vmalloc.c:2494
>   __vmalloc_node_range+0x3a6/0x1400 mm/vmalloc.c:3173
>   alloc_thread_stack_node+0x307/0x500 kernel/fork.c:311
>   dup_task_struct+0x8b/0x490 kernel/fork.c:974
>   copy_process+0x637/0x3fc0 kernel/fork.c:2084
>   kernel_clone+0x227/0x640 kernel/fork.c:2671
>   user_mode_thread+0x12d/0x190 kernel/fork.c:2747
>   call_usermodehelper_exec_work+0x57/0x220 kernel/umh.c:175
>   process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
> page last free stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1459 [inline]
>   free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
>   free_unref_page_prepare mm/page_alloc.c:3387 [inline]
>   free_unref_page+0x7d/0x630 mm/page_alloc.c:3483
>   __vunmap+0x867/0x9d0 mm/vmalloc.c:2713
>   free_work+0x66/0x90 mm/vmalloc.c:97
>   process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
>   worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>   kthread+0x266/0x300 kernel/kthread.c:376
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>
> Memory state around the buggy address:
>   ffff888021acae00: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
>   ffff888021acae80: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
>> ffff888021acaf00: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
>                                          ^
>   ffff888021acaf80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff888021acb000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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


#syz fix: [PATCH] ntfs: fix panic about slab-out-of-bounds caused by 
ntfs_listxattr()

