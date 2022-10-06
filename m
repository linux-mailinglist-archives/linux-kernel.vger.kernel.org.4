Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D75F6288
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJFIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiJFIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB929258B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A10CB8203D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A6FC433D6;
        Thu,  6 Oct 2022 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044607;
        bh=xtRoap7m/qmwX/T6G4L1xqMycLnl/tt6JCoeLYQ6/rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE68Wkfhy0BSjCWU6n99MqijIUZz/FCjoBONY9GFYb6F52rsE2B1WU+top3djXnaS
         pFREDpjEqgRfzAOzNrrbZfg9fRveLkPWQZ+hcQS4my4QE/Ic042InPMxyLCHtzeLqW
         E1NmEhtH3Zrc6BjpCkEzGkuHUiPNihTQg4zic1YkUUVUWaiQjfdpdnCnhrPZFizi5B
         qH+WzzmsYP9xHjTyGAeGd2dYburpWQ0bQKOktmna3omFCpxn+dag+VYnNybnJNlIUm
         V+ztu/vWE1LHPl0Hy6idRi1uDPSLlofA7s2CneSqcsN7gY4NByqKxFxFZlUbS+o6yS
         TR/sE0gTQCogg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 11/13] habanalabs/gaudi2: capture RAZWI information
Date:   Thu,  6 Oct 2022 11:23:06 +0300
Message-Id: <20221006082308.1266716-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Added function to calculate possible engines which caused
RAZWI (read-only zero, write ignored), from a given router id or
module index.

When getting RAZWI via PSOC IP, first the router id is calculated
and then the possible engines that caused the RAZWI are calculated.

There is a possibility that the RAZWI initiator is not an engine. In
that case, it will not be included in possible engines as it
doesn't have an engine id.

RAZWI information is captured when receiving event from engine or via
PSOC IP.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 255 ++++++++++++++++++++++--
 include/uapi/misc/habanalabs.h          |   4 +
 2 files changed, 242 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index e05ffaa047a2..13a5356f1ec3 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -128,6 +128,8 @@
 #define GAUDI2_VDEC_MSIX_ENTRIES		(GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM - \
 							GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM + 1)
 
+#define ENGINE_ID_DCORE_OFFSET (GAUDI2_DCORE1_ENGINE_ID_EDMA_0 - GAUDI2_DCORE0_ENGINE_ID_EDMA_0)
+
 enum hl_pmmu_fatal_cause {
 	LATENCY_RD_OUT_FIFO_OVERRUN,
 	LATENCY_WR_OUT_FIFO_OVERRUN,
@@ -7092,9 +7094,12 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 
 static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
-			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info)
+			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
+			enum gaudi2_engine_id id)
 {
 	u32 razwi_hi, razwi_lo, razwi_xy;
+	u16 eng_id = id;
+	u8 rd_wr_flag;
 
 	if (is_write) {
 		if (read_razwi_regs) {
@@ -7106,6 +7111,7 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_lo_reg);
 			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_id_reg);
 		}
+		rd_wr_flag = HL_RAZWI_WRITE;
 	} else {
 		if (read_razwi_regs) {
 			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HI);
@@ -7116,8 +7122,12 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_lo_reg);
 			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_id_reg);
 		}
+		rd_wr_flag = HL_RAZWI_READ;
 	}
 
+	hl_capture_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &eng_id, 1,
+				rd_wr_flag | HL_RAZWI_HBW);
+
 	dev_err_ratelimited(hdev->dev,
 		"%s-RAZWI SHARED RR HBW %s error, address %#llx, Initiator coordinates 0x%x\n",
 		name, is_write ? "WR" : "RD", (u64)razwi_hi << 32 | razwi_lo, razwi_xy);
@@ -7125,9 +7135,12 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 
 static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
