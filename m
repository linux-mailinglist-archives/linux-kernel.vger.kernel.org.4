Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9661B740551
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjF0Uxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjF0Uxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:53:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDE19A9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:53:23 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1a47b33d8so4435820b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687899202; x=1690491202;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFHD0hnOjuhPYILDUOJLbgwpgA6DIsDBsAhcitDEBFU=;
        b=AyDbzfEOwQNJQ3Q6vCBJpIzejWz0XI+CwqIDE8UgstFVF4GBN1zCUvimRHgNDXa99Q
         0A2XitElZYl4vkOr9ytUm0PmYJ5QsEPCI+4zrbGGcbdnAJac6UffXXzvU8rbykoGAN78
         RiYeGRGQi0rsCCIEmUY28CGLOcGd0QWkwDLQhn+j3WVmaQn0hiL1rrTM2ApFwPn3rmOW
         aIKz2rrQIuBq1j3yLWNWP1JGfXvLJejgPPRaYR2Sfe6YM1MfNiNFxfm4n9PGXCTAc+Ec
         tpgYnKyue/RmYU1Emj+1xNmzsPduOW3Zz+V1MnsoHZ24+8K57GccuEEID0ga5vyglJnq
         m0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687899202; x=1690491202;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFHD0hnOjuhPYILDUOJLbgwpgA6DIsDBsAhcitDEBFU=;
        b=AK5ntfnEw9AyxcW7gf5YwUk/Ba28IjzvU11U0WHDoFGkEee9uy7/iVDrgc42D3JBO0
         NUHEgs0bgt/oxCkOLpLPABV52Y7+TBi1+kKnzR/D7uwfh4DFJfAKEyC0srZI5XmY0SQu
         EqpI/TpRxg1gY4BIfE2oHIylVB3tcTB8KUZqfTtRziimiT3AuPc0UH+Di6x9v7RpjnAT
         pv8Q873q1AAEyC9U4IJDJdCdrJ480fbQU7Rt5/drirMbuHf4v4IY3/dUD4QuIRfn9CfH
         wPpDqZhTol3ZZln5wS7/3zTVCgMRcHUVQelVxRbsIdUqpna1GM2HXeAeBF7NtsCKfgjt
         wstg==
X-Gm-Message-State: AC+VfDysAWCD2sYil0Jf55FzQ2Pt3GLjhti4kp5xUHocKWW3eDgspToD
        z2hjfK4qC94SnluJ0OTd2ZDHEg==
X-Google-Smtp-Source: ACHHUZ4cqZstCs1nyAEh2QwWGawSrsE1fPzwiUYItaOw1DYAGKznreSljpXPuAJlmNc2pAtztzw7zA==
X-Received: by 2002:a05:6808:2a47:b0:3a1:df16:2e9e with SMTP id fa7-20020a0568082a4700b003a1df162e9emr6357738oib.12.1687899202175;
        Tue, 27 Jun 2023 13:53:22 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q131-20020a817589000000b00565eb8af1fesm2009195ywc.132.2023.06.27.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 13:53:21 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:53:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
        "David Sc. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
In-Reply-To: <ZJsV19f41CrfkFYa@ziepe.ca>
Message-ID: <7b1be7d-9287-cbc6-ef7-55e44625e4e@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com> <ZJGRa4zvsXfc43vB@ziepe.ca> <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com> <ZJI7xkXWmjrE1yY3@ziepe.ca> <c8284d0-91cb-b65e-4c95-bfeb627234f@google.com>
 <ZJsV19f41CrfkFYa@ziepe.ca>
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

On Tue, 27 Jun 2023, Jason Gunthorpe wrote:
> On Wed, Jun 21, 2023 at 07:36:11PM -0700, Hugh Dickins wrote:
> > [PATCH v3 05/12] powerpc: add pte_free_defer() for pgtables sharing page
...
> Yes, this makes sense to me, very simple..
> 
> I always for get these details but atomic_dec_and_test() is a release?
> So the SetPageActive is guarenteed to be visible in another thread
> that reaches 0?

Yes, that's my understanding - so the TestClearPageActive adds more
to the guarantee than is actually needed.

"release": you speak the modern language, whereas I haven't advanced
from olden-days barriers: atomic_dec_and_test() meets atomic_t.txt's
 - RMW operations that have a return value are fully ordered;
which a quick skim of present-day memory-barriers.txt suggests would
imply both ACQUIRE and RELEASE.  Please correct me if I'm mistaken!

Hugh
