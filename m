Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065866B02B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjAOJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAOJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:40:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC813C179
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:40:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EB2CB80B2A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 09:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22F0C433D2;
        Sun, 15 Jan 2023 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673775636;
        bh=3t2zkoynPZsUuzR5ci1is44NBgCu33DbyzDhfJGzf4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWwgDn2aBsaVdNPtBOz5QFJCUKTYYDDzVtaoa295CRcjL4ghp24ILJadgTlbY0HdH
         6pA7ZpwRCgYDNEIEKDhjp3UL3pVQLrqkRXA7k+9jMnyKqE2BMPwRcJzQ91lDbo32Nd
         9DsZvSaXMN8xwuhXiPSRJpxlIrNixWjPy9Gd4wto4G67JOkjdLsckkSiWEm1QxfC9h
         oEUuRRFAq5g1KXXH9ID0SBVGmV0Uh9g5XKevH6siZu0qOKC5V8NDvBWLTJeYGmFZcq
         oR7SysbBf8EN8m/E1GU86nGQ01rOm/J5AAViUjnfaMDcWyFiXEwkAnukMHkypL+jNB
         pnrCsvR6UpIiA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 4/5] habanalabs/gaudi2: read mmio razwi information
Date:   Sun, 15 Jan 2023 11:40:25 +0200
Message-Id: <20230115094026.289766-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115094026.289766-1-ogabbay@kernel.org>
References: <20230115094026.289766-1-ogabbay@kernel.org>
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

In gaudi2 there night be different routers for low b/w and high b/w
transactions. But in the code that collects razwi information, we used
the same router for high b/w and low b/w.

Fixed it by reading the information also from low b/w routers.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 117 ++++++++++++++++-------
 1 file changed, 80 insertions(+), 37 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 2b5cd058f5ad..32a824766f24 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -1568,7 +1568,7 @@ enum rtr_id {
 	DCORE3_RTR7,
 };
 
-static const u32 gaudi2_tpc_initiator_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1] = {
+static const u32 gaudi2_tpc_initiator_hbw_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1] = {
 	DCORE0_RTR1, DCORE0_RTR1, DCORE0_RTR2, DCORE0_RTR2, DCORE0_RTR3, DCORE0_RTR3,
 	DCORE1_RTR6, DCORE1_RTR6, DCORE1_RTR5, DCORE1_RTR5, DCORE1_RTR4, DCORE1_RTR4,
 	DCORE2_RTR3, DCORE2_RTR3, DCORE2_RTR2, DCORE2_RTR2, DCORE2_RTR1, DCORE2_RTR1,
@@ -1576,12 +1576,30 @@ static const u32 gaudi2_tpc_initiator_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORE
 	DCORE0_RTR0
 };
 
