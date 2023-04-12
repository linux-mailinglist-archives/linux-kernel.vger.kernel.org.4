Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437C96DFD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDLSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:00:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A46A6F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:00:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z8so17610001lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681322423; x=1683914423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pstwB45ZhAyXwZFayK2NDgVBf4FPJuGN430i2FKdyEQ=;
        b=Amuuu6R1WzCwCQ9fwZtokRbdlQTrxdPA3WTp2IpBQ1XUQV5V269tO0vw6eT2BDBsYJ
         tmRe7kxMYGWfwnXNcz2tC0PCAnLD3qu98rwwhJ4ddXgn2u9VRihQCkxaNc0qWUiaPa9A
         0r3fIch+Bxu3D7Xz3SlXMyonGMqHo28AhZWJf6TZTsu8CWXTFIA5vYPhyO0fxndPHrgq
         CFxAToK/zAV/NVa+G50wYaIZ6MwMkWBQJVW6WCdNL7squIvdfxM9tFZ04Ka9M7yNMdvp
         62J7F5wt5G64wdV9fSdV2En5jcS7zVeMDwP7S6Jm5L73jgvRCOEI+c3DoKcKETYCRwmX
         my8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322423; x=1683914423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pstwB45ZhAyXwZFayK2NDgVBf4FPJuGN430i2FKdyEQ=;
        b=hG0VHvwJkEIlHxhj/005BTi5bLj7I+ujZ+SKSB+Accc5HtQg4Hl5McSFSGOhu20cP2
         9/2BKf7sKMVv/za3xTFEeQmFh0R1EP3uVB9+GEHir87wgT5yIm1/sQid4eNBL8FhdhVI
         JFYW30qd1J7zuY31n4XKHMJb5pCfNm8y4ASzrTZ/rJe4hG+D8qkGlr2ZmZvyA0mgHVmr
         T/g8S/4pihRRc45eVCgnY8y6B+V/LubQon+H1CoIjIhHLuTEOaelz8cqnW0H0VK2kvwL
         1jxA05O8KCJ9RcaIH9mhWk1NWNqRcQ+j/yiNazvg8qUqj7nbN9yX/vt+eZWoTwl5bsQ/
         I0nw==
X-Gm-Message-State: AAQBX9cV9p5KeWMlbPJOwkB+n+3Dxt5TRuDaFB/7n6WAmpDHoonUuWrz
        mGLHB5Qn5ofWnyyoI2tQEbc3wykIHtpG80/DENSgEUcS3teLk45KC5fEYQ==
X-Google-Smtp-Source: AKy350byDIo25NCbs4/tkc8TLbNgnuz4ebOO59Bf9GBOaKfIGVaI/Z5xuOMqllwqbd3TICKu7u2LEE9nFwGWJRANNlY=
X-Received: by 2002:ac2:46f9:0:b0:4eb:2d45:f682 with SMTP id
 q25-20020ac246f9000000b004eb2d45f682mr990532lfo.10.1681322422824; Wed, 12 Apr
 2023 11:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164241.328259-1-peterx@redhat.com>
