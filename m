Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5AB6DFB97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDLQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjDLQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CA7ED7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VoJC4PMtOZChfNpsShin+Q92n+br8Q3f1O4OPEN8PE=;
        b=LMnTkc8ogIha95Cp15TODO8WtDFGZq5myfIqOH/S7nV47vmLlIaiL4fZABS5fcY3AuG0v9
        CRODK2E2EPMoEDCaRVULMvvlMiKZAzu1e9dBWNmCvK8GwW30P1aYALNbi7VuLx38JwyD9Z
        3cgLZmxCbeA1i2BqcecNQ9e/rnXUJj8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-0yPeB1l5Nqeyve5oksbMLA-1; Wed, 12 Apr 2023 12:42:33 -0400
X-MC-Unique: 0yPeB1l5Nqeyve5oksbMLA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef4122d2dbso1350526d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317751; x=1683909751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VoJC4PMtOZChfNpsShin+Q92n+br8Q3f1O4OPEN8PE=;
        b=dMUy3gs4BYEjDhUpuPYiA1u6gBm+S3vgc9BnxI+OHzZNPNCTczYuiXgkDWxMcr91oO
         89ySgtiFh8KBpKaKbmQM/6lkrSuqq1m6TdB6A8xXFsfI9cG0xdKVYuSHkf3WK5fYQJIg
         y7jIgwu3KyR8Kkly2wJfEdW4P6EmPpp5zRIPZaoF+YNWhY0xOIQ40QoOdy98wwxqDiRZ
         hjQTV24LqxTlnbdSPcVvYtyS8XqdKbU9yrtIPZUZu1Bj+yEMWIOHbHhkuUIlTK2+WUbT
         NH6AqACVxdvg9xphmc2/8eUvLHZZqz/5qzJY+hakL1cGjSR9EXFtaW3kWJFiySedJYBK
         Zt/A==
X-Gm-Message-State: AAQBX9eW7OtmT/VWHaPO98FkPETh+nbR/aJ9MDhL6DpJyZKh7h7e7tbm
        1xuJFPM7ifVKJ6cTeiYmB15Ymu4C43E0G6nfHetvSS3gBuijWq9f9+ttBoIgNvYXlZYGTRxVhVt
        vRt7u29ZryiipGLo3/CWeAW8KreFWzEbkNTuL+yEASjzpRAnHqmttLD8emB7mibo2wKqKCBL0gy
        TMKAiqmg==
X-Received: by 2002:a05:6214:4105:b0:5de:5da:b873 with SMTP id kc5-20020a056214410500b005de05dab873mr4439636qvb.3.1681317751517;
        Wed, 12 Apr 2023 09:42:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKIhyvFE421MNKeiw66bcLbViwoq88DKthBLMNBPxf9F5dEOECVmGzHn09x9YPggLZEnerFA==
X-Received: by 2002:a05:6214:4105:b0:5de:5da:b873 with SMTP id kc5-20020a056214410500b005de05dab873mr4439540qvb.3.1681317750348;
        Wed, 12 Apr 2023 09:42:30 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id j188-20020a3787c5000000b00749fa9e12e9sm4778767qkd.124.2023.04.12.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:29 -0700 (PDT)
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
Subject: [PATCH v2 08/31] selftests/mm: Use PM_* macros in vm_utils.h
Date:   Wed, 12 Apr 2023 12:42:27 -0400
Message-Id: <20230412164227.328145-1-peterx@redhat.com>
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

We've got the macros in uffd-stress.c, move it over and use it in
vm_util.h.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c |  8 --------
 tools/testing/selftests/mm/vm_util.c     | 16 ++++------------
 tools/testing/selftests/mm/vm_util.h     |  8 ++++++++
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 4cc80a0e8955..7e841f7e2884 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1389,14 +1389,6 @@ static int userfaultfd_minor_test(void)
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
 }
 
-#define BIT_ULL(nr)                   (1ULL << (nr))
-#define PM_SOFT_DIRTY                 BIT_ULL(55)
-#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
-#define PM_UFFD_WP                    BIT_ULL(57)
-#define PM_FILE                       BIT_ULL(61)
-#define PM_SWAP                       BIT_ULL(62)
-#define PM_PRESENT                    BIT_ULL(63)
-
 static int pagemap_open(void)
 {
 	int fd = open("/proc/self/pagemap", O_RDONLY);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 7ffad87aa7e8..54d227d6f70a 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -25,25 +25,17 @@ uint64_t pagemap_get_entry(int fd, char *start)
 
 bool pagemap_is_softdirty(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	// Check if dirty bit (55th bit) is set
-	return entry & 0x0080000000000000ull;
+	return pagemap_get_entry(fd, start) & PM_SOFT_DIRTY;
 }
 
 bool pagemap_is_swapped(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	return entry & 0x4000000000000000ull;
+	return pagemap_get_entry(fd, start) & PM_SWAP;
 }
 
 bool pagemap_is_populated(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	/* Present or swapped. */
-	return entry & 0xc000000000000000ull;
+	return pagemap_get_entry(fd, start) & (PM_PRESENT | PM_SWAP);
 }
 
 unsigned long pagemap_get_pfn(int fd, char *start)
@@ -51,7 +43,7 @@ unsigned long pagemap_get_pfn(int fd, char *start)
 	uint64_t entry = pagemap_get_entry(fd, start);
 
 	/* If present (63th bit), PFN is at bit 0 -- 54. */
-	if (entry & 0x8000000000000000ull)
+	if (entry & PM_PRESENT)
 		return entry & 0x007fffffffffffffull;
 	return -1ul;
 }
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index d7163fff8fb7..d9fadddb5c69 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -6,6 +6,14 @@
 #include <string.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
+#define BIT_ULL(nr)                   (1ULL << (nr))
+#define PM_SOFT_DIRTY                 BIT_ULL(55)
+#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
+#define PM_UFFD_WP                    BIT_ULL(57)
+#define PM_FILE                       BIT_ULL(61)
+#define PM_SWAP                       BIT_ULL(62)
+#define PM_PRESENT                    BIT_ULL(63)
+
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-- 
2.39.1

