Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFB56E230D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDNMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDNMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:22:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4CAF29
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kI6nWz/7mbrcqeoJObTAkGI/5raHVgMAa8wusj6R28s=; b=gmdxaxKHu6YQRudBx7W+CuJ2hM
        ciCileYCHTMdFMQHi5KdFyyA6uKga4aBGYnNb6kKq9jas6amiJzAXViiOuFamzkj0jYf3MRqNMvX7
        +r/ok3cmhkgy+1VUCGUWTjF3Mol5OXGsU9/gLgr/pWozRQg2RHrWAjZoNJAI/vaDLDuS7Got8hxI2
        4tjGZFE6gqhrwH3j8k+43SbGtpDQL64FENw3DVMDctLFtZQQuJMbRP70iFBHurrXKnvYeKY/UvRYZ
        8sDb0DFF+1EUpIKtRUCaC/qSjBjktFS4BgTu3I6VCWMeLbGua6sEnzSHNnbv2zjb7AgT1rl3ZOpiR
        /k7JZATw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnIRK-008jnq-MY; Fri, 14 Apr 2023 12:22:07 +0000
Date:   Fri, 14 Apr 2023 13:22:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <ZDlFbkwfmePEewXM@casper.infradead.org>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082222.idgw745cgcduzy37@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:22:22AM +0100, Mel Gorman wrote:
> +		/*
> +		 * Do not migrate huge pages that span the size of the region
> +		 * being allocated contiguous. e.g. Do not migrate a 1G page
> +		 * for a 1G allocation request. CMA is an exception as the
> +		 * region may be reserved for hardware that requires physical
> +		 * memory without a MMU or scatter/gather capability.
> +		 *
> +		 * Note that the compound check is race-prone versus
> +		 * free/split/collapse but it should be safe and result in
> +		 * a premature skip or a useless migration attempt.
> +		 */
> +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&

This confuses me.  PageHuge() can be called on tail pages, but if
compound_nr() is called on a tail page, it returns 1.  So I'm not
sure why this works.  Also, do you really want PageHuge (ie only
hugetlbfs pages), or do you really just want to check PageCompound(),
which would also be true for THP?

