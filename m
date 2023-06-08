Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3DE7281EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjFHN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjFHN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:58:37 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77B26AB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:58:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38dec65ab50so414949b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686232715; x=1688824715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNu2/S7sKOt+ubQCHoHXnO+tkZORQ3Sbd1tjf3f4Mr4=;
        b=c3kx8K7tTcukv+anoLR5JE3/ubg8q5CO3nzZOO6SU5CXIix8vczuprLx4rXVDWTdEX
         hs+E+zzja4ua8gGSjBrbVm6Ep8+L0fOEvdhrqVYJLxFv130wvOZzdjAaB2Flhgb2TRRb
         uqPK/7XI63a9Wl2IZQN4DEejxckFyPyr0xFuvLWArVQ/+f9ud9V5FeMXJ6bonL6nPSkP
         ZAWsLq+XfvZHPiGRN/xo7lAPtKsiLx+Q72RSIJ86pzS9EcuyNwtp9F9J96kqArgULjkv
         3GfO6CrfSEhxuYeCqGRvjyHkvsZI1BdV24dd8bBsMQRPPswYuaCUpkJe5qj8Iwetk/KI
         UiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232715; x=1688824715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNu2/S7sKOt+ubQCHoHXnO+tkZORQ3Sbd1tjf3f4Mr4=;
        b=hxNeH8VZk0srKpEQXks3zOdCzjJl8/4k1I9LQnpEvwooTN4OqDOtcAnNLVsnWGF1T1
         1DFfiaYfaoS0P2T1y9q5VLrK8IgVzZRSjHF6DPH4hwO+W/+O3mJh02BjZ2B1qekDKDNJ
         GJL8tqZYMBNHc2zPvK7omTm3BEF2qenOSyn7P6D7TkxAGBu5eBtu1435OCpoeN0dprRH
         7iCWxMOEomvWzSJDMk2qsp5la0536R1YwBUpSYgtJ5decIoqEnw/FEMbKJSKo0XgLu5C
         AHlYSoVxuif4+P6kpRIZlUHJWs++NEkxYYSwMKMMt+2wUYLn9f99hsLPKB0D0xe4TPTl
         qerw==
X-Gm-Message-State: AC+VfDw33CKJQxL1Ar62JGyNkkF4cvQaMnmmNM2MlIlkjTPIdsOsKVXI
        KbKWZEYhT2dg8YRzLRrSq2gO7Q==
X-Google-Smtp-Source: ACHHUZ79SDvHlQrsY3n06C+42lQZ8V3VBEDt3rX4FxqxgeXDKorKznGSCHqgRSC89Wx2XwVPR9xrlA==
X-Received: by 2002:aca:90e:0:b0:397:f9f2:76b with SMTP id 14-20020aca090e000000b00397f9f2076bmr8071851oij.30.1686232715650;
        Thu, 08 Jun 2023 06:58:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id pg4-20020a17090b1e0400b00256a4d59bfasm3119836pjb.23.2023.06.08.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:58:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q7G9o-003TSq-VU;
        Thu, 08 Jun 2023 10:58:32 -0300
Date:   Thu, 8 Jun 2023 10:58:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
Message-ID: <ZIHeiDf9srvRagfr@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com>
 <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com>
 <20230606214037.09c6b280@thinkpad-T15>
 <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:35:05PM -0700, Hugh Dickins wrote:

> My current thinking (but may be proved wrong) is along the lines of:
> why does something on its way to being freed need to be on any list
> than the rcu_head list?  I expect the current answer is, that the
> other half is allocated, so the page won't be freed; but I hope that
> we can put it back on that list once we're through with the rcu_head.

I was having the same thought. It is pretty tricky, but if this was
made into some core helper then PPC and S390 could both use it and PPC
would get a nice upgrade to have the S390 frag re-use instead of
leaking frags.

Broadly we have three states:

 all frags free
 at least one frag free
 all frags used

'all frags free' should be returned to the allocator
'at least one frag free' should have the struct page on the mmu_struct's list
'all frags used' should be on no list.

So if we go from 
  all frags used -> at least one frag free
Then we put it on the RCU then the RCU puts it on the mmu_struct list

If we go from 
   at least one frag free -> all frags free
Then we take it off the mmu_struct list, put it on the RCU, and RCU
frees it.

Your trick to put the list_head for the mm_struct list into the frag
memory looks like the right direction. So 'at least one frag free' has
a single already RCU free'd frag hold the list head pointer. Thus we
never use the LRU and the rcu_head is always available.

The struct page itself can contain the actual free frag bitmask.

I think if we split up the memory used for pt_frag_refcount we can get
enough bits to keep track of everything. With only 2-4 frags we should
be OK.

So we track this data in the struct page:
  - Current RCU free TODO bitmask - if non-zero then a RCU is already
    triggered
  - Next RCU TODO bitmaks - If an RCU is already triggrered then we
    accumulate more free'd frags here
  - Current Free Bits - Only updated by the RCU callback

?

We'd also need to store the mmu_struct pointer in the struct page for
the RCU to be able to add/remove from the mm_struct list.

I'm not sure how much of the work can be done with atomics and how
much would need to rely on spinlock inside the mm_struct.

It feels feasible and not so bad. :)

Figure it out and test it on S390 then make power use the same common
code, and we get full RCU page table freeing using a reliable rcu_head
on both of these previously troublesome architectures :) Yay

Jason
