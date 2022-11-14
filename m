Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9C6279D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiKNJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiKNJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:58:56 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF41F2D4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:26 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso6349868otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QTYxStQvkrcv+VnRB4CTT7tx+awCbUZdb7vV8z1XRg4=;
        b=glw3mGv76QLZuBoV3H3Xndonta0JbwjoaXSJ3EOXLNpYG5H5/3/STazmlAphOtwHj7
         tLzZ50vvnnDQSsUyyUN6gPkNwcKKtJRv248S+emetMIVAohcApzOceL0c4uylH5exPL7
         YXVg9rhQnXr03oD9mbc+ElcEbrq8fjXs+fVtcRdVWPcxtyhm+EU0ZkoGk5yWq1VMAro1
         w7XHlRB/sRTjl3r9lAHsh5wjD+APffBniefPryNE+wFz1dO7IteGRxl0xwG9rJLsGlr6
         64wBSwyDrfB0sWtKqLXuJYTze3PXhN+IOPFGJQxa0605mS8wUEJhFtJ0R8QiHly1UwWp
         XCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTYxStQvkrcv+VnRB4CTT7tx+awCbUZdb7vV8z1XRg4=;
        b=REZcU+HtZggFZdY+/b1BBWZGaxeOy58thzYCEToiXZ1ZCEBK2bq9g+0ackINLZZ4Zr
         gyIFOXMDtPUEeyomo9InRAmFlYFGG1E4OyL7N9eTmxpPQGlxq6sADV8pOG20+VoDafZV
         2dMGyZUMp2ov/YIt0d6JvjrzPim0gTL76x6V4P89N2qVdxJBTX/gKGzDF9oDGBXIRnbr
         qG8kMH39tYxjRzpX/H7lkCugZfjWo3bHqEA1ssl9uZwanpITSsFAx2+pamryuYUXN5b9
         y+wrLH4kTaoPVZGlqvza3NEwzDpSF8WW0/nc5LpMDnUO6b6U+xM+RARyeBH3ugteI9Ai
         EIOg==
X-Gm-Message-State: ANoB5pn6J8nTvq0QiQeUzDIOIhIuc4nF0Na45kEsTdleR14NmkJ1ISPT
        MYVnpwsIaJpVv09NSpPRCbRUaol3i7Ica06usdQvug==
X-Google-Smtp-Source: AA0mqf60y5OuJVpNG7qWERDov6uwBf2HXwty8K++9TuleYPTzJT72y0375AI/egD8TEIspASVjS7oyIA813MCoeF67E=
X-Received: by 2002:a9d:32f:0:b0:66c:7982:2d45 with SMTP id
 44-20020a9d032f000000b0066c79822d45mr6152010otv.123.1668419845538; Mon, 14
 Nov 2022 01:57:25 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008c742d05eca72d4d@google.com> <Y27jxKoo1BmgbDbl@monkey>
 <c7646d97-c04b-7795-a6f8-a6523945f89c@huawei.com> <CACT4Y+ZWNV6ApzEv0UrsF2T8JWmXez_-H-EGMii-S_2JbXv07Q@mail.gmail.com>
 <CACT4Y+YAQVAMoU_vS_b+x-Ew3d-ecj+FTHGW9-MPE04dCzZ37w@mail.gmail.com> <4c5fa6b4-6278-ce2b-73c2-883eb734bdc7@huawei.com>
In-Reply-To: <4c5fa6b4-6278-ce2b-73c2-883eb734bdc7@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Nov 2022 10:57:14 +0100
Message-ID: <CACT4Y+ZK76QkwnEnWvcT5bUmtnSos+npCH6-A=uouOaPbJ-xew@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in hugetlb_fault
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com>,
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

