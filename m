Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43E6279E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiKNKCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiKNKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:02:03 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373B22501
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:59:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id b124so10888133oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fAUbn1cd7nvIpMehCbcvODwqPqsDdngaN43UPC82ebs=;
        b=H3wZosPZzj1VfAmg44IIbwylidbEuoNBx3ZSbkJHEftIUXjxFI4lIAeeeQfH/AA/mk
         DoImC1qhnnNFU1H4BArc1V2YSu2bzjgOFhzKqNgDVLHGwHSXmjLGmirIoORAKIwXqNJY
         8rbnkuwG3+6G/Z0bLn9I63fn9vemzSi18/1QL6sj+bUG3s6Gfgbfmu1WC+ACpBonDzoJ
         iaw7zvh7dvRHkh5LNUklHpvFM0Xr0DN+CPM0RJmkU8KGYJZmHlqtI+gKQyFhILJyU1tm
         V21f6pGhd/x5b7rl07yTzWjzsuHyIt2aZUQEaXyB1bSzVS/cAQaHWlmak0QQE5wEdVXF
         Rk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAUbn1cd7nvIpMehCbcvODwqPqsDdngaN43UPC82ebs=;
        b=r13u/e9/BPh469aI0LdzfZtLLP2ch4yvuaWV3oCtkBJ9lZazrkJbR/mhG4tBVYf5yZ
         VMCxkSd1wIqT9RQ/zPPN9KDcWrowUbhNw+uJ5M59lkXYss8HGfpIn+55jNy+WQaDLNRn
         0FGTqZwFD1miwF5lgvR9ePYy758EqUXV5kfx3u+rEbB4YClxEiq6DGxQ3unGp7ykZPGu
         nZOpVQbQJdvSNsr7fjhfr40tLggSNq72fVAKYc9iWxqe9EP/lnkcRD8seZMKIMZsNOLN
         aKe3UDiA89MdCI7R4n8BiFEUCw+/mKxGY/g9CLenFzCa0911z9ny5mEMUYpS0kaqUWdN
         Lajg==
X-Gm-Message-State: ANoB5pmstGtkBghQtcLpnKp5LDiEtOCAlYwwDQDkITdObhm42s/xpBup
        aR9w8KwLQBpllUB6VWB0KrISHtN+cPQ00iYeTfV8pqOObRR6ScwE
X-Google-Smtp-Source: AA0mqf46zD7/njam2K6zDWAjSR+U8f1+8URrgDwnGLzzSv1XrdaKhUynr2/wcC8ZNqS2oxdF3xkNjfZpNkWs49RNJWA=
X-Received: by 2002:a05:6808:3011:b0:35a:7e1d:3d72 with SMTP id
 ay17-20020a056808301100b0035a7e1d3d72mr5542661oib.233.1668419961901; Mon, 14
 Nov 2022 01:59:21 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009586e205ed4679f4@google.com> <CACT4Y+apC6o7jB+nbsZiUua=P76vAT7wVK4GeCfM-hVtWj=scg@mail.gmail.com>
 <Y3E8ffs8jC7041h4@monkey> <Y3Gm01DB9a5PXLOI@monkey>
In-Reply-To: <Y3Gm01DB9a5PXLOI@monkey>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Nov 2022 10:59:10 +0100
Message-ID: <CACT4Y+Y2axe_Hzd8GWtnGy3bbwoCXZFpPGdh+zgfY-kawn3e2w@mail.gmail.com>
Subject: Re: [syzbot] WARNING: locking bug in hugetlb_no_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Hillf Danton <hdanton@sina.com>
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

On Mon, 14 Nov 2022 at 03:24, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/13/22 10:50, Mike Kravetz wrote:
> > On 11/13/22 16:36, Dmitry Vyukov wrote:
> > > On Sat, 12 Nov 2022 at 15:03, syzbot
> > > <syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13bd511e880000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=d07c65298d2c15eafcb0
> > > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > userspace arch: arm64
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13315856880000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173614d1880000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+d07c65298d2c15eafcb0@syzkaller.appspotmail.com
> > >
> > > This may have the same root cause as:
> > >
> > > possible deadlock in hugetlb_fault
> > > https://lore.kernel.org/all/CACT4Y+ZWNV6ApzEv0UrsF2T8JWmXez_-H-EGMii-S_2JbXv07Q@mail.gmail.com/
> > >
> > > and there is a potential explanation as to what may be the problem.
> >
> > Thanks Dmitry!
> >
> > An issue with this new hugetlb locking was previously reported and I have been
> > working on a solution.  When I look at the reproducer, I see that it is calling
> > madvise(MADV_DONTNEED).  This triggers the other issue and could certainly
> > cause the issue reported here.
> >
> > Proposed patches are here and in next-20221111:
> > https://lore.kernel.org/linux-mm/20221111232628.290160-1-mike.kravetz@oracle.com/
> >
> > I am currently trying to run the reproducer, but it is not reproducing quickly.
> > Since this is a timing issue that as expected.  Interesting that this
> > report is run on arm64 and I am trying to reproduce on x86.  Although, the
> > issue is not architecture specific in any way.
>
> After tweaking my config, I was able to reliably reproduce.
>
> > I'll keep looking, but am fairly confident this is the root cause.
>
> I was also able to verify the series above addresses the issue.

Let's tell syzbot about the fix so that it reports similar issues in future:

#syz fix:
hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing
