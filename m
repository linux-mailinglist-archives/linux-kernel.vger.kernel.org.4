Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901A623A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKJDbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiKJDbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:31:41 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038527935
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:31:40 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13bd2aea61bso1015789fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ/hy/T4wgKRhRUKsrzV8PS7uFOQpd7yYx7DQKU65gA=;
        b=oCel3QyLVsCQ/D5zATgx2McKI20XasvwBWa6tKvQi/0dJfSOYgbyjmiv99EjUbElwE
         vj+zBgvX0k6GRumlTEYnlsBt4MjY4d8AVsmZOVpE1EbDkLIAfDxVZsY3PxV/616lEyMO
         +6oaTDoGrUlzXXwem6FIKo4ccz6NYT6v3acyPfELOxMBAmcdP35S8aGCe9XIb6Z9mwnz
         C272VQYgutXqU48DPBJb4hkBv3VaHTX/5OSqPusziJ/x3uBWduOcfA+Mt0k7RWVF3Iji
         5yn5d0/18w8UNjGyyrQFFzYcfGMx8sgWSMzOQlxS500ZXRSqNH9RZ+HDdW0Qj39mp9T9
         eTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ/hy/T4wgKRhRUKsrzV8PS7uFOQpd7yYx7DQKU65gA=;
        b=e2DQIGLO+r30KT12ImgLRVevUYSC7QBkW7hHXMFrZg0d/KiyMlY7bbASlHmA9w613A
         ADLBevyhUAV0ceakBv/DUTe3WXbR3Pqef9ZBfTacfosoIqFGsIntRfaGfXNxLbVKiISy
         8SdFmci+b0hXX7N5Pf+4VaOW3A/Q2WWP5g6vijP4RpZe3JWAIg4KAKzJiPdyRUvsaLLc
         ByKTOWzpT9O69AV74/USjKWQ+fIY4/JyV1YHCxozVeMu55ByQYbmJ5FtTOe0JGoC4s6M
         8WVKIDf0PYJR7ioNK7QOaP9Rwe+pk1SDIo4SLxv2aWuLPeTdnfrpBZsd8p6MQLSUj/PY
         WReA==
X-Gm-Message-State: ACrzQf1VOZOelcMMTpanxuMKUkmrVFwJ50aEhkWWVysMVj1iePpiCk27
        RylGNC3Qg964gxNJltMAN7celg==
X-Google-Smtp-Source: AMsMyM5k5A7yBnhc7JIYU/ERsGQsnivx+IQ2OUPGw7FNEKphqf0Zn7M+mz1ohVFYJerHPKRFdj1Fvg==
X-Received: by 2002:a05:6871:9a:b0:13c:c941:645b with SMTP id u26-20020a056871009a00b0013cc941645bmr1091394oaa.95.1668051099606;
        Wed, 09 Nov 2022 19:31:39 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cv17-20020a056870c69100b00127d2005ea1sm6976643oab.18.2022.11.09.19.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 19:31:39 -0800 (PST)
Date:   Wed, 9 Nov 2022 19:31:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm,thp,rmap: lock_compound_mapcounts() on THP
 mapcounts
