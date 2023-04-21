Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92896EAA54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDUMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDUMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:25:35 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F28A53
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:25:11 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id A4E78FACCD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:25:09 +0100 (IST)
Received: (qmail 25223 invoked from network); 21 Apr 2023 12:25:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 12:25:09 -0000
Date:   Fri, 21 Apr 2023 13:25:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 01/26] block: bdev: blockdev page cache is movable
Message-ID: <20230421122504.pq76pj6hka2xdbpu@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-2-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:48PM -0400, Johannes Weiner wrote:
> While inspecting page blocks for the type of pages in them, I noticed
> a large number of blockdev cache in unmovable blocks. However, these
> pages are actually on the LRU, and their mapping has a .migrate_folio
> callback; they can be reclaimed and compacted as necessary.
> 
> Put them into movable blocks, so they don't cause pollution, and
> subsequent proliferation, of unmovable blocks.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Deserves to be split out and needs careful treatment. I don't recall exactly
but I believe I encountered a problem with these allocations in the very
distant past. Some of the allocations were movable and others weren't
or had very long lifetimes. Something like being superblock-related or
directory inodes being pinned for very long lengths of time. This is a
*long* time ago and the picture almost certainly has changed but it's
very possible that a high percentage, but not 100% of these allocations
are not movable in practice.

-- 
Mel Gorman
SUSE Labs
