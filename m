Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3FA6DFBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDLQsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDLQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B66A65A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwrBVEbuHxz2Oj1oTVxriRpco4XXvHrMi+8R/zKrUWA=;
        b=LvHhC67ZVfhkJbQHzK22JZ89a+cXxSmEWKxRjjvnPbFVfVXYoqC0dXPf3GYIRZoybjMP0a
        IHCu4zwKZ4qEGTxWj03A0DW71kLd6WZImcDNJ956fzVSRS3Q/98ro1/sCWMcIEfg4vmTXx
        bJrL3LFYUnYktauqUS29FO+ysKabh/o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6xj6vuE-M6mqfrZMwLzjfg-1; Wed, 12 Apr 2023 12:45:51 -0400
X-MC-Unique: 6xj6vuE-M6mqfrZMwLzjfg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74acb477be6so2339385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317951; x=1683909951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwrBVEbuHxz2Oj1oTVxriRpco4XXvHrMi+8R/zKrUWA=;
        b=jcGaF82nR1u7JPr0Q71qfubNAScHmWUUAq80D+N7jlQmhR3OL4Kl8dox+PyPweJ0sD
         PrpkUnyecRHSCQyJtCtfk2oIy6EW3DoEzMcOzQlnYnYhEpswiITWlST3ve9v0qKUZU9S
         OKivcSSMAKYGI3woxDVtAYZit3gZPi8UWi4RVRxz8wuIvlhLsQoX5Qskios/hyC7rsSV
         WHYKVFw1rkBSYJV1OEF16OuhtPGK0nm/1xhbbIU0Q8vIdNG0l4pxstTia+27JzpygW1K
         gnBoZIckQyFJZqIFvsddIWAZBHDm20WQ84OBUJeizcLmhVq+uljT2m9mBo2T3eJt2tV9
         Algg==
X-Gm-Message-State: AAQBX9cS5a7bX7UIsOb4/TmXfFx+KwgC6kqvmmwOz/acPpfihYq7gUaf
        JLqR79zJRFeMjn/UZCO96bhu9nHXODe0dBinwChR69sf5LPdW42qDU8qVsYU3v2Bztuze/66vWu
        PiSwTcGsPP1ctUQw7Ly1nzFhh
X-Received: by 2002:a05:6214:529e:b0:532:141d:3750 with SMTP id kj30-20020a056214529e00b00532141d3750mr4519997qvb.2.1681317951121;
        Wed, 12 Apr 2023 09:45:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350bpuR8W/T8tBiH5wpuCxkcIk4HxIzNVlOw/zbLXydj3bE4PGonuqRLOxkqDMl9QuHI+HTiqgA==
X-Received: by 2002:a05:6214:529e:b0:532:141d:3750 with SMTP id kj30-20020a056214529e00b00532141d3750mr4519973qvb.2.1681317950777;
        Wed, 12 Apr 2023 09:45:50 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id k5-20020ad44205000000b005ef447e24adsm416733qvp.19.2023.04.12.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:45:50 -0700 (PDT)
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
Subject: [PATCH v2 31/31] selftests/mm: Add uffdio register ioctls test
Date:   Wed, 12 Apr 2023 12:45:48 -0400
Message-Id: <20230412164548.329376-1-peterx@redhat.com>
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

This new test tests against the returned ioctls from UFFDIO_REGISTER, where
put into uffdio_register.ioctls.

This also tests the expected failure cases of UFFDIO_REGISTER, aka:

  - Register with empty mode should fail with -EINVAL
  - Register minor without page cache (anon) should fail with -EINVAL

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 112 ++++++++++++++++---
 1 file changed, 97 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index b0acf558e8cb..d871bf732e62 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -62,8 +62,14 @@ mem_type_t mem_types[] = {
 	},
 };
 
+/* Arguments to be passed over to each uffd unit test */
+struct uffd_test_args {
+	mem_type_t *mem_type;
+};
+typedef struct uffd_test_args uffd_test_args_t;
+
 /* Returns: UFFD_TEST_* */
-typedef void (*uffd_test_fn)(void);
+typedef void (*uffd_test_fn)(uffd_test_args_t *);
 
 typedef struct {
 	const char *name;
@@ -172,8 +178,9 @@ static int test_uffd_api(bool use_dev)
  * This function initializes the global variables.  TODO: remove global
  * vars and then remove this.
  */
-static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
-				  const char **errmsg)
+static int
+uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
+		       mem_type_t *mem_type, const char **errmsg)
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
@@ -187,6 +194,9 @@ static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
 	/* TODO: remove this global var.. it's so ugly */
 	nr_cpus = 1;
 
+	/* Initialize test arguments */
+	args->mem_type = mem_type;
+
 	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
 }
 
