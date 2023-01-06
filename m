Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354C65F9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAFDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAFDHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:07:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1356142
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 19:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69E761583
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F9C433D2;
        Fri,  6 Jan 2023 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672974419;
        bh=T+DIgbx0TN06FPH+vlHy8WVMyBolsDeruztbB4dJxSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cXeVw7iowabcjhBfgLE1p17wdUYlLu1BgeVeQQ8UijZw7aI95QojB3rMCKd0tjW7Y
         WS3j63R9NOLu1FknBmCFXsF/VkCZEPzx0EcXBFtP3y3dhfWN+R/ebd8DqZaMkF3uO5
         eBRXwFJreXb5DVfS3fu2FD2CBr7qnyP0PJ/Y2LgI=
Date:   Thu, 5 Jan 2023 19:06:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
Subject: Re: [PATCH v2] mm: huge_memory: convert split_huge_pages_all() to
 use a folio
Message-Id: <20230105190658.f5d9a4bc9619ad6bec91a973@linux-foundation.org>
In-Reply-To: <fcc4116a-e4cd-9542-60a6-905a4968e6ca@huawei.com>
References: <20221230093020.9664-1-wangkefeng.wang@huawei.com>
        <20221230134535.240f49e0ad8bf6d82f8cc393@linux-foundation.org>
        <fcc4116a-e4cd-9542-60a6-905a4968e6ca@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 09:58:36 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2022/12/31 5:45, Andrew Morton wrote:
> > On Fri, 30 Dec 2022 17:30:20 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > 
> >> Straightforwardly convert split_huge_pages_all() to use a folio.
> >>
> >> ...
> >>
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
> >>   {
> >>   	struct zone *zone;
> >>   	struct page *page;
> >> +	struct folio *folio;
> >>   	unsigned long pfn, max_zone_pfn;
> >>   	unsigned long total = 0, split = 0;
> >>   
> >> @@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
> >>   			int nr_pages;
> >>   
> >>   			page = pfn_to_online_page(pfn);
> >> -			if (!page || !get_page_unless_zero(page))
> >> +			if (!page || PageTail(page))
> >> +				continue;
> >> +			folio = page_folio(page);
> >> +			if (!folio_try_get(folio))
> >>   				continue;
> >>   
> >> -			if (zone != page_zone(page))
> >> +			if (unlikely(page_folio(page) != folio))
> >> +				goto next;
> >> +
> >> +			if (zone != folio_zone(folio))
> >>   				goto next;
> > 
> > I'm still not understanding the above hunk.  Why is the
> > "page_folio(page) != folio" check added?  Should it be commented?
> 
> There is a comment in try_get_folio(), is it enough?

Nobody would think to look at a private function in gup.c.

I suggest this folio_try_get() rule be documented at the
folio_try_get() implementation site.

Most callers do perform this check, but not the ones in vmscan.c?