In-Reply-To: <20230412164241.328259-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 10:59:45 -0700
Message-ID: <CAJHvVch1xSKikcixCO+HYHfaioJFtCyivVrdMw0PQ2oDcztfnw@mail.gmail.com>
Subject: Re: [PATCH v2 12/31] selftests/mm: Create uffd-common.[ch]
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 9:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Move common utility functions into uffd-common.[ch] files from the origin=
al
> userfaultfd.c.  This prepares for a split of userfaultfd.c into two tests=
:
> one to only cover the old but powerful stress test, the other one covers
> all the functional tests.
>
> This movement is kind of a brute-force effort for now, with light touch-u=
ps
> but nothing should really change.  There's chances to optimize more, but
> let's leave that for later.
>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/Makefile      |   2 +
>  tools/testing/selftests/mm/uffd-common.c | 611 ++++++++++++++++++++
>  tools/testing/selftests/mm/uffd-common.h | 117 ++++
>  tools/testing/selftests/mm/userfaultfd.c | 694 +----------------------
>  4 files changed, 731 insertions(+), 693 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/uffd-common.c
>  create mode 100644 tools/testing/selftests/mm/uffd-common.h
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index 5f7626550e5f..36467c15ca00 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -108,6 +108,8 @@ include ../lib.mk
>
>  $(TEST_GEN_PROGS): vm_util.c
>
> +$(OUTPUT)/userfaultfd: uffd-common.c
> +
>  ifeq ($(MACHINE),x86_64)
>  BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/sel=
ftests/mm/uffd-common.c
> new file mode 100644
> index 000000000000..c57757c2a36f
> --- /dev/null
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -0,0 +1,611 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Userfaultfd tests util functions
> + *
> + * Copyright (C) 2015-2023  Red Hat, Inc.
> + */
> +
> +#include "uffd-common.h"
> +
> +#define BASE_PMD_ADDR ((void *)(1UL << 30))
> +
> +volatile bool test_uffdio_copy_eexist =3D true;
> +unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size=
;
> +char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap=
;
> +int mem_fd, uffd =3D -1, uffd_flags, finished, *pipefd, test_type;
> +bool map_shared, test_collapse, test_dev_userfaultfd;
> +bool test_uffdio_wp =3D true, test_uffdio_minor =3D false;
> +unsigned long long *count_verify;
> +uffd_test_ops_t *uffd_test_ops;
> +
> +static void anon_release_pages(char *rel_area)
> +{
> +       if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
> +               err("madvise(MADV_DONTNEED) failed");
> +}
> +
> +static void anon_allocate_area(void **alloc_area, bool is_src)
> +{
> +       *alloc_area =3D mmap(NULL, nr_pages * page_size, PROT_READ | PROT=
_WRITE,
> +                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +}
> +
> +static void noop_alias_mapping(__u64 *start, size_t len, unsigned long o=
ffset)
> +{
> +}
> +
> +static void hugetlb_release_pages(char *rel_area)
> +{
> +       if (!map_shared) {
> +               if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED=
))
> +                       err("madvise(MADV_DONTNEED) failed");
> +       } else {
> +               if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> +                       err("madvise(MADV_REMOVE) failed");
> +       }
> +}
> +
> +static void hugetlb_allocate_area(void **alloc_area, bool is_src)
> +{
> +       off_t size =3D nr_pages * page_size;
> +       off_t offset =3D is_src ? 0 : size;
> +       void *area_alias =3D NULL;
> +       char **alloc_area_alias;
> +
> +       *alloc_area =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> +                          (is_src ? 0 : MAP_NORESERVE),
> +                          mem_fd, offset);
> +       if (*alloc_area =3D=3D MAP_FAILED)
> +               err("mmap of hugetlbfs file failed");
> +
> +       if (map_shared) {
> +               area_alias =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> +                                 MAP_SHARED, mem_fd, offset);
> +               if (area_alias =3D=3D MAP_FAILED)
> +                       err("mmap of hugetlb file alias failed");
> +       }
> +
> +       if (is_src) {
> +               alloc_area_alias =3D &area_src_alias;
> +       } else {
> +               alloc_area_alias =3D &area_dst_alias;
> +       }
> +       if (area_alias)
> +               *alloc_area_alias =3D area_alias;
> +}
> +
> +static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned lon=
g offset)
> +{
> +       if (!map_shared)
> +               return;
> +
> +       *start =3D (unsigned long) area_dst_alias + offset;
> +}
> +
> +static void shmem_release_pages(char *rel_area)
> +{
> +       if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> +               err("madvise(MADV_REMOVE) failed");
> +}
> +
> +static void shmem_allocate_area(void **alloc_area, bool is_src)
> +{
> +       void *area_alias =3D NULL;
> +       size_t bytes =3D nr_pages * page_size;
> +       unsigned long offset =3D is_src ? 0 : bytes;
> +       char *p =3D NULL, *p_alias =3D NULL;
> +
> +       if (test_collapse) {
> +               p =3D BASE_PMD_ADDR;
> +               if (!is_src)
> +                       /* src map + alias + interleaved hpages */
> +                       p +=3D 2 * (bytes + hpage_size);
> +               p_alias =3D p;
> +               p_alias +=3D bytes;
> +               p_alias +=3D hpage_size;  /* Prevent src/dst VMA merge */
> +       }
> +
> +       *alloc_area =3D mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED=
,
> +                          mem_fd, offset);
> +       if (*alloc_area =3D=3D MAP_FAILED)
> +               err("mmap of memfd failed");
> +       if (test_collapse && *alloc_area !=3D p)
> +               err("mmap of memfd failed at %p", p);
> +
> +       area_alias =3D mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_S=
HARED,
> +                         mem_fd, offset);
> +       if (area_alias =3D=3D MAP_FAILED)
> +               err("mmap of memfd alias failed");
> +       if (test_collapse && area_alias !=3D p_alias)
> +               err("mmap of anonymous memory failed at %p", p_alias);
> +
> +       if (is_src)
> +               area_src_alias =3D area_alias;
> +       else
> +               area_dst_alias =3D area_alias;
> +}
> +
> +static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long =
offset)
> +{
> +       *start =3D (unsigned long)area_dst_alias + offset;
> +}
> +
> +static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
> +{
> +       if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_siz=
e))
> +               err("Did not find expected %d number of hugepages",
> +                   expect_nr_hpages);
> +}
> +
> +struct uffd_test_ops anon_uffd_test_ops =3D {
> +       .allocate_area =3D anon_allocate_area,
> +       .release_pages =3D anon_release_pages,
> +       .alias_mapping =3D noop_alias_mapping,
> +       .check_pmd_mapping =3D NULL,
> +};
> +
> +struct uffd_test_ops shmem_uffd_test_ops =3D {
> +       .allocate_area =3D shmem_allocate_area,
> +       .release_pages =3D shmem_release_pages,
> +       .alias_mapping =3D shmem_alias_mapping,
> +       .check_pmd_mapping =3D shmem_check_pmd_mapping,
> +};
> +
> +struct uffd_test_ops hugetlb_uffd_test_ops =3D {
> +       .allocate_area =3D hugetlb_allocate_area,
> +       .release_pages =3D hugetlb_release_pages,
> +       .alias_mapping =3D hugetlb_alias_mapping,
> +       .check_pmd_mapping =3D NULL,
> +};
> +
> +void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
> +{
> +       int i;
> +       unsigned long long miss_total =3D 0, wp_total =3D 0, minor_total =
=3D 0;
> +
> +       for (i =3D 0; i < n_cpus; i++) {
> +               miss_total +=3D stats[i].missing_faults;
> +               wp_total +=3D stats[i].wp_faults;
> +               minor_total +=3D stats[i].minor_faults;
> +       }
> +
> +       printf("userfaults: ");
> +       if (miss_total) {
> +               printf("%llu missing (", miss_total);
> +               for (i =3D 0; i < n_cpus; i++)
> +                       printf("%lu+", stats[i].missing_faults);
> +               printf("\b) ");
> +       }
> +       if (wp_total) {
> +               printf("%llu wp (", wp_total);
> +               for (i =3D 0; i < n_cpus; i++)
> +                       printf("%lu+", stats[i].wp_faults);
> +               printf("\b) ");
> +       }
> +       if (minor_total) {
> +               printf("%llu minor (", minor_total);
> +               for (i =3D 0; i < n_cpus; i++)
> +                       printf("%lu+", stats[i].minor_faults);
> +               printf("\b)");
> +       }
> +       printf("\n");
> +}
> +
> +static int __userfaultfd_open_dev(void)
> +{
> +       int fd, _uffd;
> +
> +       fd =3D open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +       if (fd < 0)
> +               errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
> +
> +       _uffd =3D ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> +       if (_uffd < 0)
> +               errexit(errno =3D=3D ENOTTY ? KSFT_SKIP : 1,
> +                       "creating userfaultfd failed");
> +       close(fd);
> +       return _uffd;
> +}
> +
> +void userfaultfd_open(uint64_t *features)
> +{
> +       struct uffdio_api uffdio_api;
> +
> +       if (test_dev_userfaultfd)
> +               uffd =3D __userfaultfd_open_dev();
> +       else {
> +               uffd =3D syscall(__NR_userfaultfd, UFFD_FLAGS);
> +               if (uffd < 0)
> +                       errexit(errno =3D=3D ENOSYS ? KSFT_SKIP : 1,
> +                               "creating userfaultfd failed");
> +       }
> +       uffd_flags =3D fcntl(uffd, F_GETFD, NULL);
> +
> +       uffdio_api.api =3D UFFD_API;
> +       uffdio_api.features =3D *features;
> +       if (ioctl(uffd, UFFDIO_API, &uffdio_api))
> +               err("UFFDIO_API failed.\nPlease make sure to "
> +                   "run with either root or ptrace capability.");
> +       if (uffdio_api.api !=3D UFFD_API)
> +               err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.ap=
i);
> +
> +       *features =3D uffdio_api.features;
> +}
> +
> +static inline void munmap_area(void **area)
> +{
> +       if (*area)
> +               if (munmap(*area, nr_pages * page_size))
> +                       err("munmap");
> +
> +       *area =3D NULL;
> +}
> +
> +static void uffd_test_ctx_clear(void)
> +{
> +       size_t i;
> +
> +       if (pipefd) {
> +               for (i =3D 0; i < nr_cpus * 2; ++i) {
> +                       if (close(pipefd[i]))
> +                               err("close pipefd");
> +               }
> +               free(pipefd);
> +               pipefd =3D NULL;
> +       }
> +
> +       if (count_verify) {
> +               free(count_verify);
> +               count_verify =3D NULL;
> +       }
> +
> +       if (uffd !=3D -1) {
> +               if (close(uffd))
> +                       err("close uffd");
> +               uffd =3D -1;
> +       }
> +
> +       munmap_area((void **)&area_src);
> +       munmap_area((void **)&area_src_alias);
> +       munmap_area((void **)&area_dst);
> +       munmap_area((void **)&area_dst_alias);
> +       munmap_area((void **)&area_remap);
> +}
> +
> +void uffd_test_ctx_init(uint64_t features)
> +{
> +       unsigned long nr, cpu;
> +
> +       uffd_test_ctx_clear();
> +
> +       uffd_test_ops->allocate_area((void **)&area_src, true);
> +       uffd_test_ops->allocate_area((void **)&area_dst, false);
> +
> +       userfaultfd_open(&features);
> +
> +       count_verify =3D malloc(nr_pages * sizeof(unsigned long long));
> +       if (!count_verify)
> +               err("count_verify");
> +
> +       for (nr =3D 0; nr < nr_pages; nr++) {
> +               *area_mutex(area_src, nr) =3D
> +                       (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
> +               count_verify[nr] =3D *area_count(area_src, nr) =3D 1;
> +               /*
> +                * In the transition between 255 to 256, powerpc will
> +                * read out of order in my_bcmp and see both bytes as
> +                * zero, so leave a placeholder below always non-zero
> +                * after the count, to avoid my_bcmp to trigger false
> +                * positives.
> +                */
> +               *(area_count(area_src, nr) + 1) =3D 1;
> +       }
> +
> +       /*
> +        * After initialization of area_src, we must explicitly release p=
ages
> +        * for area_dst to make sure it's fully empty.  Otherwise we coul=
d have
> +        * some area_dst pages be errornously initialized with zero pages=
,
> +        * hence we could hit memory corruption later in the test.
> +        *
> +        * One example is when THP is globally enabled, above allocate_ar=
ea()
> +        * calls could have the two areas merged into a single VMA (as th=
ey
> +        * will have the same VMA flags so they're mergeable).  When we
> +        * initialize the area_src above, it's possible that some part of
> +        * area_dst could have been faulted in via one huge THP that will=
 be
> +        * shared between area_src and area_dst.  It could cause some of =
the
> +        * area_dst won't be trapped by missing userfaults.
> +        *
> +        * This release_pages() will guarantee even if that happened, we'=
ll
> +        * proactively split the thp and drop any accidentally initialize=
d
> +        * pages within area_dst.
> +        */
> +       uffd_test_ops->release_pages(area_dst);
> +
> +       pipefd =3D malloc(sizeof(int) * nr_cpus * 2);
> +       if (!pipefd)
> +               err("pipefd");
> +       for (cpu =3D 0; cpu < nr_cpus; cpu++)
> +               if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
> +                       err("pipe");
> +}
> +
> +uint64_t get_expected_ioctls(uint64_t mode)
> +{
> +       uint64_t ioctls =3D UFFD_API_RANGE_IOCTLS;
> +
> +       if (test_type =3D=3D TEST_HUGETLB)
> +               ioctls &=3D ~(1 << _UFFDIO_ZEROPAGE);
> +
> +       if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
> +               ioctls &=3D ~(1 << _UFFDIO_WRITEPROTECT);
> +
> +       if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
> +               ioctls &=3D ~(1 << _UFFDIO_CONTINUE);
> +
> +       return ioctls;
> +}
> +
> +void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
> +{
> +       uint64_t expected =3D get_expected_ioctls(mode);
> +       uint64_t actual =3D ioctls & expected;
> +
> +       if (actual !=3D expected) {
> +               err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx6=
4,
> +                   expected, actual);
> +       }
> +}
> +
> +void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> +{
> +       struct uffdio_writeprotect prms;
> +
> +       /* Write protection page faults */
> +       prms.range.start =3D start;
> +       prms.range.len =3D len;
> +       /* Undo write-protect, do wakeup after that */
> +       prms.mode =3D wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
> +
> +       if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
> +               err("clear WP failed: address=3D0x%"PRIx64, (uint64_t)sta=
rt);
> +}
> +
> +static void continue_range(int ufd, __u64 start, __u64 len)
> +{
> +       struct uffdio_continue req;
> +       int ret;
> +
> +       req.range.start =3D start;
> +       req.range.len =3D len;
> +       req.mode =3D 0;
> +       if (test_uffdio_wp)
> +               req.mode |=3D UFFDIO_CONTINUE_MODE_WP;
> +
> +       if (ioctl(ufd, UFFDIO_CONTINUE, &req))
> +               err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
> +                   (uint64_t)start);
> +
> +       /*
> +        * Error handling within the kernel for continue is subtly differ=
ent
> +        * from copy or zeropage, so it may be a source of bugs. Trigger =
an
> +        * error (-EEXIST) on purpose, to verify doing so doesn't cause a=
 BUG.
> +        */
> +       req.mapped =3D 0;
> +       ret =3D ioctl(ufd, UFFDIO_CONTINUE, &req);
> +       if (ret >=3D 0 || req.mapped !=3D -EEXIST)
> +               err("failed to exercise UFFDIO_CONTINUE error handling, r=
et=3D%d, mapped=3D%" PRId64,
> +                   ret, (int64_t) req.mapped);
> +}
> +
> +int uffd_read_msg(int ufd, struct uffd_msg *msg)
> +{
> +       int ret =3D read(uffd, msg, sizeof(*msg));
> +
> +       if (ret !=3D sizeof(*msg)) {
> +               if (ret < 0) {
> +                       if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
> +                               return 1;
> +                       err("blocking read error");
> +               } else {
> +                       err("short read");
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *sta=
ts)
> +{
> +       unsigned long offset;
> +
> +       if (msg->event !=3D UFFD_EVENT_PAGEFAULT)
> +               err("unexpected msg event %u", msg->event);
> +
> +       if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
> +               /* Write protect page faults */
> +               wp_range(uffd, msg->arg.pagefault.address, page_size, fal=
se);
> +               stats->wp_faults++;
> +       } else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) =
{
> +               uint8_t *area;
> +               int b;
> +
> +               /*
> +                * Minor page faults
> +                *
> +                * To prove we can modify the original range for testing
> +                * purposes, we're going to bit flip this range before
> +                * continuing.
> +                *
> +                * Note that this requires all minor page fault tests ope=
rate on
> +                * area_dst (non-UFFD-registered) and area_dst_alias
> +                * (UFFD-registered).
> +                */
> +
> +               area =3D (uint8_t *)(area_dst +
> +                                  ((char *)msg->arg.pagefault.address -
> +                                   area_dst_alias));
> +               for (b =3D 0; b < page_size; ++b)
> +                       area[b] =3D ~area[b];
> +               continue_range(uffd, msg->arg.pagefault.address, page_siz=
e);
> +               stats->minor_faults++;
> +       } else {
> +               /*
> +                * Missing page faults.
> +                *
> +                * Here we force a write check for each of the missing mo=
de
> +                * faults.  It's guaranteed because the only threads that
> +                * will trigger uffd faults are the locking threads, and
> +                * their first instruction to touch the missing page will
> +                * always be pthread_mutex_lock().
> +                *
> +                * Note that here we relied on an NPTL glibc impl detail =
to
> +                * always read the lock type at the entry of the lock op
> +                * (pthread_mutex_t.__data.__type, offset 0x10) before
> +                * doing any locking operations to guarantee that.  It's
> +                * actually not good to rely on this impl detail because
> +                * logically a pthread-compatible lib can implement the
> +                * locks without types and we can fail when linking with
> +                * them.  However since we used to find bugs with this
> +                * strict check we still keep it around.  Hopefully this
> +                * could be a good hint when it fails again.  If one day
> +                * it'll break on some other impl of glibc we'll revisit.
> +                */
> +               if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
> +                       err("unexpected write fault");
> +
> +               offset =3D (char *)(unsigned long)msg->arg.pagefault.addr=
ess - area_dst;
> +               offset &=3D ~(page_size-1);
> +
> +               if (copy_page(uffd, offset))
> +                       stats->missing_faults++;
> +       }
> +}
> +
> +void *uffd_poll_thread(void *arg)
> +{
> +       struct uffd_stats *stats =3D (struct uffd_stats *)arg;
> +       unsigned long cpu =3D stats->cpu;
> +       struct pollfd pollfd[2];
> +       struct uffd_msg msg;
> +       struct uffdio_register uffd_reg;
> +       int ret;
> +       char tmp_chr;
> +
> +       pollfd[0].fd =3D uffd;
> +       pollfd[0].events =3D POLLIN;
> +       pollfd[1].fd =3D pipefd[cpu*2];
> +       pollfd[1].events =3D POLLIN;
> +
> +       for (;;) {
> +               ret =3D poll(pollfd, 2, -1);
> +               if (ret <=3D 0) {
> +                       if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
> +                               continue;
> +                       err("poll error: %d", ret);
> +               }
> +               if (pollfd[1].revents) {
> +                       if (!(pollfd[1].revents & POLLIN))
> +                               err("pollfd[1].revents %d", pollfd[1].rev=
ents);
> +                       if (read(pollfd[1].fd, &tmp_chr, 1) !=3D 1)
> +                               err("read pipefd error");
> +                       break;
> +               }
> +               if (!(pollfd[0].revents & POLLIN))
> +                       err("pollfd[0].revents %d", pollfd[0].revents);
> +               if (uffd_read_msg(uffd, &msg))
> +                       continue;
> +               switch (msg.event) {
> +               default:
> +                       err("unexpected msg event %u\n", msg.event);
> +                       break;
> +               case UFFD_EVENT_PAGEFAULT:
> +                       uffd_handle_page_fault(&msg, stats);
> +                       break;
> +               case UFFD_EVENT_FORK:
> +                       close(uffd);
> +                       uffd =3D msg.arg.fork.ufd;
> +                       pollfd[0].fd =3D uffd;
> +                       break;
> +               case UFFD_EVENT_REMOVE:
> +                       uffd_reg.range.start =3D msg.arg.remove.start;
> +                       uffd_reg.range.len =3D msg.arg.remove.end -
> +                               msg.arg.remove.start;
> +                       if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.rang=
e))
> +                               err("remove failure");
> +                       break;
> +               case UFFD_EVENT_REMAP:
> +                       area_remap =3D area_dst;  /* save for later unmap=
 */
> +                       area_dst =3D (char *)(unsigned long)msg.arg.remap=
.to;
> +                       break;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
> +                           unsigned long offset)
> +{
> +       uffd_test_ops->alias_mapping(&uffdio_copy->dst,
> +                                    uffdio_copy->len,
> +                                    offset);
> +       if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
> +               /* real retval in ufdio_copy.copy */
> +               if (uffdio_copy->copy !=3D -EEXIST)
> +                       err("UFFDIO_COPY retry error: %"PRId64,
> +                           (int64_t)uffdio_copy->copy);
> +       } else {
> +               err("UFFDIO_COPY retry unexpected: %"PRId64,
> +                   (int64_t)uffdio_copy->copy);
> +       }
> +}
> +
> +static void wake_range(int ufd, unsigned long addr, unsigned long len)
> +{
> +       struct uffdio_range uffdio_wake;
> +
> +       uffdio_wake.start =3D addr;
> +       uffdio_wake.len =3D len;
> +
> +       if (ioctl(ufd, UFFDIO_WAKE, &uffdio_wake))
> +               fprintf(stderr, "error waking %lu\n",
> +                       addr), exit(1);
> +}
> +
> +int __copy_page(int ufd, unsigned long offset, bool retry)
> +{
> +       struct uffdio_copy uffdio_copy;
> +
> +       if (offset >=3D nr_pages * page_size)
> +               err("unexpected offset %lu\n", offset);
> +       uffdio_copy.dst =3D (unsigned long) area_dst + offset;
> +       uffdio_copy.src =3D (unsigned long) area_src + offset;
> +       uffdio_copy.len =3D page_size;
> +       if (test_uffdio_wp)
> +               uffdio_copy.mode =3D UFFDIO_COPY_MODE_WP;
> +       else
> +               uffdio_copy.mode =3D 0;
> +       uffdio_copy.copy =3D 0;
> +       if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
> +               /* real retval in ufdio_copy.copy */
> +               if (uffdio_copy.copy !=3D -EEXIST)
> +                       err("UFFDIO_COPY error: %"PRId64,
> +                           (int64_t)uffdio_copy.copy);
> +               wake_range(ufd, uffdio_copy.dst, page_size);
> +       } else if (uffdio_copy.copy !=3D page_size) {
> +               err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.co=
py);
> +       } else {
> +               if (test_uffdio_copy_eexist && retry) {
> +                       test_uffdio_copy_eexist =3D false;
> +                       retry_copy_page(ufd, &uffdio_copy, offset);
> +               }
> +               return 1;
> +       }
> +       return 0;
> +}
> +
> +int copy_page(int ufd, unsigned long offset)
> +{
> +       return __copy_page(ufd, offset, false);
> +}
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/sel=
ftests/mm/uffd-common.h
> new file mode 100644
> index 000000000000..d9430cfdcb19
> --- /dev/null
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Userfaultfd tests common header
> + *
> + * Copyright (C) 2015-2023  Red Hat, Inc.
> + */
> +#ifndef __UFFD_COMMON_H__
> +#define __UFFD_COMMON_H__
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <poll.h>
> +#include <string.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
> +#include <sys/wait.h>
> +#include <pthread.h>
> +#include <linux/userfaultfd.h>
> +#include <setjmp.h>
> +#include <stdbool.h>
> +#include <assert.h>
> +#include <inttypes.h>
> +#include <stdint.h>
> +#include <sys/random.h>
> +
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +#define UFFD_FLAGS     (O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
> +
> +#define _err(fmt, ...)                                         \
> +       do {                                                    \
> +               int ret =3D errno;                                \
> +               fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);  \
> +               fprintf(stderr, " (errno=3D%d, @%s:%d)\n",        \
> +                       ret, __FILE__, __LINE__);               \
> +       } while (0)
> +
> +#define errexit(exitcode, fmt, ...)            \
> +       do {                                    \
> +               _err(fmt, ##__VA_ARGS__);       \
> +               exit(exitcode);                 \
> +       } while (0)
> +
> +#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
> +
> +/* pthread_mutex_t starts at page offset 0 */
> +#define area_mutex(___area, ___nr)                                     \
> +       ((pthread_mutex_t *) ((___area) + (___nr)*page_size))
> +/*
> + * count is placed in the page after pthread_mutex_t naturally aligned
> + * to avoid non alignment faults on non-x86 archs.
> + */
> +#define area_count(___area, ___nr)                                     \
> +       ((volatile unsigned long long *) ((unsigned long)               \
> +                                ((___area) + (___nr)*page_size +       \
> +                                 sizeof(pthread_mutex_t) +             \
> +                                 sizeof(unsigned long long) - 1) &     \
> +                                ~(unsigned long)(sizeof(unsigned long lo=
ng) \
> +                                                 -  1)))
> +
> +/* Userfaultfd test statistics */
> +struct uffd_stats {
> +       int cpu;
> +       unsigned long missing_faults;
> +       unsigned long wp_faults;
> +       unsigned long minor_faults;
> +};
> +
> +struct uffd_test_ops {
> +       void (*allocate_area)(void **alloc_area, bool is_src);
> +       void (*release_pages)(char *rel_area);
> +       void (*alias_mapping)(__u64 *start, size_t len, unsigned long off=
set);
> +       void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
> +};
> +typedef struct uffd_test_ops uffd_test_ops_t;
> +
> +extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpa=
ge_size;
> +extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *are=
a_remap;
> +extern int mem_fd, uffd, uffd_flags, finished, *pipefd, test_type;
> +extern bool map_shared, test_collapse, test_dev_userfaultfd;
> +extern bool test_uffdio_wp, test_uffdio_minor;
> +extern unsigned long long *count_verify;
> +extern volatile bool test_uffdio_copy_eexist;
> +
> +extern uffd_test_ops_t anon_uffd_test_ops;
> +extern uffd_test_ops_t shmem_uffd_test_ops;
> +extern uffd_test_ops_t hugetlb_uffd_test_ops;
> +extern uffd_test_ops_t *uffd_test_ops;
> +
> +void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
> +void uffd_test_ctx_init(uint64_t features);
> +void userfaultfd_open(uint64_t *features);
> +uint64_t get_expected_ioctls(uint64_t mode);
> +void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls);
> +int uffd_read_msg(int ufd, struct uffd_msg *msg);
> +void wp_range(int ufd, __u64 start, __u64 len, bool wp);
> +void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *sta=
ts);
> +int __copy_page(int ufd, unsigned long offset, bool retry);
> +int copy_page(int ufd, unsigned long offset);
> +void *uffd_poll_thread(void *arg);
> +
> +#define TEST_ANON      1
> +#define TEST_HUGETLB   2
> +#define TEST_SHMEM     3
> +
> +#endif
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/sel=
ftests/mm/userfaultfd.c
> index 3487ec0bfcc8..c68a9aeefc41 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -34,96 +34,20 @@
>   * transfer (UFFDIO_COPY).
>   */
>
> -#define _GNU_SOURCE
> -#include <stdio.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <time.h>
> -#include <signal.h>
> -#include <poll.h>
> -#include <string.h>
> -#include <linux/mman.h>
> -#include <sys/mman.h>
> -#include <sys/syscall.h>
> -#include <sys/ioctl.h>
> -#include <sys/wait.h>
> -#include <pthread.h>
> -#include <linux/userfaultfd.h>
> -#include <setjmp.h>
> -#include <stdbool.h>
> -#include <assert.h>
> -#include <inttypes.h>
> -#include <stdint.h>
> -#include <sys/random.h>
> -
> -#include "../kselftest.h"
> -#include "vm_util.h"
> +#include "uffd-common.h"
>
>  #ifdef __NR_userfaultfd
>
> -static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpa=
ge_size;
> -
>  #define BOUNCE_RANDOM          (1<<0)
>  #define BOUNCE_RACINGFAULTS    (1<<1)
>  #define BOUNCE_VERIFY          (1<<2)
>  #define BOUNCE_POLL            (1<<3)
>  static int bounces;
>
> -#define TEST_ANON      1
> -#define TEST_HUGETLB   2
> -#define TEST_SHMEM     3
> -static int test_type;
> -
> -#define UFFD_FLAGS     (O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
> -
> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
> -
> -/* test using /dev/userfaultfd, instead of userfaultfd(2) */
> -static bool test_dev_userfaultfd;
> -
>  /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
>  #define ALARM_INTERVAL_SECS 10
> -static volatile bool test_uffdio_copy_eexist =3D true;
> -/* Whether to test uffd write-protection */
> -static bool test_uffdio_wp =3D true;
> -/* Whether to test uffd minor faults */
> -static bool test_uffdio_minor =3D false;
> -static bool map_shared;
> -static int mem_fd;
> -static unsigned long long *count_verify;
> -static int uffd =3D -1;
> -static int uffd_flags, finished, *pipefd;
> -static char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *are=
a_remap;
>  static char *zeropage;
>  pthread_attr_t attr;
> -static bool test_collapse;
> -
> -/* Userfaultfd test statistics */
> -struct uffd_stats {
> -       int cpu;
> -       unsigned long missing_faults;
> -       unsigned long wp_faults;
> -       unsigned long minor_faults;
> -};
> -
> -/* pthread_mutex_t starts at page offset 0 */
> -#define area_mutex(___area, ___nr)                                     \
> -       ((pthread_mutex_t *) ((___area) + (___nr)*page_size))
> -/*
> - * count is placed in the page after pthread_mutex_t naturally aligned
> - * to avoid non alignment faults on non-x86 archs.
> - */
> -#define area_count(___area, ___nr)                                     \
> -       ((volatile unsigned long long *) ((unsigned long)               \
> -                                ((___area) + (___nr)*page_size +       \
> -                                 sizeof(pthread_mutex_t) +             \
> -                                 sizeof(unsigned long long) - 1) &     \
> -                                ~(unsigned long)(sizeof(unsigned long lo=
ng) \
> -                                                 -  1)))
>
>  #define swap(a, b) \
>         do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } while=
 (0)
