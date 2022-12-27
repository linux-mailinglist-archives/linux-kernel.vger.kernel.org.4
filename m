Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81A656661
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 02:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiL0BPU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Dec 2022 20:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0BPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 20:15:14 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63492AFB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:15:12 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id k4so7358004vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 17:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faex0xXiRDvF8rchFxpPffM5E3POPyWTY89h33AM+l8=;
        b=3kpA/Yy9XpFl3MJ6pc9Xt4JjND5AZJA5Ae0270/10Te3wR/NCUooyTAgPBmcKmDOUl
         1CE4FRiNqaG7pqMHZZZhvkt1BLBXpFv9VpP5EP7DTkiBTXORPB0rNnYfCUuG9ofZVWCb
         ntX+u4p4q5v6aJqdi9gZqkrzK+XhpLTeteOnm2P+Mqx5Tt+CLlXcrqNK0/5ucfTrzdjY
         0FuAZBuUmQvJ39WbCDSGfkghNHG3bjcckgNay+yC7jfX98gpSVxe9HKqW5F55Ou5lroe
         nB4UozkWCxC9yHftr+0GGf+R0xKiz+P4pamBju+QODhVI6TpxeBbE4CxJXPk1k2rciKn
         azww==
X-Gm-Message-State: AFqh2kpM3G923R4WfTMoQU85Mf/P24tsMweLBB45fnUvifT9Q1IarlD9
        PEZcCIBimUm9bShcsEZTN7kqBIywrgRC7TGoiD0=
X-Google-Smtp-Source: AMrXdXsQEoNQdqXvggV9K83MAN604+y4o++hGoLdu4UK/xbTxgUY12EmSg5+JRaPKpHDfpovBIvHnqe8LoSMBmvPVWs=
X-Received: by 2002:a05:6102:1041:b0:3c6:2426:2210 with SMTP id
 h1-20020a056102104100b003c624262210mr936689vsq.86.1672103711801; Mon, 26 Dec
 2022 17:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20221220072743.3039060-1-shiyn.lin@gmail.com> <20221220072743.3039060-5-shiyn.lin@gmail.com>
 <CAGsJ_4z+1n3cu35iyAiXz_W4_XCxW0PoHbo4CVnuJBEgDadQ0w@mail.gmail.com> <Y6l+f8hQD4C7iLEy@archlinux.localdomain>
In-Reply-To: <Y6l+f8hQD4C7iLEy@archlinux.localdomain>
From:   Barry Song <baohua@kernel.org>
Date:   Tue, 27 Dec 2022 14:15:00 +1300
Message-ID: <CAGsJ_4z4OhDvuvMBKSB5i-rurwN=Ytu_M-ow8KPusC2hmU1rGA@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] mm/rmap: Break COW PTE in rmap walking
To:     Chih-En Lin <shiyn.lin@gmail.com>
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
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 11:56 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
>
> On Mon, Dec 26, 2022 at 10:40:49PM +1300, Barry Song wrote:
> > On Tue, Dec 20, 2022 at 8:25 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> > >
> > > Some of the features (unmap, migrate, device exclusive, mkclean, etc)
> > > might modify the pte entry via rmap. Add a new page vma mapped walk
> > > flag, PVMW_BREAK_COW_PTE, to indicate the rmap walking to break COW PTE.
> > >
> > > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > > ---
> > >  include/linux/rmap.h |  2 ++
> > >  mm/migrate.c         |  3 ++-
> > >  mm/page_vma_mapped.c |  2 ++
> > >  mm/rmap.c            | 12 +++++++-----
> > >  mm/vmscan.c          |  7 ++++++-
> > >  5 files changed, 19 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > index bd3504d11b155..d0f07e5519736 100644
> > > --- a/include/linux/rmap.h
> > > +++ b/include/linux/rmap.h
> > > @@ -368,6 +368,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
> > >  #define PVMW_SYNC              (1 << 0)
> > >  /* Look for migration entries rather than present PTEs */
> > >  #define PVMW_MIGRATION         (1 << 1)
> > > +/* Break COW-ed PTE during walking */
> > > +#define PVMW_BREAK_COW_PTE     (1 << 2)
> > >
> > >  struct page_vma_mapped_walk {
> > >         unsigned long pfn;
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index dff333593a8ae..a4be7e04c9b09 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -174,7 +174,8 @@ void putback_movable_pages(struct list_head *l)
> > >  static bool remove_migration_pte(struct folio *folio,
> > >                 struct vm_area_struct *vma, unsigned long addr, void *old)
> > >  {
> > > -       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> > > +       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
> > > +                             PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
> > >
> > >         while (page_vma_mapped_walk(&pvmw)) {
> > >                 rmap_t rmap_flags = RMAP_NONE;
> > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > index 93e13fc17d3cb..5dfc9236dc505 100644
> > > --- a/mm/page_vma_mapped.c
> > > +++ b/mm/page_vma_mapped.c
> > > @@ -251,6 +251,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > >                         step_forward(pvmw, PMD_SIZE);
> > >                         continue;
> > >                 }
> > > +               if (pvmw->flags & PVMW_BREAK_COW_PTE)
> > > +                       break_cow_pte(vma, pvmw->pmd, pvmw->address);
> > >                 if (!map_pte(pvmw))
> > >                         goto next_pte;
> > >  this_pte:
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 2ec925e5fa6a9..b1b7dcbd498be 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -807,7 +807,8 @@ static bool folio_referenced_one(struct folio *folio,
> > >                 struct vm_area_struct *vma, unsigned long address, void *arg)
> > >  {
> > >         struct folio_referenced_arg *pra = arg;
> > > -       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
> > > +       /* it will clear the entry, so we should break COW PTE. */
> > > +       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
> >
> > what do you mean by breaking cow pte? in memory reclamation case, we are only
> > checking and clearing page referenced bit in pte, do we really need to
> > break cow?
>
> Since we might clear page referenced bit, it will modify the write
> protection shared page table (COW-ed PTE). We should duplicate it.
>
> Actually, I didn’t break COW at first because it will conditionally
> modify the table and only clear the referenced bit.
> So, if clearing page referenced bit is fine to the COW-ed PTE table
> and the break COW PTE is unnecessary here, we can remove it.

if a page is mapped by 100 processes and anyone of these 100 processes
access this page, we will get a reference bit in the PTE. Otherwise, we will
have to scan 100 PTEs to figure out if a page is accessed and should be
kept in LRU.
i don't see the fundamental necessity to duplicate PTE only because of clearing
the reference bit. as keeping the pte shared will help save a lot of cost for
memory reclamation for those CPUs which have hardware reference bits
in PTE.

>
> Thanks,
> Chih-En Lin

Thanks
barry
