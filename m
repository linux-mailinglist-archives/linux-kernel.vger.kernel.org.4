Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC68714C42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjE2Oha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjE2OhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:37:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FD115
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:36:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-568928af8f5so11034697b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685371013; x=1687963013;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIWQIR7wu23EvgpQrMt3Yo6E002JcBFAWWYI7+iQQZo=;
        b=hcjUS9Azm3/0RU+gKaiie6ZifVpF/OCAFapGW8HSxUO0W2rMy4ULofPLAkozr5dK65
         BDXwIAbVAuU/9a+lI2H3m13nnKdLi9zmmQuy+OAud0Tyk7LSzBGneDZiQGCG1giRjNu9
         uNLOY9ugLp7w4phKfq/dZQoeuFCLLe61eTU31G57MHbDfFRtSZLl49v+kfNWsWi5cnow
         WBeAUiF/9G+YnMzJ93YlNpiESaX402fmYTQ9v4+kFDL9TaoSMswWpzsbP6ko87Ro2qDL
         jCa+etQGtPqZWRpF5v3idcRSj250qlhVNpCbJ+mqK5gUOrh2LrGExHBOAMEBuLDEOBy2
         RzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685371013; x=1687963013;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIWQIR7wu23EvgpQrMt3Yo6E002JcBFAWWYI7+iQQZo=;
        b=C2rCl2efckstYHB1/0WOHf7JKiJlo+nFLumR4wB73Fd0Zwzu3mps5NqCI42m+D6Et5
         SHf1jPzzLpfFONf+p90F79F6UYedH6dvxEGAYrbd8Y0VJmNdn37xAK8nx6L2tG85pbBu
         BQU9GozNA4DYZfTZ0HAtz/QjtaIWWFkPKJDruU4W+vREQqiDqda0S94snue93N/lN1Ut
         Hk3YB+QrDNekAyat/T1u9EckvR+wpRZJMVxbxTm0kwhXZX1ALCN5M9y3wjEy0bCfwD9Y
         tJNnE+DK9qX16p6ylsb5Q8CiIgXgRr3p+bxJ009FPaZga+dx4Q/+AF4iPdqklvQfHrF0
         VCkQ==
X-Gm-Message-State: AC+VfDzgYtzVjwj4KIRk+hpnUbV31mCRz8UJFBAGxlfm4VQCXUyNM4Fb
        GwSGSEo0tpfM+eVfp7FWWX3IZg==
X-Google-Smtp-Source: ACHHUZ7JQdplHPjQnLsPrFKY4x7o6203nPCvCFds9aIA594vHBEun4NndGVaRztw2DY/LseAyCeavw==
X-Received: by 2002:a81:a60a:0:b0:565:350f:3332 with SMTP id i10-20020a81a60a000000b00565350f3332mr10401354ywa.9.1685371012657;
        Mon, 29 May 2023 07:36:52 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u189-20020a0dd2c6000000b00559be540b56sm3639714ywd.134.2023.05.29.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 07:36:52 -0700 (PDT)
Date:   Mon, 29 May 2023 07:36:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <ZHSwWgLWaEd+zi/g@casper.infradead.org>
Message-ID: <a8df11d-55ae-64bc-edcb-d383a7a941ea@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com> <ZHSwWgLWaEd+zi/g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, Matthew Wilcox wrote:
> On Sun, May 28, 2023 at 11:20:21PM -0700, Hugh Dickins wrote:
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	struct page *page;
> > +
> > +	page = virt_to_page(pgtable);
> > +	call_rcu(&page->rcu_head, pte_free_now);
> > +}
> 
> This can't be safe (on ppc).  IIRC you might have up to 16x4k page
> tables sharing one 64kB page.  So if you have two page tables from the
> same page being defer-freed simultaneously, you'll reuse the rcu_head
> and I cannot imagine things go well from that point.

Oh yes, of course, thanks for catching that so quickly.
So my s390 and sparc implementations will be equally broken.

> 
> I have no idea how to solve this problem.

I do: I'll have to go back to the more complicated implementation we
actually ran with on powerpc - I was thinking those complications just
related to deposit/withdraw matters, forgetting the one-rcu_head issue.

It uses large (0x10000) increments of the page refcount, avoiding
call_rcu() when already active.

It's not a complication I had wanted to explain or test for now,
but we shall have to.  Should apply equally well to sparc, but s390
more of a problem, since s390 already has its own refcount cleverness.

Thanks, I must dash, out much of the day.

Hugh
