Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD726A1F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBXQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBXQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:12:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14296CF23;
        Fri, 24 Feb 2023 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=De1mIGDznkep02AEOIOiRotwz93uXVDX1sI4fbfcfBc=; b=AnRQkSq945ElIXdLtal7DM5ZFa
        9fdPM4pGJ0JDhE+se03gkJJWpcgLKNWcHWCIkpC/ZjENe7eUi5S3qkaZ7qPYWAkPuUfBfm2brXhuI
        8hDLEvEKjUSiOUxb2eVDcWJk7vGDGwAdJD40/W0pMiu6n0o42hBXZ/cdFesYA3H/OwFKJN7l12t6O
        ZuIDoiJ8CIBA9plQNzya+jqt6mGypD+LtCcoi9iLB5gtdgKT52JJYyeBz6BZdARGRjOyAbz7hbF1T
        G6NxV0McjcppNjRpDpNSkx89C0sP1B8TFU4b54ybfE/eBlBWvnb19k4JD3QLPsIc+BG4ccDI3F3tY
        g/c7PhHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVafi-00FLuE-QW; Fri, 24 Feb 2023 16:11:46 +0000
Date:   Fri, 24 Feb 2023 16:11:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
Message-ID: <Y/jhwuTCaOgOTLp2@casper.infradead.org>
References: <2134430.1677240738@warthog.procyon.org.uk>
 <2009825.1677229488@warthog.procyon.org.uk>
 <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2213409.1677249075@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2213409.1677249075@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:31:15PM +0000, David Howells wrote:
> Here's the simplest fix for cifs_writepages_region() that gets it to work.
> 
> Fix the cifs_writepages_region() to just skip over members of the batch that
> have been cleaned up rather than retrying them.  I'm not entirely sure why it
> fixes it, though.  It's also not the most efficient as, in the common case,
> this is going to happen a lot because cifs_extend_writeback() is going to
> clean up the contiguous pages in the batch - and then this skip will occur for
> those.

Why are you doing it this way?  What's wrong with using
write_cache_pages() to push all the contiguous dirty folios into a single
I/O object, submitting it when the folios turn out not to be contiguous,
or when we run out of a batch?

You've written an awful lot of code here and it's a different model from
every other filesystem.  Why is it better?
