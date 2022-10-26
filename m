Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E860E221
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiJZN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiJZN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:26:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC494F3B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:25:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f37so28500282lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3F0J21CmvJ5WHYm54tJvUEMwUkDmIvZoPvGXEV0b6J0=;
        b=lsUq/Qjsz9IpqJKpiyJDngqGR9UY+5zS4PjiUAV10f+pvIUBRlfvIUDW2JUWfd0M9Z
         M5qO0x36vlguUJg4KU/YD2wvlqQWuAyTq1kuCzE5zZI6urZ6j4I4Bg7dCHOE4rkr35Jc
         C99l6rZ07Jo+aAIACx46GhvOUVf3KHC5PyJSaMPDeYJx7OpjeaUv+Aw7g1dGYN/R8SBx
         AFtP0pwheE5KQg6mks7OXc479o/5XdKUdZVceFS4BmIrfOUHE3JW8jxVTa+25y2mF42T
         9ONF1ksL8yte8/HDFf9uiEBxogxHstNx/7B50HcPDR+rKQKwa0/pZWSC5GpGkrygbzDa
         XZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F0J21CmvJ5WHYm54tJvUEMwUkDmIvZoPvGXEV0b6J0=;
        b=gyxe8ux4OH6ygnwFD5SNdK4zmXl6b9cDgHPb+BuL1PsbCqdngRUQ6t7mkQndOxP/0v
         IPq6lyO5TDcNhNuyXECCk/YLL4IziT8+UM8olM26phufshWC8xf+PUAEy7XxVF2eCPVP
         XC1NtQq3aCTUPJgkqhlub0R8q/yOGOiJ3m4/jwzkhPmVxGpblpH4RZiMLug4hXmlv4em
         wnWkZT5/OVi7h9oUGtbjBJHG7mldxlaJTvloMnrEZrO3Tglf1PsQmInaXdEsATrItFIb
         urHzfym/D+DAocQubI28RKf/WerONtuI9mgP+uQwoN2kyZ2pyivjV85TqChJSBRGcXvv
         XFMQ==
X-Gm-Message-State: ACrzQf2etiSAOCUYShANxFHCvv0vZKW96swdWCMzAuKDpyR1WnGpao9u
        WP4NNpMiaNnREW/B00wc6X+RNps8n8GqI2Ofvn9DHw==
X-Google-Smtp-Source: AMsMyM6Ix7WVURNf29MW/sR9dZMcJHjp4pAbYMfHGaQV0OuYybYDVQVX3iQaU4p5VxB4eE+WtkUAaTqy96ma42EGVZ4=
X-Received: by 2002:a05:6512:3a83:b0:4ad:23ac:94ec with SMTP id
 q3-20020a0565123a8300b004ad23ac94ecmr4470741lfu.540.1666790739137; Wed, 26
 Oct 2022 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000aa2b2805ebea9137@google.com> <9a450a11-531d-8e1a-4c77-70102aa7f424@redhat.com>
In-Reply-To: <9a450a11-531d-8e1a-4c77-70102aa7f424@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Oct 2022 06:25:27 -0700
Message-ID: <CACT4Y+YTjYMWQKixhkNMuty4LXTsgBmpiYAN5ChGVXZBCyp0uA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __split_huge_page_tail
To:     David Hildenbrand <david@redhat.com>
Cc:     syzbot <syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 at 02:54, David Hildenbrand <david@redhat.com> wrote:
>
> On 26.10.22 08:59, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=113bd8bc880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4789759e8a6d5f57
> > dashboard link: https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e1f62880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dd4fe6880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a61ddb36c296/disk-4da34b7d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ceee41246252/vmlinux-4da34b7d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+273b547b15eb58ea35e8@syzkaller.appspotmail.com
> >
> >   tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
> >   exit_mmap+0x2b1/0x670 mm/mmap.c:3098
> >   __mmput+0x114/0x3b0 kernel/fork.c:1185
> >   exit_mm+0x217/0x2f0 kernel/exit.c:516
> >   do_exit+0x5e7/0x2070 kernel/exit.c:807
> >   do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
> >   __do_sys_exit_group kernel/exit.c:961 [inline]
> >   __se_sys_exit_group kernel/exit.c:959 [inline]
> >   __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3908 at mm/huge_memory.c:2465 __split_huge_page_tail+0x81c/0x1080 mm/huge_memory.c:2465
>
> Is this the
>
> VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>
> assertion?

Hi David,

You can check the sources for that revision, but on the dashboard
there are clickable links for all source references:
https://syzkaller.appspot.com/bug?extid=273b547b15eb58ea35e8

In this case it points to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/huge_memory.c?id=4da34b7d175dc99b8befebd69e96546c960d526c#n2465
