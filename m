Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E36EAC98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjDUORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDUORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:20 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8DB93DE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:17:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef38864360so20415591cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682086637; x=1684678637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijNYMVjlbJrZCaV78UXYGLc3DOZur5hhO7MmLiMh8Og=;
        b=1MoarXjdhobUU86WqZanZo18cI5xugUCVCqCEndho+J97fcXVGnhQG4rpqItWwBKRE
         pnu+PQ1Q+g5aCGhrqqbN5imC4WEXG17/s9M9M1lNc9awQfYxSMpHDXHoj9hCKtfITqpY
         E8RzhCarbtSuTtlLFKq54rQmN+WoH2JcWT3Ys7slP0oU4QXGXYvCMTTsmlXH/reFlB4Y
         S7IR/cWPx9kH+LvSEeM6TfB/5lq2Ep+r02xYaxh4H5g6mTmSBmlfg5KpOt1ql8xpyAYy
         Pq6HQhvtSGzjNcjlGkkQhm5MjHI0Ik8kd/LO8Wo5fdGOm1SPO0R/ZKjEhr98JR8g9uFa
         0nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086637; x=1684678637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijNYMVjlbJrZCaV78UXYGLc3DOZur5hhO7MmLiMh8Og=;
        b=aN1zJzTzc970+fSqoljV+lsll+YTQ3nZ9GPKkSxd422d9oQsW9PqkwWMcBaQF8GxEu
         +74sd8DKGypXJFv2oE5EP4Jd3ksdj8Epy+8NPwKBiClrJOcjHk4uh5c6Fzuf8x3IBCUS
         IVJV+M9Za5lQnYX7AYD9H5bRoqKCOsn3mgW8w+5cTRgwY7OBlPCjXCuzWXLb7aQJwztB
         OpmXRE+3FOYuBux3WO84B6ioZV5g1lVie+tWVanvuNrGzFz63cX8oX6p2QCAPb7jVwny
         Ws5wyGQ8v3pk6NwjkvbuOdm7JDKPp95uLhTR0guImJyBUUvgsRIW+QfGU+1TG3bRQVVm
         DgDw==
X-Gm-Message-State: AAQBX9dzFp0IIaMadJD3wiNnmWC+/tPj25UWcD+LX5xXGq1LdMJGRJyk
        C7zxi7B4sXJ7eqYa36zf9GmWyA==
X-Google-Smtp-Source: AKy350YR+XIBm2Qr27pDAHIa3M+HB+PNKY0FDb8TOcQDtECfUzFoFsx0E+crk5sbOnQvyLyT3L1deg==
X-Received: by 2002:ac8:5a15:0:b0:3e1:90e4:c20 with SMTP id n21-20020ac85a15000000b003e190e40c20mr9052657qta.66.1682086636949;
        Fri, 21 Apr 2023 07:17:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id l13-20020a05622a050d00b003ef38277445sm1354605qtx.16.2023.04.21.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:17:16 -0700 (PDT)
Date:   Fri, 21 Apr 2023 10:17:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 02/26] mm: compaction: avoid GFP_NOFS deadlocks
Message-ID: <20230421141715.GA320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-3-hannes@cmpxchg.org>
 <20230421122743.d7xfvzyhiunbphh3@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421122743.d7xfvzyhiunbphh3@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:27:43PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:49PM -0400, Johannes Weiner wrote:
> > During stress testing, two deadlock scenarios were observed:
> > 
> > 1. One GFP_NOFS allocation was sleeping on too_many_isolated(), and
> >    all CPUs were busy with compactors that appeared to be spinning on
> >    buffer locks.
> > 
> >    Give GFP_NOFS compactors additional isolation headroom, the same
> >    way we do during reclaim, to eliminate this deadlock scenario.
> > 
> > 2. In a more pernicious scenario, the GFP_NOFS allocation was
> >    busy-spinning in compaction, but seemingly never making
> >    progress. Upon closer inspection, memory was dominated by file
> >    pages, which the fs compactor isn't allowed to touch. The remaining
> >    anon pages didn't have the contiguity to satisfy the request.
> > 
> >    Allow GFP_NOFS allocations to bypass watermarks when compaction
> >    failed at the highest priority.
> > 
> > While these deadlocks were encountered only in tests with the
> > subsequent patches (which put a lot more demand on compaction), in
> > theory these problems already exist in the code today. Fix them now.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Definitely needs to be split out.

Will do.

> >  mm/compaction.c | 15 +++++++++++++--
> >  mm/page_alloc.c | 10 +++++++++-
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 8238e83385a7..84db84e8fd3a 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -745,8 +745,9 @@ isolate_freepages_range(struct compact_control *cc,
> >  }
> >  
> >  /* Similar to reclaim, but different enough that they don't share logic */
> > -static bool too_many_isolated(pg_data_t *pgdat)
> > +static bool too_many_isolated(struct compact_control *cc)
> >  {
> > +	pg_data_t *pgdat = cc->zone->zone_pgdat;
> >  	bool too_many;
> >  
> >  	unsigned long active, inactive, isolated;
> > @@ -758,6 +759,16 @@ static bool too_many_isolated(pg_data_t *pgdat)
> >  	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
> >  			node_page_state(pgdat, NR_ISOLATED_ANON);
> >  
> > +	/*
> > +	 * GFP_NOFS callers are allowed to isolate more pages, so they
> > +	 * won't get blocked by normal direct-reclaimers, forming a
> > +	 * circular deadlock. GFP_NOIO won't get here.
> > +	 */
> > +	if (cc->gfp_mask & __GFP_FS) {
> > +		inactive >>= 3;
> > +		active >>= 3;
> > +	}
> > +
> 
> This comment needs to explain why GFP_NOFS gets special treatment
> explaning that a GFP_NOFS context may not be able to migrate pages and
> why.

Fair point, I'll expand on that.

> As a follow-up, if GFP_NOFS cannot deal with the majority of the
> migration contexts then it should bail out of compaction entirely. The
> changelog doesn't say why but maybe SYNC_LIGHT is the issue?

It's this condition in isolate_migratepages_block():

		/*
		 * Only allow to migrate anonymous pages in GFP_NOFS context
		 * because those do not depend on fs locks.
		 */
		if (!(cc->gfp_mask & __GFP_FS) && mapping)
			goto isolate_fail_put;

In terms of bailing even earlier: We do have per-zone file and anon
counts that could be consulted. However, the real problem is
interleaving of anon and file. Even if only 10% of the zone is anon,
it could still be worth trying to compact if they're relatively
contiguous. OTOH 50% anon could be uncompactable if every block also
contains at least one file. We don't know until we actually scan. I'm
hesitant to give allocations premature access to the last reserves.

What might work is for NOFS contexts to test if anon is low up front
and shortcutting directly to the highest priority (SYNC_FULL). One
good faith scan attempt at least before touching the reserves.
