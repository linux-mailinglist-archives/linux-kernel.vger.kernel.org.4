Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D06DFB98
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDLQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDLQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A37DA5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqDS6jtSapL9ifdeK9em1EDp4bv+6WCKRXbZ+q/xf6g=;
        b=aydLCzjAdysOzWn6y1NskRVL5rn64+JYgfuQ+m4pc16bdwtUgi97rITUFC1YjSFMWkfjcD
        c2FPY22tu+3ew5+OZbw6APQnw3bYEL2lwlADWuTAyIxW6EDV0XAf1yL4DZxS4my5/Gz3+J
        Dmn/MgSnfo/2yxCiJBjfGO+74xIJpQg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-oE5bAW95O8KLdUysWhjZTQ-1; Wed, 12 Apr 2023 12:42:36 -0400
X-MC-Unique: oE5bAW95O8KLdUysWhjZTQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74acb477be6so2293085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317755; x=1683909755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqDS6jtSapL9ifdeK9em1EDp4bv+6WCKRXbZ+q/xf6g=;
        b=M7JNEcYTmoVdZiIsZVK7nZN8Qtk0F8ngpjhLy/msI6oorkKelAZpAudYLHjUyvnahJ
         ADmQghUUx+w/B9/bft19gEQJuf2Kc7o2D5Jxj3KO/0ai4nihphvD/bwAYxJ21oyD+wjz
         5Zmw3tA0Cx21M3mbYvYN1b59cjjxtUR4CIYRfm4fsGJboxoCtsVwjsrWhvVDtlbwEL9m
         nHh3Qx27IQ7GkXW+0ydy8lkKnD7xhRn8SIpL8tt5jByK4Hx7bcKRD+JY6FPz/TeRR7kD
         IU397wTcwW7atW9DYkKDz/blHqeig44ojIsrZOSah1LAzdL1A+k7fXw9uia6MflNFAtu
         if2Q==
X-Gm-Message-State: AAQBX9eVA6Vv+E2wJePT2fg9MW/MzJh+E24lwSEh2LpOplMaBlnobZfl
        ay1qCU23Z0p5yAV4FhH90c+fk4tm7ahfLdYbL3UYrYcbn8XkJlBr5hx9nbkIxBMKxp7014PBn0a
        IaTwmyaJcXgppQQYWv6tU6YNGNQGZ9SQtv2md0/gpzpdXMlaTxgpdXpVhMAWyewfGHSM2ufAeit
        Njtd4Xtg==
X-Received: by 2002:a05:6214:4002:b0:5ac:463b:a992 with SMTP id kd2-20020a056214400200b005ac463ba992mr4597605qvb.0.1681317755030;
        Wed, 12 Apr 2023 09:42:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZccWUkGHYWZ2bzm1zWaJsqlvJFElNocxXwtSRv3N+papWfiGQIPvLDwhR7/K1RnRC+7EOELw==
X-Received: by 2002:a05:6214:4002:b0:5ac:463b:a992 with SMTP id kd2-20020a056214400200b005ac463ba992mr4597570qvb.0.1681317754674;
        Wed, 12 Apr 2023 09:42:34 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a218e00b0074a25a59667sm4749109qka.115.2023.04.12.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:33 -0700 (PDT)
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
Subject: [PATCH v2 09/31] selftests/mm: Reuse pagemap_get_entry() in vm_util.h
Date:   Wed, 12 Apr 2023 12:42:31 -0400
Message-Id: <20230412164231.328157-1-peterx@redhat.com>
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

Meanwhile drop pagemap_read_vaddr().

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c | 31 +++++++-----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7e841f7e2884..795fbc4d84f8 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1399,19 +1399,6 @@ static int pagemap_open(void)
 	return fd;
 }
 
-static uint64_t pagemap_read_vaddr(int fd, void *vaddr)
-{
-	uint64_t value;
-	int ret;
-
-	ret = pread(fd, &value, sizeof(uint64_t),
-		    ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
-	if (ret != sizeof(uint64_t))
-		err("pread() on pagemap failed");
-
-	return value;
-}
-
 /* This macro let __LINE__ works in err() */
 #define  pagemap_check_wp(value, wp) do {				\
 		if (!!(value & PM_UFFD_WP) != wp)			\
@@ -1427,7 +1414,7 @@ static int pagemap_test_fork(bool present)
 	if (!child) {
 		/* Open the pagemap fd of the child itself */
 		fd = pagemap_open();
-		value = pagemap_read_vaddr(fd, area_dst);
+		value = pagemap_get_entry(fd, area_dst);
 		/*
 		 * After fork() uffd-wp bit should be gone as long as we're
 		 * without UFFD_FEATURE_EVENT_FORK
@@ -1446,24 +1433,24 @@ static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
 
 	/* Test applying pte marker to anon unpopulated */
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 
 	/* Test unprotect on anon pte marker */
 	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test zap on anon marker */
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
 	if (madvise(area_dst, page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test fault in after marker removed */
 	*area_dst = 1;
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 	/* Drop it to make pte none again */
 	if (madvise(area_dst, page_size, MADV_DONTNEED))
@@ -1522,7 +1509,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Touch the page */
 	*area_dst = 1;
 	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 	/* Make sure uffd-wp bit dropped when fork */
 	if (pagemap_test_fork(true))
@@ -1536,7 +1523,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 		err("madvise(MADV_PAGEOUT) failed");
 
 	/* Uffd-wp should persist even swapped out */
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 	/* Make sure uffd-wp bit dropped when fork */
 	if (pagemap_test_fork(false))
@@ -1544,12 +1531,12 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 
 	/* Unprotect; this tests swap pte modifications */
 	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Fault in the page from disk */
 	*area_dst = 2;
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	close(pagemap_fd);
-- 
2.39.1

