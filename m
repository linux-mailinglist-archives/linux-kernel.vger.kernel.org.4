Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E686613FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJaVOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJaVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:14:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4BEAE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:14:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p8so21101859lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DcZE19dOw0U3InXQqQZ7CFjQ49Klqa6Gwpt3MBGI+o=;
        b=d0BSzssxKL5+1GxJgWULpUZolqdu19rdxV2Cqxm5EXnrcp9cpP6sqAeHh7k3nwaN1e
         pPVQ1JsB2heoCllM/I97N6o6vz410RHGTT21pmYuzzzQTNOt+mzP2aC15Pc/gI2eCFm1
         CNOk6Td1v4CJtxlSuNA8mQhpZsMWHQQ+HdnY879/gYWrMoiHm2P+7MOQd9g9ryOPPXsb
         omotv1+2sLcNSH2jayRhUSo9J7sgsr7bQ6lLe4+ybOoK9KAVDgJcJcT9ePJ70XsZBpho
         /gEL8AIiZH6mwezWB4VKNmcC6EXHbqGLbhCCE0ViIGdExUT5HFX30KuVc6wMIYjJyWwe
         8wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DcZE19dOw0U3InXQqQZ7CFjQ49Klqa6Gwpt3MBGI+o=;
        b=Q6ZLnXWPjxLVN1a3lIz7qlp+tPcexXLVIXmHbNyxD4vqvIrNxXH9Bj/hd5fN7kxAuH
         8rT4lRbaUw1U3roFxUt3BXbhLs5Sgwpi+OphZt25UOVPFtuWkdISp5NbVeY9cyttP7HH
         wcyAYjsork30+tcE6tYzpELquDiHzTUxJjTFPxuZH5iSQDsNPgtgro7xxy2LwgG6kFPG
         sV/goRJ7rHQvYdHPKianYZXkSmgtcO4lfZX9G2ELI4NvM3sIM+LvFa1nNQDY+XXJDNYx
         AyrP1Sbl4hkE3yT1IaNaFq0Nl0B1453++5zEjBY7VOEvgTbmF8lZpj67TI6PuKjckRp4
         UNDg==
X-Gm-Message-State: ACrzQf3oJvyPOu6xDedhgISAOCeXgY/WJOUtHvdlS3XVjVD10aoNayZO
        YhhVs4Dlm11xFS65X4OGZqWBhnvlTM8piJ2hmOtAgA9o2OM=
X-Google-Smtp-Source: AMsMyM6rkpyT/b1u5KX4GfdoLxf6YTi3FhBaaycvUgy9mxVh5CXnLjbVp50j8KVtHnPWQpXX/qC59RhAUOAgoWZXcis=
X-Received: by 2002:a05:6512:224e:b0:4a2:5060:55ef with SMTP id
 i14-20020a056512224e00b004a2506055efmr6046728lfu.412.1667250857258; Mon, 31
 Oct 2022 14:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000553fc805ec1380e0@google.com> <CAHbLzkox2F1f52BADJ86wHGnQCOMySxjynNUEx+wYZSMMn456A@mail.gmail.com>
 <Y1xNUHoNve5uuHej@google.com> <CAHbLzkrGb00JaXJhvaLSoJK2V5uWO=TrwiNQQjpNaTR98b4Gwg@mail.gmail.com>
In-Reply-To: <CAHbLzkrGb00JaXJhvaLSoJK2V5uWO=TrwiNQQjpNaTR98b4Gwg@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 31 Oct 2022 14:13:40 -0700
Message-ID: <CAAa6QmRqv5znrWMkHXK+3X12FEYH4eM+DD75T3gmaKAAHFmM3w@mail.gmail.com>
Subject: Re: [syzbot] WARNING in alloc_charge_hpage
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        syzbot <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

On Mon, Oct 31, 2022 at 10:30 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Oct 28, 2022 at 2:44 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Oct 28 10:37, Yang Shi wrote:
> > > On Fri, Oct 28, 2022 at 12:49 AM syzbot
> > > <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f4726a880000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0044b22d177870ee974f
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13726f72880000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b57436880000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/5e17f1e83cf3/disk-a7038524.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/f8ef729877f7/vmlinux-a7038524.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > >
> > > It looks like the node requested by the allocation is offlined, and
> > > the allocation is using __GFP_THISNODE. It doesn't sound like
> > > khugepaged specific problem IIUC, I don't see other callsites do
> > > anything to prevent the node from being offlined.
> > >
> > > Shall we remove that warn? The page allocation call will return NULL
> > > anyway. Or we could just ignore the warn?
> > >
> >
> > Thanks for taking a look, Yang.
> >
> > As for the warn -- I don't see the value in the warning at present.  As you
> > mention, I don't think it's a khugepaged-thing (as, at least from skimming,
> > other callsites don't take care to expect that the node is online).  The
> > allocation might fail -- for a number of reasons -- and I don't think
> > __GFP_THISNODE + offline node is so special to deserve a warn.
> >
> > A different question, is if this particular callsite wants to defend against
> > that possibility.  My understanding, which I state without data, is that the
> > performance of accessing remote memory outweighs the benefit of pmd-mapping the
> > memory -- and so I think we rightly fail here.
> >
> > So, my vote is to just remove the warn.
>
> Thanks, Zach.
>
> Did some archeology, it seems the warning was even stronger before
> commit 8addc2d00fe17 ("mm: do not warn on offline nodes unless the
> specific node is explicitly requested"). That commit softened the
> warning for __GFP_THISNODE.
>
> This warning seems not quite useful TBH because:
>   * There is no guarantee the node is online for __GFP_THISNODE context
>   * Kernel just fails the allocation regardless the warning, and it
> looks all callsites handle the allocation failure gracefully.
>
> So I think we'd better remove this warning.

Hey Yang,

Yep, I did a similar lookup and came to the same conclusion.

Will a look at your patch (thank you for sending it out)

Best,
Zach

> >
> > Thanks,
> > Zach
> >
> > > > Modules linked in:
> > > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > > >  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
> > > >  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
> > > >  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
> > > >  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
> > > >  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
> > > >  do_madvise mm/madvise.c:1432 [inline]
> > > >  __do_sys_madvise mm/madvise.c:1432 [inline]
> > > >  __se_sys_madvise mm/madvise.c:1430 [inline]
> > > >  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > RIP: 0033:0x7f6b48a4eef9
> > > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > > > RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> > > > RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> > > > RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> > > > R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
> > > >  </TASK>
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > syzbot can test patches for this issue, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
> > > >
