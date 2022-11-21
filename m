Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAF6327FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiKUP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKUP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:26:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB52E0;
        Mon, 21 Nov 2022 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669044404; x=1700580404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+VBW6XwroKj5NIfjAKgNJPCqO6QO8SpE0cvuaGIrmQ=;
  b=TCUNPIl2u/PTe2AytDyO8StJH9iQ2GR8vwdcLAYBYSmwJQ0j9R6ahwyN
   TQtmhrBJHhRzeybVxZ4l44JFS0X9XK4YM80DA0C9yvzfBGIRtyS5FCyPT
   L8E5XyroCNHzPONEr4drG2iTM2Dac2ceD7DBaiJjPQj4IlZux0Yexrb38
   QBf0Ta1/C1hBjRdj1qtqinzwRmwKBxZXrp9sQRItg9zOkP4tVKVclLXue
   BMM6CSeD6IU/ffvvGfe/qRS4qFoEefEKscBUQRPZlqqw9GVvFPKG6rlSY
   e6F77SqeGdcCswiAIwa13EQGGl1WDsnZRgAnET/Evt8E2EFzbGYJ6nnFo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="399872889"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="399872889"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 07:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="746949111"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="746949111"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 07:26:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 416CE2F3; Mon, 21 Nov 2022 17:27:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH v2 3/4] software node: Switch property entry test to a new API
Date:   Mon, 21 Nov 2022 17:27:03 +0200
Message-Id: <20221121152704.30180-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch property entry test to use software_node_register_node_group() API.
The current one is going to be removed soon.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v2: added tags (Heikki, Daniel)

 drivers/base/test/property-entry-test.c | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index 6071d5bc128c..dd2b606d76a3 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -405,20 +405,18 @@ static void pe_test_move_inline_str(struct kunit *test)
 /* Handling of reference properties */
 static void pe_test_reference(struct kunit *test)
 {
-	static const struct software_node nodes[] = {
-		{ .name = "1", },
-		{ .name = "2", },
-		{ }
-	};
+	static const struct software_node node1 = { .name = "1" };
+	static const struct software_node node2 = { .name = "2" };
+	static const struct software_node *group[] = { &node1, &node2, NULL };
 
 	static const struct software_node_ref_args refs[] = {
-		SOFTWARE_NODE_REFERENCE(&nodes[0]),
-		SOFTWARE_NODE_REFERENCE(&nodes[1], 3, 4),
+		SOFTWARE_NODE_REFERENCE(&node1),
+		SOFTWARE_NODE_REFERENCE(&node2, 3, 4),
 	};
 
 	const struct property_entry entries[] = {
-		PROPERTY_ENTRY_REF("ref-1", &nodes[0]),
-		PROPERTY_ENTRY_REF("ref-2", &nodes[1], 1, 2),
+		PROPERTY_ENTRY_REF("ref-1", &node1),
+		PROPERTY_ENTRY_REF("ref-2", &node2, 1, 2),
 		PROPERTY_ENTRY_REF_ARRAY("ref-3", refs),
 		{ }
 	};
@@ -427,7 +425,7 @@ static void pe_test_reference(struct kunit *test)
 	struct fwnode_reference_args ref;
 	int error;
 
-	error = software_node_register_nodes(nodes);
+	error = software_node_register_node_group(group);
 	KUNIT_ASSERT_EQ(test, error, 0);
 
 	node = fwnode_create_software_node(entries, NULL);
@@ -436,7 +434,7 @@ static void pe_test_reference(struct kunit *test)
 	error = fwnode_property_get_reference_args(node, "ref-1", NULL,
 						   0, 0, &ref);
 	KUNIT_ASSERT_EQ(test, error, 0);
-	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &node1);
 	KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
 
 	/* wrong index */
@@ -447,7 +445,7 @@ static void pe_test_reference(struct kunit *test)
 	error = fwnode_property_get_reference_args(node, "ref-2", NULL,
 						   1, 0, &ref);
 	KUNIT_ASSERT_EQ(test, error, 0);
-	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &node2);
 	KUNIT_EXPECT_EQ(test, ref.nargs, 1U);
 	KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
 
@@ -455,7 +453,7 @@ static void pe_test_reference(struct kunit *test)
 	error = fwnode_property_get_reference_args(node, "ref-2", NULL,
 						   3, 0, &ref);
 	KUNIT_ASSERT_EQ(test, error, 0);
-	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &node2);
 	KUNIT_EXPECT_EQ(test, ref.nargs, 3U);
 	KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
 	KUNIT_EXPECT_EQ(test, ref.args[1], 2LLU);
@@ -470,14 +468,14 @@ static void pe_test_reference(struct kunit *test)
 	error = fwnode_property_get_reference_args(node, "ref-3", NULL,
 						   0, 0, &ref);
 	KUNIT_ASSERT_EQ(test, error, 0);
-	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &node1);
 	KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
 
 	/* second reference in the array */
 	error = fwnode_property_get_reference_args(node, "ref-3", NULL,
 						   2, 1, &ref);
 	KUNIT_ASSERT_EQ(test, error, 0);
-	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &node2);
 	KUNIT_EXPECT_EQ(test, ref.nargs, 2U);
 	KUNIT_EXPECT_EQ(test, ref.args[0], 3LLU);
 	KUNIT_EXPECT_EQ(test, ref.args[1], 4LLU);
@@ -488,7 +486,7 @@ static void pe_test_reference(struct kunit *test)
 	KUNIT_EXPECT_NE(test, error, 0);
 
 	fwnode_remove_software_node(node);
-	software_node_unregister_nodes(nodes);
+	software_node_unregister_node_group(group);
 }
 
 static struct kunit_case property_entry_test_cases[] = {
-- 
2.35.1

