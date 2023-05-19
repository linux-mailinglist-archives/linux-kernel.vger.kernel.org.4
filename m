Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8191970A242
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjESV6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjESV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DFB8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 14:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B887C65B84
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF268C433A1;
        Fri, 19 May 2023 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684533521;
        bh=oCbDdhFhZLLpaNqY9AE/8ZrSUZ7fcnTJYFt7L3KQehA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ONcgq/h8P77NYbRZPX9lTflhIXuz5oO+GZWxEjnRdciUA+nXLKCANdGj1b/Lz0jdN
         wQ2FiAftiC2mj+3hP5IZ5YEwbCK1N4UjL5FalkEICZkWgd0kKXYNv3USAMrFQYxNjC
         /g4RqdryR9EfNHuob/KbbE6RxZc1kXHowLCe1ntA=
Date:   Fri, 19 May 2023 14:58:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [Resend PATCHv2] mm: skip CMA pages when they are not available
Message-Id: <20230519145839.3b5193e6accf3b13fd619a07@linux-foundation.org>
In-Reply-To: <CAGWkznFVeCYUCXg4JZ78pjXp9gBUWAUzyGntVT+kkPRydxmS6A@mail.gmail.com>
References: <1684143495-12872-1-git-send-email-zhaoyang.huang@unisoc.com>
        <CAGWkznFVeCYUCXg4JZ78pjXp9gBUWAUzyGntVT+kkPRydxmS6A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 16:41:41 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> any comments?

Have any of the regular CMA developers commented on a version of this?


I have a couple of little complaints:

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..19fb445 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>         unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>         unsigned long skipped = 0;
>         unsigned long scan, total_scan, nr_pages;
> +       bool cma_cap = true;
> +       struct page *page;
>         LIST_HEAD(folios_skipped);
>
>         total_scan = 0;
>         scan = 0;
> +       if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> +               && (gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE))
> +               cma_cap = false;
> +

A code comment above this alteration would be good.  Tell the reader
why we're doing this.


>         while (scan < nr_to_scan && !list_empty(src)) {
>                 struct list_head *move_to = src;
>                 struct folio *folio;
> @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>                 nr_pages = folio_nr_pages(folio);
>                 total_scan += nr_pages;
>
> -               if (folio_zonenum(folio) > sc->reclaim_idx) {
> +               page = &folio->page;
> +
> +               if ((folio_zonenum(folio) > sc->reclaim_idx)
> +#ifdef CONFIG_CMA
> +                       || (get_pageblock_migratetype(page) == MIGRATE_CMA && !cma_cap)
> +#endif
> +               ) {
>                         nr_skipped[folio_zonenum(folio)] += nr_pages;
>                         move_to = &folios_skipped;
>                         goto move;
>                 }

That's pretty ugly.  Can we use IS_ENABLED(CONFIG_CMA) here to avoid
the ifdef?

