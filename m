Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A166EAD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjDUOhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjDUOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:37:07 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5A213FA6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:36:57 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 7A3DC1C3F8E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:36:56 +0100 (IST)
Received: (qmail 15405 invoked from network); 21 Apr 2023 14:36:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Apr 2023 14:36:56 -0000
Date:   Fri, 21 Apr 2023 15:36:54 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 14/26] mm: compaction: simplify should_compact_retry()
Message-ID: <20230421143654.g6ta3kd6ea7fsmp6@techsingularity.net>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-15-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-15-hannes@cmpxchg.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:13:01PM -0400, Johannes Weiner wrote:
> The different branches for retry are unnecessarily complicated. There
> is really only three outcomes: progress, skipped, failed. Also, the
> retry counter only applies to loops that made progress, move it there.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 60 +++++++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c3b7dc479936..18fa2bbba44b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4608,7 +4608,6 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
>  {
> -	int max_retries = MAX_COMPACT_RETRIES;
>  	int min_priority;
>  	bool ret = false;
>  	int retries = *compaction_retries;

Think this breaks build because of trace_compact_retry and max_retries is
declared in a different scope on the next hunk.

Again, move this to a preparation series. I didn't actually think about
this patch at all because I'm trying to reach the main purpose of the series
and it's now late on a Friday so I'll probably fail or forget by Monday.

-- 
Mel Gorman
SUSE Labs
