Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783DE62E16D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiKQQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiKQQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE913F0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEA562182
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB13C433D7;
        Thu, 17 Nov 2022 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702004;
        bh=kniXMxMunVGn+b5VvGM5SGMCPfwaKUpmjcCLPd93UXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjSiHVAlP9UCtEhhf1LX0Yc9P7xFDy8UzjdXn6ukPn3a+fOhIVCVnj86CHQ8kjpsv
         PEh2D4jyV1UU+aMgDgxIUur3JRzztYamztT4cAJKAzIs/0bBmK8pLeVS8SwbO4wOo9
         h/ZKQPGd94LnX7CiuLzPuYoF+++sLKCk+0KqUItI+4YafL9Dp+IESyW/wuKqVehKnM
         UcOLZN37HbBkvq/az1cBBJqezVnSZcBOA5qNWLD23F0xFlbtJJ7V+li36gIqzgDEPR
         i+KRi8ux22MfdgSajvKR7q8pxAbnMYHcn8gbpJhpIxsS9kxXH7cuAS16ZeH1qHHJXx
         9TwHCzcl0S/lw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 06/20] habanalabs/gaudi2: add razwi notify event
Date:   Thu, 17 Nov 2022 18:19:37 +0200
Message-Id: <20221117161951.845454-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
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

Each time razwi (read-only zero, write ignored) event happens, besides
capturing its data, also notify the user about it.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c |   4 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 140 +++++++++++++-----------
 2 files changed, 82 insertions(+), 62 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 31818121ef4d..708db0f48ee0 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2414,7 +2414,9 @@ void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_o
 			u8 flags, u64 *event_mask)
 {
 	hl_capture_razwi(hdev, addr, engine_id, num_of_engines, flags);
-	*event_mask |= HL_NOTIFIER_EVENT_RAZWI;
+
+	if (event_mask)
+		*event_mask |= HL_NOTIFIER_EVENT_RAZWI;
 }
 
 static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 77bdbab41e6c..59940c8df2d2 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -7063,7 +7063,7 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
 			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
-			enum gaudi2_engine_id id)
+			enum gaudi2_engine_id id, u64 *event_mask)
 {
 	u32 razwi_hi, razwi_lo, razwi_xy;
 	u16 eng_id = id;
@@ -7093,8 +7093,8 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 		rd_wr_flag = HL_RAZWI_READ;
 	}
 
-	hl_capture_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &eng_id, 1,
-				rd_wr_flag | HL_RAZWI_HBW);
+	hl_handle_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &eng_id, 1,
+				rd_wr_flag | HL_RAZWI_HBW, event_mask);
 
 	dev_err_ratelimited(hdev->dev,
 		"%s-RAZWI SHARED RR HBW %s error, address %#llx, Initiator coordinates 0x%x\n",
@@ -7104,7 +7104,7 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
 			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
-			enum gaudi2_engine_id id)
+			enum gaudi2_engine_id id, u64 *event_mask)
 {
 	u32 razwi_addr, razwi_xy;
 	u16 eng_id = id;
@@ -7132,7 +7132,7 @@ static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 		rd_wr_flag = HL_RAZWI_READ;
 	}
 
-	hl_capture_razwi(hdev, razwi_addr, &eng_id, 1, rd_wr_flag | HL_RAZWI_LBW);
+	hl_handle_razwi(hdev, razwi_addr, &eng_id, 1, rd_wr_flag | HL_RAZWI_LBW, event_mask);
 	dev_err_ratelimited(hdev->dev,
 				"%s-RAZWI SHARED RR LBW %s error, mstr_if 0x%llx, captured address 0x%x Initiator coordinates 0x%x\n",
 				name, is_write ? "WR" : "RD", rtr_mstr_if_base_addr, razwi_addr,
@@ -7189,7 +7189,8 @@ static enum gaudi2_engine_id gaudi2_razwi_calc_engine_id(struct hl_device *hdev,
  */
 static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				enum razwi_event_sources module, u8 module_idx,
-				u8 module_sub_idx, struct hl_eq_razwi_info *razwi_info)
+				u8 module_sub_idx, struct hl_eq_razwi_info *razwi_info,
+				u64 *event_mask)
 {
 	bool via_sft = false, read_razwi_regs = false;
 	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
@@ -7330,7 +7331,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	if (hbw_shrd_aw) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
 						initiator_name, read_razwi_regs, razwi_info,
-						eng_id);
+						eng_id, event_mask);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7340,7 +7341,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	if (hbw_shrd_ar) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
 						initiator_name, read_razwi_regs, razwi_info,
