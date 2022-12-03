Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DEA641411
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLCEOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 23:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLCEOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 23:14:41 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969EFE5AB1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 20:14:38 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c15so6636890pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 20:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8Lb4rWO2/png7jFWUlCrnlSu3DLF81AvaOseRvPiQo=;
        b=DK7gt55uCo6/h51m7XjhVUqJ6E0Hs1bMl1kZpwZsi021a8/WQEhvds1UH95TxlnQLL
         HiIC9DLb/Q5gyrtpLTu3s/U1NtfoG81WACqKRnbf2L7VKjVm3wuC8tynzlI3Ywaj5hiK
         Vl6NDwBNDYa1attFWgejzmcGLKwmTZJDFC5GFHXLL0STk2vWoo/pxggTq41Llot1cBm8
         cOc1k6zJsZD6KfyrItvjsziLEwnUrFv6Dm2N9/aLyag5VifY2PoMwtK6AZMLiYWBeLOi
         qmMtoKc0+FJKxkO+f9n+FQFDRU2lqhxbeBcmJartPvBBc4yfofz/mm+4N56cgI5WxOZI
         k0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8Lb4rWO2/png7jFWUlCrnlSu3DLF81AvaOseRvPiQo=;
        b=kKtta3uqLGpYSYbaOQfY2xw7MG3IP9yjvMD2pl9M+Q4i4XrQ02UYawtWsEAULftIKg
         CKpZ8KTapqx6O+yj2IQbV+owB435k/ZP68SBtcRV8ag+8jr79OQOf6dHpWtDTvaRsj5R
         QO83o5VZ3OsRgQdUgGqRzJBg54fJER+ZtDvHOx74DW+DrzIy5U/TjPgGG3xy4QCooUBu
         HQGmuK7Ie1qbzkDO3Oy0y94KbrdK23S4pMS6EgiSBGUEHZnH4CpG90DKY6EEx0bPvqCm
         yHIfn0tYxJafdrlAUndt6iWlhkHMq+TDPZauolptPtfjm9Rdcijfin04ZnSAIJ58MwsV
         iI7Q==
X-Gm-Message-State: ANoB5pmDiow+lUSSJUS0P34CRBuJaJp8hdtOzgorcZ1UC7bSeRX/4Yps
        2rGDm7HQCdXQu4zSyEV6C5Bq9eUJ3uzgXkHP/jM04w==
X-Google-Smtp-Source: AA0mqf7HjcQjConev4/hT9HMwqftbCr9qTzOUrXfBmX9z/iV7ni8AiEWoMPW5n8bPUrF9QR5LPc04/T0lmcPn1KXSmY=
X-Received: by 2002:a63:1b52:0:b0:476:cba9:eba4 with SMTP id
 b18-20020a631b52000000b00476cba9eba4mr51182014pgm.350.1670040877782; Fri, 02
 Dec 2022 20:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20221203011120.2361610-1-almasrymina@google.com>
In-Reply-To: <20221203011120.2361610-1-almasrymina@google.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 2 Dec 2022 20:14:25 -0800
Message-ID: <CAAPL-u_e7-4BT20Z9atTXFgeZSnGXWM2uX0r+2GrBqXk8RmX2Q@mail.gmail.com>
Subject: Re: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     Mina Almasry <almasrymina@google.com>
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

On Fri, Dec 2, 2022 at 5:11 PM Mina Almasry <almasrymina@google.com> wrote:
>
> commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim"") enabled demotion in memcg reclaim, which is the right thing
> to do, however, I suspect it introduced a regression in the behavior of
> try_to_free_mem_cgroup_pages().
>
> The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> of the cgroup should reduce by nr_pages. The callers expect
> try_to_free_mem_cgroup_pages() to also return the number of pages
> reclaimed, not demoted.
>
> However, what try_to_free_mem_cgroup_pages() actually does is it
> unconditionally counts demoted pages as reclaimed pages. So in practice
> when it is called it will often demote nr_pages and return the number of
> demoted pages to the caller. Demoted pages don't lower the memcg usage,
> and so I think try_to_free_mem_cgroup_pages() is not actually doing what
> the callers want it to do.
>
> I suspect various things work suboptimally on memory systems or don't
> work at all due to this:
>
> - memory.high enforcement likely doesn't work (it just demotes nr_pages
>   instead of lowering the memcg usage by nr_pages).
> - try_charge_memcg() will keep retrying the charge while
>   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>   making any room for the charge.
> - memory.reclaim has a wonky interface. It advertises to the user it
>   reclaims the provided amount but it will actually demote that amount.
>
> There may be more effects to this issue.
>
> To fix these issues I propose shrink_folio_list() to only count pages
> demoted from inside of sc->nodemask to outside of sc->nodemask as
> 'reclaimed'.
>
> For callers such as reclaim_high() or try_charge_memcg() that set
> sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> actually reclaim nr_pages and return the number of pages reclaimed. No
> demoted pages would count towards the nr_pages requirement.
>
> For callers such as memory_reclaim() that set sc->nodemask,
> try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> with either reclaim or demotion.
>
> Tested this change using memory.reclaim interface. With this change,
>
>         echo "1m" > memory.reclaim
>
> Will cause freeing of 1m of memory from the cgroup regardless of the
> demotions happening inside.
>
>         echo "1m nodes=0" > memory.reclaim
>
> Will cause freeing of 1m of node 0 by demotion if a demotion target is
> available, and by reclaim if no demotion target is available.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> This is developed on top of mm-unstable largely because I need the
> memory.reclaim nodes= arg to test it properly.
> ---
>  mm/vmscan.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2b42ac9ad755..8f6e993b870d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>         LIST_HEAD(free_folios);
>         LIST_HEAD(demote_folios);
>         unsigned int nr_reclaimed = 0;
> +       unsigned int nr_demoted = 0;
>         unsigned int pgactivate = 0;
>         bool do_demote_pass;
>         struct swap_iocb *plug = NULL;
> @@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>         /* 'folio_list' is always empty here */
>
>         /* Migrate folios selected for demotion */
> -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> +       nr_demoted = demote_folio_list(&demote_folios, pgdat);
> +
> +       /*
> +        * Only count demoted folios as reclaimed if we demoted them from
> +        * inside of the nodemask to outside of the nodemask, hence reclaiming
> +        * pages in the nodemask.
> +        */
> +       if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
> +           !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))

next_demotion_node() is just the first demotion target node. Demotion
can fall back to other allowed target nodes returned by
node_get_allowed_targets().  When the page is demoted to a fallback
node and this fallback node is in sc->nodemask, nr_demoted should not
be added into nr_reclaimed, either.

One way to address this issue is to pass sc->nodemask into
demote_folio_list() and exclude sc->nodemask from the allowed target
demotion nodes.

> +               nr_reclaimed += nr_demoted;
> +
>         /* Folios that could not be demoted are still in @demote_folios */
>         if (!list_empty(&demote_folios)) {
>                 /* Folios which weren't demoted go back on @folio_list */
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
