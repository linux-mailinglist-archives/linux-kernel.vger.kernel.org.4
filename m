Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A954661750
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjAHRVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjAHRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90329BF4B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A276B80B7E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52EC433EF;
        Sun,  8 Jan 2023 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198452;
        bh=14eFSMY196yPRCSdL+kW9LHjDjZZT/1qGfHxuhoGW4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfEWmNaouyxqKBWkgba/zjgd/HiZw94QqOYpa/ejUPifjb0w61TKn0PYvN5XfgCdA
         o7ETBIIPiwlAZO/DeiEfVEkZlHKavutMOEAY8sLzBFJnSwyKHZtouYM9lu7D6C4HQp
         E0XVdNLlCsfMS7XUQdSgI5DcEKIEnNBIGmepM9gtt3IQY9Qs3QJ7A355lrXm8iVSIP
         PyZwin3VZVgakHhpNf6qco7p777f9TryKopNCPiNjYzJhdMQDO/fmhYauUbJwo0CoE
         NjtVwkbegG4PCLCNsBk3K/Ed2Q1yIOb7vAs3CmLohsAHte7sxw+X7sQSI6WM0eXQPL
         q3OHZxyhnn1cQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 6/7] habanalabs/gaudi2: remove use of razwi info received from f/w
Date:   Sun,  8 Jan 2023 19:20:39 +0200
Message-Id: <20230108172040.3991204-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108172040.3991204-1-ogabbay@kernel.org>
References: <20230108172040.3991204-1-ogabbay@kernel.org>
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

Because f/w does not update razwi info when sending events, remove the
use of it.
The driver is responsible to check if razwi happened and to
collect razwi data.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 193 +++++++----------------
 1 file changed, 57 insertions(+), 136 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 503a52db203f..2b5cd058f5ad 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7081,7 +7081,6 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, u16 event_type
 
 static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
-			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
 			enum gaudi2_engine_id id, u64 *event_mask)
 {
 	u32 razwi_hi, razwi_lo, razwi_xy;
@@ -7089,26 +7088,14 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 	u8 rd_wr_flag;
 
 	if (is_write) {
-		if (read_razwi_regs) {
-			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HI);
-			razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_LO);
-			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_XY);
-		} else {
-			razwi_hi = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_hi_reg);
-			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_lo_reg);
-			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_aw_razwi_id_reg);
-		}
+		razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HI);
+		razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_LO);
+		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_WRITE;
 	} else {
-		if (read_razwi_regs) {
-			razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HI);
-			razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_LO);
-			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_XY);
-		} else {
-			razwi_hi = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_hi_reg);
-			razwi_lo = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_lo_reg);
-			razwi_xy = le32_to_cpu(razwi_info->hbw.rr_ar_razwi_id_reg);
-		}
+		razwi_hi = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HI);
+		razwi_lo = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_LO);
+		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_READ;
 	}
 
@@ -7122,7 +7109,6 @@ static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
 
 static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
-			bool read_razwi_regs, struct hl_eq_razwi_info *razwi_info,
 			enum gaudi2_engine_id id, u64 *event_mask)
 {
 	u32 razwi_addr, razwi_xy;
@@ -7130,24 +7116,12 @@ static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 	u8 rd_wr_flag;
 
 	if (is_write) {
-		if (read_razwi_regs) {
-			razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI);
-			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_XY);
-		} else {
-			razwi_addr = le32_to_cpu(razwi_info->lbw.rr_aw_razwi_reg);
-			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_aw_razwi_id_reg);
-		}
-
+		razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI);
+		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_WRITE;
 	} else {
-		if (read_razwi_regs) {
-			razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
-			razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_XY);
-		} else {
-			razwi_addr = le32_to_cpu(razwi_info->lbw.rr_ar_razwi_reg);
-			razwi_xy = le32_to_cpu(razwi_info->lbw.rr_ar_razwi_id_reg);
-		}
-
+		razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
+		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_READ;
 	}
 
@@ -7208,19 +7182,15 @@ static enum gaudi2_engine_id gaudi2_razwi_calc_engine_id(struct hl_device *hdev,
  */
 static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				enum razwi_event_sources module, u8 module_idx,
-				u8 module_sub_idx, struct hl_eq_razwi_info *razwi_info,
-				u64 *event_mask)
+				u8 module_sub_idx, u64 *event_mask)
 {
-	bool via_sft = false, read_razwi_regs = false;
+	bool via_sft = false;
 	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
 	u64 rtr_mstr_if_base_addr;
 	u32 hbw_shrd_aw = 0, hbw_shrd_ar = 0;
 	u32 lbw_shrd_aw = 0, lbw_shrd_ar = 0;
 	char initiator_name[64];
 
-	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX) || !razwi_info)
-		read_razwi_regs = true;
-
 	switch (module) {
 	case RAZWI_TPC:
 		rtr_id = gaudi2_tpc_initiator_rtr_id[module_idx];
@@ -7286,23 +7256,6 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		return;
 	}
 
