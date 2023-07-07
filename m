Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906574B71A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGGT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjGGT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:27:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBD1BDB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZPIlCKCzgc/KoAPeY2S749EwVAIG2D9R9gSZjauUTRo=; b=mXTbUm2BAIX5AHalbXouzGdBBv
        Cjj0LUZSA7dzFAd+xZi4ahjjHwaW+V3Yh+3Ne3IDos63zgXpbb9IJId5sHqIlRTLUBYjw1jpHEV6Z
        b8ASSXooXoxLWY40EaBS7srqevhmu+3G3FfefBpXCpu+fiGO2KvYIArAF6zeyHGCJLQfLbSPTxbZD
        4DvFnuix5S19LEvMhB/xyKkRDxKPD4gxJ7fsv83qao3OCD3vghQTD1C5BJa4scn5K6XIwc8w3PtoZ
        C4+3CaDf/GXtTDny/14Ofpy3pJ8yQOdtM4wJjVh8NEROT6guoDMd3ZIWXZn+vGbvnrP65g+P+Gb1d
        A9J+O/hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHr6S-00CIHG-4H; Fri, 07 Jul 2023 19:26:52 +0000
Date:   Fri, 7 Jul 2023 20:26:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Message-ID: <ZKhm/LDJ0X/o3BYG@casper.infradead.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <5c9bf622-0866-168f-a1cd-4e4a98322127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c9bf622-0866-168f-a1cd-4e4a98322127@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:15:02PM +0200, David Hildenbrand wrote:
> > > Sure, any time we PTE-map a THP we might just say "let's put that on the
> > > deferred split queue" and cross fingers that we can eventually split it
> > > later. (I was recently thinking about that in the context of the mapcount
> > > ...)
> > > 
> > > It's all a big mess ...
> > 
> > Oh, I agree, there are always going to be circumstances where we realise
> > we've made a bad decision and can't (easily) undo it.  Unless we have a
> > per-page pincount, and I Would Rather Not Do That.
> 
> I agree ...
> 
> But we should _try_
> > to do that because it's the right model -- that's what I meant by "Tell
> 
> Try to have per-page pincounts? :/ or do you mean, try to split on VMA
> split? I hope the latter (although I'm not sure about performance) :)

Sorry, try to split a folio on VMA split.

> > me why I'm wrong"; what scenarios do we have where a user temporarilly
> > mlocks (or mprotects or ...) a range of memory, but wants that memory
> > to be aged in the LRU exactly the same way as the adjacent memory that
> > wasn't mprotected?
> 
> Let me throw in a "fun one".
> 
> Parent process has a 2 MiB range populated by a THP. fork() a child process.
> Child process mprotects half the VMA.
> 
> Should we split the (COW-shared) THP? Or should we COW/unshare in the child
> process (ugh!) during the VMA split.
> 
> It all makes my brain hurt.

OK, so this goes back to what I wrote earlier about attempting to choose
what size of folio to allocate on COW:

https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/

: the parent had already established
: an appropriate size folio to use for this VMA before calling fork().
: Whether it is the parent or the child causing the COW, it should probably
: inherit that choice and we should default to the same size folio that
: was already found.

You've come up with a usefully different case here.  I think we should
COW the folio at the point of the mprotect().  That will allow the parent
to become the sole owner of the folio once again and ensure that when
the parent modifies the folio, it _doesn't_ have to COW.

(This is also a rare case, surely)

> > 
> > GUP-pinning is different, and I don't think GUP-pinning should split
> > a folio.  That's a temporary use (not FOLL_LONGTERM), eg, we're doing
> > tcp zero-copy or it's the source/target of O_DIRECT.  That's not an
> > instruction that this memory is different from its neighbours.
> > 
> > Maybe we end up deciding to split folios on GUP-pin.  That would be
> > regrettable.
> 
> That would probably never be accepted, because the ones that heavily rely on
> THP (databases, VMs), typically also end up using a lot of features that use
> (long-term) page pinning. Don't get me started on io_uring with fixed
> buffers.

I do think that something like a long-term pin should split a folio.
Otherwise we're condemning the rest of the folio to be pinned along
with it.  Short term pins shouldn't split.
