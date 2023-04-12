Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951AC6DFD34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDLSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDLSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:04:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3CF187
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:04:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z26so15688806lfj.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681322665; x=1683914665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtMUkS08a6OQr/bGWBbcgzBdPz10386ZoYdd9g5+ys4=;
        b=YvN48bvhIlEEL92Xf3nqLVv/jy0yktbd14LTf3MzC4Qr6G0IJi3iibOij5xAYL9AqZ
         NkIEY9aNrUMantltGrKJoS/eBo/lJmvEhJvUIERmdvRMk1/4N8GPAfLZQmxizVaocC8E
         Pl+fUZarcRl8Or5Ajk3elzjGPjsZbdfgdg0HVHCcYaoazpPWJSrd+livaUDgAuotwQ5H
         /+Tpwqs7vLyK0hdqrfhIJzJuvfFCqLJJGWQovrPKuPJHHzxbPKnZR2rHHx+UHvjkayb0
         1lyUcvgPQlRc7Gz9V9Ge8MaxyNkSZp1p6c/D7ZV/4oL0UTkd2SMzk2ee6XVWaqdyHINd
         J8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322665; x=1683914665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtMUkS08a6OQr/bGWBbcgzBdPz10386ZoYdd9g5+ys4=;
        b=GSTs/DeK9mw7RJLavXgiiuVxypFWdAQpoPiwDwvKiz6I9TrILJ8WFk2cJS8pqPwilc
         g3fmiieg84jMuVYH9wQQWXpWYvUlJtIszY2gDRxLrhssFyA78AyM5T/Ubb8Ak7dLV4UL
         PDiNTx+Ji7KWmwjwGXkgX7tZCh6NSm8L5r4swaF9lBCsz9AocwuP60lr3sKcYPBITAGA
         1aKukchKlAiEyomb7eurNyyqR2NpAKdhfrzzm+kOYDaqG5EDqOVGmMlHpr1aqcb+fxTd
         ROXFkTeDQO2AI1nx/IXvmssnL63ktm8nJ1lgry8WzG2dGW4rny0gvq3vxort1c2q81dh
         ecDg==
X-Gm-Message-State: AAQBX9fVy3wvqAK7KZije+JkK5jKMZqnnm7OK6+mffc4zukUI8wD51zK
        D4O4wdrU6VM0PmpzZFNYNExVGkL95KVo0ksw88qDCg==
X-Google-Smtp-Source: AKy350agLc9ENZTAk6C7yi0oa3N5DQkYwGy95fThzsyJlA/z6d8rDRJC84v1TJCI6eFNnJzm3UP/EI2a0rYKUutc+Qk=
X-Received: by 2002:a05:6512:90c:b0:4ea:e5e3:7eb0 with SMTP id
 e12-20020a056512090c00b004eae5e37eb0mr5562653lft.10.1681322664673; Wed, 12
 Apr 2023 11:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230412163922.327282-1-peterx@redhat.com> <20230412164244.328270-1-peterx@redhat.com>
