Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A027377C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFTXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFTXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A2CD;
        Tue, 20 Jun 2023 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687302114; x=1718838114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0S2CzFuoa7jBPBYtjg///3v2rQKx+t10A4Zc3tSMGYc=;
  b=S3w55MnYTM29zs9q2Byq9GuQ8+20uM3ePuppvoKdUtS0dcqS2zWUSOdJ
   usQSKysVnRKkvlgc78i40vCIEHHRRJIY8sX3bXHXaDkhf1u5No99GniIo
   qMhqVakWLgKzwo0zUsQnG0Hm0ofxaNmUL4Mk3bqVUWkHapaqVKxwQd1ss
   +v3/xxRwaEDqFOQ/TletyLxOOVxP05KpOk+saV4v9SCZhLV4F0rUwj636
   7lajoHu4kXczV4kj9Wn+wlI2Ncav+l3EYfTJy15lheLF7GN/b3nGk9wTe
   XaiwmAyrHczp8LKyyoPJ4mdtYZ60V6A+H3HnEeFvgpAb6XukFMMxQ3aqn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340347277"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340347277"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044465318"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="1044465318"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 16:01:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/7] thermal: int340x: processor_thermal: Add interrupt configuration
Date:   Tue, 20 Jun 2023 16:01:45 -0700
Message-Id: <20230620230150.3068704-3-srinivas.pandruvada@linux.intel.com>
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

Some features on this PCI devices require interrupt support. Here
interrupts are enabled/disabled via sending mailbox commands. The
mailbox command ID is 0x1E for read and 0x1F for write.

The interrupt configuration will require mutex protection as it
involved read-modify-write operation. Since mutex are already used
in the mailbox read/write functions: send_mbox_write_cmd() and
send_mbox_read_cmd(), there will be double locking. But, this can
be avoided by moving mutexes from mailbox read/write processing
functions to the calling (exported) functions.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device.h                |  2 +
 .../int340x_thermal/processor_thermal_mbox.c  | 85 ++++++++++++++-----
 2 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
index 7cdeca2edc21..defc919cb020 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
@@ -91,6 +91,8 @@ void proc_thermal_wlt_req_remove(struct pci_dev *pdev);
 
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp);
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data);
+int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable, int enable_bit,
+					    int time_window);
 int proc_thermal_add(struct device *dev, struct proc_thermal_device *priv);
 void proc_thermal_remove(struct proc_thermal_device *proc_priv);
 int proc_thermal_suspend(struct device *dev);
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index ec766c5615b7..7ef0af3f5bef 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -45,23 +45,16 @@ static int send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data)
 	int ret;
 
 	proc_priv = pci_get_drvdata(pdev);
-
-	mutex_lock(&mbox_lock);
-
 	ret = wait_for_mbox_ready(proc_priv);
 	if (ret)
-		goto unlock_mbox;
+		return ret;
 
 	writel(data, (proc_priv->mmio_base + MBOX_OFFSET_DATA));
 	/* Write command register */
 	reg_data = BIT_ULL(MBOX_BUSY_BIT) | id;
 	writel(reg_data, (proc_priv->mmio_base + MBOX_OFFSET_INTERFACE));
 
-	ret = wait_for_mbox_ready(proc_priv);
-
-unlock_mbox:
-	mutex_unlock(&mbox_lock);
-	return ret;
+	return wait_for_mbox_ready(proc_priv);
 }
 
 static int send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp)
@@ -71,12 +64,9 @@ static int send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp)
 	int ret;
 
 	proc_priv = pci_get_drvdata(pdev);
-
-	mutex_lock(&mbox_lock);
-
 	ret = wait_for_mbox_ready(proc_priv);
 	if (ret)
-		goto unlock_mbox;
+		return ret;
 
 	/* Write command register */
 	reg_data = BIT_ULL(MBOX_BUSY_BIT) | id;
@@ -84,28 +74,85 @@ static int send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp)
 
 	ret = wait_for_mbox_ready(proc_priv);
 	if (ret)
-		goto unlock_mbox;
+		return ret;
 
 	if (id == MBOX_CMD_WORKLOAD_TYPE_READ)
 		*resp = readl(proc_priv->mmio_base + MBOX_OFFSET_DATA);
 	else
 		*resp = readq(proc_priv->mmio_base + MBOX_OFFSET_DATA);
 
-unlock_mbox:
-	mutex_unlock(&mbox_lock);
-	return ret;
+	return 0;
 }
 
 int processor_thermal_send_mbox_read_cmd(struct pci_dev *pdev, u16 id, u64 *resp)
 {
-	return send_mbox_read_cmd(pdev, id, resp);
+	int ret;
+
+	mutex_lock(&mbox_lock);
+	ret = send_mbox_read_cmd(pdev, id, resp);
+	mutex_unlock(&mbox_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(processor_thermal_send_mbox_read_cmd, INT340X_THERMAL);
 
 int processor_thermal_send_mbox_write_cmd(struct pci_dev *pdev, u16 id, u32 data)
 {
-	return send_mbox_write_cmd(pdev, id, data);
+	int ret;
+
+	mutex_lock(&mbox_lock);
+	ret = send_mbox_write_cmd(pdev, id, data);
+	mutex_unlock(&mbox_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(processor_thermal_send_mbox_write_cmd, INT340X_THERMAL);
 
+#define MBOX_CAMARILLO_RD_INTR_CONFIG	0x1E
+#define MBOX_CAMARILLO_WR_INTR_CONFIG	0x1F
+#define WLT_TW_MASK			GENMASK_ULL(30, 24)
+#define SOC_PREDICTION_TW_SHIFT		24
+
+int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable,
+					    int enable_bit, int time_window)
+{
+	u64 data;
+	int ret;
+
+	if (!pdev)
+		return -ENODEV;
+
+	mutex_lock(&mbox_lock);
+
+	/* Do read modify write for MBOX_CAMARILLO_RD_INTR_CONFIG */
+
+	ret = send_mbox_read_cmd(pdev, MBOX_CAMARILLO_RD_INTR_CONFIG,  &data);
+	if (ret) {
+		dev_err(&pdev->dev, "MBOX_CAMARILLO_RD_INTR_CONFIG failed\n");
+		goto unlock;
+	}
+
+	if (time_window >= 0) {
+		data &= ~WLT_TW_MASK;
+
+		/* Program notification delay */
+		data |= (time_window << SOC_PREDICTION_TW_SHIFT);
+	}
+
+	if (enable)
+		data |= BIT(enable_bit);
+	else
+		data &= ~BIT(enable_bit);
+
+	ret = send_mbox_write_cmd(pdev, MBOX_CAMARILLO_WR_INTR_CONFIG, data);
+	if (ret)
+		dev_err(&pdev->dev, "MBOX_CAMARILLO_WR_INTR_CONFIG failed\n");
+
+unlock:
+	mutex_unlock(&mbox_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(processor_thermal_mbox_interrupt_config, INT340X_THERMAL);
+
 MODULE_LICENSE("GPL v2");
-- 
2.38.1

