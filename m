Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F34613C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJaRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJaRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:30:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DFBDF31
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:30:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so6494517pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42D7b3PhaDq/nstKNJMlraRS5xfxJbbu2o0Am7cwEPg=;
        b=qJnkYQuWzdkUruJEeHJ6laBz9IEPJG2hNSPM6KHTZOxjlV/38DfZA/aQAcH5pc07tq
         Gg5CEL44sU6XvnWpXLEGJEU3J3pVr/F0lAv/HnlzAvBN4srIeeyLp8ZuNBOQd7uOb+Ht
         zR3mPrb+SSMrzyENL7HM1/2TOIFh1xUR8n2w5tcCGMnHjmzmXQht16cx2fTCVYOpC8YE
         pvHikVxXYoEnFikNJJ1sO/EBYSQdtBMhxeRM0bt+lHEbR5svNBemXAy7QwC3TTI5tL/9
         OpiGxpIPWhDMdM/09GdT2To70WFGVEpcLjL3rGRmAh8NKWGLV/PxU4vHDPm+CcD4BVkI
         SN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42D7b3PhaDq/nstKNJMlraRS5xfxJbbu2o0Am7cwEPg=;
        b=mzhgvONXdPDwFYCmAcdhrS6Z0pRRgdVzq5S6yub7aFq9zPbxoMl+gxc719OGkwTjKd
         oNzbAc3UeVYfxiLU61UtzyZx6JHWQLgNXCv3cGPZNUddnf5curvswggxZbGMPbu/BgZD
         XD+y09kmo32nXidA9pZYNnqpDhhYA/U9ag6xqo+NGjMPErh+1KS+JdLkhwRJZWkrz+wy
         nf7YBVwvwUhHthtwV5t31TOk05gyxn1QwP48Hyg4xt7NFFiGxp6uDrO1EryJM6SBQMD1
         wpelbH6f9bg7eI9zfv947zc8Xybn5YIik4Um1MkC8mm5DWkammIZh1V6dcdxzpWX+DQh
         08/A==
X-Gm-Message-State: ACrzQf0mNVbZ12cOsbkZMSycxVAIVmL7WynItMTAybHtLXuwq9fYg8L2
        hpdwqBcUP6dKKIg+WskgG5OhEd8Ta2pIaWACEJk=
X-Google-Smtp-Source: AMsMyM5JCOydaDhP0sygZHVTRpmeLvvMMaDX42igfJWVkazUbjuRd78OYEt94YkafHbOZzuvqbXeCVAygrI3MCkE0xg=
X-Received: by 2002:a17:90b:60e:b0:212:d5cd:4e58 with SMTP id
 gb14-20020a17090b060e00b00212d5cd4e58mr16179744pjb.165.1667237455464; Mon, 31
 Oct 2022 10:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000553fc805ec1380e0@google.com> <CAHbLzkox2F1f52BADJ86wHGnQCOMySxjynNUEx+wYZSMMn456A@mail.gmail.com>
 <Y1xNUHoNve5uuHej@google.com>
In-Reply-To: <Y1xNUHoNve5uuHej@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 31 Oct 2022 10:30:43 -0700
Message-ID: <CAHbLzkrGb00JaXJhvaLSoJK2V5uWO=TrwiNQQjpNaTR98b4Gwg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in alloc_charge_hpage
To:     "Zach O'Keefe" <zokeefe@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     syzbot <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 2:44 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Oct 28 10:37, Yang Shi wrote:
> > On Fri, Oct 28, 2022 at 12:49 AM syzbot
> > <syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    a70385240892 Merge tag 'perf_urgent_for_v6.1_rc2' of git:/..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f4726a880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0044b22d177870ee974f
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13726f72880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b57436880000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/5e17f1e83cf3/disk-a7038524.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f8ef729877f7/vmlinux-a7038524.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> >
> > It looks like the node requested by the allocation is offlined, and
> > the allocation is using __GFP_THISNODE. It doesn't sound like
> > khugepaged specific problem IIUC, I don't see other callsites do
> > anything to prevent the node from being offlined.
> >
> > Shall we remove that warn? The page allocation call will return NULL
> > anyway. Or we could just ignore the warn?
> >
>
> Thanks for taking a look, Yang.
>
> As for the warn -- I don't see the value in the warning at present.  As you
> mention, I don't think it's a khugepaged-thing (as, at least from skimming,
> other callsites don't take care to expect that the node is online).  The
> allocation might fail -- for a number of reasons -- and I don't think
> __GFP_THISNODE + offline node is so special to deserve a warn.
>
> A different question, is if this particular callsite wants to defend against
> that possibility.  My understanding, which I state without data, is that the
> performance of accessing remote memory outweighs the benefit of pmd-mapping the
> memory -- and so I think we rightly fail here.
>
> So, my vote is to just remove the warn.

Thanks, Zach.

Did some archeology, it seems the warning was even stronger before
commit 8addc2d00fe17 ("mm: do not warn on offline nodes unless the
specific node is explicitly requested"). That commit softened the
warning for __GFP_THISNODE.

This warning seems not quite useful TBH because:
  * There is no guarantee the node is online for __GFP_THISNODE context
  * Kernel just fails the allocation regardless the warning, and it
looks all callsites handle the allocation failure gracefully.

So I think we'd better remove this warning.

>
> Thanks,
> Zach
>
> > > Modules linked in:
> > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > >  hpage_collapse_scan_file+0xd6c/0x17a0 mm/khugepaged.c:2156
> > >  madvise_collapse+0x53a/0xb40 mm/khugepaged.c:2611
> > >  madvise_vma_behavior+0xd0a/0x1cc0 mm/madvise.c:1066
> > >  madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
> > >  do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
> > >  do_madvise mm/madvise.c:1432 [inline]
> > >  __do_sys_madvise mm/madvise.c:1432 [inline]
> > >  __se_sys_madvise mm/madvise.c:1430 [inline]
> > >  __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7f6b48a4eef9
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f6b48ccf318 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > > RAX: ffffffffffffffda RBX: 00007f6b48af0048 RCX: 00007f6b48a4eef9
> > > RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
> > > RBP: 00007f6b48af0040 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6b48aa53a4
> > > R13: 00007f6b48bffcbf R14: 00007f6b48ccf400 R15: 0000000000022000
> > >  </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > syzbot can test patches for this issue, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> > >
