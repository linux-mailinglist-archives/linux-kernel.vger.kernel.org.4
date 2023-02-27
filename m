Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4996A45B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjB0POl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0POj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:14:39 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938659DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:14:38 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id df20so11594070vsb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677510877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DK29JUcB7eAkqoEsw6GF+QQWOkXrCAiRiZPvb7EnDxI=;
        b=i91GA7ikHLkyUXv4H6HxEIuUfgXhAGI9NSZjXdKe3/Qc57p9E7Lcxqq5mrmbfL3LsQ
         ben+D8y6ZTvdkowVBiEifGz6tNOZux/Re4NMCGhXj2jeAotuRaMtt++jC6T0gIK4PmIu
         xA5Mbi0muKMS1PdU89IDw+kw9HnXdtzrnRepFIgICf9bqEfTcLpJ68RhGQ/DwcwOAKy+
         q6a9/q6Vb6XBrWssFF+WJZFO94qB/9ESRbFcVqV90ZcrqaT0jpuoRKVIO/cBphpwDwGR
         RxcHRvmJLtzDj45KSImx8wholIA5YYRZ+GKiREDe2R+hVIpS4GCIXQ84aO7NVM7VV6Hr
         jZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677510877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK29JUcB7eAkqoEsw6GF+QQWOkXrCAiRiZPvb7EnDxI=;
        b=0gt5FwNg/72lmFZXbWA7LkkR/dbAGtVg9GTvsTAwzCU3kqCdcWwV+TC8E+wT4D86i1
         yCkYfqEla7x/ZdjaPsdqvfczx/Bp9aPA8mOoFP1WUcMfSwDn4rtYLwSAtaRs+K8FGyoV
         t+2cXQ1VsARd7P58G2qQq2vwZh08g7lGeG55aMsa9tkcfiYkDSwnkqQa/5tKTd2/0NoF
         EAdnX2nvnvt8eZq+TnXHVbKl8rGu2SSDN7e2C260KY5tAjAujEYeIq1bWBxPqUFlgDSF
         YGSiAJh9hYefkiT4IYPryI1CJDUl6oLPluyCXtKxBtkkm39NUPfldb2XuH0mvWwvsdjK
         RAGA==
X-Gm-Message-State: AO0yUKX13egI8s+yxpKEBGaPSTO0KWV5TWwu1NpKDOp3mhyeScm7mkZk
        Grc6uy27P8dUQzKlaUGOSqJ5r+dPmuTL5MRne96NIQ==
X-Google-Smtp-Source: AK7set/tc/TZYbFu12DoUY/3mUSkmyU3RCWmBL58iDnCNGTReanN3wW0hP1sv6GKPSs1Yv7/LKV2j8FdzR6Wy4RU43Y=
X-Received: by 2002:a05:6102:31a9:b0:415:48dd:e0b9 with SMTP id
 d9-20020a05610231a900b0041548dde0b9mr7415429vsh.3.1677510877266; Mon, 27 Feb
 2023 07:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-10-jthoughton@google.com> <Y/lHWhxmv/hhg8Jl@monkey>
In-Reply-To: <Y/lHWhxmv/hhg8Jl@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Mon, 27 Feb 2023 07:14:00 -0800
Message-ID: <CADrL8HUqb4Sr-dBRaNr4dyWw9ns5XEQktA0ZSjXK+R0TwcSxWg@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

