Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0AC67887F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjAWUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:39:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4D2203A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y19zn3yu+yzaqVrjSeUjhkJu+C2eSsJkC4MKVOBZlg4=; b=DFdmJyQOPH93neKJmgAjK7Vtdg
        Hm01CQfW4phK4moeagY3UemX5v00YhX5Vb1bKrqJhoYG+sBYH1zRmIa9+fzbD7s9ONt110GZ+GWru
        eJ6BjcR4NBAkiEX/3VSSV3jyWcKAuRK5h5T29rpqIpHTIxOcn84xFDUfYXjAcfo8RRsVp9ewrCbWL
        ZDnw9SasjlzEovIrNidRlpUuNZtLGtOtrdGYizkUUfsSAw0h2u5NUa6scJROAS9zBJdhLzK8e0fpO
        6dXVupel69dQBHcgeRo33xF2psWijAu7/VmaicCr5DvgJgbbmOVn8ubG9FO5vDAmq9EdjNY8i6bjY
        VsKbVDYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK3Zn-004Vl0-3t; Mon, 23 Jan 2023 20:37:59 +0000
Date:   Mon, 23 Jan 2023 20:37:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de
Subject: Re: [PATCH 1/2] mm/memory_hotplug: remove head page reference in
 do_migrate_range
Message-ID: <Y87wJ6ERhdujjo6P@casper.infradead.org>
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:23:46PM -0800, Sidhartha Kumar wrote:
> @@ -1637,14 +1637,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			continue;
>  		page = pfn_to_page(pfn);
>  		folio = page_folio(page);
> -		head = &folio->page;
>  
> -		if (PageHuge(page)) {
> -			pfn = page_to_pfn(head) + compound_nr(head) - 1;
> +		if (folio_test_hugetlb(folio)) {
> +			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
>  			isolate_hugetlb(folio, &source);
>  			continue;
> -		} else if (PageTransHuge(page))
> -			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
> +		} else if (folio_test_transhuge(folio))
> +			pfn = folio_pfn(folio) + thp_nr_pages(page) - 1;

I'm pretty sure those two lines should be...

		} else if (folio_test_large(folio))
			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;

But, erm ... we're doing this before we have a refcount on the page,
right?  So this is unsafe because the page might change which folio
it is in.  And the folio we found earlier might become a tail page
of a different folio.  (As the comment below explains, HWPoison pages
won't, so it's not unsafe for them).

Also, thp_nr_pages(page) is going to return 1 for tail pages.  So this
is a noop, unless page is a head page.

It's all a bit confusing, and being memory-hotplug, it's not well
tested.  More thought needed.
