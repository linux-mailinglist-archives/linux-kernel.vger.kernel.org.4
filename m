Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D9626052
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiKKRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiKKRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:18:44 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7C4D5E3;
        Fri, 11 Nov 2022 09:18:36 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHIPQZ081056;
        Fri, 11 Nov 2022 11:18:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668187105;
        bh=ECDL3sZx5BUYYCI2k/6ernjy/NSdgpC69pPfs/90DWo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=scWPUFRkcjttQ6j29ThrYa7LaXXHjQJ9e9PImFPMHlWPeDihkNje3R7fIdxlhynUt
         PkEg/PUk5pqxE0oyP9W91Ro4bJx/jndyHE070bRZ3RDTZhk8Zh6pZu/LJHuQNQwTxu
         UZzSZcQ8V+sVYtdd7dt9hkXa0e6UCJ2nQmuSJTMs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ABHIP7A057132
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Nov 2022 11:18:25 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 11
 Nov 2022 11:18:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 11 Nov 2022 11:18:25 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHHewb028454;
        Fri, 11 Nov 2022 11:18:18 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v3 4/5] firmware: ti_sci: Use dt provided fw name and address to load at suspend time
Date:   Fri, 11 Nov 2022 19:17:38 +0200
Message-ID: <20221111171739.160693-5-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111171739.160693-1-g-vlaev@ti.com>
References: <20221111171739.160693-1-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Use request_firmware_direct to load the fs stub LPM firmware to a
provided memory region. The filename for the firmware is provided
in the device tree as "firmware-name".

Use a pm_notifier for loading of the low power firmware during
PM_SUSPEND_PREPARE phase so that it can be loaded from the rootfs
before it is suspended. It is possible in the future for this
firmware to require reload, so add a check to indicate that the
firmware is currently loaded so it is only loaded once.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2434cf1ec5e6..a961506dbbc4 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/firmware.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -22,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -89,10 +91,13 @@ struct ti_sci_desc {
  * @dev:	Device pointer
  * @desc:	SoC description for this instance
  * @nb:	Reboot Notifier block
+ * @pm_nb:	PM notifier block
  * @d:		Debugfs file entry
  * @debug_region: Memory region where the debug message are available
  * @debug_region_size: Debug region size
  * @debug_buffer: Buffer allocated to copy debug messages.
+ * @lpm_region: Memory region where the FS Stub LPM Firmware will be stored
+ * @lpm_region_size: LPM region size
  * @handle:	Instance of TI SCI handle to send to clients.
  * @cl:		Mailbox Client
  * @chan_tx:	Transmit mailbox channel
@@ -104,15 +109,20 @@ struct ti_sci_desc {
  * @ctx_mem_buf: Low power context memory buffer
  * @users:	Number of users of this instance
  * @is_suspending: Flag set to indicate in suspend path.
+ * @lpm_firmware_loaded: Flag to indicate if LPM firmware has been loaded
+ * @lpm_firmware_name: Name of firmware binary to load from fw search path
  */
 struct ti_sci_info {
 	struct device *dev;
 	struct notifier_block nb;
+	struct notifier_block pm_nb;
 	const struct ti_sci_desc *desc;
 	struct dentry *d;
 	void __iomem *debug_region;
 	char *debug_buffer;
 	size_t debug_region_size;
+	void __iomem *lpm_region;
+	size_t lpm_region_size;
 	struct ti_sci_handle handle;
 	struct mbox_client cl;
 	struct mbox_chan *chan_tx;
@@ -125,11 +135,14 @@ struct ti_sci_info {
 	/* protected by ti_sci_list_mutex */
 	int users;
 	bool is_suspending;
+	bool lpm_firmware_loaded;
+	const char *lpm_firmware_name;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
 #define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
+#define pm_nb_to_ti_sci_info(n) container_of(n, struct ti_sci_info, pm_nb)
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -3465,6 +3478,32 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
+static int ti_sci_load_lpm_firmware(struct device *dev, struct ti_sci_info *info)
+{
+	const struct firmware *firmware;
+	int ret = 0;
+
+	/* If no firmware name is set, do not attempt to load. */
+	if (!info->lpm_firmware_name)
+		return -EINVAL;
+
+	ret = request_firmware_direct(&firmware, info->lpm_firmware_name, dev);
+	if (ret) {
+		dev_warn(dev, "Cannot load %s\n", info->lpm_firmware_name);
+		return ret;
+	}
+
+	if (firmware->size > info->lpm_region_size) {
+		release_firmware(firmware);
+		return -ENOMEM;
+	}
+
+	memcpy_toio(info->lpm_region, firmware->data, firmware->size);
+
+	release_firmware(firmware);
+
+	return ret;
+}
 static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspending)
 {
 	info->is_suspending = is_suspending;
@@ -3494,10 +3533,33 @@ static int ti_sci_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
 
+static int tisci_pm_handler(struct notifier_block *nb, unsigned long pm_event,
+			    void *unused)
+{
+	struct ti_sci_info *info = pm_nb_to_ti_sci_info(nb);
+	int ret;
+
+	/* Load the LPM firmware on PM_SUSPEND_PREPARE if not loaded yet */
+	if (pm_event != PM_SUSPEND_PREPARE || info->lpm_firmware_loaded)
+		return NOTIFY_DONE;
+
+	ret = ti_sci_load_lpm_firmware(info->dev, info);
+	if (ret) {
+		dev_err(info->dev, "Failed to LPM firmware, suspend is disabled (%d)\n",
+			ret);
+		return NOTIFY_BAD;
+	}
+
+	info->lpm_firmware_loaded = true;
+
+	return NOTIFY_OK;
+}
+
 static int ti_sci_init_suspend(struct platform_device *pdev,
 			       struct ti_sci_info *info)
 {
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	int ret;
 
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
@@ -3521,6 +3583,38 @@ static int ti_sci_init_suspend(struct platform_device *pdev,
 	if (ret)
 		goto err;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpm");
+	if (!res) {
+		dev_warn(dev,
+			 "lpm region is required for suspend but not provided.\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	info->lpm_region = devm_ioremap_resource(dev, res);
+	if (IS_ERR(info->lpm_region)) {
+		ret = PTR_ERR(info->lpm_region);
+		goto err;
+	}
+	info->lpm_region_size = resource_size(res);
+
+	if (of_property_read_string(dev->of_node, "firmware-name",
+				    &info->lpm_firmware_name)) {
+		dev_warn(dev,
+			 "firmware-name is required for suspend but not provided.\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	info->pm_nb.notifier_call = tisci_pm_handler;
+	info->pm_nb.priority = 128;
+
+	ret = register_pm_notifier(&info->pm_nb);
+	if (ret) {
+		dev_err(dev, "pm_notifier registration fail(%d)\n", ret);
+		goto err;
+	}
+
 	return 0;
 err:
 	dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,
@@ -3718,6 +3812,9 @@ static int ti_sci_remove(struct platform_device *pdev)
 
 	info = platform_get_drvdata(pdev);
 
+	if (info->pm_nb.notifier_call)
+		unregister_pm_notifier(&info->pm_nb);
+
 	if (info->nb.notifier_call)
 		unregister_restart_handler(&info->nb);
 
-- 
2.30.2

