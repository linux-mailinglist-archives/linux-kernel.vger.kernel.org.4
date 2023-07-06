Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387857492C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjGFAw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGFAwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:52:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7061995
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:52:52 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5768a7e3adbso20064717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688604771; x=1691196771;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=brYvfzxZIpzg2ekRWtSDETsKA5c6SQ0IrxunDSGxGEc=;
        b=xC2HINTq+WsZ6bkXuW3ZbQpuGJQPT0iM01isllTqlWtK8a2fGIX46T+CbpEjT8G16s
         qDwnKfQKJVRy3oyeXo3yIpwxKde63vyF9pF0VSWiUoHLL8dLOXgHf+38v8oCfcvJw4Er
         ejlXEu+OTpfpAhBvOyVGD80VixV4DfU44J6sigPGD6rA2/MjKGssOiRnE44ygD7T63vp
         t+E6BvJuJrICBNXpe1Szr6pynzSjeStiuBoj25z5M9pljiFW7x7bX1duA718XuUIxoIv
         aPIZ+mwTRAfYj6FjsOtWyUjzjmTTqQ+MgOlxxBZxAlxSWo3w6TfWylHqInFCKAu2bu68
         t/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688604771; x=1691196771;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brYvfzxZIpzg2ekRWtSDETsKA5c6SQ0IrxunDSGxGEc=;
        b=ABi54mis9uY1+wY1EJgZ4NFX1q4nGmZoRv5DVNSIMp0qjw9IsUMqj1J+vv5r+4mfM3
         NvfkDlmOhks6NttBDl4KDI1ds1GlY24pl61D03WJF7g69RwtiFfjaoD5j9pI2CVvJqtD
         StFQ2yJ7L6uRhPlb4I6ps5EoOSr0ZDX8u+cNZeNEjfdBWgfQWfNmT2IEQfEYgSI2vRb5
         OclBNrNYfyduYvPg7MqaNAmAWcFhbzcsJIYYWRtPk5gZ+vQxQguhgWF3xv83USMZMQCR
         LaqdVHaTlCL5KH+2SEVxgz6tmeZ4QG+fr6976aPgB3nt7P68J9rALSPpkYmSw08LpSxY
         wkFg==
X-Gm-Message-State: ABy/qLapBfvkVSU5uS7OncEtyxUWyRxZmZ2IuRXqSxyyKKeHbw3Pk+Qf
        4P4Oxqb92w+cPtZEq0LjtqdrGA==
X-Google-Smtp-Source: APBJJlGRAVoxAYVowQcijWwmVf4ESHfCTlO+TpznIilMWn3o7JH0E6ojbd/bR9jPjq/VIj7YN/NLDQ==
X-Received: by 2002:a0d:dfca:0:b0:56c:fbd2:edec with SMTP id i193-20020a0ddfca000000b0056cfbd2edecmr557929ywe.6.1688604771513;
        Wed, 05 Jul 2023 17:52:51 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o207-20020a0dccd8000000b00568c1c919d2sm29463ywd.29.2023.07.05.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 17:52:51 -0700 (PDT)
Date:   Wed, 5 Jul 2023 17:52:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alexander Gordeev <agordeev@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <ZKUR0HItN2Va8J1D@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <8c6a4a46-2d17-8cfb-50f-f89f1d44973f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca> <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com> <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com> <ZKUR0HItN2Va8J1D@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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

On Wed, 5 Jul 2023, Alexander Gordeev wrote:
> On Sat, Jul 01, 2023 at 09:32:38PM -0700, Hugh Dickins wrote:
> > On Thu, 29 Jun 2023, Hugh Dickins wrote:
> 
> Hi Hugh,
> 
> ...
> 
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> > +{
> > +	struct page *page;
> 
> If I got your and Claudio conversation right, you were going to add
> here WARN_ON_ONCE() in case of mm_alloc_pgste(mm)?

Well, Claudio approved, so I would have put it in, if we had stuck with
that version which had "if (mm_alloc_pgste(mm)) {" in pte_free_defer();
but once that went away, it became somewhat irrelevant... to me anyway.

But I don't mind adding it here, in the v3 I'll post when -rc1 is out,
if it might help you guys - there is some point, since pte_free_defer()
is a route which can usefully check for such a case, without confusion
from harmless traffic from immediate frees of just-in-case allocations.

But don't expect it to catch all such cases (if they exist): another
category of s390 page_table_free()s comes from the PageAnon
zap_deposited_table() in zap_huge_pmd(): those tables might or might
not have been exposed to userspace at some time in the past.

I'll add the WARN_ON_ONCE in pte_free_defer() (after checking that
WARN_ON_ONCE is the one we want - I get confused by all the different
flavours of WARN, and have to check the header file each time to be
sure of the syntax and semantics): but be aware that it won't be
checking all potential cases.

Hugh

> 
> > +	page = virt_to_page(pgtable);
> > +	SetPageActive(page);
> > +	page_table_free(mm, (unsigned long *)pgtable);
> > +}
> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +
> >  /*
> >   * Base infrastructure required to generate basic asces, region, segment,
> >   * and page tables that do not make use of enhanced features like EDAT1.
> 
> Thanks!
