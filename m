Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87CE699EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBPVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A3505D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676582379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iQS7fLcdFYItcBczHsW9796GCBjG+HT4QQb65rs3R5g=;
        b=HJqi8+URK2FaKnsjmSsFGlW8Ik754hdNZb1w5k0S4CQWLSvKtX3L/xUr0hHLzvYiO1xSXC
        W0j90MHl2Bc/kFxqHv5EN/w5QCI0syjvGBYBaX+8qql0Do+uvZ1jgDvbEdUB+FqdWURR01
        2O7ZxEgDFRGQz1yM92GDv6RbGwZB/tY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-bnaSfYcBPw-w36P2GfwC8g-1; Thu, 16 Feb 2023 16:19:34 -0500
X-MC-Unique: bnaSfYcBPw-w36P2GfwC8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7864A1C05AF0;
        Thu, 16 Feb 2023 21:19:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4649E40C10FA;
        Thu, 16 Feb 2023 21:19:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 31GLJXo0007124;
        Thu, 16 Feb 2023 16:19:33 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 31GLJWwh007120;
        Thu, 16 Feb 2023 16:19:32 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 16 Feb 2023 16:19:32 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     snitzer@kernel.org, Yang Shi <shy828301@gmail.com>,
        mgorman@techsingularity.net, agk@redhat.com, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm-crypt: allocate compound pages if possible
In-Reply-To: <Y+5+OKbeTO2d9TsH@casper.infradead.org>
Message-ID: <alpine.LRH.2.21.2302161614540.5436@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.21.2302161245210.18393@file01.intranet.prod.int.rdu2.redhat.com> <Y+5+OKbeTO2d9TsH@casper.infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2023, Matthew Wilcox wrote:

> > -		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
> > -
> > -		bio_add_page(clone, page, len, 0);
> > +have_pages:
> > +		page->compound_order = order;
> 
> No.  You'll corrupt the next page if page is order-0, which it is if it
> came from the mempool.  Also we've deleted page->compound_order in -next
> so you can't make this mistake.  Using __GFP_COMP will set this field
> for you, so you can just drop this line.

OK

> > -		remaining_size -= len;
> > +		for (o = 0; o < 1U << order; o++) {
> > +			unsigned len = min((unsigned)PAGE_SIZE, remaining_size);
> > +			bio_add_page(clone, page, len, 0);
> > +			remaining_size -= len;
> > +			page++;
> 
> You can add multiple pages at once, whether they're compound or not.  So
> replace this entire loop with:
> 
> 		bio_add_page(clone, page, remaining_size, 0);

This should be min((unsigned)PAGE_SIZE << order, remaining_size), because 
we may allocate less than remaining_size.

> > @@ -1711,10 +1732,23 @@ static void crypt_free_buffer_pages(stru
> >  {
> >  	struct bio_vec *bv;
> >  	struct bvec_iter_all iter_all;
> > +	unsigned skip_entries = 0;
> >  
> >  	bio_for_each_segment_all(bv, clone, iter_all) {
> > -		BUG_ON(!bv->bv_page);
> > -		mempool_free(bv->bv_page, &cc->page_pool);
> > +		unsigned order;
> > +		struct page *page = bv->bv_page;
> > +		BUG_ON(!page);
> > +		if (skip_entries) {
> > +			skip_entries--;
> > +			continue;
> > +		}
> > +		order = page->compound_order;
> > +		if (order) {
> > +			__free_pages(page, order);
> > +			skip_entries = (1U << order) - 1;
> > +		} else {
> > +			mempool_free(page, &cc->page_pool);
> > +		}
> 
> You can simplify this by using the folio code.
> 
> 	struct folio_iter fi;
> 
> 	bio_for_each_folio_all(fi, bio) {
> 		if (folio_test_large(folio))
> 			folio_put(folio);
> 		else
> 			mempool_free(&folio->page, &cc->page_pool);
> 	}

OK. I'm sending version 2 of the patch.

> (further work would actually convert this driver to use folios instead
> of pages)

Mikulas