@@ -239,7 +249,7 @@ static int pagemap_test_fork(bool present)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(void)
+static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
 {
 	uint64_t value;
 	int pagemap_fd;
@@ -285,7 +295,7 @@ static void uffd_wp_unpopulated_test(void)
 	uffd_test_pass();
 }
 
-static void uffd_pagemap_test(void)
+static void uffd_pagemap_test(uffd_test_args_t *args)
 {
 	int pagemap_fd;
 	uint64_t value;
@@ -415,17 +425,17 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 		uffd_test_pass();
 }
 
-void uffd_minor_test(void)
+void uffd_minor_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(false, false);
 }
 
-void uffd_minor_wp_test(void)
+void uffd_minor_wp_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(false, true);
 }
 
-void uffd_minor_collapse_test(void)
+void uffd_minor_collapse_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(true, false);
 }
@@ -603,12 +613,12 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(void)
+static void uffd_sigbus_test(uffd_test_args_t *args)
 {
 	uffd_sigbus_test_common(false);
 }
 
-static void uffd_sigbus_wp_test(void)
+static void uffd_sigbus_wp_test(uffd_test_args_t *args)
 {
 	uffd_sigbus_test_common(true);
 }
@@ -651,12 +661,12 @@ static void uffd_events_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_events_test(void)
+static void uffd_events_test(uffd_test_args_t *args)
 {
 	uffd_events_test_common(false);
 }
 
-static void uffd_events_wp_test(void)
+static void uffd_events_wp_test(uffd_test_args_t *args)
 {
 	uffd_events_test_common(true);
 }
@@ -724,7 +734,7 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(void)
+static void uffd_zeropage_test(uffd_test_args_t *args)
 {
 	bool has_zeropage;
 	int i;
@@ -748,7 +758,77 @@ static void uffd_zeropage_test(void)
 	uffd_test_pass();
 }
 
+/*
+ * Test the returned uffdio_register.ioctls with different register modes.
+ * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
+ */
+static void
+do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
+{
+	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
+	mem_type_t *mem_type = args->mem_type;
+	int ret;
+
+	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
+					miss, wp, minor, &ioctls);
+
+	/*
+	 * Handle special cases of UFFDIO_REGISTER here where it should
+	 * just fail with -EINVAL first..
+	 *
+	 * Case 1: register MINOR on anon
+	 * Case 2: register with no mode selected
+	 */
+	if ((minor && (mem_type->mem_flag == MEM_ANON)) ||
+	    (!miss && !wp && !minor)) {
+		if (ret != -EINVAL)
+			err("register (miss=%d, wp=%d, minor=%d) failed "
+			    "with wrong errno=%d", miss, wp, minor, ret);
+		return;
+	}
+
+	/* UFFDIO_REGISTER should succeed, then check ioctls returned */
+	if (miss)
+		expected |= BIT_ULL(_UFFDIO_COPY);
+	if (wp)
+		expected |= BIT_ULL(_UFFDIO_WRITEPROTECT);
+	if (minor)
+		expected |= BIT_ULL(_UFFDIO_CONTINUE);
+
+	if ((ioctls & expected) != expected)
+		err("unexpected uffdio_register.ioctls "
+		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
+		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);
+
+	if (uffd_unregister(uffd, area_dst, page_size))
+		err("unregister");
+}
+
+static void uffd_register_ioctls_test(uffd_test_args_t *args)
+{
+	int miss, wp, minor;
+
+	for (miss = 0; miss <= 1; miss++)
+		for (wp = 0; wp <= 1; wp++)
+			for (minor = 0; minor <= 1; minor++)
+				do_register_ioctls_test(args, miss, wp, minor);
+
+	uffd_test_pass();
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		/* Test returned uffdio_register.ioctls. */
+		.name = "register-ioctls",
+		.uffd_fn = uffd_register_ioctls_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_MISSING_HUGETLBFS |
+		UFFD_FEATURE_MISSING_SHMEM |
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM |
+		UFFD_FEATURE_MINOR_HUGETLBFS |
+		UFFD_FEATURE_MINOR_SHMEM,
+	},
 	{
 		.name = "zeropage",
 		.uffd_fn = uffd_zeropage_test,
@@ -835,6 +915,7 @@ int main(int argc, char *argv[])
 	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
+	uffd_test_args_t args;
 	char test_name[128];
 	const char *errmsg;
 	int has_uffd;
@@ -862,11 +943,12 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(test, mem_type, &errmsg)) {
+			if (uffd_setup_environment(&args, test, mem_type,
+						   &errmsg)) {
 				uffd_test_skip(errmsg);
 				continue;
 			}
-			test->uffd_fn();
+			test->uffd_fn(&args);
 		}
 	}
 
-- 
2.39.1

