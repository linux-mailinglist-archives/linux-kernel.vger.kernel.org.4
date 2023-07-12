Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA6750277
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjGLJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjGLJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:05:42 -0400
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA510C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:05:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id F41711B15
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:05:27 +0100 (IST)
Received: (qmail 12686 invoked from network); 12 Jul 2023 09:05:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jul 2023 09:05:27 -0000
Date:   Wed, 12 Jul 2023 10:05:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Message-ID: <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-3-ying.huang@intel.com>
 <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:19:46PM +0200, Michal Hocko wrote:
> On Mon 10-07-23 14:53:25, Huang Ying wrote:
> > To auto-tune PCP high for each CPU automatically, an
> > allocation/freeing depth based PCP high auto-tuning algorithm is
> > implemented in this patch.
> > 
> > The basic idea behind the algorithm is to detect the repetitive
> > allocation and freeing pattern with short enough period (about 1
> > second).  The period needs to be short to respond to allocation and
> > freeing pattern changes quickly and control the memory wasted by
> > unnecessary caching.
> 
> 1s is an ethernity from the allocation POV. Is a time based sampling
> really a good choice? I would have expected a natural allocation/freeing
> feedback mechanism. I.e. double the batch size when the batch is
> consumed and it requires to be refilled and shrink it under memory
> pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
> high over batch (e.g. twice as much).  Have you considered something as
> simple as that?
> Quite honestly I am not sure time based approach is a good choice
> because memory consumptions tends to be quite bulky (e.g. application
> starts or workload transitions based on requests).
>  

I tend to agree. Tuning based on the recent allocation pattern without frees
would make more sense and also be symmetric with how free_factor works. I
suspect that time-based may be heavily orientated around the will-it-scale
benchmark. While I only glanced at this, a few things jumped out

1. Time-based heuristics are not ideal. congestion_wait() and
   friends was an obvious case where time-based heuristics fell apart even
   before the event it waited on was removed. For congestion, it happened to
   work for slow storage for a while but that was about it.  For allocation
   stream detection, it has a similar problem. If a process is allocating
   heavily, then fine, if it's in bursts of less than a second more than one
   second apart then it will not adapt. While I do not think it is explicitly
   mentioned anywhere, my understanding was that heuristics like this within
   mm/ should be driven by explicit events as much as possible and not time.

2. If time was to be used, it would be cheaper to have the simpliest possible
   state tracking in the fast paths and decay any resizing of the PCP
   within the vmstat updates (reuse pcp->expire except it applies to local
   pcps). Even this is less than ideal as the PCP may be too large for short
   periods of time but it may also act as a backstop for worst-case behaviour

3. free_factor is an existing mechanism for detecting recent patterns
   and adapting the PCP sizes. The allocation side should be symmetric
   and the events that should drive it are "refills" on the alloc side and
   "drains" on the free side. Initially it might be easier to have a single
   parameter that scales batch and high up to a limit

4. The amount of state tracked seems excessive and increases the size of
   the per-cpu structure by more than 1 cache line. That in itself may not
   be a problem but the state is tracked on every page alloc/free that goes
   through the fast path and it's relatively complex to track.  That is
   a constant penalty in fast paths that may not may not be relevant to the
   workload and only sustained bursty allocation streams may offset the
   cost.

5. Memory pressure and reclaim activity does not appear to be accounted
   for and it's not clear if pcp->high is bounded or if it's possible for
   a single PCP to hide a large number of pages from other CPUs sharing the
   same node. The max size of the PCP should probably be explicitly clamped.

-- 
Mel Gorman
SUSE Labs
