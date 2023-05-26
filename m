Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC86712CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbjEZSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbjEZSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:46:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28865125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1cJq9zIs0nZ+a+dTmYQ4RE64ai18LNw3YMg66oEGC+o=; b=BoDyrS3q49eYTzYXMZ+EQJdZQ7
        XsFEfXiEGufp692c5s6T3VqZOR19XZXZwCdeHmaE5NRNcJ0x3YGH1IR5hBdWvXpbCi75VF1aE8jCo
        UDRT2dLssfTd6LUv8fHprvJV4ga0idQGoomgMfuKcwGZdTh5Z4hI9Bk0ptFrU2xYMfEO/AoJ0BY9T
        hRqSx8shvhkP3giwTuNDvQ5o9hqrrim4nRHfoLJUcq1SWGxXyb5TIxQMiSjiOxU5bBf0rFrouoqEY
        GpAC+0PqXTJE/Xk/5K7E9AJRTEpGaixlUa2olPvY9Th1ECbj8ZViZJleR5NiMxxt364zC11dAiRvj
        5zkLNQ/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2cS8-0032fH-28; Fri, 26 May 2023 18:46:16 +0000
Date:   Fri, 26 May 2023 19:46:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
Message-ID: <ZHD+eOMpZpWXNAig@casper.infradead.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:46:15PM +0200, David Hildenbrand wrote:
> On 26.05.23 18:44, Matthew Wilcox wrote:
> > On Fri, May 26, 2023 at 09:44:34AM -0600, Khalid Aziz wrote:
> > > > Oh, I think I found it!  pin_user_pages_remote() is called by
> > > > vaddr_get_pfns().  If these are the pages you're concerned about,
> > > > then the efficient way to do what you want is simply to call
> > > > folio_maybe_dma_pinned().  Far more efficient than the current mess
> > > > of total_mapcount().
> > > 
> > > vfio pinned pages triggered this change. Wouldn't checking refcounts against
> > > mapcount provide a more generalized way of detecting non-migratable pages?
> > 
> > Well, you changed the comment to say that we were concerned about
> > long-term pins.  If we are, than folio_maybe_dma_pinned() is how to test
> > for long-term pins.  If we want to skip pages which are short-term pinned,
> > then we need to not change the comment, and keep using mapcount/refcount
> > differences.
> > 
> 
> folio_maybe_dma_pinned() is all about FOLL_PIN, not FOLL_LONGTERM.

But according to our documentation, FOLL_LONGTERM implies FOLL_PIN.
Anyway, right now, the code skips any pages which are merely FOLL_GET,
so we'll skip fewer pages if we do only skip the FOLL_PIN ones,
regardless if we'd prefer to only skip the FOLL_LONGTERM ones.

> folio_maybe_dma_pinned() would skip migrating any page that has more than
> 1024 references. (shared libraries?)

True, but maybe we should be skipping any page with that many mappings,
given how disruptive it is to the rest of the system to unmap a page
from >1024 processes.
