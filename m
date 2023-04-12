Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A656DFB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDLQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjDLQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAAE8698
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEk7ts1lThyIvIfCL1IGZ4lKytmWVdDqEngQ3sxu8hg=;
        b=T83QQ/zfSNPfNEk0GCUGGdwNGw5/mo+c/aO9XTUtmojndXPlrFZp8H3INe/ae4jmU6vjXh
        nRtcASNQSmGNoj/Mj87pRTXDYdnULQfv1uOpPdGQtdGlMXSotcOxPFiBTDoMfJfCDGOH7Q
        R0KUNhgrqEIww11dzVhOX41U3hi7H00=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ImXb0YNPMdOpFngiTcswMg-1; Wed, 12 Apr 2023 12:42:52 -0400
X-MC-Unique: ImXb0YNPMdOpFngiTcswMg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74acb477be6so2297185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317768; x=1683909768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEk7ts1lThyIvIfCL1IGZ4lKytmWVdDqEngQ3sxu8hg=;
        b=iFE9CCpRigso1s9gWKruYQWCNa1WoMAYzMJsBRlhCHdak0RAcBYiM4glDHv1/yDpPX
         3ii0IbqTrhxSJA1VY10AgrIb21EdUtM2qRbKnGsqzGh7aCoT4xpkbVsdwR5LadXu8ia+
         p2cTRuKyNdsYGNqVCDLB6Vv+aaYhMiaWi30BAgigIGGFcI3wRJUcOg8leQom/+uOLXJb
         dD+oHcdViZOWOFjzEx6Sy+/F0umYL4T7/Du0HjahNWs27hTxkWyMJiNYG9s6qbkSclg4
         AggdY4mRhERSEHt7tHdoM2+rV9cDryohVPmbgZ5Zhu43mLKzozQx7OMhgQu2PAnuHfz9
         li5A==
X-Gm-Message-State: AAQBX9ee3/JidaoWzpzshr30fNen5MOnM4v3Bkgc8GnlObPi80Bahx0P
        8Em74TBRQTkKf8ntlnlGsEQnDSRms5TNHq4I4STAOGFDBpqeuiZIZVTzLi/RFZ2Mabx0A868lGf
        DRsc0cB1g/ISBl+6dvTx38jh3NGLt0/cEtstxGLJhT+VTRgMYAXjC8ETP/ub+6D2HrgO8oFa4D2
        wGwlKdRA==
X-Received: by 2002:a05:6214:4002:b0:5ac:463b:a992 with SMTP id kd2-20020a056214400200b005ac463ba992mr4598530qvb.0.1681317767990;
        Wed, 12 Apr 2023 09:42:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350a0pJ+/tI/6Rg99Rlojds2/BsXxwj8wuO3kxU6T8U2AdUZsBRqUPHcEr1eIDqvTv36rahRGqw==
X-Received: by 2002:a05:6214:4002:b0:5ac:463b:a992 with SMTP id kd2-20020a056214400200b005ac463ba992mr4598491qvb.0.1681317767536;
        Wed, 12 Apr 2023 09:42:47 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm4882592qvb.104.2023.04.12.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 13/31] selftests/mm: Split uffd tests into uffd-stress and uffd-unit-tests
Date:   Wed, 12 Apr 2023 12:42:44 -0400
Message-Id: <20230412164244.328270-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many ways it's weird and unwanted to keep all the tests in the same
userfaultfd.c at least when still in the current way.

For example, it doesn't make much sense to run the stress test for each
method we can create an userfaultfd handle (either via syscall or /dev/
node).  It's a waste of time running this twice for the whole stress as the
stress paths are the same, only the open path is different.

It's also just weird to need to manually specify different types of memory
to run all unit tests for the userfaultfd interface.  We should be able to
just run a single program and that should go through all functional uffd
tests without running the stress test at all.  The stress test was more for
torturing and finding race conditions.  We don't want to wait for stress to
finish just to regress test a functional test.

