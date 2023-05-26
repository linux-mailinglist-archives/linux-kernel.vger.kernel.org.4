Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E667122CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbjEZI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbjEZI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926E9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685091418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/8JS6bjSYYM5b/bJbEXfvPGMCA87+2GLI6ZyQk0Hyfg=;
        b=B5WmuKQbk7CbFfNjs8PrOIFxhf95k3IHlqWmJLvk/PCJtY2WyTm6YX0nQN0iJxXIdAOXBz
        fV7Kys/H0lRl5Ff3o+PmYckK227OcelOZuy2SCuHqQWsmAwmQC4UzxgNlPawilvV3+Cu5v
        MIBYJxqUWLk95QNn6eBCCRvsFnVxLs0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-5G75kQDWO2-_fG69XeKX5A-1; Fri, 26 May 2023 04:56:54 -0400
X-MC-Unique: 5G75kQDWO2-_fG69XeKX5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C72F802355;
        Fri, 26 May 2023 08:56:54 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 939DA200AD47;
        Fri, 26 May 2023 08:56:53 +0000 (UTC)
Date:   Fri, 26 May 2023 16:56:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <ZHB0UTEYUMZVa23V@MiWiFi-R3L-srv>
References: <20230524082424.10022-1-lstoakes@gmail.com>
 <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
 <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26/23 at 08:13am, Lorenzo Stoakes wrote:
> On Fri, May 26, 2023 at 08:08:33AM +0800, Baoquan He wrote:
> > On 05/24/23 at 09:24am, Lorenzo Stoakes wrote:
> > > It turns out that alloc_pages_bulk_array() does not treat the page_array
> > > parameter as an output parameter, but rather reads the array and skips any
> > > entries that have already been allocated.
> >
> > I read __alloc_pages_bulk() carefully, it does store the allocated page
> > pointers into page_array[] and pass out, not just reads the array and
> > skips entry alreay allocated.
> 
> Umm, the function literally opens with:-
> 
> 	/*
> 	 * Skip populated array elements to determine if any pages need
> 	 * to be allocated before disabling IRQs.
> 	 */
> 	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
> 		nr_populated++;

OK, suppose page_array[] alreasy has three pages populated, if not
initialized and there's garbage data in page_array[], it could have
nr_populated > 3 finally? This is really risky.

> 
> And then later:-
> 
> 		/* Skip existing pages */
> 		if (page_array && page_array[nr_populated]) {
> 			nr_populated++;
> 			continue;
> 		}

This is interesting, I thought this place of nr_populated checking and
updating is meaningless, in fact it's skipping the element with vlaue
in the middle of page_array. I realize this when I recheck the code when
replying to your mail. Not sure if we should restrict that, or it's
really existing reasonablly.

[x][x][x][][][][x][x][][]
x marks the element pointing to page.

> 
> This explicitly skips populated array entries and reads page_array to see
> if entries already exist, and literally documents this in the comments
> above each line, exactly as I describe.

OK, I misread your words in log. While page_array[] is still output
parameter, just not pure output parameter? Not sure if I understand
output parameter correctly.

> 
> >
> > For the issue this patch is trying to fix, you mean __alloc_pages_bulk()
> > doesn't initialize page_array intentionally if it doesn't successfully
> > allocate desired number of pages. we may need add one sentence to notice
> > user that page_array need be initialized explicitly.
> 
> It isn't 'trying' to fix it, it fixes it. I have this reproing locally.

Right, my wrong expression.

> 
> What you're stating about 'successfully allocate desired number of pages'
> is irrelevant, we literally check the number of allocated pages in the
> caller.
> 
> No sentences need to be added, I explicitly state that the issue is due to
> the array being uninitialised, the summary lines talks about reading
> garbage.

Well, I meant adding sentence above __alloc_pages_bulk() to tell:
page_array[] could have garbage data stored if you don't initialize
it explicitly before calling __alloc_pages_bulk();

This could happen in other place if they don't use kcalloc(),
kmalloc(GFP_ZERO) or something like this to allocate page_array[]?

> 
> >
> > By the way, could you please tell in which line the test was referencing
> > uninitialized data and causing the PFN to not be valid and trigger the
> > WANR_ON? Please forgive my dumb head.
> 
> Well, I showed you the lines above where __alloc_bulk_array() is accessing
> uninitialised data by reading page_array[].

I see now, thanks for these details.

> 
> But ultimately this is called from vm_map_ram_test() in lib/test_vmalloc.c:-
> 
> 	for (i = 0; i < test_loop_count; i++) {
> 		v_ptr = vm_map_ram(pages, map_nr_pages, NUMA_NO_NODE);
> ^--- triggers warning because we can't map the invalid PFN
> 		*v_ptr = 'a';
> ^--- NULL pointer deref
> 		vm_unmap_ram(v_ptr, map_nr_pages);
> 	}
> 
> The warning is triggered in:-
> 
> vm_map_ram()
> vmap_pages_range()
> vmap_pages_range_noflush()
> __vmap_pages_range_noflush()
> vmap_pages_p4d_range()
> vmap_pages_pud_range()
> vmap_pages_pmd_range()
> vmap_pages_pte_range()
> 
> In:-
> 
> 		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> 			return -EINVAL;
> 
> The PFN is invalid because I happen to have garbage in an array entry such
> that page_to_pfn(garbage) >= max_pfn.
> 
> > >
> > > This is somewhat unexpected and breaks this test, as we allocate the pages
> > > array uninitialised on the assumption it will be overwritten.
> > >
> > > As a result, the test was referencing uninitialised data and causing the
> > > PFN to not be valid and thus a WARN_ON() followed by a null pointer deref
> > > and panic.
> > >
> > > In addition, this is an array of pointers not of struct page objects, so we
> > > need only allocate an array with elements of pointer size.
> > >
> > > We solve both problems by simply using kcalloc() and referencing
> > > sizeof(struct page *) rather than sizeof(struct page).
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > > ---
> > >  lib/test_vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > > index 9dd9745d365f..3718d9886407 100644
> > > --- a/lib/test_vmalloc.c
> > > +++ b/lib/test_vmalloc.c
> > > @@ -369,7 +369,7 @@ vm_map_ram_test(void)
> > >  	int i;
> > >
> > >  	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> > > -	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
> > > +	pages = kcalloc(map_nr_pages, sizeof(struct page *), GFP_KERNEL);
> > >  	if (!pages)
> > >  		return -1;
> > >
> > > --
> > > 2.40.1
> > >
> >
> 
> A broader problem we might want to think about is how little anybody is
> running this test in order that it wasn't picked up before now... obviously
> there's an element of luck as to whether the page_array happens to be
> zeroed or not, but you'd think it'd be garbage filled at least a reasonable
> amount of the time.

Hmm, that's why we may need notice people that there's risk in
__alloc_pages_bulk() if page_array[] is not initialized and the garbage
could be mistaken as a effective page pointer. My personal opinion.
People may argue it's caller's responsibility to do that.

Thanks
Baoquan

