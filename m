Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C8622902
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiKIKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKIKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:50:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47349249;
        Wed,  9 Nov 2022 02:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667991056; x=1699527056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=unCM/Qt3pgMcDj4CtsPmEJc8BHMjVTV5v1XWbrtVPsY=;
  b=e6oV0IHn8pWl8OVgka/QNakN/6CM7ohPLOHTNJUwRC+zrG4Bmxj7qVLq
   CxqQpEGX3yd7gNjs3uOW7gOj3oTaHrNgcHD9jcXoYSx1i9Bmedv3C6gkE
   A+gR5Zt1kQ4YidhdqaoNVTujzDTJ22TLfybXL2ZT9rfy9g8otmxh4PSR4
   DWzJ8zpsBvFv8KJDBY5pH15VuylqsxC8sQtCnOuzC8ImrXkg9VIPAdxDX
   cNG5n42FTd9SOamzb+GyH1MUHO1BDRd+nbH9jS9HCZ5CyTBIPymgNBqXM
   GrzIh6gdDhmPLxFyXQiQ0X9nrf24hqszUigfE5NmbNUR3+U7L7fHLustV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397239951"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="397239951"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 02:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="779300605"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="779300605"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2022 02:50:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16570155; Wed,  9 Nov 2022 12:51:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 1/2] resource: Replace printk(KERN_WARNING) by pr_warn()
Date:   Wed,  9 Nov 2022 12:51:13 +0200
Message-Id: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Replace printk(KERN_WARNING) by pr_warn().

While at it, use %pa for the resource_size_t variables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 4c5e80b92f2f..ab32b015bd50 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -888,7 +888,7 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 		if (conflict->end > new->end)
 			new->end = conflict->end;
 
-		printk("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
+		pr_info("Expanded resource %s due to conflict with %s\n", new->name, conflict->name);
 	}
 	write_unlock(&resource_lock);
 }
@@ -1283,9 +1283,7 @@ void __release_region(struct resource *parent, resource_size_t start,
 
 	write_unlock(&resource_lock);
 
-	printk(KERN_WARNING "Trying to free nonexistent resource "
-		"<%016llx-%016llx>\n", (unsigned long long)start,
-		(unsigned long long)end);
+	pr_warn("Trying to free nonexistent resource <%pa-%pa>\n", &start, &end);
 }
 EXPORT_SYMBOL(__release_region);
 
@@ -1658,6 +1656,7 @@ __setup("reserve=", reserve_setup);
 int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 {
 	struct resource *p = &iomem_resource;
+	resource_size_t end = addr + size - 1;
 	int err = 0;
 	loff_t l;
 
@@ -1667,12 +1666,12 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
 		 */
-		if (p->start >= addr + size)
+		if (p->start > end)
 			continue;
 		if (p->end < addr)
 			continue;
 		if (PFN_DOWN(p->start) <= PFN_DOWN(addr) &&
-		    PFN_DOWN(p->end) >= PFN_DOWN(addr + size - 1))
+		    PFN_DOWN(p->end) >= PFN_DOWN(end))
 			continue;
 		/*
 		 * if a resource is "BUSY", it's not a hardware resource
@@ -1683,10 +1682,8 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
 		if (p->flags & IORESOURCE_BUSY)
 			continue;
 
-		printk(KERN_WARNING "resource sanity check: requesting [mem %#010llx-%#010llx], which spans more than %s %pR\n",
-		       (unsigned long long)addr,
-		       (unsigned long long)(addr + size - 1),
-		       p->name, p);
+		pr_warn("resource sanity check: requesting [mem %pa-%pa], which spans more than %s %pR\n",
+			&addr, &end, p->name, p);
 		err = -1;
 		break;
 	}
-- 
2.35.1

