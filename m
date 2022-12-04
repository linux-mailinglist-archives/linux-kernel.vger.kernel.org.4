Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224A641C10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLDJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLDJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:34:38 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD339D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:34:33 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 125so8518098vsi.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDZCPeHF38SRI2PhowrQk3SQC9N/a7ammpRRQqsEwNs=;
        b=AbRL9P6Qn3/xgQIx/pr3LG8cbkJVDfT9OVAUbK6KrzlboQqDcc5qDyhnDPrkt6l479
         6rRzZRyqU1Zjr9waeEtgH95w2xviLHF3x7b/3+9n7GZJkghEhGItfl4JBU2S3yMof1PM
         l9KrRyak1Z5nTAZsL+zcloajEUiDOTf8EJm5qoPrmDDyKJF1iwwojBjKm0wxkTy/aG3M
         Y2PpV2hwM/46KrZUUTf9iLgA6DcgX7p8dwjTIEI3v8H1W++FnQOVGWQqKNXvBO8lraGt
         +awKel+zwyFLh6+hxXcmHIMCL0DfwS+eqD46uh25JWEaEhjR3kdZLRDep073ioU5+Fys
         a5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDZCPeHF38SRI2PhowrQk3SQC9N/a7ammpRRQqsEwNs=;
        b=hC2hLvfLsJO6tO/iY5Equvfk0G6V+lZ61FXwgUpSZY5JIVITu6P7WEcDWuKK+dDznW
         jlD7bxRMCk9NexePyvOlNEuuIrMyTmzK6CGEOGIprHDJACf4MPMdNFIEHpDuPv4dB//i
         1TE0DMp+ozuPAnUod5p79Bzs27KdVXJlKPw3+7nw/sR6VThoNKzA2WR6PMkdTo2wns9H
         HHgPWuOUnyp1LswMtG6G7tJ35fWlDSo3g6ofNQQxYTTV3Bvhvf5Opi1p+rmrWBhXFtD4
         Ztk3ouvh/qRt3D5vzmq4XMxNmPX8PV+2Cr4iwUAnLAUiTbkyYMA+SRkkSDOkK0PrwTco
         nG3Q==
X-Gm-Message-State: ANoB5pl9Z3sQOVW6TPLaQof3uiC0rHxW4FI5rqYqgtkVj9hjpSRvdi5s
        4CcjDyKquk6VQQ38HDonbXOuTpG4wHbzkOl4hocQTUmG14z/UTPH
X-Google-Smtp-Source: AA0mqf6odUcczZRCsSLrEvyEneoIneIZ0eqanYuxkKWHUX3keeCnDUzxCsHAEQ+wk1zEFWUiilitWrSHk8Yh/i5MNC0=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr34388799vso.61.1670146472628; Sun, 04
 Dec 2022 01:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221203011120.2361610-1-almasrymina@google.com> <CAAPL-u_e7-4BT20Z9atTXFgeZSnGXWM2uX0r+2GrBqXk8RmX2Q@mail.gmail.com>
In-Reply-To: <CAAPL-u_e7-4BT20Z9atTXFgeZSnGXWM2uX0r+2GrBqXk8RmX2Q@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 4 Dec 2022 01:34:20 -0800
Message-ID: <CAHS8izMA2zaadio1ezXXW9vq1L16MwNkQxHv3HJgN=LU0n4Eug@mail.gmail.com>
Subject: Re: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 8:14 PM Wei Xu <weixugc@google.com> wrote:
>
> On Fri, Dec 2, 2022 at 5:11 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > to do, however, I suspect it introduced a regression in the behavior of
> > try_to_free_mem_cgroup_pages().
> >
> > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > of the cgroup should reduce by nr_pages. The callers expect
> > try_to_free_mem_cgroup_pages() to also return the number of pages
> > reclaimed, not demoted.
> >
> > However, what try_to_free_mem_cgroup_pages() actually does is it
> > unconditionally counts demoted pages as reclaimed pages. So in practice
> > when it is called it will often demote nr_pages and return the number of
> > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > and so I think try_to_free_mem_cgroup_pages() is not actually doing what
> > the callers want it to do.
> >
> > I suspect various things work suboptimally on memory systems or don't
> > work at all due to this:
> >
> > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> >   instead of lowering the memcg usage by nr_pages).
> > - try_charge_memcg() will keep retrying the charge while
> >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> >   making any room for the charge.
> > - memory.reclaim has a wonky interface. It advertises to the user it
> >   reclaims the provided amount but it will actually demote that amount.
> >
> > There may be more effects to this issue.
> >
> > To fix these issues I propose shrink_folio_list() to only count pages
> > demoted from inside of sc->nodemask to outside of sc->nodemask as
> > 'reclaimed'.
> >
> > For callers such as reclaim_high() or try_charge_memcg() that set
> > sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> > actually reclaim nr_pages and return the number of pages reclaimed. No
> > demoted pages would count towards the nr_pages requirement.
> >
> > For callers such as memory_reclaim() that set sc->nodemask,
> > try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> > with either reclaim or demotion.
> >
> > Tested this change using memory.reclaim interface. With this change,
> >
> >         echo "1m" > memory.reclaim
> >
> > Will cause freeing of 1m of memory from the cgroup regardless of the
> > demotions happening inside.
> >
> >         echo "1m nodes=0" > memory.reclaim
> >
> > Will cause freeing of 1m of node 0 by demotion if a demotion target is
> > available, and by reclaim if no demotion target is available.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > This is developed on top of mm-unstable largely because I need the
> > memory.reclaim nodes= arg to test it properly.
> > ---
> >  mm/vmscan.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 2b42ac9ad755..8f6e993b870d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >         LIST_HEAD(free_folios);
> >         LIST_HEAD(demote_folios);
> >         unsigned int nr_reclaimed = 0;
> > +       unsigned int nr_demoted = 0;
> >         unsigned int pgactivate = 0;
> >         bool do_demote_pass;
> >         struct swap_iocb *plug = NULL;
> > @@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >         /* 'folio_list' is always empty here */
> >
> >         /* Migrate folios selected for demotion */
> > -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> > +       nr_demoted = demote_folio_list(&demote_folios, pgdat);
> > +
> > +       /*
> > +        * Only count demoted folios as reclaimed if we demoted them from
> > +        * inside of the nodemask to outside of the nodemask, hence reclaiming
> > +        * pages in the nodemask.
> > +        */
> > +       if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
> > +           !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))
>
> next_demotion_node() is just the first demotion target node. Demotion
> can fall back to other allowed target nodes returned by
> node_get_allowed_targets().  When the page is demoted to a fallback
> node and this fallback node is in sc->nodemask, nr_demoted should not
> be added into nr_reclaimed, either.
>

Thanks for reviewing Wei, I did indeed miss this.

> One way to address this issue is to pass sc->nodemask into
> demote_folio_list() and exclude sc->nodemask from the allowed target
> demotion nodes.
>

This makes sense to me. Applied this change and uploaded v2:
https://lore.kernel.org/linux-mm/20221204093008.2620459-1-almasrymina@google.com/T/#u

> > +               nr_reclaimed += nr_demoted;
> > +
> >         /* Folios that could not be demoted are still in @demote_folios */
> >         if (!list_empty(&demote_folios)) {
> >                 /* Folios which weren't demoted go back on @folio_list */
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
