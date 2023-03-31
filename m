Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF56D17BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCaGqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCaGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:45:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C8103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:45:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so6262774ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680245157;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VYwgOZzIab2d39oyClbfDEpmmkLWmyGxs5IxByBnP0=;
        b=rgB6tWev0qNk4dlZ1kjDIOeciIm5SrcKp4JPV6QaPzj8RD2RWyzS8df1TqVTD+5Dvy
         QdY2YDRTPdY1I/eT3RuDO0jtDYTH4CFByMqWgalTXfd2KGTqCN11w5jTywH8ydCzzGhJ
         YeeUUPCec2EaDf1RW1ZbVgFJKbGGWfHXQhuIx9cNHtImDkqGTAc9k7aw4/aGiBPmdeS6
         zNaDAOorCR9n9QqJlxkX9nWMD8GZ+cS58Jq3Kj94M4wW28/WWWVQ9l9QN/lMxFULTmZh
         h96l3+aHy3fSTlhn0ePMTXVvs1eb/IqaGG5E83napmaipIruUt3U+rX5EpyZuJey8VeK
         RN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680245157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VYwgOZzIab2d39oyClbfDEpmmkLWmyGxs5IxByBnP0=;
        b=S7tBm/6A4oyScQJpBfFqgrzP8iUKA00vFeI0l6Y/1wYsOYVHtu4JL0a8RYaDVOcUqD
         /Xr5Z79yBhG/krwA/Dj3kCeHWE91Wf+kSD2wOrMMwtU33/kNUHAjELc+4ZZq2INNT+3X
         92C5raL335zJKXO5St6phHiPJn/ZlaBldK3s6CWRiNGcSC2wuuoK8Saw4Pu1crPBpiFu
         s0mWs4MIlwbVU4q0ms/+Q/TKYCblsFLBTXNbych49CJtdE6dQ5j19OJtun9+fjcHpaLF
         swMDrBEGnEbVkPJYAiBzRs13KrCMoZ6ibl3D/Q/CkX0fM1i/zszwRZRtzDH5q7E2wgbC
         2Hng==
X-Gm-Message-State: AAQBX9fHJIVuGs02HTeoJk0M+dVCdcj14A9KcYXuhG7YCTokAXzr/sy6
        m8H6u9lVp2sIpQFEZ+zvBrEHMbdX+NVWsdr1
X-Google-Smtp-Source: AKy350acPQrtcTiAOsgiWU+RkjlbXHHJgDvsAx5UvsyHHzTE0TsqfMU0q/sviQZSB71FBMeO6GaZmyYBlQkzNjGj
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a81:b647:0:b0:534:d71f:14e6 with SMTP
 id h7-20020a81b647000000b00534d71f14e6mr12376184ywk.9.1680245157719; Thu, 30
 Mar 2023 23:45:57 -0700 (PDT)
Date:   Fri, 31 Mar 2023 06:45:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331064528.3764174-1-sadiyakazi@google.com>
Subject: [PATCH v2] list: test: Test the klist structure
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KUnit tests to the klist linked-list structure.
These perform testing for different variations of node add
and node delete in the klist data structure (<linux/klist.h>).

Limitation: Since we use a static global variable, and if
multiple instances of this test are run concurrently, the test may fail.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
Thank you Brendan and David for reviewing this patch. I have addressed
the review comments in this iteration.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20230329110723.3458843-1-sadiyakazi@google.com/

- Corrected the commenting style
- Deleted the comment /* counts the number of nodes*/
- Renamed last_node_count to last_node


---
 lib/list-test.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 299 insertions(+), 1 deletion(-)

diff --git a/lib/list-test.c b/lib/list-test.c
index d374cf5d1a57..0cc27de9cec8 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 
 #include <linux/list.h>
