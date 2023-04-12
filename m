Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FA96DFD61
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDLSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLSVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:21:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84737B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:21:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id be27so12966654ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681323672; x=1683915672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHQPTt7cWQIEtVROUWDckFXtp54MVdsNKpJI7oRbgyk=;
        b=OZrBxKyYwj4QC35wSxLsKTwVbRWQ2fFxDvXy+9f1nUlAJvn7wU4ruubLZOnOXo/D4V
         ZPm+RI7Fh7WbBIqDQhpg85FQt/ZfHZaxp7oH7bQvyhiwLsfht7sg+tfBtEdh2r+gra7h
         S7HXHOsIzU3uU+y4Gd/sJCzc4ZUGbW+ondyaVAykAwRyuLc188s9MmTS2Lxiq3VX0y/+
         vu8lLT56imdCEXnjEb0vfWtqO4xRiADulBEqgKd9W4e7MG0QxJeWWz0Xod9kv49ZwdHW
         Ah5h2hdIOPSkR80EbNubUYVSNmS/y6hePiT7gU3xxIa7NR0SFdGWsusya5+98avUHwXJ
         OTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323672; x=1683915672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHQPTt7cWQIEtVROUWDckFXtp54MVdsNKpJI7oRbgyk=;
        b=Mlj8fKlY+6vjcpSULLengKkvjCJ5e9u/gwkzPsN7AMcWNWFWOafum2iqkDNMcjxNhX
         kN+s4XA2e7+BBZavB7ce/4vI8GaUdMjaaYUNXv6qrgKyS5mlM7oHj4qqh3+7ZPCrQRfZ
         zZKslyJhv5zVpQoWOcoZkYK41pVWcsBzoODoskBDtFi7dDR/sLqg1zfiTn6XfsAkttFr
         WW7V02iWQ2MarQyV265yDsgie59glbb9NagLz0l5S+L5I9qOEDo8ynOtepcY3qcwA+Nw
         s7VD45nAK0UBJtXOATzHfxKWPGUzoVThwNuArfrT2PANeDmQyDK1ONbfafW6t34cXbAI
         B1DQ==
X-Gm-Message-State: AAQBX9dFyeclgHaqwfUpgfU/XqUJYK+i4PTZd790TsgX77KwhFNaE54k
        YRSaswuwYr3WKbP4Sc/Na2PsgCgvn8HNmIno2sAlNw==
X-Google-Smtp-Source: AKy350bYMa1yg2YTzfWVxAASA8b/5Ob3hSOyy2mAj+ShbF5eucDVWzHVnCnaeoyFzwXobbhw8DkgPWP38vQxHDdYEBo=
X-Received: by 2002:a05:651c:20c:b0:2a7:8203:152c with SMTP id
 y12-20020a05651c020c00b002a78203152cmr3076128ljn.6.1681323671519; Wed, 12 Apr
 2023 11:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164247.328293-1-peterx@redhat.com>
In-Reply-To: <20230412164247.328293-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 11:20:35 -0700
Message-ID: <CAJHvVchBhRf3pP4fCwsrr2s3S5jQP8z4sct5-_0n=tRd4XB9jQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/31] selftests/mm: uffd_[un]register()
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>
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

On Wed, Apr 12, 2023 at 9:42=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Add two helpers to register/unregister to an uffd.  Use them to drop
> duplicate codes.
>
> This patch also drops assert_expected_ioctls_present() and
> get_expected_ioctls().  Reasons:
>
>   - It'll need a lot of effort to pass test_type=3D=3DHUGETLB into it fro=
m the
>   upper, so it's the simplest way to get rid of another global var
>
>   - The ioctls returned in UFFDIO_REGISTER is hardly useful at all, becau=
se
>   any app can already detect kernel support on any ioctl via its
>   corresponding UFFD_FEATURE_*.  The check here is for sanity mostly but
>   it's probably destined no user app will even use it.
>
>   - It's not friendly to one future goal of uffd to run on old kernels, t=
he
>   problem is get_expected_ioctls() compiles against UFFD_API_RANGE_IOCTLS=
,
>   which is a value that can change depending on where the test is compile=
d,
>   rather than reflecting what the kernel underneath has.  It means it'll
>   report false negatives on old kernels so it's against our will.

I do think there is some value in this test, but I see patch 31 adds a
similar test back so it's fine to remove it in the meantime to clean
up things like get_expected_ioctls().

