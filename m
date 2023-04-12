Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B616DFBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDLQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDLQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5993D2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P1/ScyFhtwT2WBZ2avhVrVKXGlimCZn+6QVBkOI+hY=;
        b=ay3/1p/9r0bq0UTWuJVstf/Evrf9pVq8Bj+XoYNuqHkYuupOr+U51D0JiRG2y71H+o8UZC
        nTXNLvsCgXtdINSGFoyMEWIRtR8lj2Jg6VpamV0OFCk/e+jiiRtKv5QhyZO5220pg69vbo
        Appg0E4w6pu5vqFnWOutw7j0wWpZzC0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-OsNpgVeJNIuvAzY8f6vjIA-1; Wed, 12 Apr 2023 12:45:39 -0400
X-MC-Unique: OsNpgVeJNIuvAzY8f6vjIA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e947d81d7dso272561cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317934; x=1683909934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4P1/ScyFhtwT2WBZ2avhVrVKXGlimCZn+6QVBkOI+hY=;
        b=fWUIcaAVjNaF0foTMz0qEx6Jbds4QyyXd3Z91tFxBuTev3teeL7Ohh3/vjIsPH/8JT
         wy4J+oknnLSCX+XYmAFtcuxv1UutV4edQhJ6Kc2t+9lVcPXVkp1Rt0eAoq0q7eC3o0yN
         +7wHjJClTmcK/xUbBP8q5kBAvu5kIEOF2NoreKVmq6GqenxOgFfKfpU88x3NY0C1/MDs
         xElxx4Q+awxTV0b+JGGtcnvzX6j0GNZoqPXsgncSxUoVdqDbaocp3fphHdoSX32+SIxq
         VmSeFDFYSfosz+UE8wTDDeGQ2nR3DUMoiuFApzlim2vxG0VWN4dyH9exh9mwucl+yNhK
         3QJA==
X-Gm-Message-State: AAQBX9cBm5bUjcmx3SUhu2N6TrDJuNiI1ARtqwEnBgO2GIawNIxGRfz2
        YFFrD9q82FGyBOHxNvK/gfsqq+GyTSOQWX5FZe5uojZ9mn68FCdj04ugHww3kkSxQnM7upAQnIB
        Uy8WaDahzISfCJJskqNIfkHnF
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr4735734qvb.2.1681317933758;
        Wed, 12 Apr 2023 09:45:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350YFr4iYYFdfQl6EUz00VO2xExXsFFSl3Ic24dd5qBrL9XsgdoJ8YxnsY9ruU2bfo6aBT4rElA==
X-Received: by 2002:a05:6214:401a:b0:5aa:14b8:e935 with SMTP id kd26-20020a056214401a00b005aa14b8e935mr4735714qvb.2.1681317933520;
        Wed, 12 Apr 2023 09:45:33 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056214186300b005dd8b934594sm1817671qvb.44.2023.04.12.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:45:30 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 29/31] selftests/mm: Drop sys/dev test in uffd-stress test
Date:   Wed, 12 Apr 2023 12:45:25 -0400
Message-Id: <20230412164525.329176-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new uffd unit test covering the /dev/userfaultfd path and syscall
path of uffd initializations, we can safely drop the devnode test in the
old stress test.

One thing is to avoid duplication of running the stress test twice which is
an overkill to only test the /dev/ interface in run_vmtests.sh.

The other benefit is now all uffd tests (that uses userfaultfd_open) can
run automatically as long as any type of interface is enabled (either
syscall or dev), so it's more likely to succeed rather than fail due to
unprivilege.

With this patch lands, we can drop all the "mem_type:XXX" handlings too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 15 +++++--------
 tools/testing/selftests/mm/uffd-common.c  |  7 ++----
 tools/testing/selftests/mm/uffd-common.h  |  2 +-
 tools/testing/selftests/mm/uffd-stress.c  | 27 ++---------------------
 4 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index efe22dc569f0..ecc16ea6fc40 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -197,16 +197,13 @@ CATEGORY="gup_test" run_test ./gup_test -a
 CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 CATEGORY="userfaultfd" run_test ./uffd-unit-tests
-uffd_mods=("" ":dev")
 uffd_stress_bin=./uffd-stress
-for mod in "${uffd_mods[@]}"; do
-	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon${mod} 20 16
-	# Hugetlb tests require source and destination huge pages. Pass in half
-	# the size ($half_ufd_size_MB), which is used for *each*.
-	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb${mod} "$half_ufd_size_MB" 32
-	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb_shared${mod} "$half_ufd_size_MB" 32
-	CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem${mod} 20 16
-done
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
+# Hugetlb tests require source and destination huge pages. Pass in half
+# the size ($half_ufd_size_MB), which is used for *each*.
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb_shared "$half_ufd_size_MB" 32
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
 
 #cleanup
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 3e98e129f8bd..61c6250adf93 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -13,7 +13,7 @@ volatile bool test_uffdio_copy_eexist = true;
 unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 int uffd = -1, uffd_flags, finished, *pipefd, test_type;
-bool map_shared, test_dev_userfaultfd;
+bool map_shared;
 bool test_uffdio_wp = true;
 unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
@@ -236,10 +236,7 @@ int userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	if (test_dev_userfaultfd)
-		uffd = uffd_open_dev(UFFD_FLAGS);
-	else
-		uffd = uffd_open_sys(UFFD_FLAGS);
+	uffd = uffd_open(UFFD_FLAGS);
 	if (uffd < 0)
 		return -1;
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 32e590ce9442..6068f2346b86 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -90,7 +90,7 @@ typedef struct uffd_test_ops uffd_test_ops_t;
 extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 extern int uffd, uffd_flags, finished, *pipefd, test_type;
-extern bool map_shared, test_dev_userfaultfd;
+extern bool map_shared;
 extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index c0e804f05002..4e071a7d0ff5 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -55,8 +55,6 @@ pthread_attr_t attr;
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
-    "# Run the same anonymous memory test, but using /dev/userfaultfd:\n"
-    "./userfaultfd anon:dev 100 99999\n\n"
     "# Run share memory test on 1GiB region with 99 bounces:\n"
     "./userfaultfd shmem 1000 99\n\n"
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
@@ -69,18 +67,9 @@ const char *examples =
 
 static void usage(void)
 {
-	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
-		"[hugetlbfs_file]\n\n");
+	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces>\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
-	fprintf(stderr, "'Test mods' can be joined to the test type string with a ':'. "
-		"Supported mods:\n");
-	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
-	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
-	fprintf(stderr, "\nExample test mod usage:\n");
-	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
-	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
-
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
@@ -400,21 +389,9 @@ static void set_test_type(const char *type)
 
 static void parse_test_type_arg(const char *raw_type)
 {
-	char *buf = strdup(raw_type);
 	uint64_t features = UFFD_API_FEATURES;
 
-	while (buf) {
-		const char *token = strsep(&buf, ":");
-
-		if (!test_type)
-			set_test_type(token);
-		else if (!strcmp(token, "dev"))
-			test_dev_userfaultfd = true;
-		else if (!strcmp(token, "syscall"))
-			test_dev_userfaultfd = false;
-		else
-			err("unrecognized test mod '%s'", token);
-	}
+	set_test_type(raw_type);
 
 	if (!test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
-- 
2.39.1

