Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0A6EACCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjDUOZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjDUOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:25:47 -0400
Received: from outbound-smtp17.blacknight.com (outbound-smtp17.blacknight.com [46.22.139.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCDD19B2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:25:37 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 876811C3F8B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:25:36 +0100 (IST)
Received: (qmail 13269 invoked from network); 21 Apr 2023 14:25:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 14:25:36 -0000
Date:   Fri, 21 Apr 2023 15:25:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 11/26] mm: page_alloc: introduce MIGRATE_FREE
Message-ID: <20230421142533.nm44wkmh3wkudlqn@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-12-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-12-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:58PM -0400, Johannes Weiner wrote:
> To cut down on type mixing, put empty pageblocks on separate freelists
> and make them the first fallback preference before stealing space from
> incompatible blocks.
> 
> The neutral block designation will also be handy in subsequent patches
> that: simplify compaction; add per-mt freelist counts and make
> compaction_suitable() more precise; and ultimately make pageblocks the
> basis of free memory management.
> 

This patch is a line in the sand for the series. Patches 1-10 can stand
alone with supporting data because this is the first major change that
has a material impact on fragmentation avoidance and its overhead.

Maybe there is something in the later patches that makes the need for this
patch more obvious but putting the empty pageblocks on separate freelists
is not that helpful in itself. The main problem is that __rmqueue() starts
with __rmqueue_smallest which for huge pages is probably fine because
it searches first for free pageblocks, but it's not for SLUB high-order
allocations because __rmqueue_smallest for orders < pageblock_order
encourages mixing. Obviously it would also not be fine for contiguous page
allocations for page cache or anything else that is planned. If nothing
else, this patch highlights that fragmentation avoidance was originally
focused on huge pages which was fine at the time, but not any longer.

The need for MIGRATE_FREE type could potentially be avoided by having
__rmqueue() start with __rmqueue_smallest(order == pageblock_order) to
encourage full block usage first before mixing.

-- 
Mel Gorman
SUSE Labs
