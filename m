Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAA6E2443
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNN3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:29:49 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637108A41
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:29:44 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id AD9591C3FC5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:29:42 +0100 (IST)
Received: (qmail 17515 invoked from network); 14 Apr 2023 13:29:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Apr 2023 13:29:42 -0000
Date:   Fri, 14 Apr 2023 14:29:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20230414132940.chjmsuiurnygajxs@techsingularity.net>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
 <ZDlFbkwfmePEewXM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZDlFbkwfmePEewXM@casper.infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:22:06PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 09:22:22AM +0100, Mel Gorman wrote:
> > +		/*
> > +		 * Do not migrate huge pages that span the size of the region
> > +		 * being allocated contiguous. e.g. Do not migrate a 1G page
> > +		 * for a 1G allocation request. CMA is an exception as the
> > +		 * region may be reserved for hardware that requires physical
> > +		 * memory without a MMU or scatter/gather capability.
> > +		 *
> > +		 * Note that the compound check is race-prone versus
> > +		 * free/split/collapse but it should be safe and result in
> > +		 * a premature skip or a useless migration attempt.
> > +		 */
> > +		if (PageHuge(page) && compound_nr(page) >= nr_pages &&
> 
> This confuses me.  PageHuge() can be called on tail pages, but if
> compound_nr() is called on a tail page, it returns 1. 

Given the calling context is a linear scan, the head page will be scanned
first so the value for compound_nr() called on a tail page shouldn't occur.

> So I'm not
> sure why this works.  Also, do you really want PageHuge (ie only
> hugetlbfs pages), or do you really just want to check PageCompound(),
> which would also be true for THP?
> 

For now I only want hugetlbfs pages as the fix is for a regression when
allocating 1G hugetlbfs pages and previous behaviour avoided existing
hugetlbfs pages. THP pages can be split+migrated of course but the cost
of the 1G allocation attempt may be excessive relative to any benefit.

-- 
Mel Gorman
SUSE Labs
