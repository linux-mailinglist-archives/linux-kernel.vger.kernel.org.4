Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD50672C8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjFLOl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjFLOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:41:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7EBE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3HQW4PKlH1HusP+FajQ9wyjam/OsW2rojrIuXgqtbYs=; b=cjPdsxz2FS7Erv2rgoBvEEZcwB
        VkPI3+3uIZ4lOe7mwGc5AftfwiY4ps793EzOC/E3mpmeXI6SQhEryuBNtqquCYI/nQJqdzOFDy0sQ
        OgW36gzzgUm6bH4zNb51Yks8Hd4ywzAN3CyRn88RRsG2YgV/R2oRdEyvaDDZmZwyYU4c8atNB6DRa
        4HyhyCu5OxHhWCKdK95rzX5xjtl5712K9DVD9HZ6qD5BtH2jbKCkUU+UucSYKm/fxHY21TayBJnK2
        XmkbEpyjjswd7KptaQl94PBMeX2srJf6zKU2AUWZ3R9yIGcgtNCQdjTm9qdS08MgcyKL/0EJc2Ifg
        KiE2trfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ijI-002jGU-FS; Mon, 12 Jun 2023 14:41:12 +0000
Date:   Mon, 12 Jun 2023 15:41:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jgowans@amazon.com, yuzhao@google.com
Subject: Re: [PATCH -next 1/2] mm: compaction: convert to use a folio in
 isolate_migratepages_block()
Message-ID: <ZIcuiHIXsIXKHGFH@casper.infradead.org>
References: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:34:13PM +0800, Kefeng Wang wrote:
> @@ -959,7 +960,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				 * Hugepage was successfully isolated and placed
>  				 * on the cc->migratepages list.
>  				 */
> -				low_pfn += compound_nr(page) - 1;
> +				folio = page_folio(page);
> +				low_pfn += folio_nr_pages(folio) - 1;
>  				goto isolate_success_no_list;

Why is this safe?  That is, how do we know that the folio can't be
dissolved under us at this point, then reallocated and hit the
VM_BUG_ON_PGFLAGS(PageTail(page), page) in folio_flags() when we
test folio_test_large()?

> @@ -1132,30 +1137,30 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			 * and it's on LRU. It can only be a THP so the order
>  			 * is safe to read and it's 0 for tail pages.
>  			 */

^^^ This comment needs to be updated too.

> -		mod_node_page_state(page_pgdat(page),
> -				NR_ISOLATED_ANON + page_is_file_lru(page),
> -				thp_nr_pages(page));
> +		lruvec_del_folio(lruvec, folio);
> +		mod_node_page_state(folio_pgdat(folio),
> +				NR_ISOLATED_ANON + folio_is_file_lru(folio),
> +				folio_nr_pages(folio));

		node_stat_mod_folio()

