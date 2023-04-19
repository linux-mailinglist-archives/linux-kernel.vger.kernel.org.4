Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D26E7220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjDSEL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDSELy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:11:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90C61AF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCirft2EQ+qvGc6ZahSkKa47nK3OVYtgm30zMVksWYc=; b=F3Mm3LpsRGSooA3ZUYSX/vadVw
        EshdMvO850KSZucpjBZNG0dxxMQ4GcYMsf37mR31oDQ3tChovu8d7vEWh+p/dTuE+de3LbPSHWX8k
        GZ9kFmHyWUiylFE1d4OH1/2uZCDlJMtFCN8ZVXpZf67VXzFMtZ8vp7IxgCNtNx9sZJeyW/qY/S/R/
        Sgr3SNuJbsuhYpmmhqsOe3q5CGP29fgV7AkWR6RuOwpavFhcdRL6FGLPLbtU762JGe0T83XrVpnT4
        dasscrClOZkYmjmUUM/9bJNkupRhq75tUoquhJpA4kUP1wh20nEqSQfjnq3o2Z47sOZwwl1glhsU+
        pM5XMY4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pozAX-00Cwu9-Co; Wed, 19 Apr 2023 04:11:45 +0000
Date:   Wed, 19 Apr 2023 05:11:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Message-ID: <ZD9qATZcdyW/UGgI@casper.infradead.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:12:47PM -0400, Johannes Weiner wrote:
> This series proposes to make THP allocations reliable by enforcing
> pageblock hygiene, and aligning the allocator, reclaim and compaction
> on the pageblock as the base unit for managing free memory. All orders
> up to and including the pageblock are made first-class requests that
> (outside of OOM situations) are expected to succeed without
> exceptional investment by the allocating thread.
> 
> A neutral pageblock type is introduced, MIGRATE_FREE. The first
> allocation to be placed into such a block claims it exclusively for
> the allocation's migratetype. Fallbacks from a different type are no
> longer allowed, and the block is "kept open" for more allocations of
> the same type to ensure tight grouping. A pageblock becomes neutral
> again only once all its pages have been freed.

YES!  This is exactly what I've been thinking is the right solution
for some time.  Thank you for doing it.

