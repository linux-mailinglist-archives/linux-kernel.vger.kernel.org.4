Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01E66B69F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjAPEfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjAPEfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:35:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C945F65BC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 20:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6X5H5b4mTEHtRm79YlcNwUJw2vmgwvvxhyKoNWNRjmk=; b=IHzhB2qAPOkPwlxaUbIKJeX+AV
        QXSYncECDy0NAaJ6A4CrkRL5zdeBBP8vyJu1Bf6q157ve+igyBCIcibGfkOik+hzMckBwA1mVtk9f
        g674es2LWE9nhBvJ3fGgQurXz9XALqnecx8VgaMGCKntm9cvxRv15DUeAqPLhsvrUi8aS+k5cW3Lt
        YZ9yUzerZUw5tbXQ7TGb80ENjP4B18cHdQ9KQ19qziHAh4ICj29iFbboRUfRJc3JHObIvBNxtVKFU
        RyWDQcjC+Bj9ZneCe/nxRVLHNiObF3IAsbKX2lMzZVM7A0mskU4zQQw8ViYZiloFj/COlG3tYeKZU
        +0gL3GWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHHDX-008QM0-L6; Mon, 16 Jan 2023 04:35:31 +0000
Date:   Mon, 16 Jan 2023 04:35:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
Message-ID: <Y8TUE3h/IJySDn11@casper.infradead.org>
References: <20230110075327.590514-1-ying.huang@intel.com>
 <Y74WsWCFGh2wFGji@monkey>
 <Y782h7t10uRVW0RC@monkey>
 <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y79tTXgEeuzzqFho@monkey>
 <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y8ChvzGVG5Tm9tQQ@monkey>
 <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:42:08AM +0800, Huang, Ying wrote:
> +++ b/mm/migrate.c
> @@ -1187,10 +1187,13 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>  	int rc;
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
> +	bool is_lru = !__PageMovable(&src->page);
>  
>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>  
>  	rc = move_to_new_folio(dst, src, mode);
> +	if (!unlikely(is_lru))
> +		goto out_unlock_both;

This reads a little awkwardly.  Could it be:

	if (likely(!is_lru))

... but honestly, I think the polarity here is wrong.  LRU pages tend to
outnumber !LRU pages, so shouldn't this be:

	if (unlikely(!is_lru)) {

just like it is in migrate_folio_unmap()?

