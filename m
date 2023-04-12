Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3216DFC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDLRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjDLRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082E7AB8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681318821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2yWZt1s7MuVGMeOCGLd+TTj5TTX+8gBX0BUmTSUDX0=;
        b=PsqDH26iyJedwjXgjcIGrP+E2Zo0Q8bfh0RSd+9hCwDZ4uXsCTWNsweo9v+1b1KLuiyTWB
        mw2kiwg32kiJUMrmSdl/mD2Y/CK7XXvw0yffLdceK0Y6b9ULBseOgFsL103xgTc16HpLdU
        87GkwFii+4M9s+PO9xK4NU/f6CB4rus=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-DATm5dPtM3yAsNKUOMiMWA-1; Wed, 12 Apr 2023 12:45:48 -0400
X-MC-Unique: DATm5dPtM3yAsNKUOMiMWA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e947d81d7dso272951cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317948; x=1683909948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2yWZt1s7MuVGMeOCGLd+TTj5TTX+8gBX0BUmTSUDX0=;
        b=F17kCG9aUAnbNVNuiuQ1vWv6cNAqmTaUXS9RuzG84ZeExUbnPYtEtR/CnuPSBkDigC
         J/Gyrsbw6ufx6ofrG4CLLi7v2wbQcl7Xk1GRGFj+xGHnAkTCaVCw4ezh9UE7AB/xRz9W
         dkxHs6FA4K5mpbmm1Xd4k6IwPozhX70g0hiM0lBfwSF2gpHi4ExD753yfhYjhEsnYhWI
         z7sp+hac/OKqO9aBJPQg5SN670N+ilPSEE72NoRwriFvUov9aOC43Jz1RpgkO0oTB+ve
         oF+ceS78iOx4l+C+/b6dNwqA2zXY7V2Z737IGAezI7G/iHQm3LKZ5l1YzXz6oCFU10ob
         SwqQ==
X-Gm-Message-State: AAQBX9e2ILQWWpGeFrpcN3DKCq9zAyn/sYpLRJxKpy31lRW8Gum7HLEB
        PvqU++L8oY/vpbKNCEtJd1na6ZJQlJqAKb9qan6v+HNNyRxg5rxca9lGco3aCWMcfSLXqjInKhM
        nyBfd+Aoo/JV5U6rn6g2x27n2
X-Received: by 2002:a05:622a:19a1:b0:3e3:98cf:68ae with SMTP id u33-20020a05622a19a100b003e398cf68aemr5389663qtc.2.1681317948340;
        Wed, 12 Apr 2023 09:45:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZiKY7ANBKy64ZZqrbCk8PQr9/JPPi7k1BmBEe0htozZ6mrlT6vo8j3lhtJ4S3TO2Z85boE2w==
X-Received: by 2002:a05:622a:19a1:b0:3e3:98cf:68ae with SMTP id u33-20020a05622a19a100b003e398cf68aemr5389622qtc.2.1681317947950;
        Wed, 12 Apr 2023 09:45:47 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a141700b00746803d7e8dsm4761888qkj.113.2023.04.12.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:45:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 30/31] selftests/mm: Add shmem-private test to uffd-stress
Date:   Wed, 12 Apr 2023 12:45:46 -0400
Message-Id: <20230412164546.329355-1-peterx@redhat.com>
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
index ecc16ea6fc40..438eb49567b6 100644
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
index 4e071a7d0ff5..f1ad9eef1c3a 100644
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
@@ -376,14 +376,17 @@ static void set_test_type(const char *type)
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

