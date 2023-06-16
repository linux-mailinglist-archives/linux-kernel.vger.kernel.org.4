Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9447336B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbjFPQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjFPQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:52:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AF35AB;
        Fri, 16 Jun 2023 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934290; x=1718470290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAxiCElI/WsLjL5c5x/g7xAgUbSGehjbwZYVliTAqf8=;
  b=VMCcN+trC9ZobqHcd8erM3lkJ50xhpE4dAmqEq0XJAunPIloEsk2wQSA
   UXi6egWSEKdT2fKPGyd0Lkn9JNVVX7rB9yxgcTqDE92vUBpr8zRZJXvvd
   5DgJLbTfiZ8DbKq4nCIHRkuEZFhf8zJsBc3CvZB7I2ChbI2dD1JnDf7Zp
   77YAxPtR0H52rjomstfabWxEIOxa6+VUwBO3yh2lBkBbYNPM3mWKXSzSu
   25jUzqrTU558b04kzsrbn2ParbTcr8t8vBSS2hLlJIvJpYyY5hN5jDmzy
   XMxnTsxyN631bZ6ErUwdg/bpyTr2hPfolrf4I/+QhVce5wIcHjK/wJ62K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422913098"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422913098"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154239"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154239"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:25 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to driver
Date:   Fri, 16 Jun 2023 19:50:33 +0300
Message-ID: <20230616165034.3630141-10-michal.wilczynski@intel.com>
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
 drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 95930e9d776c..a281bdfee8a0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
-static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
+static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, adev->handle, event);
-	device_unlock(&adev->dev);
+	struct acpi_device *device = data;
+
+	device_lock(&device->dev);
+	__acpi_nfit_notify(&device->dev, handle, event);
+	device_unlock(&device->dev);
 }
 
 static int acpi_nfit_add(struct acpi_device *adev)
@@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
 	if (rc)
 		return rc;
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+
+	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+	if (rc)
+		return rc;
+
+	return acpi_dev_install_notify_handler(adev,
+					       ACPI_DEVICE_NOTIFY,
+					       acpi_nfit_notify);
 }
 
 static void acpi_nfit_remove(struct acpi_device *adev)
 {
 	/* see acpi_nfit_unregister */
+
+	acpi_dev_remove_notify_handler(adev,
+				       ACPI_DEVICE_NOTIFY,
+				       acpi_nfit_notify);
 }
 
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
@@ -3465,7 +3478,6 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ops = {
 		.add = acpi_nfit_add,
 		.remove = acpi_nfit_remove,
-		.notify = acpi_nfit_notify,
 	},
 };
 
-- 
2.41.0

