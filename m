Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD685EC1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiI0LrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiI0Lqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:46:51 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED5615101F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:46:49 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so5603342ioz.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=bbY2Sek2sgHveCTCTUq9yzFAqzrnsqKC+uZBUYjGglk=;
        b=WPtqck/4ws9lZJG+/NC25CMcvMQ4ruQrXHESPpIrNxjljT/6mvs349jtjYSRm7l6OI
         j6uSjfyGi43RfSmhyOY0IkVi5X3njinIsEd0fVnd8G0b1rbV8qMr1etDrnc6sm6Ki7Ba
         ZFxlFksPc/JAySueXBhpTXxSl9cPZBQYx5HeTDEWHJXOMN9SPAzStCWmSDeG680gRh1u
         VyzcmeHbPnePTzjSqe9RcbeiXybKAFEKZ8vKCIIED4i6Kw4AHqZRteugUhnuBUpV5e2O
         69INqXkuxj2IBMyUzbGpE6/iuHzL5ytYH6cLyXYqETlhYWdAie/gIx8snSSCw375851G
         ImlQ==
X-Gm-Message-State: ACrzQf0ThAe/+UnFOl8jOuOorsYm+2n9Rkl/5idqx7xEpMHiSCbw9vL+
        1/N8AbCqAc0XI7PsysoDOKMaVA8AA3EnNlRldzise9D1K7k4
X-Google-Smtp-Source: AMsMyM5KvWfODPqW+S2E4L7C/dCvNQOwawJsiP3ArOzi+Bk+By/O9uV3bCCSr4sFs3pi1RkpTbFo7a5/JMBECxOEoGtQXI4y2S9F
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1c0a:b0:35b:1b58:ac2c with SMTP id
 ca10-20020a0566381c0a00b0035b1b58ac2cmr14642360jab.34.1664279207911; Tue, 27
 Sep 2022 04:46:47 -0700 (PDT)
Date:   Tue, 27 Sep 2022 04:46:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fea8c705e9a732af@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hdr_find_e
From:   syzbot <syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10156150880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=c986d2a447ac6fb27b02
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ffc374880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102db9ff080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c986d2a447ac6fb27b02@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
ntfs3: loop0: Failed to load $Extend.
==================================================================
BUG: KASAN: use-after-free in hdr_find_e+0x255/0x580 fs/ntfs3/index.c:689
Read of size 2 at addr ffff8880786eb820 by task syz-executor222/3600

CPU: 0 PID: 3600 Comm: syz-executor222 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 hdr_find_e+0x255/0x580 fs/ntfs3/index.c:689
 indx_find+0x4ff/0xb20 fs/ntfs3/index.c:1085
 dir_search_u+0x161/0x320 fs/ntfs3/dir.c:254
 ntfs_lookup+0x112/0x1b0 fs/ntfs3/namei.c:83
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6ebc72f029
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda4fbe348 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ebc72f029
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00007f6ebc6ee890 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6ebc6ee920
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3253:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0xa3/0xd0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x1a6/0x310 mm/slub.c:3273
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 user_path_at_empty+0x2a/0x1a0 fs/namei.c:2875
 user_path_at include/linux/namei.h:57 [inline]
 user_statfs fs/statfs.c:103 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0x106/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3253:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kmem_cache_free+0x95/0x1d0 mm/slub.c:3556
 putname fs/namei.c:271 [inline]
 user_path_at_empty+0x149/0x1a0 fs/namei.c:2878
 user_path_at include/linux/namei.h:57 [inline]
 user_statfs fs/statfs.c:103 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0x106/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880786eb300
 which belongs to the cache names_cache of size 4096
The buggy address is located 1312 bytes inside of
 4096-byte region [ffff8880786eb300, ffff8880786ec300)

The buggy address belongs to the physical page:
page:ffffea0001e1ba00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x786e8
head:ffffea0001e1ba00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff8880121db500
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3253, tgid 3253 (rm), ts 23835929867, free_ts 23812724158
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x25d/0x310 mm/slub.c:3273
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 do_sys_openat2+0xba/0x4e0 fs/open.c:1307
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_slab mm/slub.c:2073 [inline]
 discard_slab mm/slub.c:2079 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2553
 put_cpu_partial+0x106/0x170 mm/slub.c:2629
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x1bd/0x370 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 load_elf_phdrs fs/binfmt_elf.c:481 [inline]
 load_elf_binary+0x2eb/0x27c0 fs/binfmt_elf.c:861
 search_binary_handler fs/exec.c:1727 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve+0x8dc/0x1590 fs/exec.c:1837
 do_execveat_common+0x59b/0x750 fs/exec.c:1942
 do_execve fs/exec.c:2016 [inline]
 __do_sys_execve fs/exec.c:2092 [inline]
 __se_sys_execve fs/exec.c:2087 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2087
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880786eb700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880786eb780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880786eb800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8880786eb880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880786eb900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
