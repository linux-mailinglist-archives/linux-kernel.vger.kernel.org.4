Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F74262692B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiKLLd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:33:55 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5692408A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:33:54 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13c2cfd1126so7931896fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WASCqpyvqTm+dApPzLLpG5uSd0cYKz/p7aAYyPpSOpA=;
        b=KPJ6yFkZKRkSqS18fYn4wljLLnYH3FoKmPdA1ZzCpfMBv/7Ghu00p9WXCSuVMllSAm
         zSnslFVl7KEqOFPsdb6RxIP367K7wMZemLPouHvCg5TiQoDSHObt+mjwv34JRXYz2sDV
         QJq6eUg8mC3tBA4jjCkr+/49yZ8j6r/6rdsPHhfHD0Uqu3z6tXQx488LMlpjv2Vvm9mQ
         4wYRV5Z8OkvDYn5JlcmnuU9gdAPZtw+QQtEUh9YblqoF+ox5iClfR+S2OW4UM0ppH92N
         4sn6zgpgAHHUu0wD2hqEY1+Kqh8efIM0TO4dawjLVhX9SQz3CjAK+QW6O/okveDXI8kW
         zNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WASCqpyvqTm+dApPzLLpG5uSd0cYKz/p7aAYyPpSOpA=;
        b=lT83pQTItSt6hrXsOBBHgIKkk3O76vdEVkKJKXYdajrifU8SQQyOdnp2G1Wo3smRVr
         5G8uZbXSABKdK45pLRwzdakf5+yXPgfXheQDddbTs1+K78Dxg2WXwsC6BLsKcjZtX4pi
         +bUj3cpSQTKq1E7cQvs+a6f2UVmnfF/qH2v/OM0ckky9dF9+SYgKuHj/hu6IeoLv1A7P
         WEd2TmxS9fjYD+sUPRP7y8WmyaeIyUgAgWN8n9hgjMqc9h1xD+vQ/eBCUko4xoG/f4KV
         e+Y6KFfqd+EAYRGojxAsuBr9ESod06EqBLnKi13V+qFZK+YkfVUlH7dptE9Su8zIYEm8
         OyUw==
X-Gm-Message-State: ANoB5pmSYndy0nbZNtcEAf6VphbrHkmNmSHPjcdTZsm30YtfYkj0vJFB
        S0/rFCFGhuCXk+IKAy47K+lx27IbVG1CKU///6bQOA==
X-Google-Smtp-Source: AA0mqf62+3HHHLHpNEGtlSIB1lmYHVaJFGhn9LzjKDGNPJozU69O7z77G+ONY2C2YSm2bcKnzvaQ/fbw1pd6gYu7h1o=
X-Received: by 2002:a05:6870:bf0b:b0:13c:7d1c:5108 with SMTP id
 qh11-20020a056870bf0b00b0013c7d1c5108mr3023850oab.282.1668252833334; Sat, 12
 Nov 2022 03:33:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008c742d05eca72d4d@google.com> <Y27jxKoo1BmgbDbl@monkey>
 <c7646d97-c04b-7795-a6f8-a6523945f89c@huawei.com>
In-Reply-To: <c7646d97-c04b-7795-a6f8-a6523945f89c@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 12 Nov 2022 12:33:41 +0100
Message-ID: <CACT4Y+ZWNV6ApzEv0UrsF2T8JWmXez_-H-EGMii-S_2JbXv07Q@mail.gmail.com>
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