On Mon, 14 Nov 2022 at 03:35, 'Miaohe Lin' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 2022/11/12 22:14, Dmitry Vyukov wrote:
> > On Sat, 12 Nov 2022 at 12:33, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> On Sat, 12 Nov 2022 at 05:02, 'Miaohe Lin' via syzkaller-bugs
> >> <syzkaller-bugs@googlegroups.com> wrote:
> >>>
> >>> On 2022/11/12 8:07, Mike Kravetz wrote:
> >>>> On 11/04/22 09:00, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
> >>>>> git tree:       upstream
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=137d52ca880000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d080a4bd239918dd
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ca56f14c500045350f93
> >>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>>>> userspace arch: i386
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> Downloadable assets:
> >>>>> disk image: https://storage.googleapis.com/syzbot-assets/b4f72e7a4c11/disk-f2f32f8a.raw.xz
> >>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/3f88997ad7c9/vmlinux-f2f32f8a.xz
> >>>>> kernel image: https://storage.googleapis.com/syzbot-assets/b4b5b3963e2d/bzImage-f2f32f8a.xz
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com
> >>>>>
> >>>>> ======================================================
> >>>>> WARNING: possible circular locking dependency detected
> >>>>> 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0 Not tainted
> >>>>> ------------------------------------------------------
> >>>>> syz-executor.2/5665 is trying to acquire lock:
> >>>>> ffff88801c74c298 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5645
> >>>>>
> >>>>> but task is already holding lock:
> >>>>> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
> >>>>> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859
> >>>>>
> >>>>> which lock already depends on the new lock.
> >>>>>
> >>>>>
> >>>>> the existing dependency chain (in reverse order) is:
> >>>>>
> >>>>> -> #1 (&vma_lock->rw_sema){++++}-{3:3}:
> >>>>>        down_write+0x90/0x220 kernel/locking/rwsem.c:1562
> >>>>>        hugetlb_vma_lock_write mm/hugetlb.c:6834 [inline]
> >>>>>        __unmap_hugepage_range_final+0x97/0x340 mm/hugetlb.c:5202
> >>>>>        unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
> >>>>>        unmap_vmas+0x21e/0x370 mm/memory.c:1733
> >>>>>        exit_mmap+0x189/0x7a0 mm/mmap.c:3090
> >>>>>        __mmput+0x128/0x4c0 kernel/fork.c:1185
> >>>>>        mmput+0x5c/0x70 kernel/fork.c:1207
> >>>>>        exit_mm kernel/exit.c:516 [inline]
> >>>>>        do_exit+0xa39/0x2a20 kernel/exit.c:807
> >>>>>        do_group_exit+0xd0/0x2a0 kernel/exit.c:950
> >>>>>        get_signal+0x21a1/0x2430 kernel/signal.c:2858
> >>>>>        arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
> >>>>>        exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> >>>>>        exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
> >>>>>        __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> >>>>>        syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
> >>>>>        __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
> >>>>>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >>>>>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> >>>>>
> >>>>> -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
> >>>>>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
> >>>>>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
> >>>>>        validate_chain kernel/locking/lockdep.c:3831 [inline]
> >>>>>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
> >>>>>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
> >>>>>        lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
> >>>>>        __might_fault mm/memory.c:5646 [inline]
> >>>>>        __might_fault+0x104/0x170 mm/memory.c:5639
> >>>>>        _copy_from_user+0x25/0x170 lib/usercopy.c:13
> >>>>>        copy_from_user include/linux/uaccess.h:161 [inline]
> >>>>>        snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
> >>>>>        snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
> >>>>>        vfs_write+0x2d7/0xdd0 fs/read_write.c:582
> >>>>>        ksys_write+0x1e8/0x250 fs/read_write.c:637
> >>>>>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >>>>>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >>>>>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >>>>>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> >>>>>
> >>>>> other info that might help us debug this:
> >>>>>
> >>>>>  Possible unsafe locking scenario:
> >>>>>
> >>>>>        CPU0                    CPU1
> >>>>>        ----                    ----
> >>>>>   lock(&vma_lock->rw_sema);
> >>>>>                                lock(&mm->mmap_lock#2);
> >>>>>                                lock(&vma_lock->rw_sema);
> >>>>>   lock(&mm->mmap_lock#2);
> >>>>
> >>>> I may not be reading the report correctly, but I can not see how we acquire the
> >>>> hugetlb vma_lock before trying to acquire mmap_lock in stack 0.  We would not
> >>>> acquire the vma_lock until we enter hugetlb fault processing (not in the stack).
> >>
> >> The unlock of vma_lock is conditional:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/hugetlb.c?id=f2f32f8af2b0ca9d619e5183eae3eed431793baf#n6840
> >>
> >> and the condition is:
> >>
> >> static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
> >> {
> >>     return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
> >>          vma->vm_private_data;
> >> }
> >>
> >> Is it possible that the condition has changed between vma lock and unlock?
> >> What mutexes protect vma->vm_flags/vm_private_data?
> >>
> >> That would make the report perfectly sensible.
> >>
> >> FWIW the test case that was running is this, that's the syscalls that
> >> were running concurrently:
> >>
> >> 07:56:56 executing program 2:
> >> r0 = syz_open_dev$sndmidi(&(0x7f0000000040), 0x2, 0x141101)
> >> r1 = dup(r0)
> >> setsockopt$inet_sctp_SCTP_I_WANT_MAPPED_V4_ADDR(r1, 0x84, 0xc,
> >> &(0x7f0000000080), 0x4) (async)
> >> write$6lowpan_enable(r1, &(0x7f0000000000)='0', 0xc86ade39) (async)
> >> mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0x3, 0x68831,
> >> 0xffffffffffffffff, 0x0) (async)
> >> madvise(&(0x7f0000000000/0x600000)=nil, 0x600003, 0x4) (async, rerun: 32)
> >> mremap(&(0x7f00007a0000/0x3000)=nil, 0x3000, 0x2000, 0x7,
> >> &(0x7f0000835000/0x2000)=nil) (rerun: 32)
> >
> >
> > This new bug report seems to confirm the hypothesis:
> >
> > WARNING: locking bug in hugetlb_no_page
> > https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
>
> Thanks Dmitry!
>
> I believe Mike found the root cause and his proposed patches in next-20221111 will fix the problem:
>   https://lore.kernel.org/linux-mm/20221111232628.290160-1-mike.kravetz@oracle.com/
>
> Let's keep looking. :) Thanks for your work!


Let's tell syzbot about the fix so that it reports similar issues in future:

#syz fix:
hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing

> Thanks,
> Miaohe Lin
>
>
> >
> >
> >>>> Adding Miaohe Lin on Cc due to previous help with vma_lock potential deadlock
> >>>> situations.  Miaohe, does this make sense to you?
> >>>>
> >>>
> >>> Hi Mike,
> >>>   This doesn't make sense for me too. Stack #1 shows that syz-executor is releasing
> >>> its address space while stack #0 shows another thread is serving the write syscall.
> >>> In this case, mm->mm_users is 0 and all threads in this process should be serving
> >>> do_exit()? But I could be easily wrong. Also I can't see how vma_lock is locked before
> >>> trying to acquire mmap_lock in above stacks. Might this be a false positive?
> > .
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/4c5fa6b4-6278-ce2b-73c2-883eb734bdc7%40huawei.com.
