Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA19626050
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiKKRSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiKKRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:18:33 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE7DEAF;
        Fri, 11 Nov 2022 09:18:29 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHIKmP047612;
        Fri, 11 Nov 2022 11:18:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668187101;
        bh=5A/fv0J8rGB5ugYgRHRdXdNAUkqvodydSPXq5z7C8U4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g4MwM3seJVjMB0qTfV8Gd0xcP/+oJXDG+M11Eym11vNfpMa2di4oiZXqH5rN5Ochl
         qfon1C5zGsIpObijR8st23vZMjP3gCBOZkXZRRNnToNvaRrVBLfaFJkjV8pdyJ8IEr
         bqX7lKygkx058unhrWwodvWtQ2mnThBllNJchB68=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ABHIKSe095883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Nov 2022 11:18:20 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 11
 Nov 2022 11:18:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 11 Nov 2022 11:18:16 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ABHHewa028454;
        Fri, 11 Nov 2022 11:18:09 -0600
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
Subject: [PATCH v3 3/5] firmware: ti_sci: Allocate memory for the LPM modes
Date:   Fri, 11 Nov 2022 19:17:37 +0200
Message-ID: <20221111171739.160693-4-g-vlaev@ti.com>
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

A region of memory in DDR must be used during Deep Sleep for saving
of some system context when using the ti_sci firmware. From DM's point
of view, this can be any contiguous region in the DDR, so can allocate
512KB of DMA reserved memory in probe(), instead of another carveout.

Also send a TISCI_MSG_PREPARE_SUSPEND message to the firmware during
probe to determine if system suspend is supported and if
ti_sci_init_suspend should be called based on the response received.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/firmware/ti_sci.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index f13cf19587e3..2434cf1ec5e6 100644
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
@@ -96,6 +100,8 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @ctx_mem_addr: Low power context memory phys address
+ * @ctx_mem_buf: Low power context memory buffer
  * @users:	Number of users of this instance
  * @is_suspending: Flag set to indicate in suspend path.
  */
@@ -114,6 +120,8 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	dma_addr_t ctx_mem_addr;
+	void* ctx_mem_buf;
 	/* protected by ti_sci_list_mutex */
 	int users;
 	bool is_suspending;
@@ -3486,6 +3494,41 @@ static int ti_sci_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
 
+static int ti_sci_init_suspend(struct platform_device *pdev,
+			       struct ti_sci_info *info)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
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
+	/*
+	 * Attempt to call prepare_sleep, this will be NAK'd if suspend is not
+	 * supported by firmware in use, in which case we will not attempt to
+	 * init suspend.
+	 */
+	ret = ti_sci_cmd_prepare_sleep(&info->handle, 0,
+				       (u32)(info->ctx_mem_addr & 0xffffffff) ,
+				       (u32)((u64)info->ctx_mem_addr >> 32), 0);
+
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,
+			  info->ctx_mem_buf,
+			  info->ctx_mem_addr);
+	return ret;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3638,6 +3681,14 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = ti_sci_init_suspend(pdev, info);
+	if (ret)
+		dev_warn(dev,
+			 "ti_sci_init_suspend failed, mem suspend will be non-functional.\n");
+
+	/* Suspend is an optional feature, reset return value and continue. */
+	ret = 0;
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3685,6 +3736,10 @@ static int ti_sci_remove(struct platform_device *pdev)
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

