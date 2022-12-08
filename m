Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72C96472A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLHPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLHPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD530AD322
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A0061F6B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01708C433C1;
        Thu,  8 Dec 2022 15:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512461;
        bh=2WxFtwBQLkQ7axHemveXVhRJxDTNuVv+k1voETl0tvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJ2oMSez+bqd/xc+Z5Bdljg6g0YLWQx5lVGG0mKlgLd2VNZziEemhGLWZrLzelAOM
         UhbtlLtDV66S7qCiNHF4PV139NBMd8X/MuHuYQWf9Hqy5iMmtBv725XtOHxizhvoKp
         aVFL7ppuyR3xiAbH4t6/qkRgzSPRMgQ1uKhrH7FFFYNr09HpTsCSD7xqK0VgcX7cpe
         QrXHmEQQaeH/x4CvRRJSt6N6s3JNT12tQPGzRr+3j5doEvEMiWe097VEMbOKOYfpIW
         IqrQ1QsNL5lYyxyGdUFabhGKZXxj7F1vXsd1+EBX/IMHHFXV3Wd5WIJwFvYacSbE51
         nH+M3ZheXBI7g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 20/26] habanalabs: helper function to validate export params
Date:   Thu,  8 Dec 2022 17:13:44 +0200
Message-Id: <20221208151350.1833823-20-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Validate export parameters in a dedicated function instead of in the
main export flow.
This will be useful later when support to export dmabuf for devices
with virtual memory will be added.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 79 ++++++++++++++-----------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 864a8a1c6067..e3b2e882b037 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1797,36 +1797,10 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	return rc;
 }
 
-/**
- * export_dmabuf_from_addr() - export a dma-buf object for the given memory
- *                             address and size.
- * @ctx: pointer to the context structure.
- * @device_addr:  device memory physical address.
- * @size: size of device memory.
- * @flags: DMA-BUF file/FD flags.
- * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
- *
- * Create and export a dma-buf object for an existing memory allocation inside
- * the device memory, and return a FD which is associated with the dma-buf
- * object.
- *
- * Return: 0 on success, non-zero for failure.
- */
-static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
-					u64 size, int flags, int *dmabuf_fd)
+static int validate_export_params(struct hl_device *hdev, u64 device_addr, u64 size)
 {
-	struct hl_dmabuf_priv *hl_dmabuf;
-	struct hl_device *hdev = ctx->hdev;
-	struct asic_fixed_properties *prop;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 bar_address;
-	int rc;
-
-	prop = &hdev->asic_prop;
-
-	if (prop->dram_supports_virtual_memory) {
-		dev_dbg(hdev->dev, "Export not supported for devices with virtual memory\n");
-		return -EOPNOTSUPP;
-	}
 
 	if (!IS_ALIGNED(device_addr, PAGE_SIZE)) {
 		dev_dbg(hdev->dev,
@@ -1843,26 +1817,61 @@ static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
 	}
 
 	if (device_addr < prop->dram_user_base_address ||
-				device_addr + size > prop->dram_end_address ||
-				device_addr + size < device_addr) {
+				(device_addr + size) > prop->dram_end_address ||
+				(device_addr + size) < device_addr) {
 		dev_dbg(hdev->dev,
 			"DRAM memory range 0x%llx (+0x%llx) is outside of DRAM boundaries\n",
 			device_addr, size);
 		return -EINVAL;
 	}
 
-	bar_address = hdev->dram_pci_bar_start +
-			(device_addr - prop->dram_base_address);
+	bar_address = hdev->dram_pci_bar_start + (device_addr - prop->dram_base_address);
 
-	if (bar_address + size >
-			hdev->dram_pci_bar_start + prop->dram_pci_bar_size ||
-			bar_address + size < bar_address) {
+	if ((bar_address + size) > (hdev->dram_pci_bar_start + prop->dram_pci_bar_size) ||
+			(bar_address + size) < bar_address) {
 		dev_dbg(hdev->dev,
 			"DRAM memory range 0x%llx (+0x%llx) is outside of PCI BAR boundaries\n",
 			device_addr, size);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+/**
+ * export_dmabuf_from_addr() - export a dma-buf object for the given memory
+ *                             address and size.
+ * @ctx: pointer to the context structure.
+ * @device_addr:  device memory physical address.
+ * @size: size of device memory.
+ * @flags: DMA-BUF file/FD flags.
+ * @dmabuf_fd: pointer to result FD that represents the dma-buf object.
+ *
+ * Create and export a dma-buf object for an existing memory allocation inside
+ * the device memory, and return a FD which is associated with the dma-buf
+ * object.
+ *
+ * Return: 0 on success, non-zero for failure.
+ */
+static int export_dmabuf_from_addr(struct hl_ctx *ctx, u64 device_addr,
+					u64 size, int flags, int *dmabuf_fd)
+{
+	struct hl_dmabuf_priv *hl_dmabuf;
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop;
+	int rc;
+
+	prop = &hdev->asic_prop;
+
+	if (prop->dram_supports_virtual_memory) {
+		dev_dbg(hdev->dev, "Export not supported for devices with virtual memory\n");
+		return -EOPNOTSUPP;
+	}
+
+	rc = validate_export_params(hdev, device_addr, size);
+	if (rc)
+		return rc;
+
 	hl_dmabuf = kzalloc(sizeof(*hl_dmabuf), GFP_KERNEL);
 	if (!hl_dmabuf)
 		return -ENOMEM;
-- 
2.25.1

