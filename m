Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5D6D0AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjC3QKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjC3QK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5EE1A6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QgmTtu8OFjFdW8yq7WIzzTW/am1uahC9wawM1FIOBXg=;
        b=GIFEKQlcSWWlvVLW8R33Now6EfDwxHz5cXJjAPIfbHWso2WAMeLqjZwglCNAtNjZCqb+2H
        /0TDD2obUQNYSRnNTbF3IhYfXUd1jimRmTZcLPa8GKj76o0W4ZTbC/Zk1oyp+ze40Jsqcn
        Ua+P7gp+eDr9l4bgw0Gepg0UnetlPlo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-BQVzeRJbMEmlF5CTlsQfVg-1; Thu, 30 Mar 2023 12:08:44 -0400
X-MC-Unique: BQVzeRJbMEmlF5CTlsQfVg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-57c67ea348eso12978976d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgmTtu8OFjFdW8yq7WIzzTW/am1uahC9wawM1FIOBXg=;
        b=vLDUezW82rH7Gt7t7LO1/lTkFZClQEueXl//OIkgFm9ZEjKzf0DD4yyVtXvwMxVY5T
         wOnA913mTJ7JpNnIIMM8pw1qqeEV78CDCRmxa9IxVLWziaWnTK68p40ZSEz3NG/ExhTY
         qFYvbDwFaXHMBB4X66Bq1wyPANot/gJngZmv8U3r3BuAeqviB9C4gawik4sFpRr2AKWP
         /Ht2kOxTsBn59PdDtVG9AHWKWqpkJcCwfPG98MYwUoNa3GvUp4+0l64pYi1EZz+4kvdZ
         tpmBetTjx1dK60K60jaWNRXSfT5GrSY9cbvbhU6P/gxHcq8xLUE/BFkjRYu2/y0Sg0Db
         lkrw==
X-Gm-Message-State: AAQBX9ctCKC03v0b06xLgOLzPGCYL4xB0rpAKcGujb38mze+xWZpYQjK
        26qRhsdPpRytagzDii/eu2EvwKtcwUe1UwPx856SYbfEjF8rciSTTQ+gvlzJjVjx3ewTHTLM/YQ
        gsMBycE3AR9vMXfkqrL08+ejW+jBBo1qKIYnjqNlT5bpNfGeDOkrkJfYaKJeEyl2y1d0Kb8P53q
        GFZj2rxQ==
X-Received: by 2002:a05:6214:3014:b0:5aa:14b8:e935 with SMTP id ke20-20020a056214301400b005aa14b8e935mr3724010qvb.2.1680192522488;
        Thu, 30 Mar 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YMKgyQGsiWXfxMgANl5DSoc8CnFLkGelQ0rF4PH3xD4dOO2E/F49CFek+tRBt85PQwpxWhkw==
X-Received: by 2002:a05:6214:3014:b0:5aa:14b8:e935 with SMTP id ke20-20020a056214301400b005aa14b8e935mr3723957qvb.2.1680192522120;
        Thu, 30 Mar 2023 09:08:42 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id k2-20020a0cc782000000b005e1235e6f2esm227430qvj.12.2023.03.30.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:41 -0700 (PDT)
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
Subject: [PATCH 29/29] selftests/mm: Add shmem-private test to uffd-stress
Date:   Thu, 30 Mar 2023 12:08:40 -0400
Message-Id: <20230330160840.3107635-1-peterx@redhat.com>
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

The userfaultfd stress test never tested private shmem, which I think was
overlooked long due.  Add it so it matches with uffd unit test and it'll
cover all memory supported with the three memory types.

Meanwhile, rename the memory types a bit.  Considering shared mem is the
major use case for both shmem / hugetlbfs, changing from:

  anon, hugetlb, hugetlb_shared, shmem

To (with shmem-private added):

  anon, hugetlb, hugetlb-private, shmem, shmem-private

Add the shmem-private to run_vmtests.sh too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh |  3 ++-
 tools/testing/selftests/mm/uffd-stress.c  | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 845ce8a48204..b8ab75bc731c 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -202,8 +202,9 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half
 # the size ($half_ufd_size_MB), which is used for *each*.
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
-CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb_shared "$half_ufd_size_MB" 32
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
+CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem-private 20 16
 
 #cleanup
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 7461021dd4af..6172ebfe732e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -59,8 +59,8 @@ const char *examples =
     "./userfaultfd shmem 1000 99\n\n"
     "# Run hugetlb memory test on 256MiB region with 50 bounces:\n"
     "./userfaultfd hugetlb 256 50\n\n"
-    "# Run the same hugetlb test but using shared file:\n"
-    "./userfaultfd hugetlb_shared 256 50\n\n"
+    "# Run the same hugetlb test but using private file:\n"
+    "./userfaultfd hugetlb-private 256 50\n\n"
     "# 10MiB-~6GiB 999 bounces anonymous test, "
     "continue forever unless an error triggers\n"
     "while ./userfaultfd anon $[RANDOM % 6000 + 10] 999; do true; done\n\n";
@@ -69,7 +69,7 @@ static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces>\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
-		"hugetlb_shared, shmem\n\n");
+		"hugetlb-private, shmem, shmem-private\n\n");
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
@@ -377,14 +377,17 @@ static void set_test_type(const char *type)
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-	} else if (!strcmp(type, "hugetlb_shared")) {
 		map_shared = true;
+	} else if (!strcmp(type, "hugetlb-private")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
+	} else if (!strcmp(type, "shmem-private")) {
+		test_type = TEST_SHMEM;
+		uffd_test_ops = &shmem_uffd_test_ops;
 	}
 }
 
-- 
2.39.1

