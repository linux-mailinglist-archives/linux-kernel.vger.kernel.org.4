Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B735E619AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKDPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282BEA7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667574171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=760mHfCsMBzfAvIYgQ085mME4hkndza7s7oPPqSIMRU=;
        b=U5Zd0PFdfqjfo0KwaPZwKtcVL2ashkrQvd9zv2SnyCdcmY1gTe3waglwnwUco5YpQNg2W8
        5CcShGQ4Mkh8PkD4I0w4I82eaDa92mM/fKbs7mQkkguu7atj/EZBYm3KFT1u+qkoA5G1YP
        Wx/XaUYapB9odBgVA0zQq72Y5zWnGvE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-kVZgo4GuNOmKoGx0W3MAvA-1; Fri, 04 Nov 2022 11:02:50 -0400
X-MC-Unique: kVZgo4GuNOmKoGx0W3MAvA-1
Received: by mail-qv1-f70.google.com with SMTP id mo15-20020a056214330f00b004b96d712bccso3416194qvb.22
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=760mHfCsMBzfAvIYgQ085mME4hkndza7s7oPPqSIMRU=;
        b=aCErbNMX63haRlWDIF37sSQ6A2xKUSl9/5gdmuukk+QvkpMnqfMf0DX09BAjdN2ruJ
         GKr57IMgJLXFFcDG/BFHMUFdqI6mbZ2ZPnZCpHi0BWTlIGd8uixCQJL8z9Irew7ZbkjV
         e3ejDBMdox2siwZH6hcD7I/z3cCkTcINw9+pBBB2e7Bin9rSw+6ltQq/ilgFyf7FFjSj
         M1KAp6gWwNfVmUK7galGUduJ0kC5fRX1VMSW8Qo2LJNRA1k1I6HlyZ6Un43n9KYOwRS6
         VZNBxw7kWdoU5Vc5vHadpe18Bz6JDhXCC1HAWwbwB9o42c+VQ+WiDBSNTxZdhGquE6nE
         OZ4A==
X-Gm-Message-State: ACrzQf3LWcd8lhOk5qk41myjq5bQRKUn4gJFvTXMlSL3o6qSlr2p+0UR
        BKFO0IFRTIXzWC9wQALL7UYYae0pfBpy+CRNnKIpKNcjLU6HKMRlHGgz3CDSq3laChQFS2G2YHL
        WzbSOaqMIW4vRW/1k9kQ2taxt
X-Received: by 2002:a05:620a:12b8:b0:6f9:9b46:5318 with SMTP id x24-20020a05620a12b800b006f99b465318mr283278qki.767.1667574169460;
        Fri, 04 Nov 2022 08:02:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5y1m/0oHGuPZdsjlLqFYyIeoduRxO9AgJ40X0jo+tk8egpAUGd+LkjCLLhziknLtD0sSdfbA==
X-Received: by 2002:a05:620a:12b8:b0:6f9:9b46:5318 with SMTP id x24-20020a05620a12b800b006f99b465318mr283275qki.767.1667574169082;
        Fri, 04 Nov 2022 08:02:49 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a70-20020ae9e849000000b006ce40fbb8f6sm3032758qkg.21.2022.11.04.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:02:48 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:02:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-ID: <Y2UplvB0dgQYIZWm@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <Y2RbGpQooJRq/gCg@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2RbGpQooJRq/gCg@monkey>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Thu, Nov 03, 2022 at 05:21:46PM -0700, Mike Kravetz wrote:
