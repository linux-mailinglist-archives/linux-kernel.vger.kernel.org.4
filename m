Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF88614B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKANCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKANCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:02:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF45A1B78B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D+EHaa8ZSYWQyKEwd8VdI1NfdyRq/w+zeq0C4XjaijY=; b=dGk5R5sFoqExlKZ8WUCieZp2hc
        NWvrUA/VaQdoDBYD66Et+Zpo8U0qH8f3TjU5hseQQkuAWGOSD/RSTzTsAJeTrjc9wlEhJTphAWrZx
        VeSzNDNUtTXLbAVqseGT1IiS3GrR/mBxNH+GVGMfuhmdASGnm76T2PaxlIoyEofP4GR34rb8NYhWc
        7ZovRyfq5W3r20xRQaZ0WePuZnBJNZyLdsjAEU8ZfTCkJJ9ZrxwMNVjsLcAMqG76x93GZilG3IMTn
        0EY+jORidC1nHjFfiYYyYbxzFXnahxMQMS5nm20TqeiJGkBFXZWkQCCQnuqwytv/C7pCvhK2Y3pCE
        Sg4ziqtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opqul-004cil-2D; Tue, 01 Nov 2022 13:02:47 +0000
Date:   Tue, 1 Nov 2022 13:02:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC 2/2] migrate: convert migrate_pages() to use folios
Message-ID: <Y2EY9zK0phgfQYE1@casper.infradead.org>
References: <20221101062137.83649-1-ying.huang@intel.com>
 <20221101062137.83649-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101062137.83649-3-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:21:37PM +0800, Huang Ying wrote:
> -			is_thp = PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages = compound_nr(page);
> +			is_large = folio_test_large(folio) && !PageHuge(&folio->page);

We have folio_test_hugetlb() to replace PageHuge().

>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>  	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
> -			       nr_thp_failed, nr_thp_split, mode, reason);
> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_large_succeeded);
> +	count_vm_events(THP_MIGRATION_FAIL, nr_large_failed);
> +	count_vm_events(THP_MIGRATION_SPLIT, nr_split);
> +	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_large_succeeded,
> +			       nr_large_failed, nr_split, mode, reason);

I think this is the biggest question with this patch -- how (or whether)
to account folios in size between PMD and PTE size.  Since it's
_called_ THP, I've tended to make the statistics conditional on
folio_test_pmd_mappable() rather than simply being folio_test_large().
