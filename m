Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE773B33C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFWJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFWJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D49AC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687511232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/G8RHNBY78+Px5wdz6dNBoCO3mzGUQrI4D5gpZgUjI=;
        b=eMIFvo3dpbhXI9C7siInK4wQVx4lwAfxZ2OuOvK+u0Cr5YbYa7THRORY3bwp3buYBryBvm
        Pr+P+5/Dfbu3qkuM2DoWAOVeTRHfRqleJaHSEL7rty4Ebf87UTgNZVFAtgxZwncalyoArd
        Gz5VL88bpKfpUWxe1kqDsmbqR40i+pY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-Yf1WUi0tMI6-F5303-p1OA-1; Fri, 23 Jun 2023 05:07:05 -0400
X-MC-Unique: Yf1WUi0tMI6-F5303-p1OA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BEC98E44EE;
        Fri, 23 Jun 2023 09:07:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B254C15230A0;
        Fri, 23 Jun 2023 09:06:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <634c885ccfb2e49e284aedc60e157bb12e5f3530.camel@redhat.com>
References: <634c885ccfb2e49e284aedc60e157bb12e5f3530.camel@redhat.com> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1969719.1687511219.1@warthog.procyon.org.uk>
Date:   Fri, 23 Jun 2023 10:06:59 +0100
Message-ID: <1969720.1687511219@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> wrote:

> IMHO this function uses a bit too much labels and would be more easy to
> read, e.g. moving the above chunk of code in conditional branch.

Maybe.  I was trying to put the fast path up at the top without the slow path
bits in it, but I can put the "insufficient_space" bit there.

> Even without such change, I think the above 'goto try_again;'
> introduces an unneeded conditional, as at this point we know 'fragsz <=
> fsize'.

Good point.

> > +		cache->pfmemalloc = folio_is_pfmemalloc(spare);
> > +		if (cache->folio)
> > +			goto reload;
> 
> I think there is some problem with the above.
> 
> If cache->folio is != NULL, and cache->folio was not pfmemalloc-ed
> while the spare one is, it looks like the wrong policy will be used.
> And should be even worse if folio was pfmemalloc-ed while spare is not.
> 
> I think moving 'cache->pfmemalloc' initialization...
> 
> > +	}
> > +
> 
> ... here should fix the above.

Yeah.  We might have raced with someone else or been moved to another cpu and
there might now be a folio we can allocate from.

> > +	/* Reset page count bias and offset to start of new frag */
> > +	cache->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
> > +	offset = folio_size(folio);
> > +	goto try_again;
> 
> What if fragsz > PAGE_SIZE, we are consistently unable to allocate an
> high order page, but order-0, pfmemalloc-ed page allocation is
> successful? It looks like this could become an unbounded loop?

It shouldn't.  It should go:

	try_again:
		if (fragsz > offset)
			goto insufficient_space;
	insufficient_space:
		/* See if we can refurbish the current folio. */
		...
		fsize = folio_size(folio);
		if (unlikely(fragsz > fsize))
			goto frag_too_big;
	frag_too_big:
		...
		return NULL;

Though for safety's sake, it would make sense to put in a size check in the
case we fail to allocate a larger-order folio.

> >  		do {
> >  			struct page *page = pages[i++];
> >  			size_t part = min_t(size_t, PAGE_SIZE - off, len);
> > -
> > -			ret = -EIO;
> > -			if (WARN_ON_ONCE(!sendpage_ok(page)))
> > +			bool put = false;
> > +
> > +			if (PageSlab(page)) {
> 
> I'm a bit concerned from the above. If I read correctly, tcp 0-copy

Well, splice()-to-tcp will; MSG_ZEROCOPY is unaffected.

> will go through that for every page, even if the expected use-case is
> always !PageSlub(page). compound_head() could be costly if the head
> page is not hot on cache and I'm not sure if that could be the case for
> tcp 0-copy. The bottom line is that I fear a possible regression here.

I can put the PageSlab() check inside the sendpage_ok() so the page flag is
only checked once.  But PageSlab() doesn't check the headpage, only the page
it is given.  sendpage_ok() is more the problem as it also calls
page_count().  I could drop the check.

David

