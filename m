Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFA6566E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiL0ChY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiL0ChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:37:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBDAF0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:37:19 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso16100678pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNTcuC/uMnLX3sHEs8cTcq592eiISwDTWsJLCh9JY8s=;
        b=ipYTU1VHHkMc/2Z723iIhWnbWXKGdoiEGlqGg821lKYKNKXm/iSlIMDM3PSNh4GfZC
         FYZDG4tPXOmPjK2RN11otymbDxPFd6XqrV1v+5eFwUFPjrtX03SwAnqL/nOFripGKMvS
         ri7F2AOwBqeBH+SiSGBJCp0sFqc5oa+toGhcPMslmZSHIgPimRhG/zgydZxXZw4vXSuQ
         D2/iIIP2/oubu2m9NN3uqgk5l1vDTCFxjfyzvxPS7TURG6X7FjUY/99DlZKn+nLlo1tl
         /p937Xve3RrRkWqawgxELSVb2tD0nswU2SPLOQe9Yuipys58Q8WtzQZksS89CsHGT3Qe
         ZfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNTcuC/uMnLX3sHEs8cTcq592eiISwDTWsJLCh9JY8s=;
        b=d3hi2kFkJ5IgfEc/Nk1AKUWSOajR0Pfpr6SNOiLoe3UbR0b5oLUhhdvt3CnH5hg4eC
         Roxeo++EA/BKEknBv5ZW/DUjsm9DZlMvQa7zFpX1yD1k4afB1BnW6QK+HS7ZlIFMJS7U
         GrVDtYLlnTWHpBIRf3uj4LJiTYvDnJlGHiB+gPw88rS8KFMd3bYQI1mbyuosF3tgUpWt
         7nIyPgm0/qR4jh/KF8OYJncn3Tjec1M4H0gII/F6T99fFT6JAop9GPdZfU4ejm/GuXlH
         mPTk+fAGjAhNX7gpE3sctpk8+rsKzFIIWB4e4vxaFrgCrg5I/8Si9G57dE5cJ6o5E2qg
         SvLg==
X-Gm-Message-State: AFqh2krpGi5VMmM3oO+ti2EX6vE89GFRjpTyPr83fvxNrpyJw513ALMH
        T5Dis9jxwJG8aXDqem5zEvY=
X-Google-Smtp-Source: AMrXdXv51Ha5eu6nVcy7J37wJ6My3h1JNeMoiYkvi2rsZ3j8RZ95WeibJVVMoFNoKmGuroeYo/8S0w==
X-Received: by 2002:a05:6a20:6f61:b0:9d:efd3:66f7 with SMTP id gu33-20020a056a206f6100b0009defd366f7mr19787678pzb.62.1672108639012;
        Mon, 26 Dec 2022 18:37:19 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id 31-20020a63145f000000b0047048c201e3sm6924997pgu.33.2022.12.26.18.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:37:18 -0800 (PST)
Date:   Tue, 27 Dec 2022 10:40:22 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Barry Song <baohua@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [PATCH v3 04/14] mm/rmap: Break COW PTE in rmap walking
Message-ID: <Y6pbFrngCMd9JpVr@archlinux.localdomain>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
 <20221220072743.3039060-5-shiyn.lin@gmail.com>
 <CAGsJ_4z+1n3cu35iyAiXz_W4_XCxW0PoHbo4CVnuJBEgDadQ0w@mail.gmail.com>
 <Y6l+f8hQD4C7iLEy@archlinux.localdomain>
 <CAGsJ_4z4OhDvuvMBKSB5i-rurwN=Ytu_M-ow8KPusC2hmU1rGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z4OhDvuvMBKSB5i-rurwN=Ytu_M-ow8KPusC2hmU1rGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 02:15:00PM +1300, Barry Song wrote:
