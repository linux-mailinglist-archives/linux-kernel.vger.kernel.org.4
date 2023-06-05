Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6B722FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjFETVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjFETVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E687EED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685992808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3gJegw+Nxk7RoiwTPjGOLisSvTSWuH40t9k+gDBIZk=;
        b=eXCOKhabRkMbTlgDzP6HAhnO92suGAqi6bAxuxB2sL6e6YEHl5BvAYFmKCnK+eqdeP51UL
        BpI0hb8f0sC+C5vz+z+OgGHE4mhslNchLly2J1ywTb5HZpoDL9/AxP0iqisLSNQ+fU/taU
        q23ZMh8cANmZ/tQYsDc9sFrCzlWfXWo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-q3XU63thOX682ZIKY7aMBg-1; Mon, 05 Jun 2023 15:20:07 -0400
X-MC-Unique: q3XU63thOX682ZIKY7aMBg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b337f2504so102082385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992806; x=1688584806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3gJegw+Nxk7RoiwTPjGOLisSvTSWuH40t9k+gDBIZk=;
        b=bGvTX801pk6dVTNeKowJZ3iSEi2Y/uVLYBUoyKoRh/B3x6HqiLeCG+mvM+77JlzELU
         H1vWP3nBkmc6ly6rj+GR+RnSxJGUiDh+gc0engFgPZGjbmEe4EWpDAjI9SrlFbUO9nyR
         KtqiqZ+uO+7xmF1R+xh0mIEKy6JAm+uEkVaJgDXoZuM8UIUMvYlHm/mWZ81kwcJ1T3yx
         JIqQ6Ed9uXAqk8zHOm2ObBwmfU4iuwz6EO1f999r9ICaSRd3h0CNz7zLpsZYQ3WEEp6G
         mWgzj3nwbfwSxgnPlmDq1QdeQ9JFSxgxPrfH7JC0J3Zt/rvXbd03K+xEKZE0sV+i72xD
         rDFQ==
X-Gm-Message-State: AC+VfDzZ9dYe+iB9UYRHH63Jfb/IJVHSYZbuQIcyjNyfUBNzyl4tGUh2
        nUrpXfdthMyt/3hjbKjjPBniqd7GEEFUOXuWSRkUuLxOnbHwxL4ePpzf8wp3W7fC1tm8v/OVdNa
        5mmC3vdXSS7KGpIW8tPAFbsB6
X-Received: by 2002:a05:620a:4608:b0:75b:23a1:69e4 with SMTP id br8-20020a05620a460800b0075b23a169e4mr24924952qkb.4.1685992806494;
        Mon, 05 Jun 2023 12:20:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KaZbrUbHfUOAQ4MJPPCdYmmSw75EyCtKDwbv6P1YuOokJkf5Zw/bRz0vcgCeVP/isTdSzsQ==
X-Received: by 2002:a05:620a:4608:b0:75b:23a1:69e4 with SMTP id br8-20020a05620a460800b0075b23a169e4mr24924927qkb.4.1685992806193;
        Mon, 05 Jun 2023 12:20:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a035100b0075cdb0381ebsm4430076qkm.67.2023.06.05.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:20:05 -0700 (PDT)
Date:   Mon, 5 Jun 2023 15:20:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH 4/4] mm: Make most walk page paths with
 pmd_trans_unstable() to retry
Message-ID: <ZH41YzZ0DBoF8csH@x1n>
References: <20230602230552.350731-1-peterx@redhat.com>
 <20230602230552.350731-5-peterx@redhat.com>
 <CAHbLzkp_tzN8SZVeWTKxtMAnFSzUvk2064KFg3quj=raOSHPrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkp_tzN8SZVeWTKxtMAnFSzUvk2064KFg3quj=raOSHPrA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 11:46:04AM -0700, Yang Shi wrote:
