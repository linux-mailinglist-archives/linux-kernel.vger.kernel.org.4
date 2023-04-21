Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045976EADB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjDUPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDUPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:06:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F1A257
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:06:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74e1aec175eso109269885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682089609; x=1684681609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIAJWB5J2B8K78m9oI7khqky/22dVLaQfbFsBbxztKQ=;
        b=iJevz6cEXq3yi/2Ws0fGvIgtnolydo04XXjfQDLcp6sC2QIPSBjxB8fOuY3VZ+3C8Y
         5myNoUtu9r2OvWThTxM8+M8g9XobkLBd3CEUSpAYLUDR8WHgBBY2UoRlWydMUQZdoxDp
         izWJcA08AvdEYJnRBaUih6DfAS/X9OQhsFoRIq0hq4DnAcBY3zCEM2tB4Ds8AAUiHXht
         PeJKfe81CEtMJ35Rhji2ZxdV5zzvPbOUiCWp57GRbs8QEPP9K/CieYhaiFqTz0IYDYma
         6LfwJIuPLRErC+nqSqsjMP/O23MSljEDqm9RLS3koXks5B40//c31qAgvqvXyffQmwhP
         do4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089609; x=1684681609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIAJWB5J2B8K78m9oI7khqky/22dVLaQfbFsBbxztKQ=;
        b=AcWMwkQsZozi31YbSDLE2N7pQDEegyYIR0EEM1VbfcijQfX60HSQa8k/pzO9prV9SJ
         vgIt/SRYr269XeMAO1hN/SIooMnPoPhNYdzNdPKqQxMUPtiE2kqujfZ0AZpy+1hCHN3Z
         kXePVRinjGcxNu28pcqF8xfrFfiCpTwecKvXh3zXlJsMD52a/fLGYC4UdGGHz7nN8nzD
         mQ8id/bqxzStAd/MXopvKqDD3Qz1C/OHUM7iauAWfR0rtesfh853D50lV0Lt9RHslNZO
         dJHY3Hk02dcP1BK+BV6g5pDuvs/4NpUD5iyHkGuK+CpL7VBMqKYyd/o1UdLekYmvywyf
         CAWw==
X-Gm-Message-State: AAQBX9fdDcWAi7KwmlngNPLPwl/SAK7OR2SAq1fYVwod0E0njOIsv9q1
        vfkjMmBprt6d31dpinoMAV/N/Q==
X-Google-Smtp-Source: AKy350b/32igxAJPjM6OJok7UdEMciBdE4rZawPr2m1ECfTAYZx+6ZoGBz/NxB84javPVoPEd7eEfw==
X-Received: by 2002:a05:622a:3d4:b0:3e8:1903:ab05 with SMTP id k20-20020a05622a03d400b003e81903ab05mr7372402qtx.64.1682089609592;
        Fri, 21 Apr 2023 08:06:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id j1-20020ac806c1000000b003d65e257f10sm1365634qth.79.2023.04.21.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:06:49 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:06:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 05/26] mm: page_alloc: per-migratetype pcplist for
 THPs
Message-ID: <20230421150648.GB320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-6-hannes@cmpxchg.org>
 <20230421124744.skrxvziwg3bx7rgt@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421124744.skrxvziwg3bx7rgt@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:47:44PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:52PM -0400, Johannes Weiner wrote:
> > Right now, there is only one pcplist for THP allocations. However,
> > while most THPs are movable, the huge zero page is not. This means a
> > movable THP allocation can grab an unmovable block from the pcplist,
> > and a subsequent THP split, partial free, and reallocation of the
> > remainder will mix movable and unmovable pages in the block.
> > 
> > While this isn't a huge source of block pollution in practice, it
> > happens often enough to trigger debug warnings fairly quickly under
> > load. In the interest of tightening up pageblock hygiene, make the THP
> > pcplists fully migratetype-aware, just like the lower order ones.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Split out :P
> 
> Take special care of this one because, while I didn't check this, I
> suspect it'll push the PCP structure size into the next cache line and
> increase overhead.
>
> The changelog makes it unclear why exactly this happens or why the
> patch fixes it.

Before this, I'd see warnings from the last patch in the series about
received migratetype not matching requested mt.

The way it happens is that the zero page gets freed and the unmovable
block put on the pcplist. A regular THP allocation is subsequently
served from an unmovable block.

Mental note, I think this can happen the other way around too: a
regular THP on the pcp being served to a MIGRATE_UNMOVABLE zero
THP. It's not supposed to, but it looks like there is a bug in the
code that's meant to prevent that from happening in rmqueue():

	if (likely(pcp_allowed_order(order))) {
		/*
		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
		 * we need to skip it when CMA area isn't allowed.
		 */
		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
				migratetype != MIGRATE_MOVABLE) {
			page = rmqueue_pcplist(preferred_zone, zone, order,
					migratetype, alloc_flags);
			if (likely(page))
				goto out;
		}
	}

Surely that last condition should be migratetype == MIGRATE_MOVABLE?

> The huge zero page strips GFP_MOVABLE (so unmovable)
> but at allocation time, it doesn't really matter what the movable type
> is because it's a full pageblock. It doesn't appear to be a hazard until
> the split happens. Assuming that's the case, it should be ok to always
> set the pageblock movable for THP allocations regardless of GFP flags at
> allocation time or else set the pageblock MOVABLE at THP split (always
> MOVABLE at allocation time makes more sense).

The regular allocator compaction skips over compound pages anyway, so
the migratetype should indeed not matter there.

The bigger issue is CMA. alloc_contig_range() will try to move THPs to
free a larger range. We have to be careful not to place an unmovable
zero THP into a CMA region. That means we can not play games with MT -
we really do have to physically keep unmovable and movable THPs apart.

Another option would be not to use pcp for the zero THP. It's cached
anyway in the caller. But it would add branches to the THP alloc and
free fast paths (pcp_allowed_order() also checking migratetype).