In-Reply-To: <20221105200646.wmfilka6prusrb56@box.shutemov.name>
Message-ID: <806c097-4613-de13-a5c-5bd5ab318cc9@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <1b42bd1a-8223-e827-602f-d466c2db7d3c@google.com> <20221105200646.wmfilka6prusrb56@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2022, Kirill A. Shutemov wrote:
> On Wed, Nov 02, 2022 at 06:53:45PM -0700, Hugh Dickins wrote:
> > Fix the races in maintaining compound_mapcount, subpages_mapcount and
> > subpage _mapcount by using PG_locked in the first tail of any compound
> > page for a bit_spin_lock() on such modifications; skipping the usual
> > atomic operations on those fields in this case.
> > 
> > Bring page_remove_file_rmap() and page_remove_anon_compound_rmap()
> > back into page_remove_rmap() itself.  Rearrange page_add_anon_rmap()
> > and page_add_file_rmap() and page_remove_rmap() to follow the same
> > "if (compound) {lock} else if (PageCompound) {lock} else {atomic}"
> > pattern (with a PageTransHuge in the compound test, like before, to
> > avoid BUG_ONs and optimize away that block when THP is not configured).
> > Move all the stats updates outside, after the bit_spin_locked section,
> > so that it is sure to be a leaf lock.
> > 
> > Add page_dup_compound_rmap() to manage compound locking versus atomics
> > in sync with the rest.  In particular, hugetlb pages are still using
> > the atomics: to avoid unnecessary interference there, and because they
> > never have subpage mappings; but this exception can easily be changed.
> > Conveniently, page_dup_compound_rmap() turns out to suit an anon THP's
> > __split_huge_pmd_locked() too.
> > 
> > bit_spin_lock() is not popular with PREEMPT_RT folks: but PREEMPT_RT
> > sensibly excludes TRANSPARENT_HUGEPAGE already, so its only exposure
> > is to the non-hugetlb non-THP pte-mapped compound pages (with large
> > folios being currently dependent on TRANSPARENT_HUGEPAGE).  There is
> > never any scan of subpages in this case; but we have chosen to use
> > PageCompound tests rather than PageTransCompound tests to gate the
> > use of lock_compound_mapcounts(), so that page_mapped() is correct on
> > all compound pages, whether or not TRANSPARENT_HUGEPAGE is enabled:
> > could that be a problem for PREEMPT_RT, when there is contention on
> > the lock - under heavy concurrent forking for example?  If so, then it
> > can be turned into a sleeping lock (like folio_lock()) when PREEMPT_RT.
> > 
> > A simple 100 X munmap(mmap(2GB, MAP_SHARED|MAP_POPULATE, tmpfs), 2GB)
> > took 18 seconds on small pages, and used to take 1 second on huge pages,
> > but now takes 115 milliseconds on huge pages.  Mapping by pmds a second
> > time used to take 860ms and now takes 86ms; mapping by pmds after mapping
> > by ptes (when the scan is needed) used to take 870ms and now takes 495ms.
> > Mapping huge pages by ptes is largely unaffected but variable: between 5%
> > faster and 5% slower in what I've recorded.  Contention on the lock is
> > likely to behave worse than contention on the atomics behaved.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks, Kirill; and there's a 4/3 posted to change around that
"if (compound) {lock} else if (PageCompound) {lock} else {atomic}"
ordering, which Linus hated.

But this might be a good place to mention, that Linus (I'd sent private
mail to sort out mm-unstable instabilities in a hurry, and discussion
ensued from there) does not like this patch very much, and has a good
idea for improving it, but has let us move forward with this for now.

His idea is for subpages_mapcount not to count all the ptes of subpages,
but to count all the subpages which have ptes (or I think that's one way
of saying it, but not how he said it): count what the stats need counted.

I was sceptical at first, because that was indeed something I had tried
at one point, but decided against.  I am hoping that it will turn out
just to be my prejudice: that I embarked on this job, in large part,
to get rid of the scan lurking inside total_mapcount().  And Linus's
idea would appear to bring back the unlocked scan in total_mapcount():
but remove all the locked scans in page_add/remove_rmap() - which,
setting aside my prejudice, sounds like a big improvement (in the
double-mapped case; common cases unchanged).

I was not enthusiastic, in that discussion several days ago, but got
quite excited once I had a moment to consider (but I've not told him so
until now).  I'll try to pursue it this weekend: maybe I'll rediscover
a good reason why it had to be abandoned, but let's hope it works out.

Anyway, what's in mm-unstable is good, and an improvement over the old
scans; but I appreciate Linus's frustration that it could be much better.

Hugh
