Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7083E712B08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbjEZQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbjEZQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DEBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685119743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sxic9C46g7G0xFpFyBBflZoBYb0LNNTJdlt5DOHiHJY=;
        b=Vmc58cnZKWrvpz9BdGFE/YK+H6XRg4aydh9q977fYTwU/7ZFqRmLzR8Fdz8gIT+MrJczhp
        tgd+SavUux/Kodb95xStHDxvWE04mu7asvDZK4/lZyIAL7TT9ABZCDeFyXLaC+b1sc98oH
        Z2piPykM7wJVg+tHc0hx8xtFH6QA0Oo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-piDNsAa4Oe-HkRLrttHJlg-1; Fri, 26 May 2023 12:48:54 -0400
X-MC-Unique: piDNsAa4Oe-HkRLrttHJlg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75cb47e5507so4137085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119733; x=1687711733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxic9C46g7G0xFpFyBBflZoBYb0LNNTJdlt5DOHiHJY=;
        b=jblXh2mgllqXNgAnjCaHJnefRoHbnrXUusuHw3ewFFjiXUxeulTCA82W0NY1Zvm53G
         0CPK22CSnpo+k+IMAFVXPz4sAWG5LISrIBHN35a9y1ANp74IyAK2WBrI6FT3+3DEFzSO
         7vORis78XbFkc832Sy9e4/VubcmvMauXg4RNpQLJetoTGy4Hrs3ed/Xa/Yp6GNkoM+8E
         /gWeFS8u5hL5A/0rmNfRO9ct66uptJWZaj0JUJkLFktTnpXJzZDTCTb9MbBw2iWl5ShM
         U3cOsF4E83EET2JJlm81RlabyqhknpH7HOWS+/48aPRR8/kdZrIvZ4vTj7BL5bf7L3pg
         jHtQ==
X-Gm-Message-State: AC+VfDxHLFMg60+yailqJYMJnFknxXX13mbYzUtE5RQZ1RQ3sMhUwqZa
        NPWwCoVI0NYr5BoOEqYMmdh7oTLZdGRL3WR4rVKch5gJh+ntnUnNwn+K5LUhaJqGP9J2VKN405N
        cQsi8xCrfHTZCBd4g9tCstMgr
X-Received: by 2002:a05:620a:8f06:b0:75b:3a99:241c with SMTP id rh6-20020a05620a8f0600b0075b3a99241cmr1986886qkn.7.1685119733667;
        Fri, 26 May 2023 09:48:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Zj6MOk0fgSC2Gs+lb8bZgbtw6HOuPPCYdHF93Hvwa10uJ6LUEwh6R8dNOTYn7x41D4Dwn9g==
X-Received: by 2002:a05:620a:8f06:b0:75b:3a99:241c with SMTP id rh6-20020a05620a8f0600b0075b3a99241cmr1986862qkn.7.1685119733280;
        Fri, 26 May 2023 09:48:53 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id c22-20020ae9e216000000b0075b18a40a85sm1289471qkc.46.2023.05.26.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:48:52 -0700 (PDT)
Date:   Fri, 26 May 2023 12:48:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Subject: Re: [PATCH 01/31] mm: use pmdp_get_lockless() without surplus
 barrier()
Message-ID: <ZHDi8q6N9BPElAMH@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <34467cca-58b6-3e64-1ee7-e3dc43257a@google.com>
 <ZG6PwAvIO4Z7lpkq@x1n>
 <427ea01f-345a-6086-d145-fe573894dbe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <427ea01f-345a-6086-d145-fe573894dbe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 03:35:01PM -0700, Hugh Dickins wrote:
> On Wed, 24 May 2023, Peter Xu wrote:
> > On Sun, May 21, 2023 at 09:49:45PM -0700, Hugh Dickins wrote:
> > > Use pmdp_get_lockless() in preference to READ_ONCE(*pmdp), to get a more
> > > reliable result with PAE (or READ_ONCE as before without PAE); and remove
> > > the unnecessary extra barrier()s which got left behind in its callers.
> > 
> > Pure question: does it mean that some of below path (missing barrier()
> > ones) could have problem when CONFIG_PAE, hence this can be seen as a
> > (potential) bug fix?
> 
> I don't think so; or at least, I am not claiming that this fixes any.
> 
> It really depends on what use is made of the pmdval afterwards, and
> I've not checked through them.  The READ_ONCE()s which were there,
> were good enough to make sure that the compiler did not reevaluate
> the pmdval later on, with perhaps a confusingly different result.
> 
> But, at least in the x86 PAE case, they were not good enough to ensure
> that the two halves of the entry match up; and, sad to say, nor is that
> absolutely guaranteed by these conversions to pmdp_get_lockless() -
> because of the "HOWEVER" below.  PeterZ's comments in linux/pgtable.h
> are well worth reading through.

Yes exactly - that's one major thing of my confusion on using
{ptep|pmdp}_get_lockless().

In irqoff ctx, AFAICT we can see a totally messed up pte/pmd with present
bit set if extremely unlucky. E.g. it can race with something like
"DONTNEED (contains tlbflush) then a POPULATE_WRITE" so we can have
"present -> present" conversion of pte when reading, so we can read half
pfn1 and then the other half pfn2.

The other confusing thing on this _lockless trick on PAE is, I think it
_might_ go wrong with devmap..

The problem is here we assumed even if high & low may not match, we still
can rely on most pte/pmd checks are done only on low bits (except _none()
check) to guarantee at least the checks are still atomic on low bits.

But it seems to me it's not true anymore if with pmd_trans_huge() after
devmap introduced, e.g.:

static inline int pmd_trans_huge(pmd_t pmd)
{
	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
}

#define _PAGE_PSE	(_AT(pteval_t, 1) << _PAGE_BIT_PSE)
#define _PAGE_BIT_PSE		7	/* 4 MB (or 2MB) page */

#define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
#define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
#define _PAGE_BIT_SOFTW4	58	/* available for programmer */

So after devmap with CONFIG_PAE, pmd_trans_huge() checks more than low bits
but also high bits.  I didn't go further to check whether there can be any
real issue but IIUC that's not expected when the low/high trick introduced
(originally introduced in commit e585513b76f7b05d sololy for x86 PAE
fast-gup only).

> 
> You might question why I made these changes at all: some days
> I question them too.  Better though imperfect?  Or deceptive?

I think it's probably a separate topic to address in all cases, so I think
this patch still make it slightly better on barrier() which I agree:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

