Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191206EAEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDUQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjDUQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:03:25 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1BE61
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:03:24 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id AA4731C3D0F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:03:22 +0100 (IST)
Received: (qmail 14677 invoked from network); 21 Apr 2023 16:03:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 16:03:22 -0000
Date:   Fri, 21 Apr 2023 17:03:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 12/26] mm: page_alloc: per-migratetype free counts
Message-ID: <20230421160320.zz2he2iprq37vnl3@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-13-hannes@cmpxchg.org>
 <20230421142841.parju3gmqmpefigq@techsingularity.net>
 <20230421153501.GE320347@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230421153501.GE320347@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:35:01AM -0400, Johannes Weiner wrote:
> On Fri, Apr 21, 2023 at 03:28:41PM +0100, Mel Gorman wrote:
> > On Tue, Apr 18, 2023 at 03:12:59PM -0400, Johannes Weiner wrote:
> > > Increase visibility into the defragmentation behavior by tracking and
> > > reporting per-migratetype free counters.
> > > 
> > > Subsequent patches will also use those counters to make more targeted
> > > reclaim/compaction decisions.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Visibility into fragmentation behaviour is information that is
> > almost certainly only useful to a developer and even then, there is
> > /proc/pagetypeinfo. At minimum, move this patch to later in the series
> > but I'm skeptical about its benefit.
> 
> Having them available in the memory dump (OOM, sysrq) was essential
> while debugging problems in later patches. For OOMs or lockups,
> pagetypeinfo isn't available. It would be useful to have them included
> in user reports if any issues pop up.
> 

OOM+sysrq could optionally take the very expensive step of traversing the
lists to get the count so yes, it helps debugging, but not necessarily
critical.

> They're used internally in several places later on, too.
> 

I did see that for deciding the suitability for compaction. Minimally, put
the patches adjacent in the series and later if possible so that the series
can be taken in parts. There are a lot of patches that should be relatively
uncontroversial so maybe make "mm: page_alloc: introduce MIGRATE_FREE" the
pivot point between incremental improvements and "everything on and after
this patch is relatively high risk, could excessively compact/reclaim,
could livelock etc".

-- 
Mel Gorman
SUSE Labs