In-Reply-To: <20230412164244.328270-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 12 Apr 2023 11:03:48 -0700
Message-ID: <CAJHvVcjWwc02Ke4ws-ma77=4pRrHch_JmDUwO7tJg5eJw6P_Pg@mail.gmail.com>
Subject: Re: [PATCH v2 13/31] selftests/mm: Split uffd tests into uffd-stress
 and uffd-unit-tests
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
> In many ways it's weird and unwanted to keep all the tests in the same
> userfaultfd.c at least when still in the current way.
>
> For example, it doesn't make much sense to run the stress test for each
> method we can create an userfaultfd handle (either via syscall or /dev/
> node).  It's a waste of time running this twice for the whole stress as t=
he
> stress paths are the same, only the open path is different.
>
> It's also just weird to need to manually specify different types of memor=
y
> to run all unit tests for the userfaultfd interface.  We should be able t=
o
> just run a single program and that should go through all functional uffd
> tests without running the stress test at all.  The stress test was more f=
or
> torturing and finding race conditions.  We don't want to wait for stress =
to
> finish just to regress test a functional test.
>
> When we start to pile up more things on top of the same file and same
> functions, things start to go a bit chaos and the code is just harder to
> maintain too with tons of global variables.
>
> This patch creates a new test uffd-unit-tests to keep userfaultfd unit
> tests in the future, currently empty.
>
> Meanwhile rename the old userfaultfd.c test to uffd-stress.c.
>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/.gitignore         |  3 ++-
>  tools/testing/selftests/mm/Makefile           |  8 +++---
>  tools/testing/selftests/mm/run_vmtests.sh     | 10 ++++---
>  .../mm/{userfaultfd.c =3D> uffd-stress.c}       |  0
>  tools/testing/selftests/mm/uffd-unit-tests.c  | 27 +++++++++++++++++++
>  5 files changed, 40 insertions(+), 8 deletions(-)
>  rename tools/testing/selftests/mm/{userfaultfd.c =3D> uffd-stress.c} (10=
0%)
>  create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selfte=
sts/mm/.gitignore
> index 347277f2adc3..8917455f4f51 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -21,7 +21,8 @@ protection_keys
>  protection_keys_32
>  protection_keys_64
>  madv_populate
> -userfaultfd
> +uffd-stress
> +uffd-unit-tests
>  mlock-intersect-test
>  mlock-random-test
>  virtual_address_range
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index 36467c15ca00..5a3434419403 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -20,7 +20,7 @@ MACHINE ?=3D $(shell echo $(uname_M) | sed -e 's/aarch6=
4.*/arm64/' -e 's/ppc64.*/p
>  # Avoid accidental wrong builds, due to built-in rules working just a li=
ttle
>  # bit too well--but not quite as well as required for our situation here=
.
>  #
> -# In other words, "make userfaultfd" is supposed to fail to build at all=
,
> +# In other words, "make $SOME_TEST" is supposed to fail to build at all,
>  # because this Makefile only supports either "make" (all), or "make /ful=
l/path".
>  # However,  the built-in rules, if not suppressed, will pick up CFLAGS a=
nd the
>  # initial LDLIBS (but not the target-specific LDLIBS, because those are =
only
> @@ -57,7 +57,8 @@ TEST_GEN_PROGS +=3D mremap_test
>  TEST_GEN_PROGS +=3D on-fault-limit
>  TEST_GEN_PROGS +=3D thuge-gen
>  TEST_GEN_PROGS +=3D transhuge-stress
> -TEST_GEN_PROGS +=3D userfaultfd
> +TEST_GEN_PROGS +=3D uffd-stress
> +TEST_GEN_PROGS +=3D uffd-unit-tests
>  TEST_GEN_PROGS +=3D soft-dirty
>  TEST_GEN_PROGS +=3D split_huge_page_test
>  TEST_GEN_PROGS +=3D ksm_tests
> @@ -108,7 +109,8 @@ include ../lib.mk
>
>  $(TEST_GEN_PROGS): vm_util.c
>
> -$(OUTPUT)/userfaultfd: uffd-common.c
> +$(OUTPUT)/uffd-stress: uffd-common.c
> +$(OUTPUT)/uffd-unit-tests: uffd-common.c
>
>  ifeq ($(MACHINE),x86_64)
>  BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index ddf40f883747..efe22dc569f0 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -196,14 +196,16 @@ CATEGORY=3D"gup_test" run_test ./gup_test -a
>  # Dump pages 0, 19, and 4096, using pin_user_pages:
>  CATEGORY=3D"gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
>
> +CATEGORY=3D"userfaultfd" run_test ./uffd-unit-tests
>  uffd_mods=3D("" ":dev")
> +uffd_stress_bin=3D./uffd-stress
>  for mod in "${uffd_mods[@]}"; do
> -       CATEGORY=3D"userfaultfd" run_test ./userfaultfd anon${mod} 20 16
> +       CATEGORY=3D"userfaultfd" run_test ${uffd_stress_bin} anon${mod} 2=
0 16
>         # Hugetlb tests require source and destination huge pages. Pass i=
n half
>         # the size ($half_ufd_size_MB), which is used for *each*.
> -       CATEGORY=3D"userfaultfd" run_test ./userfaultfd hugetlb${mod} "$h=
alf_ufd_size_MB" 32
> -       CATEGORY=3D"userfaultfd" run_test ./userfaultfd hugetlb_shared${m=
od} "$half_ufd_size_MB" 32
> -       CATEGORY=3D"userfaultfd" run_test ./userfaultfd shmem${mod} 20 16
> +       CATEGORY=3D"userfaultfd" run_test ${uffd_stress_bin} hugetlb${mod=
} "$half_ufd_size_MB" 32
> +       CATEGORY=3D"userfaultfd" run_test ${uffd_stress_bin} hugetlb_shar=
ed${mod} "$half_ufd_size_MB" 32
> +       CATEGORY=3D"userfaultfd" run_test ${uffd_stress_bin} shmem${mod} =
20 16
>  done
>
>  #cleanup
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/sel=
ftests/mm/uffd-stress.c
> similarity index 100%
> rename from tools/testing/selftests/mm/userfaultfd.c
> rename to tools/testing/selftests/mm/uffd-stress.c
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing=
/selftests/mm/uffd-unit-tests.c
> new file mode 100644
> index 000000000000..6857388783be
> --- /dev/null
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Userfaultfd unit tests.
> + *
> + *  Copyright (C) 2015-2023  Red Hat, Inc.
> + */
> +
> +#include "uffd-common.h"
> +
> +#ifdef __NR_userfaultfd
> +
> +int main(int argc, char *argv[])
> +{
> +       return KSFT_PASS;
> +}
> +
> +#else /* __NR_userfaultfd */
> +
> +#warning "missing __NR_userfaultfd definition"
> +
> +int main(void)
> +{
> +       printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
> +       return KSFT_SKIP;
> +}
> +
> +#endif /* __NR_userfaultfd */
> --
> 2.39.1
>
