Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5252D64F7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 05:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLQE4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 23:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLQE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 23:56:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639740807
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HNBvGcqXcWq+3AAYbJatmTxzCpFZhSTTEH3kZBldKRk=; b=HT0Ah9m2HWt9/79RcWQoTS44Yh
        jPIVoCsfrNoXelxm9k2DHCigiLm0vWPQV7Y3I2lio1Q2alC47WCgUhppGnE9zK10zGcfBPj/3O4Km
        DGm82gmAGv9di/0dQla9ZtJkfIcJ6YJTMuY8SAAZ7UZaoaH9WAISBLi6vWqdF7GedcvAHHlMcA6SC
        hRx1IB+ONdM7kUUBd6qArE/ao5tjayPnFtaI7Qdi/RI5oSR/imdfmwrsnJVh/lv2donWwB6SkHosZ
        HqEWwwjJQxWIkKkUwXIyEO+7SeUzPzYN4mBV1sJ/c3TOFZuTs+h4Sut+oRHLHmgnlfgIjy7THE/Ue
        EeGfuDBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6PEx-00GFDv-J2; Sat, 17 Dec 2022 04:56:03 +0000
Date:   Sat, 17 Dec 2022 04:56:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <Y51L496TjNuiSxsG@casper.infradead.org>
References: <20221217001554.554913-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217001554.554913-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 12:15:54AM +0000, Lorenzo Stoakes wrote:
> This function is not referenced anywhere else in the kernel, remove it.

I think we're waiting to see if any users show up.  It's only been 18
months or so, so perhaps wait a little longer?

Also, if we do get rid of this, then __alloc_pages_bulk() can lose
the "list" argument.

> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/gfp.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 65a78773dcca..67c5164f4758 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -188,13 +188,6 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
>  				unsigned long nr_pages,
>  				struct page **page_array);
>  
> -/* Bulk allocate order-0 pages */
> -static inline unsigned long
> -alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
> -{
> -	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, list, NULL);
> -}
> -
>  static inline unsigned long
>  alloc_pages_bulk_array(gfp_t gfp, unsigned long nr_pages, struct page **page_array)
>  {
> -- 
> 2.38.1
> 