When we start to pile up more things on top of the same file and same
functions, things start to go a bit chaos and the code is just harder to
maintain too with tons of global variables.

This patch creates a new test uffd-unit-tests to keep userfaultfd unit
tests in the future, currently empty.

Meanwhile rename the old userfaultfd.c test to uffd-stress.c.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/.gitignore         |  3 ++-
 tools/testing/selftests/mm/Makefile           |  8 +++---
 tools/testing/selftests/mm/run_vmtests.sh     | 10 ++++---
 .../mm/{userfaultfd.c => uffd-stress.c}       |  0
 tools/testing/selftests/mm/uffd-unit-tests.c  | 27 +++++++++++++++++++
 5 files changed, 40 insertions(+), 8 deletions(-)
 rename tools/testing/selftests/mm/{userfaultfd.c => uffd-stress.c} (100%)
 create mode 100644 tools/testing/selftests/mm/uffd-unit-tests.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 347277f2adc3..8917455f4f51 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -21,7 +21,8 @@ protection_keys
 protection_keys_32
 protection_keys_64
 madv_populate
-userfaultfd
+uffd-stress
+uffd-unit-tests
 mlock-intersect-test
 mlock-random-test
 virtual_address_range
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 36467c15ca00..5a3434419403 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -20,7 +20,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # Avoid accidental wrong builds, due to built-in rules working just a little
 # bit too well--but not quite as well as required for our situation here.
 #
-# In other words, "make userfaultfd" is supposed to fail to build at all,
+# In other words, "make $SOME_TEST" is supposed to fail to build at all,
 # because this Makefile only supports either "make" (all), or "make /full/path".
 # However,  the built-in rules, if not suppressed, will pick up CFLAGS and the
 # initial LDLIBS (but not the target-specific LDLIBS, because those are only
@@ -57,7 +57,8 @@ TEST_GEN_PROGS += mremap_test
 TEST_GEN_PROGS += on-fault-limit
 TEST_GEN_PROGS += thuge-gen
 TEST_GEN_PROGS += transhuge-stress
-TEST_GEN_PROGS += userfaultfd
+TEST_GEN_PROGS += uffd-stress
+TEST_GEN_PROGS += uffd-unit-tests
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_PROGS += ksm_tests
@@ -108,7 +109,8 @@ include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c
 
-$(OUTPUT)/userfaultfd: uffd-common.c
+$(OUTPUT)/uffd-stress: uffd-common.c
+$(OUTPUT)/uffd-unit-tests: uffd-common.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index ddf40f883747..efe22dc569f0 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -196,14 +196,16 @@ CATEGORY="gup_test" run_test ./gup_test -a
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
+CATEGORY="userfaultfd" run_test ./uffd-unit-tests
 uffd_mods=("" ":dev")
+uffd_stress_bin=./uffd-stress
 for mod in "${uffd_mods[@]}"; do
-	CATEGORY="userfaultfd" run_test ./userfaultfd anon${mod} 20 16
+	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon${mod} 20 16
 	# Hugetlb tests require source and destination huge pages. Pass in half
 	# the size ($half_ufd_size_MB), which is used for *each*.
-	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
-	CATEGORY="userfaultfd" run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32
-	CATEGORY="userfaultfd" run_test ./userfaultfd shmem${mod} 20 16
+	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb${mod} "$half_ufd_size_MB" 32
+	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb_shared${mod} "$half_ufd_size_MB" 32
+	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem${mod} 20 16
 done
 
 #cleanup
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/uffd-stress.c
similarity index 100%
rename from tools/testing/selftests/mm/userfaultfd.c
rename to tools/testing/selftests/mm/uffd-stress.c
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
new file mode 100644
index 000000000000..6857388783be
--- /dev/null
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Userfaultfd unit tests.
+ *
+ *  Copyright (C) 2015-2023  Red Hat, Inc.
+ */
+
+#include "uffd-common.h"
+
+#ifdef __NR_userfaultfd
+
+int main(int argc, char *argv[])
+{
+	return KSFT_PASS;
+}
+
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
-- 
2.39.1