-			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info)
+			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
+			enum gaudi2_engine_id id)
 {
 	u32 razwi_addr, razwi_xy;
+	u16 eng_id = id;
+	u8 rd_wr_flag;
 
 	if (is_write) {
 		if (read_razwi_regs) {
@@ -7138,9 +7151,7 @@ static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_aw_razwi_id_reg);
 		}
 
-		dev_err_ratelimited(hdev->dev,
-			"%s-RAZWI SHARED RR LBW WR error, mstr_if 0x%llx, captured address 0x%x, Initiator coordinates 0x%x\n",
-			name, rtr_mstr_if_base_addr, razwi_addr, razwi_xy);
+		rd_wr_flag = HL_RAZWI_WRITE;
 	} else {
 		if (read_razwi_regs) {
 			razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
@@ -7150,9 +7161,57 @@ static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_ar_razwi_id_reg);
 		}
 
-		dev_err_ratelimited(hdev->dev,
-			"%s-RAZWI SHARED RR LBW AR error, mstr_if 0x%llx, captured address 0x%x Initiator coordinates 0x%x\n",
-			name, rtr_mstr_if_base_addr, razwi_addr, razwi_xy);
+		rd_wr_flag = HL_RAZWI_READ;
+	}
+
+	hl_capture_razwi(hdev, razwi_addr, &eng_id, 1, rd_wr_flag | HL_RAZWI_LBW);
+	dev_err_ratelimited(hdev->dev,
+				"%s-RAZWI SHARED RR LBW %s error, mstr_if 0x%llx, captured address 0x%x Initiator coordinates 0x%x\n",
+				name, is_write ? "WR" : "RD", rtr_mstr_if_base_addr, razwi_addr,
+						razwi_xy);
+}
+
+static enum gaudi2_engine_id gaudi2_razwi_calc_engine_id(struct hl_device *hdev,
+						enum razwi_event_sources module, u8 module_idx)
+{
+	switch (module) {
+	case RAZWI_TPC:
+		if (module_idx == (NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES))
+			return GAUDI2_DCORE0_ENGINE_ID_TPC_6;
+		return (((module_idx / NUM_OF_TPC_PER_DCORE) * ENGINE_ID_DCORE_OFFSET) +
+				(module_idx % NUM_OF_TPC_PER_DCORE) +
+				(GAUDI2_DCORE0_ENGINE_ID_TPC_0 - GAUDI2_DCORE0_ENGINE_ID_EDMA_0));
+
+	case RAZWI_MME:
+		return ((GAUDI2_DCORE0_ENGINE_ID_MME - GAUDI2_DCORE0_ENGINE_ID_EDMA_0) +
+			(module_idx * ENGINE_ID_DCORE_OFFSET));
+
+	case RAZWI_EDMA:
+		return (((module_idx / NUM_OF_EDMA_PER_DCORE) * ENGINE_ID_DCORE_OFFSET) +
+			(module_idx % NUM_OF_EDMA_PER_DCORE));
+
+	case RAZWI_PDMA:
+		return (GAUDI2_ENGINE_ID_PDMA_0 + module_idx);
+
+	case RAZWI_NIC:
+		return (GAUDI2_ENGINE_ID_NIC0_0 + (NIC_NUMBER_OF_QM_PER_MACRO * module_idx));
+
+	case RAZWI_DEC:
+		if (module_idx == 8)
+			return GAUDI2_PCIE_ENGINE_ID_DEC_0;
+
+		if (module_idx == 9)
+			return GAUDI2_PCIE_ENGINE_ID_DEC_1;
+					;
+		return (((module_idx / NUM_OF_DEC_PER_DCORE) * ENGINE_ID_DCORE_OFFSET) +
+				(module_idx % NUM_OF_DEC_PER_DCORE) +
+				(GAUDI2_DCORE0_ENGINE_ID_DEC_0 - GAUDI2_DCORE0_ENGINE_ID_EDMA_0));
+
+	case RAZWI_ROT:
+		return GAUDI2_ENGINE_ID_ROT_0 + module_idx;
+
+	default:
+		return GAUDI2_ENGINE_ID_SIZE;
 	}
 }
 
