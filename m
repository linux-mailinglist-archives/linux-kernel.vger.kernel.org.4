Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0E6643A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjAJOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjAJOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:51:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D632EB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:51:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso5813791wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muRPvoodtHXWL4NNIYk10Fq+4im2yIJuL90gKAD23Fo=;
        b=mcbpw9yVFKa2pKs33yjofN8fOHvlBpdccQJAlKL7ez+aiyuIx+eugxWQ+737C90Xqk
         94lKTbMRxUCxdgv64bmONJ8O9xzmKja9V0uQZ7tLRjJytMve2/HMj6dvV1i+F6ViaTz7
         rwNBEIiGdGHQbGa36FvsnGv2WoCw9tu/HMLK0kArZxC2r4KE6Cp9zA+FVqr/cCgHS6/0
         daETULbrXIXK/8K0KdcRWnkFz5t9OppacT1Ba//AQBEKZyGqkIGnedHeRto8LCeLaDpT
         1d656DHBQxKmoaNYQ5qpVzmkt12JDCaMI5AUHvMohdzRSVRwNZVXnhAnLvUXqktVzTv7
         9NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muRPvoodtHXWL4NNIYk10Fq+4im2yIJuL90gKAD23Fo=;
        b=gLm+kmoKwh88b5cmHmq2n7qeHyYlcoOKH/glCwY33hSU7zpLRLPuOucAE7tdyaoQm8
         5XQf2NcUsCh/kXhfKU3JmYjpGWrtqwe91isR0xOcohIF6ELqGWl41T+4RzwcTxGnAt4I
         OcxqcnRPQKKoTCmOzUr+ADIb7dWJVU4mZMRKbLr6bCi/dfgG6j9WVY0bWYSavSTBSPfO
         EGWhwA/B0l5XWSlvZz5rIf57x713F/+LJTckRZg/Ghl26UWSpCQG2c0g0uM3vjSAh1K9
         59+bEddtXZQ+fehav6uK0elpdiOlw4yf+BKRF2mRCFPnbjNKuDDZBoBKwLKrhzUXXjhe
         P7FQ==
X-Gm-Message-State: AFqh2koXaUk7CSrmOTWd5TI4VYiPN/QoJavLVI3UI/ToV/HXXw2VJxcx
        z3lV76PaiXXKpvvTZvwlkKf2SEeDA9umE/KPzWObIg==
X-Google-Smtp-Source: AMrXdXs4xy9xMIlVczjqZL2d+TSIfcJDWWQwF9xsndZPEJis6d+4cFr03Ck5XyKySBDlvnKM6yEO/8ClXSEvQXEa8ZQ=
X-Received: by 2002:a05:600c:4c22:b0:3cf:f2aa:3dc2 with SMTP id
 d34-20020a05600c4c2200b003cff2aa3dc2mr3621686wmp.175.1673362271690; Tue, 10
 Jan 2023 06:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-35-jthoughton@google.com> <Y7g6ihsCTIC765CO@x1n>
In-Reply-To: <Y7g6ihsCTIC765CO@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 10 Jan 2023 09:50:59 -0500
Message-ID: <CADrL8HXbTzX8T-S57mUQ8ggJ=DGMcQAxJapiQCFndqjPNLV=-Q@mail.gmail.com>
Subject: Re: [PATCH 34/46] hugetlb: userfaultfd: when using MADV_SPLIT, round
 addresses to PAGE_SIZE
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
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jan 6, 2023 at 10:13 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 05, 2023 at 10:18:32AM +0000, James Houghton wrote:
> > MADV_SPLIT enables HugeTLB HGM which allows for UFFDIO_CONTINUE in
> > PAGE_SIZE chunks. If a huge-page-aligned address were to be provided,
> > userspace would be completely unable to take advantage of HGM. That
> > would then require userspace to know to provide
> > UFFD_FEATURE_EXACT_ADDRESS.
> >
> > This patch would make it harder to make a mistake. Instead of requiring
> > userspace to provide UFFD_FEATURE_EXACT_ADDRESS, always provide a usabl=
e
> > address.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 5af6db52f34e..5b6215e03fe1 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5936,28 +5936,27 @@ static inline vm_fault_t hugetlb_handle_userfau=
lt(struct vm_area_struct *vma,
> >                                                 unsigned long addr,
> >                                                 unsigned long reason)
> >  {
> > +     u32 hash;
> > +     struct vm_fault vmf;
> > +
> >       /*
> >        * Don't use the hpage-aligned address if the user has explicitly
> >        * enabled HGM.
> >        */
> >       if (hugetlb_hgm_advised(vma) && reason =3D=3D VM_UFFD_MINOR)
> > -             haddr =3D address & PAGE_MASK;
> > -
> > -     u32 hash;
> > -     struct vm_fault vmf =3D {
> > -             .vma =3D vma,
> > -             .address =3D haddr,
> > -             .real_address =3D addr,
> > -             .flags =3D flags,
> > +             haddr =3D addr & PAGE_MASK;
> >
> > -             /*
> > -              * Hard to debug if it ends up being
> > -              * used by a callee that assumes
> > -              * something about the other
> > -              * uninitialized fields... same as in
> > -              * memory.c
> > -              */
> > -     };
> > +     vmf.vma =3D vma;
> > +     vmf.address =3D haddr;
> > +     vmf.real_address =3D addr;
> > +     vmf.flags =3D flags;
>
> Const fields here:
>
> mm/hugetlb.c: In function =E2=80=98hugetlb_handle_userfault=E2=80=99:
> mm/hugetlb.c:5961:17: error: assignment of member =E2=80=98vma=E2=80=99 i=
n read-only object
>  5961 |         vmf.vma =3D vma;
>       |                 ^
> mm/hugetlb.c:5962:21: error: assignment of member =E2=80=98address=E2=80=
=99 in read-only object
>  5962 |         vmf.address =3D haddr;
>       |                     ^
> mm/hugetlb.c:5963:26: error: assignment of member =E2=80=98real_address=
=E2=80=99 in read-only object
>  5963 |         vmf.real_address =3D addr;

Thanks Peter for this and your other findings. Not sure why my
compiler (clang) let me do this. :/ Will send a v2 soon with this +
the other problems fixed.
