Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479AD63E580
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK3XdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiK3Xci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:32:38 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5E90762
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:29:15 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3b56782b3f6so119057b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sVGmk8iXfRJi6LHpCkuFJ1XLyGvMWqmOzcPL5P0XpHM=;
        b=qgKMTJUmPzLXdl3XUPHNLrMjWcbRNKXVr40/b1Cb+68B0JvcoIL+DdetThrvro0I2e
         Mq3y5U5KHVuJwxTJKuWjfdhdGTB9IZiF6piakctChUJzF4d1ukV3i//n0YzT8bF1UfdK
         fTYHnjvrlrF1qultVw8XUPzq49LgchZe/fU/zQG+2Dsd0Hpbnhqmzw+21XdStKI2ra30
         sZe4lMpAfZTLmSrjd2v5QPu21SzQSsObnFk/0EqFlguUCzBENGfzq30zrzJ34ZmXfrKu
         G3PYZJL53gDDRrBIhNgaaRKaOtourUk3LB29/ZeHVJfrZpbcreEJ9AMWx/OJNfZjvZSQ
         H9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVGmk8iXfRJi6LHpCkuFJ1XLyGvMWqmOzcPL5P0XpHM=;
        b=OgW2awtZpVxviuRldkyEEr1n8XJAXweHWx8JVEDuH3pGSa+2DqN3+CZ0qD3F6h6HfL
         LMsfm2Se0dCvLhw8tJYiME9hENzVl7vLB8ahekiBLl/FeL/iuF7cFFLPWxULe/4heC0/
         /cTnbrKdPkqdiDSq7L1cBWtm1C6vXtDggr3xNk641A/Px33YEhermDpPMOIuehpJCe7k
         A2kZc/GjHAzh+DWrpaTvdQ3rc6OIXEMnQWuiJcpKJxs0FpDbRRDAghEPH1SpIs+w/jbo
         q2GnsBw5YMeJ9tx+Ac8HQeLwu+NbOAT0hz8Es8XApGC1cnBsGpZLOLAuoIutI6QPCIRX
         DKZg==
X-Gm-Message-State: ANoB5plSO5skOGNjDOpdQRSSYKinrOyvS72SaDhuATH92u+rr/2clnxz
        IzDfvedwMdm8gkaKSD3XcmqPp2aqBXwdtBwwYqD26Q==
X-Google-Smtp-Source: AA0mqf6oJoBEjEFwNYBRq/FzzoyS0xR2bK87uFIledzCB9j/r6lljZoLVtVbMrE9TynPwRw5fAlVtHAVdGMSn4dHiG4=
X-Received: by 2002:a81:4602:0:b0:35f:9c14:144a with SMTP id
 t2-20020a814602000000b0035f9c14144amr60796886ywa.209.1669850954990; Wed, 30
 Nov 2022 15:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-7-jthoughton@google.com> <Y4fEkLkbYr7qfPQA@x1n>
In-Reply-To: <Y4fEkLkbYr7qfPQA@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 30 Nov 2022 18:29:04 -0500
Message-ID: <CADrL8HXndK9uzHN9PFwbBy24ZN5Zg_GCKbo3To2Yn-1nU0hv=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/47] hugetlb: extend vma lock for shared vmas
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 4:01 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:22PM +0000, James Houghton wrote:
> > This allows us to add more data into the shared structure, which we will
> > use to store whether or not HGM is enabled for this VMA or not, as HGM
> > is only available for shared mappings.
> >
> > It may be better to include HGM as a VMA flag instead of extending the
> > VMA lock structure.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h |  4 +++
> >  mm/hugetlb.c            | 65 +++++++++++++++++++++--------------------
> >  2 files changed, 37 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index a899bc76d677..534958499ac4 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -121,6 +121,10 @@ struct hugetlb_vma_lock {
> >       struct vm_area_struct *vma;
> >  };
> >
> > +struct hugetlb_shared_vma_data {
> > +     struct hugetlb_vma_lock vma_lock;
> > +};
>
> How about add a comment above hugetlb_vma_lock showing how it should be
> used correctly?  We lacked documents on the lock for pmd sharing
> protections, now if to reuse the same lock for HGM pgtables I think some
> doc will definitely help.
>
> To summarize, I think so far it means:
>
>   - Read lock needed when one wants to stablize VM_SHARED pgtables (covers
>     both pmd shared pgtables or hgm low-level pgtables)
>
>   - Write lock needed when one wants to release VM_SHARED pgtable pages
>     (covers both pmd unshare or releasing hgm low-level pgtables)
>
> Or something like that.

Will do. I'll make this change together with the rmap comment update
("rmap: update hugetlb lock comment for HGM").

- James

>
> --
> Peter Xu
>
