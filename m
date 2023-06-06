Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B6724CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbjFFTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbjFFTNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:13:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D601BD7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:12:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2568caabfbfso3223395a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686078735; x=1688670735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V4VnQ+NwlTLpp1UfRmPdcygP5cp3PVVXwMSQln1Mw4=;
        b=huHRTZhmyVde5umjaMPBXE9BqvehtfkERNX0+20lrgbb+8BZmowdyr2pLmm/hBeKqj
         SXskEgPUvfeQg9JvqFPSuMluR8H4EJB7LzMVVw+tekJ49ehCm0xmpS2aHsvURYkf7hbQ
         nHNrQOAeNuseR6C5I6RVw3E3+iSfhpG7uCpaWTEUkMhH338GO1B7+ejPK6h+8DWZDhfH
         bKHBTGbLMVCH29lRdVlWC7QLN1boxnVeAk2gA9lRKEfS+Nsj+m3PqpbzYsRkul3tDm5M
         r4Y/Pg2yjy2IgTq3EKGfiPj69z5p07fNLL1s+jJeFHBuKgUu1FbdkxQUuE5myqzXEmic
         AzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078735; x=1688670735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V4VnQ+NwlTLpp1UfRmPdcygP5cp3PVVXwMSQln1Mw4=;
        b=kedxGxn1WHUldLaEDPdd/UV33oBa9DozNQFobyl9EhimxnoGQ3A+YTP/f1zIJZfkwa
         ssvUzvzdweeJqW82xIxbLy6M8lL4kN5uD/KtTSgo8l/9fvs9oSsB0lMCULF9QYT76wSW
         wdzNgDNqjC8AuYJlMTT2Q0NDzXo7n93s5flr7hkSIoRcWbs5Mc15AaQNXd1+56BL/8sO
         QszrKTjajFkuv6TtrbGF6HTJFaLS1rjBlZeni4O9Tu35UcicH35eqt/oaUTHOP9O6KnY
         OhnQ65e5XdHsFJsScLT7zXPfC/1XQe2HGULV6TtfWXsq178+WnXPZ9munOl8KAnQiS08
         tbqA==
X-Gm-Message-State: AC+VfDyVHLGEc15UuHOoGULrMK48S/RV+dXz5Hk8nPlDzqyd/atMp00w
        XN064d9adbGqOAHfucpSqNhRFdms4T03S/W9Dm/rqGSn
X-Google-Smtp-Source: ACHHUZ6pvkagNmr77QJSeQrvFqP2Rtr4ViTDOCT+9jTlisEZtBeHczaWuWiySyEsKop2uTYJgopZX2Y4OrTW2NC4wAg=
X-Received: by 2002:a17:90a:10c9:b0:259:6a29:ef1c with SMTP id
 b9-20020a17090a10c900b002596a29ef1cmr1545385pje.5.1686078734710; Tue, 06 Jun
 2023 12:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230552.350731-1-peterx@redhat.com> <20230602230552.350731-5-peterx@redhat.com>
 <CAHbLzkp_tzN8SZVeWTKxtMAnFSzUvk2064KFg3quj=raOSHPrA@mail.gmail.com> <ZH41YzZ0DBoF8csH@x1n>
In-Reply-To: <ZH41YzZ0DBoF8csH@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Jun 2023 12:12:03 -0700
Message-ID: <CAHbLzkq-dE4B5k+4KV5YtSJRXf+x61V8iBte6Z=Afbh=_oCJtw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: Make most walk page paths with
 pmd_trans_unstable() to retry
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 12:20=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 05, 2023 at 11:46:04AM -0700, Yang Shi wrote:
> > On Fri, Jun 2, 2023 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > For most of the page walk paths, logically it'll always be good to ha=
ve the
> > > pmd retries if hit pmd_trans_unstable() race.  We can treat it as non=
e
> > > pmd (per comment above pmd_trans_unstable()), but in most cases we're=
 not