-						eng_id);
+						eng_id, event_mask);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7350,7 +7351,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	if (lbw_shrd_aw) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
 						initiator_name, read_razwi_regs, razwi_info,
-						eng_id);
+						eng_id, event_mask);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7360,7 +7361,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	if (lbw_shrd_ar) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
 						initiator_name, read_razwi_regs, razwi_info,
-						eng_id);
+						eng_id, event_mask);
 
 		/* Clear event indication */
 		if (read_razwi_regs)
@@ -7376,38 +7377,42 @@ static void gaudi2_check_if_razwi_happened(struct hl_device *hdev)
 	/* check all TPCs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1) ; mod_idx++) {
 		if (prop->tpc_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, mod_idx, 0, NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, mod_idx, 0, NULL,
+								NULL);
 	}
 
 	/* check all MMEs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_MME_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
 		for (sub_mod = MME_WAP0 ; sub_mod < MME_INITIATORS_MAX ; sub_mod++)
 			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mod_idx,
-								sub_mod, NULL);
+									sub_mod, NULL, NULL);
 
 	/* check all EDMAs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
 		if (prop->edma_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, mod_idx, 0, NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, mod_idx, 0, NULL,
+								NULL);
 
 	/* check all PDMAs */
 	for (mod_idx = 0 ; mod_idx < NUM_OF_PDMA ; mod_idx++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, mod_idx, 0, NULL);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, mod_idx, 0, NULL,
+							NULL);
 
 	/* check all NICs */
 	for (mod_idx = 0 ; mod_idx < NIC_NUMBER_OF_PORTS ; mod_idx++)
 		if (hdev->nic_ports_mask & BIT(mod_idx))
 			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_NIC, mod_idx >> 1, 0,
-								NULL);
+								NULL, NULL);
 
 	/* check all DECs */
 	for (mod_idx = 0 ; mod_idx < NUMBER_OF_DEC ; mod_idx++)
 		if (prop->decoder_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, mod_idx, 0, NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, mod_idx, 0, NULL,
+								NULL);
 
 	/* check all ROTs */
 	for (mod_idx = 0 ; mod_idx < NUM_OF_ROT ; mod_idx++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL, NULL);
 }
 
 static const char *gaudi2_get_initiators_name(u32 rtr_id)
@@ -7625,7 +7630,8 @@ static u16 gaudi2_get_razwi_initiators(u32 rtr_id, u16 *engines)
 }
 
 static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u32 rtr_id,
-							u64 rtr_ctrl_base_addr, bool is_write)
+							u64 rtr_ctrl_base_addr, bool is_write,
+							u64 *event_mask)
 {
 	u16 engines[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR], num_of_eng;
 	u32 razwi_hi, razwi_lo;
@@ -7649,8 +7655,8 @@ static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_HBW_AR_SET, 0x1);
 	}
 
-	hl_capture_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &engines[0], num_of_eng,
-				rd_wr_flag | HL_RAZWI_HBW);
+	hl_handle_razwi(hdev, (u64)razwi_hi << 32 | razwi_lo, &engines[0], num_of_eng,
+				rd_wr_flag | HL_RAZWI_HBW, event_mask);
 	dev_err_ratelimited(hdev->dev,
 		"RAZWI PSOC unmapped HBW %s error, rtr id %u, address %#llx\n",
 		is_write ? "WR" : "RD", rtr_id, (u64)razwi_hi << 32 | razwi_lo);
