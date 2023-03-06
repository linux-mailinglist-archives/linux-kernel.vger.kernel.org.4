Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56636AD0B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCFVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCFVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EF13C794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678138776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh3vnUO1CryjqGh5pf4N+hTFZfi7U8elDbn6yAru0xw=;
        b=X0rNS+U5cCVjbUEJml4v9vm+YduIhUw8A5qkaqF50XAra1Sq5PWlF4LOv8oa0l1GYaaseZ
        qNP+JgPyDJDrEvpezrVPhbGJ88QfSMXIudbOoO3iRHYVczzZMPc/vGV43ZCJH8VbgTSSpU
        X3/jSKhPa/vXi+S1/+/g47XV0jnrsIU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-C2FesjSFOe-49FQWU5amjw-1; Mon, 06 Mar 2023 16:39:35 -0500
X-MC-Unique: C2FesjSFOe-49FQWU5amjw-1
Received: by mail-qk1-f198.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so6200618qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678138773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh3vnUO1CryjqGh5pf4N+hTFZfi7U8elDbn6yAru0xw=;
        b=r2gzAFYKTP7ndkNdyF+12Kv6drcuCTGsElxPl/YmrwdXA6LYxAwanWTrWImKSWTT90
         uNbAXU9WkmW9kBv+LkRkdKgts65icC+n+eQjsQ0vhX9C4mdVrnZxLNx6nrFSKco2FWjS
         01rxzYS3FUUlWQqUxT0Frj8/rOBUAYXOhzvMbQoarrCPyGRVk7fZ5+pi5SHFwoxppIb+
         /Z7bDzaTb1sqQr5tSSEaLd/giMfed9jU9GJQBGMiHf+HeJQHJPB24nPNrXorMqs77lez
         B+95phtKpJXxd3gykyTu33K05vVJz31qzpidKcF1PPRC5tx5dZx7e3ODhy2IE8j7YLYg
         pijg==
X-Gm-Message-State: AO0yUKWlCPa2diUNRJfUCmpoA0fTYF7JpsCEr2PK2Nnolo2twkhvAL+j
        FnTXvWTkheXhZbNg6ThhryKBsyPSzZFwVVUGJN2/T6afWdCh4NRmVI1J9efsRNbr5n621KEVNKM
        dofwNSBjdQLjAfy4Dov3yUe1jHK0ilNmK
X-Received: by 2002:ac8:5e0a:0:b0:3b8:36f8:830e with SMTP id h10-20020ac85e0a000000b003b836f8830emr17691674qtx.6.1678138773299;
        Mon, 06 Mar 2023 13:39:33 -0800 (PST)
X-Google-Smtp-Source: AK7set9ol7LMQNBhaMyIBRZulf0Y2fuCeROIjvtU2gPZUJ2lDeqPLHVXUOpB/4I1eDjWa/ErESxpNw==
X-Received: by 2002:ac8:5e0a:0:b0:3b8:36f8:830e with SMTP id h10-20020ac85e0a000000b003b836f8830emr17691649qtx.6.1678138773087;
        Mon, 06 Mar 2023 13:39:33 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e20-20020a05622a111400b003bfa66b7484sm8522884qty.35.2023.03.06.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 13:39:30 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 2/2] selftests/mm: Smoke test WP_UNPOPULATED
Date:   Mon,  6 Mar 2023 16:39:25 -0500
Message-Id: <20230306213925.617814-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306213925.617814-1-peterx@redhat.com>
References: <20230306213925.617814-1-peterx@redhat.com>
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

Enable it by default on the stress test, and add some smoke tests for the
pte markers on anonymous.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c | 45 ++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7f22844ed704..e030d63c031a 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1444,6 +1444,43 @@ static int pagemap_test_fork(bool present)
 	return result;
 }
 
+static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
+{
+	uint64_t value;
+
+	/* Test applying pte marker to anon unpopulated */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+
+	/* Test unprotect on anon pte marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, false);
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Test zap on anon marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Test fault in after marker removed */
+	*area_dst = 1;
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+	/* Drop it to make pte none again */
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+
+	/* Test read-zero-page upon pte marker */
+	wp_range(uffd, (uint64_t)area_dst, page_size, true);
+	*(volatile char *)area_dst;
+	/* Drop it to make pte none again */
+	if (madvise(area_dst, page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
+}
+
 static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 {
 	struct uffdio_register uffdio_register;
@@ -1462,7 +1499,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1482,6 +1519,10 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 
 	pagemap_fd = pagemap_open();
 
+	/* Smoke test WP_UNPOPULATED first when it's still empty */
+	if (test_pgsize == page_size)
+		userfaultfd_wp_unpopulated_test(pagemap_fd);
+
 	/* Touch the page */
 	*area_dst = 1;
 	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
@@ -1526,7 +1567,7 @@ static int userfaultfd_stress(void)
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
 
 	if (posix_memalign(&area, page_size, page_size))
 		err("out of memory");
-- 
2.39.1

