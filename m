Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DF5ECA84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiI0RJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI0RJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:09:17 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A36DF95
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:09:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664298555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SM5jImXkTQ0dWpEX7zywQte5Om9P2FhlzYZkNaZtxVY=;
        b=Ytygl79eKAkc505qOAP9/aJ2ptBvHS08vBpNG57fPXozhwhcVFSEHqGy0PuyjRYktlfiMt
        6+QN5G/yXyA3A+wZUMkl2+wN3ODYRaihSR0Z2lNjd9n+i8f4gP8DI9GkQ/ExJiDXxzoSIh
        gKRa89te2AOLlwpSqKtvLn7NIydhja4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 2/3] kasan: migrate kasan_rcu_uaf test to kunit
Date:   Tue, 27 Sep 2022 19:09:10 +0200
Message-Id: <897ee08d6cd0ba7e8a4fbfd9d8502823a2f922e6.1664298455.git.andreyknvl@google.com>
In-Reply-To: <9345acdd11e953b207b0ed4724ff780e63afeb36.1664298455.git.andreyknvl@google.com>
References: <9345acdd11e953b207b0ed4724ff780e63afeb36.1664298455.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Migrate the kasan_rcu_uaf test to the KUnit framework.

Changes to the implementation of the test:

- Call rcu_barrier() after call_rcu() to make that the RCU callbacks get
  triggered before the test is over.

- Cast pointer passed to rcu_dereference_protected as __rcu to get rid of
  the Sparse warning.

- Check that KASAN prints a report via KUNIT_EXPECT_KASAN_FAIL.

Initially, this test was intended to check that Generic KASAN prints
auxiliary stack traces for RCU objects. Nevertheless, the test is enabled
for all modes to make that KASAN reports bad accesses in RCU callbacks.

The presence of auxiliary stack traces for the Generic mode needs to be
inspected manually.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c        | 37 ++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan_test_module.c | 30 -----------------------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 3a2886f85e69..005776325e20 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1134,6 +1134,42 @@ static void kmalloc_double_kzfree(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
 }
 
+static struct kasan_rcu_info {
+	int i;
+	struct rcu_head rcu;
+} *global_rcu_ptr;
+
+static void rcu_uaf_reclaim(struct rcu_head *rp)
+{
+	struct kasan_rcu_info *fp =
+		container_of(rp, struct kasan_rcu_info, rcu);
+
+	kfree(fp);
+	((volatile struct kasan_rcu_info *)fp)->i;
+}
+
+/*
+ * Check that Generic KASAN prints auxiliary stack traces for RCU callbacks.
+ * The report needs to be inspected manually.
+ *
+ * This test is still enabled for other KASAN modes to make sure that all modes
+ * report bad accesses in tested scenarios.
+ */
+static void rcu_uaf(struct kunit *test)
+{
+	struct kasan_rcu_info *ptr;
+
+	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	global_rcu_ptr = rcu_dereference_protected(
+				(struct kasan_rcu_info __rcu *)ptr, NULL);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
+		rcu_barrier());
+}
+
 static void vmalloc_helpers_tags(struct kunit *test)
 {
 	void *ptr;
@@ -1465,6 +1501,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),
 	KUNIT_CASE(kmalloc_double_kzfree),
+	KUNIT_CASE(rcu_uaf),
 	KUNIT_CASE(vmalloc_helpers_tags),
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
diff --git a/mm/kasan/kasan_test_module.c b/mm/kasan/kasan_test_module.c
index e4ca82dc2c16..4688cbcd722d 100644
--- a/mm/kasan/kasan_test_module.c
+++ b/mm/kasan/kasan_test_module.c
@@ -62,35 +62,6 @@ static noinline void __init copy_user_test(void)
 	kfree(kmem);
 }
 
-static struct kasan_rcu_info {
-	int i;
-	struct rcu_head rcu;
-} *global_rcu_ptr;
-
-static noinline void __init kasan_rcu_reclaim(struct rcu_head *rp)
-{
-	struct kasan_rcu_info *fp = container_of(rp,
-						struct kasan_rcu_info, rcu);
-
-	kfree(fp);
-	((volatile struct kasan_rcu_info *)fp)->i;
-}
-
-static noinline void __init kasan_rcu_uaf(void)
-{
-	struct kasan_rcu_info *ptr;
-
-	pr_info("use-after-free in kasan_rcu_reclaim\n");
-	ptr = kmalloc(sizeof(struct kasan_rcu_info), GFP_KERNEL);
-	if (!ptr) {
-		pr_err("Allocation failed\n");
-		return;
-	}
-
-	global_rcu_ptr = rcu_dereference_protected(ptr, NULL);
-	call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
-}
-
 static noinline void __init kasan_workqueue_work(struct work_struct *work)
 {
 	kfree(work);
@@ -130,7 +101,6 @@ static int __init test_kasan_module_init(void)
 	bool multishot = kasan_save_enable_multi_shot();
 
 	copy_user_test();
-	kasan_rcu_uaf();
 	kasan_workqueue_uaf();
 
 	kasan_restore_multi_shot(multishot);
-- 
2.25.1