>
> So let's make our live easier.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/hugepage-mremap.c  |  7 +-
>  .../selftests/mm/ksm_functional_tests.c       |  6 +-
>  tools/testing/selftests/mm/uffd-common.c      | 27 ------
>  tools/testing/selftests/mm/uffd-common.h      |  2 -
>  tools/testing/selftests/mm/uffd-stress.c      | 83 +++++--------------
>  tools/testing/selftests/mm/vm_util.c          | 37 +++++++++
>  tools/testing/selftests/mm/vm_util.h          |  4 +
>  7 files changed, 62 insertions(+), 104 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing=
/selftests/mm/hugepage-mremap.c
> index e53b5eaa8fce..2084692fe1c4 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -60,7 +60,6 @@ static void register_region_with_uffd(char *addr, size_=
t len)
>  {
>         long uffd; /* userfaultfd file descriptor */
>         struct uffdio_api uffdio_api;
> -       struct uffdio_register uffdio_register;
>
>         /* Create and enable userfaultfd object. */
>
> @@ -96,11 +95,7 @@ static void register_region_with_uffd(char *addr, size=
_t len)
>          * handling by the userfaultfd object. In mode, we request to tra=
ck
>          * missing pages (i.e., pages that have not yet been faulted in).
>          */
> -
> -       uffdio_register.range.start =3D (unsigned long)addr;
> -       uffdio_register.range.len =3D len;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
> +       if (uffd_register(uffd, addr, len, true, false, false)) {

For what it's worth, I agree with Mike that the booleans here are hard
to read. It's not clear what "true, false, false" means without going
to look at the header file, whereas "uffd_register(uffd, addr, len,
MINOR)" would be immediately clear.

One solution I've seen outside the kernel is to comment the bools, like:

uffd_register(..., /*minor=3D*/true, /*wp=3D*/false, /*minor=3D*/false);

But, then I feel we lose most of the benefit we wanted from switching
to bools anyway (code length). :)

I do agree the macro names are unwieldy, and lots of tests already use
booleans so we'd have to convert from bool -> flag. If it were me, I
would resolve that by:

- Define much shorter aliases for these macros in uffd-common.h
- Consider refactoring callers to not use bools either.

Then again, I also agree with Mike that it's not a deal breaker, if
you like this way much more than that alternative we can leave it.