-	if (!read_razwi_regs) {
-		if (le32_to_cpu(razwi_info->razwi_happened_mask) & RAZWI_HAPPENED_HBW) {
-			hbw_shrd_aw = le32_to_cpu(razwi_info->razwi_happened_mask) &
-								RAZWI_HAPPENED_AW;
-			hbw_shrd_ar = le32_to_cpu(razwi_info->razwi_happened_mask) &
-								RAZWI_HAPPENED_AR;
-		} else if (le32_to_cpu(razwi_info->razwi_happened_mask) & RAZWI_HAPPENED_LBW) {
-			lbw_shrd_aw = le32_to_cpu(razwi_info->razwi_happened_mask) &
-								RAZWI_HAPPENED_AW;
-			lbw_shrd_ar = le32_to_cpu(razwi_info->razwi_happened_mask) &
-								RAZWI_HAPPENED_AR;
-		}
-		rtr_mstr_if_base_addr = 0;
-
-		goto dump_info;
-	}
-
 	/* Find router mstr_if register base */
 	if (via_sft) {
 		rtr_mstr_if_base_addr = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE +
@@ -7320,7 +7273,6 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	/* Find out event cause by reading "RAZWI_HAPPENED" registers */
 	hbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED);
-
 	hbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED);
 
 	if (via_sft) {
@@ -7333,58 +7285,43 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				RTR_LBW_MSTR_IF_OFFSET;
 
 		lbw_shrd_aw = RREG32(base + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
-
 		lbw_shrd_ar = RREG32(base + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
 	} else {
 		lbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
-
 		lbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
 	}
 
-dump_info:
-	/* check if there is no RR razwi indication at all */
-	if (!hbw_shrd_aw && !hbw_shrd_ar && !lbw_shrd_aw && !lbw_shrd_ar)
-		return;
-
 	eng_id = gaudi2_razwi_calc_engine_id(hdev, module, module_idx);
 	if (hbw_shrd_aw) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
-						initiator_name, read_razwi_regs, razwi_info,
-						eng_id, event_mask);
+						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		if (read_razwi_regs)
-			WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED, hbw_shrd_aw);
+		WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED, hbw_shrd_aw);
 	}
 
 	if (hbw_shrd_ar) {
 		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
-						initiator_name, read_razwi_regs, razwi_info,
-						eng_id, event_mask);
+						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		if (read_razwi_regs)
-			WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED, hbw_shrd_ar);
+		WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED, hbw_shrd_ar);
 	}
 
 	if (lbw_shrd_aw) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
-						initiator_name, read_razwi_regs, razwi_info,
-						eng_id, event_mask);
+						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		if (read_razwi_regs)
-			WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED, lbw_shrd_aw);
+		WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED, lbw_shrd_aw);
 	}
 
 	if (lbw_shrd_ar) {
 		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
-						initiator_name, read_razwi_regs, razwi_info,
-						eng_id, event_mask);
+						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		if (read_razwi_regs)
-			WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED, lbw_shrd_ar);
+		WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED, lbw_shrd_ar);
 	}
 }
 
@@ -7396,42 +7333,38 @@ static void gaudi2_check_if_razwi_happened(struct hl_device *hdev)
 	/* check all TPCs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1) ; mod_idx++) {
 		if (prop->tpc_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, mod_idx, 0, NULL,
-								NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, mod_idx, 0, NULL);
 	}
 
 	/* check all MMEs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_MME_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
 		for (sub_mod = MME_WAP0 ; sub_mod < MME_INITIATORS_MAX ; sub_mod++)
 			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mod_idx,
-									sub_mod, NULL, NULL);
+									sub_mod, NULL);
 
 	/* check all EDMAs */
 	for (mod_idx = 0 ; mod_idx < (NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES) ; mod_idx++)
 		if (prop->edma_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, mod_idx, 0, NULL,
-								NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, mod_idx, 0, NULL);
 
 	/* check all PDMAs */
 	for (mod_idx = 0 ; mod_idx < NUM_OF_PDMA ; mod_idx++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, mod_idx, 0, NULL,
-							NULL);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_PDMA, mod_idx, 0, NULL);
 
 	/* check all NICs */
 	for (mod_idx = 0 ; mod_idx < NIC_NUMBER_OF_PORTS ; mod_idx++)
 		if (hdev->nic_ports_mask & BIT(mod_idx))
 			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_NIC, mod_idx >> 1, 0,
-								NULL, NULL);
+								NULL);
 
 	/* check all DECs */
 	for (mod_idx = 0 ; mod_idx < NUMBER_OF_DEC ; mod_idx++)
 		if (prop->decoder_enabled_mask & BIT(mod_idx))
