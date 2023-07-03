Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424657456E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGCIEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGCIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:04:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E65E5E;
        Mon,  3 Jul 2023 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371423; x=1719907423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=epFJB+pC8Cnb2bJxMzw10oc2jXbHbhRfW4dq8aHrchQ=;
  b=O2/mXA9IicmJfmj7lG3LYWoj+1Ci28bfx1OL+NCZXonzuzMH83nBY9YC
   ba6imj4xVtcwnWa3TAa/XOW84TpzmwkzBTlnwngKD2eqMkr1+Aw+DA4fg
   TmEJhDg65ck6WcjP8QqC0nAaMckRjc6cRUnKaKpbnIBNq5rh1J13dlsvQ
   RSr8BtLuxAp7wfxgjKC+EW0cZc1fjDEdRA0k8N1ymlknoFBjjMOVeeMui
   41/Io3utSs3uPbyngbsAZdGGKTw7iONn1p28+YSvvFpaMNT4nqZJtAIjP
   F5BJ0xpyZ082Fj9Er2lO05vmImAMd3Ij3PPbmWiSIzalHtIRlS4trZQtw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304086"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994572"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994572"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:33 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 7/9] acpi/nfit: Move handler installing logic to driver
Date:   Mon,  3 Jul 2023 11:02:50 +0300
Message-ID: <20230703080252.2899090-8-michal.wilczynski@intel.com>
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
index 07204d482968..124e928647d3 100644
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
+static void acpi_nfit_remove_notify_handler(void *data)
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

