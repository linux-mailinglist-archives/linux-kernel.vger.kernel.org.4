Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1B621072
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiKHMYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiKHMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:24:26 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F54FFA5;
        Tue,  8 Nov 2022 04:24:19 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id r13so7084489vkf.2;
        Tue, 08 Nov 2022 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxLAjZfA0AwsmBNWPk934g1SqMR+uUlpsmtEd8HnAB8=;
        b=ooMmk9CWOqiO3MGJqVLbvzYwNae2KK1LkFx+OSB/YCrY4w3pLbjl7ORISvbf52RnNy
         Rbwg3p+JtPTb5SAzKZHKHoRxV3wdzcGzebX29jJ9o37MD8YGSDqARzKaZPI//XvKkXQw
         LOkPRJU+Qxh7LUxi96hxnZlx3ZJHb1tuHC8DmtFBqgCcavDi6pcMGzV0yBFubQl4hT5/
         b9wDFQaqcRXcRZZTjtmn4nV1n8oEK+xIymButIMxw9Jx7mx1Pz3UDjnSQMt+oE4e+VWa
         LJWSlNz5yYEpBNupx4ri34bsSrsFONWIG4bo4p5tWifC9HZQlBGfnpM48g4VTZ4BLq2t
         0EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxLAjZfA0AwsmBNWPk934g1SqMR+uUlpsmtEd8HnAB8=;
        b=fDjmzYCrSzf8e3TJgjdqfO7+b8bBiRZKdDSGEZKHW2IWVJcTc3pg9RP+YmTBL41R8Y
         e9eG/MmkAHZ8AbaerKloIdr1w2Ki0dT5rhVcPc15Td5cKehaPzQwn+w4VyftILFAkqzh
         lZsOwxtzQCWeyJrIeQkWpEqKpZE8EjkypRbzwTbjlBMjzJ1GAWhg8WNDksB3e2tPGD+4
         J6UA8UVtWSYrOPsXw5sHLpCYrELYz2ArgV4ZVLdIc6tSRDSfVmivHf/d5vxT8lwo0xqA
         eJw8B4b4d9bzrOQGe+t/eEibNW4BpR3oP6++lTkvhTIkAV7bJ/ZlUtvRGvgV6kNReSVV
         Op4g==
X-Gm-Message-State: ACrzQf2Bz8uVOwLFiGitisvsO/IjPLs6qYgUtcjZwredWXSdeDuBWPg3
        OdXVAAdZ3/0vp15x6vPwrOPrBZIgna/2vubx5Uw=
X-Google-Smtp-Source: AMsMyM5mFBh2Pmp/vJB9KpvJc6/C3oSeCvSE/EY4opqJY7pa7lEEMFDjC9lqbQt4DR8Bh2wUEnOS+pre4OSzz9uWMME=
X-Received: by 2002:a1f:254f:0:b0:3b7:7495:86d5 with SMTP id
 l76-20020a1f254f000000b003b7749586d5mr28749297vkl.23.1667910258747; Tue, 08
 Nov 2022 04:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com> <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
 <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com>
In-Reply-To: <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 8 Nov 2022 21:24:01 +0900
Message-ID: <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 8:53 PM Liu Shixin wrote:
>
>
>
> On 2022/11/8 18:33, Ryusuke Konishi wrote:
> > On Tue, Nov 8, 2022 at 3:49 PM Liu Shixin wrote:
> >>
> >>
> >> On 2022/11/8 12:41, Ryusuke Konishi wrote:
> >>> Hi Liu Shixin,
> >>>
> >>> On Tue, Nov 8, 2022 at 10:41 AM Liu Shixin wrote:
> >>>> Syzbot reported a NULL pointer dereference:
> >>>>
> >>>>  Unable to handle kernel NULL pointer dereference at virtual address=
 0000000000000168
> >>>>  Mem abort info:
> >>>>    ESR =3D 0x0000000096000004
> >>>>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >>>>    SET =3D 0, FnV =3D 0
> >>>>    EA =3D 0, S1PTW =3D 0
> >>>>    FSC =3D 0x04: level 0 translation fault
> >>>>  Data abort info:
> >>>>    ISV =3D 0, ISS =3D 0x00000004
> >>>>    CM =3D 0, WnR =3D 0
> >>>>  user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000108bcf000
> >>>>  [0000000000000168] pgd=3D0000000000000000, p4d=3D0000000000000000
> >>>>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> >>>>  Modules linked in:
> >>>>  CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-180=
95-gbbed346d5a96 #0
> >>>>  Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 09/30/2022
> >>>>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >>>>  pc : _compound_head include/linux/page-flags.h:253 [inline]
> >>>>  pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
> >>>>  lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> >>>>  sp : ffff80001290bc00
> >>>>  x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
> >>>>  x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
> >>>>  x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
> >>>>  x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
> >>>>  x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
> >>>>  x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
> >>>>  x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
> >>>>  x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
> >>>>  x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
> >>>>  x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
> >>>>  Call trace:
> >>>>   lock_page+0x28/0x1e0 include/linux/pagemap.h:956
> >>>>   nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
> >>>>   nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
> >>>>   nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
> >>>>   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
> >>>>   nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
> >>>>   kthread+0x12c/0x158 kernel/kthread.c:376
> >>>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> >>>>
> >>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construct=
ion(),
> >>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we=
 will