@@ -7660,7 +7666,8 @@ static void gaudi2_razwi_unmapped_addr_hbw_printf_info(struct hl_device *hdev, u
 }
 
 static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u32 rtr_id,
-							u64 rtr_ctrl_base_addr, bool is_write)
+							u64 rtr_ctrl_base_addr, bool is_write,
+							u64 *event_mask)
 {
 	u16 engines[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR], num_of_eng;
 	u32 razwi_addr;
@@ -7682,7 +7689,8 @@ static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_SET, 0x1);
 	}
 
-	hl_capture_razwi(hdev, razwi_addr, &engines[0], num_of_eng, rd_wr_flag | HL_RAZWI_LBW);
+	hl_handle_razwi(hdev, razwi_addr, &engines[0], num_of_eng, rd_wr_flag | HL_RAZWI_LBW,
+			event_mask);
 	dev_err_ratelimited(hdev->dev,
 		"RAZWI PSOC unmapped LBW %s error, rtr id %u, address %#x\n",
 		is_write ? "WR" : "RD", rtr_id, razwi_addr);
@@ -7692,7 +7700,7 @@ static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u
 }
 
 /* PSOC RAZWI interrupt occurs only when trying to access a bad address */
-static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev)
+static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev, u64 *event_mask)
 {
 	u32 hbw_aw_set, hbw_ar_set, lbw_aw_set, lbw_ar_set, rtr_id, dcore_id, dcore_rtr_id, xy,
 								razwi_mask_info, razwi_intr = 0;
@@ -7746,19 +7754,19 @@ static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev)
 
 	if (hbw_aw_set)
 		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_id,
-						rtr_ctrl_base_addr, true);
+						rtr_ctrl_base_addr, true, event_mask);
 
 	if (hbw_ar_set)
 		gaudi2_razwi_unmapped_addr_hbw_printf_info(hdev, rtr_id,
-						rtr_ctrl_base_addr, false);
+						rtr_ctrl_base_addr, false, event_mask);
 
 	if (lbw_aw_set)
 		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_id,
-						rtr_ctrl_base_addr, true);
+						rtr_ctrl_base_addr, true, event_mask);
 
 	if (lbw_ar_set)
 		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_id,
-						rtr_ctrl_base_addr, false);
+						rtr_ctrl_base_addr, false, event_mask);
 
 clear:
 	/* Clear Interrupts only on pldm or if f/w doesn't handle interrupts */
@@ -7784,7 +7792,7 @@ static void _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
 }
 
 static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
-					struct hl_eq_razwi_info *razwi_info)
+					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	enum razwi_event_sources module;
 	u64 qman_base;
@@ -7837,7 +7845,7 @@ static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 
 	/* check if RAZWI happened */
 	if (razwi_info)
-		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, razwi_info);
+		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, razwi_info, event_mask);
 }
 
 static void gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
@@ -8003,7 +8011,8 @@ static void gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
 }
 
 static void gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
-					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause)
+					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
+					u64 *event_mask)
 {
 	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
 	int i;
@@ -8015,11 +8024,12 @@ static void gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0,
-						&razwi_with_intr_cause->razwi_info);
+						&razwi_with_intr_cause->razwi_info, event_mask);
 }
 
 static void gaudi2_tpc_ack_interrupts(struct hl_device *hdev, u8 tpc_index, char *interrupt_name,
-					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause)
+					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
+					u64 *event_mask)
 {
 	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
 	int i;
@@ -8031,11 +8041,11 @@ static void gaudi2_tpc_ack_interrupts(struct hl_device *hdev, u8 tpc_index, char
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0,
-						&razwi_with_intr_cause->razwi_info);
+						&razwi_with_intr_cause->razwi_info, event_mask);
 }
 
 static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const char *interrupt_name,
-				struct hl_eq_razwi_info *razwi_info)
+				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_val = 0;
 	int i;
@@ -8061,14 +8071,15 @@ static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const ch
 	}
 
 	/* check if RAZWI happened */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, razwi_info);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, razwi_info,