-			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, mod_idx, 0, NULL,
-								NULL);
+			gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, mod_idx, 0, NULL);
 
 	/* check all ROTs */
 	for (mod_idx = 0 ; mod_idx < NUM_OF_ROT ; mod_idx++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL, NULL);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, mod_idx, 0, NULL);
 }
 
 static const char *gaudi2_get_initiators_name(u32 rtr_id)
@@ -7818,7 +7751,7 @@ static int _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base, u16
 }
 
 static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
-					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
+					bool extended_err_check, u64 *event_mask)
 {
 	enum razwi_event_sources module;
 	u32 error_count = 0;
@@ -7871,9 +7804,9 @@ static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 		error_count += _gaudi2_handle_qm_sei_err(hdev,
 					qman_base + NIC_QM_OFFSET, event_type);
 
-	/* check if RAZWI happened */
-	if (razwi_info)
-		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, razwi_info, event_mask);
+	if (extended_err_check)
+		/* check if RAZWI happened */
+		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, event_mask);
 
 	return error_count;
 }
@@ -8042,8 +7975,7 @@ static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index, u16 event
 		}
 
 	/* check if RAZWI happened */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0,
-						&razwi_with_intr_cause->razwi_info, event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0, event_mask);
 
 	return error_count;
 }
@@ -8064,14 +7996,13 @@ static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, u16
 		}
 
 	/* check if RAZWI happened */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0,
-						&razwi_with_intr_cause->razwi_info, event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0, event_mask);
 
 	return error_count;
 }
 
 static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, u16 event_type,
-				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
+					u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_val = 0, error_count = 0;
 	int i;
@@ -8098,8 +8029,7 @@ static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, u16 event
 	}
 
 	/* check if RAZWI happened */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, razwi_info,
-						event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, event_mask);
 
 	/* Write 1 clear errors */
 	WREG32(sts_addr, sts_clr_val);
@@ -8108,7 +8038,7 @@ static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, u16 event
 }
 
 static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, u16 event_type,
-				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
+					u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
 	int i;
@@ -8129,8 +8059,7 @@ static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, u16 event
 
 	/* check if RAZWI happened */
 	for (i = MME_WRITE ; i < MME_INITIATORS_MAX ; i++)
-		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, razwi_info,
-							event_mask);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
 
@@ -8153,7 +8082,7 @@ static int gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u16 event_type,
 }
 
 static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index, u16 event_type,
-					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
+					u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
 	int i;
@@ -8173,10 +8102,8 @@ static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index, u16 e
 	}
 
 	/* check if RAZWI happened on WAP0/1 */
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, razwi_info,
-						event_mask);
-	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, razwi_info,
-						event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, event_mask);
+	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
 
@@ -8226,29 +8153,29 @@ static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev,
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
-		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE",
+							GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
-		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE",
+							GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
-		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, true, "PCIE",
+							GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 
 	razwi_happened_addr = mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED;
 	if (RREG32(razwi_happened_addr)) {
-		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE", true,
-							NULL, GAUDI2_ENGINE_ID_PCIE, event_mask);
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, mstr_if_base_addr, false, "PCIE",
+							GAUDI2_ENGINE_ID_PCIE, event_mask);
 		WREG32(razwi_happened_addr, 0x1);
 	}
 }
@@ -8912,8 +8839,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		error_count = gaudi2_handle_qm_sei_err(hdev, event_type,
-					&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_qm_sei_err(hdev, event_type, true, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8922,7 +8848,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
 		error_count = gaudi2_handle_rot_err(hdev, index, event_type,
 					&eq_entry->razwi_with_intr_cause, &event_mask);
-		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, false, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8930,14 +8856,13 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
 		error_count = gaudi2_tpc_ack_interrupts(hdev, index, event_type,
 						&eq_entry->razwi_with_intr_cause, &event_mask);
-		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, false, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
 		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
-		error_count = gaudi2_handle_dec_err(hdev, index, event_type,
-						&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_dec_err(hdev, index, event_type, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8985,8 +8910,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC9_SPI:
 		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
 				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
-		error_count = gaudi2_handle_dec_err(hdev, index, event_type,
-					&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_dec_err(hdev, index, event_type, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8997,9 +8921,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE) /
 				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
 						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
-		error_count = gaudi2_handle_mme_err(hdev, index, event_type,
-				&eq_entry->razwi_info, &event_mask);
-		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count = gaudi2_handle_mme_err(hdev, index, event_type, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, false, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9010,8 +8933,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_QMAN_SW_ERROR) /
 				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
 					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
-		error_count = gaudi2_handle_mme_err(hdev, index, event_type,
-					&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_mme_err(hdev, index, event_type, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9022,8 +8944,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID) /
 				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
 					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
-		error_count = gaudi2_handle_mme_wap_err(hdev, index, event_type,
-					&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_mme_wap_err(hdev, index, event_type, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
-- 
2.25.1

