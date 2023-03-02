Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD096A8CED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCBXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCBXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:22:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405859E58
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:21:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so4378417pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677799315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Umr5zRx7LZxoXNofPxvfrNl/FxEmafsnTcc+zwDql1Y=;
        b=bjVMOdcrNxLuBiLEEFaIZR1mK9cdnzdjwLURuJelQ3ERIrmgP2fukYOz8nwdnGsAnF
         JUJX3ta1SokzeqQUrlPbjL4RO1qRlfv5gOEekLKDIujED2QJcHbPHImJUY2FsIC03ObR
         j0tDp7MzEy8YA4v7eGx9k9nHT93n3YTsuxUwn4efxhFG3dPiVi2sAFevjDoCgMk0Xiaf
         pWuoVGDECCNV8IIwBNH5YQURCdONqPcr6f1V7aCxPzRqmEWGspwrwtUHKWH1qFXyPPlZ
         SUK4aPrIJebGQtlpWbUJ2+XH8tpCSom5TeJG6+FVwWXjJ2Q+boERTBI4Tz9yIaN3PXr2
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Umr5zRx7LZxoXNofPxvfrNl/FxEmafsnTcc+zwDql1Y=;
        b=6oRGoGstVd6eDzTRU5G8q0+m5JZsw8hypVNeAvYBXKlIdapWZNzELd5PWrSPFCFj9O
         74aCNftgMjproPIi8P9MfsRvb6hJPT2A3OVLA7z+XrsVTPO/ggAweeVnubFW/96tw7M7
         ujRQMegDIr3gs2D/EHyxL3Xv6UsoGDs1lk/JEbYaO4egCqaI6rvvTeOw3JHAhYNo//+X
         wdlINRnATEssR2okF4f/JlRGGaumu5/eaK0pDttLgg6t7e6XVu2wYVzzUNsriKirtcDO
         tBJ00RlUE9y0t9V4/j2p9fdzwsuEQ61p60qblli/gu3M0WIicAz85v47xSTOy+2KlKSv
         Izkg==
X-Gm-Message-State: AO0yUKXGRUZmhtvgxEgGZT/PX74O7Arpl/xopxOqp+nc+AhE40fVLAor
        Bpq4/liNDpAU1Gg1K+OiP88cXw==
X-Google-Smtp-Source: AK7set+hdJvu6FUSLpeOiGsfK3pztUXRbikU8bYd/VGaiU29pfxrCV9E0XIcb953CRcsnF/fFIqCBQ==
X-Received: by 2002:a17:903:6cb:b0:198:af50:e4e6 with SMTP id kj11-20020a17090306cb00b00198af50e4e6mr81056plb.12.1677799315123;
        Thu, 02 Mar 2023 15:21:55 -0800 (PST)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b9-20020a63d809000000b0050300a7c8c2sm183711pgh.89.2023.03.02.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:21:54 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:21:50 -0800
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Stevens <stevensd@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
Message-ID: <20230302232150.vvmszlrdzqm5ndjq@google.com>
References: <20230222195247.791227-1-peterx@redhat.com>
 <CAHbLzkp3PwpXir=YUuWmxpW5VXEba81UKb3YOyq+snKTZGjqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkp3PwpXir=YUuWmxpW5VXEba81UKb3YOyq+snKTZGjqDA@mail.gmail.com>
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

On Feb 22 14:53, Yang Shi wrote:
> On Wed, Feb 22, 2023 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > If memory charge failed, instead of returning the hpage but with an error,
> > allow the function to cleanup the folio properly, which is normally what a
> > function should do in this case - either return successfully, or return
> > with no side effect of partial runs with an indicated error.
> >
> > This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
> > with either anon or shmem path (even if it's safe to do so).
> 
> Thanks for the cleanup. Reviewed-by: Yang Shi <shy828301@gmail.com>
> 
> >
> > Cc: Yang Shi <shy828301@gmail.com>
> > Reviewed-by: David Stevens <stevensd@chromium.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v1->v2:
> > - Enhance commit message, drop "Fixes:" and "Cc: stable" tag, add R-bs.
> > ---
> >  mm/khugepaged.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 8dbc39896811..941d1c7ea910 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1063,12 +1063,19 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> >         gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
> >                      GFP_TRANSHUGE);
> >         int node = hpage_collapse_find_target_node(cc);
> > +       struct folio *folio;
> >
> >         if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
> >                 return SCAN_ALLOC_HUGE_PAGE_FAIL;
> > -       if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
> > +
> > +       folio = page_folio(*hpage);
> > +       if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
> > +               folio_put(folio);
> > +               *hpage = NULL;
> >                 return SCAN_CGROUP_CHARGE_FAIL;
> > +       }
> >         count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
> > +
> >         return SCAN_SUCCEED;
> >  }
> >
> > --
> > 2.39.1
> >
> 

Thanks, Peter.

Can we also get rid of the unnecessary mem_cgroup_uncharge() calls while we're
at it? Maybe this deserves a separate patch, but after Yang's cleanup of the
!NUMA case (where we would preallocate a hugepage) we can depend on put_page()
do take care of that for us.

Regardless, can have my

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
