Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432A7120BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjEZHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZHPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:15:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FDF114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:15:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so4322425e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685085320; x=1687677320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t91DnNfVBB5flL99LpLlavWZRfqPEi+X/+IxN9gTW9U=;
        b=oQmuvkMLuPCqWiWXelSR5L0QjuJW2qwM/XZI1QKphvIEmO014uKSzBewq0A1YiIFOG
         p7xQc2cOmv6ZaP41tn7mYaarKiy1WLEIFC8F/tsacir0laXyfGgNWTOEE6Of8yH09TJq
         V0fxnE5WqzebEPt76quLPG0RTmVa5qnDpGkyhOy6SMxnWE3zRTAnTpSi5zBwkENBJPWq
         Dl4lBzd5UaRNgJ9kTorojva8j3U9/M81vPTjSpsU42sGf5mBDBxSZ79XAVR5fTAIm2fn
         VMUdQQLBZWsTVfsPgv2YV24duGe402z6g5LutKBHow36RQeqTbqDi9uCdkJj+YYCMwgu
         gSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685085320; x=1687677320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t91DnNfVBB5flL99LpLlavWZRfqPEi+X/+IxN9gTW9U=;
        b=K0SB9CBsfBD9yvtZOfkWPcl88z9oh1V5tM8xmOoIl77f1NQzuJN4JVrpEj2aiqYdwp
         WZh62XA4MluKugFQWgztzOxyLZvoKOM1iJBCWHzii3+Mkd6/y4emuIlfHLqgiMIiTDpD
         AVWQNi4vdgm3XdaRde76oA7YAjYobqamkfELE9Q2WAXVDkvp7nu6f76zJ8XW4E1Jsf6V
         hGJJr8r1zae7fgBeJ7N9keovjrrsQpc+wxCI0MjbyIxJGV31U/cbUc3ELCgPpEncXlD0
         2grBXWQEJM9NMPeOkS8BpjIdJjmAp/uEaustgXqIdv6yMtsgUCKA9RNa/x3Ol9lloc8R
         fJaw==
X-Gm-Message-State: AC+VfDwtPnjbivmhlbn/MWTre1nVN8D/FDhUE9jOPMSk47oO4HsmWcFb
        4tzfyF6xd8FKDrNdfCPJCDo=
X-Google-Smtp-Source: ACHHUZ79bjFz3JryFplB2bXK1OOazxp1JWNad91KuvzjlVo3CxG5sH5bO4eUf3D/ZIkKQujrE3rH/g==
X-Received: by 2002:a7b:ce0f:0:b0:3f6:a65:6ff3 with SMTP id m15-20020a7bce0f000000b003f60a656ff3mr812644wmc.32.1685085319801;
        Fri, 26 May 2023 00:15:19 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c7703000000b003f17eaae2c9sm4254789wmi.1.2023.05.26.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:15:18 -0700 (PDT)
Date:   Fri, 26 May 2023 08:13:07 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
References: <20230524082424.10022-1-lstoakes@gmail.com>
 <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:08:33AM +0800, Baoquan He wrote:
> On 05/24/23 at 09:24am, Lorenzo Stoakes wrote:
> > It turns out that alloc_pages_bulk_array() does not treat the page_array
> > parameter as an output parameter, but rather reads the array and skips any
> > entries that have already been allocated.
>
> I read __alloc_pages_bulk() carefully, it does store the allocated page
> pointers into page_array[] and pass out, not just reads the array and
> skips entry alreay allocated.

Umm, the function literally opens with:-

	/*
	 * Skip populated array elements to determine if any pages need
	 * to be allocated before disabling IRQs.
	 */
	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
		nr_populated++;

And then later:-

		/* Skip existing pages */
		if (page_array && page_array[nr_populated]) {
			nr_populated++;
			continue;
		}

This explicitly skips populated array entries and reads page_array to see
if entries already exist, and literally documents this in the comments
above each line, exactly as I describe.

>
> For the issue this patch is trying to fix, you mean __alloc_pages_bulk()
> doesn't initialize page_array intentionally if it doesn't successfully
> allocate desired number of pages. we may need add one sentence to notice
> user that page_array need be initialized explicitly.

It isn't 'trying' to fix it, it fixes it. I have this reproing locally.

What you're stating about 'successfully allocate desired number of pages'
is irrelevant, we literally check the number of allocated pages in the
caller.

No sentences need to be added, I explicitly state that the issue is due to
the array being uninitialised, the summary lines talks about reading
garbage.

>
> By the way, could you please tell in which line the test was referencing
> uninitialized data and causing the PFN to not be valid and trigger the
> WANR_ON? Please forgive my dumb head.

Well, I showed you the lines above where __alloc_bulk_array() is accessing
uninitialised data by reading page_array[].

But ultimately this is called from vm_map_ram_test() in lib/test_vmalloc.c:-

	for (i = 0; i < test_loop_count; i++) {
		v_ptr = vm_map_ram(pages, map_nr_pages, NUMA_NO_NODE);
^--- triggers warning because we can't map the invalid PFN
		*v_ptr = 'a';
^--- NULL pointer deref
		vm_unmap_ram(v_ptr, map_nr_pages);
	}

The warning is triggered in:-

vm_map_ram()
vmap_pages_range()
vmap_pages_range_noflush()
__vmap_pages_range_noflush()
vmap_pages_p4d_range()
vmap_pages_pud_range()
vmap_pages_pmd_range()
vmap_pages_pte_range()

In:-

		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
			return -EINVAL;

The PFN is invalid because I happen to have garbage in an array entry such
that page_to_pfn(garbage) >= max_pfn.

> >
> > This is somewhat unexpected and breaks this test, as we allocate the pages
> > array uninitialised on the assumption it will be overwritten.
> >
> > As a result, the test was referencing uninitialised data and causing the
> > PFN to not be valid and thus a WARN_ON() followed by a null pointer deref
> > and panic.
> >
> > In addition, this is an array of pointers not of struct page objects, so we
> > need only allocate an array with elements of pointer size.
> >
> > We solve both problems by simply using kcalloc() and referencing
> > sizeof(struct page *) rather than sizeof(struct page).
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  lib/test_vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index 9dd9745d365f..3718d9886407 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -369,7 +369,7 @@ vm_map_ram_test(void)
> >  	int i;
> >
> >  	map_nr_pages = nr_pages > 0 ? nr_pages:1;
> > -	pages = kmalloc(map_nr_pages * sizeof(struct page), GFP_KERNEL);
> > +	pages = kcalloc(map_nr_pages, sizeof(struct page *), GFP_KERNEL);
> >  	if (!pages)
> >  		return -1;
> >
> > --
> > 2.40.1
> >
>

A broader problem we might want to think about is how little anybody is
running this test in order that it wasn't picked up before now... obviously
there's an element of luck as to whether the page_array happens to be
zeroed or not, but you'd think it'd be garbage filled at least a reasonable
amount of the time.
