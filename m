Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3663C733684
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFPQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbjFPQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:50:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D53E4B;
        Fri, 16 Jun 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934257; x=1718470257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UvyzPcfXTAF64SpSK/iQMRURHuN5IiuY8+/vdbpQTg=;
  b=VGeUntbeYs6L4U9yD9ODOzD7AVAYB7Uo1At2/BqcWvlhSsSUTXd/HcVn
   jPmPB48OCu5XqPRDZIzzmlkV+iLMNbzl55GXFB6hq60UNckBHQSYgQVSJ
   hkbFd6ZfoBNxtroAc+NCO+3+wozcJ7BXLZ+H7LnvFhivq1xxDeNykKC9E
   Pf1aYo3kodeufOiKGm/rp6632YJyZF1wGWH6s6p0rAikHtCfJVlpMORgV
   asZXq0yPIj6mgpSoUirr0W3n+yN/GI+8Rnzt13G8pZj9J82rpOrb4PmDV
   YTwZ5c9g0qZa6oBt+ncfDTWbO5uPO95vZCx3CD7wRZqSz+1PZ8oh5ZN28
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422912944"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422912944"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154086"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154086"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:50:53 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 01/10] acpi/bus: Introduce wrappers for ACPICA event handler install/remove
Date:   Fri, 16 Jun 2023 19:50:25 +0300
Message-ID: <20230616165034.3630141-2-michal.wilczynski@intel.com>
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

Introduce new acpi_dev_install_notify_handler() and
acpi_dev_remove_notify_handler(). Those functions are replacing old
installers, and after all drivers switch to the new model, old installers
will be removed.

Make acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
non-static, and export symbols. This will allow the drivers to call them
directly, instead of relying on .notify callback.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c      | 26 ++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b6ab3608d782..22468589c551 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -557,6 +557,32 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
 	acpi_os_wait_events_complete();
 }
 
+int acpi_dev_install_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler)
+{
+	acpi_status status;
+
+	status = acpi_install_notify_handler(adev->handle,
+					     handler_type,
+					     handler,
+					     adev);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_dev_install_notify_handler);
+
+void acpi_dev_remove_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler)
+{
+	acpi_remove_notify_handler(adev->handle, handler_type, handler);
+	acpi_os_wait_events_complete();
+}
+EXPORT_SYMBOL(acpi_dev_remove_notify_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c941d99162c0..23fbe4a16972 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -515,6 +515,12 @@ void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
 int acpi_bus_attach_private_data(acpi_handle, void *);
 void acpi_bus_detach_private_data(acpi_handle);
+int acpi_dev_install_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler);
+void acpi_dev_remove_notify_handler(struct acpi_device *adev,
+				    u32 handler_type,
+				    acpi_notify_handler handler);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.41.0

