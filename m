Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0464E65C4CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbjACRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjACRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E586A12D31
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672765584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6BRBNvzQCbi1RenvRCJJP9+zcFTdMvF+Yz2UJ3A+ymw=;
        b=OKWEP09r37lTHsrs93EGNv+ww2JDb1CtwUyTp6efGt13L1h9YAEJJfRIPTaeYgYblt9c5V
        aJvXzBBAJEas4HcQmnvvj7mjWX+JGFVM8WOSS8pjAj84kWlK/l61kkRTjaomJCiiC+ABls
        MbNQRfW409Kl80nz7/o8vmqJ5xgbey4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-fTarJbc1ORiCHHI1F3Ye4A-1; Tue, 03 Jan 2023 12:06:23 -0500
X-MC-Unique: fTarJbc1ORiCHHI1F3Ye4A-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-46a518991cfso290477637b3.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BRBNvzQCbi1RenvRCJJP9+zcFTdMvF+Yz2UJ3A+ymw=;
        b=BjFiUrZpcofYm1btnPRjq7Dip4T+P5LgojT4dTyn+fvClUL4qBBa2b4YxdgqgA9him
         Pk5lTGksTQzbz9byXbVHltt61cQsOxukGTOdwoqD62DmeXGGemKD8eq39fblsH/5K2Gm
         hFO8bgfas0d89YOtawK7R43uGR/EzX+UKGdSGqhGkQvasIgk+hsMZOKSWvuMY7oUIjeT
         YQlDpLVZv/eGlLAMHi3IN5zUuNcMtbSc2MmJBXdkTsUTSMwgiLRJOCgEjgDgRDDYT9cn
         E/SnEAZjqe9lHQ7KFwHABGCWFneBQMvCaLsnnvdGMOrQCuasFy9thMNJsjRK1Brxk8fu
         lrEw==
X-Gm-Message-State: AFqh2kolk1BglQTwa7U5owVC4IYEaKT2mlsKG/PKUbnXy0R7BX3i2MZf
        bbsyzmQGwwJhZGNEHvFiuXh7clPksTIDmt5Z/NATiIncJR69eJm4+MW2FaAXW4PoKeDieqVlvym
        OLlIub1Wufr3SLNXHEfo6ycz8
X-Received: by 2002:a05:7508:668b:b0:48:f620:2c6a with SMTP id dt11-20020a057508668b00b00048f6202c6amr1639404gbb.9.1672765582559;
        Tue, 03 Jan 2023 09:06:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt523hnmHSsOU3XGi7N2xoeMR1V8T+JUVSBn+QqfnYY9uocBsZpKDL4orUEbrjuNgR1+K0dYA==
X-Received: by 2002:a05:7508:668b:b0:48:f620:2c6a with SMTP id dt11-20020a057508668b00b00048f6202c6amr1639373gbb.9.1672765582158;
        Tue, 03 Jan 2023 09:06:22 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id s2-20020a05620a29c200b006eef13ef4c8sm22809203qkp.94.2023.01.03.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:06:21 -0800 (PST)
Date:   Tue, 3 Jan 2023 12:06:19 -0500
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
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add
 UFFD_FEATURE_MINOR_HUGETLBFS_HGM
Message-ID: <Y7Rgiypq1m5XBHfz@x1n>
References: <Y6NdN2ADVCcK70ym@x1n>
 <CADrL8HXqE3s4ckxh0OU5onkhystj=1jMTS+S7GFeiO+kwBo0QQ@mail.gmail.com>
 <Y6N9G0Y2j98V8Pnz@monkey>
 <Y6OEQB3dLSa083F6@x1n>
 <Y6OJUtVkvdptEgW7@monkey>
 <CADrL8HX997CguZWkH3vB4+cYjwLc0mYV4GkroE41bCLRqFiPpg@mail.gmail.com>
 <Y6Om/dvlt1Wl2uZw@monkey>
 <CADrL8HU_4ymb4XMBpujyFECwONKpWP0fgZgy7odb+M23QUx6pQ@mail.gmail.com>
 <Y6RqAbGOFEKFUeQr@x1n>
 <CADrL8HWt0s_Ev+QRCVQqdkLbe_jX0X95A=UNYn1Ej8qpr=38ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HWt0s_Ev+QRCVQqdkLbe_jX0X95A=UNYn1Ej8qpr=38ng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:02:52PM -0500, James Houghton wrote:
> On Thu, Dec 22, 2022 at 9:30 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Dec 21, 2022 at 08:24:45PM -0500, James Houghton wrote:
> > > Not sure what the best name for this flag is either. MADV_ENABLE_HGM
> > > sounds ok. MADV_HUGETLB_HGM or MADV_HUGETLB_SMALL_PAGES could work
> > > too. No need to figure it out now.
> >
> > One more option to consider is MADV_SPLIT (hopefully to be more generic).
> >
> > We already decided to reuse thp MADV_COLLAPSE, we can also introduce
> > MADV_SPLIT and leave thp for later if it can be anything helpful (I
> > remember we used to discuss this for thp split).
> >
> > For hugetlb one SPLIT should enable hgm advise bit on the vma forever.
> 
> MADV_SPLIT sounds okay to me -- we'll see how it turns out when I send
> v1. However, there's an interesting API question regarding what
> address userfaultfd provides. We previously required
> UFFD_FEATURE_EXACT_ADDRESS when you specified
> UFFD_FEATURE_MINOR_HUGETLBFS_HGM so that there was no ambiguity. Now,
> we can do:
> 
> 1. When MADV_SPLIT is given, userfaultfd will now round addresses to
> PAGE_SIZE instead of huge_page_size(hstate), and
> UFFD_FEATURE_EXACT_ADDRESS is not needed.
> 2. Don't change anything. A user must know to provide
> UFFD_FEATURE_EXACT_ADDRESS to get the real address, otherwise they get
> an (unusable) hugepage-aligned address.
> 
> I think #1 sounds fine; let me know if you disagree.

Sounds good to me, thanks!

-- 
Peter Xu

