Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445846477B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiLHVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:06:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF2450AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670533555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8gJxUEGqY0h3QoA4zMFmJqAFB2FDWfdiuoBMjsfUSQ=;
        b=MXwfOo4MtMlc5W3tHzVMTqRgsvoyHprg6ZhwOmcEE2U8EUf+rkTPmL7l9/WxMiG7aQmYwd
        /fL1mPLe9ZKglveiIuOrBPW52Oc/NJX4YwNt0wsOYeSqFcDLIV0zyIaIvIyWoOU4kuoc/M
        bnBbXNzpc77WIKE6v1KaYksVH2lXQFk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-BIT0oFhhPDGL-ZSy5oNISA-1; Thu, 08 Dec 2022 16:05:49 -0500
X-MC-Unique: BIT0oFhhPDGL-ZSy5oNISA-1
Received: by mail-qt1-f197.google.com with SMTP id ay12-20020a05622a228c00b003a52bd33749so2512274qtb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8gJxUEGqY0h3QoA4zMFmJqAFB2FDWfdiuoBMjsfUSQ=;
        b=zFbTGtjEYSvltTqRYg+R9+qez6KhZD4vEuuz0WzueTYXqc+ZUk+apiZjT4e5eWKUWw
         wbste/l+KC+SbERV4awEkFjEaC/kokDZz5REmtrUoq20AvC5nCydAVK7sItZJCW0GNJ7
         Z82cEWRkTBng5yBVIYMhu4eY+MbltZqj22Tz/Py6BdXxuqRF6CVKVJ4K5PGArP0gkukY
         hyuDrH0xgn0lPE4aF+lih08xMAP26gbVqGJ7IeaP9DTy+Gk9KM6bPM+K44RnyMPZoaQ7
         i7oy2J+8/PvyvMUIR4VRQw1YE3R4cblGppkKCWMK20kwLGB4/liV7P3Kb66xTDv+/ftx
         UfrQ==
X-Gm-Message-State: ANoB5pk7ZPa93qyLqM9O+vZ+bRKBf0tcyp8VfN9A55cXrXl7jOrgtkKp
        jvswHE5bUG1S0ubysjZUC7jdKo7TAqjLQQ55aZJW/sZOJQJx+O81A0E05GK4JFCmYXQsE2nEd1x
        ZuKYU3ptM5DR8eCmFUer+9KM+
X-Received: by 2002:a05:6214:2b8b:b0:4c7:82c7:8e12 with SMTP id kr11-20020a0562142b8b00b004c782c78e12mr4956122qvb.39.1670533548505;
        Thu, 08 Dec 2022 13:05:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FKeCs6XLMmlBuTOyruzGAX+e5x0fpvxMa9R7jnCtsk74wOUjpZdw45cWmI1xEFZepm0zEiQ==
X-Received: by 2002:a05:6214:2b8b:b0:4c7:82c7:8e12 with SMTP id kr11-20020a0562142b8b00b004c782c78e12mr4956102qvb.39.1670533548289;
        Thu, 08 Dec 2022 13:05:48 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006fc40dafaa2sm20433574qkb.8.2022.12.08.13.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:05:47 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:05:46 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 10/10] mm/hugetlb: Document why page_vma_mapped_walk()
 is safe to walk
Message-ID: <Y5JRqqwN7N6SJuz5@x1n>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203158.651092-1-peterx@redhat.com>
 <799d6831-2af3-72c1-84b2-1f0454a46c07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <799d6831-2af3-72c1-84b2-1f0454a46c07@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 02:16:03PM +0100, David Hildenbrand wrote:
> On 07.12.22 21:31, Peter Xu wrote:
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
> >   		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
> >   		if (!pvmw->pte)
> >   			return false;
> 
> Would it make sense to squash that into the previous commit?

Sure thing.

-- 
Peter Xu

