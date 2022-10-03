Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631AE5F37D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJCVdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJCVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B858B4A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664832478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rRZrqABbAJl6nJtSQCzOUEo0gY6dCRHrx7ZyLqZHrnQ=;
        b=dJLCQfNY2dhBRP5GbW+gG0RLGeNHsA7lQCZV0KCiESun/P9xTvwAGdfvBB52KJ0MX9Bicw
        NREk8TkMuwEv/BaR/rilOfiPyMncLtFPnS6bMjVHrSlnSrm30LVZ0NUeiWTZ9oTxTL9LD6
        U7ltJuFuqsk9fb5QXgjAnlgzCUy0ov4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-T8d17tvMNImmqkXX0oxNwg-1; Mon, 03 Oct 2022 17:27:57 -0400
X-MC-Unique: T8d17tvMNImmqkXX0oxNwg-1
Received: by mail-qk1-f200.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so10113289qko.17
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rRZrqABbAJl6nJtSQCzOUEo0gY6dCRHrx7ZyLqZHrnQ=;
        b=7H1IPQaroF3TJdb8DuUHoUqj0mOiLUv8wYm0Ein/caL+mRBPojfQuKPUAo8meVum3+
         Oti4i5EgTlstkF1jgHMbfvucfdaVCnIgnBJTDe9ogyOMO9hJMd5jSrFYmbEWfgUeaZyI
         sMk9BvMwnC9SD66r15XWLd6Z04Zhq0bPtzdNdmDRy61U8H1vAnjPgT7bJ8RUFDE8o7iJ
         ZL5UoU6mXRKg7WLDTMuKTYUcphkSrfCwhDKCJwrEkg2asS4c4bNTmRYwRw/bOZ+W0QWv
         QGbNveimJzZcotkgH7FfxeYLkgD7sI0N7vVayPUeWzUeGkjRvU+ZLGdKk2l8IA/s1SPV
         ISqw==
X-Gm-Message-State: ACrzQf0ycBVH2B27YOOQqE57YFq5jpCN/0+UaGl3ZweT8oVl9DJg9AAf
        s4jk/ljrL8u/cgTXIvAjI9xtN140/C4qT6fA4xbzIsDnYLFQ8J+GzPvcHJ1PDRMZ3q0WKs1h+OH
        KJRAd+Xi/TsloAyGIFEX9d0+G
X-Received: by 2002:ad4:5944:0:b0:4ad:7802:c35a with SMTP id eo4-20020ad45944000000b004ad7802c35amr17752445qvb.84.1664832476528;
        Mon, 03 Oct 2022 14:27:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4dpYFsadgte02ajtCQnVHbVKrHCOF2nTI51FBcoDopBFsDBe096LRY636BcKyBenxRodSlUg==
X-Received: by 2002:ad4:5944:0:b0:4ad:7802:c35a with SMTP id eo4-20020ad45944000000b004ad7802c35amr17752431qvb.84.1664832476333;
        Mon, 03 Oct 2022 14:27:56 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id 85-20020a370758000000b006ceb8f36302sm11494156qkh.71.2022.10.03.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 14:27:55 -0700 (PDT)
Date:   Mon, 3 Oct 2022 17:27:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
Message-ID: <YztT2OJake65WG3P@x1n>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
 <YzsZ3VV/95AvXDUz@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzsZ3VV/95AvXDUz@monkey>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 10:20:29AM -0700, Mike Kravetz wrote:
> On 10/03/22 11:56, Peter Xu wrote:
> > After the recent rework patchset of hugetlb locking on pmd sharing,
> > kselftest for userfaultfd sometimes fails on hugetlb private tests with
> > unexpected write fault checks.
> > 
> > It turns out there's nothing wrong within the locking series regarding this
> > matter, but it could have changed the timing of threads so it can trigger
> > an old bug.
> > 
> > The real bug is when we call hugetlb_no_page() we're not with the pgtable
> > lock.  It means we're reading the pte values lockless.  It's perfectly fine
> > in most cases because before we do normal page allocations we'll take the
> > lock and check pte_same() again.  However before that, there are actually
> > two paths on userfaultfd missing/minor handling that may directly move on
> > with the fault process without checking the pte values.
> > 
> > It means for these two paths we may be generating an uffd message based on
> > an unstable pte, while an unstable pte can legally be anything as long as
> > the modifier holds the pgtable lock.
> > 
> > One example, which is also what happened in the failing kselftest and
> > caused the test failure, is that for private mappings CoW can happen on one
> > page.  CoW requires pte being cleared before being replaced with a new page
> > for TLB coherency, but then there can be a race condition:
> > 
> >         thread 1                              thread 2
> >         --------                              --------
> > 
> >       hugetlb_fault                         hugetlb_fault
> >         private pte RO
> >         hugetlb_wp
> >           pgtable_lock()
> >           huge_ptep_clear_flush
> >                                               pte=NULL
> >                                               hugetlb_no_page
> >                                                 generate uffd missing event
> >                                                 even if page existed!!
> >           set_huge_pte_at
> >           pgtable_unlock()
> 
> Thanks for working on this Peter!
> 
> I agree with this patch, but I suspect the above race is not possible.  Why?
> In both cases, we take the hugetlb fault mutex when processing a huegtlb
> page fault.  This means only one thread can execute the fault code for
> a specific mapping/index at a time.  This is why I was so confused, and may
> remain a bit confused about how we end up with userfault processing a write
> fault.  It was part of the reason for my 'unclear' wording about this being
> more about cpus not seeing updated values.  Note that we do drop the fault
> mutex before calling handle_usefault, but by then we have already made the
> 'missing' determination.
> 
> Thoughts?  Perhaps, I am still confused.

It's my fault to have the commit message wrong, sorry. :) And thanks for
raising this question, I could have overlooked that.

It turns out it's not the CoW that's clearing the pte... it's the
wr-protect with huge_ptep_modify_prot_start().  So the race is with
UFFDIO_WRITEPROTECT, not CoW.

Obviously when I was tracking the hpte changes I overlooked
huge_ptep_get_and_clear(), only seeing the CoW path and I'm pretty sure
that's already a bug which was obvious enough.  I didn't prove they
happened at the same time during the MISSING event.

Then after I further looked at the CoW code I start to question myself on
why CoW would trigger at all even with an available fault mutex, since for
private mappings mapcount should be 1:

	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
		if (!PageAnonExclusive(old_page))
			page_move_anon_rmap(old_page, vma);
		if (likely(!unshare))
			set_huge_ptep_writable(vma, haddr, ptep);

		delayacct_wpcopy_end();
		return 0;
	}

There could still be something else I didn't catch, even though that may
not be relevant to this patchset anymore.

I'll wait a few more hours for other reviewers, then prepare a new version
with the corrected commit message.

Thanks,

-- 
Peter Xu

