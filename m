Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1C65C308
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjACPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbjACPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:31:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490851055B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tYB2JZE2N0WqTPWcsY2cJZJix0I7cJCxTxV5O4mNf00=; b=e5jv2AL9yGM5fFtgcVIjLQBfU6
        9nI7bN3KEFRKBs7n+Q+yhCiQIpbuSUEiSWczKzLuui2JWaq0xcmVGJ9UfeEj2tZOrL1BCDp8LBVih
        /iYkhtP0eJJYwY5R1H63IErkwXLJcZejtyrM9PbgSSjiDkMqwBr/fyovTXH0Zbd3ssmeCRgAJ5hBZ
        TqlR1LsNWUgE0V25W7RDR1KvZIKR9PLTXMT3EM3nyECFk4nL30HO0utjok8Fn0vfVKangD21FRlVp
        xdTELx4xqcPxigyfX56kBGZ+rS2fR32CZIT/p7FZb4tvtUbgG3h5iiWzxLQzQqPvGBUSs/6mnOQ+9
        AINeyHEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCjGR-00EDwR-3V; Tue, 03 Jan 2023 15:31:43 +0000
Date:   Tue, 3 Jan 2023 15:31:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: A better dump_page()
Message-ID: <Y7RKX45mvwkbiMbo@casper.infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> Separately we should also make the __dump_page() more resilient.

Right.  It's not ideal when one of our best debugging tools obfuscates
the problem we're trying to debug.  I've seen probems like this before,
and the problem is that somebody calls dump_page() on a page that they
don't own a refcount on.  That lets the page mutate under us in some
fairly awkward ways (as you've seen here, it seems to be part of several
different compound allocations at various points during the dump
process).

One possibility I thought about was taking our own refcount on the
page at the start of dump_page().  That would kill off the possibility
of ever passing in a const struct page, and it would confuse people.
Also, what if somebody passes in a pointer to something that's not a
struct page?  Then we've (tried to) modify memory that's not a refcount.

I think the best we can do is to snapshot the struct page and the folio
it appears to belong to at the start of dump_page().  It'll take a
little care (for example, folio_pfn() must be passed the original
folio, and not the snapshot), but I think it's doable.
