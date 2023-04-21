Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA786EAE54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDUPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:55:30 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FEC125BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:55:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id 31FA3FACA5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:55:26 +0100 (IST)
Received: (qmail 16126 invoked from network); 21 Apr 2023 15:55:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 15:55:25 -0000
Date:   Fri, 21 Apr 2023 16:55:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 25/26] mm: page_alloc: disallow fallbacks when 2M
 defrag is enabled
Message-ID: <20230421155523.p4qqx23xpwlm3yt4@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-26-hannes@cmpxchg.org>
 <20230421145657.fnpjqkuyquy3z24t@techsingularity.net>
 <20230421152448.GD320347@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230421152448.GD320347@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:24:48AM -0400, Johannes Weiner wrote:
> On Fri, Apr 21, 2023 at 03:56:57PM +0100, Mel Gorman wrote:
> > On Tue, Apr 18, 2023 at 03:13:12PM -0400, Johannes Weiner wrote:
> > > Fallbacks are already unlikely due to watermarks being enforced
> > > against MIGRATE_FREE blocks. Eliminate them altogether. This allows
> > > compaction to look exclusively at movable blocks, reducing the number
> > > of pageblocks it needs to scan on an ongoing basis.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Conceptually this could be fun if a GFP_NOFS allocation cannot migrate
> > enough memory to free one pageblock and there are no pageblocks
> > available of the correct migratetype. Fallbacks might be unlikely but
> > never being able to fallback is a livelock risk, no?
> 
> The reserves below the watermarks are maintained in neutral
> MIGRATE_FREE blocks. So just like today, critical/limited allocation
> contexts are ensured forward progress as long as there are reserves.
> 
> An argument could be made that because smaller orders type-claim the
> entire neutral block on allocation now, the reserves can deplete
> faster than they do today given comparable watermarks. I haven't run
> into this issue during testing that would have me raise the reserves
> by a factor of NR_MIGRATETYPES. But something to keep an eye out for.

Also bear in mind low memory systems, not even the embedded ones, just
things like a cheap laptop with <= 1G. I haven't consulted the code to
think this through but forcing watermarks to be in multiples of pageblock
could be get trickier the smaller the memory size is and it would have
to be considered what happens when min_free_kbytes for a zone is smaller
than pageblock*MIGRATE_TYPES. It's possible it's protected, or could be
protected, by page_group_by_mobility_disabled but that only applies for
very small systems.

-- 
Mel Gorman
SUSE Labs
