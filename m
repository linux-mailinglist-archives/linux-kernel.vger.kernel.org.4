Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF19F60316C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJRRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJRRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:17:13 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D73A2A96
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:17:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666113430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sMEqDPOnA0B1xo/BBovBSGH55UI1F4ZzoT+c6nAvV4=;
        b=iQpOwSCLZjzJ52HhFXaIUvgFQ1sUWc4Sc9mt8RosAmIo8bQnSklMNwaQpWMQIBavCfsZ/X
        ELYid2RnVBuJjL7uKJah1g3sJuR8mpsKtJhJ7qrO5piVxy2cFIa7J1uhE+kEUOxuE6Gpdp
        6D/jHBZckDcxA2Um5/ChnTrtAQsS3Zo=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 3/3] kasan: migrate workqueue_uaf test to kunit
Date:   Tue, 18 Oct 2022 19:17:06 +0200
Message-Id: <3a28fa0c89771e47418fb2d5f0e009c83aec5eba.1666113393.git.andreyknvl@google.com>
In-Reply-To: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Migrate the workqueue_uaf test to the KUnit framework.

Initially, this test was intended to check that Generic KASAN prints
auxiliary stack traces for workqueues. Nevertheless, the test is enabled
for all modes to make that KASAN reports bad accesses in the tested
scenario.

The presence of auxiliary stack traces for the Generic mode needs to be
inspected manually.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changed v2->v3:
- Rebased onto 6.1-rc1
---
 mm/kasan/kasan_test.c        | 40 +++++++++++++++++++++++++++++-------
 mm/kasan/kasan_test_module.c | 30 ---------------------------
 2 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 38bf6ed61cb8..e27591ef2777 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1141,6 +1141,14 @@ static void kmalloc_double_kzfree(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
 }
 
+/*
+ * The two tests below check that Generic KASAN prints auxiliary stack traces
+ * for RCU callbacks and workqueues. The reports need to be inspected manually.
+ *
+ * These tests are still enabled for other KASAN modes to make sure that all
+ * modes report bad accesses in tested scenarios.
+ */
+
 static struct kasan_rcu_info {
 	int i;
 	struct rcu_head rcu;
@@ -1155,13 +1163,6 @@ static void rcu_uaf_reclaim(struct rcu_head *rp)
 	((volatile struct kasan_rcu_info *)fp)->i;
 }
 
-/*
- * Check that Generic KASAN prints auxiliary stack traces for RCU callbacks.
- * The report needs to be inspected manually.
- *
- * This test is still enabled for other KASAN modes to make sure that all modes
- * report bad accesses in tested scenarios.
- */
 static void rcu_uaf(struct kunit *test)
 {
 	struct kasan_rcu_info *ptr;
@@ -1177,6 +1178,30 @@ static void rcu_uaf(struct kunit *test)
 		rcu_barrier());
 }
 
+static void workqueue_uaf_work(struct work_struct *work)
+{
+	kfree(work);
+}
+
+static void workqueue_uaf(struct kunit *test)
+{
+	struct workqueue_struct *workqueue;
+	struct work_struct *work;
+
+	workqueue = create_workqueue("kasan_workqueue_test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, workqueue);
+
+	work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, work);
+
+	INIT_WORK(work, workqueue_uaf_work);
+	queue_work(workqueue, work);
+	destroy_workqueue(workqueue);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		((volatile struct work_struct *)work)->data);
+}
+
 static void vmalloc_helpers_tags(struct kunit *test)
 {
 	void *ptr;
@@ -1509,6 +1534,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_bitops_tags),
 	KUNIT_CASE(kmalloc_double_kzfree),
 	KUNIT_CASE(rcu_uaf),
+	KUNIT_CASE(workqueue_uaf),
 	KUNIT_CASE(vmalloc_helpers_tags),
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
index 4688cbcd722d..7be7bed456ef 100644
--- a/mm/kasan/kasan_test_module.c
+++ b/mm/kasan/kasan_test_module.c
@@ -62,35 +62,6 @@ static noinline void __init copy_user_test(void)
 	kfree(kmem);
 }
 
-static noinline void __init kasan_workqueue_work(struct work_struct *work)
-{
-	kfree(work);
-}
-
-static noinline void __init kasan_workqueue_uaf(void)
-{
-	struct workqueue_struct *workqueue;
-	struct work_struct *work;
-
-	workqueue = create_workqueue("kasan_wq_test");
-	if (!workqueue) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-	work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
-	if (!work) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	INIT_WORK(work, kasan_workqueue_work);
-	queue_work(workqueue, work);
-	destroy_workqueue(workqueue);
-
-	pr_info("use-after-free on workqueue\n");
-	((volatile struct work_struct *)work)->data;
-}
-
 static int __init test_kasan_module_init(void)
 {
 	/*
@@ -101,7 +72,6 @@ static int __init test_kasan_module_init(void)
 	bool multishot = kasan_save_enable_multi_shot();
 
 	copy_user_test();
-	kasan_workqueue_uaf();
 
 	kasan_restore_multi_shot(multishot);
 	return -EAGAIN;
-- 
2.25.1

