Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319BC6D1006
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjC3Uas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3Uap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:30:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDB198D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:30:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g17so26131842lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680208242; x=1682800242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibqoW3aqug8lkTzee2r6dDS7STVhEoPrqifxRDlW8Ew=;
        b=EKma1yxPhX7S7dNEjIgjcNMi1jPUfyn/Z3BVoYLK3q7ysAYFxDxRTekPFQ9THsHBU5
         6SsdoxySmNSRlLIVgsPqfUeF7LJ7t6Thi/wNpKjGa/BhGaZX22sZgNgf39nFa/HSKsDa
         Qee/o4Pp8Kh6MK6ca9kuNkG+QFScr+tuLmuMlCGGJJm4g9ysiXpO8aUsZCdRcPJdXbxV
         VFV4hlVYP1+MMgb/j2GhIMCLDHrflioyiidAeg2NbJSLFcX/f3uU/g8uxYqEcaW4lMTU
         4eubA30dTML5nAFdrOVdGzv62fj1XpDhpwPQutcmk+fmEho17pdJTDqNr1k7ukW0Q9Rk
         pk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208242; x=1682800242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibqoW3aqug8lkTzee2r6dDS7STVhEoPrqifxRDlW8Ew=;
        b=2NUS0i2qOGEn1A82aNF2hQfclKb7a8N/vO2XOAwNAxOt78Ib5USd47s+aiih8cZGQ7
         qXZQTpNthYyEuuDTivz7Z/7cIA4JRVaNDi1Aaw1FCQJKmp4zGKOuhJtXqu4eU+xLf3ID
         0BQpikFZLtIbvoHpw2fVBnldtWNGD71A8qdVqWLahhUN+a40Qs7v3mgJzgN0o0KZKLrU
         FvykZh1UioJylN2SDIpb9/5d4mID7qwAGGZeItmfig8XvsKpTyHXaVDNyxOs7/1vd/xs
         N8GJrJDZ+u979+SPU9USOgcp0LyPZo6Wcvl+4s1EPSaO6VwJBS6lKGStR1/XfExmpPoa
         0MuA==
X-Gm-Message-State: AAQBX9dO6Ea+HWI2lhK/dcW0Uj1UxviQFJjvShjiJTbqHePNEVXFRofQ
        +cV/I3N2WDN1cgXoratZSzwkBfx1QZT7EKq4P+QUqg==
X-Google-Smtp-Source: AKy350aidLSuvX9vJo0uXrSBh5Sk3mH+O9VXXztPPBDn8TXDbKcIWfm/n73qRTubf0tO5RMGGRQK5WHyyA5yUAHn+G8=
X-Received: by 2002:ac2:50c3:0:b0:4d5:ca32:6aea with SMTP id
 h3-20020ac250c3000000b004d5ca326aeamr7392071lfm.10.1680208242140; Thu, 30 Mar
 2023 13:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230330155707.3106228-1-peterx@redhat.com> <20230330160705.3106966-1-peterx@redhat.com>
In-Reply-To: <20230330160705.3106966-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 30 Mar 2023 13:30:05 -0700
Message-ID: <CAJHvVcgUGu+zDjOknKarQ2+MkYRuAyUR-=8HosfmNXkftNvGYQ@mail.gmail.com>
Subject: Re: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into one
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:07=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> There're already 3 same definitions of the three functions.  Move it into
> vm_util.[ch].
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/hugetlb-madvise.c | 25 +-------------------
>  tools/testing/selftests/mm/thuge-gen.c       | 19 +--------------
>  tools/testing/selftests/mm/userfaultfd.c     | 24 -------------------
>  tools/testing/selftests/mm/vm_util.c         | 21 ++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h         |  1 +
>  5 files changed, 24 insertions(+), 66 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing=
/selftests/mm/hugetlb-madvise.c
> index 9a127a8fe176..28426e30d9bc 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -18,6 +18,7 @@
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include <fcntl.h>
> +#include "vm_util.h"
>
>  #define MIN_FREE_PAGES 20
>  #define NR_HUGE_PAGES  10      /* common number of pages to map/allocate=
 */
