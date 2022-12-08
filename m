Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9C6477A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLHVGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHVGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD901B7AE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670533513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p90updOgwd1USYq0liDeFfcravRUaF2Ej7MYlbLmcPw=;
        b=it2HG/S6O9Ld5fTmxRrHk4bNH2QjiZ2Z7k6/0SbsRUdWhkSbgVSZTehfF9l8ALHwXGR/0n
        z7j3LIY14GbHePE2TZlpaHX7qAk3BAetdiBasnAjSt9VN0/BxbSma/rlVN3i+tviY/UKxx
        mjvouW7s96bqEQGdecjVbIDNehg+ktU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-QBtbrwz0O0elXkpgm2QN0g-1; Thu, 08 Dec 2022 16:05:12 -0500
X-MC-Unique: QBtbrwz0O0elXkpgm2QN0g-1
Received: by mail-qt1-f200.google.com with SMTP id g3-20020ac84b63000000b003a529c62a92so2512474qts.23
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p90updOgwd1USYq0liDeFfcravRUaF2Ej7MYlbLmcPw=;
        b=NsVcUwTfZeJdZ+KYIKnTxDd4vtgv6Xz4d3M04bv98J9HeURpNsl/8pGni+WWgER04L
         N+hCQyjHpBEHlrxhbTIsjY4VSt5AzeYR4Fq2IECrvkTTOCc6glbWK+/pzouDZSrnVCC7
         dDvc/cCE8SSDYP1dHHLyVH1Xt+YT8nMem7FjnhF6YF8twQHAjlH67Z9t3RJNm1tdut20
         ugUSTqjueLhNN5j+DNhPlS0q9rJAsCfAoWRW+RnHABlZjceSEGzURPpa/fpi1qM6VPhv
         cQl/Lx4ccCE8md0ajnxgTjypz4Ji76F503BxK30rhsVLadDqh9qkIenFWZyHxAs9FxGm
         a/oA==
X-Gm-Message-State: ANoB5pm5uFv6hVrMSWChWLxJy4VCpnO1fvNqyXldAqAdJAuAEZLt7aha
        7O3F1kYuXOHpm31dCZAJQk5MX4cKw/hwEjKDX2GEOKQHg/El6yUlqv3nFapFgEDrRpy1lzaTiCA
        jZJ3jdI1NEMZxpqWxLKtAycj+
X-Received: by 2002:ac8:774d:0:b0:3a5:7ab0:e1c4 with SMTP id g13-20020ac8774d000000b003a57ab0e1c4mr4649227qtu.35.1670533511909;
        Thu, 08 Dec 2022 13:05:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5O9YmWRgmJW2ZnxZNg83hBfPnP8RFzwN69nU4apaBGReiFXz1mF8FR0BzprN2mwE/Jjr6CmQ==
X-Received: by 2002:ac8:774d:0:b0:3a5:7ab0:e1c4 with SMTP id g13-20020ac8774d000000b003a57ab0e1c4mr4649209qtu.35.1670533511650;
        Thu, 08 Dec 2022 13:05:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id p18-20020ac87412000000b0039cba52974fsm7942735qtq.94.2022.12.08.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:05:11 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:05:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Message-ID: <Y5JRhU+9QqoUuSdR@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a970de6-e3da-f57d-14fd-55f65ddcb27d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        On Wed, Dec 07, 2022 at 04:16:11PM -0800, John Hubbard wrote:
> On 12/7/22 12:31, Peter Xu wrote:
> > Taking vma lock here is not needed for now because all potential hugetlb
> > walkers here should have i_mmap_rwsem held.  Document the fact.
> > 
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/page_vma_mapped.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index e97b2e23bd28..2e59a0419d22 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >   		/* The only possible mapping was handled on last iteration */
> >   		if (pvmw->pte)
> >   			return not_found(pvmw);
> > -
> > -		/* when pud is not present, pte will be NULL */
> > +		/*
> > +		 * NOTE: we don't need explicit lock here to walk the
> > +		 * hugetlb pgtable because either (1) potential callers of
> > +		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
> > +		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
> > +		 * When one day this rule breaks, one will get a warning
> > +		 * in hugetlb_walk(), and then we'll figure out what to do.
> > +		 */
> 
> Confused. Is this documentation actually intended to refer to hugetlb_walk()
> itself, or just this call site? If the former, then let's move it over
> to be right before hugetlb_walk().

It is for this specific code path not hugetlb_walk().

The "holds i_mmap_rwsem" here is a true statement (not requirement) because
PVMW rmap walkers always have that.  That satisfies with hugetlb_walk()
requirements already even without holding the vma lock.

-- 
Peter Xu

