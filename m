Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9740C6EAA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjDUMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDUMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:37:23 -0400
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B4193
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:37:22 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id F1603FACC5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:37:20 +0100 (IST)
Received: (qmail 23836 invoked from network); 21 Apr 2023 12:37:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:37:20 -0000
Date:   Fri, 21 Apr 2023 13:37:19 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 03/26] mm: make pageblock_order 2M per default
Message-ID: <20230421123719.w7tufd6asqdpxcf3@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-4-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:50PM -0400, Johannes Weiner wrote:
> pageblock_order can be of various sizes, depending on configuration,
> but the default is MAX_ORDER-1. Given 4k pages, that comes out to
> 4M. This is a large chunk for the allocator/reclaim/compaction to try
> to keep grouped per migratetype. It's also unnecessary as the majority
> of higher order allocations - THP and slab - are smaller than that.
> 
> Before subsequent patches increase the effort that goes into
> maintaining migratetype isolation, it's important to first set the
> defrag block size to what's likely to have common consumers.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

This patch may be a distraction in the context of this series. I don't feel
particularly strongly about it but it has strong bikeshed potential. For
configurations that support huge pages of any sort, it should be PMD_ORDER,
for anything else the choice is arbitrary. 2M is as good a guess as
anyway because even if it was tied to the PAGE_ALLOC_COSTLY_ORDER then
the pageblock bitmap overhead might be annoying.

-- 
Mel Gorman
SUSE Labs
