Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC369B79D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBRB60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRB6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:58:25 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF95A3B5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:58:23 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h3so1208002iow.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 17:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBEtaMmv6NuU1ujK88VLXYldYw/2E3HzM87x0/nWuSk=;
        b=lHB21MhbsZ8voyCEeWeDja8SxFALo+TWTEPkC2R/uO3n1ngrln5JbuymJG9L1fjUQ5
         ZeQJLWjMXCYCEtxL+TZAOn+0Ln4PlLOo4O7N+nlkvUMwyFGsyB5zgCZUJwQ24sc5zVMc
         PkHR3WsondhJnfiKHvMkPqDYBQF2zKZgs499ISITc737cNoG1btliGXHqo5+9WLtI5Lq
         G1CgR19YuVuubOgtCSvQDmvHrKdNvbL0+TZbpYbzOeLzswSTvR/AaVBoCFHgPYnr0Ijt
         7wpHUXIj5T43gY5tofHF5uoLcn5TnEMsCmmqzVJcJUsFJdxONHAQLSucnT0npJ88DYdL
         +TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBEtaMmv6NuU1ujK88VLXYldYw/2E3HzM87x0/nWuSk=;
        b=C3BXaZ+eEaJ4UMc2v4CzqBbiSHHdogWHOW9HuNLv8hTCh1MRK4jowarxrqWtYZJvla
         kc6/yXkW5aOjMtQWIDpGOIwaeNvItAH4H9kR/cXhRAOgcI1+NzmbAWi5UV/dJQJSCLN6
         s926Lu2tabGLRtQCIi462jIj44iEVYb1b4VmDHBQTaeX/o5kGX/24EE0S7jWJRjyLu3D
         zp9dnKgg78ZfLB7DowOZ4ItvHufO9XwcI7XCcXgwGkwj9sLEqjZFfbt6H/CjcHisNpyq
         q8/nYBbU4Z+FXxBwBGl+fVO8TPnNBIcCp2j2Dq20vhEQdAYk1dBGvhyqgYUiQa2/CfLq
         4ohA==
X-Gm-Message-State: AO0yUKUNJP028K8BqX/Nhh/vAZAUv7BUyCqPNvCNx6tJUIHM4ueevxZL
        5qC27Uv5Y+UBRhZAU7kIdeWwjSTFA5TudVZhJ9yHmg==
X-Google-Smtp-Source: AK7set+hepjXy8mNFLsGdZJtJUCkkYrnLqzv45sd6fQAhj7fw753M+gaxJjummNMV7I8HmdXhMXUAy7ybafJsF7I4j0=
X-Received: by 2002:a02:94a4:0:b0:3c5:1490:5775 with SMTP id
 x33-20020a0294a4000000b003c514905775mr1817884jah.1.1676685502895; Fri, 17 Feb
 2023 17:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-10-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-10-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Feb 2023 17:58:11 -0800
Message-ID: <CAHS8izPDXHan7bwaiLO6mfNgjVMm=LRqUcuaCJbu8Wb_NN7kTw@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
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
> Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> applied to non-HugeTLB memory in the future, if such an application is
> to arise.
>
> MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> address ranges:
> 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
>    alignment.
> 2. read()ing a page fault event from a userfaultfd will yield a
>    PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
>    address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
>
> There is no way to disable the API changes that come with issuing
> MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> table mappings that come from the extended functionality that comes with
> using MADV_SPLIT.
>

So is a hugetlb page or VMA that has been MADV_SPLIT + MADV_COLLAPSE
distinct from a hugetlb page or vma that has not been? I thought
COLLAPSE would reverse the effects on SPLIT completely.

> For post-copy live migration, the expected use-case is:
> 1. mmap(MAP_SHARED, some_fd) primary mapping
> 2. mmap(MAP_SHARED, some_fd) alias mapping
> 3. MADV_SPLIT the primary mapping
> 4. UFFDIO_REGISTER/etc. the primary mapping
> 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
>    corresponding PAGE_SIZE sections in the primary mapping.
>

