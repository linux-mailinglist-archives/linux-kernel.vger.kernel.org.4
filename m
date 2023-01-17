Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B7670E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjARAab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjARA35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:29:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96EE5AA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 824B4B80B49
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F012AC433D2;
        Tue, 17 Jan 2023 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673999593;
        bh=JkKYkLGT09zMGz/urEeklXEdIEzXoMEAS8SRYneI7pQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVzk+tb+wA0d2mvDd8Qfs6s4SpJvISvjxCFtqL0V+scC2BpzoIiLzAINGsFT6VsX1
         zEoca97bWMkfTWcyJw5XbuWrJ7nL9JpcuZ5X7s47UJmTIPoJoNzfHsTohUTTCsdQKX
         RJ5suLIZG51xNBSNkukEpcIR/Fo9kmgwCRzd/xB0=
Date:   Tue, 17 Jan 2023 15:53:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged
 out
Message-Id: <20230117155312.5464d01c2d639b1ac44f9330@linux-foundation.org>
In-Reply-To: <20230117231632.2734737-1-minchan@kernel.org>
References: <20230117231632.2734737-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm all hung up on the naming of everything.

> mm: return the number of pages successfully paged out

This is a vague title - MM is a big place.  Perhaps "mm/vmscan: ..."

On Tue, 17 Jan 2023 15:16:30 -0800 Minchan Kim <minchan@kernel.org> wrote:

> The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> pages paged-out successfully, not only the number of reclaimed pages
> in the operation because those pages paged-out successfully will be
> reclaimed easily at the memory pressure due to asynchronous writeback
> rotation(i.e., PG_reclaim with folio_rotate_reclaimable).

So...  what does "paged out" actually mean?  "writeback to backing
store was initiated"?  From an application's point of view it means "no
longer in page tables needs a fault to get it back", no?

> This patch renames the reclaim_pages with paging_out(with hope that

"page_out" or "pageout" would be better than "paging_out".

> it's clear from operation point of view) and then adds a additional
> stat in reclaim_stat to represent the number of paged-out but kept
> in the memory for rotation on writeback completion.

So it's the number of pages against which we have initiated writeback. 
Why not call it "nr_writeback" or similar?

> With that stat, madvise_pageout can know how many pages were paged-out
> successfully as well as reclaimed. The return value will be used for
> statistics in next patch.
> 
> ...
>
> -unsigned long reclaim_pages(struct list_head *folio_list)
> +/*
> + * paging_out - reclaim clean pages and write dirty pages into storage
> + * @folio_list: pages for paging out
> + *
> + * paging_out() writes dirty pages to backing storage and/or reclaim
> + * clean pages from memory. Returns the number of written/reclaimed pages.

s/reclaim/reclaims/

"and/or" it vague - just "or", I think.

"written/reclaimed" is vague.  "number of reclaimed pages plus the
number of pages against which writeback was initiated" is precise.


