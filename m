Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2574425F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjF3Sfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjF3Se6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:34:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A39468B;
        Fri, 30 Jun 2023 11:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688150072; x=1719686072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/R3I4v94b+OqCb+YA+/zIsoRAWwSbNvd1KKpPX6mkEU=;
  b=PlNt9rTUD22dV4rWwMBhWsE/fASN7KPCohXZBDDXxANTo4Azm0I9hSmt
   nZsbN6HfcBxIfT33RfRuKlhd+7vBLZAgxK/viIrOuhBFMy96yyTJd8DQn
   X38zCbJmTdg4nCfmvRUzH+TuobQhA0bxK2/wA4PWJJHWQ0RWwZKJJ6W23
   WYkb3meQ7hHzO/KCqxHRdj//NQq4t5dOKFxyS7Bf5bpwXAZIXRWtCC985
   4QtfCfRQoGZIjjmaR6RZ8mO8lupTXLRm+X3MoPuP5wqZgv7P7Iutiucb5
   Gv8mFmW+cSVLrI9ARygmSFKdyhPtXCDJidIPwb6ogzIqbj13J2AmjcrQf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365949997"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365949997"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717896464"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717896464"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:28 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 7/9] acpi/nfit: Move handler installing logic to driver
Date:   Fri, 30 Jun 2023 21:33:42 +0300
Message-ID: <20230630183344.891077-8-michal.wilczynski@intel.com>
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
Call acpi_dev_remove_notify_handler() at the beginning of
acpi_nfit_shutdown(). Change arguments passed to the notify function to
match with what's required by acpi_dev_install_notify_handler(). Remove
.notify callback initialization in acpi_driver.

Introduce a new devm action acpi_nfit_remove_notify_handler.

Move acpi_nfit_notify() upwards in the file, so it can be used inside
acpi_nfit_add() and acpi_nfit_remove_notify_handler().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 41 +++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..ee2365a80aa1 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3282,6 +3282,24 @@ static void acpi_nfit_put_table(void *table)
 	acpi_put_table(table);
 }
 
+static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *adev = data;
+
+	device_lock(&adev->dev);
+	__acpi_nfit_notify(&adev->dev, handle, event);
+	device_unlock(&adev->dev);
+}
+
+void acpi_nfit_remove_notify_handler(void *data)
+{
+	struct acpi_device *adev = data;
+
+	acpi_dev_remove_notify_handler(adev,
+				       ACPI_DEVICE_NOTIFY,
+				       acpi_nfit_notify);
+}
+
 void acpi_nfit_shutdown(void *data)
 {
 	struct acpi_nfit_desc *acpi_desc = data;
@@ -3368,7 +3386,20 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
 	if (rc)
 		return rc;
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+
+	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	if (rc)
+		return rc;
+
+	rc = acpi_dev_install_notify_handler(adev,
+					     ACPI_DEVICE_NOTIFY,
+					     acpi_nfit_notify);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(dev,
+					acpi_nfit_remove_notify_handler,
+					adev);
 }
 
 static void acpi_nfit_remove(struct acpi_device *adev)
@@ -3446,13 +3477,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 }
 EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
-static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
-{
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, adev->handle, event);
-	device_unlock(&adev->dev);
-}
-
 static const struct acpi_device_id acpi_nfit_ids[] = {
 	{ "ACPI0012", 0 },
 	{ "", 0 },
@@ -3465,7 +3489,6 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ops = {
 		.add = acpi_nfit_add,
 		.remove = acpi_nfit_remove,
-		.notify = acpi_nfit_notify,
 	},
 };
 
-- 
2.41.0