>                 perror("ioctl-UFFDIO_REGISTER");
>                 exit(1);
>         }
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/te=
sting/selftests/mm/ksm_functional_tests.c
> index d8b5b4930412..d3f26050dfd7 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -178,7 +178,6 @@ static void test_unmerge_discarded(void)
>  static void test_unmerge_uffd_wp(void)
>  {
>         struct uffdio_writeprotect uffd_writeprotect;
> -       struct uffdio_register uffdio_register;
>         const unsigned int size =3D 2 * MiB;
>         struct uffdio_api uffdio_api;
>         char *map;
> @@ -210,10 +209,7 @@ static void test_unmerge_uffd_wp(void)
>         }
>
>         /* Register UFFD-WP, no need for an actual handler. */
> -       uffdio_register.range.start =3D (unsigned long) map;
> -       uffdio_register.range.len =3D size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
> +       if (uffd_register(uffd, map, size, false, true, false)) {
>                 ksft_test_result_fail("UFFDIO_REGISTER_MODE_WP failed\n")=
;
>                 goto close_uffd;
>         }
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/sel=
ftests/mm/uffd-common.c
> index c57757c2a36f..daa5b5781e7a 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -330,33 +330,6 @@ void uffd_test_ctx_init(uint64_t features)
>                         err("pipe");
>  }
>
> -uint64_t get_expected_ioctls(uint64_t mode)
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
> -void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
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
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp)
>  {
>         struct uffdio_writeprotect prms;
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/sel=
ftests/mm/uffd-common.h
> index d9430cfdcb19..11f770391bd9 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -101,8 +101,6 @@ extern uffd_test_ops_t *uffd_test_ops;
>  void uffd_stats_report(struct uffd_stats *stats, int n_cpus);
>  void uffd_test_ctx_init(uint64_t features);
>  void userfaultfd_open(uint64_t *features);
> -uint64_t get_expected_ioctls(uint64_t mode);
> -void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls);
>  int uffd_read_msg(int ufd, struct uffd_msg *msg);
>  void wp_range(int ufd, __u64 start, __u64 len, bool wp);
>  void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_stats *sta=
ts);
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/sel=
ftests/mm/uffd-stress.c
> index c68a9aeefc41..e6d39a755082 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -463,28 +463,19 @@ static int uffdio_zeropage(int ufd, unsigned long o=
ffset)
>  /* exercise UFFDIO_ZEROPAGE */
>  static int userfaultfd_zeropage_test(void)
>  {
> -       struct uffdio_register uffdio_register;
> -
>         printf("testing UFFDIO_ZEROPAGE: ");
>         fflush(stdout);
>
>         uffd_test_ctx_init(0);
>
> -       uffdio_register.range.start =3D (unsigned long) area_dst;
> -       uffdio_register.range.len =3D nr_pages * page_size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -       if (test_uffdio_wp)
> -               uffdio_register.mode |=3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +                         true, test_uffdio_wp, false))
>                 err("register failure");
>
> -       assert_expected_ioctls_present(
> -               uffdio_register.mode, uffdio_register.ioctls);
> -
>         if (area_dst_alias) {
>                 /* Needed this to test zeropage-retry on shared memory */
> -               uffdio_register.range.start =3D (unsigned long) area_dst_=
alias;
> -               if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +               if (uffd_register(uffd, area_dst_alias, nr_pages * page_s=
ize,
> +                                 true, test_uffdio_wp, false))
>                         err("register failure");
>         }
>
> @@ -498,7 +489,6 @@ static int userfaultfd_zeropage_test(void)
>
>  static int userfaultfd_events_test(void)
>  {
> -       struct uffdio_register uffdio_register;
>         pthread_t uffd_mon;
>         int err, features;
>         pid_t pid;
> @@ -514,17 +504,10 @@ static int userfaultfd_events_test(void)
>
>         fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>
> -       uffdio_register.range.start =3D (unsigned long) area_dst;
> -       uffdio_register.range.len =3D nr_pages * page_size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -       if (test_uffdio_wp)
> -               uffdio_register.mode |=3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +                         true, test_uffdio_wp, false))
>                 err("register failure");
>
> -       assert_expected_ioctls_present(
> -               uffdio_register.mode, uffdio_register.ioctls);
> -
>         if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
>                 err("uffd_poll_thread create");
>
> @@ -550,7 +533,6 @@ static int userfaultfd_events_test(void)
>
>  static int userfaultfd_sig_test(void)
>  {
> -       struct uffdio_register uffdio_register;
>         unsigned long userfaults;
>         pthread_t uffd_mon;
>         int err, features;
> @@ -566,17 +548,10 @@ static int userfaultfd_sig_test(void)
>
>         fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>
> -       uffdio_register.range.start =3D (unsigned long) area_dst;
> -       uffdio_register.range.len =3D nr_pages * page_size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -       if (test_uffdio_wp)
> -               uffdio_register.mode |=3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +                         true, test_uffdio_wp, false))
>                 err("register failure");
>
> -       assert_expected_ioctls_present(
> -               uffdio_register.mode, uffdio_register.ioctls);
> -
>         if (faulting_process(1))
>                 err("faulting process failed");
>
> @@ -629,7 +604,6 @@ void check_memory_contents(char *p)
>  static int userfaultfd_minor_test(void)
>  {
>         unsigned long p;
> -       struct uffdio_register uffdio_register;
>         pthread_t uffd_mon;
>         char c;
>         struct uffd_stats stats =3D { 0 };
> @@ -642,17 +616,10 @@ static int userfaultfd_minor_test(void)
>
>         uffd_test_ctx_init(uffd_minor_feature());
>
> -       uffdio_register.range.start =3D (unsigned long)area_dst_alias;
> -       uffdio_register.range.len =3D nr_pages * page_size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MINOR;
> -       if (test_uffdio_wp)
> -               uffdio_register.mode |=3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +       if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
> +                         false, test_uffdio_wp, true))
>                 err("register failure");
>
> -       assert_expected_ioctls_present(
> -               uffdio_register.mode, uffdio_register.ioctls);
> -
>         /*
>          * After registering with UFFD, populate the non-UFFD-registered =
side of
>          * the shared mapping. This should *not* trigger any UFFD minor f=
aults.
> @@ -777,7 +744,6 @@ static void userfaultfd_wp_unpopulated_test(int pagem=
ap_fd)
>
>  static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>  {
> -       struct uffdio_register uffdio_register;
>         int pagemap_fd;
>         uint64_t value;
>
> @@ -805,10 +771,8 @@ static void userfaultfd_pagemap_test(unsigned int te=
st_pgsize)
>                         err("madvise(MADV_NOHUGEPAGE) failed");
>         }
>
> -       uffdio_register.range.start =3D (unsigned long) area_dst;
> -       uffdio_register.range.len =3D nr_pages * page_size;
> -       uffdio_register.mode =3D UFFDIO_REGISTER_MODE_WP;
> -       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +       if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +                         false, true, false))
>                 err("register failed");
>
>         pagemap_fd =3D pagemap_open();
> @@ -858,8 +822,8 @@ static int userfaultfd_stress(void)
>  {
>         void *area;
>         unsigned long nr;
> -       struct uffdio_register uffdio_register;
>         struct uffd_stats uffd_stats[nr_cpus];
> +       uint64_t mem_size =3D nr_pages * page_size;
>
>         uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
>
> @@ -894,20 +858,13 @@ static int userfaultfd_stress(void)
>                         fcntl(uffd, F_SETFL, uffd_flags & ~O_NONBLOCK);
>
>                 /* register */
> -               uffdio_register.range.start =3D (unsigned long) area_dst;
> -               uffdio_register.range.len =3D nr_pages * page_size;
> -               uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> -               if (test_uffdio_wp)
> -                       uffdio_register.mode |=3D UFFDIO_REGISTER_MODE_WP=
;
> -               if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
> +               if (uffd_register(uffd, area_dst, mem_size,
> +                                 true, test_uffdio_wp, false))
>                         err("register failure");
> -               assert_expected_ioctls_present(
> -                       uffdio_register.mode, uffdio_register.ioctls);
>
>                 if (area_dst_alias) {
> -                       uffdio_register.range.start =3D (unsigned long)
> -                               area_dst_alias;
> -                       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register=
))
> +                       if (uffd_register(uffd, area_dst_alias, mem_size,
> +                                         true, test_uffdio_wp, false))
>                                 err("register failure alias");
>                 }
>
> @@ -949,12 +906,10 @@ static int userfaultfd_stress(void)
>                                  nr_pages * page_size, false);
>
>                 /* unregister */
> -               if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range=
))
> +               if (uffd_unregister(uffd, area_dst, mem_size))
>                         err("unregister failure");
>                 if (area_dst_alias) {
> -                       uffdio_register.range.start =3D (unsigned long) a=
rea_dst;
> -                       if (ioctl(uffd, UFFDIO_UNREGISTER,
> -                                 &uffdio_register.range))
> +                       if (uffd_unregister(uffd, area_dst_alias, mem_siz=
e))
>                                 err("unregister failure alias");
>                 }
>
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftes=
ts/mm/vm_util.c
> index 54d227d6f70a..bb633d050d71 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
>  #include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <linux/userfaultfd.h>
>  #include "../kselftest.h"
>  #include "vm_util.h"
>
> @@ -193,3 +195,38 @@ unsigned long default_huge_page_size(void)
>         fclose(f);
>         return hps;
>  }
> +
> +int uffd_register(int uffd, void *addr, uint64_t len,
> +                 bool miss, bool wp, bool minor)
> +{
> +       struct uffdio_register uffdio_register =3D { 0 };
> +       uint64_t mode =3D 0;
> +       int ret =3D 0;
> +
> +       if (miss)
> +               mode |=3D UFFDIO_REGISTER_MODE_MISSING;
> +       if (wp)
> +               mode |=3D UFFDIO_REGISTER_MODE_WP;
> +       if (minor)
> +               mode |=3D UFFDIO_REGISTER_MODE_MINOR;
> +
> +       uffdio_register.range.start =3D (unsigned long)addr;
> +       uffdio_register.range.len =3D len;
> +       uffdio_register.mode =3D mode;
> +
> +       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1)
> +               ret =3D -errno;
> +
> +       return ret;
> +}
> +
> +int uffd_unregister(int uffd, void *addr, uint64_t len)
> +{
> +       struct uffdio_range range =3D { .start =3D (uintptr_t)addr, .len =
=3D len };
> +       int ret =3D 0;
> +
> +       if (ioctl(uffd, UFFDIO_UNREGISTER, &range) =3D=3D -1)
> +               ret =3D -errno;
> +
> +       return ret;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index d9fadddb5c69..3a9762022efd 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -45,6 +45,10 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint6=
4_t hpage_size);
>  int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>  unsigned long default_huge_page_size(void);
>
> +int uffd_register(int uffd, void *addr, uint64_t len,
> +                 bool miss, bool wp, bool minor);
> +int uffd_unregister(int uffd, void *addr, uint64_t len);
> +
>  /*
>   * On ppc64 this will only work with radix 2M hugepage size
>   */
> --
> 2.39.1
>
