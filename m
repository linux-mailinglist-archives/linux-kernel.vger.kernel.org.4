Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993FA74425D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjF3Sfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjF3Sel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:34:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1E4206;
        Fri, 30 Jun 2023 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688150065; x=1719686065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ro1KbsI0sCyRbPkzkXqtarOGFnBsPGqpRQpQUovj/YY=;
  b=HWSno8137Z0TgTxDp2bQ//y84gJh5mvSMXCephCZwsLO18dUVh0l1BXg
   lwQp4kQOIkOhTG0ia8fn9kbDM0g3knd10RUVsaMs6z9xvIB0noItP8CYJ
   qsakOVKTL/9XHeEvlZT+Noh6zJWgS+TnJFydFlMwecBDpX9QQP9Bpv6kW
   jb0uYZIyKsDD5/BtzK1/oJ67Ew3IkLr/yYpFlwDsE8ry2S2M4BV/g3eyY
   bXftxAsdcodtpDQVE+cRuFG3jMhIxFvaRF8iP/6dTU/St56EY/PyCU5OE
   CsaTZitSUgZNcTpb7R7WGNS5sef3MY6F1ZjrVO/5yL3ZcLEK7qVG7sdex
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365949967"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365949967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717896448"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717896448"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:21 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 5/9] acpi/battery: Move handler installing logic to driver
Date:   Fri, 30 Jun 2023 21:33:40 +0300
Message-ID: <20230630183344.891077-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630183344.891077-1-michal.wilczynski@intel.com>
References: <20230630183344.891077-1-michal.wilczynski@intel.com>
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
what's required by acpi_dev_install_notify_handler(). Remove .notify
callback initialization in acpi_driver.

While at it, fix lack of whitespaces in .remove() callback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/battery.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9c67ed02d797..4c634a4c32dd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1034,8 +1034,9 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(struct acpi_device *device, u32 event)
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_battery *battery = acpi_driver_data(device);
 	struct power_supply *old;
 
@@ -1212,13 +1213,23 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 1);
 
-	return result;
+	result = acpi_dev_install_notify_handler(device,
+						 ACPI_ALL_NOTIFY,
+						 acpi_battery_notify);
+	if (result)
+		goto fail_pm;
+
+	return 0;
 
+fail_pm:
+	device_init_wakeup(&device->dev, 0);
+	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_remove_battery(battery);
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
 	kfree(battery);
+
 	return result;
 }
 
@@ -1228,10 +1239,17 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	if (!device || !acpi_driver_data(device))
 		return;
-	device_init_wakeup(&device->dev, 0);
+
 	battery = acpi_driver_data(device);
+
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_ALL_NOTIFY,
+				       acpi_battery_notify);
+
+	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 	sysfs_remove_battery(battery);
+
 	mutex_destroy(&battery->lock);
 	mutex_destroy(&battery->sysfs_lock);
 	kfree(battery);
@@ -1264,11 +1282,9 @@ static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = battery_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
-		.notify = acpi_battery_notify,
 		},
 	.drv.pm = &acpi_battery_pm,
 };
-- 
2.41.0

