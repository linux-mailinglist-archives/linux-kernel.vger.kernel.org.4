Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348C06EAC93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjDUOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDUOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:14:59 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2179B2106
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:14:51 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id A27CBFA739
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:14:49 +0100 (IST)
Received: (qmail 14279 invoked from network); 21 Apr 2023 14:14:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 14:14:49 -0000
Date:   Fri, 21 Apr 2023 15:14:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 10/26] mm: page_alloc: allow compaction capturing
 from larger blocks
Message-ID: <20230421141447.2cw5cfwibb7jxf6n@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-11-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-11-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:57PM -0400, Johannes Weiner wrote:
> Currently, capturing only works on matching orders and matching
> migratetypes. However, if capturing is initially skipped on the
> migratetype, it's possible that merging continues up to a full
> pageblock, in which case the migratetype is up for grabs again.
> 
> Allow capturing to grab smaller chunks from claimed pageblocks, and
> expand the remainder of the block back onto the freelists.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

No objections other than we're still in the preparation phase and the
series needs to be split. Out of curiousity, how often does this actually
trigger in practice? I ask because superficially, I would expect capture to
happen while pages are being merged and I'm not sure how much this actually
helps. If anything the anomaly would be merging !MOVABLE types, capturing
one pageblock and leaving the adjacent block eligible for splitting as
UNMOVABLE/RECLAIMABLE which is not necessarily desirable.

I nagged about the splitting already but ideally there would be supporting
data for all the incremental improvements before a major modification is made
to fragmentation avoidance. That way, even if the fragmentation avoidance
changes have side-effects, the incremental changes stand alone.

-- 
Mel Gorman
SUSE Labs
