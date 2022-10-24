Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8717609AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJXGlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJXGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:40:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113259E97
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:40:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d3so5042340ljl.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bsSKNwAmHdY5r0nJ3+cuVL0rNIuxhpOeL2lyquGZ8H0=;
        b=gGuSHnm2XDkfJoTksC1mLjkINXC8uiZSHe6HjVTFDUHDOLMwPkni0QtX+hMMGTYh26
         0b0E6MKAVBGNUgs5qeAy0S+ArSYqbmhL3tDeLHUJLaa6gVJjk0W7FZXPiU6eBidqviqg
         j62sDAaMFzRgOfVeUn4spRaTqVmBeYBCt+9VCYypZRDIe/acFwzaT/tmCY66azV2FWCr
         eC1/zd2o0lzUmXjbcXxnB6qtiD90E45EIFUcMUNEre+mDaKmTzA8T2CZwBvcMDnohneN
         tPBfmx/RU9f/XAkJKpKGHedMhIo+9yRaU4+3mY05br88XUC5KJ3goUyXZEO+k/nQ/+in
         9rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsSKNwAmHdY5r0nJ3+cuVL0rNIuxhpOeL2lyquGZ8H0=;
        b=dNwR5nT0WwR9v4NdfPwAOHeyu8/rrBlYffdffFGgQTHEgcQ8NAZPs8LH8h8XhkzigQ
         9sciOxwmCekTSAKhhx1cZG94q7tCsmHi0GkxhVd4xx6OzXcr4McfaEd9K00bWzvlrYl3
         0i7uZ1c1XQj3oNWzVqDt4XMnK0jhdisrOICIx56nVdIlekEn7UYJtZJJ4Q3H5h3n/BiQ
         RF+3DGBU+ljyoY7Lx/Nzy37CmxqzXciwiHFPKXE562NRj4wq++eYxV9RB0IvEt413Zbh
         noFHgDDElCnlW1jj+9aqw78RGt7GWjEJToVs8WaD6y+CwaE1GROdoGYR43ZaA/xdDhVI
         6V0w==
X-Gm-Message-State: ACrzQf2IinnN2+FdRHRx9PNGC0ZA44XpPR+9h79sfTzUbzpG1OAWNkbE
        Df9QtJjNd+n2XecY2UbkG3KgCKPoGKgTWaVh5QJQhJpkTNwf3w==
X-Google-Smtp-Source: AMsMyM6aCvpUTp5j30cvBdgcYqSyAHnsb0m06WqByI8Lkr+EGj0V6xhtvEycBZbBvqKHqHYUKbk5/tCfqrcuqqP+fQM=
X-Received: by 2002:a05:651c:1111:b0:26f:eb56:5844 with SMTP id
 e17-20020a05651c111100b0026feb565844mr12010324ljo.4.1666593655477; Sun, 23
 Oct 2022 23:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000eda7a05ebae986e@google.com> <Y1V4VIM+WieI2/3f@monkey>
In-Reply-To: <Y1V4VIM+WieI2/3f@monkey>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Oct 2022 08:40:43 +0200
Message-ID: <CACT4Y+a0==UbGMLn8YLqAy1A_C4vfzVcLUP_wjKm407_fGd7xA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in hugetlb_fault
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

