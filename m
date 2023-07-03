Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229F7456D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGCIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGCIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:03:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D671707;
        Mon,  3 Jul 2023 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371405; x=1719907405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TtSlxKV+HOo4L7ax/yjcsU33lOHTI/V/imUAW6Fx3I=;
  b=VpjUrZTS0yVcjuf+voS9rGjIZ/hjwIXjNchI78wyfvmeKUDHZnFkGr3w
   KeD5TCbMhlJ/P60zKHi8vOoid9LchOntElyQ98laKof8TExRe8VlemnBd
   Ow03ziHcyH+vBL04rtv2c073QwGDdqC9jyAeZkcNF7KYjPycyPSZKGl7a
   66IJs1XKxiw7n4//YE/NVNqIPSQfY115NYS3k4UsQdva9fQ5fq/JyGD/u
   A2/TrN6UEL1eJBUZ7nKgSYTcDqrOMdx8CdqTlpdKxNbjL17tyjxeGBTfn
   aVdQ2nltD20zgMCinNIfUMrZvx1TfflD914CKy6Xxs4AVB8PlDhh1P7qY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304033"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304033"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994538"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994538"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:20 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 3/9] acpi/ac: Move handler installing logic to driver
Date:   Mon,  3 Jul 2023 11:02:46 +0300
Message-ID: <20230703080252.2899090-4-michal.wilczynski@intel.com>
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

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 1ace70b831cd..f6feff1f3118 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_ac_add(struct acpi_device *device);
 static void acpi_ac_remove(struct acpi_device *device);
-static void acpi_ac_notify(struct acpi_device *device, u32 event);
+static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
@@ -54,11 +54,9 @@ static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
 	.ids = ac_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
-		.notify = acpi_ac_notify,
 		},
 	.drv.pm = &acpi_ac_pm,
 };
@@ -128,8 +126,9 @@ static enum power_supply_property ac_props[] = {
 };
 
 /* Driver Model */
-static void acpi_ac_notify(struct acpi_device *device, u32 event)
+static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_ac *ac = acpi_driver_data(device);
 
 	if (!ac)
@@ -235,7 +234,7 @@ static int acpi_ac_add(struct acpi_device *device)
 
 	result = acpi_ac_get_state(ac);
 	if (result)
-		goto end;
+		goto err_release_ac;
 
 	psy_cfg.drv_data = ac;
 
@@ -248,7 +247,7 @@ static int acpi_ac_add(struct acpi_device *device)
 					    &ac->charger_desc, &psy_cfg);
 	if (IS_ERR(ac->charger)) {
 		result = PTR_ERR(ac->charger);
-		goto end;
+		goto err_release_ac;
 	}
 
 	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
@@ -256,9 +255,20 @@ static int acpi_ac_add(struct acpi_device *device)
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
-end:
+
+	result = acpi_dev_install_notify_handler(device,
+						 ACPI_ALL_NOTIFY,
+						 acpi_ac_notify);
 	if (result)
-		kfree(ac);
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	power_supply_unregister(ac->charger);
+	unregister_acpi_notifier(&ac->battery_nb);
+err_release_ac:
+	kfree(ac);
 
 	return result;
 }
@@ -297,6 +307,9 @@ static void acpi_ac_remove(struct acpi_device *device)
 
 	ac = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_ALL_NOTIFY,
+				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
 
-- 
2.41.0

