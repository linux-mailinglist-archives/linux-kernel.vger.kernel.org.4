Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFB6B2DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCITcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCITbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72645F1449
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678390191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rjkLnFnFbXNnmU+t7ss87Y2e6BpbMdJhJqRqbf2LnQ=;
        b=dclBlltUwmBLE/Vibv8KQR97GDUP/fNJTIu6fEjKrThXvQW3VsDFt4Rzmx2FgaQeNH4T1q
        t7Rzd7AXr5pDFAr7qjCOmg242LM3cuwKb4u+woqjA+aUXQ+KK8X5YZDog0BCFShp7pqqlz
        Hwz4jDBZBXWOnqXVPlwnA/XzGLdcBB0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-3xAQxqgFOkCpyAe1_MmWSQ-1; Thu, 09 Mar 2023 14:29:50 -0500
X-MC-Unique: 3xAQxqgFOkCpyAe1_MmWSQ-1
Received: by mail-qv1-f69.google.com with SMTP id y6-20020ad457c6000000b00535261af1b1so1756949qvx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rjkLnFnFbXNnmU+t7ss87Y2e6BpbMdJhJqRqbf2LnQ=;
        b=3okoOWpvU56kp7re4gEwGh6knzoBk+MjaPbC46ncwvmQglHsBAqxz8zYrm6DGPZLXw
         qZ4Jhm97oP5Mr9EFW4N2zP/3B0z1m+ZwxwSpdCkeaE8ofaHH/tPinZPAcz0RNtQUPtfu
         DigJtVuedKd2xQxHRp15Q4efLrA9dK/e0ldvwwoMzQSmcMSexmSWCgvD31oSyHhfF/jV
         G6lGxNjKGpdG8m+AhKYBrT50vkTD/WlyjsR1xZDxEO4GIbw664oZ5yB9TlLjXqy3unpx
         2t5HVUPPdeXrNbAFEwrbcU7ok83PjDAbChNBOITJn0Ivg3RSJUxzWhPvdpgt7CoCUc2X
         OxPg==
X-Gm-Message-State: AO0yUKWsgAGm9Rm7t7F+BrexPGc2OjwWVajuBnJYtjA7yglNm/1pHo7S
        E0OFiY0DHSwdDIo/HT7+b/H7XW20ux7pzYDswACNzsGJM1UKforpH8fayCGkMKmnzqF/BhHZwvC
        +JpEzzh04ReSFvCDbQE3JyHtL
X-Received: by 2002:a05:6214:2027:b0:53a:3591:1e49 with SMTP id 7-20020a056214202700b0053a35911e49mr653248qvf.1.1678390189865;
        Thu, 09 Mar 2023 11:29:49 -0800 (PST)
X-Google-Smtp-Source: AK7set9hev3mSeA0Fa08ehlYVEigim0ZGbXOSN7+pZAgsmmPDmLT6cjm//xKGgRn8uChiHS67OjTmw==
X-Received: by 2002:a05:6214:2027:b0:53a:3591:1e49 with SMTP id 7-20020a056214202700b0053a35911e49mr653212qvf.1.1678390189473;
        Thu, 09 Mar 2023 11:29:49 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a12a800b007427fce1377sm4973944qki.7.2023.03.09.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:29:49 -0800 (PST)
Date:   Thu, 9 Mar 2023 14:29:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: rmap: merge HugeTLB mapcount logic with THPs
Message-ID: <ZAozq9a25utZtsaD@x1n>
References: <20230306230004.1387007-1-jthoughton@google.com>
 <ZAkH4cImuFttLuDQ@x1n>
 <CADrL8HXk6F+7N9sYfFb3Q=T9Tda2+St1JoBCThrgc2j2yU3bcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HXk6F+7N9sYfFb3Q=T9Tda2+St1JoBCThrgc2j2yU3bcQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:05:12AM -0800, James Houghton wrote:
> On Wed, Mar 8, 2023 at 2:10 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Mar 06, 2023 at 11:00:02PM +0000, James Houghton wrote:
> > > HugeTLB pages may soon support being mapped with PTEs. To allow for this
> > > case, merge HugeTLB's mapcount scheme with THP's.
> > >
> > > The first patch of this series comes from the HugeTLB high-granularity
> > > mapping series[1], though with some updates, as the original version
> > > was buggy[2] and incomplete.
> > >
> > > I am sending this change as part of this smaller series in hopes that it
> > > can be more thoroughly scrutinized.
> > >
> > > I haven't run any THP performance tests with this series applied.
> > > HugeTLB pages don't currently support being mapped with
> > > `compound=false`, but this mapcount scheme will make collapsing
> > > compound=false mappings in HugeTLB pages quite slow. This can be
> > > optimized with future patches (likely by taking advantage of HugeTLB's
> > > alignment guarantees).
> > >
> > > Matthew Wilcox is working on a mapcounting scheme[3] that will avoid
> > > the use of each subpage's mapcount. If this series is applied, Matthew's
> > > new scheme will automatically apply to HugeTLB pages.
> >
> > Is this the plan?
> >
> > I may have not followed closely on the latest development of Matthew's
> > idea.  The thing is if the design requires ptes being installed / removed
> > at the same time for the whole folio, then it may not work directly for HGM
> > if HGM wants to support at least postcopy, iiuc, because if we install the
> > whole folio ptes at the same time it seems to beat the whole purpose of
> > having HGM..
> 
> My understanding is that it doesn't *require* all the PTEs in a folio
> to be mapped at the same time. I don't see how it possibly could,
> given that UFFDIO_CONTINUE exists (which can already create PTE-mapped
> THPs today). It would be faster to populate all the PTEs at the same
> time (you would only need to traverse the page table once for the
> entire group to see if you should be incrementing mapcount).
> 
> Though, with respect to unmapping, if PTEs aren't all unmapped at the
> same time, then you could end up with a case where mapcount is still
> incremented but nothing is really mapped. I'm not really sure what
> should be done there, but this problem applies to PTE-mapped THPs the
> same way that it applies to HGMed HugeTLB pages.
> 
> > The patch (especially patch 1) looks good.  So it's a pure question just to
> > make sure we're on the same page.  IIUC your other mapcount proposal may
> > work, but it still needs to be able to take care of ptes in less-than-folio
> > sizes whatever it'll look like at last.
> 
> By my "other mapcount proposal", I assume you mean the "using the
> PAGE_SPECIAL bit to track if mapcount has been incremented or not". It
> really only serves as an optimization for Matthew's scheme (see below
> [2] for some more thoughts), and it doesn't have to only apply to
> HugeTLB.
> 
> I originally thought[1] that Matthew's scheme would be really painful
> for postcopy for HGM without this optimization, but it's actually not
> so bad. Let's assume the worst case, that we're UFFDIO_CONTINUEing
> from the end to the beginning, like in [1]:
> 
> First CONTINUE: pvmw finds an empty PUD, so quickly returns false.
> Second CONTINUE: pvmw finds 511 empty PMDs, then finds 511 empty PTEs,
> then finds a present PTE (from the first CONTINUE).
> Third CONTINUE: pvmw finds 511 empty PMDs, then finds 510 empty PTEs.
> ...
> 514th CONTINUE: pvmw finds 510 empty PMDs, then finds 511 empty PTEs.
> 
> So it'll be slow, but it won't have to check 262k empty PTEs per
> CONTINUE (though you could make this possible with MADV_DONTNEED).
> Even with an HGM implementation that only allows PTE-mapping of
> HugeTLB pages, it should still behave just like this, too.
> 
> > A trivial comment on patch 2 since we're at it: does "a future plan on some
> > arch to support 512GB huge page" justify itself?  It would be better
> > justified, IMHO, when that support is added (and decided to use HGM)?
> 
> That's fine with me. I'm happy to drop that patch.
> 
> > What I feel like is missing (rather than patch 2 itself) is some guard to
> > make sure thp mapcountings will not be abused with new hugetlb sizes
> > coming.
> >
> > How about another BUG_ON() squashed into patch 1 (probably somewhere in
> > page_add_file|anon_rmap()) to make sure folio_size() is always smaller than
> > COMPOUND_MAPPED / 2)?
> 
> Sure, I can add that.
> 
> Thanks, Peter!
> 
> - James
> 
> [1]: https://lore.kernel.org/linux-mm/CADrL8HUrEgt+1qAtEsOHuQeA+WWnggGfLj8_nqHF0k-pqPi52w@mail.gmail.com/
> 
> [2]: Some details on what the optimization might look like:
> 
> So an excerpt of Matthew's scheme would look something like this:
> 
>     /* if we're mapping < folio_nr_pages(folio) worth of PTEs. */
>     if (!folio_has_ptes(folio, vma))
>       atomic_inc(folio->_mapcount);
> 
> where folio_has_ptes() is defined like:
> 
>     if (!page_vma_mapped_walk(...))
>       return false;
>     page_vma_mapped_walk_done(...);
>     return true;
> 
> You might be able to optimize folio_has_ptes() with a block like this
> at the beginning:
> 
>     if (folio_is_naturally_aligned(folio, vma)) {
>       /* optimization for naturally-aligned folios. */
>       if (folio_test_hugetlb(folio)) {
>         /* check hstate-level PTE, and do a similar check as below. */
>       }
>       /* for naturally-aligned THPs: */
>       pmdp = mm_find_pmd(...); /* or just pass it in. */
>       pmd = READ_ONCE(*pmdp);
>       BUG_ON(!pmd_present(pmd) || pmd_leaf(pmd));
>       if (pmd_special(pmd))
>         return true;
>       /* we already hold the PTL for the PTE. */
>       ptl = pmd_lock(mm, pmdp);
>       /* test and set pmd_special */
>       pmd_unlock(ptl)
>       return if_we_set_pmd_special;
>     }
> 
> (pmd_special() doesn't currently exist.) If HugeTLB walking code can
> be merged with generic mm, then HugeTLB wouldn't have a special case
> at all here.

I see what you mean now, thanks.  That looks fine.  I just suspect the
pte_special trick will still be needed if this will start to apply to HGM,
as it seems to not suite perfectly with a large folio size, still.  The
MADV_DONTNEED worst case of having it loop over ~folio_size() times of none
pte is still possible.

-- 
Peter Xu