> >>>> add a bh in two segbuf->sb_segsum_buffers. And finally cause list er=
ror.
> >>>>
> >>>> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
> >>>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> >>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >>>> ---
> >>>>  fs/nilfs2/segment.c | 1 +
> >>>>  fs/nilfs2/sufile.c  | 2 +-
> >>>>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> >>>> index b4cebad21b48..7be632c15f91 100644
> >>>> --- a/fs/nilfs2/segment.c
> >>>> +++ b/fs/nilfs2/segment.c
> >>>> @@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(struc=
t nilfs_sc_info *sci,
> >>>>                 sci->sc_segbuf_nblocks +=3D segbuf->sb_rest_blocks;
> >>>>
> >>>>                 /* allocate the next next full segment */
> >>>> +               nextnextnum =3D segbuf->sb_segnum;
> >>>>                 err =3D nilfs_sufile_alloc(sufile, &nextnextnum);
> >>>>                 if (unlikely(err))
> >>>>                         goto failed_segbuf;
> >>>> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
> >>>> index 77ff8e95421f..853a8212114f 100644
> >>>> --- a/fs/nilfs2/sufile.c
> >>>> +++ b/fs/nilfs2/sufile.c
> >>>> @@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u=
64 *segnump)
> >>>>                 goto out_sem;
> >>>>         kaddr =3D kmap_atomic(header_bh->b_page);
> >>>>         header =3D kaddr + bh_offset(header_bh);
> >>>> -       last_alloc =3D le64_to_cpu(header->sh_last_alloc);
> >>>> +       last_alloc =3D max(le64_to_cpu(header->sh_last_alloc), *segn=
ump);
> >>>>         kunmap_atomic(kaddr);
> >>>>
> >>>>         nsegments =3D nilfs_sufile_get_nsegments(sufile);
> >>>> --
> >>>> 2.25.1
> >>> Thank you for your help.   I have a few questions, so I'll ask them b=
elow.
> >>>
> >>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construct=
ion(),
> >>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we=
 will
> >>>> add a bh in two segbuf->sb_segsum_buffers.
> >>> If nilfs_sufile_alloc() succeeds to allocate a segment, sh_last_alloc
> >>> is updated.
> >>> all segment allocation must be done through nilfs_sufile_alloc().
> >>> And, the allocated segment is marked dirty on the sufile not to be
> >>> reallocated until it's freed.
> >>>
> >>> So, why is it happening that the same segment is allocated twice in a=
 log ?
> >>> Is it hard to fix the problem by correcting the calling sequence of
> >>> nilfs_sufile_alloc()/free()/etc without touching nilfs_sufile_alloc()
> >>> ?
> >> The problem happened when we call nilfs_segctor_begin_construction() a=
nd satisfied
> >> condition nilfs->ns_segnum !=3D nilfs->ns_nextnum. In such scenario, n=
ilfs_sufile_alloc()
> >> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set_n=
ext_segnum()
> >> all the time, so last_alloc is not updated.
> >> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_=
nextnum directly,
> >> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc=
 is not updated,
> >> we will get sb_segnum again.
> >>
> >> By the way, I still don't understand why skip nilfs_sufile_alloc() in =
some cases and why
> >> nilfs->ns_segnum !=3D nilfs->ns_nextnum. Do you have any ideas?
> >>> I haven't looked closely at this patch yet, but I'm concerned about
> >>> the impact on other places as well.
> >>> nilfs_sufile_alloc() is also used in
> >>> nilfs_segctor_begin_construction() and
> >>> nilfs_prepare_segment_for_recovery().  Are there any side effects?
> >>>
> >>> This patch turns an output-only argument into both input and output,
> >>> and that input value is always used in the calculation of
> >>> "last_alloc".
> >>> So, this change requires all callers to pass a meaningful initial
> >>> value (at least a valid value) to *segnump.
> >>>
> >>> Another question, will this work near the end of the segments ?
> >>> Since segments are used cyclically, wouldn't comparison with the max
> >>> function break down there?
> >>> (I mean it seems that sh_last_alloc may be chosen unintentionally at =
the end.)
> >> Thanks for the heads-up=EF=BC=8CI need to look at it again. This patch=
 can only prevent this problem,