@@ -7165,7 +7224,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				u8 module_sub_idx, struct hl_eq_razwi_info *razwi_info)
 {
 	bool via_sft = false, read_razwi_regs = false;
-	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id;
+	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
 	u64 rtr_mstr_if_base_addr;
 	u32 hbw_shrd_aw = 0, hbw_shrd_ar = 0;
 	u32 lbw_shrd_aw = 0, lbw_shrd_ar = 0;
@@ -7299,9 +7358,11 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	if (!hbw_shrd_aw && !hbw_shrd_ar && !lbw_shrd_aw && !lbw_shrd_ar)
 		return;
 
+	eng_id = gaudi2_razwi_calc_engine_id(hdev, module, module_idx);
 	if (hbw_shrd_aw) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
-						initiator_name, read_razwi_regs, razwi_info);
+						initiator_name, read_razwi_regs, razwi_info,
+						eng_id);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7310,7 +7371,8 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	if (hbw_shrd_ar) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
-						initiator_name, read_razwi_regs, razwi_info);
+						initiator_name, read_razwi_regs, razwi_info,
+						eng_id);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7319,7 +7381,8 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	if (lbw_shrd_aw) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
-						initiator_name, read_razwi_regs, razwi_info);
+						initiator_name, read_razwi_regs, razwi_info,
+						eng_id);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7328,7 +7391,8 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	if (lbw_shrd_ar) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
-						initiator_name, read_razwi_regs, razwi_info);
+						initiator_name, read_razwi_regs, razwi_info,
+						eng_id);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7450,25 +7514,175 @@ static const char *gaudi2_get_initiators_name(u32 rtr_id)
 	}
 }
 
