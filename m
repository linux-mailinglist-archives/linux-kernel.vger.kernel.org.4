Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B7719F11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjFAOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjFAOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:05 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6F192
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:00 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39a55e706deso275857b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685628419; x=1688220419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Il8ad/JyLlNtEN0Gv4lgifY2JQdLnMbUxgSHsXnJD/E=;
        b=Ja7iIoiaBZS06nl+158TUHHbNfEj3dQZ/L62R0DW/ijsVPGlsZ2O32Ba4eQCHX0zAg
         LfHMRKbOsxI5fTkJegrENtOKGl9zwk0OJLur02SGJ6GIveUDBcVkr+UhIEaFUVcRjrKv
         I+lxCwssvsZK8CqLx1MBuX6uAdKjNETkdRqy7zXaIaDyhuZ4NBPXIc4oT4Kq9QPYL/wp
         rQLV8GNPnEEDqd/Ylc/L8oZa2HjL+J1vDLj4QFw7X1INT12js5HjHN0Joz+wUbJ02lUx
         KBCcn64/pwCReWJpNIW2B8GeaXRlQuUpK9rJC0snd+LGP1JbYm8YgxK8d5hCtKnpZFl1
         SjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628419; x=1688220419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il8ad/JyLlNtEN0Gv4lgifY2JQdLnMbUxgSHsXnJD/E=;
        b=jz9Ofx0ZLKRIr6XOhwa0HYG/fWmSwbKFZzdGElta4cQd5pDUcHbS4U440neIYX/TR3
         +KX2Qxt3cqr0tOhC8JVAvz45UrKqY7U/IM2bejXmdmRXUS/2qLVW/xWqlyKo5UHBKHut
         p7OVDOV9xlhWyMxrBGfhlhv20cUJK79US3BIhFW60rEjhGaflkIhCQ6QYQSNsRG2vLqw
         8Ub7EzDwV5Fx1q2bg9l2iZcX1446VEy4lVmEaJ2Rqv2TcSFJ9779k/16h9nbZPye7He4
         v6z2AXhyo7TWV1j4M/30luTMnL2KqvXPOW2qHLM318dowWE6jmIpEKOd0ClJVdyKT7Q5
         P5Pg==
X-Gm-Message-State: AC+VfDxu5ivunbBQWZO9lJt8BBNsG1PpB8AFCj6E7x+CnKT0jM57GO1o
        eGoipEqXBDYCHsYXUsWIZgaTsw==
X-Google-Smtp-Source: ACHHUZ4AEXih+LbcgXQJ3oJivdeKU2TDKI4u9IDJeO3/vV8DGscgFzmcnAdAr6rfYy2wFC0uefsS6g==
X-Received: by 2002:a05:6808:1494:b0:398:1186:88b9 with SMTP id e20-20020a056808149400b00398118688b9mr5790684oiw.30.1685628419236;
        Thu, 01 Jun 2023 07:06:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id es1-20020a056214192100b00626195bdbbdsm5454337qvb.132.2023.06.01.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:06:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4ix7-001SP8-JZ;
        Thu, 01 Jun 2023 11:06:57 -0300
Date:   Thu, 1 Jun 2023 11:06:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
Message-ID: <ZHimAWRNDTg1JPOp@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
 <CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfhF7jMdi5Hg@mail.gmail.com>
 <ZHe0A079X9B8jWlH@x1n>
 <CAG48ez1UNFfpTUph6ZMuN61CoTGne05NLAweL_=ijRfqj5evMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1UNFfpTUph6ZMuN61CoTGne05NLAweL_=ijRfqj5evMg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:18:43AM +0200, Jann Horn wrote:

> 3. We have to *serialize* with page table walks performed by the
> IOMMU. We're doing an RCU barrier to synchronize against page table
> walks from the MMU, but without an appropriate mmu_notifier call, we
> have nothing to ensure that we aren't yanking a page table out from
> under an IOMMU page table walker while it's in the middle of its walk.
> Sure, this isn't very likely in practice, the IOMMU page table walker
> is probably pretty fast, but still we need some kind of explicit
> synchronization to make this robust, I think.

There is another thread talking about this..

Broadly we are saying that we need to call mmu ops invalidate_range at
any time the normal CPU TLB would be invalidated.

invalidate_range will not return until the iommu HW is coherent with
the current state of the page table.

Jason
