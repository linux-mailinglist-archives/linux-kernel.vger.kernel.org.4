Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631CF7490FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGEW0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGEW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:26:27 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A701732
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:26:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579d5d89b41so1265767b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688595984; x=1691187984;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDnLbLcuwE9iQDqKqrCS7qCokL1RGxXvXlYeJ0eQJ30=;
        b=6CKi5YkaqWX/DZe4AMMnKGlm9x+zYXWWqEFIrjF2CbV+djK2HBa8nIZsU/YUdnOmoB
         VemKz95l3SrvYuLVN6zF1ce5fk40ps0gEcLJE2HpN36h19GOUaVyEeWQpuJw/+8WNozs
         ANZmq1YW4CC4njb5cWLXjuny4iksiCVizwZTGMlRQ58IpEPfAt6NuWIWJPtw39soLPO+
         R6PoAQK6bI2BLH2YkpUT5pjPIcfCcBUhu+Yi1VKb+SzC/yKngcpBkWwS5zWfYgJAdMnl
         x1RSXOsAiqUJ1X89Immik9GKYJPLQlHmLCCUxvdSGHgxasv9zIuqZxf+suSs87SBgsGD
         DDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688595984; x=1691187984;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDnLbLcuwE9iQDqKqrCS7qCokL1RGxXvXlYeJ0eQJ30=;
        b=Zh9VOJrGvwQnBD6uPto7V/BSzSNNL14M9p81WlmqYqoda5GWUvTbwMHT54ka7LYiOB
         cUV1GQ0CYYWOtJ4MMGUcVrD9AV+qvbwqqh6R9ARTSlmuAFdMTUrqtgw9r/rugHdRsy4Z
         WEyTSW2dgOiEl5HAf/asirOFsLPnJ4vKRW15ZCiGvrEm2XKzjntYdtkEIro8bEMiEHni
         6Vyl4UEQ343zpchLSsJ8SUXl0kmR4hazWCtlIVW4VArbyjwTf4mfsacarcnG7GM82Xrm
         ZcEJ5OAvnJYLsoy9KS1HHkInRJ2d0FFaOHRHhLwcEHGaibySAE5p+qs4A0hJW14mTNEj
         ATUA==
X-Gm-Message-State: ABy/qLZCtqGtyyqEMeh6YpgIUPjhDPCDToX45wZHsTCaDCUCGsfiJ1Xv
        oZA6OIXal52tpHO2QJOnqrbG0Q==
X-Google-Smtp-Source: APBJJlHqGpoZ+nLiN32zt+ZgOuEAR9yG9oiJSFv2dzaPuHS4wUlJAw2cpnmLLKyZe4ZXfSxoqplOEw==
X-Received: by 2002:a0d:d40d:0:b0:577:2bcf:8f0e with SMTP id w13-20020a0dd40d000000b005772bcf8f0emr186530ywd.51.1688595984607;
        Wed, 05 Jul 2023 15:26:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x132-20020a81638a000000b00576beffe858sm5718746ywb.97.2023.07.05.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 15:26:24 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:26:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/31] mm/pgtable: allow pte_offset_map[_lock]() to
 fail
In-Reply-To: <87y1juxvmb.fsf@linux.ibm.com>
Message-ID: <1bb35f43-8556-8654-b11d-98ecc1f1dc0@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <8218ffdc-8be-54e5-0a8-83f5542af283@google.com> <87y1juxvmb.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aneesh,

On Wed, 5 Jul 2023, Aneesh Kumar K.V wrote:
> 
> Hi Hugh,
> 
> Sorry for not checking about this before.

I was about to say "No problem" - but it appears I would be lying!

> I am looking at a kernel
> crash (BUG_ON()) on ppc64 with 4K page size. The reason we hit
> BUG_ON() is beause we have pmd_same calling BUG_ON on 4K with hash
> translation. We don't support THP with 4k page size and hash
> translation.

I misunderstood you at first.  I was trying to work out what in that
context might lead to *pmd changing suddenly, was going to ask for
stack backtrace (in faulting? or in copying mm? or?), whether you
have PER_VMA_LOCK enabled, etc. etc.

Then I looked at the source: oh, that is gross, and not something
I had expected at all.

> > +pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> > +			     unsigned long addr, spinlock_t **ptlp)
> > +{
> > +	spinlock_t *ptl;
> > +	pmd_t pmdval;
> > +	pte_t *pte;
> > +again:
> > +	pte = __pte_offset_map(pmd, addr, &pmdval);
> > +	if (unlikely(!pte))
> > +		return pte;
> > +	ptl = pte_lockptr(mm, &pmdval);
> > +	spin_lock(ptl);
> > +	if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> > +		*ptlp = ptl;
> > +		return pte;
> > +	}
> > +	pte_unmap_unlock(pte, ptl);
> > +	goto again;
> > +}
> 
> What is expected by that pmd_same check? We are holding pte lock
> and not pmd lock. So contents of pmd can change.

And you don't need me to answer that question: the answer is in the
"likely".  We do not expect *pmd to change there (though maybe some
ancillary bits of it, like "accessed"), unless the page table is on
its way to being freed; and other locking higher up (mmap_lock or
rmap lock) prevent all possibilities of that at present.  Later, we
arrange to hold pte lock as well as pmd lock when removing page table.

So the obvious quick fix is:

--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -138,8 +138,7 @@ static inline int hash__pmd_trans_huge(p
 
 static inline int hash__pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
-	BUG();
-	return 0;
+	return 1;
 }
 
 static inline pmd_t hash__pmd_mkhuge(pmd_t pmd)

But I hope you will reject that as almost as gross, and instead commit
a patch which makes hash__pmd_same() ... check whether the pmd_ts are the
same - as in ppc64's other implementations.  That will save having to change
it again, when/if someone extends the current replace-page-table-by-THP work
by non-THP work to remove empty page tables without mmap_lock or rmap lock.

Thanks for finding this, Aneesh, and I'm sorry I didn't notice it before,
and I'm sorry to have given you trouble... but really, that BUG(),

(H)ugh!
