Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA62E7456E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGCIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjGCIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:05:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070FB1BDC;
        Mon,  3 Jul 2023 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371457; x=1719907457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UyXWfKO7yUPN8MnLg1ywaUXI/b1qFb1tKTsv4NWR/I=;
  b=l1LwjDYCrewAZ6Pxs3pbcdjptcgc069c0rPKAObsNA/9bhZ39ubcpwKt
   1SnKXW9uE31IC6GyARz2pjs6D+llrO629ivMvLfrXPUv/LEgy3umRGxVA
   VRnoe+pe6y3OdE+Lcb/ZoKWN4Ekvx66/5v7Wd+i1m3mVUVlz0SytiVHvY
   J1cCktV2TfNj6HjwI14K9HeM9P5MRTByK4w8OYT1KEBNVvHClszSCSQro
   BGUC5A8X3Ws9rW6xU4P+qmd9mJRrphnxgsErLQsgwZifZ7+mW80cGJvg/
   gOtGZFwEVabALm6qbNSC3hjuzDPFBzjhAw0swR0oEMWTQMJOAWmNaE3wI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304114"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304114"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994579"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994579"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:39 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 9/9] acpi/thermal: Move handler installing logic to driver
Date:   Mon,  3 Jul 2023 11:02:52 +0300
Message-ID: <20230703080252.2899090-10-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
what's required by acpi_dev_install_notify_handler(). Remove .notify
callback initialization in acpi_driver.

While at it, fix whitespaces in .remove() callback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/thermal.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f9f6ebb08fdb..97858ad59d68 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -825,8 +825,9 @@ static void acpi_queue_thermal_check(struct acpi_thermal *tz)
 		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
 }
 
-static void acpi_thermal_notify(struct acpi_device *device, u32 event)
+static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_thermal *tz = acpi_driver_data(device);
 
 	if (!tz)
@@ -997,11 +998,21 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
-	goto end;
 
+	result = acpi_dev_install_notify_handler(device,
+						 ACPI_DEVICE_NOTIFY,
+						 acpi_thermal_notify);
+	if (result)
+		goto flush_wq;
+
+	return 0;
+
+flush_wq:
+	flush_workqueue(acpi_thermal_pm_queue);
+	acpi_thermal_unregister_thermal_zone(tz);
 free_memory:
 	kfree(tz);
-end:
+
 	return result;
 }
 
@@ -1012,10 +1023,15 @@ static void acpi_thermal_remove(struct acpi_device *device)
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
 
@@ -1078,7 +1094,6 @@ static struct acpi_driver acpi_thermal_driver = {
 	.ops = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
-		.notify = acpi_thermal_notify,
 		},
 	.drv.pm = &acpi_thermal_pm,
 };
-- 
2.41.0

