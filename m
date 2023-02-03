Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D1689EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjBCQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:00:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93C97D8F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:00:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n13so5637027plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiUaOu2iRNFq5Ksk1hK+QZW45BRCm1sHgZZrxPYsFTY=;
        b=LdHnyTMyjfLCGEpqKc2l2ei9SRkgdyVLJ+Vmg+SQbx6C0yTT+URBKPXf6SVb5imyLH
         lAD+wV5PjcylMQ8D1/aKwZN3hZIFhMhdeCHNcr19TVW6QTPn6aX2hEcX/EZzw9D7x4Nh
         vPgyjGUtydo5jDrf1+YrxDbzNuZWdLwbGEje7cyct9uGGkeJJn3Ew/CrYP9OAADYhKHy
         A0WZr8+JWa72ymrMHcmPU+aKRt0dPjGwYu3MSzQ7kBus7BP7KATl8KZDJAIC+CNUkOhG
         qj83/3MVojpw3w7I9GbJgTlqnwsKLD+x20LZzLDJLJyEMHKfW7QVfEHrBy32Q2t+Pozq
         S6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiUaOu2iRNFq5Ksk1hK+QZW45BRCm1sHgZZrxPYsFTY=;
        b=LE96V1LSEuOyrHZf8zJxJqW3Xr4tUXb8n2IlUYcoHQ8dLEbjgW9+gmLp2tQTu/vIRW
         KU1ZyVEiipyNb373fQ6mzX+ZAVBDir9ui+FPme94XwTIXCzD1yku0iHsh2Rpdl+mS2st
         UZmhG3+rdDJ+wxaoz1Di/K6HAP9nodZJlYsVKA8Gw6TWtXWSz3v3WpsyRP1ChGvHFsTy
         iDgnND4gZJwyMh6D7B73dMuXYXxfc3/ZyTDlgBSUny8FqCawVK+gdxuLWU3aPh32nhjU
         Da6CxebG7lkowDt8kMKK5tyWx6bYRz2+stgrCy+w7MZOU/AiTiW3x7F0KcTKPWQWfeoK
         p2uQ==
X-Gm-Message-State: AO0yUKWmkeZ+prg9cbYFoZt79DqN/OWI8JWgr8mwXmymRdR6sOHNTHup
        QzQeTkyYYV3TIWIbtheI67Q=
X-Google-Smtp-Source: AK7set+XKBRFSgUA7sYAqnOPC8tU2gAKsM8mbu9pGDCG+jk3gL7B44cIoIvKmKNIlMA20DBQiRgjwQ==
X-Received: by 2002:a17:902:d0d3:b0:194:8c75:29d with SMTP id n19-20020a170902d0d300b001948c75029dmr8883687pln.12.1675440024125;
        Fri, 03 Feb 2023 08:00:24 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0017ec1b1bf9fsm1767327pln.217.2023.02.03.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:00:23 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:00:08 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
Message-ID: <Y90viPlfxzq8UKKq@localhost>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz>
 <Y9dI88l2YJZfZ8ny@hyeyoo>
 <Y9dRlNhh6O99tg4E@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9dRlNhh6O99tg4E@casper.infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 05:11:48AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
> > > Seems like quite some changes to page_type to accomodate SLAB, which is
> > > hopefully going away soon(TM). Could we perhaps avoid that?
> > 
> > If it could be done with less changes, I'll try to avoid that.
> 
> Let me outline the idea I had for removing PG_slab:
> 
> Observe that PG_reserved and PG_slab are mutually exclusive.  Also,
> if PG_reserved is set, no other flags are set.  If PG_slab is set, only
> PG_locked is used.  Many of the flags are only for use by anon/page
> cache pages (eg referenced, uptodate, dirty, lru, active, workingset,
> waiters, error, owner_priv_1, writeback, mappedtodisk, reclaim,
> swapbacked, unevictable, mlocked).
> 
> Redefine PG_reserved as PG_kernel.  Now we can use the other _15_
> flags to indicate pagetype, as long as PG_kernel is set. 

So PG_kernel is a new special flag, I thought it indicates
"not usermappable pages", but considering PG_vmalloc it's not.

> So, eg
> PageSlab() can now be (page->flags & PG_type) == PG_slab where

But if PG_xxx and PG_slab shares same bit, PG_xxx would be confused?

> #define PG_kernel	0x00001
> #define PG_type		(PG_kernel | 0x7fff0)
> #define PG_slab		(PG_kernel | 0x00010)
> #define PG_reserved	(PG_kernel | 0x00020)
> #define PG_buddy	(PG_kernel | 0x00030)
> #define PG_offline	(PG_kernel | 0x00040)
> #define PG_table	(PG_kernel | 0x00050)
> #define PG_guard	(PG_kernel | 0x00060)
> 
> That frees up the existing PG_slab, lets us drop the page_type field
> altogether and gives us space to define all the page types we might
> want (eg PG_vmalloc)
> 
> We'll want to reorganise all the flags which are for anon/file pages
> into a contiguous block.  And now that I think about it, vmalloc pages
> can be mapped to userspace, so they can get marked dirty, so only
> 14 bits are available.  Maybe rearrange to ...
> 
> PG_locked	0x000001
> PG_writeback	0x000002
> PG_head		0x000004

I think slab still needs PG_head,
but it seems to be okay with this layout.
(but these assumpstions are better documented, I think)

> PG_dirty	0x000008
> PG_owner_priv_1	0x000010
> PG_arch_1	0x000020
> PG_private	0x000040
> PG_waiters	0x000080
> PG_kernel	0x000100
> PG_referenced	0x000200
> PG_uptodate	0x000400
> PG_lru		0x000800
> PG_active	0x001000
> PG_workingset	0x002000
> PG_error	0x004000
> PG_private_2	0x008000
> PG_mappedtodisk	0x010000
> PG_reclaim	0x020000
> PG_swapbacked	0x040000
> PG_unevictable	0x080000
> PG_mlocked	0x100000
> 
> ... or something.  There are a number of constraints and it may take
> a few iterations to get this right.  Oh, and if this is the layout
> we use, then:
> 
> PG_type		0x1fff00
> PG_reserved	(PG_kernel | 0x200)
> PG_slab		(PG_kernel | 0x400)
> PG_buddy	(PG_kernel | 0x600)
> PG_offline	(PG_kernel | 0x800)
> PG_table	(PG_kernel | 0xa00)
> PG_guard	(PG_kernel | 0xc00)
> PG_vmalloc	(PG_kernel | 0xe00)

what is PG_vmalloc for, is it just an example for
explaining possible layout?

> This is going to make show_page_flags() more complex :-P
>
> Oh, and while we're doing this, we should just make PG_mlocked
> unconditional.  NOMMU doesn't need the extra space in page flags
> (for what?  their large number of NUMA nodes?)