> >> and seems to need improvement. Maybe there is a more reasonable soluti=
on.
> >>
> >> Thanks,
> > I will explain step by step.
> >
> >> By the way, I still don't understand why skip nilfs_sufile_alloc() in =
some cases and why
> >> nilfs->ns_segnum !=3D nilfs->ns_nextnum. Do you have any ideas?
> > nilfs->ns_segnum holds the segment number where nilfs2 currently
> > writes logs to, and nilfs->ns_nextnum holds the next segment number
> > where nilfs2 will select to write logs when the current segment gets
> > full.
> > Here, a segment is a fixed sized container of logs (*), in which
> > multiple logs can be appended and written in.
> > (*) Exceptionally, segment #0 is shorter than others to exclude the
> > superblock area.
> >
> > The reason "nextnum" is needed is that mount-time recovery processing
> > needs to know which segment the logs follow.
> >
> > Both segments (nilfs->ns_segnum and nilfs->ns_nextnum) must be already
> > allocated on the sufile.
> > Here, "allocated" means the corresponding segment usage entry is
> > marked "dirty" on the sufile.
> > In nilfs_sufile_alloc() this is done with the following line:
> >
> >                         nilfs_segment_usage_set_dirty(su);
> >
> > On the other hand, the test whether the segment is allocatable or not
> > is done at the following part:
> >
> >                         if (!nilfs_segment_usage_clean(su))
> >                                 continue;
> >                         /* found a clean segment */
> >
> > Coming back to your last question, if nilfs->ns_segnum !=3D
> > nilfs->ns_nextnum, it indicates that nilfs2 is still writing a log to
> > the segment of ns_segnum.
> > Both should be in the allocated state, so there is no need to call
> > nilfs_sufile_alloc() in this case.
> >
> > If nilfs->ns_segnum =3D=3D nilfs->ns_nextnum in
> > nilfs_segctor_begin_construction(), then nilfs_shift_to_next_segment()
> > sets ns_segnum to ns_nextnum because the current segment (ns_segnum)
> > is full and no more logs can be written.
> > In this case, a new segment must be allocated for new ns_nextnum,
> > therefore nilfs_sufile_alloc() will be called.
> >
> >> The problem happened when we call nilfs_segctor_begin_construction() a=
nd satisfied
> >> condition nilfs->ns_segnum !=3D nilfs->ns_nextnum. In such scenario, n=
ilfs_sufile_alloc()
> >> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set_n=
ext_segnum()
> >> all the time, so last_alloc is not updated.
> > As I explained above, it is expected behavior that
> > nilfs_sufile_alloc() is not called and last_alloc is not updated if
> > nilfs->ns_segnum !=3D nilfs->ns_nextnum.
> >
> > nilfs_segbuf_map() is always called there to set the geometry
> > information in the segbuf.  This is expected behavior.
> > And, nilfs_segbuf_set_next_segnum() is called later to set the
> > determined ns_nextnum to the segbuf, so this is expected behavior as
> > well.
> >
> >> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_=
nextnum directly,
> >> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc=
 is not updated,
> >> we will get sb_segnum again.
> > nilfs_segctor_extend_segments() pre-allocates one or more segments
> > large enough to store updated blocks of metadata files that need to be
> > written in a series of logs at once, and sets up a chain of segbufs.
> > (Sorry for the missing function comment).
> >
> > sb_segnum is set by prev->sb_nextnum to form a chain of buffers for
> > segments.  This is expected behavior.
> > And, the sb_nextnum (=3D next sb_segnum) will be given by
> > nilfs_sufile_alloc().   This is also expected.
> > It looks like the problem is that nilfs_sufile_alloc() here allocates
> > the same segnum again.
> Thanks to your series of explanations, I learned a lot. So I can assume t=
hat
> the skip of nilfs_sufile_alloc() here is because it's already been alloca=
ted. So
> in next time, we will skip previous sb_segnum natually. And the problem
> should not be happend.
>
> >
> > Because sb_segnum is set by prev->sb_nextnum which is allocated by the
> > previous nilfs_sufile_alloc() call,
> > this usually does not happen.
> >
> > A possible anomaly is if the segment pointed by the first nextnum (or
> > segnum) was not marked dirty on sufile.
> > This may happen if the sufile is corrupted on the test disk image that
> > syzbot provided (mounted).
> >
> > Can you confirm if this is actually happening?
> This problem was discovered through syzbot and can be reproduced. The roo=
t
> reason I think is data corruption rather than logical error. So we should=
 add
> some protection instead of modifying the logic, right?

I think the most likely cause is metadata corruption.  If so, we
should fix it by adding a proper sanity check, yes.
However, there is still the possibility that the error retry logic
after detecting errors has a flaw. (I believe at least this is not a
problem with normal paths.)
The sufile state inconsistency above is hypothetical for now.
Either way, I'd like to make sure what's actually happening (and where
the anomaly is coming from) so we can decide how to fix it.

Regards,
Ryusuke Konishi
