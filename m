Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5BF5BBD9D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIRLhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C309EE1D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288846124F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8380C433C1;
        Sun, 18 Sep 2022 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501042;
        bh=zW+TqlWobocCauRMtZDH8hILpO5AU1suHWhiqm/dHzM=;
        h=From:To:Cc:Subject:Date:From;
        b=PQ5neLHc0JN/Fnc6Gn7diByLfiCPgsvaNMU5/ZrLWiA3yps9EEZbnsFu4iPWAGo7k
         aRggzayZjsW3uWOrrOzMdk2yIjHyxbvcDDMcbB/LwjQRQszw9o4fMBwfkBHTSeciKO
         a8puWMgpJPz15M0Ua0TNBICzzUlZpnI+e+zcXHMyK5u3Vk5/bdBRFXohnwD9wXhmo3
         /+9cPAlFudqMGVdv5KbbQx74bMkEkl0RbTV9AWOBSz3xKu9FC+WNYCbURPYSQ58DfY
         risxjolkrVECIPz5Ye/KgTnzmjqzvy8Rp/fPngCqKRyY43ji0TTrzpE0+53MXZvndk
         t6gvUQjHP2o0A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/7] habanalabs/gaudi2: print RAZWI info upon PCIe access error
Date:   Sun, 18 Sep 2022 14:37:11 +0300
Message-Id: <20220918113717.2637094-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Tomer Tayar <ttayar@habana.ai>

Add the dump of the RAZWI information when a PCIe access is blocked by
RR.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 52 +++++++++++++++++--
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h | 13 +++++
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 5761ca5d50ae..c040e01adafe 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -7963,14 +7963,58 @@ static void gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_
 						gaudi2_dma_core_interrupts_cause[i]);
 }
 
+static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev)
+{
+	u32 mstr_if_base_addr = mmPCIE_MSTR_RR_MSTR_IF_RR_SHRD_HBW_BASE, razwi_happened_addr;
+
+	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED;
+	if (RREG32(razwi_happened_addr)) {
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
+							NULL);
+		WREG32(razwi_happened_addr, 0x1);
+	}
+
+	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED;
+	if (RREG32(razwi_happened_addr)) {
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
+							NULL);
+		WREG32(razwi_happened_addr, 0x1);
+	}
+
+	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED;
+	if (RREG32(razwi_happened_addr)) {
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
+							NULL);
+		WREG32(razwi_happened_addr, 0x1);
+	}
+
+	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED;
+	if (RREG32(razwi_happened_addr)) {
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
+							NULL);
+		WREG32(razwi_happened_addr, 0x1);
+	}
+}
+
 static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data)
 {
 	int i;
 
-	for (i = 0 ; i < GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE; i++)
-		if (intr_cause_data & BIT_ULL(i))
-			dev_err_ratelimited(hdev->dev, "PCIE ADDR DEC Error: %s\n",
-						gaudi2_pcie_addr_dec_error_cause[i]);
+	for (i = 0 ; i < GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE ; i++) {
+		if (!(intr_cause_data & BIT_ULL(i)))
+			continue;
+
+		dev_err_ratelimited(hdev->dev, "PCIE ADDR DEC Error: %s\n",
+					gaudi2_pcie_addr_dec_error_cause[i]);
+
+		switch (intr_cause_data & BIT_ULL(i)) {
+		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK:
+			break;
+		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK:
+			gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev);
+			break;
+		}
+	}
 }
 
 static void gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
index 0239d118abc5..e9ac87828221 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
@@ -144,4 +144,17 @@
 #define DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_SIGN_SHIFT	15
 #define DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_SIGN_MASK		0x8000
 
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_ERR_INTR_SHIFT		0
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_ERR_INTR_MASK		0x1
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_SHIFT		1
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK		0x2
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_SHIFT		2
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK		0x4
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_ERR_INTR_MASK_SHIFT		3
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_ERR_INTR_MASK_MASK		0x8
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK_SHIFT	4
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK_MASK	0x10
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK_SHIFT	5
+#define PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK_MASK	0x20
+
 #endif /* GAUDI2_MASKS_H_ */
-- 
2.25.1