+static u16 gaudi2_get_razwi_initiators(u32 rtr_id, u16 *engines)
+{
+	switch (rtr_id) {
+	case DCORE0_RTR0:
+		engines[0] = GAUDI2_DCORE0_ENGINE_ID_DEC_0;
+		engines[1] = GAUDI2_DCORE0_ENGINE_ID_DEC_1;
+		engines[2] = GAUDI2_PCIE_ENGINE_ID_DEC_0;
+		engines[3] = GAUDI2_PCIE_ENGINE_ID_DEC_1;
+		engines[4] = GAUDI2_DCORE0_ENGINE_ID_TPC_6;
+		engines[5] = GAUDI2_ENGINE_ID_PDMA_0;
+		engines[6] = GAUDI2_ENGINE_ID_PDMA_1;
+		engines[7] = GAUDI2_ENGINE_ID_PCIE;
+		engines[8] = GAUDI2_DCORE0_ENGINE_ID_EDMA_0;
+		engines[9] = GAUDI2_DCORE1_ENGINE_ID_EDMA_0;
+		engines[10] = GAUDI2_ENGINE_ID_PSOC;
+		return 11;
+
+	case DCORE0_RTR1:
+		engines[0] = GAUDI2_DCORE0_ENGINE_ID_TPC_0;
+		engines[1] = GAUDI2_DCORE0_ENGINE_ID_TPC_1;
+		return 2;
+
+	case DCORE0_RTR2:
+		engines[0] = GAUDI2_DCORE0_ENGINE_ID_TPC_2;
+		engines[1] = GAUDI2_DCORE0_ENGINE_ID_TPC_3;
+		return 2;
+
+	case DCORE0_RTR3:
+		engines[0] = GAUDI2_DCORE0_ENGINE_ID_TPC_4;
+		engines[1] = GAUDI2_DCORE0_ENGINE_ID_TPC_5;
+		return 2;
+
+	case DCORE0_RTR4:
+	case DCORE0_RTR5:
+	case DCORE0_RTR6:
+	case DCORE0_RTR7:
+		engines[0] = GAUDI2_DCORE0_ENGINE_ID_MME;
+		return 1;
+
+	case DCORE1_RTR0:
+	case DCORE1_RTR1:
+	case DCORE1_RTR2:
+	case DCORE1_RTR3:
+		engines[0] = GAUDI2_DCORE1_ENGINE_ID_MME;
+		return 1;
+
+	case DCORE1_RTR4:
+		engines[0] = GAUDI2_DCORE1_ENGINE_ID_TPC_4;
+		engines[1] = GAUDI2_DCORE1_ENGINE_ID_TPC_5;
+		return 2;
+
+	case DCORE1_RTR5:
+		engines[0] = GAUDI2_DCORE1_ENGINE_ID_TPC_2;
+		engines[1] = GAUDI2_DCORE1_ENGINE_ID_TPC_3;
+		return 2;
+
+	case DCORE1_RTR6:
+		engines[0] = GAUDI2_DCORE1_ENGINE_ID_TPC_0;
+		engines[1] = GAUDI2_DCORE1_ENGINE_ID_TPC_1;
+		return 2;
+
+	case DCORE1_RTR7:
+		engines[0] = GAUDI2_DCORE1_ENGINE_ID_DEC_0;
+		engines[1] = GAUDI2_DCORE1_ENGINE_ID_DEC_1;
+		engines[2] = GAUDI2_ENGINE_ID_NIC0_0;
+		engines[3] = GAUDI2_ENGINE_ID_NIC1_0;
+		engines[4] = GAUDI2_ENGINE_ID_NIC2_0;
+		engines[5] = GAUDI2_ENGINE_ID_NIC3_0;
+		engines[6] = GAUDI2_ENGINE_ID_NIC4_0;
+		engines[7] = GAUDI2_ENGINE_ID_ARC_FARM;
+		engines[8] = GAUDI2_ENGINE_ID_KDMA;
+		engines[9] = GAUDI2_DCORE0_ENGINE_ID_EDMA_1;
+		engines[10] = GAUDI2_DCORE1_ENGINE_ID_EDMA_1;
+		return 11;
+
+	case DCORE2_RTR0:
+		engines[0] = GAUDI2_DCORE2_ENGINE_ID_DEC_0;
+		engines[1] = GAUDI2_DCORE2_ENGINE_ID_DEC_1;
+		engines[2] = GAUDI2_ENGINE_ID_NIC5_0;
+		engines[3] = GAUDI2_ENGINE_ID_NIC6_0;
+		engines[4] = GAUDI2_ENGINE_ID_NIC7_0;
+		engines[5] = GAUDI2_ENGINE_ID_NIC8_0;
+		engines[6] = GAUDI2_DCORE2_ENGINE_ID_EDMA_0;
+		engines[7] = GAUDI2_DCORE3_ENGINE_ID_EDMA_0;
+		engines[8] = GAUDI2_ENGINE_ID_ROT_0;
+		return 9;
+
+	case DCORE2_RTR1:
+		engines[0] = GAUDI2_DCORE2_ENGINE_ID_TPC_4;
+		engines[1] = GAUDI2_DCORE2_ENGINE_ID_TPC_5;
+		return 2;
+
+	case DCORE2_RTR2:
+		engines[0] = GAUDI2_DCORE2_ENGINE_ID_TPC_2;
+		engines[1] = GAUDI2_DCORE2_ENGINE_ID_TPC_3;
+		return 2;
+
+	case DCORE2_RTR3:
+		engines[0] = GAUDI2_DCORE2_ENGINE_ID_TPC_0;
+		engines[1] = GAUDI2_DCORE2_ENGINE_ID_TPC_1;
+		return 2;
+
+	case DCORE2_RTR4:
+	case DCORE2_RTR5:
+	case DCORE2_RTR6:
+	case DCORE2_RTR7:
+		engines[0] = GAUDI2_DCORE2_ENGINE_ID_MME;
+		return 1;
+	case DCORE3_RTR0:
+	case DCORE3_RTR1:
+	case DCORE3_RTR2:
+	case DCORE3_RTR3:
+		engines[0] = GAUDI2_DCORE3_ENGINE_ID_MME;
+		return 1;
+	case DCORE3_RTR4:
+		engines[0] = GAUDI2_DCORE3_ENGINE_ID_TPC_0;
+		engines[1] = GAUDI2_DCORE3_ENGINE_ID_TPC_1;
+		return 2;
+	case DCORE3_RTR5:
+		engines[0] = GAUDI2_DCORE3_ENGINE_ID_TPC_2;
+		engines[1] = GAUDI2_DCORE3_ENGINE_ID_TPC_3;
+		return 2;
+	case DCORE3_RTR6:
+		engines[0] = GAUDI2_DCORE3_ENGINE_ID_TPC_4;
+		engines[1] = GAUDI2_DCORE3_ENGINE_ID_TPC_5;
+		return 2;
+	case DCORE3_RTR7:
+		engines[0] = GAUDI2_DCORE3_ENGINE_ID_DEC_0;
+		engines[1] = GAUDI2_DCORE3_ENGINE_ID_DEC_1;
+		engines[2] = GAUDI2_ENGINE_ID_NIC9_0;
+		engines[3] = GAUDI2_ENGINE_ID_NIC10_0;
+		engines[4] = GAUDI2_ENGINE_ID_NIC11_0;
+		engines[5] = GAUDI2_DCORE2_ENGINE_ID_EDMA_1;
+		engines[6] = GAUDI2_DCORE3_ENGINE_ID_EDMA_1;
+		engines[7] = GAUDI2_ENGINE_ID_ROT_1;
+		engines[8] = GAUDI2_ENGINE_ID_ROT_0;
+		return 9;
+	default:
+		return 0;
+	}
+}
+
 static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u32 rtr_id,
 							u64 rtr_ctrl_base_addr, bool is_write)
 {
+	u16 engines[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR], num_of_eng;
 	u32 razwi_hi, razwi_lo;
+	u8 rd_wr_flag;
+
+	num_of_eng = gaudi2_get_razwi_initiators(rtr_id, &engines[0]);
 
 	if (is_write) {
 		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_HI);
 		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_ADDR_LO);
