Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD76DFB96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDLQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDLQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7A7D86
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9w4FTeM4b1xfAgG4y96DPCrYEWea1Mc83v+smBNR1Gs=;
        b=X2ed2FD99jiNWvs0VoEgrMr8NFsHxsbfUYEgHcebia94OWpovljBSDdck4d/W2PJQarvBa
        GXJQRXMDnfpkjJnzeNbP+lHXPXlhgwTikC5en5eb/AETXSQu8Q0RaNFIVi4kEBmTlepUpB
        JIkOVvc8FaobEJ173dRGgt5ACk1Dzeg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-zzNHV1rjMxyKINPfiEgw2Q-1; Wed, 12 Apr 2023 12:42:28 -0400
X-MC-Unique: zzNHV1rjMxyKINPfiEgw2Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74a25fcda05so77596285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317747; x=1683909747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w4FTeM4b1xfAgG4y96DPCrYEWea1Mc83v+smBNR1Gs=;
        b=bqaC5+jCyPvCOAd8FnsDXxbVFyJTSR1uhWL2tsbup6MnPNXWWcPadIg8NAEXWSuHix
         gRTqJyfVwYdVhqQimzBYVUohh6FOUVd3uPBdXOGjO6udQbx+l8rT0jbLv9PENSyjZzi5
         zssPEOTl3cwqNNDssQsMEvS1kEF+cPV7uMKIEetFaWeMHYiQRe6VrhUJQjhmlEBpjOYW
         FTX1NkOCLGdGoY+fwfioBy8XRlUbgg0uEZNFOYWbiE7ZQneftvwpjOBuAQtNimB2qe/o
         WAKsqPaxsIdszM6p8HzBSaDHX5C6hZyV+je3TDbRhVWnpdxgtzX9FvbVkHU9/qybm56T
         qzlA==
X-Gm-Message-State: AAQBX9eq5K6LkEHw2GdSP+TxhMCUezvH9gwxsEJmiwLN6rN58w+Jq+9x
        OnKKV4z7vhtvqGl1f/GqLx0TfD023fQkHNxtBw8fEut4F05pavSjPe+KiF6S6AUOKEOlgLUvAta
        K1ymFwAgIgqCrkUpr5LOVogFhlEHtkeWrfe+29wZ/C2trtbg046hM9h8i0ILKZ1ZduTFd2xQaTp
        XKMe/LkA==
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr5012782qta.0.1681317747187;
        Wed, 12 Apr 2023 09:42:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350YVvSHn+CiNqMbEanS4Hm6vnJ4+dDPCuFu7aqhBaI35sD13aR8Lht4vPI828Te9foEW+WzjQg==
X-Received: by 2002:ac8:5cc8:0:b0:3e6:707e:d3b1 with SMTP id s8-20020ac85cc8000000b003e6707ed3b1mr5012723qta.0.1681317746702;
        Wed, 12 Apr 2023 09:42:26 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b003e3c23dd2cfsm4353889qtn.84.2023.04.12.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:25 -0700 (PDT)
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
Subject: [PATCH v2 07/31] selftests/mm: Merge default_huge_page_size() into one
Date:   Wed, 12 Apr 2023 12:42:23 -0400
Message-Id: <20230412164223.328134-1-peterx@redhat.com>
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

There're already 3 same definitions of the three functions.  Move it into
vm_util.[ch].

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 25 +-------------------
 tools/testing/selftests/mm/thuge-gen.c       | 19 +--------------
 tools/testing/selftests/mm/userfaultfd.c     | 24 -------------------
 tools/testing/selftests/mm/vm_util.c         | 21 ++++++++++++++++
 tools/testing/selftests/mm/vm_util.h         |  1 +
 5 files changed, 24 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index 9a127a8fe176..28426e30d9bc 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define MIN_FREE_PAGES	20
 #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
@@ -35,30 +36,6 @@
 unsigned long huge_page_size;
 unsigned long base_page_size;
 
-/*
- * default_huge_page_size copied from mlock2-tests.c
- */
-unsigned long default_huge_page_size(void)
-{
-	unsigned long hps = 0;
-	char *line = NULL;
-	size_t linelen = 0;
-	FILE *f = fopen("/proc/meminfo", "r");
-
-	if (!f)
-		return 0;
-	while (getline(&line, &linelen, f) > 0) {
-		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
-			hps <<= 10;
-			break;
-		}
-	}
-
-	free(line);
-	fclose(f);
-	return hps;
-}
-
 unsigned long get_free_hugepages(void)
 {
 	unsigned long fhp = 0;
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 361ef7192cc6..380ab5f0a534 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -24,6 +24,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <string.h>
+#include "vm_util.h"
 
 #define err(x) perror(x), exit(1)
 
@@ -74,24 +75,6 @@ void find_pagesizes(void)
 	globfree(&g);
 }
 
-unsigned long default_huge_page_size(void)
-{
-	unsigned long hps = 0;
-	char *line = NULL;
-	size_t linelen = 0;
-	FILE *f = fopen("/proc/meminfo", "r");
-	if (!f)
-		return 0;
-	while (getline(&line, &linelen, f) > 0) {
-		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
-			hps <<= 10;
-			break;
-		}
-	}
-	free(line);
-	return hps;
-}
-
 void show(unsigned long ps)
 {
 	char buf[100];
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index a96d126cb40e..4cc80a0e8955 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1703,30 +1703,6 @@ static int userfaultfd_stress(void)
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
 
-/*
- * Copied from mlock2-tests.c
- */
-unsigned long default_huge_page_size(void)
-{
-	unsigned long hps = 0;
-	char *line = NULL;
-	size_t linelen = 0;
-	FILE *f = fopen("/proc/meminfo", "r");
-
-	if (!f)
-		return 0;
-	while (getline(&line, &linelen, f) > 0) {
-		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
-			hps <<= 10;
-			break;
-		}
-	}
-
-	free(line);
-	fclose(f);
-	return hps;
-}
-
 static void set_test_type(const char *type)
 {
 	if (!strcmp(type, "anon")) {
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 85411ee7ff8b..7ffad87aa7e8 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -180,3 +180,24 @@ int64_t allocate_transhuge(void *ptr, int pagemap_fd)
 
 	return -1;
 }
+
+unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 6edeb531afc6..d7163fff8fb7 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -35,6 +35,7 @@ bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
+unsigned long default_huge_page_size(void);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1

