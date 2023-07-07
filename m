Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77C74B24C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjGGN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGGN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:57:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF6D2108
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HOf6zW5tc2OKxnAzSW57DuGvsKKY4Rg1phen8HORVkg=; b=FvDn4P7ZEkpDde4hXJ6KlSS65n
        qjtlEYVIgCZChVeO1xO1TkXR7vBC6bACZqnbipoRMtKJ9g0TMvX9mOifU97HiUEbMUEKqDcPuO8Le
        hbeKWeuc/h+WmVaWlIWVnrwGCi/iCQiVLhVsqVePC2qVVZhMLTyZ2t7U3ffROIF7xWdehjZfYi/rN
        X7tDupOHB9wubZV29RZwWFXzbVbJho/j4gqFO+Pw1McbL2iBgG/gIe9iFMceyQ2jeV+IumaSGDqXc
        xaL4AzgCqzZJ9biTQ0ep69tneAw8Rieie8MWJkYiJwY8dwXAKbo3IuhH+5N7LAFxGsLRQfqY+WEBM
        6khm6D6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHlxE-00C4Ty-SF; Fri, 07 Jul 2023 13:57:00 +0000
Date:   Fri, 7 Jul 2023 14:57:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
Message-ID: <ZKgZrNuxuq4ACvIb@casper.infradead.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
> On 07.07.23 11:52, Ryan Roberts wrote:
> > On 07/07/2023 09:01, Huang, Ying wrote:
> > > Although we can use smaller page order for FLEXIBLE_THP, it's hard to
> > > avoid internal fragmentation completely.  So, I think that finally we
> > > will need to provide a mechanism for the users to opt out, e.g.,
> > > something like "always madvise never" via
> > > /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
> > > a good idea to reuse the existing interface of THP.
> > 
> > I wouldn't want to tie this to the existing interface, simply because that
> > implies that we would want to follow the "always" and "madvise" advice too; That
> > means that on a thp=madvise system (which is certainly the case for android and
> > other client systems) we would have to disable large anon folios for VMAs that
> > haven't explicitly opted in. That breaks the intention that this should be an
> > invisible performance boost. I think it's important to set the policy for use of
> 
> It will never ever be a completely invisible performance boost, just like
> ordinary THP.
> 
> Using the exact same existing toggle is the right thing to do. If someone
> specify "never" or "madvise", then do exactly that.
> 
> It might make sense to have more modes or additional toggles, but
> "madvise=never" means no memory waste.

I hate the existing mechanisms.  They are an abdication of our
responsibility, and an attempt to blame the user (be it the sysadmin
or the programmer) of our code for using it wrongly.  We should not
replicate this mistake.

Our code should be auto-tuning.  I posted a long, detailed outline here:
https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/

> I remember I raised it already in the past, but you *absolutely* have to
> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
> example, userfaultfd) that doesn't want the kernel to populate any
> additional page tables. So if you have to respect that already, then also
> respect MADV_HUGEPAGE, simple.

Possibly having uffd enabled on a VMA should disable using large folios,
I can get behind that.  But the notion that userspace knows what it's
doing ... hahaha.  Just ignore the madvise flags.  Userspace doesn't
know what it's doing.

