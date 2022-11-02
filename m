Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F56616F04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKBUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKBUpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F00658A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667421861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W/vNqEe9kdMiUGr3xRIJxtzc4rwHsL9U2+4y8NsyPqk=;
        b=Ivj2/+OQ25XcTAxn+n42nCQLBjS0h13IVSPYbvbPjASNJstCNnry29ReLvgT1v2OmXvbj3
        xa4H37uZfZsWXjjppZxTj78AA+bA2v9eQgVBZXP0hcxNsxOzwDv03cU3ki0qkv5OVEXCmo
        poVCxa1pi6sMZ7MA3seZ8XwvODyUZz8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-ZuG0B89zOFqP4EQZJ3gNDg-1; Wed, 02 Nov 2022 16:44:20 -0400
X-MC-Unique: ZuG0B89zOFqP4EQZJ3gNDg-1
Received: by mail-qk1-f197.google.com with SMTP id de21-20020a05620a371500b006eed31abb72so16241302qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/vNqEe9kdMiUGr3xRIJxtzc4rwHsL9U2+4y8NsyPqk=;
        b=froAN2LTmfd94QhuQVhHnRwdqUe9Idz5Y29ubi6ICaD6LUOy5K31ADYx2ODWXh+LsC
         if50ivbYCzm05LWuDYuhe4EP141g9GMLfXdvFfTTnlu9D4+qkZ16tkZoW4hrJ1OnsU9G
         zluRWtNhumMeIcLiyDWceK+i4kPsRwwi0kdgekzj/78UVCSQ6TcvEigFYEP9jfTbyg3P
         +z9oWgbL/xzJOyOqVC4uET5EadSazey/CCvMe4zC7H/Adolqxj3CIu6pdj106Bd1xkrM
         bvbm0hxpgeB9UbAit9b9mbTgoQPTKbSQo+DQbyLMeF88GJ86gct17wZIV4wdU3cgGKR5
         9ZaA==
X-Gm-Message-State: ACrzQf2I7SO/SzRqYAOfNmuIJK5b0m7RvTG1m1t6g5/bZ97wBrVqwnhE
        roz7s9Q3rYTolp2dGtJRnVBQifBlWndc5D/OdHT34LdRORGRrw+fiEYR3+7I8YCBR/xNFxgfT+d
        Rzj7eh6uumeq+pKxe2Pptvg06
X-Received: by 2002:a37:c4d:0:b0:6fa:b44:1610 with SMTP id 74-20020a370c4d000000b006fa0b441610mr18938083qkm.153.1667421860290;
        Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45PiqOchTm473K6yukASrI7J3XtwxvJ2ubdKVdWdx5zZccQ1R7pEO4ceI62cTHD1N+1bBGJA==
X-Received: by 2002:a37:c4d:0:b0:6fa:b44:1610 with SMTP id 74-20020a370c4d000000b006fa0b441610mr18938066qkm.153.1667421860080;
        Wed, 02 Nov 2022 13:44:20 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a445400b006cbe3be300esm1873284qkp.12.2022.11.02.13.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:44:19 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:44:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2LWonzCdWkDwyyr@x1n>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n>
 <Y2LDL8zjgxDPCzH9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2LDL8zjgxDPCzH9@casper.infradead.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:21:19PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> > Does the patch attached look reasonable to you?
> 
> Mmm, no.  If the page is in the swap cache, this will be "true".

It will not happen in practise, right?

I mean, shmem_get_folio() should have done the swap-in, and we should have
the page lock held at the meantime.

For anon, mcopy_atomic_pte() is the only user and it's passing in a newly
allocated page here.

> 
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 3d0fef3980b3..650ab6cfd5f4 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> >  	pte_t _dst_pte, *dst_pte;
> >  	bool writable = dst_vma->vm_flags & VM_WRITE;
> >  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > -	bool page_in_cache = page->mapping;
> > +	bool page_in_cache = page_mapping(page);
> 
> We could do:
> 
> 	struct page *head = compound_head(page);
> 	bool page_in_cache = head->mapping && !PageMappingFlags(head);

Sounds good to me, but it just gets a bit complicated.

If page_mapping() doesn't sound good, how about we just pass that over from
callers?  We only have three, so quite doable too.

-- 
Peter Xu

