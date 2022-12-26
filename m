Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9C656206
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiLZK5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:57:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D62707
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:57:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o2so4872044pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MinmLA/kgWz3YQeRKMJgWvVcWJZLlwFfkbh4JSkqKw=;
        b=LUZTNzfwEKtgiXHDxz5OgOqUwygAV8MHk35XN8JUIM3jFwSJzWSvoR36CRe7GB14/y
         w/8mBlChUVOOoL+843guNcAKf9+DxHhUR3tMloOsPjkY/lfdvT1scdDiLSPBfwcpeJ25
         XbTK2Wpto8BEqQ8VFfnWBIiNJUzW3TOF1kvEv0ujB2Lta5+SSMXKmZ3vVhRHK3n4Rm1y
         1kPInj7LuS2TbVLOf8e8RZR7+eYG2zxzRgtQM2xraAYsCEIbmKlGMy3Mg8SaN+afMWmn
         uRjyxbF/XKRENcCs6mAbew4TD0xPi++2UrxLRZmklLCVQOQswSlenyd0smjroNmA1ABO
         BXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MinmLA/kgWz3YQeRKMJgWvVcWJZLlwFfkbh4JSkqKw=;
        b=U1W1nBcAhhv4TKl53xzjIYf3J7QHiMXRN0goAAaD3yX/DnxdTec2kXHxoiTTIboI4R
         XEWPMjKL78FV2bW2JaPKavnUQYFVwME/4GexRQDHeFqA1S73+XBRqcPn77ImDCxrFXx9
         5wm+hzKDiUlepHjo7t/GLqD7ilF+AGCMA2Z0zapg9OY/9++Q8/XehghOVudGv7WmoH8X
         3cXvqam/PZG+HOaDyrba9wk9sTITvg5SPF08UsonWItcgIT4BdIxQWzgAWYdd2oduqxe
         FK+jlmipN9zuccFZyvYupMYoUanUUsZDbEtFPeK6whCvd3hVn3yr3rPyljMw3HL/h5Q4
         obFw==
X-Gm-Message-State: AFqh2kpPHwpmQ9gNyhfnYAdnzCIqFpBSlw6ytxGjf7ClsS5YGAbsCqBS
        DGdcffF3VB1j2o4GmhTkCw4=
X-Google-Smtp-Source: AMrXdXvvbzPtmZMYkpWoHX5FkmOsBGx91ChrffHzm/6/Y8uefQNJ9rjU78ENUrUSx+RawVoR03n+zA==
X-Received: by 2002:a17:902:e74c:b0:189:dd98:b96b with SMTP id p12-20020a170902e74c00b00189dd98b96bmr27764859plf.22.1672052167405;
        Mon, 26 Dec 2022 02:56:07 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b00186b69157ecsm6825510plb.202.2022.12.26.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 02:56:06 -0800 (PST)
Date:   Mon, 26 Dec 2022 18:59:11 +0800
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
Message-ID: <Y6l+f8hQD4C7iLEy@archlinux.localdomain>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
 <20221220072743.3039060-5-shiyn.lin@gmail.com>
 <CAGsJ_4z+1n3cu35iyAiXz_W4_XCxW0PoHbo4CVnuJBEgDadQ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z+1n3cu35iyAiXz_W4_XCxW0PoHbo4CVnuJBEgDadQ0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 10:40:49PM +1300, Barry Song wrote:
> On Tue, Dec 20, 2022 at 8:25 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> >
> > Some of the features (unmap, migrate, device exclusive, mkclean, etc)
> > might modify the pte entry via rmap. Add a new page vma mapped walk
> > flag, PVMW_BREAK_COW_PTE, to indicate the rmap walking to break COW PTE.
> >
> > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > ---
> >  include/linux/rmap.h |  2 ++
> >  mm/migrate.c         |  3 ++-
> >  mm/page_vma_mapped.c |  2 ++
> >  mm/rmap.c            | 12 +++++++-----
> >  mm/vmscan.c          |  7 ++++++-
> >  5 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index bd3504d11b155..d0f07e5519736 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -368,6 +368,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
> >  #define PVMW_SYNC              (1 << 0)
> >  /* Look for migration entries rather than present PTEs */
> >  #define PVMW_MIGRATION         (1 << 1)
> > +/* Break COW-ed PTE during walking */
> > +#define PVMW_BREAK_COW_PTE     (1 << 2)
> >
> >  struct page_vma_mapped_walk {
> >         unsigned long pfn;
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index dff333593a8ae..a4be7e04c9b09 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -174,7 +174,8 @@ void putback_movable_pages(struct list_head *l)
> >  static bool remove_migration_pte(struct folio *folio,
> >                 struct vm_area_struct *vma, unsigned long addr, void *old)
> >  {
> > -       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> > +       DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
> > +                             PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
> >
> >         while (page_vma_mapped_walk(&pvmw)) {
> >                 rmap_t rmap_flags = RMAP_NONE;
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 93e13fc17d3cb..5dfc9236dc505 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -251,6 +251,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >                         step_forward(pvmw, PMD_SIZE);
> >                         continue;
> >                 }
> > +               if (pvmw->flags & PVMW_BREAK_COW_PTE)
> > +                       break_cow_pte(vma, pvmw->pmd, pvmw->address);
> >                 if (!map_pte(pvmw))
> >                         goto next_pte;
> >  this_pte:
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 2ec925e5fa6a9..b1b7dcbd498be 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -807,7 +807,8 @@ static bool folio_referenced_one(struct folio *folio,
> >                 struct vm_area_struct *vma, unsigned long address, void *arg)
> >  {
> >         struct folio_referenced_arg *pra = arg;
> > -       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
> > +       /* it will clear the entry, so we should break COW PTE. */
> > +       DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
> 
> what do you mean by breaking cow pte? in memory reclamation case, we are only
> checking and clearing page referenced bit in pte, do we really need to
> break cow?

Since we might clear page referenced bit, it will modify the write
protection shared page table (COW-ed PTE). We should duplicate it.

Actually, I didn’t break COW at first because it will conditionally
modify the table and only clear the referenced bit.
So, if clearing page referenced bit is fine to the COW-ed PTE table
and the break COW PTE is unnecessary here, we can remove it.

Thanks,
Chih-En Lin
