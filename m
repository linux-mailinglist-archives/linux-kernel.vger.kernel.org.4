Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145E5673599
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjASKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjASKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4946F316
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA5F6150E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ABCC433EF;
        Thu, 19 Jan 2023 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124429;
        bh=+X0kPgmVo1UmmvH/S0Wj1Uhi8UF00ALskJuTsOflvdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfR64zQNNZTtf6tz1uTrJQMArNTxCENgio7qzQzOWOuScLskOaggpgybGexqep78H
         yvIbus7N2BQOntKXvAauS/iKDvDHNejg00/gQAQdqR/0vw9IY9NjPIaDpjmNXVNxEB
         JTjAKV93fAuxs7tRYcgJaTKY9wBrM7hQiLgDgC/ZoqDvo7Zhb4bEzN6CioX7PjXZmd
         xZgmWkTPBIfTOBlAHA807I6+oAX+l16TQ+FE+lsIa3t3wr1uXLtAr/jgcataYh/qa/
         h7AOOvZbBaFZ3I4L/MxYtCJkb3FK7X5jj7IT+gp0O9gTY3Po7vMuwo6FLWygQfXL1z
         DPFdHJ6IrMpCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 04/10] habanalabs/gaudi2: fix emda range registers razwi handling
Date:   Thu, 19 Jan 2023 12:33:33 +0200
Message-Id: <20230119103339.718430-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
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

Handling edma razwi is different than all other engines since edma
uses sft routers. For hbw transactions sft router contain separate
interface for each edma and for lbw there is common interface for
both edma engines of the same dcore.

To handle the razwi correctly we need to:
1. Simplify the calculation of the sft router address.
2. Add razwi handling for edma qm errors, since edma qman doesn't
   reports axi error response.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 69 ++++++++++++------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 72e08c1eae22..80cd4413b87d 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -1604,13 +1604,15 @@ static const u32 gaudi2_nic_initiator_lbw_rtr_id[NIC_NUMBER_OF_MACROS] = {
 	DCORE2_RTR0, DCORE2_RTR0, DCORE2_RTR0, DCORE3_RTR7, DCORE3_RTR7, DCORE3_RTR7
 };
 
