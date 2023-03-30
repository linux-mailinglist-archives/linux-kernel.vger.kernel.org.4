Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AA6D0AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjC3QKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjC3QKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18312A246
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqqRZE0+KdLihnYJHNBsrIiryhx5Vgf+EPtUaXiDnEk=;
        b=L5eHCmGN9aKZONvXwVzLZvVBku4igj97ambjCWCDyydGGlC3fz0qZsTZNid5TIO2Lde+Cu
        2RZOrJt2yw4CK3x2/hrKSCqc+0O+9O0MebXkaoCUJkmEfvXpJscqcFNZtDmKhvW06T0ywn
        BrSCV10QS41N5mvQaNK1M+33Y7CqgBM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-_kFysrE9OqSxhR7S6nOm6w-1; Thu, 30 Mar 2023 12:08:41 -0400
X-MC-Unique: _kFysrE9OqSxhR7S6nOm6w-1
Received: by mail-qk1-f197.google.com with SMTP id 72-20020a37064b000000b007467c5d3abeso9087867qkg.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqqRZE0+KdLihnYJHNBsrIiryhx5Vgf+EPtUaXiDnEk=;
        b=VPhtgGwZ9G3ieU0fgYkuJ/Jseej+yGMyrxdljORojx+jWZkT0L/S7vuhX5EvW5NqvO
         2jN/nXQ3cbHiJelfoeyS5jTl9vpwHZeeOmY4GmkNkF24uJsHsmhOi9B03VQuRZRcsLip
         I6xvmR67wNGCUaetb4J2E/2Il++wNN8wpirXAEf2lMvEpu2azCLYOV3Fcjab81gSfh+z
         Z3gh1iWQkuvGTtJHXcItcP4kynlUAUN92TCDKnVtxve17FncTxpf1yeww4ZJ2+5u+9rN
         y0/8pto2qgfa/jaPSS4ofZF0uwO45tPw7ormpJujWoQkCWQ1AsBDtP/8zG9R7KGWRSi2
         gsMQ==
X-Gm-Message-State: AAQBX9es6av/VfCQJIxJhBaK9thAqPhitkZtE9Ci77XV5ilkqTtF0+Hr
        1dg7KE76ZACMksKGqBbYC7P0mhPsURrqRX90AwiUgerHvImfVjLqBDAKOD2TtRCjyGihVcJ6OCd
        cg2pvJ166xm9sluYgg0s8+1QQv/d08DmrAc01dZj4sNrI2oRfaEzVesuvO40jVsOzNhEfYwAgl4
        lC2S8YxA==
X-Received: by 2002:a05:6214:519e:b0:5df:55b5:b1a with SMTP id kl30-20020a056214519e00b005df55b50b1amr3622833qvb.4.1680192520325;
        Thu, 30 Mar 2023 09:08:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bqP/iX2AlNio2XqzWARNgLqKc/rTJrU3oBSu0UdCvPePSSbjDMbIS03DCF8/QdFFI9R5EhrQ==
X-Received: by 2002:a05:6214:519e:b0:5df:55b5:b1a with SMTP id kl30-20020a056214519e00b005df55b50b1amr3622788qvb.4.1680192519977;
        Thu, 30 Mar 2023 09:08:39 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mn15-20020a0562145ecf00b005dd8b93458dsm5543495qvb.37.2023.03.30.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 28/29] selftests/mm: Drop sys/dev test in uffd-stress test
Date:   Thu, 30 Mar 2023 12:08:37 -0400
Message-Id: <20230330160837.3107624-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
index af7bbc74cd83..845ce8a48204 100644
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
index 964fa57b710a..f14bf0941077 100644
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
@@ -229,10 +229,7 @@ int userfaultfd_open(uint64_t *features)
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
index 07d00e9809dc..f2e2fbb37cda 100644
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
index 8f41bef2fbda..7461021dd4af 100644
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
@@ -401,21 +390,9 @@ static void set_test_type(const char *type)
 
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