> > > even treating that as a none pmd.  If to fix it anyway, a retry will =
be the
> > > most accurate.
> > >
> > > I've went over all the pmd_trans_unstable() special cases and this pa=
tch
> > > should cover all the rest places where we should retry properly with
> > > unstable pmd.  With the newly introduced ACTION_AGAIN since 2020 we c=
an
> > > easily achieve that.
> > >
> > > These are the call sites that I think should be fixed with it:
> > >
> > > *** fs/proc/task_mmu.c:
> > > smaps_pte_range[634]           if (pmd_trans_unstable(pmd))
> > > clear_refs_pte_range[1194]     if (pmd_trans_unstable(pmd))
> > > pagemap_pmd_range[1542]        if (pmd_trans_unstable(pmdp))
> > > gather_pte_stats[1891]         if (pmd_trans_unstable(pmd))
> > > *** mm/memcontrol.c:
> > > mem_cgroup_count_precharge_pte_range[6024] if (pmd_trans_unstable(pmd=
))
> > > mem_cgroup_move_charge_pte_range[6244] if (pmd_trans_unstable(pmd))
> > > *** mm/memory-failure.c:
> > > hwpoison_pte_range[794]        if (pmd_trans_unstable(pmdp))
> > > *** mm/mempolicy.c:
> > > queue_folios_pte_range[517]    if (pmd_trans_unstable(pmd))
> > > *** mm/madvise.c:
> > > madvise_cold_or_pageout_pte_range[425] if (pmd_trans_unstable(pmd))
> > > madvise_free_pte_range[625]    if (pmd_trans_unstable(pmd))
> > >
> > > IIUC most of them may or may not be a big issue even without a retry,
> > > either because they're already not strict (smaps, pte_stats, MADV_COL=
D,
> > > .. it can mean e.g. the statistic may be inaccurate or one less 2M ch=
unk to
> > > cold worst case), but some of them could have functional error withou=
t the
> > > retry afaiu (e.g. pagemap, where we can have the output buffer shifte=
d over
> > > the unstable pmd range.. so IIUC the pagemap result can be wrong).
> > >
> > > While these call sites all look fine, and don't need any change:
> > >
> > > *** include/linux/pgtable.h:
> > > pmd_devmap_trans_unstable[1418] return pmd_devmap(*pmd) || pmd_trans_=
unstable(pmd);
> > > *** mm/gup.c:
> > > follow_pmd_mask[695]           if (pmd_trans_unstable(pmd))
> > > *** mm/mapping_dirty_helpers.c:
> > > wp_clean_pmd_entry[131]        if (!pmd_trans_unstable(&pmdval))
> > > *** mm/memory.c:
> > > do_anonymous_page[4060]        if (unlikely(pmd_trans_unstable(vmf->p=
md)))
> > > *** mm/migrate_device.c:
> > > migrate_vma_insert_page[616]   if (unlikely(pmd_trans_unstable(pmdp))=
)
> > > *** mm/mincore.c:
> > > mincore_pte_range[116]         if (pmd_trans_unstable(pmd)) {
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  fs/proc/task_mmu.c  | 17 +++++++++++++----
> > >  mm/madvise.c        |  8 ++++++--
> > >  mm/memcontrol.c     |  8 ++++++--
> > >  mm/memory-failure.c |  4 +++-
> > >  mm/mempolicy.c      |  4 +++-
> > >  5 files changed, 31 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 6259dd432eeb..823eaba5c6bf 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -631,8 +631,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned =
long addr, unsigned long end,
> > >                 goto out;
> > >         }
> > >
> > > -       if (pmd_trans_unstable(pmd))
> > > +       if (pmd_trans_unstable(pmd)) {
> > > +               walk->action =3D ACTION_AGAIN;
> > >                 goto out;
> > > +       }
> > > +
> > >         /*
> > >          * The mmap_lock held all the way back in m_start() is what
> > >          * keeps khugepaged out of here and from collapsing things
> > > @@ -1191,8 +1194,10 @@ static int clear_refs_pte_range(pmd_t *pmd, un=
signed long addr,
> > >                 return 0;
> > >         }
> > >
> > > -       if (pmd_trans_unstable(pmd))
> > > +       if (pmd_trans_unstable(pmd)) {
> > > +               walk->action =3D ACTION_AGAIN;
> > >                 return 0;
> > > +       }
> > >
> > >         pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > >         for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> > > @@ -1539,8 +1544,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsi=
gned long addr, unsigned long end,
> > >                 return err;
> > >         }
> > >
> > > -       if (pmd_trans_unstable(pmdp))
> > > +       if (pmd_trans_unstable(pmdp)) {
> > > +               walk->action =3D ACTION_AGAIN;
> > >                 return 0;
> >
> > Had a quick look at the pagemap code, I agree with your analysis,
> > "returning 0" may mess up pagemap, retry should be fine. But I'm
> > wondering whether we should just fill in empty entries. Anyway I don't
> > have a  strong opinion on this, just a little bit concerned by
> > potential indefinite retry.
>
> Yes, none pte is still an option.  But if we're going to fix this anyway,
> it seems better to fix it with the accurate new thing that poped up, and
> it's even less change (just apply walk->action rather than doing random
> stuff in different call sites).
>
> I see that you have worry on deadloop over this, so I hope to discuss
> altogether here.
>
> Unlike normal checks, pmd_trans_unstable() check means something must hav=
e
> changed in the past very short period or it should just never if nothing
> changed concurrently from under us, so it's not a "if (flag=3D=3Dtrue)" c=
heck
> which is even more likely to loop.
>
> If we see the places that I didn't touch, most of them suggested a retry =
in
> one form or another.  So if there's a worry this will also not the first
> time to do a retry (and for such a "unstable" API, that's really the most
> natural thing to do which is to retry until it's stable).

IIUC other than do_anonymous_page() suggests retry (retry page fault),
others may not, for example:
  - follow_pmd_mask: return -EBUSY
  - wp_clean_pmd_entry: actually just retry for pmd_none case, but the
pagewalk code does handle pmd_none by skipping it, so it basically
just retry once
  - min_core_pte_range: treated as unmapped range by calling
__mincore_unmapped_range

Anyway I really don't have a strong opinion on this. I may be just
over-concerned. I just thought if nobody cares whether the result is
accurate or not, why do we bother fixing those cases?

>
> So in general, it seems to me if we deadloop over pmd_trans_unstable() fo=
r
> whatever reason then something more wrong could have happened..
>
> Thanks,
>
> --
> Peter Xu
>
