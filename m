Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16EC69E9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBUVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBUVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:49:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B530B17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tqUTdU7Oxabkpc2eX2yF/NoLMlUx0QIQ1Sh+WbBxTB0=; b=gFTVM+au7usG3SRVpcLGuZ0Jua
        g2aPjaOkF6cMpH8l2keX0zC3RoATVpjJJP5mtxdn544c8Jy7oIUkTGfPMWueGme9uHfZ5tc4Oacyi
        bSO5+jgwM+99YfnbzOYeQpd427DA4Gm6e1/3G+wqa5vkaYpvVL9XMrSa8/Z8gD2HCPNouQsY3WNwt
        xzdtZDh+GDFug8xBmhcVQcz/1mBNjvYYk4NGd++LYQ6O7Ak3a/Q09A5KtiMtxx11SysOORiGSl601
        q3YPqwAWZ3CwBjxHcYrPEsRGKtqIKjHtws6p2mpUx246N8Ok3LftlXFGmnGG/y8EmuIn8BWOre8B9
        +JfY3BKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUaVx-00CweB-8t; Tue, 21 Feb 2023 21:49:33 +0000
Date:   Tue, 21 Feb 2023 21:49:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: What size anonymous folios should we allocate?
Message-ID: <Y/U8bQd15aUO97vS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a sense this question is premature, because we don't have any code
in place to handle folios which are any size but PMD_SIZE or PAGE_SIZE,
but let's pretend that code already exists and is just waiting for us
to answer this policy question.

I'd like to reject three ideas up front: 1. a CONFIG option, 2. a boot
option and 3. a sysfs tunable.  It is foolish to expect the distro
packager or the sysadmin to be able to make such a decision.  The
correct decision will depend upon the instantaneous workload of the
entire machine and we'll want different answers for different VMAs.

I'm open to applications having some kind of madvise() call they can
use to specify hints, but I would prefer to handle memory efficiently
for applications which do not.

For pagecache memory, we use the per-fd readahead code; if readahead has
been successful in the past we bump up the folio size until it reaches
its maximum.  There is no equivalent for anonymous memory.

I'm working my way towards a solution that looks a little like this:

A. We modify khugepaged to quadruple the folio size each time it scans.
   At the moment, it always attempts to promote straight from order 0
   to PMD size.  Instead, if it finds four adjacent order-0 folios,
   it will allocate an order-2 folio to replace them.  Next time it
   scans, it finds four order-2 folios and replaces them with a single
   order-4 folio.  And so on, up to PMD order.

B. A further modification is that it will require three of the four
   folios being combined to be on the active list.  If two (or more)
   of the four folios are inactive, we should leave them alone; either
   they will remain inactive and eventually be evicted, or they will be
   activated and eligible for merging in a future pass of khugepaged.

C. We add a new wrinkle to the LRU handling code.  When our scan of the
   active list examines a folio, we look to see how many of the PTEs
   mapping the folio have been accessed.  If it is fewer than half, and
   those half are all in either the first or last half of the folio, we
   split it.  The active half stays on the active list and the inactive
   half is moved to the inactive list.

I feel that these three changes should allow us to iterate towards a
solution for any given VMA that is close to optimal, and adapts to a
changing workload with no intervention from a sysadmin, or even hint
from a program.

There are three different circumstances where we currently allocate
anonymous memory.  The first is for mmap(MAP_ANONYMOUS), the second is
COW on a file-backed MAP_PRIVATE and the third is COW of a post-fork
anonymous mapping.

For the first option, the only hint we have is the size of the VMA.
I'm tempted to suggest our initial guess at the right size folio to
allocate should be scaled to that, although I don't have a clear idea
about what the scale factor should be.

For the second case, I want to strongly suggest that the size of the
folio allocated by the page cache should be of no concern.  It is largely
irrelevant to the application's usage pattern what size the page cache
has chosen to cache the file.  I might start out very conservatively
here with an order-0 allocation.

For the third case, in contrast, the parent had already established
an appropriate size folio to use for this VMA before calling fork().
Whether it is the parent or the child causing the COW, it should probably
inherit that choice and we should default to the same size folio that
was already found.


I don't stay current with the research literature, so if someone wants
to point me to a well-studied algorithm and let me know that I can stop
thinking about this, that'd be great.  And if anyone wants to start
working on implementing this, that'd also be great.

P.S. I didn't want to interrupt the flow of the above description to
note that allocation of any high-order folio can and will fail, so
there will definitely be fallback points to order-0 folios, which will
be no different from today.  Except that maybe we'll be able to iterate
towards the correct folio size in the new khugepaged.

P.P.S. I still consider myself a bit of a novice in the handling of
anonymous memory, so don't be shy to let me know what I got wrong.