On Sat, 12 Nov 2022 at 05:02, 'Miaohe Lin' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 2022/11/12 8:07, Mike Kravetz wrote:
> > On 11/04/22 09:00, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=137d52ca880000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d080a4bd239918dd
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=ca56f14c500045350f93
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >> userspace arch: i386
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/b4f72e7a4c11/disk-f2f32f8a.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/3f88997ad7c9/vmlinux-f2f32f8a.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/b4b5b3963e2d/bzImage-f2f32f8a.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+ca56f14c500045350f93@syzkaller.appspotmail.com
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0 Not tainted
> >> ------------------------------------------------------
> >> syz-executor.2/5665 is trying to acquire lock:
> >> ffff88801c74c298 (&mm->mmap_lock#2){++++}-{3:3}, at: __might_fault+0xa1/0x170 mm/memory.c:5645
> >>
> >> but task is already holding lock:
> >> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_vma_lock_read mm/hugetlb.c:6816 [inline]
> >> ffff88801c4f3078 (&vma_lock->rw_sema){++++}-{3:3}, at: hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5859
> >>
> >> which lock already depends on the new lock.
> >>
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #1 (&vma_lock->rw_sema){++++}-{3:3}:
> >>        down_write+0x90/0x220 kernel/locking/rwsem.c:1562
> >>        hugetlb_vma_lock_write mm/hugetlb.c:6834 [inline]
> >>        __unmap_hugepage_range_final+0x97/0x340 mm/hugetlb.c:5202
> >>        unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
> >>        unmap_vmas+0x21e/0x370 mm/memory.c:1733
> >>        exit_mmap+0x189/0x7a0 mm/mmap.c:3090
> >>        __mmput+0x128/0x4c0 kernel/fork.c:1185
> >>        mmput+0x5c/0x70 kernel/fork.c:1207
> >>        exit_mm kernel/exit.c:516 [inline]
> >>        do_exit+0xa39/0x2a20 kernel/exit.c:807
> >>        do_group_exit+0xd0/0x2a0 kernel/exit.c:950
> >>        get_signal+0x21a1/0x2430 kernel/signal.c:2858
> >>        arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
> >>        exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> >>        exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
> >>        __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> >>        syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
> >>        __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
> >>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> >>
> >> -> #0 (&mm->mmap_lock#2){++++}-{3:3}:
> >>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
> >>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
> >>        validate_chain kernel/locking/lockdep.c:3831 [inline]
> >>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
> >>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
> >>        lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
> >>        __might_fault mm/memory.c:5646 [inline]
> >>        __might_fault+0x104/0x170 mm/memory.c:5639
> >>        _copy_from_user+0x25/0x170 lib/usercopy.c:13
> >>        copy_from_user include/linux/uaccess.h:161 [inline]
> >>        snd_rawmidi_kernel_write1+0x366/0x880 sound/core/rawmidi.c:1549
> >>        snd_rawmidi_write+0x273/0xbb0 sound/core/rawmidi.c:1618
> >>        vfs_write+0x2d7/0xdd0 fs/read_write.c:582
> >>        ksys_write+0x1e8/0x250 fs/read_write.c:637
> >>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
> >>        entry_SYSENTER_compat_after_hwframe+0x70/0x82
> >>
> >> other info that might help us debug this:
> >>
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(&vma_lock->rw_sema);
> >>                                lock(&mm->mmap_lock#2);
> >>                                lock(&vma_lock->rw_sema);
> >>   lock(&mm->mmap_lock#2);
> >
> > I may not be reading the report correctly, but I can not see how we acquire the
> > hugetlb vma_lock before trying to acquire mmap_lock in stack 0.  We would not
> > acquire the vma_lock until we enter hugetlb fault processing (not in the stack).

The unlock of vma_lock is conditional:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/hugetlb.c?id=f2f32f8af2b0ca9d619e5183eae3eed431793baf#n6840

and the condition is:

static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
{
    return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
         vma->vm_private_data;
}

Is it possible that the condition has changed between vma lock and unlock?
What mutexes protect vma->vm_flags/vm_private_data?

That would make the report perfectly sensible.

FWIW the test case that was running is this, that's the syscalls that
were running concurrently:

07:56:56 executing program 2:
r0 = syz_open_dev$sndmidi(&(0x7f0000000040), 0x2, 0x141101)
r1 = dup(r0)
setsockopt$inet_sctp_SCTP_I_WANT_MAPPED_V4_ADDR(r1, 0x84, 0xc,
&(0x7f0000000080), 0x4) (async)
write$6lowpan_enable(r1, &(0x7f0000000000)='0', 0xc86ade39) (async)
mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0x3, 0x68831,
0xffffffffffffffff, 0x0) (async)
madvise(&(0x7f0000000000/0x600000)=nil, 0x600003, 0x4) (async, rerun: 32)
mremap(&(0x7f00007a0000/0x3000)=nil, 0x3000, 0x2000, 0x7,
&(0x7f0000835000/0x2000)=nil) (rerun: 32)





> > Adding Miaohe Lin on Cc due to previous help with vma_lock potential deadlock
> > situations.  Miaohe, does this make sense to you?
> >
>
> Hi Mike,
>   This doesn't make sense for me too. Stack #1 shows that syz-executor is releasing
> its address space while stack #0 shows another thread is serving the write syscall.
> In this case, mm->mm_users is 0 and all threads in this process should be serving
> do_exit()? But I could be easily wrong. Also I can't see how vma_lock is locked before
> trying to acquire mmap_lock in above stacks. Might this be a false positive?