+		rd_wr_flag = HL_RAZWI_WRITE;
 
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AW_SET, 0x1);
 	} else {
 		razwi_hi = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_HI);
 		razwi_lo = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_ADDR_LO);
+		rd_wr_flag = HL_RAZWI_READ;
 
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_SET, 0x1);
 	}
 
+	hl_capture_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &engines[0], num_of_eng,
+				rd_wr_flag | HL_RAZWI_HBW);
 	dev_err_ratelimited(hdev->dev,
 		"RAZWI PSOC unmapped HBW %s error, rtr id %u, address %#llx\n",
 		is_write ? "WR" : "RD", rtr_id, (u64)razwi_hi << 32 | razwi_lo);
@@ -7480,20 +7694,27 @@ static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u
 static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u32 rtr_id,
 							u64 rtr_ctrl_base_addr, bool is_write)
 {
+	u16 engines[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR], num_of_eng;
 	u32 razwi_addr;
+	u8 rd_wr_flag;
+
+	num_of_eng = gaudi2_get_razwi_initiators(rtr_id, &engines[0]);
 
 	if (is_write) {
 		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_ADDR);
+		rd_wr_flag = HL_RAZWI_WRITE;
 
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_SET, 0x1);
 	} else {
 		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_ADDR);
+		rd_wr_flag = HL_RAZWI_READ;
 
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET, 0x1);
 	}
 
+	hl_capture_razwi(hdev, razwi_addr, &engines[0], num_of_eng, rd_wr_flag | HL_RAZWI_LBW);
 	dev_err_ratelimited(hdev->dev,
 		"RAZWI PSOC unmapped LBW %s error, rtr id %u, address %#x\n",
 		is_write ? "WR" : "RD", rtr_id, razwi_addr);
@@ -7974,28 +8195,28 @@ static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev)
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL);
+							NULL, GAUDI2_ENGINE_ID_PCIE);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL);
+							NULL, GAUDI2_ENGINE_ID_PCIE);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL);
+							NULL, GAUDI2_ENGINE_ID_PCIE);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL);
+							NULL, GAUDI2_ENGINE_ID_PCIE);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 2b794f54e2ed..a4ceee681898 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -597,6 +597,10 @@ enum gaudi2_engine_id {
 	GAUDI2_ENGINE_ID_NIC10_1,
 	GAUDI2_ENGINE_ID_NIC11_0,
 	GAUDI2_ENGINE_ID_NIC11_1,
+	GAUDI2_ENGINE_ID_PCIE,
+	GAUDI2_ENGINE_ID_PSOC,
+	GAUDI2_ENGINE_ID_ARC_FARM,
+	GAUDI2_ENGINE_ID_KDMA,
 	GAUDI2_ENGINE_ID_SIZE
 };
 
-- 
2.25.1

