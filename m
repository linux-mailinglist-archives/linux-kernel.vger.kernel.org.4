Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68D62FD87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbiKRTBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiKRTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:01:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5B10E9;
        Fri, 18 Nov 2022 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668798065; x=1700334065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bxz54gOygFD+2N524o4eOo4LHia2SzsQwfOA3UPhtPM=;
  b=FVZ8ueyrMLZZZeR+TF+eDvc4zOVDDC1ds47AspOC+cUrIBEZ1orsZaoe
   nRE88bnMUEPYBUNc1KFO+YBL8Wnx6QA3PcLrV6q3RJt606kIHzY225GrF
   K9nhLECfrh+nW7zkifz+k07Lg+3j/QIrBHyG7hqxrERdZ1m4j9yoMOkTL
   xkrZxiCf9tLWfZr7DBbNVhZk79oiAA9+FN6dXapK0rCSxfgwTupiS1/P9
   PDSocuIBhPq4lCs9j+Gih3UCkjfN9piU3u/3ecVlzXciFqO4O+PWzO4T2
   pB/WBiwQhi53j2droYd8G+ezuJYY17qW2vg8koWwy1GgAnHga4wtvagC7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="311912178"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="311912178"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="815018698"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="815018698"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2022 11:01:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6043A2F3; Fri, 18 Nov 2022 21:01:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: [PATCH v1 3/4] software node: Switch property entry test to new API
Date:   Fri, 18 Nov 2022 20:56:16 +0200
Message-Id: <20221118185617.33908-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
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
---
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

