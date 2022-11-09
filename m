Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C9622F75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiKIP4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKIPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:55:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841491D674
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668009358; x=1699545358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=houP/G39k9nKc21+XB8opbGw93N1dUcYvVlSmSR6tAo=;
  b=IGYdAGIsI9z97yCXMAMYNyLu18kDUIBhCPuAIe4oza6a3BUGop81lWVq
   2E1SLwltpgN+CsluOegcUKBhAv0ExnJWDPEUwheWykp3u8vJ+zgw2Zbk/
   E5MVRo9MxsMA6oiOsk4x7+kayR/6ZImadQrMl3e+gXAtYB50qvA1pUea1
   3jWgmB27EeLKWtj2ZoLWuh6FSmqgp+HEtpATQHTsC3kpiMt7vmO0IUh5w
   b5oWmhuF02iIYy96FUxFatC98ANnjYx9+TX2ujHi5gdPZJ7ctBaU2Tao+
   yGt+g7BlgnlTR1yGUO6rjSer0S+Atspv6s7SXgAvbpDB3ZEzuUtFoVYlK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="308632794"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="308632794"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 07:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="881974115"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="881974115"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2022 07:55:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADE60155; Wed,  9 Nov 2022 17:56:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] resource: Replace printk(KERN_WARNING) by pr_warn(), printk() by pr_info()
Date:   Wed,  9 Nov 2022 17:56:17 +0200
Message-Id: <20221109155618.42276-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk(KERN_WARNING) by pr_warn() and printk() by pr_info().

While at it, use %pa for the resource_size_t variables. With that,
for the sake of consistency, introduce a temporary variable for
the end address in iomem_map_sanity_check() like it's done in another
function in the same module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: updated changelog (Rafael), Cc'ed to Greg (Rafael)
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