Huh, so MADV_SPLIT doesn't actually split an existing PMD mapping into
high granularity mappings. Instead it says that future mappings may be
high granularity? I assume they may not even be high granularity, like
if the alias mapping faulted in a full hugetlb page (without
UFFDIO_CONTINUE) that page would be regular mapped not high
granularity mapped.

This may be bikeshedding but I do think a clearer name is warranted.
Maybe MADV_MAY_SPLIT or something.

> More API changes may be added in the future.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi=
/asm/mman.h
> index 763929e814e9..7a26f3648b90 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -78,6 +78,8 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_SPLIT     26              /* Enable hugepage high-granulari=
ty APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/a=
sm/mman.h
> index c6e1fc77c996..f8a74a3a0928 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -105,6 +105,8 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_SPLIT     26              /* Enable hugepage high-granulari=
ty APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/ua=
pi/asm/mman.h
> index 68c44f99bc93..a6dc6a56c941 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -72,6 +72,8 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_SPLIT     74              /* Enable hugepage high-granulari=
ty APIs */
> +
>  #define MADV_HWPOISON     100          /* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing =
*/
>
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/ua=
pi/asm/mman.h
> index 1ff0c858544f..f98a77c430a9 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -113,6 +113,8 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_SPLIT     26              /* Enable hugepage high-granulari=
ty APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-ge=
neric/mman-common.h
> index 6ce1f1ceb432..996e8ded092f 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -79,6 +79,8 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_SPLIT     26              /* Enable hugepage high-granulari=
ty APIs */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c2202f51e9dd..8c004c678262 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1006,6 +1006,28 @@ static long madvise_remove(struct vm_area_struct *=
vma,
>         return error;
>  }
>
> +static int madvise_split(struct vm_area_struct *vma,
> +                        unsigned long *new_flags)
> +{
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_eligible(vma))
> +               return -EINVAL;
> +
> +       /*
> +        * PMD sharing doesn't work with HGM. If this MADV_SPLIT is on pa=
rt
> +        * of a VMA, then we will split the VMA. Here, we're unsharing be=
fore
> +        * splitting because it's simpler, although we may be unsharing m=
ore
> +        * than we need.
> +        */
> +       hugetlb_unshare_all_pmds(vma);
> +
> +       *new_flags |=3D VM_HUGETLB_HGM;
> +       return 0;
> +#else
> +       return -EINVAL;
> +#endif
> +}
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with i=
ts own
> @@ -1084,6 +1106,11 @@ static int madvise_vma_behavior(struct vm_area_str=
uct *vma,
>                 break;
>         case MADV_COLLAPSE:
>                 return madvise_collapse(vma, prev, start, end);
> +       case MADV_SPLIT:
> +               error =3D madvise_split(vma, &new_flags);
> +               if (error)
> +                       goto out;
> +               break;
>         }
>
>         anon_name =3D anon_vma_name(vma);
> @@ -1178,6 +1205,9 @@ madvise_behavior_valid(int behavior)
>         case MADV_HUGEPAGE:
>         case MADV_NOHUGEPAGE:
>         case MADV_COLLAPSE:
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +       case MADV_SPLIT:
>  #endif
>         case MADV_DONTDUMP:
>         case MADV_DODUMP:
> @@ -1368,6 +1398,8 @@ int madvise_set_anon_name(struct mm_struct *mm, uns=
igned long start,
>   *             transparent huge pages so the existing pages will not be
>   *             coalesced into THP and new pages will not be allocated as=
 THP.
>   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> + *  MADV_SPLIT - allow HugeTLB pages to be mapped at PAGE_SIZE. This all=
ows
> + *             UFFDIO_CONTINUE to accept PAGE_SIZE-aligned regions.
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given =
range
>   *             from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump=
.
> --
> 2.39.2.637.g21b0678d19-goog
>