+						event_mask);
 
 	/* Write 1 clear errors */
 	WREG32(sts_addr, sts_clr_val);
 }
 
 static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const char *interrupt_name,
-				struct hl_eq_razwi_info *razwi_info)
+				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
 	int i;
@@ -8088,7 +8099,8 @@ static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const ch
 
 	/* check if RAZWI happened */
 	for (i = MME_WRITE ; i < MME_INITIATORS_MAX ; i++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, razwi_info);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, razwi_info,
+							event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
 }
@@ -8105,7 +8117,7 @@ static void gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u8 mme_index, u8
 }
 
 static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
-					struct hl_eq_razwi_info *razwi_info)
+					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
 	int i;
@@ -8125,8 +8137,10 @@ static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 	}
 
 	/* check if RAZWI happened on WAP0/1 */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, razwi_info);
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, razwi_info);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, razwi_info,
+						event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, razwi_info,
+						event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
 }
@@ -8156,40 +8170,41 @@ static void gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_
 						gaudi2_dma_core_interrupts_cause[i]);
 }
 
-static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev)
+static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev, u64 *event_mask)
 {
 	u32 mstr_if_base_addr = mmPCIE_MSTR_RR_MSTR_IF_RR_SHRD_HBW_BASE, razwi_happened_addr;
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE);
+							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE);
+							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE);
+							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE);
+							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 }
 
-static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data)
+static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data,
+						u64 *event_mask)
 {
 	int i;
 
@@ -8204,7 +8219,7 @@ static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cau
 		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK:
 			break;
 		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK:
-			gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev);
+			gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev, event_mask);
 			break;
 		}
 	}
@@ -8818,29 +8833,30 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		gaudi2_handle_qm_sei_err(hdev, event_type, &eq_entry->razwi_info);
+		gaudi2_handle_qm_sei_err(hdev, event_type, &eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
 	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
-		gaudi2_handle_rot_err(hdev, index, &eq_entry->razwi_with_intr_cause);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+		gaudi2_handle_rot_err(hdev, index, &eq_entry->razwi_with_intr_cause, &event_mask);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
 		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
 		gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
-						&eq_entry->razwi_with_intr_cause);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+						&eq_entry->razwi_with_intr_cause, &event_mask);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
 		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
-		gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE", &eq_entry->razwi_info);
+		gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE", &eq_entry->razwi_info,
+					&event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8871,7 +8887,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_TPC24_KERNEL_ERR:
 		index = (event_type - GAUDI2_EVENT_TPC0_KERNEL_ERR) /
 			(GAUDI2_EVENT_TPC1_KERNEL_ERR - GAUDI2_EVENT_TPC0_KERNEL_ERR);
-		gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR", &eq_entry->razwi_with_intr_cause);
+		gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR", &eq_entry->razwi_with_intr_cause,
+						&event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8887,7 +8904,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC9_SPI:
 		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
 				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
-		gaudi2_handle_dec_err(hdev, index, "SPI", &eq_entry->razwi_info);
+		gaudi2_handle_dec_err(hdev, index, "SPI", &eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8899,8 +8916,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
 						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
 		gaudi2_handle_mme_err(hdev, index,
-				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL);
+				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info, &event_mask);
+		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8911,7 +8928,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_QMAN_SW_ERROR) /
 				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
 					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
-		gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR", &eq_entry->razwi_info);
+		gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR", &eq_entry->razwi_info,
+					&event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8922,7 +8940,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID) /
 				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
 					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
-		gaudi2_handle_mme_wap_err(hdev, index, &eq_entry->razwi_info);
+		gaudi2_handle_mme_wap_err(hdev, index, &eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8941,7 +8959,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
 		gaudi2_print_pcie_addr_dec_info(hdev,
-				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data), &event_mask);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
@@ -8970,7 +8988,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_PSOC63_RAZWI_OR_PID_MIN_MAX_INTERRUPT:
-		gaudi2_ack_psoc_razwi_event_handler(hdev);
+		gaudi2_ack_psoc_razwi_event_handler(hdev, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
-- 
2.25.1