On Sun, 23 Oct 2022 at 19:22, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/23/22 00:26, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    bb1a1146467a Merge tag 'cgroup-for-6.1-rc1-fixes' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f38cc2880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=972ee691c428ae39
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1b27d7a2722eabc2c5d5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
> > BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
> > BUG: KASAN: use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
> > BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1262 [inline]
> > BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1255 [inline]
> > BUG: KASAN: use-after-free in __down_read kernel/locking/rwsem.c:1269 [inline]
> > BUG: KASAN: use-after-free in down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
> > Read of size 8 at addr ffff88801eabdc08 by task syz-executor.2/4171
> >
> > CPU: 0 PID: 4171 Comm: syz-executor.2 Not tainted 6.1.0-rc1-syzkaller-00010-gbb1a1146467a #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:284 [inline]
> >  print_report+0x15e/0x461 mm/kasan/report.c:395
> >  kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
> >  check_region_inline mm/kasan/generic.c:183 [inline]
> >  kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
> >  instrument_atomic_read include/linux/instrumented.h:72 [inline]
> >  atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
> >  is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
> >  __down_read_common kernel/locking/rwsem.c:1262 [inline]
> >  __down_read_common kernel/locking/rwsem.c:1255 [inline]
> >  __down_read kernel/locking/rwsem.c:1269 [inline]
> >  down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
> >  hugetlb_vma_lock_read mm/hugetlb.c:6797 [inline]
> >  hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5840
> >  follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6282
> >  __get_user_pages+0x2cb/0xf10 mm/gup.c:1202
> >  populate_vma_page_range+0x23d/0x320 mm/gup.c:1587
> >  __mm_populate+0x101/0x3a0 mm/gup.c:1701
> >  mm_populate include/linux/mm.h:2744 [inline]
> >  vm_mmap_pgoff+0x1fd/0x270 mm/util.c:525
> >  ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f07e488b5a9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f07e59e7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: ffffffffffffffda RBX: 00007f07e49abf80 RCX: 00007f07e488b5a9
> > RDX: 0000000000000003 RSI: 0000000000b36000 RDI: 0000000020000000
> > RBP: 00007f07e48e6580 R08: ffffffffffffffff R09: 0000000000000000
> > R10: 0000000000068831 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffc053fba9f R14: 00007f07e59e7300 R15: 0000000000022000
> >  </TASK>
> >
> > Allocated by task 4171:
> >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
> >  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
> >  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
> >  ____kasan_kmalloc mm/kasan/common.c:330 [inline]
> >  __kasan_kmalloc+0x9f/0xb0 mm/kasan/common.c:380
> >  kmalloc include/linux/slab.h:576 [inline]
> >  hugetlb_vma_lock_alloc.part.0+0x3f/0x130 mm/hugetlb.c:6907
> >  hugetlb_vma_lock_alloc mm/hugetlb.c:6663 [inline]
> >  hugetlb_reserve_pages+0xa3f/0xe80 mm/hugetlb.c:6532
> >  hugetlbfs_file_mmap+0x40c/0x5c0 fs/hugetlbfs/inode.c:167
> >  call_mmap include/linux/fs.h:2196 [inline]
> >  mmap_region+0x6bf/0x1bf0 mm/mmap.c:2624
> >  do_mmap+0x825/0xf50 mm/mmap.c:1411
> >  vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
> >  ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Freed by task 4172:
> >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
> >  kasan_set_track+0x21/0x30 mm/kasan/common.c:52
> >  kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
> >  ____kasan_slab_free mm/kasan/common.c:236 [inline]
> >  ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
> >  kasan_slab_free include/linux/kasan.h:177 [inline]
> >  __cache_free mm/slab.c:3389 [inline]
> >  __do_kmem_cache_free mm/slab.c:3585 [inline]
> >  __kmem_cache_free+0xc9/0x3a0 mm/slab.c:3592
> >  hugetlb_vma_lock_release mm/hugetlb.c:6852 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  __hugetlb_vma_unlock_write_put mm/hugetlb.c:6867 [inline]
> >  __hugetlb_vma_unlock_write_free mm/hugetlb.c:6875 [inline]
> >  __unmap_hugepage_range_final+0x2ad/0x340 mm/hugetlb.c:5196
> >  unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
> >  zap_page_range+0x38a/0x520 mm/memory.c:1762
> >  madvise_dontneed_single_vma mm/madvise.c:793 [inline]
> >  madvise_dontneed_free mm/madvise.c:876 [inline]
> >  madvise_vma_behavior+0xee8/0x1cc0 mm/madvise.c:1015
> >  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
> >  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
> >  do_madvise mm/madvise.c:1432 [inline]
> >  __do_sys_madvise mm/madvise.c:1432 [inline]
> >  __se_sys_madvise mm/madvise.c:1430 [inline]
> >  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Looks like page fault is racing with the vma_lock freeing in
> __unmap_hugepage_range_final as the result of a madvise(MADV_DONTNEED).
>
> It should be addressed with,
> https://lore.kernel.org/linux-mm/20221023025047.470646-1-mike.kravetz@oracle.com/

Let's tell syzbot so that it reports similar issues in future:

#syz fix: hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing
