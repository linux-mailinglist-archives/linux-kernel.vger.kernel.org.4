Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED44F7336B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjFPQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbjFPQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:52:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D54231;
        Fri, 16 Jun 2023 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934296; x=1718470296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9XCZnNDXGa3ES/phAjH28aJuSFl5AKJDTx3eRMC0J9A=;
  b=czmHyVPPzCyZT2fbvXgLyitYYg40lDQuiC86g2VbYprDUHtxgay/SIvI
   aQLpoM/pO8u4AdNJHtOXUsquVmhsssSjnE0YblDvsbJyOD5/NY3885bcj
   j4LZqgdcfyJXObXTULz/whyqgz+DGTIDdR+6LLh8zhMNDT2ftFckQAs4f
   IPWorE26CFEZuivAfaEcK5+dLv37ECt0ZyRC9RMQI4fs0EqKrzAExKQ7M
   Jvuc+7ELVJ5jeMH38S0/lZLPkGB3eE7qPV1FS4uPN8jWnxQcrWn6ltzL3
   UEw2H5Vi43bIfdqYBcmV/JInuIoVr/k1QVrP3YNtO6Bm7kWedqfbYLd97
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422913114"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422913114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154256"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154256"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 10/10] acpi/thermal: Move handler installing logic to driver
Date:   Fri, 16 Jun 2023 19:50:34 +0300
Message-ID: <20230616165034.3630141-11-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616165034.3630141-1-michal.wilczynski@intel.com>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_dev_install_notify_handler() at the end of .add() callback.
Call acpi_dev_remove_notify_handler() at the beginning of .remove()
callback. Change arguments passed to the notify function to match with
what's required by acpi_install_notify_handler(). Remove .notify
callback initialization in acpi_driver.

While at it, fix whitespaces in .remove() callback and move tz
assignment upwards.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/thermal.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f9f6ebb08fdb..84716e4b967c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -825,9 +825,12 @@ static void acpi_queue_thermal_check(struct acpi_thermal *tz)
 		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
 }
 
-static void acpi_thermal_notify(struct acpi_device *device, u32 event)
+static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_thermal *tz = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_thermal *tz;
+
+	tz = acpi_driver_data(device);
 
 	if (!tz)
 		return;
@@ -997,11 +1000,20 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
-	goto end;
 
+	result = acpi_dev_install_notify_handler(device,
+						 ACPI_DEVICE_NOTIFY,
+						 acpi_thermal_notify);
+	if (result)
+		goto flush_wq_and_unregister;
+
+	return 0;
+
+flush_wq_and_unregister:
+	flush_workqueue(acpi_thermal_pm_queue);
+	acpi_thermal_unregister_thermal_zone(tz);
 free_memory:
 	kfree(tz);
-end:
 	return result;
 }
 
@@ -1012,10 +1024,15 @@ static void acpi_thermal_remove(struct acpi_device *device)
 	if (!device || !acpi_driver_data(device))
 		return;
 
-	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_DEVICE_NOTIFY,
+				       acpi_thermal_notify);
+
+	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
+
 	kfree(tz);
 }
 
@@ -1078,7 +1095,6 @@ static struct acpi_driver acpi_thermal_driver = {
 	.ops = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
-		.notify = acpi_thermal_notify,
 		},
 	.drv.pm = &acpi_thermal_pm,
 };
-- 
2.41.0

