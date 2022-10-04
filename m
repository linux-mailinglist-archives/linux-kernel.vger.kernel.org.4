Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311A5F45C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJDOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJDOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:40:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D618B13;
        Tue,  4 Oct 2022 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hW9HdhVYK8YoDrnaYmqTbVsR1S9wWFhd+9YKhSOTphY=; b=O53LrSO7ngSMB8+B2L67BOxMv6
        1lAyZEAZ8t9y1VVu3Ysl6iNu703c7QkC8/E65lQ4dXogyEOaJoB9DF8tZc0l99WuTALZjyuXjH0AY
        2FQ4impjQYOfWaPR67dZiLeQVRj+oHe6fcDrfGkIQTpMWpZdmeSDvhrEcuTY6/5WK+KK4WAfN/XcE
        6hdW+Su/80heZo1ZU2CGb6Ldf/YJ6ILQsQWGibgNLY32ldWbFaXj8jkXySo703CfafZUZwXNsPX9S
        bzn48MhgT+HU6mKf6ShXlFLl9iFs0fF11iEyO5/jbPyvNE5K2jTS9iBR5DMh8Se9H/IhnIV2DTkFi
        rwaiR1Fg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofj64-00HFJs-3t; Tue, 04 Oct 2022 14:40:36 +0000
Date:   Tue, 4 Oct 2022 15:40:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzxF5Bs/tgLDOB0T@casper.infradead.org>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <YzxCmR3dGJz45NVD@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxCmR3dGJz45NVD@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:26:33PM +0900, Hyeonggon Yoo wrote:
> > It's the acquisition of
> > the refcount which stabilises the slab flag, not holding the lock.
> 
> But can you please elaborate how this prevents race between
> allocation & initialization of a slab and isolate_movable_page()?
> 
> Or maybe we can handle it with frozen folio as Vlastimil suggested? ;-) 

Yes, we discussed that a little yesterday.  I'm hoping to have a
refreshed patchset for frozen folios out today.  Some of this patch
is still needed, even if we go that route.

> > @@ -91,8 +99,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
> >  	 * lets be sure we have the page lock
> >  	 * before proceeding with the movable page isolation steps.
> >  	 */
> > -	if (unlikely(!trylock_page(page)))
> > -		goto out_putpage;
> > +	if (unlikely(!folio_trylock(folio)))
> > +		goto out_put;
> 
> I don't know much about callers that this is trying to avoid race aginst...
> 
> But for this to make sense, I think *every users* that doing their stuff with
> sub-page of a compound page should acquire folio lock and not page lock
> of sub-page, right?

There is no page lock per se.  If you try to acquire the lock on a tail
page, it acquires the lock on its head page.  It's been that way for a
very long time.  A lot of people are confused by this, which was part of
the motivation for making it explicit with folios.