> On 10/30/22 17:29, Peter Xu wrote:
> > Resolution
> > ==========
> > 
> > What this patch proposed is, besides using the vma lock, we can also use
> > RCU to protect the pgtable page from being freed from under us when
> > huge_pte_offset() is used.  The idea is kind of similar to RCU fast-gup.
> > Note that fast-gup is very safe regarding pmd unsharing even before vma
> > lock, because fast-gup relies on RCU to protect walking any pgtable page,
> > including another mm's.
> > 
> > To apply the same idea to huge_pte_offset(), it means with proper RCU
> > protection the pte_t* pointer returned from huge_pte_offset() can also be
> > always safe to access and de-reference, along with the pgtable lock that
> > was bound to the pgtable page.
> > 
> > Patch Layout
> > ============
> > 
> > Patch 1 is a trivial cleanup that I noticed when working on this.  Please
> > shoot if anyone think I should just post it separately, or hopefully I can
> > still just carry it over.
> > 
> > Patch 2 is the gut of the patchset, describing how we should use the helper
> > huge_pte_offset() correctly. Only a comment patch but should be the most
> > important one, as the follow up patches are just trying to follow the rule
> > it setup here.
> > 
> > The rest patches resolve all the call sites of huge_pte_offset() to make
> > sure either it's with the vma lock (which is perfectly good enough for
> > safety in this case; the last patch commented on all those callers to make
> > sure we won't miss a single case, and why they're safe).  Besides, each of
> > the patch will add rcu protection to one caller of huge_pte_offset().
> > 
> > Tests
> > =====
> > 
> > Only lightly tested on hugetlb kselftests including uffd, no more errors
> > triggered than current mm-unstable (hugetlb-madvise fails before/after
> > here, with error "Unexpected number of free huge pages line 207"; haven't
> > really got time to look into it).
> 
> Do not worry about the madvise test failure, that is caused by a recent
> change.
> 
> Unless I am missing something, the basic strategy in this series is to
> wrap calls to huge_pte_offset and subsequent ptep access with
> rcu_read_lock/unlock calls.  I must embarrassingly admit that it has
> been a loooong time since I had to look at rcu usage and may not know
> what I am talking about.  However, I seem to recall that one needs to
> somehow flag the data items being protected from update/freeing.  I
> do not see anything like that in the huge_pmd_unshare routine where
> pmd page pointer is updated.  Or, is it where the pmd page pointer is
> referenced in huge_pte_offset?

Right.  The RCU proposed here is trying to protect the pmd pgtable page
that will normally be freed in rcu pattern.  Please refer to
tlb_remove_table_free() (which can be called from tlb_finish_mmu()) where
it's released with RCU API:

	call_rcu(&batch->rcu, tlb_remove_table_rcu);

I mentioned fast-gup just to refererence on the same usage as fast-gup has
the same risk if without RCU or similar protections that is IPI-based, but
I definitely can be even clearer, and I will enrich the cover letter in the
next post.

In short, my understanding is pgtable pages (including the shared PUD page
for hugetlb) needs to be freed with caution because there can be softwares
that are walking the pages with no locks.  In our case, even though
huge_pte_offset() is with the mmap lock, due to the pmd sharing it's not
always having the same mmap lock as when the pgtable needs to be freed, so
it's similar to having no lock here, imo.  Then huge_pte_offset() needs to
be protected just like what we do with fast-gup.

Please also feel free to refer to the comment chunk at the start of
asm-generic/tlb.h for more information on the mmu gather API.

> 
> Please ignore if you are certain of this rcu usage, otherwise I will
> spend some time reeducating myself.

I'm not certain, and I'd like to get any form of comment. :)

Sorry if this RFC version is confusing, but if it can try to at least
explain what the problem we have and if we can agree on the problem first
then that'll already be a step forward to me.  So far that's more important
than how we resolve it, using RCU or vma lock or anything else.

For a non-rfc series, I think I need to be more careful on some details,
e.g., the RCU protection for pgtable page is only used when the arch
supports MMU_GATHER_RCU_TABLE_FREE.  I thought that's always supported at
least for pmd sharing enabled archs, but I'm actually wrong:

arch/arm64/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
arch/riscv/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
arch/x86/Kconfig:       select ARCH_WANT_HUGE_PMD_SHARE

arch/arm/Kconfig:       select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
arch/arm64/Kconfig:     select MMU_GATHER_RCU_TABLE_FREE
arch/powerpc/Kconfig:   select MMU_GATHER_RCU_TABLE_FREE
arch/s390/Kconfig:      select MMU_GATHER_RCU_TABLE_FREE
arch/sparc/Kconfig:     select MMU_GATHER_RCU_TABLE_FREE if SMP
arch/sparc/include/asm/tlb_64.h:#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
arch/x86/Kconfig:       select MMU_GATHER_RCU_TABLE_FREE        if PARAVIRT

I think it means at least on RISCV RCU_TABLE_FREE is not enabled and we'll
need to rely on the IPIs (e.g. I think we need to replace rcu_read_lock()
with local_irq_disable() on RISCV only for what this patchset wanted to
do).  In the next version, I plan to add a helper, let's name it
huge_pte_walker_lock() for now, and it should be one of the three options:

  - if !ARCH_WANT_HUGE_PMD_SHARE:      it's no-op
  - else if MMU_GATHER_RCU_TABLE_FREE: it should be rcu_read_lock()
  - else:                              it should be local_irq_disable()

With that, I think we'll strictly follow what we have with fast-gup, at the
meantime it should add zero overhead on archs that does not have pmd sharing.

Hope above helps a bit on extending the missing pieces of the cover
letter.  Or again if anything missing I'd be more than glad to know..

Thanks,

-- 
Peter Xu