-struct sft_info {
-	u8 interface_id;
-	u8 dcore_id;
-};
-
-static const struct sft_info gaudi2_edma_initiator_sft_id[NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES] = {
-	{0, 0},	{1, 0}, {0, 1}, {1, 1}, {1, 2}, {1, 3},	{0, 2},	{0, 3},
+static const u32 gaudi2_edma_initiator_hbw_sft[NUM_OF_EDMA_PER_DCORE * NUM_OF_DCORES] = {
+	mmSFT0_HBW_RTR_IF1_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT0_HBW_RTR_IF0_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT1_HBW_RTR_IF1_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT1_HBW_RTR_IF0_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT2_HBW_RTR_IF0_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT2_HBW_RTR_IF1_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT3_HBW_RTR_IF0_MSTR_IF_RR_SHRD_HBW_BASE,
+	mmSFT3_HBW_RTR_IF1_MSTR_IF_RR_SHRD_HBW_BASE
 };
 
 static const u32 gaudi2_pdma_initiator_hbw_rtr_id[NUM_OF_PDMA] = {
@@ -7212,7 +7214,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 				u8 module_sub_idx, u64 *event_mask)
 {
 	bool via_sft = false;
-	u32 hbw_rtr_id, lbw_rtr_id, dcore_id, dcore_rtr_id, sft_id, eng_id;
+	u32 hbw_rtr_id, lbw_rtr_id, dcore_id, dcore_rtr_id, eng_id;
 	u64 hbw_rtr_mstr_if_base_addr, lbw_rtr_mstr_if_base_addr;
 	u32 hbw_shrd_aw = 0, hbw_shrd_ar = 0;
 	u32 lbw_shrd_aw = 0, lbw_shrd_ar = 0;
@@ -7268,8 +7270,13 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		lbw_rtr_id = hbw_rtr_id;
 		break;
 	case RAZWI_EDMA:
-		sft_id = gaudi2_edma_initiator_sft_id[module_idx].interface_id;
-		dcore_id = gaudi2_edma_initiator_sft_id[module_idx].dcore_id;
+		hbw_rtr_mstr_if_base_addr = gaudi2_edma_initiator_hbw_sft[module_idx];
+		dcore_id = module_idx / NUM_OF_EDMA_PER_DCORE;
+		/* SFT has separate MSTR_IF for LBW, only there we can
+		 * read the LBW razwi related registers
+		 */
+		lbw_rtr_mstr_if_base_addr = mmSFT0_LBW_RTR_IF_MSTR_IF_RR_SHRD_HBW_BASE +
+								dcore_id * SFT_DCORE_OFFSET;
 		via_sft = true;
 		sprintf(initiator_name, "EDMA_%u", module_idx);
 		break;
@@ -7298,13 +7305,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	}
 
 	/* Find router mstr_if register base */
-	if (via_sft) {
-		hbw_rtr_mstr_if_base_addr = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE +
-				dcore_id * SFT_DCORE_OFFSET +
-				sft_id * SFT_IF_OFFSET +
-				RTR_MSTR_IF_OFFSET;
-		lbw_rtr_mstr_if_base_addr = hbw_rtr_mstr_if_base_addr;
-	} else {
+	if (!via_sft) {
 		dcore_id = hbw_rtr_id / NUM_OF_RTR_PER_DCORE;
 		dcore_rtr_id = hbw_rtr_id % NUM_OF_RTR_PER_DCORE;
 		hbw_rtr_mstr_if_base_addr = mmDCORE0_RTR0_CTRL_BASE +
@@ -7318,22 +7319,8 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 	/* Find out event cause by reading "RAZWI_HAPPENED" registers */
 	hbw_shrd_aw = RREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AW_RAZWI_HAPPENED);
 	hbw_shrd_ar = RREG32(hbw_rtr_mstr_if_base_addr + RR_SHRD_HBW_AR_RAZWI_HAPPENED);
-
-	if (via_sft) {
-		/* SFT has separate MSTR_IF for LBW, only there we can
-		 * read the LBW razwi related registers
-		 */
-		u64 base;
-
-		base = mmSFT0_HBW_RTR_IF0_RTR_CTRL_BASE + dcore_id * SFT_DCORE_OFFSET +
-				RTR_LBW_MSTR_IF_OFFSET;
-
-		lbw_shrd_aw = RREG32(base + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
-		lbw_shrd_ar = RREG32(base + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
-	} else {
-		lbw_shrd_aw = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
-		lbw_shrd_ar = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
-	}
+	lbw_shrd_aw = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_HAPPENED);
+	lbw_shrd_ar = RREG32(lbw_rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_HAPPENED);
 
 	eng_id = gaudi2_razwi_calc_engine_id(hdev, module, module_idx);
 	if (hbw_shrd_aw) {
@@ -7855,7 +7842,7 @@ static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 	return error_count;
 }
 
-static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
+static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	u32 qid_base, error_count = 0;
 	u64 qman_base;
@@ -7903,34 +7890,42 @@ static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 		qman_base = mmDCORE3_MME_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA0_QM:
+		index = 0;
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0;
 		qman_base = mmDCORE0_EDMA0_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA1_QM:
+		index = 1;
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0;
 		qman_base = mmDCORE0_EDMA1_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA2_QM:
+		index = 2;
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0;
 		qman_base = mmDCORE1_EDMA0_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA3_QM:
+		index = 3;
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0;
 		qman_base = mmDCORE1_EDMA1_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA4_QM:
+		index = 4;
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0;
 		qman_base = mmDCORE2_EDMA0_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA5_QM:
+		index = 5;
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0;
 		qman_base = mmDCORE2_EDMA1_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA6_QM:
+		index = 6;
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0;
 		qman_base = mmDCORE3_EDMA0_QM_BASE;
 		break;
 	case GAUDI2_EVENT_HDMA7_QM:
+		index = 7;
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0;
 		qman_base = mmDCORE3_EDMA1_QM_BASE;
 		break;
@@ -7957,8 +7952,10 @@ static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 	error_count = gaudi2_handle_qman_err_generic(hdev, event_type, qman_base, qid_base);
 
 	/* Handle EDMA QM SEI here because there is no AXI error response event for EDMA */
-	if (event_type >= GAUDI2_EVENT_HDMA2_QM && event_type <= GAUDI2_EVENT_HDMA5_QM)
+	if (event_type >= GAUDI2_EVENT_HDMA2_QM && event_type <= GAUDI2_EVENT_HDMA5_QM) {
 		error_count += _gaudi2_handle_qm_sei_err(hdev, qman_base, event_type);
+		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, index, 0, event_mask);
+	}
 
 	return error_count;
 }
@@ -8868,7 +8865,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_ROTATOR0_ROT0_QM ... GAUDI2_EVENT_ROTATOR1_ROT1_QM:
 		fallthrough;
 	case GAUDI2_EVENT_NIC0_QM0 ... GAUDI2_EVENT_NIC11_QM1:
-		error_count = gaudi2_handle_qman_err(hdev, event_type);
+		error_count = gaudi2_handle_qman_err(hdev, event_type, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
-- 
2.25.1

