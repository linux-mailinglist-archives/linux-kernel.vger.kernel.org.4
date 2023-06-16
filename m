Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABE733698
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbjFPQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbjFPQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:51:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1163359E;
        Fri, 16 Jun 2023 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934265; x=1718470265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YpXKLkZYqfKoJMlwGjZfZyyB1xoLyflHJUZahcB0DSk=;
  b=bu95iKOFP58T622ZR8rm+wpam/MV/8Ipukip2VI72O7lLJgDw+L0PHXq
   pd4dq7vRWNc+lnAnBLl4ycKwBxuiMFC5efrPUkidup02UG1G6SMzPUS0j
   yImtNFBgsZ9B7MvhzICZDtEk2NNOTSKPn0lXNlDGABFAml9lTGixejb4O
   8AwAnOHkA1/XpdstiuuHdpXol9BBUcgsQ+3zQ27zJWmFJZ2qK9Tk6Qb61
   +6Xz/ZrP4nJ5hixw7Z7RB1obPxeRQsw9nJF1yS0JiTuGGKp1P8kRwaz31
   9B1Tmv9ot889Y01LtrUIHBooq+FbMY9XKE58L+2HzWJSDBPl6eQeBMglt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422912993"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422912993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154134"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154134"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:01 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 03/10] acpi/ac: Move handler installing logic to driver
Date:   Fri, 16 Jun 2023 19:50:27 +0300
Message-ID: <20230616165034.3630141-4-michal.wilczynski@intel.com>
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

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 1ace70b831cd..207ee3c85bad 100644
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
@@ -128,9 +126,12 @@ static enum power_supply_property ac_props[] = {
 };
 
 /* Driver Model */
-static void acpi_ac_notify(struct acpi_device *device, u32 event)
+static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_ac *ac;
+
+	ac = acpi_driver_data(device);
 
 	if (!ac)
 		return;
@@ -235,7 +236,7 @@ static int acpi_ac_add(struct acpi_device *device)
 
 	result = acpi_ac_get_state(ac);
 	if (result)
-		goto end;
+		goto err_release_ac;
 
 	psy_cfg.drv_data = ac;
 
@@ -248,7 +249,7 @@ static int acpi_ac_add(struct acpi_device *device)
 					    &ac->charger_desc, &psy_cfg);
 	if (IS_ERR(ac->charger)) {
 		result = PTR_ERR(ac->charger);
-		goto end;
+		goto err_release_ac;
 	}
 
 	pr_info("%s [%s] (%s)\n", acpi_device_name(device),
@@ -256,9 +257,20 @@ static int acpi_ac_add(struct acpi_device *device)
 
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
@@ -297,6 +309,9 @@ static void acpi_ac_remove(struct acpi_device *device)
 
 	ac = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_ALL_NOTIFY,
+				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
 
-- 
2.41.0

