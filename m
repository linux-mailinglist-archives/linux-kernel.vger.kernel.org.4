Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82370EB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjEXCor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEXCoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:44:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A7E189
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:44:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba81f71dfefso707740276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684896284; x=1687488284;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3If+wNKDpztgamuvwXQbsQHi3AsIclBz5NcCQV3CYi4=;
        b=hrm8eV4Fq6VAAV1GxKh0FyrU8o4JWflrPTKLcjcBt6GHqGBUZgjEwPtBTGs49KMeO7
         E+1IyOO5I/1GKz9vC5+8+/f6AbZqhYPgs9grMTqpvaYG3v2VhmjovMDDpy/iU5jey7V0
         6oqVRDxrV0HyWz3HBkEmkWT0oxlkZBfQw6wiT67vFipyzTrQQplQiiQhCCEVWvbnA0WT
         76rmKqPHPE7ZcxwcwitoT7UUmP8wyfixdR3hH2X0VofCs+JWLmDuCl39lEWw2LrImLFh
         Dfg/3CV6de1VFP0QOdKlPEDMpdJm/yt2YKlA6wqgdE9udjCSyapNT4/WHex1qDf4EiQi
         brpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684896284; x=1687488284;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3If+wNKDpztgamuvwXQbsQHi3AsIclBz5NcCQV3CYi4=;
        b=EubRPJmf6TCQCdJUyI14B+KqsxszJsBpCpTqIf3gl4AUHlg5pctWH97/FGuxKwk73k
         jtXn6HWiUTNjlH1Ui0HnwCv+tFk4+hp8gUZCiL5scZMSzfMyTw0tcZwz7tcsMB25+JHA
         TOEo+ifzBde5CGH8aNcwTGMZSX72ircPrBWTV0vrP1DlIPtBIG74klmUtg2w726Qc4at
         s/ekF5UpfIuWSFHv5UVPG7X3Bny663wlOOAbQ04tHZAKv26AaMzZbik3Omm1ey0VzUVR
         P/kHAeYDtzztABFNp/TjEx8cbEkCDHwulKKjfIh0HS6uW387z8lNEXotjKtPb5QnCrSr
         MTqQ==
X-Gm-Message-State: AC+VfDxPhsP50wqRQ8PbHVqh4CVi0hl6NOrz4mz9mp/bzH1DgYzan2zU
        6b382sIQjW0nvVWVDbUaf0wz0A==
X-Google-Smtp-Source: ACHHUZ6gIKhhAwV7VzJZ+VjYAmN1m1JqAsACzn5Xl0TpbWituX+QnPRD/b4+0EBRgkw7jWvonN7X7w==
X-Received: by 2002:a81:d548:0:b0:561:949d:f9a7 with SMTP id l8-20020a81d548000000b00561949df9a7mr20238915ywj.20.1684896284333;
        Tue, 23 May 2023 19:44:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i16-20020a0ddf10000000b0054f80928ea4sm3324271ywe.140.2023.05.23.19.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:44:43 -0700 (PDT)
Date:   Tue, 23 May 2023 19:44:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <qi.zheng@linux.dev>
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
Subject: Re: [PATCH 08/31] mm/page_vma_mapped: pte_offset_map_nolock() not
 pte_lockptr()
In-Reply-To: <10e58e7e-a52e-751d-f693-cd4e05ac10ca@linux.dev>
Message-ID: <83ec98e0-d17-6d59-e276-557c13ac58ea@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <8fa3fb6e-2e39-cbea-c529-ee9e64c7d2d0@google.com> <10e58e7e-a52e-751d-f693-cd4e05ac10ca@linux.dev>
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

On Mon, 22 May 2023, Qi Zheng wrote:
> On 2023/5/22 12:58, Hugh Dickins wrote:
> > map_pte() use pte_offset_map_nolock(), to make sure of the ptl belonging
> > to pte, even if pmd entry is then changed racily: page_vma_mapped_walk()
> > use that instead of getting pte_lockptr() later, or restart if map_pte()
> > found no page table.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   mm/page_vma_mapped.c | 28 ++++++++++++++++++++++------
> >   1 file changed, 22 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 947dc7491815..2af734274073 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -156,6 +168,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk
> > *pvmw)
> >    struct vm_area_struct *vma = pvmw->vma;
> >    struct mm_struct *mm = vma->vm_mm;
> >    unsigned long end;
> > +	spinlock_t *ptl;
> >    pgd_t *pgd;
> >    p4d_t *p4d;
> >    pud_t *pud;
> > @@ -257,8 +270,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk
> > *pvmw)
> >      step_forward(pvmw, PMD_SIZE);
> >      continue;
> >   		}
> > -		if (!map_pte(pvmw))
> > +		if (!map_pte(pvmw, &ptl)) {
> > +			if (!pvmw->pte)
> > +				goto restart;
> 
> Could pvmw->pmd be changed? Otherwise, how about just jumping to the
> retry label below?
> 
> @@ -205,6 +205,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk
> *pvmw)
>                 }
> 
>                 pvmw->pmd = pmd_offset(pud, pvmw->address);
> +
> +retry:
>                 /*
>                  * Make sure the pmd value isn't cached in a register by the
>                  * compiler and used as a stale value after we've observed a

You're right, that could be done, and that's where I'd have inserted
the label if there were none already.  I just thought the fewer goto
labels the better, so reused the restart already there.  If you feel
strongly that it's actively misleading, I can certainly make that
change; but it's too rare an occurrence to be worth optimizing for.

Hugh
