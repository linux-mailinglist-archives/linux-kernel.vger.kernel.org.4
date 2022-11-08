Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73889620982
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiKHGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiKHGUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:20:03 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE0326FB;
        Mon,  7 Nov 2022 22:20:01 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id b81so8240931vkf.1;
        Mon, 07 Nov 2022 22:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePxJ0cMyxU7hZKfemaCo4z91ENavbF4DP5tqDnIrbwA=;
        b=O6n+B4JVsNQC+/U+91ztdlsa9C9dvgnG1Q4TU2mQtn4+4rZmKqrRH2OodY6FEI74yG
         3QoLgs89funPWDHiSt/QKVe06bsqt5LU16UPyJ/KomqmN0ebtPWiyh9ahvnJ7pvd0h/G
         Zkjh31ntbnlFq4oaqmb+nkbaspdMUr2kgLBs2WSDkZKXm/Hz7eHcVp00CwIVwPRlyMlM
         duuyzOYRoRHUl3TRjmcP34tKsekMxVYsuDNP9etAxP8KfSOj1+oKn2haTAewktx1t2Us
         1slQ5Ccps1+9ZDkrMROkDplczHxVbxe0kvVnVo6KxZKHW13rV4gnL6tiLQZ+RlJzW9oZ
         1s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePxJ0cMyxU7hZKfemaCo4z91ENavbF4DP5tqDnIrbwA=;
        b=7cjPbbxNbvQTpgs2LFQ/ri9L578ojBNcXd6okCmun5qGQ4a1PY+QM47Huemz9fqKRq
         6xA3mElTYPrGZ8Ei9W2vFxOHK58DocJLyVQ7dKkp6fyZJkY88cMWp87BvAj9Wvq9oA37
         NRFy0e+8jD9gKPfbFl2iLaxRNOdlsssNAIrJF4AD1PcaGFYJG2Dy8WVKsVroAPZ7njKo
         q9p+bmE9CAX79cseBHnX5FTHihJ7UF678G1KIjTLgNYQvusiYVdFHmz8jn7vnuWGCajj
         lQOFIF4DXqUqklOkvpGjQXt9gZmIoSaQztivm3dGTHiNbwKiiSiiAdQmRS7ANF/u/LC7
         pmiQ==
X-Gm-Message-State: ACrzQf0OXQJvVQYILH1d67kvKXiGLjHXmYEZl51NWGuaPHHUuIYlrwNc
        dVTBgqOenidNZevP+2bj2urvHOeXfNzM4WFsxbb3PUivp3A=
X-Google-Smtp-Source: AMsMyM65ZI4UGvStFgGfxG/RcXmy+pA4u8gpsIdyWTq8invX8x5iQ5DBy6VcyNy15DWQSkQRzjm2jQDvYgidBf1zFF8=
X-Received: by 2002:a1f:254f:0:b0:3b7:7495:86d5 with SMTP id
 l76-20020a1f254f000000b003b7749586d5mr28262884vkl.23.1667888399963; Mon, 07
 Nov 2022 22:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com> <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
