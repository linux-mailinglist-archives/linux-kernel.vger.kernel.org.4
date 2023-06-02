Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAE71F9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjFBFfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 01:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjFBFfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 01:35:19 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68219A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 22:35:16 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-568bb833462so17672367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 22:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685684115; x=1688276115;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlaitmpXRewCMQojclut1KWFgZpzrF4XDGrxy0b7AoI=;
        b=E3a6AaZ3Wcq1lZLp7NnGxoPP+Sqqvy1yK8I8U7Sr9m03K8dydeKVdp3X09jrk0mT5l
         Z4gWsI110+w/R9oqWgJirwZU62nrDu5xK430A1Pp9R8v9LU5xUjKK27fq63Q3dCxL+lK
         EOER3xk6WvrcmWXOqAulAYp17HQSfpWOFuD7ebF2cknb9e8VMLdEW32HSGJvwKQf98ax
         d5K0yw+++hRSZJGGAi/XlfXqyPj54C4Vo4rdV5xGmJz6P6/NDq2CFGmLHSiJzR8ezKb9
         GO3Du3RsU6exq6DpYJrcN85L+5XjKkr2C7r3tznXuV+dxaowhBTIMhoLLvmKkcXrv/cl
         1/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685684115; x=1688276115;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlaitmpXRewCMQojclut1KWFgZpzrF4XDGrxy0b7AoI=;
        b=DvQcxeyoT+kW3lKyJ1a2wbigZNC7iEZ6LxdUuN3jyN2lqZqyyrxOqN8wdFpcOoRofc
         ahY4d6X7V5ENV+1uQD4GhOvnlSnqF3rqVHRiuew9bBiE1lFhkuQYCaQNAg8rp0h9+bZS
         yXfj4JUNj7fvcC2QM7M34+wsNbUP2q1AuX8uH0nMnafK0lANdjutM9LA88YDT2gOjAtp
         bK/Of921ACcXtO++Cr5ISeBxQ7WSrPL5XB88mkOu/Wbxtb9Hd/0qZ5mUh3/Z+9PwPG37
         zEsmfMyFiVlsSpRLA1XQUByFYrKmmXhAV9THG/4M+P/eNECV5eJ/s8kIqPanTApfaAoT
         OYAA==
X-Gm-Message-State: AC+VfDxnD2C63SEJIa6feDV5m9G6TF9w9EvFFqmINS+u406K02ucNJFU
        3Dp0ve+40Z6/Q0OILy+lb4C8eg==
X-Google-Smtp-Source: ACHHUZ7whn1RpfZ7H7hHcynnXPMYyLfZjTq4u0ndZfcdykRJugtYK04I6kRSON6CXC6C75fb1m2BVA==
X-Received: by 2002:a0d:fdc6:0:b0:561:e944:a559 with SMTP id n189-20020a0dfdc6000000b00561e944a559mr10559756ywf.31.1685684115539;
        Thu, 01 Jun 2023 22:35:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j188-20020a0df9c5000000b0055a07e36659sm122944ywf.145.2023.06.01.22.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 22:35:14 -0700 (PDT)
Date:   Thu, 1 Jun 2023 22:35:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Subject: Re: [PATCH 02/12] mm/pgtable: add PAE safety to __pte_offset_map()
In-Reply-To: <ZHeg3oRljRn6wlLX@ziepe.ca>
Message-ID: <40349492-6f33-2a19-4a5-eabbe6b48aca@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <923480d5-35ab-7cac-79d0-343d16e29318@google.com> <ZHeg3oRljRn6wlLX@ziepe.ca>
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

On Wed, 31 May 2023, Jason Gunthorpe wrote:
> On Sun, May 28, 2023 at 11:16:16PM -0700, Hugh Dickins wrote:
> > There is a faint risk that __pte_offset_map(), on a 32-bit architecture
> > with a 64-bit pmd_t e.g. x86-32 with CONFIG_X86_PAE=y, would succeed on
> > a pmdval assembled from a pmd_low and a pmd_high which never belonged
> > together: their combination not pointing to a page table at all, perhaps
> > not even a valid pfn.  pmdp_get_lockless() is not enough to prevent that.
> > 
> > Guard against that (on such configs) by local_irq_save() blocking TLB
> > flush between present updates, as linux/pgtable.h suggests.  It's only
> > needed around the pmdp_get_lockless() in __pte_offset_map(): a race when
> > __pte_offset_map_lock() repeats the pmdp_get_lockless() after getting the
> > lock, would just send it back to __pte_offset_map() again.
> 
> What about the other places calling pmdp_get_lockless ? It seems like
> this is quietly making it part of the API that the caller must hold
> the IPIs off.

No, I'm making no judgment of other places where pmdp_get_lockless() is
used: examination might show that some need more care, but I'll just
assume that each is taking as much care as it needs.

But here where I'm making changes, I do see that we need this extra care.

> 
> And Jann had a note that this approach used by the lockless functions
> doesn't work anyhow:
> 
> https://lore.kernel.org/linux-mm/CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com/

Thanks a lot for the link: I don't know why, but I never saw that mail
thread at all before.  I have not fully digested it yet, to be honest:
MADV_DONTNEED, doesn't flush TLB yet, etc - I'll have to get into the
right frame of mind for that.

> 
> Though we never fixed it, AFAIK..

I'm certainly depending very much on pmdp_get_lockless(): and hoping to
find its case is easier to defend than at the ptep_get_lockless() level.

Thanks,
Hugh
