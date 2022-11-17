Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49362E1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiKQQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiKQQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2814313F0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668702432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ECSnbQYfyTzj4hb5xC2FkZlFvx+IZRrl+au2Rw9T6WM=;
        b=b1W7SD++7/eHRs04MbtjXhhqyv9dQ9q12TjfYq+lr7e9l7Q7HcbgSiiWHgNLw+nJJ2VM2l
        XtH6GMu2lGv1byw7XpLMGSNQItP30eOVHLqUr1pu7NDYH77m5Bcnrtb5YVfX8G4vcNDWZ2
        RTzfo146vkaDMoMzqAyRAfem5rwiO68=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-a4GArCUPNteFQirxUpXz0g-1; Thu, 17 Nov 2022 11:27:10 -0500
X-MC-Unique: a4GArCUPNteFQirxUpXz0g-1
Received: by mail-qt1-f199.google.com with SMTP id z11-20020a05622a028b00b003a550fa8989so2091241qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECSnbQYfyTzj4hb5xC2FkZlFvx+IZRrl+au2Rw9T6WM=;
        b=2W4luGV/yoef4iXnHSfKc6coFCVt6YgiI1iuDmzBbXmn28RGOpk+tBFz2ATfQq10a5
         iRzMi2vJINP6MKAs+XClP2d7yWXpne7kBS1k+Rgl7SP36OpuJjB8HH8fxgQinkKNqG/y
         Dkxaa88JX3FfnZ5jn7LuEptGGjOEbuyjDzKxxZWspsJ9YLfdtd7hDEdPFdJZnW7KaFYF
         Y2wtiwIATEpvnWvpxxpKf21fPUfEWTMrQoQH18YudJX9Usp7ujNeEMmMpaBODjp214np
         IoOXaaB53PC4PixvMLRAR2Jn8c7X7NvHw+186OudZH5Mpc7CmhOy/K3SXt1s3aSMQL2a
         d7Pw==
X-Gm-Message-State: ANoB5pmw99Q/3hoOT1DtgoKBmybjZbKhNYPEi01sqsUoFoJBZu63Tcpt
        heIc+dVxforNpliizJH49cvvjM1mY/dyNCZk2xVgsGTPxd1ZdYBlEIGnnCA1GQ1j3hnWIsypiG8
        1HsE6D9DYdtXGtHA/qYVsL0gY
X-Received: by 2002:ac8:704:0:b0:39c:d509:76a5 with SMTP id g4-20020ac80704000000b0039cd50976a5mr2899884qth.382.1668702430475;
        Thu, 17 Nov 2022 08:27:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EJS/miV6XQ6ptWdO+LFShsaM6eU5na38uW33M+lBwqqItY3BuFgTw/XjdD19YLVqgAVclZg==
X-Received: by 2002:ac8:704:0:b0:39c:d509:76a5 with SMTP id g4-20020ac80704000000b0039cd50976a5mr2899857qth.382.1668702430219;
        Thu, 17 Nov 2022 08:27:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm681515qke.105.2022.11.17.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:27:09 -0800 (PST)
Date:   Thu, 17 Nov 2022 11:27:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
Message-ID: <Y3Zg3PgqSgDt/Z2t@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-11-jthoughton@google.com>
 <Y3Vhl6jzTLP0AggE@x1n>
 <CADrL8HUZRAT1ViYniBEL=SQaFsmwSpMUmR6tSWy11LdbdhePnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUZRAT1ViYniBEL=SQaFsmwSpMUmR6tSWy11LdbdhePnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:00:08PM -0800, James Houghton wrote:
> On Wed, Nov 16, 2022 at 2:18 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 04:36:26PM +0000, James Houghton wrote:
> > > +struct hugetlb_pte {
> > > +     pte_t *ptep;
> > > +     unsigned int shift;
> > > +     enum hugetlb_level level;
> > > +     spinlock_t *ptl;
> > > +};
> >
> > Do we need both shift + level?  Maybe it's only meaningful for ARM where
> > the shift may not be directly calculcated from level?
> >
> > I'm wondering whether we can just maintain "shift" then we calculate
> > "level" realtime.  It just reads a bit weird to have these two fields, also
> > a burden to most of the call sites where shift and level exactly match..
> 
> My main concern is interaction with folded levels. For example, if
> PUD_SIZE and PMD_SIZE are the same, we want to do something like this:
> 
> pud = pud_offset(p4d, addr)
> pmd = pmd_offset(pud, addr) /* this is just pmd = (pmd_t *) pud */
> pte = pte_offset(pmd, addr)
> 
> and I think we should avoid quietly skipping the folded level, which
> could happen:
> 
> pud = pud_offset(p4d, addr)
> /* Each time, we go back to pte_t *, so if we stored PUD_SHIFT here,
> it is impossible to know that `pud` came from `pud_offset` and not
> `pmd_offset`. We must assume the deeper level so that we don't get
> stuck in a loop. */
> pte = pte_offset(pud, addr) /* pud is cast from (pud_t * -> pte_t * ->
> pmd_t *) */
> 
> Quietly dropping p*d_offset for folded levels is safe; it's just a
> cast that we're doing anyway. If you think this is fine, then I can
> remove `level`. It might also be that this is a non-issue and that
> there will never be a folded level underneath a hugepage level.
> 
> We could also change `ptep` to a union eventually (to clean up
> "hugetlb casts everything to pte_t *" messiness), and having an
> explicit `level` as a tag for the union would be nice help. In the
> same way: I like having `level` explicitly so that we know for sure
> where `ptep` came from.

Makes sense.

> 
> I can try to reduce the burden at the callsite while keeping `level`:
> hpage_size_to_level() is really annoying to have everywhere.

Yeah this would be nice.

Per what I see most callers are having paired level/shift, so maybe we can
make hugetlb_hgm_iter_init() to only take one of them and calculate the
other. Then there can also be the __hugetlb_hgm_iter_init() which takes
both, only used in the few places where necessary to have explicit
level/shift.  hugetlb_hgm_iter_init() calls __hugetlb_hgm_iter_init().

Thanks,

-- 
Peter Xu