+#include <linux/klist.h>
 
 struct list_test_struct {
 	int data;
@@ -1199,6 +1200,303 @@ static struct kunit_suite hlist_test_module = {
 	.test_cases = hlist_test_cases,
 };
 
-kunit_test_suites(&list_test_module, &hlist_test_module);
+
+struct klist_test_struct {
+	int data;
+	struct klist klist;
+	struct klist_node klist_node;
+};
+
+static int node_count;
+static struct klist_node *last_node;
+
+static void check_node(struct klist_node *node_ptr)
+{
+	node_count++;
+	last_node = node_ptr;
+}
+
+static void check_delete_node(struct klist_node *node_ptr)
+{
+	node_count--;
+	last_node = node_ptr;
+}
+
+static void klist_test_add_tail(struct kunit *test)
+{
+	struct klist_node a, b;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_tail(&a, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 1);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &a);
+
+	klist_add_tail(&b, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 2);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &b);
+
+	/* should be [list] -> a -> b */
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_head(struct kunit *test)
+{
+	struct klist_node a, b;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 1);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &a);
+
+	klist_add_head(&b, &mylist);
+	KUNIT_EXPECT_EQ(test, node_count, 2);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &b);
+
+	/* should be [list] -> b -> a */
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_behind(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	klist_add_head(&b, &mylist);
+
+	klist_add_behind(&c, &a);
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
+
+	klist_add_behind(&d, &b);
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
+
+	klist_iter_init(&mylist, &i);
+
+	/* should be [list] -> b -> d -> a -> c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_add_before(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, NULL);
+
+	klist_add_head(&a, &mylist);
+	klist_add_head(&b, &mylist);
+	klist_add_before(&c, &a);
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
+
+	klist_add_before(&d, &b);
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
+
+	klist_iter_init(&mylist, &i);
+
+	/* should be [list] -> b -> d -> a -> c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+/*
+ * Verify that klist_del() delays the deletion of a node until there
+ * are no other references to it
+ */
+static void klist_test_del_refcount_greater_than_zero(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	/* Advance the iterator to point to node c*/
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
+
+	/* Try to delete node c while there is a reference to it*/
+	klist_del(&c);
+
+	/*
+	 * Verify that node c is still attached to the list even after being
+	 * deleted. Since the iterator still points to c, the reference count is not
+	 * decreased to 0
+	 */
+	KUNIT_EXPECT_TRUE(test, klist_node_attached(&c));
+
+	/* Check that node c has not been removed yet*/
+	KUNIT_EXPECT_EQ(test, node_count, 4);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
+
+	klist_iter_exit(&i);
+
+	/*
+	 * Since the iterator is no longer pointing to node c, node c is removed
+	 * from the list
+	 */
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
+
+}
+
+/*
+ * Verify that klist_del() deletes a node immediately when there are no
+ * other references to it.
+ */
+static void klist_test_del_refcount_zero(struct kunit *test)
+{
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+	/* Delete node c*/
+	klist_del(&c);
+
+	/* Check that node c is deleted from the list*/
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
+
+	/* Should be [list] -> a -> b -> d*/
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_remove(struct kunit *test)
+{
+	/* This test doesn't check correctness under concurrent access */
+	struct klist_node a, b, c, d;
+	struct klist mylist;
+	struct klist_iter i;
+
+	node_count = 0;
+	klist_init(&mylist, &check_node, &check_delete_node);
+
+	/* Add nodes a,b,c,d to the list*/
+	klist_add_tail(&a, &mylist);
+	klist_add_tail(&b, &mylist);
+	klist_add_tail(&c, &mylist);
+	klist_add_tail(&d, &mylist);
+	/* Delete node c*/
+	klist_remove(&c);
+
+	/* Check the nodes in the list*/
+	KUNIT_EXPECT_EQ(test, node_count, 3);
+	KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
+
+	/* should be [list] -> a -> b -> d*/
+	klist_iter_init(&mylist, &i);
+
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
+	KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
+	KUNIT_EXPECT_NULL(test, klist_next(&i));
+
+	klist_iter_exit(&i);
+
+}
+
+static void klist_test_node_attached(struct kunit *test)
+{
+	struct klist_node a = {};
+	struct klist mylist;
+
+	klist_init(&mylist, NULL, NULL);
+
+	KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
+	klist_add_head(&a, &mylist);
+	KUNIT_EXPECT_TRUE(test, klist_node_attached(&a));
+	klist_del(&a);
+	KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
+
+}
+
+static struct kunit_case klist_test_cases[] = {
+	KUNIT_CASE(klist_test_add_tail),
+	KUNIT_CASE(klist_test_add_head),
+	KUNIT_CASE(klist_test_add_behind),
+	KUNIT_CASE(klist_test_add_before),
+	KUNIT_CASE(klist_test_del_refcount_greater_than_zero),
+	KUNIT_CASE(klist_test_del_refcount_zero),
+	KUNIT_CASE(klist_test_remove),
+	KUNIT_CASE(klist_test_node_attached),
+	{},
+};
+
+static struct kunit_suite klist_test_module = {
+	.name = "klist",
+	.test_cases = klist_test_cases,
+};
+
+kunit_test_suites(&list_test_module, &hlist_test_module, &klist_test_module);
 
 MODULE_LICENSE("GPL v2");
-- 
2.40.0.348.gf938b09366-goog

