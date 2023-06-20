Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893877377C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjFTXCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFTXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887BECD;
        Tue, 20 Jun 2023 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687302116; x=1718838116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKmNt3HszQmb/54iu3mxg6VlucMYA5OmGJY2K1UUMO0=;
  b=FeyaMbY40thCB9Sy2YuK5r1REbMf5+QJ4z5f95UNMDIpmCUrx2OIyWPd
   M/pimQkiNCV0ygVTeCfKeAzz4fH8rzSfIDx6HWWx/2AvMCqgOc13FBbZY
   h+bcUMbXW8N/Z6qmOf0G+bAdLqI/EV4quPjDn5C+NqH/JVpqD4pHlOkTC
   Nn7Ef/B6jQUfvb2XGia99JJI5ulWnTgzLE1KTJCVii0mc1N/63PtInMJI
   u1UH4b6TO3ETafFioenYjn4ipmz1ZVf2G5r4vD9DMKhRycrYprcdXIhRt
   6SPYrOuEB3LDHeu5KIp9OgGxYYjhawdlTvLJmU7yx77t1SgKX/bcyoe5+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340347301"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340347301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044465338"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="1044465338"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 16:01:54 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/7] thermal/drivers/int340x: Support workload hint interrupts
Date:   Tue, 20 Jun 2023 16:01:49 -0700
Message-Id: <20230620230150.3068704-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On thermal device interrupt, if the interrupt is generated for passing
workload hint, call the callback to pass notification to the user
space.

First call proc_thermal_check_wlt_intr() to check interrupt, if this
callback returns true, wake IRQ thread. Call
proc_thermal_wlt_intr_callback() to notify user space.

While here remove function pkg_thermal_schedule_work() and move the
processing to the caller. The function pkg_thermal_schedule_work() just
called schedule_delayed_work().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device_pci.c            | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index edddebedf42e..7fa5c3d459bd 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -115,27 +115,40 @@ static void proc_thermal_threshold_work_fn(struct work_struct *work)
 	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 1);
 }
 
-static void pkg_thermal_schedule_work(struct delayed_work *work)
+static irqreturn_t proc_thermal_irq_thread_handler(int irq, void *devid)
 {
-	unsigned long ms = msecs_to_jiffies(notify_delay_ms);
+	struct proc_thermal_pci *pci_info = devid;
+
+	proc_thermal_wlt_intr_callback(pci_info->pdev, pci_info->proc_priv);
 
-	schedule_delayed_work(work, ms);
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 {
 	struct proc_thermal_pci *pci_info = devid;
+	struct proc_thermal_device *proc_priv;
+	int ret = IRQ_HANDLED;
 	u32 status;
 
+	proc_priv = pci_info->proc_priv;
+
+	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_WLT_HINT) {
+		if (proc_thermal_check_wlt_intr(pci_info->proc_priv))
+			ret = IRQ_WAKE_THREAD;
+	}
+
 	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_INT_STATUS_0, &status);
+	if (status) {
+		unsigned long ms = msecs_to_jiffies(notify_delay_ms);
 
-	/* Disable enable interrupt flag */
-	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		/* Disable enable interrupt flag */
+		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
+		schedule_delayed_work(&pci_info->work, ms);
+	}
 	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
 
-	pkg_thermal_schedule_work(&pci_info->work);
-
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
@@ -269,7 +282,7 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					proc_thermal_irq_handler, NULL,
+					proc_thermal_irq_handler, proc_thermal_irq_thread_handler,
 					irq_flag, KBUILD_MODNAME, pci_info);
 	if (ret) {
 		dev_err(&pdev->dev, "Request IRQ %d failed\n", pdev->irq);
@@ -383,6 +396,8 @@ static struct pci_driver proc_thermal_pci_driver = {
 
 module_pci_driver(proc_thermal_pci_driver);
 
+MODULE_IMPORT_NS(INT340X_THERMAL);
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_DESCRIPTION("Processor Thermal Reporting Device Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.38.1

