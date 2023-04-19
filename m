Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF506E7218
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjDSEIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjDSEH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:07:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8154C1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1+uWTRLewcToazydKhUaBrTu2FFNSB5P4CD6tbusd5I=; b=lX4A6YoG795WdRlLvY9HCmzp28
        t9Mp8kqgHz/CbAHesPBSTEDRmzD42ieHVv6hejyUv/XcqepEy8RBsNcoAYF7XiDwMIpZDSgLBOpzk
        AZYKR59yb5sxSiVi+OYOg8ijkXdQy0CwYK96Eh6oLBmg3ebf7nPyOFFvY0JVnVhD6tkXve8GUjnGU
        K/csjLvhMND7y3EhS++quS907GNeHNnTB7SdDhuxpxHB83sksEXIAskf5JbQLFCnwMdgmG0idvTVd
        NXuXoo3jQJKkevnZbQTBtasWuUjdwRyYWY1e5NIOH+3ER8LuEOjeLGGMoqs+j+6H8vBWkEu+lz6ic
        k7GXn3mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poz6c-00Cwlr-GG; Wed, 19 Apr 2023 04:07:42 +0000
Date:   Wed, 19 Apr 2023 05:07:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 01/26] block: bdev: blockdev page cache is movable
Message-ID: <ZD9pDlR3ZpAXgwmq@casper.infradead.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418191313.268131-2-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Wise to split this out into a separate patch.  Perhaps we can get it
into -next for a while to shake out any problems with it.  I don't have
any specific code that I think is broken, but code like this is in ext2:

	bh = sb_bread(sb, logic_sb_block);
        es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
        sbi->s_es = es;

ie it reads into the page cache and then keeps a pointer to it during
the lifetime of the mount.

This specific example is, I believe, safe.  There's a refcount on
the buffer (released by brelse() at unmount) and so the page cannot
be migrated.

But that speaks to a different problem; sometimes buffers are held
pinned for short periods of time (eg reading a directory, modifying a
bitmap) and other times they're held pinned for a long period of time
(a superblock).  We notice that pages are being long-term pinned (eg
GUP) and migrate them out of the MOVABLE zone when that happens to them.
Perhaps we need something similar for buffer heads where the filesystem
can specify if it's just having a quick look or if it intends for this
buffer to be pinned over, let's say, a return to userspace.
