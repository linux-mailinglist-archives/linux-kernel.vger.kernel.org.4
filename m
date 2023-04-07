Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F96DABEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDGLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjDGLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:03:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBFA6A74
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:02:52 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3379Rm7u003005;
        Fri, 7 Apr 2023 11:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=B3Hc3AO7nsCmztpIafB3Q/2Ut1dFVUeP+4f9w1s5d7c=;
 b=B8MtwBHWNVQXpwYJQ2D4o6IjiqI5a9CxO8Id6rs2+cV0YdYvlP8JRMUABcu2E61XKxbD
 C5SgqvUICQWtG6RamSSwU/bHKFccMoMfjw6+FA8dq+iAGxVcFsP7aKCCGJ2pZDeRP7DN
 NscB3l70SbzYRMyCpqfPPx+zfPyTXQLRr0Oy5PPpikVDYLFuhzKJ5leWd1fSijwoRn5p
 1w9xt83l2OrZkm5SSgUXvqrim2pMMxcMb60GTQ2vkb1ubRrSwqg9POzWirp4Fe5vcibY
 YZITfZyh06nZ3gpq4Jlhp8xkbzKiIWiUAu1DQYx5jMYR+x+gr0CWwzyJ7X+5p5vlEvcu iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pta9x144b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:02:46 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337Atrd4035494;
        Fri, 7 Apr 2023 11:02:46 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pta9x143h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:02:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336LuNGY020329;
        Fri, 7 Apr 2023 11:02:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc87cwxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:02:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B2fQv65274172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:02:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8256E2004B;
        Fri,  7 Apr 2023 11:02:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49C5320040;
        Fri,  7 Apr 2023 11:02:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:02:40 +0000 (GMT)
Date:   Fri, 7 Apr 2023 14:02:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 13/29] selftests/mm: Split uffd tests into uffd-stress
 and uffd-unit-tests
Message-ID: <ZC/4TglHaFUHe+U4@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160723.3107032-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160723.3107032-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sXJyXlW8KWdk5185RWgOfRlhcFk-Yl7V
X-Proofpoint-ORIG-GUID: -H6sq_nIAZpB0XAzEqxkBG1qdchrSMXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070097
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:23PM -0400, Peter Xu wrote:
> In many ways it's weird and unwanted to keep all the tests in the same
> userfaultfd.c at least when still in the current way.
> 
> For example, it doesn't make much sense to run the stress test for each
> method we can create an userfaultfd handle (either via syscall or /dev/
> node).  It's a waste of time running this twice for the whole stress as the
> stress paths are the same, only the open path is different.
> 
> It's also just weird to need to manually specify different types of memory
> to run all unit tests for the userfaultfd interface.  We should be able to
> just run a single program and that should go through all functional uffd
> tests without running the stress test at all.  The stress test was more for
> torturing and finding race conditions.  We don't want to wait for stress to
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
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/.gitignore         |  3 ++-
>  tools/testing/selftests/mm/Makefile           |  8 +++---
>  tools/testing/selftests/mm/run_vmtests.sh     | 10 ++++---
>  .../mm/{userfaultfd.c => uffd-stress.c}       |  0
>  tools/testing/selftests/mm/uffd-unit-tests.c  | 27 +++++++++++++++++++
>  5 files changed, 40 insertions(+), 8 deletions(-)
>  rename tools/testing/selftests/mm/{userfaultfd.c => uffd-stress.c} (100%)
>  create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
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
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 9c3737285f8a..ca8bc4ac71e6 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -20,7 +20,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>  # Avoid accidental wrong builds, due to built-in rules working just a little
>  # bit too well--but not quite as well as required for our situation here.
>  #
> -# In other words, "make userfaultfd" is supposed to fail to build at all,
> +# In other words, "make $SOME_TEST" is supposed to fail to build at all,
>  # because this Makefile only supports either "make" (all), or "make /full/path".
>  # However,  the built-in rules, if not suppressed, will pick up CFLAGS and the
>  # initial LDLIBS (but not the target-specific LDLIBS, because those are only
> @@ -56,7 +56,8 @@ TEST_GEN_PROGS += mremap_test
>  TEST_GEN_PROGS += on-fault-limit
>  TEST_GEN_PROGS += thuge-gen
>  TEST_GEN_PROGS += transhuge-stress
> -TEST_GEN_PROGS += userfaultfd
> +TEST_GEN_PROGS += uffd-stress
> +TEST_GEN_PROGS += uffd-unit-tests
>  TEST_GEN_PROGS += soft-dirty
>  TEST_GEN_PROGS += split_huge_page_test
>  TEST_GEN_PROGS += ksm_tests
> @@ -107,7 +108,8 @@ include ../lib.mk
> 
>  $(TEST_GEN_PROGS): vm_util.c
> 
> -$(OUTPUT)/userfaultfd: uffd-common.c
> +$(OUTPUT)/uffd-stress: uffd-common.c
> +$(OUTPUT)/uffd-unit-tests: uffd-common.c
> 
>  ifeq ($(MACHINE),x86_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 9cc33984aa9f..af7bbc74cd83 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -196,14 +196,16 @@ CATEGORY="gup_test" run_test ./gup_test -a
>  # Dump pages 0, 19, and 4096, using pin_user_pages:
>  CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
> 
> +CATEGORY="userfaultfd" run_test ./uffd-unit-tests
>  uffd_mods=("" ":dev")
> +uffd_stress_bin=./uffd-stress
>  for mod in "${uffd_mods[@]}"; do
> -	CATEGORY="userfaultfd" run_test ./userfaultfd anon${mod} 20 16
> +	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon${mod} 20 16
>  	# Hugetlb tests require source and destination huge pages. Pass in half
>  	# the size ($half_ufd_size_MB), which is used for *each*.
> -	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
> -	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32
> -	CATEGORY="userfaultfd" run_test ./userfaultfd shmem${mod} 20 16
> +	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb${mod} "$half_ufd_size_MB" 32
> +	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb_shared${mod} "$half_ufd_size_MB" 32
> +	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem${mod} 20 16
>  done
> 
>  #cleanup
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/uffd-stress.c
> similarity index 100%
> rename from tools/testing/selftests/mm/userfaultfd.c
> rename to tools/testing/selftests/mm/uffd-stress.c
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
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
> +	return KSFT_PASS;
> +}
> +
> +#else /* __NR_userfaultfd */
> +
> +#warning "missing __NR_userfaultfd definition"
> +
> +int main(void)
> +{
> +	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
> +	return KSFT_SKIP;
> +}
> +
> +#endif /* __NR_userfaultfd */
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
