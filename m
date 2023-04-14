Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5626E1FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDNJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDNJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:52:09 -0400
Received: from outbound-smtp02.blacknight.com (outbound-smtp02.blacknight.com [81.17.249.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9D72B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:52:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id A1D21BACB2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:52:05 +0100 (IST)
Received: (qmail 19672 invoked from network); 14 Apr 2023 09:52:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Apr 2023 09:52:05 -0000
Date:   Fri, 14 Apr 2023 10:52:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Assume huge tail pages are valid when
 allocating contiguous pages
Message-ID: <20230414095204.7fz6trkj5i4mzthz@techsingularity.net>
References: <20230414082222.idgw745cgcduzy37@techsingularity.net>
 <ZDkU6PuuDsUb82lr@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZDkU6PuuDsUb82lr@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:55:04AM +0200, Michal Hocko wrote:
> On Fri 14-04-23 09:22:22, Mel Gorman wrote:
> [...]
> > +
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
> > +		    !is_migrate_cma_page(page)) {
> > +			return false;
> 
> Is the CMA check working as expected?

I didn't test it as I don't have a good simulator for CMA contraints which
is still a mobile phone concern for devices like cameras.

> The function sounds quite generic
> and I agree that it would make sense if it was generic but it is used
> only for GB pages in fact and unless I am missing something it would
> allow to migrate CMA pages and potentially allocate over that region
> without any possibility to migrate GB page out so the CMA region would
> be essentially unusable for CMA users.

It's used primarily for 1G pages but does have other users (debugging
mostly, low priority). As it's advertised as a general API, I decided to
treat it as such and that meant being nice to CMA if possible. If CMA pages
migrate but can still use the target location then it should be fine. If a
CMA can migrate to an usable location that breaks a device then that's a bug.

> GB pages already have their CMA
> allocator path before we get to alloc_contig_pages. Or do I miss
> something?

I don't think you missed anything. The CMA check is, at best, an effort
to have a potentially useful semantic but it's very doubtful anyone will
notice or care. I'm perfectly happy just to drop the CMA check because it's a
straight-forward fix and more suitable as a -stable backport.  I'm also happy
to just go with a PageHuge check and ignore any possibility that a 2M page
could be migrated to satisfy a 1G allocation.  1G allocation requests after
significant uptime is a crapshoot at best and relying on them succeeding is
unwise. There is a non-zero possibility that the latency incurred migrating
2M pages and still failing a 1G allocation could itself be classed as a
bug with users preferring fast-failure of 1G allocation attempts.

-- 
Mel Gorman
SUSE Labs
