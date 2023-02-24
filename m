Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A766A21B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBXSpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:45:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E3679BF;
        Fri, 24 Feb 2023 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KrxxPv4XvLx2RtKsee2RWloWUMeXGZheVNKJtMabags=; b=jplJ5yxAebN1rP7bepdDpvim3J
        qwaEDxAqa8jGhLU2xsBmcOLPsbTQfx0yfmyHY2nR4yRAp1aZId0mjEaNFsLjlJ7M8x7dMElLs1fhR
        tU1bEh8mTbx15omA53EmgduU5NuQf1MMFkHRoCp1T+6o8f3zZDL+3GioKL3ld30g3Uv+gVIb/Bk4r
        q+VMOAQIfnKSLm9UrKdw09y0Lxv7qp3eiwvy2UKncyVP+YJpgajz+I1Nb96uJ3G6Yw9sWAn+dieUo
        tOlYBSsJIoBYTDRsDyJuRVkFXKB7IEi8T7MEVT2ZiApqSgQAY6GvtAWRcpAq7TjcViYBYtSmS04gW
        ClPAldHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVd3m-00FU4d-25; Fri, 24 Feb 2023 18:44:46 +0000
Date:   Fri, 24 Feb 2023 18:44:46 +0000
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
Message-ID: <Y/kFnhUM5hjWM2Ae@casper.infradead.org>
References: <Y/jhwuTCaOgOTLp2@casper.infradead.org>
 <2134430.1677240738@warthog.procyon.org.uk>
 <2009825.1677229488@warthog.procyon.org.uk>
 <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2213409.1677249075@warthog.procyon.org.uk>
 <2385089.1677258941@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2385089.1677258941@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 05:15:41PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Why are you doing it this way?  What's wrong with using
> > write_cache_pages() to push all the contiguous dirty folios into a single
> > I/O object, submitting it when the folios turn out not to be contiguous,
> > or when we run out of a batch?
> > 
> > You've written an awful lot of code here and it's a different model from
> > every other filesystem.  Why is it better?
> 
> Because write_cache_pages():
> 
>  (1) Takes no account of fscache.  I can't just build knowledge of PG_fscache
>      into it because PG_private_2 may be used differently by other filesystems
>      (btrfs, for example).  (I'm also trying to phase out the use of
>      PG_private_2 and instead uses PG_writeback to cover both and the
>      difference will be recorded elsewhere - but that's not there yet).

I don't understand why waiting for fscache here is even the right thing
to do.  The folio is dirty and needs to be written back to the
server.  Why should beginning that write wait for the current write
to the fscache to complete?

>  (2) Calls ->writepage() individually for each folio - which is excessive.  In
>      AFS's implementation, we locate the first folio, then race through the
>      following folios without ever waiting until we hit something that's
>      locked or a gap and then stop and submit.
> 
>      write_cache_pages(), otoh, calls us with the next folio already undirtied
>      and set for writeback when we find out that we don't want it yet.

I think you're so convinced that your way is better that you don't see
what write_cache_pages() is actually doing.  Yes, the writepage callback
is called once for each folio, but that doesn't actually submit a write.
Instead, they're accumulated into the equivalent of a wdata and the
wdata is submitted when there's a discontiguity or we've accumulated
enough to satisfy the constraints of the wbc.

>  (3) Skips over holes, but at some point in the future we're going to need to
>      schedule adjacent clean pages (before and after) for writeback too to
>      handle transport compression and fscache updates if the granule size for
>      either is larger than the folio size.

Then we'll need it for other filesystems too, so should enhance
write_cache_pages().

> It might be better to take what's in cifs, generalise it and replace
> write_cache_pages() with it, then have a "->submit_write()" aop that takes an
> ITER_XARRAY iterator to write from.

->writepages _is_ ->submit_write.  Should write_cache_pages() be better?
Maybe!  But it works a whole lot better than what AFS was doing and
you've now ladelled into cifs.