> On Mon, Dec 26, 2022 at 11:56 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> >
> > On Mon, Dec 26, 2022 at 10:40:49PM +1300, Barry Song wrote:
> > > On Tue, Dec 20, 2022 at 8:25 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> > > >
> > > > Some of the features (unmap, migrate, device exclusive, mkclean, etc)
> > > > might modify the pte entry via rmap. Add a new page vma mapped walk
> > > > flag, PVMW_BREAK_COW_PTE, to indicate the rmap walking to break COW PTE.
> > > >
> > > > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > > > ---
> > > >  include/linux/rmap.h |  2 ++
> > > >  mm/migrate.c         |  3 ++-
> > > >  mm/page_vma_mapped.c |  2 ++
> > > >  mm/rmap.c            | 12 +++++++-----
> > > >  mm/vmscan.c          |  7 ++++++-
> > > >  5 files changed, 19 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > > index bd3504d11b155..d0f07e5519736 100644
> > > > --- a/include/linux/rmap.h
> > > > +++ b/include/linux/rmap.h
> > > > @@ -368,6 +368,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
> > > >  #define PVMW_SYNC              (1 << 0)
> > > >  /* Look for migration entries rather than present PTEs */
> > > >  #define PVMW_MIGRATION         (1 << 1)
> > > > +/* Break COW-ed PTE during walking */
> > > > +#define PVMW_BREAK_COW_PTE     (1 << 2)
> > > >
> > > >  struct page_vma_mapped_walk {
> > > >         unsigned long pfn;
> > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > index dff333593a8ae..a4be7e04c9b09 100644
> > > > --- a/mm/migrate.c
> > > > +++ b/mm/migrate.c
> > > > @@ -174,7 +174,8 @@ void putback_movable_pages(struct list_head *l)
> > > >  static bool remove_migration_pte(struct folio *folio,
> > > >                 struct vm_area_struct *vma, unsigned long addr, void *old)
> > > >  {
> > > > -       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> > > > +       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
> > > > +                             PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
> > > >
> > > >         while (page_vma_mapped_walk(&pvmw)) {
> > > >                 rmap_t rmap_flags = RMAP_NONE;
> > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > index 93e13fc17d3cb..5dfc9236dc505 100644
> > > > --- a/mm/page_vma_mapped.c
> > > > +++ b/mm/page_vma_mapped.c
> > > > @@ -251,6 +251,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > >                         step_forward(pvmw, PMD_SIZE);
> > > >                         continue;
> > > >                 }
> > > > +               if (pvmw->flags & PVMW_BREAK_COW_PTE)
> > > > +                       break_cow_pte(vma, pvmw->pmd, pvmw->address);
> > > >                 if (!map_pte(pvmw))
> > > >                         goto next_pte;
> > > >  this_pte:
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index 2ec925e5fa6a9..b1b7dcbd498be 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -807,7 +807,8 @@ static bool folio_referenced_one(struct folio *folio,
> > > >                 struct vm_area_struct *vma, unsigned long address, void *arg)
> > > >  {
> > > >         struct folio_referenced_arg *pra = arg;
> > > > -       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
> > > > +       /* it will clear the entry, so we should break COW PTE. */
> > > > +       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
> > >
> > > what do you mean by breaking cow pte? in memory reclamation case, we are only
> > > checking and clearing page referenced bit in pte, do we really need to
> > > break cow?
> >
> > Since we might clear page referenced bit, it will modify the write
> > protection shared page table (COW-ed PTE). We should duplicate it.
> >
> > Actually, I didn’t break COW at first because it will conditionally
> > modify the table and only clear the referenced bit.
> > So, if clearing page referenced bit is fine to the COW-ed PTE table
> > and the break COW PTE is unnecessary here, we can remove it.
> 
> if a page is mapped by 100 processes and anyone of these 100 processes
> access this page, we will get a reference bit in the PTE. Otherwise, we will
> have to scan 100 PTEs to figure out if a page is accessed and should be
> kept in LRU.
> i don't see the fundamental necessity to duplicate PTE only because of clearing
> the reference bit. as keeping the pte shared will help save a lot of cost for
> memory reclamation for those CPUs which have hardware reference bits
> in PTE.
> 

As I knew, if the page reference bit is unset and the accessed bit of
the pte entry is set, the reclamation will clear the accessed bit and
set the reference bit of the page.

So, for the such case with COW PTE, the logic is same as the normal PTE
one. It makes sense. Thanks for helping me to clear up the point.

Thanks,
Chih-En Lin
