Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34196672A56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjARVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjARVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:23:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E224940B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:23:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F20E73F3B5;
        Wed, 18 Jan 2023 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674076984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TWe4//UXtWoSbfkzYR+yLI6KZbz74mo1UXbqphj11c=;
        b=CStZUXfRae9aJsMQsiWggighXwjHfvOgkCBON+YFqM0TUXRFqiijoLauDIjoVjoKKujIhx
        azaFM13uO4vlItJERp6/k7jUK01N6dVRIKzTAb1qB2J+OmG46s/xvd4uHiDZI6zIcnWBvt
        vT6yrvEUKWLg8pX9KZ7YPZOCJkCEnec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2D7E139D2;
        Wed, 18 Jan 2023 21:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GBpHLTdjyGPBNQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 21:23:03 +0000
Date:   Wed, 18 Jan 2023 22:23:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8hjNm+kB8WquUH6@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
 <Y8gn0KQDWC/5CZ/w@google.com>
 <Y8gt5Gb7DPaEI2uN@dhcp22.suse.cz>
 <Y8g1VWkdSwt5SUVo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8g1VWkdSwt5SUVo@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 10:07:17, Minchan Kim wrote:
> On Wed, Jan 18, 2023 at 06:35:32PM +0100, Michal Hocko wrote:
> > On Wed 18-01-23 09:09:36, Minchan Kim wrote:
> > > On Wed, Jan 18, 2023 at 10:10:44AM +0100, Michal Hocko wrote:
> > > > On Tue 17-01-23 15:16:30, Minchan Kim wrote:
> > > > > The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> > > > > pages paged-out successfully, not only the number of reclaimed pages
> > > > > in the operation because those pages paged-out successfully will be
> > > > > reclaimed easily at the memory pressure due to asynchronous writeback
> > > > > rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> > > > > 
> > > > > This patch renames the reclaim_pages with paging_out(with hope that
> > > > > it's clear from operation point of view) and then adds a additional
> > > > > stat in reclaim_stat to represent the number of paged-out but kept
> > > > > in the memory for rotation on writeback completion.
> > > > > 
> > > > > With that stat, madvise_pageout can know how many pages were paged-out
> > > > > successfully as well as reclaimed. The return value will be used for
> > > > > statistics in next patch.
> > > > 
> > > > I really fail to see the reson for the rename and paging_out doesn't
> > > > even make much sense as a name TBH.
> > > 
> > > Currently, what we are doing to reclaim memory is
> > > 
> > > reclaim_folio_list
> > >     shrink_folio_list
> > >         if (folio_mapped(folio))
> > >             try_to_unmap(folio)
> > > 
> > >         if (folio_test_dirty(folio))
> > >             pageout
> > > 
> > > Based on the structure, pageout is just one of way to reclaim memory.
> > > 
> > > With MADV_PAGEOUT, what user want to know how many pages
> > > were paged out as they requested(from userspace PoV, how many times
> > > pages fault happens in future accesses), not the number of reclaimed
> > > pages shrink_folio_list returns currently.
> > > 
> > > In the sense, I wanted to distinguish between reclaim and pageout.
> > 
> > But MADV_PAGEOUT is documented to trigger memory reclaim in general
> > not a pageout. Let me quote from the man page
> > : Reclaim a given range of pages.  This is done to free up memory occupied
> > : by these pages.
> 
> IMO, we need to change the documentation something like this.
> 
>  : Try to reclaim a given range of pages. The reclaim carries on the
>    unmap pages from address space and then write them out to backing
>    storage. It could help to free up memory occupied by these pages
>    or improve memory reclaim efficiency.

But this is not what the implementation does nor should it be specific
about what reclaim actual can do. The specific implementation of the
reclaim is an implementation detail.
 
> > Sure anonymous pages can be paged out to the swap storage but with the
> > upcomming multi-tiering it can be also "paged out" to a lower tier. All
> > that leads to freeing up memory that is currently mapped by that address
> > range.
> 
> I am not familiar with multi-tiering. However, thing is the operation
> of pageout is synchronous or not. If it's synchronous(IOW, when the
> pageout returns, the page was really written to the storage), yes,
> it can reclaim memory. If the backing storage is asynchrnous device
> (which is *major* these days), we cannot reclaim the memory but just
> wrote the page to the storage with hope it could help reclaim speed
> at next iteration of reclaim.

I am sorry but I do not follow. Synchronicity of the reclaim should be
completely irrelevant. Even swapout (pageout from your POV AFAIU) can be
async or sync.
 
> > Anyway, what do you actually meen by distinguishing between reclaim and
> > pageout. Aren't those just two names for the same thing?
> 
> reclaim is realy memory freeing but pageout is just one of the way
> to achieve the memory freeing, which is not guaranteed depending on
> backing storage's speed.

Try to think about it some more. Do you really want the MADV_PAGEOUT to
be so specific about how the memory reclaim is achieved? How do you
reflect new ways of reclaiming memory - e.g. memory demotion when the
primary memory gets freed by migrating the content to a slower type of
memory yet not write it out to ultra slow swap storage (which is just
yet another tier that cannot be accessed directly without an explicit
IO)?

-- 
Michal Hocko
SUSE Labs
