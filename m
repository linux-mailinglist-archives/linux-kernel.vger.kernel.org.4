Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96969B787
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBRBk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRBk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:40:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9B6781C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:40:25 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f11so930036ioz.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsxS1CvU3sPwRUQ7h5x+PsiOhYM0cqVzH8hm+Yv9Ypk=;
        b=RHqMFu4fMBvsjgHDOqayIgKc17Dfifs0tzNkGNdGY4QFvW1R6niUfBvQMJDRwG2DOZ
         R+8NuQvda+pKQjQwrGOmkEKc9QkzPz80st/qNPH0wN8mbQ0dnZobvx3nv6BXxzDa0wCg
         APImNM62nPIOVuemsndgIxFBcfHN/trLXonKQM7cyi/vlR9K3jmexu6P41dUuqipJY4B
         xwurCDXsgERc0EoiFtO35L45V1WpXMuhvFHUEKK9NtSXGkbGfGTtfieCsJXEmGjvu5zK
         7yavbqNxJYGg2zCfeJ9rEh5QA49RsQ68d7JUpU7WuotqvegGxLXr17QWftzPHbofbQ3C
         Y5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsxS1CvU3sPwRUQ7h5x+PsiOhYM0cqVzH8hm+Yv9Ypk=;
        b=BJYCDoxYYX/iGjcS1FY+2GLqFKape1A77OSPmbnX4mYq/Ip/bXNMWYQfkMHnzWitFJ
         9NyWb3ideqcM/OyPmArinj0Z62j5ZxXqrZLOx4fJ1skLHjjAl8Dtgu6QWUz+t8F1xgOi
         +j4HdzuddhlL9nWRtt1PIz+PyjlpLmqHBOKAk+Xep0AYma6QKDwbyjAaKFsVRVx2xcOx
         6Iy5q381Ns1AqIkNPXJBJrmCOn/WjshReD/HrC8NapGE4DSfw1drHeuOdSt3teEqQ6O4
         ddtdWYWZsbCS82CYu29fD/JB3Q2c0sU3iQScd6uW2Q3dGxY6CofT2HlHu9Wjed0n5mXt
         twOQ==
X-Gm-Message-State: AO0yUKUgRdxO1+0xxD1Npf97a5oTOCU+XXIFdx9eY4BaVy9fpHkQvk4W
        bfclgQnoK5lxiTCeh7GQqqIDI6h+bRxIEzubLYFRdg==
X-Google-Smtp-Source: AK7set81+4+DcnxLnRjD0bGTcfJyYF5UOz/DNXJjQZZRHaJs1AohJ+P/Q1I8zGEmUbew24o0jKFdz2LCuIDv8k69ycU=
X-Received: by 2002:a6b:3c09:0:b0:73d:9833:d43 with SMTP id
 k9-20020a6b3c09000000b0073d98330d43mr347908iob.27.1676684424236; Fri, 17 Feb
 2023 17:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-9-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-9-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Feb 2023 17:40:13 -0800
Message-ID: <CAHS8izM8xcOg8384-692O2Aaj7xiOO=GYWH=g7-RGES=2tNxhw@mail.gmail.com>
Subject: Re: [PATCH v2 08/46] hugetlb: add HugeTLB HGM enablement helpers
To:     James Houghton <jthoughton@google.com>
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

On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> hugetlb_hgm_eligible indicates that a VMA is eligible to have HGM
> explicitly enabled via MADV_SPLIT, and hugetlb_hgm_enabled indicates
> that HGM has been enabled.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Only nits:
Reviewed-by: Mina Almasry <almasrymina@google.com>

>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 7c977d234aba..efd2635a87f5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1211,6 +1211,20 @@ static inline void hugetlb_unregister_node(struct =
node *node)
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +       return false;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>                                         struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c008c9de80e..0576dcc98044 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7004,6 +7004,10 @@ static bool pmd_sharing_possible(struct vm_area_st=
ruct *vma)
>  #ifdef CONFIG_USERFAULTFD
>         if (uffd_disable_huge_pmd_share(vma))
>                 return false;
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       if (hugetlb_hgm_enabled(vma))
> +               return false;
>  #endif
>         /*
>          * Only shared VMAs can share PMDs.
> @@ -7267,6 +7271,18 @@ __weak unsigned long hugetlb_mask_last_page(struct=
 hstate *h)
>
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)

I think the other function you named pmd_sharing_possible(), I suggest
hugetlb_hgm_possible() for some consistency.

> +{
> +       /* All shared VMAs may have HGM. */

I think this is a redundant comment.

> +       return vma && (vma->vm_flags & VM_MAYSHARE);
> +}
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +       return vma && (vma->vm_flags & VM_HUGETLB_HGM);
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> --
> 2.39.2.637.g21b0678d19-goog
>