In-Reply-To: <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 8 Nov 2022 15:19:43 +0900
Message-ID: <CAKFNMok3YGAPfrze=_Ed2tWAvOFp_3kYbGGnOvY1ZmCdF4dKMA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 1:41 PM Ryusuke Konishi wrote:
>
> Hi Liu Shixin,
>
> On Tue, Nov 8, 2022 at 10:41 AM Liu Shixin wrote:
> >
> > Syzbot reported a NULL pointer dereference:
> >
> >  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
> >  Mem abort info:
> >    ESR = 0x0000000096000004
> >    EC = 0x25: DABT (current EL), IL = 32 bits
> >    SET = 0, FnV = 0
> >    EA = 0, S1PTW = 0
> >    FSC = 0x04: level 0 translation fault
> >  Data abort info:
> >    ISV = 0, ISS = 0x00000004
> >    CM = 0, WnR = 0
> >  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
> >  [0000000000000168] pgd=0000000000000000, p4d=0000000000000000
> >  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> >  Modules linked in:
> >  CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> >  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> >  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >  pc : _compound_head include/linux/page-flags.h:253 [inline]
> >  pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
> >  lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> >  sp : ffff80001290bc00
> >  x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
> >  x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
> >  x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
> >  x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
> >  x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
> >  x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
> >  x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
> >  x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> >  x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> >  x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
> >  Call trace:
> >   lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> >   nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
> >   nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
> >   nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
> >   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
> >   nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
> >   kthread+0x12c/0x158 kernel/kthread.c:376
> >   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> >
> > If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
> > nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
> > add a bh in two segbuf->sb_segsum_buffers. And finally cause list error.
> >
> > Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
> > Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > ---
> >  fs/nilfs2/segment.c | 1 +
> >  fs/nilfs2/sufile.c  | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> > index b4cebad21b48..7be632c15f91 100644
> > --- a/fs/nilfs2/segment.c
> > +++ b/fs/nilfs2/segment.c
> > @@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(struct nilfs_sc_info *sci,
> >                 sci->sc_segbuf_nblocks += segbuf->sb_rest_blocks;
> >
> >                 /* allocate the next next full segment */
> > +               nextnextnum = segbuf->sb_segnum;
> >                 err = nilfs_sufile_alloc(sufile, &nextnextnum);
> >                 if (unlikely(err))
> >                         goto failed_segbuf;
> > diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> > index 77ff8e95421f..853a8212114f 100644
> > --- a/fs/nilfs2/sufile.c
> > +++ b/fs/nilfs2/sufile.c
> > @@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
> >                 goto out_sem;
> >         kaddr = kmap_atomic(header_bh->b_page);
> >         header = kaddr + bh_offset(header_bh);
> > -       last_alloc = le64_to_cpu(header->sh_last_alloc);
> > +       last_alloc = max(le64_to_cpu(header->sh_last_alloc), *segnump);
> >         kunmap_atomic(kaddr);
> >
> >         nsegments = nilfs_sufile_get_nsegments(sufile);
> > --
> > 2.25.1
>
> Thank you for your help.   I have a few questions, so I'll ask them below.
>
> > If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
> > nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
> > add a bh in two segbuf->sb_segsum_buffers.
>
> If nilfs_sufile_alloc() succeeds to allocate a segment, sh_last_alloc
> is updated.
> all segment allocation must be done through nilfs_sufile_alloc().
> And, the allocated segment is marked dirty on the sufile not to be
> reallocated until it's freed.
>
> So, why is it happening that the same segment is allocated twice in a log ?
> Is it hard to fix the problem by correcting the calling sequence of
> nilfs_sufile_alloc()/free()/etc without touching nilfs_sufile_alloc() ?

If the cause of this problem is a sufile state inconsistency on disk,
rather than an imperfection in the call sequence, then some sanity
check should be added to treat the inconsistency as an error.
Since this came from syzbot, I suspect that it may have created an
on-disk metadata anomaly and hit this.

For example, if the next (or next next) segment that the latest
segment summary points to is not in the allocated (dirty) state and it
is missed and is causing this oops, I think we should change it to
check for that at mount time.

Either way, I feel like we need to look a little more at the root cause.

Ryusuke Konishi

>
> I haven't looked closely at this patch yet, but I'm concerned about
> the impact on other places as well.
> nilfs_sufile_alloc() is also used in
> nilfs_segctor_begin_construction() and
> nilfs_prepare_segment_for_recovery().  Are there any side effects?
>
> This patch turns an output-only argument into both input and output,
> and that input value is always used in the calculation of
> "last_alloc".
> So, this change requires all callers to pass a meaningful initial
> value (at least a valid value) to *segnump.
>
> Another question, will this work near the end of the segments ?
> Since segments are used cyclically, wouldn't comparison with the max
> function break down there?
> (I mean it seems that sh_last_alloc may be chosen unintentionally at the end.)
>
> Regards,
> Ryusuke Konishi