> On Fri, Jun 2, 2023 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > For most of the page walk paths, logically it'll always be good to have the
> > pmd retries if hit pmd_trans_unstable() race.  We can treat it as none
> > pmd (per comment above pmd_trans_unstable()), but in most cases we're not
> > even treating that as a none pmd.  If to fix it anyway, a retry will be the
> > most accurate.
> >
> > I've went over all the pmd_trans_unstable() special cases and this patch
> > should cover all the rest places where we should retry properly with
> > unstable pmd.  With the newly introduced ACTION_AGAIN since 2020 we can
> > easily achieve that.
> >
> > These are the call sites that I think should be fixed with it:
> >
> > *** fs/proc/task_mmu.c:
> > smaps_pte_range[634]           if (pmd_trans_unstable(pmd))
> > clear_refs_pte_range[1194]     if (pmd_trans_unstable(pmd))
> > pagemap_pmd_range[1542]        if (pmd_trans_unstable(pmdp))
> > gather_pte_stats[1891]         if (pmd_trans_unstable(pmd))
> > *** mm/memcontrol.c:
> > mem_cgroup_count_precharge_pte_range[6024] if (pmd_trans_unstable(pmd))
> > mem_cgroup_move_charge_pte_range[6244] if (pmd_trans_unstable(pmd))
> > *** mm/memory-failure.c:
> > hwpoison_pte_range[794]        if (pmd_trans_unstable(pmdp))
> > *** mm/mempolicy.c:
> > queue_folios_pte_range[517]    if (pmd_trans_unstable(pmd))
> > *** mm/madvise.c:
> > madvise_cold_or_pageout_pte_range[425] if (pmd_trans_unstable(pmd))
> > madvise_free_pte_range[625]    if (pmd_trans_unstable(pmd))
> >
> > IIUC most of them may or may not be a big issue even without a retry,
> > either because they're already not strict (smaps, pte_stats, MADV_COLD,
> > .. it can mean e.g. the statistic may be inaccurate or one less 2M chunk to
> > cold worst case), but some of them could have functional error without the
> > retry afaiu (e.g. pagemap, where we can have the output buffer shifted over
> > the unstable pmd range.. so IIUC the pagemap result can be wrong).
> >
> > While these call sites all look fine, and don't need any change:
> >
> > *** include/linux/pgtable.h:
> > pmd_devmap_trans_unstable[1418] return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
> > *** mm/gup.c:
> > follow_pmd_mask[695]           if (pmd_trans_unstable(pmd))
> > *** mm/mapping_dirty_helpers.c:
> > wp_clean_pmd_entry[131]        if (!pmd_trans_unstable(&pmdval))
> > *** mm/memory.c:
> > do_anonymous_page[4060]        if (unlikely(pmd_trans_unstable(vmf->pmd)))
> > *** mm/migrate_device.c:
> > migrate_vma_insert_page[616]   if (unlikely(pmd_trans_unstable(pmdp)))
> > *** mm/mincore.c:
> > mincore_pte_range[116]         if (pmd_trans_unstable(pmd)) {
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/proc/task_mmu.c  | 17 +++++++++++++----
> >  mm/madvise.c        |  8 ++++++--
> >  mm/memcontrol.c     |  8 ++++++--
> >  mm/memory-failure.c |  4 +++-
> >  mm/mempolicy.c      |  4 +++-
> >  5 files changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 6259dd432eeb..823eaba5c6bf 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -631,8 +631,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >                 goto out;
> >         }
> >
> > -       if (pmd_trans_unstable(pmd))
> > +       if (pmd_trans_unstable(pmd)) {
> > +               walk->action = ACTION_AGAIN;
> >                 goto out;
> > +       }
> > +
> >         /*
> >          * The mmap_lock held all the way back in m_start() is what
> >          * keeps khugepaged out of here and from collapsing things
> > @@ -1191,8 +1194,10 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
> >                 return 0;
> >         }
> >
> > -       if (pmd_trans_unstable(pmd))
> > +       if (pmd_trans_unstable(pmd)) {
> > +               walk->action = ACTION_AGAIN;
> >                 return 0;
> > +       }
> >
> >         pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> >         for (; addr != end; pte++, addr += PAGE_SIZE) {
> > @@ -1539,8 +1544,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
> >                 return err;
> >         }
> >
> > -       if (pmd_trans_unstable(pmdp))
> > +       if (pmd_trans_unstable(pmdp)) {
> > +               walk->action = ACTION_AGAIN;
> >                 return 0;
> 
> Had a quick look at the pagemap code, I agree with your analysis,
> "returning 0" may mess up pagemap, retry should be fine. But I'm
> wondering whether we should just fill in empty entries. Anyway I don't
> have a  strong opinion on this, just a little bit concerned by
> potential indefinite retry.

Yes, none pte is still an option.  But if we're going to fix this anyway,
it seems better to fix it with the accurate new thing that poped up, and
it's even less change (just apply walk->action rather than doing random
stuff in different call sites).

I see that you have worry on deadloop over this, so I hope to discuss
altogether here.

Unlike normal checks, pmd_trans_unstable() check means something must have
changed in the past very short period or it should just never if nothing
changed concurrently from under us, so it's not a "if (flag==true)" check
which is even more likely to loop.

If we see the places that I didn't touch, most of them suggested a retry in
one form or another.  So if there's a worry this will also not the first
time to do a retry (and for such a "unstable" API, that's really the most
natural thing to do which is to retry until it's stable).

So in general, it seems to me if we deadloop over pmd_trans_unstable() for
whatever reason then something more wrong could have happened..

Thanks,

-- 
Peter Xu

