Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC569E45E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjBUQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjBUQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:17:28 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B22CFD4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:18 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id f20so900445uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676996238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZd3kSfNGA1PHVCAPaBvCHlOyxSL9wfTIK5IbE0HRRI=;
        b=OGU9x/csY9RolGb9FqqDo1Mov8yqY4AD6vdB1wFGpnQAxqMB8/q3roetWUUCSXJ1Bh
         4x11R7Ic9xznvrxj7jIg0qxp/gZkBy1z7kGwmEpXH85Ei/eWzMakSuJVpcRDQ1Ggj0we
         YsQfVS3dnCxwm/jQ0OYQIL9021IaFf4hIbMNfeYQi+31ixY/AILxPazuA5wJoJmR8j29
         weQYzCjQuF2IDQpOIywBJD/NdO+lJZR2t1ThdN+arlm3dwsLr0OyncjSiEay+Y/kLrfl
         eLNS6O2RcLwEsH425VLI5EzLJlD4TF+8va9eP1dhoJKdk3bAOH+QlPbu0u4/x/wriEXS
         00bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676996238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZd3kSfNGA1PHVCAPaBvCHlOyxSL9wfTIK5IbE0HRRI=;
        b=8DNdmbSFOjDM23tXNiSqKEmxfpvVWMk/VJNSoL/e9XzpJfpfLeqvAyIXZuljeZOqy3
         bnHoN3D7VM0WjEkmjl84WSQj9xwAISKzKfd9TyuuKAauY07ANAcMaeu7iX9IEXdj++GP
         easzuP5GVoyGx0Q3lvD7Yd9XNx/Gk3JeEQ07DKPt7Gjg/5V3F+zYh1EaQVN9BvvOZvH6
         ahkkcPvEJZarhFCeZGBp3Xlh4zpM4vLGljvrKKw5A7gtnFA8oqpH5E1BdO672XscBqJO
         Bvrl+zLrjTOlyFx3flTeoT5QTOGQ6y0EUCJDti/d6HKALLxjQEtKhOjRbY0TEWeZd5iX
         ByNQ==
X-Gm-Message-State: AO0yUKVvaJim3oAAdzXzbVcPdyI7CyCdVgWXhigiTPblw8LLhhcOn0Yp
        Fpb9OWJTorwE0iKAMhDlDpAh3l+D/cfIL9je+U/Bzw==
X-Google-Smtp-Source: AK7set/FTbhy2QinX1nfpt4pgKPaIOPugBCH8djx/8IFrfwqKhU7NQ30t+tWJLaoNQ72vVheI57wMf1yRD8ZVRDtBJ8=
X-Received: by 2002:a05:6122:71b:b0:401:72fb:a212 with SMTP id
 27-20020a056122071b00b0040172fba212mr1109772vki.27.1676996237794; Tue, 21 Feb
 2023 08:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-9-jthoughton@google.com> <CAHS8izM8xcOg8384-692O2Aaj7xiOO=GYWH=g7-RGES=2tNxhw@mail.gmail.com>
In-Reply-To: <CAHS8izM8xcOg8384-692O2Aaj7xiOO=GYWH=g7-RGES=2tNxhw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 21 Feb 2023 08:16:41 -0800
Message-ID: <CADrL8HXx-RczH4h7270h0-=7-Lt02y6zF1DtN-mcc0NKkbWHYw@mail.gmail.com>
Subject: Re: [PATCH v2 08/46] hugetlb: add HugeTLB HGM enablement helpers
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 17, 2023 at 5:40 PM Mina Almasry <almasrymina@google.com> wrote=
:
>
> On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > hugetlb_hgm_eligible indicates that a VMA is eligible to have HGM
> > explicitly enabled via MADV_SPLIT, and hugetlb_hgm_enabled indicates
> > that HGM has been enabled.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Only nits:
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks Mina. :)

>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 7c977d234aba..efd2635a87f5 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -1211,6 +1211,20 @@ static inline void hugetlb_unregister_node(struc=
t node *node)
> >  }
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> > +#else
> > +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +       return false;
> > +}
> > +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> >  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> >                                         struct mm_struct *mm, pte_t *pt=
e)
> >  {
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6c008c9de80e..0576dcc98044 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7004,6 +7004,10 @@ static bool pmd_sharing_possible(struct vm_area_=
struct *vma)
> >  #ifdef CONFIG_USERFAULTFD
> >         if (uffd_disable_huge_pmd_share(vma))
> >                 return false;
> > +#endif
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +       if (hugetlb_hgm_enabled(vma))
> > +               return false;
> >  #endif
> >         /*
> >          * Only shared VMAs can share PMDs.
> > @@ -7267,6 +7271,18 @@ __weak unsigned long hugetlb_mask_last_page(stru=
ct hstate *h)
> >
> >  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
> >
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
>
> I think the other function you named pmd_sharing_possible(), I suggest
> hugetlb_hgm_possible() for some consistency.

Good idea. Will do.

>
> > +{
> > +       /* All shared VMAs may have HGM. */
>
> I think this is a redundant comment.

Indeed. I'll change it to something like:

"HGM is not supported for private mappings. Operations that apply to
MAP_PRIVATE VMAs like hugetlb_wp haven't been updated to support
high-granularity mappings."

>
> > +       return vma && (vma->vm_flags & VM_MAYSHARE);
> > +}
> > +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> > +{
> > +       return vma && (vma->vm_flags & VM_HUGETLB_HGM);
> > +}
> > +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> > +
> >  /*
> >   * These functions are overwritable if your architecture needs its own
> >   * behavior.
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