On Fri, Feb 24, 2023 at 3:25 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 02/18/23 00:27, James Houghton wrote:
> > Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> > HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> > applied to non-HugeTLB memory in the future, if such an application is
> > to arise.
> >
> > MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> > address ranges:
> > 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
> >    alignment.
> > 2. read()ing a page fault event from a userfaultfd will yield a
> >    PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
> >    address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
> >
> > There is no way to disable the API changes that come with issuing
> > MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> > table mappings that come from the extended functionality that comes with
> > using MADV_SPLIT.
> >
> > For post-copy live migration, the expected use-case is:
> > 1. mmap(MAP_SHARED, some_fd) primary mapping
> > 2. mmap(MAP_SHARED, some_fd) alias mapping
> > 3. MADV_SPLIT the primary mapping
> > 4. UFFDIO_REGISTER/etc. the primary mapping
> > 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
> >    corresponding PAGE_SIZE sections in the primary mapping.
> >
> > More API changes may be added in the future.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 763929e814e9..7a26f3648b90 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -78,6 +78,8 @@
> >
> >  #define MADV_COLLAPSE        25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   26              /* Enable hugepage high-granularity APIs */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE     0
> >
> > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> > index c6e1fc77c996..f8a74a3a0928 100644
> > --- a/arch/mips/include/uapi/asm/mman.h
> > +++ b/arch/mips/include/uapi/asm/mman.h
> > @@ -105,6 +105,8 @@
> >
> >  #define MADV_COLLAPSE        25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   26              /* Enable hugepage high-granularity APIs */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE     0
> >
> > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> > index 68c44f99bc93..a6dc6a56c941 100644
> > --- a/arch/parisc/include/uapi/asm/mman.h
> > +++ b/arch/parisc/include/uapi/asm/mman.h
> > @@ -72,6 +72,8 @@
> >
> >  #define MADV_COLLAPSE        25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   74              /* Enable hugepage high-granularity APIs */
> > +
> >  #define MADV_HWPOISON     100                /* poison a page for testing */
> >  #define MADV_SOFT_OFFLINE 101                /* soft offline page for testing */
> >
> > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> > index 1ff0c858544f..f98a77c430a9 100644
> > --- a/arch/xtensa/include/uapi/asm/mman.h
> > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > @@ -113,6 +113,8 @@
> >
> >  #define MADV_COLLAPSE        25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   26              /* Enable hugepage high-granularity APIs */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE     0
> >
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index 6ce1f1ceb432..996e8ded092f 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -79,6 +79,8 @@
> >
> >  #define MADV_COLLAPSE        25              /* Synchronous hugepage collapse */
> >
> > +#define MADV_SPLIT   26              /* Enable hugepage high-granularity APIs */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE     0
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index c2202f51e9dd..8c004c678262 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1006,6 +1006,28 @@ static long madvise_remove(struct vm_area_struct *vma,
> >       return error;
> >  }
> >
> > +static int madvise_split(struct vm_area_struct *vma,
> > +                      unsigned long *new_flags)
> > +{
> > +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> > +     if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_eligible(vma))
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * PMD sharing doesn't work with HGM. If this MADV_SPLIT is on part
> > +      * of a VMA, then we will split the VMA. Here, we're unsharing before
> > +      * splitting because it's simpler, although we may be unsharing more
> > +      * than we need.
> > +      */
> > +     hugetlb_unshare_all_pmds(vma);
>
> I think we should just unshare the (appropriately aligned) range within the
> vma that is the target of MADV_SPLIT.  No need to unshare the entire vma.

Right I can do that, and I can check for appropriate alignment here
(else fail with -EINVAL).

>
> > +
> > +     *new_flags |= VM_HUGETLB_HGM;
> > +     return 0;
> > +#else
> > +     return -EINVAL;
> > +#endif
> > +}
> > +
> >  /*
> >   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> >   * will handle splitting a vm area into separate areas, each area with its own
> > @@ -1084,6 +1106,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >               break;
> >       case MADV_COLLAPSE:
> >               return madvise_collapse(vma, prev, start, end);
> > +     case MADV_SPLIT:
> > +             error = madvise_split(vma, &new_flags);
> > +             if (error)
> > +                     goto out;
>
> Not a huge deal, but if one passes an invalid range (such as not huge page
> size aligned) to MADV_SPLIT, then we will not notice the error until
> later in madvise_update_vma() when the vma split fails.  By then, we will
> have unshared all pmds in the entire vma (or just the range if you agree
> with my suggestion above).

Good point. I'll fix this for v3. :) Thanks Mike.
