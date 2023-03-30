Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3C6D0AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjC3QIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjC3QH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029A976D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OY41FoDSXIz8Px4DR5ueHfK5qhzGwiU30swTtCORuo=;
        b=JWF+84EoztgdDi3RKVDFDH07xLDm22qVs45rU+27AE/nxkBTl1YyO5olOWA4ltLNP714oP
        WodL5/ANw9xufidGOlUrC8BWu5LZKOFgoZ5B2uQBv/ura3xZujwqZBInNCFjrNCeH+z0bc
        b9yTVot+bbNGtgUGD+dVYPytRK1Hi3k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-2XSnw-gONMy2Ie_jsV56Ug-1; Thu, 30 Mar 2023 12:07:09 -0400
X-MC-Unique: 2XSnw-gONMy2Ie_jsV56Ug-1
Received: by mail-qt1-f197.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so12759855qta.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OY41FoDSXIz8Px4DR5ueHfK5qhzGwiU30swTtCORuo=;
        b=C8BbQNJTj4HIORWuCU7vfzQvC5yEwfvuoxt1/cmYamYnJHKap+hhJtM6I33Z0A62jp
         Bp8lyjEiMKZ41k7v3nzidlsbEl3G4wUih+dYwapMQgx4F6BzgNgM6J2YI/Puc+rfrmMS
         ///Kv1yx8v49efX6c37PK73Z60yrXgvpEB4SBJ19YsOLfZ1z9P/XjK2d+LDm/lcjzvje
         /5EiFavyQdjrjALVNxw6dQZ0VwWs7ZDV+hYaIvGkCr4zX1quflZWeU4xZX6N+9ZZXJyJ
         FYQFR0XB5rxqslP9tj9DMyIZEeQDoxUcDnVUD0msGMsbcNYJOGPIgi4z/P/LPPjviHfA
         tyvA==
X-Gm-Message-State: AAQBX9el9nOf269JYve7EOGmgyQPKHo6MTWd+BMUKB3874i00J3tqoZq
        CFDXoZsYJO2KPI5JFeKY6K9hhPIsIh6kozOUScDAMipYj1jjjlnSe9ZCbu8lkVceFn8Ci732l+w
        jwyiLsg7LAaFKPybIQsWj3keA
X-Received: by 2002:a05:6214:5090:b0:532:141d:3750 with SMTP id kk16-20020a056214509000b00532141d3750mr3688740qvb.2.1680192428266;
        Thu, 30 Mar 2023 09:07:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ys6fX7rmt9YD/vVT9J8araJkwcE6MiBOgwawHwu2UT8IpOsYcMasH6fyTBBFlM3DCctSA8FA==
X-Received: by 2002:a05:6214:5090:b0:532:141d:3750 with SMTP id kk16-20020a056214509000b00532141d3750mr3688715qvb.2.1680192428056;
        Thu, 30 Mar 2023 09:07:08 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r6-20020a0cf806000000b005dd8b93457asm5582136qvn.18.2023.03.30.09.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 07/29] selftests/mm: Merge default_huge_page_size() into one
Date:   Thu, 30 Mar 2023 12:07:05 -0400
Message-Id: <20230330160705.3106966-1-peterx@redhat.com>
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

There're already 3 same definitions of the three functions.  Move it into
vm_util.[ch].

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
index 0204c469be43..12dc654b5be3 100644
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