> @@ -166,22 +90,6 @@ static void usage(void)
>         exit(1);
>  }
>
> -#define _err(fmt, ...)                                         \
> -       do {                                                    \
> -               int ret =3D errno;                                \
> -               fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);  \
> -               fprintf(stderr, " (errno=3D%d, line=3D%d)\n",       \
> -                       ret, __LINE__);                         \
> -       } while (0)
> -
> -#define errexit(exitcode, fmt, ...)            \
> -       do {                                    \
> -               _err(fmt, ##__VA_ARGS__);       \
> -               exit(exitcode);                 \
> -       } while (0)
> -
> -#define err(fmt, ...) errexit(1, fmt, ##__VA_ARGS__)
> -
>  static void uffd_stats_reset(struct uffd_stats *uffd_stats,
>                              unsigned long n_cpus)
>  {
> @@ -195,189 +103,6 @@ static void uffd_stats_reset(struct uffd_stats *uff=
d_stats,
>         }
>  }
>
> -static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
> -{
> -       int i;
> -       unsigned long long miss_total =3D 0, wp_total =3D 0, minor_total =
=3D 0;
> -
> -       for (i =3D 0; i < n_cpus; i++) {
> -               miss_total +=3D stats[i].missing_faults;
> -               wp_total +=3D stats[i].wp_faults;
> -               minor_total +=3D stats[i].minor_faults;
> -       }
> -
> -       printf("userfaults: ");
> -       if (miss_total) {
> -               printf("%llu missing (", miss_total);
> -               for (i =3D 0; i < n_cpus; i++)
> -                       printf("%lu+", stats[i].missing_faults);
> -               printf("\b) ");
> -       }
> -       if (wp_total) {
> -               printf("%llu wp (", wp_total);
> -               for (i =3D 0; i < n_cpus; i++)
> -                       printf("%lu+", stats[i].wp_faults);
> -               printf("\b) ");
> -       }
> -       if (minor_total) {
> -               printf("%llu minor (", minor_total);
> -               for (i =3D 0; i < n_cpus; i++)
> -                       printf("%lu+", stats[i].minor_faults);
> -               printf("\b)");
> -       }
> -       printf("\n");
> -}
> -
> -static void anon_release_pages(char *rel_area)
> -{
> -       if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
> -               err("madvise(MADV_DONTNEED) failed");
> -}
> -
> -static void anon_allocate_area(void **alloc_area, bool is_src)
> -{
> -       *alloc_area =3D mmap(NULL, nr_pages * page_size, PROT_READ | PROT=
_WRITE,
> -                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -}
> -
> -static void noop_alias_mapping(__u64 *start, size_t len, unsigned long o=
ffset)
> -{
> -}
> -
> -static void hugetlb_release_pages(char *rel_area)
> -{
> -       if (!map_shared) {
> -               if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED=
))
> -                       err("madvise(MADV_DONTNEED) failed");
> -       } else {
> -               if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> -                       err("madvise(MADV_REMOVE) failed");
> -       }
> -}
> -
> -static void hugetlb_allocate_area(void **alloc_area, bool is_src)
> -{
> -       off_t size =3D nr_pages * page_size;
> -       off_t offset =3D is_src ? 0 : size;
> -       void *area_alias =3D NULL;
> -       char **alloc_area_alias;
> -
> -       *alloc_area =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> -                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> -                          (is_src ? 0 : MAP_NORESERVE),
> -                          mem_fd, offset);
> -       if (*alloc_area =3D=3D MAP_FAILED)
> -               err("mmap of hugetlbfs file failed");
> -
> -       if (map_shared) {
> -               area_alias =3D mmap(NULL, size, PROT_READ | PROT_WRITE,
> -                                 MAP_SHARED, mem_fd, offset);
> -               if (area_alias =3D=3D MAP_FAILED)
> -                       err("mmap of hugetlb file alias failed");
> -       }
> -
> -       if (is_src) {
> -               alloc_area_alias =3D &area_src_alias;
> -       } else {
> -               alloc_area_alias =3D &area_dst_alias;
> -       }
> -       if (area_alias)
> -               *alloc_area_alias =3D area_alias;
> -}
> -
> -static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned lon=
g offset)
> -{
> -       if (!map_shared)
> -               return;
> -
> -       *start =3D (unsigned long) area_dst_alias + offset;
> -}
> -
> -static void shmem_release_pages(char *rel_area)
> -{
> -       if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
> -               err("madvise(MADV_REMOVE) failed");
> -}
> -
> -static void shmem_allocate_area(void **alloc_area, bool is_src)
> -{
> -       void *area_alias =3D NULL;
> -       size_t bytes =3D nr_pages * page_size;
> -       unsigned long offset =3D is_src ? 0 : bytes;
> -       char *p =3D NULL, *p_alias =3D NULL;
> -
> -       if (test_collapse) {
> -               p =3D BASE_PMD_ADDR;
> -               if (!is_src)
> -                       /* src map + alias + interleaved hpages */
> -                       p +=3D 2 * (bytes + hpage_size);
> -               p_alias =3D p;
> -               p_alias +=3D bytes;
> -               p_alias +=3D hpage_size;  /* Prevent src/dst VMA merge */
> -       }
> -
> -       *alloc_area =3D mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED=
,
> -                          mem_fd, offset);
> -       if (*alloc_area =3D=3D MAP_FAILED)
> -               err("mmap of memfd failed");
> -       if (test_collapse && *alloc_area !=3D p)
> -               err("mmap of memfd failed at %p", p);
> -
> -       area_alias =3D mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_S=
HARED,
> -                         mem_fd, offset);
> -       if (area_alias =3D=3D MAP_FAILED)
> -               err("mmap of memfd alias failed");
> -       if (test_collapse && area_alias !=3D p_alias)
> -               err("mmap of anonymous memory failed at %p", p_alias);
> -
> -       if (is_src)
> -               area_src_alias =3D area_alias;
> -       else
> -               area_dst_alias =3D area_alias;
> -}
> -
> -static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long =
offset)
> -{
> -       *start =3D (unsigned long)area_dst_alias + offset;
> -}
> -
> -static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
> -{
> -       if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_siz=
e))
> -               err("Did not find expected %d number of hugepages",
> -                   expect_nr_hpages);
> -}
> -
> -struct uffd_test_ops {
> -       void (*allocate_area)(void **alloc_area, bool is_src);
> -       void (*release_pages)(char *rel_area);
> -       void (*alias_mapping)(__u64 *start, size_t len, unsigned long off=
set);
> -       void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
> -};
> -
> -static struct uffd_test_ops anon_uffd_test_ops =3D {
> -       .allocate_area  =3D anon_allocate_area,
> -       .release_pages  =3D anon_release_pages,
> -       .alias_mapping =3D noop_alias_mapping,
> -       .check_pmd_mapping =3D NULL,
> -};
> -
> -static struct uffd_test_ops shmem_uffd_test_ops =3D {
> -       .allocate_area  =3D shmem_allocate_area,
> -       .release_pages  =3D shmem_release_pages,
> -       .alias_mapping =3D shmem_alias_mapping,
> -       .check_pmd_mapping =3D shmem_check_pmd_mapping,
> -};
> -
> -static struct uffd_test_ops hugetlb_uffd_test_ops =3D {
> -       .allocate_area  =3D hugetlb_allocate_area,
> -       .release_pages  =3D hugetlb_release_pages,
> -       .alias_mapping =3D hugetlb_alias_mapping,
> -       .check_pmd_mapping =3D NULL,
> -};
> -
> -static struct uffd_test_ops *uffd_test_ops;
> -
>  static inline uint64_t uffd_minor_feature(void)
>  {
>         if (test_type =3D=3D TEST_HUGETLB && map_shared)
> @@ -388,171 +113,6 @@ static inline uint64_t uffd_minor_feature(void)
>                 return 0;
>  }
>
> -static uint64_t get_expected_ioctls(uint64_t mode)
> -{
> -       uint64_t ioctls =3D UFFD_API_RANGE_IOCTLS;
> -
> -       if (test_type =3D=3D TEST_HUGETLB)
> -               ioctls &=3D ~(1 << _UFFDIO_ZEROPAGE);
> -
> -       if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
> -               ioctls &=3D ~(1 << _UFFDIO_WRITEPROTECT);
> -
> -       if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
> -               ioctls &=3D ~(1 << _UFFDIO_CONTINUE);
> -
> -       return ioctls;
> -}
> -
> -static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctl=
s)
> -{
> -       uint64_t expected =3D get_expected_ioctls(mode);
> -       uint64_t actual =3D ioctls & expected;
> -
> -       if (actual !=3D expected) {
> -               err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx6=
4,
> -                   expected, actual);
> -       }
> -}
> -
> -static int __userfaultfd_open_dev(void)
> -{
> -       int fd, _uffd;
> -
> -       fd =3D open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> -       if (fd < 0)
> -               errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
> -
> -       _uffd =3D ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
> -       if (_uffd < 0)
> -               errexit(errno =3D=3D ENOTTY ? KSFT_SKIP : 1,
> -                       "creating userfaultfd failed");
> -       close(fd);
> -       return _uffd;
> -}
> -
> -static void userfaultfd_open(uint64_t *features)
> -{
> -       struct uffdio_api uffdio_api;
> -
> -       if (test_dev_userfaultfd)
> -               uffd =3D __userfaultfd_open_dev();
> -       else {
> -               uffd =3D syscall(__NR_userfaultfd, UFFD_FLAGS);
> -               if (uffd < 0)
> -                       errexit(errno =3D=3D ENOSYS ? KSFT_SKIP : 1,
> -                               "creating userfaultfd failed");
> -       }
> -       uffd_flags =3D fcntl(uffd, F_GETFD, NULL);
> -
> -       uffdio_api.api =3D UFFD_API;
> -       uffdio_api.features =3D *features;
> -       if (ioctl(uffd, UFFDIO_API, &uffdio_api))
> -               err("UFFDIO_API failed.\nPlease make sure to "
> -                   "run with either root or ptrace capability.");
> -       if (uffdio_api.api !=3D UFFD_API)
> -               err("UFFDIO_API error: %" PRIu64, (uint64_t)uffdio_api.ap=
i);
> -
> -       *features =3D uffdio_api.features;
> -}
> -
> -static inline void munmap_area(void **area)
> -{
> -       if (*area)
> -               if (munmap(*area, nr_pages * page_size))
> -                       err("munmap");
> -
> -       *area =3D NULL;
> -}
> -
> -static void uffd_test_ctx_clear(void)
> -{
> -       size_t i;
> -
> -       if (pipefd) {
> -               for (i =3D 0; i < nr_cpus * 2; ++i) {
> -                       if (close(pipefd[i]))
> -                               err("close pipefd");
> -               }
> -               free(pipefd);
> -               pipefd =3D NULL;
> -       }
> -
> -       if (count_verify) {
> -               free(count_verify);
> -               count_verify =3D NULL;
> -       }
> -
> -       if (uffd !=3D -1) {
> -               if (close(uffd))
> -                       err("close uffd");
> -               uffd =3D -1;
> -       }
> -
> -       munmap_area((void **)&area_src);
> -       munmap_area((void **)&area_src_alias);
> -       munmap_area((void **)&area_dst);
> -       munmap_area((void **)&area_dst_alias);
> -       munmap_area((void **)&area_remap);
> -}
> -
> -static void uffd_test_ctx_init(uint64_t features)
> -{
> -       unsigned long nr, cpu;
> -
> -       uffd_test_ctx_clear();
> -
> -       uffd_test_ops->allocate_area((void **)&area_src, true);
> -       uffd_test_ops->allocate_area((void **)&area_dst, false);
> -
> -       userfaultfd_open(&features);
> -
> -       count_verify =3D malloc(nr_pages * sizeof(unsigned long long));
> -       if (!count_verify)
> -               err("count_verify");
> -
> -       for (nr =3D 0; nr < nr_pages; nr++) {
> -               *area_mutex(area_src, nr) =3D
> -                       (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
> -               count_verify[nr] =3D *area_count(area_src, nr) =3D 1;
> -               /*
> -                * In the transition between 255 to 256, powerpc will
> -                * read out of order in my_bcmp and see both bytes as
> -                * zero, so leave a placeholder below always non-zero
> -                * after the count, to avoid my_bcmp to trigger false
> -                * positives.
> -                */
> -               *(area_count(area_src, nr) + 1) =3D 1;
> -       }
> -
> -       /*
> -        * After initialization of area_src, we must explicitly release p=
ages
> -        * for area_dst to make sure it's fully empty.  Otherwise we coul=
d have
> -        * some area_dst pages be errornously initialized with zero pages=
,
> -        * hence we could hit memory corruption later in the test.
> -        *
> -        * One example is when THP is globally enabled, above allocate_ar=
ea()
> -        * calls could have the two areas merged into a single VMA (as th=
ey
> -        * will have the same VMA flags so they're mergeable).  When we
> -        * initialize the area_src above, it's possible that some part of
> -        * area_dst could have been faulted in via one huge THP that will=
 be
> -        * shared between area_src and area_dst.  It could cause some of =
the
> -        * area_dst won't be trapped by missing userfaults.
> -        *
> -        * This release_pages() will guarantee even if that happened, we'=
ll
> -        * proactively split the thp and drop any accidentally initialize=
d
> -        * pages within area_dst.
> -        */
> -       uffd_test_ops->release_pages(area_dst);
> -
> -       pipefd =3D malloc(sizeof(int) * nr_cpus * 2);
> -       if (!pipefd)
> -               err("pipefd");
> -       for (cpu =3D 0; cpu < nr_cpus; cpu++)
> -               if (pipe2(&pipefd[cpu * 2], O_CLOEXEC | O_NONBLOCK))
> -                       err("pipe");
> -}
> -
>  static int my_bcmp(char *str1, char *str2, size_t n)
>  {
>         unsigned long i;
> @@ -562,47 +122,6 @@ static int my_bcmp(char *str1, char *str2, size_t n)
>         return 0;
>  }
>
> -static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> -{
> -       struct uffdio_writeprotect prms;
> -
> -       /* Write protection page faults */
> -       prms.range.start =3D start;
> -       prms.range.len =3D len;
> -       /* Undo write-protect, do wakeup after that */
> -       prms.mode =3D wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
> -
> -       if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
> -               err("clear WP failed: address=3D0x%"PRIx64, (uint64_t)sta=
rt);
> -}
> -
> -static void continue_range(int ufd, __u64 start, __u64 len)
> -{
> -       struct uffdio_continue req;
> -       int ret;
> -
> -       req.range.start =3D start;
> -       req.range.len =3D len;
> -       req.mode =3D 0;
> -       if (test_uffdio_wp)
> -               req.mode |=3D UFFDIO_CONTINUE_MODE_WP;
> -
> -       if (ioctl(ufd, UFFDIO_CONTINUE, &req))
> -               err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
> -                   (uint64_t)start);
> -
> -       /*
> -        * Error handling within the kernel for continue is subtly differ=
ent
> -        * from copy or zeropage, so it may be a source of bugs. Trigger =
an
> -        * error (-EEXIST) on purpose, to verify doing so doesn't cause a=
 BUG.
> -        */
> -       req.mapped =3D 0;
> -       ret =3D ioctl(ufd, UFFDIO_CONTINUE, &req);
> -       if (ret >=3D 0 || req.mapped !=3D -EEXIST)
> -               err("failed to exercise UFFDIO_CONTINUE error handling, r=
et=3D%d, mapped=3D%" PRId64,
> -                   ret, (int64_t) req.mapped);
> -}
> -
>  static void *locking_thread(void *arg)
>  {
>         unsigned long cpu =3D (unsigned long) arg;
> @@ -635,222 +154,11 @@ static void *locking_thread(void *arg)
>         return NULL;
>  }
>
> -static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
> -                           unsigned long offset)
> -{
> -       uffd_test_ops->alias_mapping(&uffdio_copy->dst,
> -                                    uffdio_copy->len,
> -                                    offset);
> -       if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
> -               /* real retval in ufdio_copy.copy */
> -               if (uffdio_copy->copy !=3D -EEXIST)
> -                       err("UFFDIO_COPY retry error: %"PRId64,
> -                           (int64_t)uffdio_copy->copy);
> -       } else {
> -               err("UFFDIO_COPY retry unexpected: %"PRId64,
> -                   (int64_t)uffdio_copy->copy);
> -       }
> -}
> -
> -static void wake_range(int ufd, unsigned long addr, unsigned long len)
> -{
> -       struct uffdio_range uffdio_wake;
> -
> -       uffdio_wake.start =3D addr;
> -       uffdio_wake.len =3D len;
> -
> -       if (ioctl(ufd, UFFDIO_WAKE, &uffdio_wake))
> -               fprintf(stderr, "error waking %lu\n",
> -                       addr), exit(1);
> -}
> -
> -static int __copy_page(int ufd, unsigned long offset, bool retry)
> -{
> -       struct uffdio_copy uffdio_copy;
> -
> -       if (offset >=3D nr_pages * page_size)
> -               err("unexpected offset %lu\n", offset);
> -       uffdio_copy.dst =3D (unsigned long) area_dst + offset;
> -       uffdio_copy.src =3D (unsigned long) area_src + offset;
> -       uffdio_copy.len =3D page_size;
> -       if (test_uffdio_wp)
> -               uffdio_copy.mode =3D UFFDIO_COPY_MODE_WP;
> -       else
> -               uffdio_copy.mode =3D 0;
> -       uffdio_copy.copy =3D 0;
> -       if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
> -               /* real retval in ufdio_copy.copy */
> -               if (uffdio_copy.copy !=3D -EEXIST)
> -                       err("UFFDIO_COPY error: %"PRId64,
> -                           (int64_t)uffdio_copy.copy);
> -               wake_range(ufd, uffdio_copy.dst, page_size);
> -       } else if (uffdio_copy.copy !=3D page_size) {
> -               err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.co=
py);
> -       } else {
> -               if (test_uffdio_copy_eexist && retry) {
> -                       test_uffdio_copy_eexist =3D false;
> -                       retry_copy_page(ufd, &uffdio_copy, offset);
> -               }
> -               return 1;
> -       }
> -       return 0;
> -}
> -
>  static int copy_page_retry(int ufd, unsigned long offset)
>  {
>         return __copy_page(ufd, offset, true);
>  }
>
> -static int copy_page(int ufd, unsigned long offset)
> -{
> -       return __copy_page(ufd, offset, false);
> -}
> -
> -static int uffd_read_msg(int ufd, struct uffd_msg *msg)
> -{
> -       int ret =3D read(uffd, msg, sizeof(*msg));
> -
> -       if (ret !=3D sizeof(*msg)) {
> -               if (ret < 0) {
> -                       if (errno =3D=3D EAGAIN || errno =3D=3D EINTR)
> -                               return 1;
> -                       err("blocking read error");
> -               } else {
> -                       err("short read");
> -               }
> -       }
> -
> -       return 0;
> -}
> -
> -static void uffd_handle_page_fault(struct uffd_msg *msg,
> -                                  struct uffd_stats *stats)
> -{
> -       unsigned long offset;
> -
> -       if (msg->event !=3D UFFD_EVENT_PAGEFAULT)
> -               err("unexpected msg event %u", msg->event);
> -
> -       if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
> -               /* Write protect page faults */
> -               wp_range(uffd, msg->arg.pagefault.address, page_size, fal=
se);
> -               stats->wp_faults++;
> -       } else if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR) =
{
> -               uint8_t *area;
> -               int b;
> -
> -               /*
> -                * Minor page faults
> -                *
> -                * To prove we can modify the original range for testing
> -                * purposes, we're going to bit flip this range before
> -                * continuing.
> -                *
> -                * Note that this requires all minor page fault tests ope=
rate on
> -                * area_dst (non-UFFD-registered) and area_dst_alias
> -                * (UFFD-registered).
> -                */
> -
> -               area =3D (uint8_t *)(area_dst +
> -                                  ((char *)msg->arg.pagefault.address -
> -                                   area_dst_alias));
> -               for (b =3D 0; b < page_size; ++b)
> -                       area[b] =3D ~area[b];
> -               continue_range(uffd, msg->arg.pagefault.address, page_siz=
e);
> -               stats->minor_faults++;
> -       } else {
> -               /*
> -                * Missing page faults.
> -                *
> -                * Here we force a write check for each of the missing mo=
de
> -                * faults.  It's guaranteed because the only threads that
> -                * will trigger uffd faults are the locking threads, and
> -                * their first instruction to touch the missing page will
> -                * always be pthread_mutex_lock().
> -                *
> -                * Note that here we relied on an NPTL glibc impl detail =
to
> -                * always read the lock type at the entry of the lock op
> -                * (pthread_mutex_t.__data.__type, offset 0x10) before
> -                * doing any locking operations to guarantee that.  It's
> -                * actually not good to rely on this impl detail because
> -                * logically a pthread-compatible lib can implement the
> -                * locks without types and we can fail when linking with
> -                * them.  However since we used to find bugs with this
> -                * strict check we still keep it around.  Hopefully this
> -                * could be a good hint when it fails again.  If one day
> -                * it'll break on some other impl of glibc we'll revisit.
> -                */
> -               if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
> -                       err("unexpected write fault");
> -
> -               offset =3D (char *)(unsigned long)msg->arg.pagefault.addr=
ess - area_dst;
> -               offset &=3D ~(page_size-1);
> -
> -               if (copy_page(uffd, offset))
> -                       stats->missing_faults++;
> -       }
> -}
> -
> -static void *uffd_poll_thread(void *arg)
> -{
> -       struct uffd_stats *stats =3D (struct uffd_stats *)arg;
> -       unsigned long cpu =3D stats->cpu;
> -       struct pollfd pollfd[2];
> -       struct uffd_msg msg;
> -       struct uffdio_register uffd_reg;
> -       int ret;
> -       char tmp_chr;
> -
> -       pollfd[0].fd =3D uffd;
> -       pollfd[0].events =3D POLLIN;
> -       pollfd[1].fd =3D pipefd[cpu*2];
> -       pollfd[1].events =3D POLLIN;
> -
> -       for (;;) {
> -               ret =3D poll(pollfd, 2, -1);
> -               if (ret <=3D 0) {
> -                       if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
> -                               continue;
> -                       err("poll error: %d", ret);
> -               }
> -               if (pollfd[1].revents & POLLIN) {
> -                       if (read(pollfd[1].fd, &tmp_chr, 1) !=3D 1)
> -                               err("read pipefd error");
> -                       break;
> -               }
> -               if (!(pollfd[0].revents & POLLIN))
> -                       err("pollfd[0].revents %d", pollfd[0].revents);
> -               if (uffd_read_msg(uffd, &msg))
> -                       continue;
> -               switch (msg.event) {
> -               default:
> -                       err("unexpected msg event %u\n", msg.event);
> -                       break;
> -               case UFFD_EVENT_PAGEFAULT:
> -                       uffd_handle_page_fault(&msg, stats);
> -                       break;
> -               case UFFD_EVENT_FORK:
> -                       close(uffd);
> -                       uffd =3D msg.arg.fork.ufd;
> -                       pollfd[0].fd =3D uffd;
> -                       break;
> -               case UFFD_EVENT_REMOVE:
> -                       uffd_reg.range.start =3D msg.arg.remove.start;
> -                       uffd_reg.range.len =3D msg.arg.remove.end -
> -                               msg.arg.remove.start;
> -                       if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.rang=
e))
> -                               err("remove failure");
> -                       break;
> -               case UFFD_EVENT_REMAP:
> -                       area_remap =3D area_dst;  /* save for later unmap=
 */
> -                       area_dst =3D (char *)(unsigned long)msg.arg.remap=
.to;
> -                       break;
> -               }
> -       }
> -
> -       return NULL;
> -}
> -
>  pthread_mutex_t uffd_read_mutex =3D PTHREAD_MUTEX_INITIALIZER;
>
>  static void *uffd_read_thread(void *arg)
> --
> 2.39.1
>
