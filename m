Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176DC6B3104
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCIWis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCIWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:38:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93710820E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678401443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dh3vnUO1CryjqGh5pf4N+hTFZfi7U8elDbn6yAru0xw=;
        b=RF4a5CaVXPvFIrAI/MeH7OwCpAcBHbDXfH5p4R/Fjyu+5BTMhZ3U/YC722i/5F329hwUJb
        ER6LeuLEl96bYxn4egjcsh1c44QXgSlAATCAF0I0JeauOc9N78Qaco1Z02+3yP/UTDf0Sx
        SGJHuJJWkNQ5YLeJeqs2AaQWEClLZ2A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-KQgV8WBaOa6OnX2zXIQe5w-1; Thu, 09 Mar 2023 17:37:19 -0500
X-MC-Unique: KQgV8WBaOa6OnX2zXIQe5w-1
Received: by mail-qt1-f197.google.com with SMTP id z1-20020ac87ca1000000b003ba2a2c50f9so1886972qtv.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh3vnUO1CryjqGh5pf4N+hTFZfi7U8elDbn6yAru0xw=;
        b=63NLRVJuG7slCQwEcyvFemz0ci6QVYqF6RN6gzSyJHGlKycOcn19vcNiAmOyAPfkkt
         0oOsTfA90JFX02BSv2NMS19V0OJYpiLWzIejkDG0+xoR53fD7yP3E9xdf5DJ2g649xUW
         wdyvhUvYXoWflJgA+8omHUCT/Pg+AvX3IHzvj9VHAn+qklErHQ+xg5PVt20IXMXdnZQV
         7Xj+OhkxQQf/TFb/0y14J/ZxtFpIWqtt+7fL/ay67+yRohVNa4U50sDDdXc7W7zCxW1x
         F3qkE/xe7UYKTFF8N/zv6DCe7kfr0ounBZJQTE3+NUfE/oM1cbBfonLAG+CbC7uRWj0L
         F7DQ==
X-Gm-Message-State: AO0yUKXSaFx6cIk+fXNXX1oA4pz4IXuW8fiJzq7x010XHzckGK9Wv7Lb
        dPygVEwXWH+imKZQ0r72DIPTtY0K+tXWsWNEgPdgJw89KkqP69d/ibSbgIrgmiqmzvPOxaPwMX/
        5kiwsmKAofCR6KBOUG3KtnmzO
X-Received: by 2002:a05:622a:1a09:b0:3bf:c458:5bac with SMTP id f9-20020a05622a1a0900b003bfc4585bacmr1271807qtb.0.1678401438467;
        Thu, 09 Mar 2023 14:37:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/zs42/Izdu6QlfJ7NnX3Mn0ZoSSqNN1L96LiNcygyJm4jXsLB3B/nRmD9vB/SX58+KtB6MDA==
X-Received: by 2002:a05:622a:1a09:b0:3bf:c458:5bac with SMTP id f9-20020a05622a1a0900b003bfc4585bacmr1271786qtb.0.1678401438212;
        Thu, 09 Mar 2023 14:37:18 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c26-20020ac84e1a000000b003b8484fdfccsm172215qtw.42.2023.03.09.14.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:37:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/2] selftests/mm: Smoke test UFFD_FEATURE_WP_UNPOPULATED
Date:   Thu,  9 Mar 2023 17:37:11 -0500
Message-Id: <20230309223711.823547-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309223711.823547-1-peterx@redhat.com>
References: <20230309223711.823547-1-peterx@redhat.com>
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