-static const u32 gaudi2_dec_initiator_rtr_id[NUMBER_OF_DEC] = {
+static const u32 gaudi2_tpc_initiator_lbw_rtr_id[NUM_OF_TPC_PER_DCORE * NUM_OF_DCORES + 1] = {
+	DCORE0_RTR1, DCORE0_RTR1, DCORE0_RTR1, DCORE0_RTR1, DCORE0_RTR2, DCORE0_RTR2,
+	DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR6, DCORE1_RTR6, DCORE1_RTR5, DCORE1_RTR5,
+	DCORE2_RTR2, DCORE2_RTR2, DCORE2_RTR1, DCORE2_RTR1, DCORE2_RTR0, DCORE2_RTR0,
+	DCORE3_RTR5, DCORE3_RTR5, DCORE3_RTR6, DCORE3_RTR6, DCORE3_RTR7, DCORE3_RTR7,
+	DCORE0_RTR0
+};
+
+static const u32 gaudi2_dec_initiator_hbw_rtr_id[NUMBER_OF_DEC] = {
 	DCORE0_RTR0, DCORE0_RTR0, DCORE1_RTR7, DCORE1_RTR7, DCORE2_RTR0, DCORE2_RTR0,
 	DCORE3_RTR7, DCORE3_RTR7, DCORE0_RTR0, DCORE0_RTR0
 };
 
-static const u32 gaudi2_nic_initiator_rtr_id[NIC_NUMBER_OF_MACROS] = {
+static const u32 gaudi2_dec_initiator_lbw_rtr_id[NUMBER_OF_DEC] = {
+	DCORE0_RTR1, DCORE0_RTR1, DCORE1_RTR6, DCORE1_RTR6, DCORE2_RTR1, DCORE2_RTR1,
+	DCORE3_RTR6, DCORE3_RTR6, DCORE0_RTR0, DCORE0_RTR0
+};
+
+static const u32 gaudi2_nic_initiator_hbw_rtr_id[NIC_NUMBER_OF_MACROS] = {
+	DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE2_RTR0,
+	DCORE2_RTR0, DCORE2_RTR0, DCORE2_RTR0, DCORE3_RTR7, DCORE3_RTR7, DCORE3_RTR7
+};
+
+static const u32 gaudi2_nic_initiator_lbw_rtr_id[NIC_NUMBER_OF_MACROS] = {
 	DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE1_RTR7, DCORE2_RTR0,
 	DCORE2_RTR0, DCORE2_RTR0, DCORE2_RTR0, DCORE3_RTR7, DCORE3_RTR7, DCORE3_RTR7
 };
@@ -1595,14 +1613,22 @@ static const struct sft_info gaudi2_edma_initiator_sft_id[NUM_OF_EDMA_PER_DCORE
 	{0, 0},	{1, 0}, {0, 1}, {1, 1}, {1, 2}, {1, 3},	{0, 2},	{0, 3},
 };
 
-static const u32 gaudi2_pdma_initiator_rtr_id[NUM_OF_PDMA] = {
+static const u32 gaudi2_pdma_initiator_hbw_rtr_id[NUM_OF_PDMA] = {
 	DCORE0_RTR0, DCORE0_RTR0
 };
 
-static const u32 gaudi2_rot_initiator_rtr_id[NUM_OF_ROT] = {
+static const u32 gaudi2_pdma_initiator_lbw_rtr_id[NUM_OF_PDMA] = {
+	DCORE0_RTR2, DCORE0_RTR2
+};
+
+static const u32 gaudi2_rot_initiator_hbw_rtr_id[NUM_OF_ROT] = {
 	DCORE2_RTR0, DCORE3_RTR7
 };
 
+static const u32 gaudi2_rot_initiator_lbw_rtr_id[NUM_OF_ROT] = {
+	DCORE2_RTR2, DCORE3_RTR5
+};
+
 struct mme_initiators_rtr_id {
 	u32 wap0;
 	u32 wap1;
@@ -7185,50 +7211,60 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				u8 module_sub_idx, u64 *event_mask)
 {
 	bool via_sft = false;
-	u32 rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
-	u64 rtr_mstr_if_base_addr;
+	u32 hbw_rtr_id, lbw_rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
+	u64 hbw_rtr_mstr_if_base_addr, lbw_rtr_mstr_if_base_addr;
 	u32 hbw_shrd_aw = 0, hbw_shrd_ar = 0;
 	u32 lbw_shrd_aw = 0, lbw_shrd_ar = 0;
 	char initiator_name[64];
 
 	switch (module) {
 	case RAZWI_TPC:
-		rtr_id = gaudi2_tpc_initiator_rtr_id[module_idx];
+		hbw_rtr_id = gaudi2_tpc_initiator_hbw_rtr_id[module_idx];
+
+		/* TODO : remove this check and depend only on tpc routers table
+		 * when SW-118828 is resolved
+		 */
+		if (!hdev->asic_prop.fw_security_enabled &&
+				((module_idx == 0) || (module_idx == 1)))
+			lbw_rtr_id = DCORE0_RTR0;
+		else
+			lbw_rtr_id = gaudi2_tpc_initiator_lbw_rtr_id[module_idx];
 		sprintf(initiator_name, "TPC_%u", module_idx);
 		break;
 	case RAZWI_MME:
 		sprintf(initiator_name, "MME_%u", module_idx);
 		switch (module_sub_idx) {
 		case MME_WAP0:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap0;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap0;
 			break;
 		case MME_WAP1:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap1;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].wap1;
 			break;
 		case MME_WRITE:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].write;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].write;
 			break;
 		case MME_READ:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].read;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].read;
 			break;
 		case MME_SBTE0:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte0;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte0;
 			break;
 		case MME_SBTE1:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte1;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte1;
 			break;
 		case MME_SBTE2:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte2;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte2;
 			break;
 		case MME_SBTE3:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte3;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte3;
 			break;
 		case MME_SBTE4:
-			rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte4;
+			hbw_rtr_id = gaudi2_mme_initiator_rtr_id[module_idx].sbte4;
 			break;
 		default:
 			return;
 		}
+		lbw_rtr_id = hbw_rtr_id;
 		break;
 	case RAZWI_EDMA:
 		sft_id = gaudi2_edma_initiator_sft_id[module_idx].interface_id;
@@ -7237,19 +7273,23 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		sprintf(initiator_name, "EDMA_%u", module_idx);
 		break;
 	case RAZWI_PDMA:
-		rtr_id = gaudi2_pdma_initiator_rtr_id[module_idx];
+		hbw_rtr_id = gaudi2_pdma_initiator_hbw_rtr_id[module_idx];
+		lbw_rtr_id = gaudi2_pdma_initiator_lbw_rtr_id[module_idx];
 		sprintf(initiator_name, "PDMA_%u", module_idx);
 		break;
 	case RAZWI_NIC:
-		rtr_id = gaudi2_nic_initiator_rtr_id[module_idx];
+		hbw_rtr_id = gaudi2_nic_initiator_hbw_rtr_id[module_idx];
+		lbw_rtr_id = gaudi2_nic_initiator_lbw_rtr_id[module_idx];
 		sprintf(initiator_name, "NIC_%u", module_idx);
 		break;
 	case RAZWI_DEC:
-		rtr_id = gaudi2_dec_initiator_rtr_id[module_idx];
+		hbw_rtr_id = gaudi2_dec_initiator_hbw_rtr_id[module_idx];
+		lbw_rtr_id = gaudi2_dec_initiator_lbw_rtr_id[module_idx];
 		sprintf(initiator_name, "DEC_%u", module_idx);
 		break;
 	case RAZWI_ROT:
-		rtr_id = gaudi2_rot_initiator_rtr_id[module_idx];
+		hbw_rtr_id = gaudi2_rot_initiator_hbw_rtr_id[module_idx];
+		lbw_rtr_id = gaudi2_rot_initiator_lbw_rtr_id[module_idx];
 		sprintf(initiator_name, "ROT_%u", module_idx);
 		break;
 	default:
@@ -7258,22 +7298,25 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 
 	/* Find router mstr_if register base */
 	if (via_sft) {
-		rtr_mstr_if_base_addr = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE +
+		hbw_rtr_mstr_if_base_addr = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE +
 				dcore_id * SFT_DCORE_OFFSET +
 				sft_id * SFT_IF_OFFSET +
 				RTR_MSTR_IF_OFFSET;
+		lbw_rtr_mstr_if_base_addr = hbw_rtr_mstr_if_base_addr;
 	} else {
-		dcore_id = rtr_id / NUM_OF_RTR_PER_DCORE;
-		dcore_rtr_id = rtr_id % NUM_OF_RTR_PER_DCORE;
-		rtr_mstr_if_base_addr = mmDCORE0_RTR0_CTRL_BASE +
+		dcore_id = hbw_rtr_id / NUM_OF_RTR_PER_DCORE;
+		dcore_rtr_id = hbw_rtr_id % NUM_OF_RTR_PER_DCORE;
+		hbw_rtr_mstr_if_base_addr = mmDCORE0_RTR0_CTRL_BASE +
 				dcore_id * DCORE_OFFSET +
 				dcore_rtr_id * DCORE_RTR_OFFSET +
 				RTR_MSTR_IF_OFFSET;
+		lbw_rtr_mstr_if_base_addr = hbw_rtr_mstr_if_base_addr +
+				(((s32)lbw_rtr_id - hbw_rtr_id) * DCORE_RTR_OFFSET);
 	}
 
 	/* Find out event cause by reading "RAZWI_HAPPENED" registers */
-	hbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED);
-	hbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED);
+	hbw_shrd_aw = RREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED);
+	hbw_shrd_ar = RREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED);
 
 	if (via_sft) {
 		/* SFT has separate MSTR_IF for LBW, only there we can
@@ -7287,41 +7330,41 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		lbw_shrd_aw = RREG32(base + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
 		lbw_shrd_ar = RREG32(base + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
 	} else {
-		lbw_shrd_aw = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
-		lbw_shrd_ar = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
+		lbw_shrd_aw = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
+		lbw_shrd_ar = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
 	}
 
 	eng_id = gaudi2_razwi_calc_engine_id(hdev, module, module_idx);
 	if (hbw_shrd_aw) {
-		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, hbw_rtr_mstr_if_base_addr, true,
 						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED, hbw_shrd_aw);
+		WREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED, hbw_shrd_aw);
 	}
 
 	if (hbw_shrd_ar) {
-		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
+		gaudi2_razwi_rr_hbw_shared_printf_info(hdev, hbw_rtr_mstr_if_base_addr, false,
 						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		WREG32(rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED, hbw_shrd_ar);
+		WREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED, hbw_shrd_ar);
 	}
 
 	if (lbw_shrd_aw) {
-		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, true,
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, lbw_rtr_mstr_if_base_addr, true,
 						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED, lbw_shrd_aw);
+		WREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED, lbw_shrd_aw);
 	}
 
 	if (lbw_shrd_ar) {
-		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, rtr_mstr_if_base_addr, false,
+		gaudi2_razwi_rr_lbw_shared_printf_info(hdev, lbw_rtr_mstr_if_base_addr, false,
 						initiator_name, eng_id, event_mask);
 
 		/* Clear event indication */
-		WREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED, lbw_shrd_ar);
+		WREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED, lbw_shrd_ar);
 	}
 }
 
-- 
2.25.1

