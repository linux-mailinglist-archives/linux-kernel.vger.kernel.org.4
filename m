Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2463AA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiK1OGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiK1OGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:06:06 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471EF20BDC;
        Mon, 28 Nov 2022 06:06:05 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE5wFB044432;
        Mon, 28 Nov 2022 08:05:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669644358;
        bh=7jkAENbaGQCGj8274ocsGwp0BivC0m9EFpVsZaWJ+lw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HWxYgAwnlxvn6a2iqF74VwkwYDzy2xLuiVXxA+LvdYu24l6xb0vGGgvPNZPZsE+Nk
         jEwF4dTIj12E76fxi3d5T8G9GsTBB1hlbV+9t5U4M6KoY7xd/5OEQvci6iNS/AzX+6
         tug/oix7YFyuHrfHxvZ2SV/o6sDP7DUr12f9ugfg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ASE5wYp023854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Nov 2022 08:05:58 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 28
 Nov 2022 08:05:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 28 Nov 2022 08:05:57 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE5NQd125815;
        Mon, 28 Nov 2022 08:05:52 -0600
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
Subject: [PATCH v5 4/6] firmware: ti_sci: Allocate memory for the LPM modes
Date:   Mon, 28 Nov 2022 16:05:20 +0200
Message-ID: <20221128140522.49474-5-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128140522.49474-1-g-vlaev@ti.com>
References: <20221128140522.49474-1-g-vlaev@ti.com>
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

A region of memory in DDR must be used during Deep Sleep for saving
of some system context when using the ti_sci firmware. From DM's point
of view, this can be any contiguous region in the DDR, so can allocate
512KB of DMA reserved memory in probe(), instead of another carveout.

Also send a TISCI_MSG_QUERY_FW_CAPS message to the firmware during
probe to determine if any low power modes are supported and if
ti_sci_init_suspend should be called based on the response received.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index caa7b9d2bd48..b49d81527e29 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -25,6 +26,9 @@
 
 #include "ti_sci.h"
 
+/* Low power mode memory context size */
+#define LPM_CTX_MEM_SIZE 0x80000
+
 /* List of all TI SCI devices active in system */
 static LIST_HEAD(ti_sci_list);
 /* Protection for the entire list */
@@ -96,6 +100,9 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @ctx_mem_addr: Low power context memory phys address
+ * @ctx_mem_buf: Low power context memory buffer
+ * @fw_caps:	FW/SoC low power capabilities
  * @users:	Number of users of this instance
  * @is_suspending: Flag set to indicate in suspend path.
  */
@@ -114,6 +121,9 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	dma_addr_t ctx_mem_addr;
+	void *ctx_mem_buf;
+	u64 fw_caps;
 	/* protected by ti_sci_list_mutex */
 	int users;
 	bool is_suspending;
@@ -3543,6 +3553,23 @@ static int ti_sci_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
 
+static int ti_sci_init_suspend(struct platform_device *pdev,
+			       struct ti_sci_info *info)
+{
+	struct device *dev = &pdev->dev;
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	info->ctx_mem_buf = dma_alloc_coherent(info->dev, LPM_CTX_MEM_SIZE,
+					       &info->ctx_mem_addr,
+					       GFP_KERNEL);
+	if (!info->ctx_mem_buf) {
+		dev_err(info->dev, "Failed to allocate LPM context memory\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3695,6 +3722,15 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * Check if the firmware supports any optional low power modes
+	 * and initialize them if present. Old revisions of TIFS (< 08.04)
+	 * will NACK the request.
+	 */
+	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
+	if (!ret && (info->fw_caps & MSG_MASK_CAPS_LPM))
+		ti_sci_init_suspend(pdev, info);
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3742,6 +3778,10 @@ static int ti_sci_remove(struct platform_device *pdev)
 		mbox_free_channel(info->chan_rx);
 	}
 
+	if (info->ctx_mem_buf)
+		dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,
+				  info->ctx_mem_buf,
+				  info->ctx_mem_addr);
 	return ret;
 }
 
-- 
2.30.2

