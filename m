Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C960C6EAAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjDUMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjDUMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:47:50 -0400
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892E71B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:47:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 12AAB1FC1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:47:47 +0100 (IST)
Received: (qmail 20574 invoked from network); 21 Apr 2023 12:47:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:47:46 -0000
Date:   Fri, 21 Apr 2023 13:47:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 05/26] mm: page_alloc: per-migratetype pcplist for
 THPs
Message-ID: <20230421124744.skrxvziwg3bx7rgt@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-6-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-6-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:52PM -0400, Johannes Weiner wrote:
> Right now, there is only one pcplist for THP allocations. However,
> while most THPs are movable, the huge zero page is not. This means a
> movable THP allocation can grab an unmovable block from the pcplist,
> and a subsequent THP split, partial free, and reallocation of the
> remainder will mix movable and unmovable pages in the block.
> 
> While this isn't a huge source of block pollution in practice, it
> happens often enough to trigger debug warnings fairly quickly under
> load. In the interest of tightening up pageblock hygiene, make the THP
> pcplists fully migratetype-aware, just like the lower order ones.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Split out :P

Take special care of this one because, while I didn't check this, I
suspect it'll push the PCP structure size into the next cache line and
increase overhead.

The changelog makes it unclear why exactly this happens or why the
patch fixes it. The huge zero page strips GFP_MOVABLE (so unmovable)
but at allocation time, it doesn't really matter what the movable type
is because it's a full pageblock. It doesn't appear to be a hazard until
the split happens. Assuming that's the case, it should be ok to always
set the pageblock movable for THP allocations regardless of GFP flags at
allocation time or else set the pageblock MOVABLE at THP split (always
MOVABLE at allocation time makes more sense).

-- 
Mel Gorman
SUSE Labs
