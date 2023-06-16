Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D622D7336AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345898AbjFPQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345726AbjFPQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:51:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8603359C;
        Fri, 16 Jun 2023 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934277; x=1718470277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i3LCbxXW1I/fk6aNkEWMrCEmBGj4eZySi8syJ1vaMOg=;
  b=aseYtAuFNXa6jZaOk8jLw3MRXs08jPkL3+gubqgvBkkbcJ6dPcL+q3al
   47BM1cCbKYHWxcxmF0emoMh5/CqRbVhFGTu8PBcbdu+SwLDchs+X7tTyh
   tYCrSjYdknaQXHD0v5Hxhpxgs80I081aFLop87sPbEuE2c/ZpwbUDWHEe
   xfM9XvMnukk1NIZIfwfRBNiB8Zsfy+6CpINeFDEhMN+9aO2fTVUHtZ5Ha
   RiLhG8kr0jS1F/Gu5B3sORuIkumiXmAdaskrblWz/jxjDnB8ZrjXqob2J
   D49VfA3odWqAPQciFm2NSWBnGdSaFiyZJU9dNWl67lzvKo/h5ZKjCA/7y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422913042"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422913042"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154194"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154194"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:12 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 06/10] acpi/hed: Move handler installing logic to driver
Date:   Fri, 16 Jun 2023 19:50:30 +0300
Message-ID: <20230616165034.3630141-7-michal.wilczynski@intel.com>
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
 drivers/acpi/hed.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 78d44e3fe129..8f54560c6d1c 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -42,22 +42,34 @@ EXPORT_SYMBOL_GPL(unregister_acpi_hed_notifier);
  * it is used by HEST Generic Hardware Error Source with notify type
  * SCI.
  */
-static void acpi_hed_notify(struct acpi_device *device, u32 event)
+static void acpi_hed_notify(acpi_handle handle, u32 event, void *data)
 {
 	blocking_notifier_call_chain(&acpi_hed_notify_list, 0, NULL);
 }
 
 static int acpi_hed_add(struct acpi_device *device)
 {
+	int err;
+
 	/* Only one hardware error device */
 	if (hed_handle)
 		return -EINVAL;
 	hed_handle = device->handle;
-	return 0;
+
+	err = acpi_dev_install_notify_handler(device,
+					      ACPI_DEVICE_NOTIFY,
+					      acpi_hed_notify);
+	if (err)
+		hed_handle = NULL;
+
+	return err;
 }
 
 static void acpi_hed_remove(struct acpi_device *device)
 {
+	acpi_dev_remove_notify_handler(device,
+				       ACPI_DEVICE_NOTIFY,
+				       acpi_hed_notify);
 	hed_handle = NULL;
 }
 
@@ -68,7 +80,6 @@ static struct acpi_driver acpi_hed_driver = {
 	.ops = {
 		.add = acpi_hed_add,
 		.remove = acpi_hed_remove,
-		.notify = acpi_hed_notify,
 	},
 };
 module_acpi_driver(acpi_hed_driver);
-- 
2.41.0

