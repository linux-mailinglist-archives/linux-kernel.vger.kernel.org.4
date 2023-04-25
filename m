Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC416EE414
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjDYOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjDYOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:40:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90D1544D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:39:21 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-5ef8aaf12bdso24323246d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682433554; x=1685025554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAymwB2ajYRlu+sRIxNbgxXmCl1PbjcxmIoXSAKN4EM=;
        b=4M8NDPSQ1aHK3VBE0rM8aYdsDyZfgRRXN8P8uij4AX+H6Q8elgffA+4W04vlkKzSKo
         K2DIfH3mCWrULuyoR6pbpEylqv3+wAhLDMuYxVKm+7uhYUVdjEluXTTY1T/Tt+jJEVtY
         EQcxQrB6Yue3WPtcmImi1ErLKfBZFiVAqt1d38UN+Z+g+mTsXVWX2c0NKBdeSWX3az5I
         cNHdSDqjQ/OntfmA3Q9LRqQ7bh6mtr34CKRHzAfdJ3C3Ek1MXFn+GMjmx0rMHome7lxh
         LRUzjBJlHTcb5tZxWkBgKK09BirhcyeFEje81qul7ieUkouf4kk7fqag2dw4TCMBgo74
         x/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682433554; x=1685025554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAymwB2ajYRlu+sRIxNbgxXmCl1PbjcxmIoXSAKN4EM=;
        b=guPXz1S7zfcQZyMiRp+d8B6lryHoXc9PCaMQE2/Xfxboaov4T9QXimdv+x+Twwsogk
         8JQqc/xLjwWm9hXVQEYbFpaPZSpD2CIb1J+7h12sEq8FOzO1h9Iew/ZqfC6cknTn37Pj
         vsE6e6IggBTa2JIDK6LEMieNX0U5Z97+XPqq7n0tZxqXTQKDTQ4UVRWyP3rZ4UsIcLnc
         3EWI89L6PFfkvsacfSGVDJTRhoZaud+QWma63w8EzpsONyuYXOxKRq5LcgLHCgOrqGyk
         Fw5C9f0N4mjU1sH9htsQVkGlMUZO7z0NeUa92sajoJtOzUFAh98cTezus60lMUqkx2qq
         rGBQ==
X-Gm-Message-State: AAQBX9dxzlF+gYQ8knnFWNQibgNirYJTFrnyhxy3ibUPr/kmjPx5ftSX
        4Dgjg7PFFyeJqr2z/JmK6c4aJw==
X-Google-Smtp-Source: AKy350ZTSn0jDkuxQukJ6AV2BrYyovduzY60WhUsXHFsDIidfr84v7R33z9T6nervRAGqLIFzemhcQ==
X-Received: by 2002:a05:6214:1bc9:b0:5e3:d150:3163 with SMTP id m9-20020a0562141bc900b005e3d1503163mr29654593qvc.20.1682433553123;
        Tue, 25 Apr 2023 07:39:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9fc5])
        by smtp.gmail.com with ESMTPSA id hr6-20020a05621423c600b005f2dba7a5b0sm4122128qvb.132.2023.04.25.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 07:39:12 -0700 (PDT)
Date:   Tue, 25 Apr 2023 10:39:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 08/26] mm: page_alloc: claim blocks during compaction
 capturing
Message-ID: <20230425143912.GB17132@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-9-hannes@cmpxchg.org>
 <20230421131227.k2afmhb6kejdbhui@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421131227.k2afmhb6kejdbhui@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:12:27PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:55PM -0400, Johannes Weiner wrote:
> > When capturing a whole block, update the migratetype accordingly. For
> > example, a THP allocation might capture an unmovable block. If the THP
> > gets split and partially freed later, the remainder should group up
> > with movable allocations.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/internal.h   |  1 +
> >  mm/page_alloc.c | 42 ++++++++++++++++++++++++------------------
> >  2 files changed, 25 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 024affd4e4b5..39f65a463631 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -432,6 +432,7 @@ struct compact_control {
> >   */
> >  struct capture_control {
> >  	struct compact_control *cc;
> > +	int migratetype;
> >  	struct page *page;
> >  };
> >  
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 4d20513c83be..8e5996f8b4b4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -615,6 +615,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
> >  				page_to_pfn(page), MIGRATETYPE_MASK);
> >  }
> >  
> > +static void change_pageblock_range(struct page *pageblock_page,
> > +					int start_order, int migratetype)
> > +{
> > +	int nr_pageblocks = 1 << (start_order - pageblock_order);
> > +
> > +	while (nr_pageblocks--) {
> > +		set_pageblock_migratetype(pageblock_page, migratetype);
> > +		pageblock_page += pageblock_nr_pages;
> > +	}
> > +}
> > +
> >  #ifdef CONFIG_DEBUG_VM
> >  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
> >  {
> > @@ -962,14 +973,19 @@ compaction_capture(struct capture_control *capc, struct page *page,
> >  	    is_migrate_isolate(migratetype))
> >  		return false;
> >  
> > -	/*
> > -	 * Do not let lower order allocations pollute a movable pageblock.
> > -	 * This might let an unmovable request use a reclaimable pageblock
> > -	 * and vice-versa but no more than normal fallback logic which can
> > -	 * have trouble finding a high-order free page.
> > -	 */
> > -	if (order < pageblock_order && migratetype == MIGRATE_MOVABLE)
> > +	if (order >= pageblock_order) {
> > +		migratetype = capc->migratetype;
> > +		change_pageblock_range(page, order, migratetype);
> > +	} else if (migratetype == MIGRATE_MOVABLE) {
> > +		/*
> > +		 * Do not let lower order allocations pollute a
> > +		 * movable pageblock.  This might let an unmovable
> > +		 * request use a reclaimable pageblock and vice-versa
> > +		 * but no more than normal fallback logic which can
> > +		 * have trouble finding a high-order free page.
> > +		 */
> >  		return false;
> > +	}
> >  
> 
> For capturing pageblock order or larger, why not unconditionally make
> the block MOVABLE? Even if it's a zero page allocation, it would be nice
> to keep the pageblock for movable pages after the split as long as
> possible.

The zero page isn't split, but if some other unmovable allocation does
a split and free later on I want to avoid filling a block with an
unmovable allocation with movables. That block is already lost to
compaction, and this way future unmovable allocations are more likely
to group into that block rather than claim an additional unmovable.

I had to double take for block merges beyond pageblock order,
wondering if we can claim multiple blocks for requests (capc->order)
smaller than a block. But that can't happen. Once we reach
pageblock_order during merging we claim, capture and exit. That means
order > pageblock_order can only happen if capc->order is actually
larger than a pageblock as well. I'll add a comment.