> @@ -35,30 +36,6 @@
>  unsigned long huge_page_size;
>  unsigned long base_page_size;
>
> -/*
> - * default_huge_page_size copied from mlock2-tests.c
> - */
> -unsigned long default_huge_page_size(void)
> -{
> -       unsigned long hps =3D 0;
> -       char *line =3D NULL;
> -       size_t linelen =3D 0;
> -       FILE *f =3D fopen("/proc/meminfo", "r");
> -
> -       if (!f)
> -               return 0;
> -       while (getline(&line, &linelen, f) > 0) {
> -               if (sscanf(line, "Hugepagesize:       %lu kB", &hps) =3D=
=3D 1) {
> -                       hps <<=3D 10;
> -                       break;
> -               }
> -       }
> -
> -       free(line);
> -       fclose(f);
> -       return hps;
> -}
> -
>  unsigned long get_free_hugepages(void)
>  {
>         unsigned long fhp =3D 0;
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selft=
ests/mm/thuge-gen.c
> index 361ef7192cc6..380ab5f0a534 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -24,6 +24,7 @@
>  #include <unistd.h>
>  #include <stdarg.h>
>  #include <string.h>
> +#include "vm_util.h"
>
>  #define err(x) perror(x), exit(1)
>
> @@ -74,24 +75,6 @@ void find_pagesizes(void)
>         globfree(&g);
>  }
>
> -unsigned long default_huge_page_size(void)
> -{
> -       unsigned long hps =3D 0;
> -       char *line =3D NULL;
> -       size_t linelen =3D 0;
> -       FILE *f =3D fopen("/proc/meminfo", "r");
> -       if (!f)
> -               return 0;
> -       while (getline(&line, &linelen, f) > 0) {
> -               if (sscanf(line, "Hugepagesize:       %lu kB", &hps) =3D=
=3D 1) {
> -                       hps <<=3D 10;
> -                       break;
> -               }
> -       }
> -       free(line);
> -       return hps;
> -}
> -
>  void show(unsigned long ps)
>  {
>         char buf[100];
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/sel=
ftests/mm/userfaultfd.c
> index a96d126cb40e..4cc80a0e8955 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1703,30 +1703,6 @@ static int userfaultfd_stress(void)
>                 || userfaultfd_events_test() || userfaultfd_minor_test();
>  }
>
> -/*
> - * Copied from mlock2-tests.c
> - */
> -unsigned long default_huge_page_size(void)
> -{
> -       unsigned long hps =3D 0;
> -       char *line =3D NULL;
> -       size_t linelen =3D 0;
> -       FILE *f =3D fopen("/proc/meminfo", "r");
> -
> -       if (!f)
> -               return 0;
> -       while (getline(&line, &linelen, f) > 0) {
> -               if (sscanf(line, "Hugepagesize:       %lu kB", &hps) =3D=
=3D 1) {
> -                       hps <<=3D 10;
> -                       break;
> -               }
> -       }
> -
> -       free(line);
> -       fclose(f);
> -       return hps;
> -}
> -
>  static void set_test_type(const char *type)
>  {
>         if (!strcmp(type, "anon")) {
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftes=
ts/mm/vm_util.c
> index 0204c469be43..12dc654b5be3 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -180,3 +180,24 @@ int64_t allocate_transhuge(void *ptr, int pagemap_fd=
)
>
>         return -1;
>  }
> +
> +unsigned long default_huge_page_size(void)
> +{
> +       unsigned long hps =3D 0;
> +       char *line =3D NULL;
> +       size_t linelen =3D 0;
> +       FILE *f =3D fopen("/proc/meminfo", "r");
> +
> +       if (!f)
> +               return 0;
> +       while (getline(&line, &linelen, f) > 0) {
> +               if (sscanf(line, "Hugepagesize:       %lu kB", &hps) =3D=
=3D 1) {
> +                       hps <<=3D 10;
> +                       break;
> +               }
> +       }
> +
> +       free(line);
> +       fclose(f);
> +       return hps;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 6edeb531afc6..d7163fff8fb7 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -35,6 +35,7 @@ bool check_huge_anon(void *addr, int nr_hpages, uint64_=
t hpage_size);
>  bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>  int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> +unsigned long default_huge_page_size(void);
>
>  /*
>   * On ppc64 this will only work with radix 2M hugepage size
> --
> 2.39.1
>
