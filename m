Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCC64729F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLHPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLHPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B11ABA3A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 430EF61F81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7245DC433D6;
        Thu,  8 Dec 2022 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512449;
        bh=2OvQYim45wB3jh/pgwiXWsMYOHe1O1yP6ejcydoTWVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcy1o6rFq3/Seox94uQ8JtdsWtv9UIV4D5KsCBfUffN9vdtAI0UvbCI+NeMu1AYb5
         o3TWhsNBTah0d0VOdkBUmu81li1lfot22xlKFuQf1yNlX6ZKMN6EJb/IAX2v+gTPOJ
         k5V6XtPmpEt7LO3bJSDtPEr5xys2Cd/lsltOxgT496FYQPhZ6fXlOkzYB2Ng/+VxZZ
         4gub22dSaxW9lAQonz01yH+vqwDVd1BPvX2c/9YB3mQ6O/jytT5gDxaNJ6c8V8/WUf
         KxIxId+Xkx9LXamURzUUpfNTiJ259W8saqNwz6/nZUGbFkC1ar9CwzXwb36hIxAdXw
         LE3yKT+Kj8o7Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 11/26] habanalabs/gaudi2: count interrupt causes
Date:   Thu,  8 Dec 2022 17:13:35 +0200
Message-Id: <20221208151350.1833823-11-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

During event handling we extract interrupt cause and count it.
In case we could not find any cause we should add proper error.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 361 +++++++++++++++++-------
 1 file changed, 252 insertions(+), 109 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 10c017b8ddfa..b8da2aa024ca 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -53,6 +53,7 @@
 #define GAUDI2_HIF_HMMU_FULL_MASK		0xFFFF
 #define GAUDI2_DECODER_FULL_MASK		0x3FF
 
+#define GAUDI2_NA_EVENT_CAUSE			0xFF
 #define GAUDI2_NUM_OF_QM_ERR_CAUSE		18
 #define GAUDI2_NUM_OF_QM_LCP_ERR_CAUSE		25
 #define GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE		3
@@ -6987,10 +6988,10 @@ static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base, u32 str
 		gaudi2_print_last_pqes_on_err(hdev, qid_base, i, qman_base, false);
 }
 
-static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm_name,
-						u64 qman_base, u32 qid_base)
+static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm_name,
+							u64 qman_base, u32 qid_base)
 {
-	u32 i, j, glbl_sts_val, arb_err_val, num_error_causes;
+	u32 i, j, glbl_sts_val, arb_err_val, num_error_causes, error_count = 0;
 	u64 glbl_sts_addr, arb_err_addr;
 	char reg_desc[32];
 
@@ -7013,12 +7014,14 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 		}
 
 		for (j = 0 ; j < num_error_causes ; j++)
-			if (glbl_sts_val & BIT(j))
+			if (glbl_sts_val & BIT(j)) {
 				dev_err_ratelimited(hdev->dev, "%s %s. err cause: %s\n",
 						qm_name, reg_desc,
 						i == QMAN_STREAMS ?
 						gaudi2_qman_lower_cp_error_cause[j] :
 						gaudi2_qman_error_cause[j]);
+				error_count++;
+			}
 
 		print_qman_data_on_err(hdev, qid_base, i, qman_base);
 	}
@@ -7026,13 +7029,18 @@ static void gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *q
 	arb_err_val = RREG32(arb_err_addr);
 
 	if (!arb_err_val)
-		return;
+		goto out;
 
 	for (j = 0 ; j < GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE ; j++) {
-		if (arb_err_val & BIT(j))
+		if (arb_err_val & BIT(j)) {
 			dev_err_ratelimited(hdev->dev, "%s ARB_ERR. err cause: %s\n",
 						qm_name, gaudi2_qman_arb_error_cause[j]);
+			error_count++;
+		}
 	}
+
+out:
+	return error_count;
 }
 
 static void gaudi2_razwi_rr_hbw_shared_printf_info(struct hl_device *hdev,
@@ -7675,17 +7683,17 @@ static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u
 }
 
 /* PSOC RAZWI interrupt occurs only when trying to access a bad address */
-static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev, u64 *event_mask)
+static int gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev, u64 *event_mask)
 {
 	u32 hbw_aw_set, hbw_ar_set, lbw_aw_set, lbw_ar_set, rtr_id, dcore_id, dcore_rtr_id, xy,
-								razwi_mask_info, razwi_intr = 0;
+						razwi_mask_info, razwi_intr = 0, error_count = 0;
 	int rtr_map_arr_len = NUM_OF_RTR_PER_DCORE * NUM_OF_DCORES;
 	u64 rtr_ctrl_base_addr;
 
 	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX)) {
 		razwi_intr = RREG32(mmPSOC_GLOBAL_CONF_RAZWI_INTERRUPT);
 		if (!razwi_intr)
-			return;
+			return 0;
 	}
 
 	razwi_mask_info = RREG32(mmPSOC_GLOBAL_CONF_RAZWI_MASK_INFO);
@@ -7743,15 +7751,19 @@ static void gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev, u64 *eve
 		gaudi2_razwi_unmapped_addr_lbw_printf_info(hdev, rtr_id,
 						rtr_ctrl_base_addr, false, event_mask);
 
+	error_count++;
+
 clear:
 	/* Clear Interrupts only on pldm or if f/w doesn't handle interrupts */
 	if (hdev->pldm || !(hdev->fw_components & FW_TYPE_LINUX))
 		WREG32(mmPSOC_GLOBAL_CONF_RAZWI_INTERRUPT, razwi_intr);
+
+	return error_count;
 }
 
-static void _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
+static int _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
 {
-	u32 i, sts_val, sts_clr_val = 0;
+	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
 	sts_val = RREG32(qman_base + QM_SEI_STATUS_OFFSET);
 
@@ -7760,16 +7772,20 @@ static void _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
 			dev_err_ratelimited(hdev->dev, "QM SEI. err cause: %s\n",
 						gaudi2_qm_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
 	WREG32(qman_base + QM_SEI_STATUS_OFFSET, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
+static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	enum razwi_event_sources module;
+	u32 error_count = 0;
 	u64 qman_base;
 	u8 index;
 
@@ -7808,24 +7824,27 @@ static void gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 		module = RAZWI_ROT;
 		break;
 	default:
-		return;
+		return 0;
 	}
 
-	_gaudi2_handle_qm_sei_err(hdev, qman_base);
+	error_count = _gaudi2_handle_qm_sei_err(hdev, qman_base);
 
 	/* There is a single event per NIC macro, so should check its both QMAN blocks */
 	if (event_type >= GAUDI2_EVENT_NIC0_AXI_ERROR_RESPONSE &&
 			event_type <= GAUDI2_EVENT_NIC11_AXI_ERROR_RESPONSE)
-		_gaudi2_handle_qm_sei_err(hdev, qman_base + NIC_QM_OFFSET);
+		error_count += _gaudi2_handle_qm_sei_err(hdev,
+					qman_base + NIC_QM_OFFSET);
 
 	/* check if RAZWI happened */
 	if (razwi_info)
 		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, razwi_info, event_mask);
+
+	return error_count;
 }
 
-static void gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
+static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 {
-	u32 qid_base;
+	u32 qid_base, error_count = 0;
 	u64 qman_base;
 	char desc[32];
 	u8 index;
@@ -7941,19 +7960,21 @@ static void gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 		snprintf(desc, ARRAY_SIZE(desc), "ROTATOR1_QM");
 		break;
 	default:
-		return;
+		return 0;
 	}
 
-	gaudi2_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
+	error_count = gaudi2_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
 
 	/* Handle EDMA QM SEI here because there is no AXI error response event for EDMA */
 	if (event_type >= GAUDI2_EVENT_HDMA2_QM && event_type <= GAUDI2_EVENT_HDMA5_QM)
-		_gaudi2_handle_qm_sei_err(hdev, qman_base);
+		error_count += _gaudi2_handle_qm_sei_err(hdev, qman_base);
+
+	return error_count;
 }
 
-static void gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
+static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
 {
-	u32 i, sts_val, sts_clr_val = 0;
+	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
 	sts_val = RREG32(mmARC_FARM_ARC0_AUX_ARC_SEI_INTR_STS);
 
@@ -7962,15 +7983,18 @@ static void gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
 			dev_err_ratelimited(hdev->dev, "ARC SEI. err cause: %s\n",
 						gaudi2_arc_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
 	WREG32(mmARC_FARM_ARC0_AUX_ARC_SEI_INTR_CLR, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
+static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
 {
-	u32 i, sts_val, sts_clr_val = 0;
+	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
 	sts_val = RREG32(mmCPU_IF_CPU_SEI_INTR_STS);
 
@@ -7979,50 +8003,63 @@ static void gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
 			dev_err_ratelimited(hdev->dev, "CPU SEI. err cause: %s\n",
 						gaudi2_cpu_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
 	WREG32(mmCPU_IF_CPU_SEI_INTR_CLR, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
+static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
 					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
 					u64 *event_mask)
 {
 	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_ROT_ERR_CAUSE ; i++)
-		if (intr_cause_data & BIT(i))
+		if (intr_cause_data & BIT(i)) {
 			dev_err_ratelimited(hdev->dev, "ROT%u. err cause: %s\n",
 						rot_index, guadi2_rot_error_cause[i]);
+			error_count++;
+		}
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0,
 						&razwi_with_intr_cause->razwi_info, event_mask);
+
+	return error_count;
 }
 
-static void gaudi2_tpc_ack_interrupts(struct hl_device *hdev, u8 tpc_index, char *interrupt_name,
+static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, char *interrupt_name,
 					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
 					u64 *event_mask)
 {
 	u64 intr_cause_data = le64_to_cpu(razwi_with_intr_cause->intr_cause.intr_cause_data);
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_TPC_INTR_CAUSE ; i++)
-		if (intr_cause_data & BIT(i))
+		if (intr_cause_data & BIT(i)) {
 			dev_err_ratelimited(hdev->dev, "TPC%d_%s interrupt cause: %s\n",
 					tpc_index, interrupt_name, gaudi2_tpc_interrupts_cause[i]);
+			error_count++;
+		}
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0,
 						&razwi_with_intr_cause->razwi_info, event_mask);
+
+	return error_count;
 }
 
-static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const char *interrupt_name,
+static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const char *interrupt_name,
 				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
-	u32 sts_addr, sts_val, sts_clr_val = 0;
+	u32 sts_addr, sts_val, sts_clr_val = 0, error_count = 0;
 	int i;
 
 	if (dec_index < NUM_OF_VDEC_PER_DCORE * NUM_OF_DCORES)
@@ -8042,6 +8079,7 @@ static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const ch
 			dev_err_ratelimited(hdev->dev, "DEC%u_%s err cause: %s\n",
 					dec_index, interrupt_name, gaudi2_dec_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
@@ -8051,12 +8089,14 @@ static void gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const ch
 
 	/* Write 1 clear errors */
 	WREG32(sts_addr, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const char *interrupt_name,
+static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const char *interrupt_name,
 				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
-	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
+	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
 	int i;
 
 	sts_addr = mmDCORE0_MME_CTRL_LO_INTR_CAUSE + DCORE_OFFSET * mme_index;
@@ -8069,6 +8109,7 @@ static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const ch
 			dev_err_ratelimited(hdev->dev, "MME%u_%s err cause: %s\n",
 					mme_index, interrupt_name, guadi2_mme_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
@@ -8078,23 +8119,29 @@ static void gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const ch
 							event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u8 mme_index, u8 sbte_index,
+static int gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u8 mme_index, u8 sbte_index,
 					u64 intr_cause_data)
 {
-	int i;
+	int i, error_count = 0;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_MME_SBTE_ERR_CAUSE ; i++)
-		if (intr_cause_data & BIT(i))
+		if (intr_cause_data & BIT(i)) {
 			dev_err_ratelimited(hdev->dev, "MME%uSBTE%u_AXI_ERR_RSP err cause: %s\n",
 					mme_index, sbte_index, guadi2_mme_sbte_error_cause[i]);
+			error_count++;
+		}
+
+	return error_count;
 }
 
-static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
+static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
-	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0;
+	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
 	int i;
 
 	sts_addr = mmDCORE0_MME_ACC_INTR_CAUSE + DCORE_OFFSET * mme_index;
@@ -8108,6 +8155,7 @@ static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 					"MME%u_WAP_SOURCE_RESULT_INVALID err cause: %s\n",
 					mme_index, guadi2_mme_wap_error_cause[i]);
 			sts_clr_val |= BIT(i);
+			error_count++;
 		}
 	}
 
@@ -8118,10 +8166,13 @@ static void gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 						event_mask);
 
 	WREG32(sts_clr_addr, sts_clr_val);
+
+	return error_count;
 }
 
-static void gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause_data)
 {
+	u32 error_count = 0;
 	int i;
 
 	/* If an AXI read or write error is received, an error is reported and
@@ -8130,19 +8181,28 @@ static void gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause
 	 * the actual error caused by a LBW KDMA transaction.
 	 */
 	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
-		if (intr_cause_data & BIT(i))
+		if (intr_cause_data & BIT(i)) {
 			dev_err_ratelimited(hdev->dev, "kdma core err cause: %s\n",
 						gaudi2_kdma_core_interrupts_cause[i]);
+			error_count++;
+		}
+
+	return error_count;
 }
 
-static void gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_data)
 {
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
-		if (intr_cause_data & BIT(i))
+		if (intr_cause_data & BIT(i)) {
 			dev_err_ratelimited(hdev->dev, "dma core err cause: %s\n",
 						gaudi2_dma_core_interrupts_cause[i]);
+			error_count++;
+		}
+
+	return error_count;
 }
 
 static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev, u64 *event_mask)
@@ -8178,9 +8238,10 @@ static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev,
 	}
 }
 
-static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data,
+static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data,
 						u64 *event_mask)
 {
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_PCIE_ADDR_DEC_ERR_CAUSE ; i++) {
@@ -8189,6 +8250,7 @@ static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cau
 
 		dev_err_ratelimited(hdev->dev, "PCIE ADDR DEC Error: %s\n",
 					gaudi2_pcie_addr_dec_error_cause[i]);
+		error_count++;
 
 		switch (intr_cause_data & BIT_ULL(i)) {
 		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK:
@@ -8198,33 +8260,44 @@ static void gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cau
 			break;
 		}
 	}
+
+	return error_count;
 }
 
-static void gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
 
 {
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_PMMU_FATAL_ERR_CAUSE ; i++) {
-		if (intr_cause_data & BIT_ULL(i))
+		if (intr_cause_data & BIT_ULL(i)) {
 			dev_err_ratelimited(hdev->dev, "PMMU PIF err cause: %s\n",
 					gaudi2_pmmu_fatal_interrupts_cause[i]);
+			error_count++;
+		}
 	}
+
+	return error_count;
 }
 
-static void gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64 intr_cause_data)
+static int gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64 intr_cause_data)
 {
-	u32 dcore_id, hif_id;
+	u32 dcore_id, hif_id, error_count = 0;
 	int i;
 
 	dcore_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) / 4;
 	hif_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) % 4;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE ; i++) {
-		if (intr_cause_data & BIT_ULL(i))
+		if (intr_cause_data & BIT_ULL(i)) {
 			dev_err_ratelimited(hdev->dev, "DCORE%u_HIF%u: %s\n", dcore_id, hif_id,
 					gaudi2_hif_fatal_interrupts_cause[i]);
+			error_count++;
+		}
 	}
+
+	return error_count;
 }
 
 static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu,
@@ -8270,10 +8343,10 @@ static void gaudi2_handle_access_error(struct hl_device *hdev, u64 mmu_base, boo
 	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE), 0);
 }
 
-static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char *mmu_name,
+static int gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char *mmu_name,
 						u64 mmu_base, bool is_pmmu, u64 *event_mask)
 {
-	u32 spi_sei_cause, interrupt_clr = 0x0;
+	u32 spi_sei_cause, interrupt_clr = 0x0, error_count = 0;
 	int i;
 
 	spi_sei_cause = RREG32(mmu_base + MMU_SPI_SEI_CAUSE_OFFSET);
@@ -8290,6 +8363,8 @@ static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 
 			if (gaudi2_mmu_spi_sei[i].clear_bit >= 0)
 				interrupt_clr |= BIT(gaudi2_mmu_spi_sei[i].clear_bit);
+
+			error_count++;
 		}
 	}
 
@@ -8298,12 +8373,14 @@ static void gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 
 	/* Clear interrupt */
 	WREG32(mmu_base + MMU_INTERRUPT_CLR_OFFSET, interrupt_clr);
+
+	return error_count;
 }
 
-static void gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
+static int gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 {
-	u32 sei_cause_addr, sei_cause_val, sei_cause_cause, sei_cause_log;
-	u32 cq_intr_addr, cq_intr_val, cq_intr_queue_index;
+	u32 sei_cause_addr, sei_cause_val, sei_cause_cause, sei_cause_log,
+		cq_intr_addr, cq_intr_val, cq_intr_queue_index, error_count = 0;
 	int i;
 
 	sei_cause_addr = mmDCORE0_SYNC_MNGR_GLBL_SM_SEI_CAUSE + DCORE_OFFSET * sm_index;
@@ -8328,6 +8405,7 @@ static void gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 					gaudi2_sm_sei_cause[i].cause_name,
 					gaudi2_sm_sei_cause[i].log_name,
 					sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
+			error_count++;
 			break;
 		}
 
@@ -8343,16 +8421,20 @@ static void gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 
 		dev_err_ratelimited(hdev->dev, "SM%u err. err cause: CQ_INTR. queue index: %u\n",
 				sm_index, cq_intr_queue_index);
+		error_count++;
 
 		/* Clear CQ_INTR */
 		WREG32(cq_intr_addr, 0);
 	}
+
+	return error_count;
 }
 
-static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
+static int gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	bool is_pmmu = false;
 	char desc[32];
+	u32 error_count = 0;
 	u64 mmu_base;
 	u8 index;
 
@@ -8404,10 +8486,12 @@ static void gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type
 		snprintf(desc, ARRAY_SIZE(desc), "PMMU");
 		break;
 	default:
-		return;
+		return 0;
 	}
 
-	gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu, event_mask);
+	error_count = gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu, event_mask);
+
+	return error_count;
 }
 
 
@@ -8586,21 +8670,30 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 	return require_hard_reset;
 }
 
-static void gaudi2_handle_hbm_cattrip(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_hbm_cattrip(struct hl_device *hdev, u64 intr_cause_data)
 {
-	dev_err(hdev->dev,
-		"HBM catastrophic temperature error (CATTRIP) cause %#llx\n",
-		intr_cause_data);
+	if (intr_cause_data) {
+		dev_err(hdev->dev,
+			"HBM catastrophic temperature error (CATTRIP) cause %#llx\n",
+			intr_cause_data);
+		return 1;
+	}
+
+	return 0;
 }
 
-static void gaudi2_handle_hbm_mc_spi(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_hbm_mc_spi(struct hl_device *hdev, u64 intr_cause_data)
 {
-	u32 i;
+	u32 i, error_count = 0;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE ; i++)
-		if (intr_cause_data & hbm_mc_spi[i].mask)
+		if (intr_cause_data & hbm_mc_spi[i].mask) {
 			dev_dbg(hdev->dev, "HBM spi event: notification cause(%s)\n",
 				hbm_mc_spi[i].cause);
+			error_count++;
+		}
+
+	return error_count;
 }
 
 static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type, u64 *event_mask)
@@ -8657,9 +8750,9 @@ static void gaudi2_print_out_of_sync_info(struct hl_device *hdev,
 		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
-static void gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
+static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
 {
-	u32 p2p_intr, msix_gw_intr;
+	u32 p2p_intr, msix_gw_intr, error_count = 0;
 
 	p2p_intr = RREG32(mmPCIE_WRAP_P2P_INTR);
 	msix_gw_intr = RREG32(mmPCIE_WRAP_MSIX_GW_INTR);
@@ -8670,6 +8763,7 @@ static void gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
 			RREG32(mmPCIE_WRAP_P2P_REQ_ID));
 
 		WREG32(mmPCIE_WRAP_P2P_INTR, 0x1);
+		error_count++;
 	}
 
 	if (msix_gw_intr) {
@@ -8678,13 +8772,16 @@ static void gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
 			RREG32(mmPCIE_WRAP_MSIX_GW_VEC));
 
 		WREG32(mmPCIE_WRAP_MSIX_GW_INTR, 0x1);
+		error_count++;
 	}
+
+	return error_count;
 }
 
-static void gaudi2_handle_pcie_drain(struct hl_device *hdev,
+static int gaudi2_handle_pcie_drain(struct hl_device *hdev,
 			struct hl_eq_pcie_drain_ind_data *drain_data)
 {
-	u64 lbw_rd, lbw_wr, hbw_rd, hbw_wr, cause;
+	u64 lbw_rd, lbw_wr, hbw_rd, hbw_wr, cause, error_count = 0;
 
 	cause = le64_to_cpu(drain_data->intr_cause.intr_cause_data);
 	lbw_rd = le64_to_cpu(drain_data->drain_rd_addr_lbw);
@@ -8692,26 +8789,37 @@ static void gaudi2_handle_pcie_drain(struct hl_device *hdev,
 	hbw_rd = le64_to_cpu(drain_data->drain_rd_addr_hbw);
 	hbw_wr = le64_to_cpu(drain_data->drain_wr_addr_hbw);
 
-	if (cause & BIT_ULL(0))
+	if (cause & BIT_ULL(0)) {
 		dev_err_ratelimited(hdev->dev,
 			"PCIE AXI drain LBW completed, read_err %u, write_err %u\n",
 			!!lbw_rd, !!lbw_wr);
+		error_count++;
+	}
 
-	if (cause & BIT_ULL(1))
+	if (cause & BIT_ULL(1)) {
 		dev_err_ratelimited(hdev->dev,
 			"PCIE AXI drain HBW completed, raddr %#llx, waddr %#llx\n",
 			hbw_rd, hbw_wr);
+		error_count++;
+	}
+
+	return error_count;
 }
 
-static void gaudi2_handle_psoc_drain(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_psoc_drain(struct hl_device *hdev, u64 intr_cause_data)
 {
+	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_AXI_DRAIN_ERR_CAUSE ; i++) {
-		if (intr_cause_data & BIT_ULL(i))
+		if (intr_cause_data & BIT_ULL(i)) {
 			dev_err_ratelimited(hdev->dev, "PSOC %s completed\n",
 				gaudi2_psoc_axi_drain_interrupts_cause[i]);
+			error_count++;
+		}
 	}
+
+	return error_count;
 }
 
 static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev,
@@ -8724,8 +8832,7 @@ static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev,
 		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
-static void hl_arc_event_handle(struct hl_device *hdev,
-					struct hl_eq_engine_arc_intr_data *data)
+static int hl_arc_event_handle(struct hl_device *hdev, struct hl_eq_engine_arc_intr_data *data)
 {
 	struct hl_engine_arc_dccm_queue_full_irq *q;
 	u32 intr_type, engine_id;
@@ -8742,9 +8849,10 @@ static void hl_arc_event_handle(struct hl_device *hdev,
 		dev_err_ratelimited(hdev->dev,
 				"ARC DCCM Full event: EngId: %u, Intr_type: %u, Qidx: %u\n",
 				engine_id, intr_type, q->queue_index);
-		break;
+		return 1;
 	default:
 		dev_err_ratelimited(hdev->dev, "Unknown ARC event type\n");
+		return 0;
 	}
 }
 
@@ -8752,7 +8860,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	bool reset_required = false, is_critical = false;
-	u32 ctl, reset_flags = HL_DRV_RESET_HARD;
+	u32 ctl, reset_flags = HL_DRV_RESET_HARD, error_count = 0;
 	int index, sbte_index;
 	u64 event_mask = 0;
 	u16 event_type;
@@ -8779,6 +8887,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		reset_required = gaudi2_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		is_critical = eq_entry->ecc_data.is_critical;
+		error_count++;
 		break;
 
 	case GAUDI2_EVENT_TPC0_QM ... GAUDI2_EVENT_PDMA1_QM:
@@ -8786,48 +8895,50 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_ROTATOR0_ROT0_QM ... GAUDI2_EVENT_ROTATOR1_ROT1_QM:
 		fallthrough;
 	case GAUDI2_EVENT_NIC0_QM0 ... GAUDI2_EVENT_NIC11_QM1:
-		gaudi2_handle_qman_err(hdev, event_type);
+		error_count = gaudi2_handle_qman_err(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_ARC_AXI_ERROR_RESPONSE_0:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		gaudi2_handle_arc_farm_sei_err(hdev);
+		error_count = gaudi2_handle_arc_farm_sei_err(hdev);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_AXI_ERR_RSP:
-		gaudi2_handle_cpu_sei_err(hdev);
+		error_count = gaudi2_handle_cpu_sei_err(hdev);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PDMA_CH1_AXI_ERR_RSP:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		gaudi2_handle_qm_sei_err(hdev, event_type, &eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_qm_sei_err(hdev, event_type,
+					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
 	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
-		gaudi2_handle_rot_err(hdev, index, &eq_entry->razwi_with_intr_cause, &event_mask);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count = gaudi2_handle_rot_err(hdev, index,
+					&eq_entry->razwi_with_intr_cause, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
 		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
-		gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
+		error_count = gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
 						&eq_entry->razwi_with_intr_cause, &event_mask);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
 		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
-		gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE", &eq_entry->razwi_info,
-					&event_mask);
+		error_count = gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE",
+					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8858,8 +8969,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_TPC24_KERNEL_ERR:
 		index = (event_type - GAUDI2_EVENT_TPC0_KERNEL_ERR) /
 			(GAUDI2_EVENT_TPC1_KERNEL_ERR - GAUDI2_EVENT_TPC0_KERNEL_ERR);
-		gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR", &eq_entry->razwi_with_intr_cause,
-						&event_mask);
+		error_count = gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR",
+				&eq_entry->razwi_with_intr_cause, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8875,7 +8986,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC9_SPI:
 		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
 				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
-		gaudi2_handle_dec_err(hdev, index, "SPI", &eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_dec_err(hdev, index, "SPI",
+					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8886,9 +8998,9 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE) /
 				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
 						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
-		gaudi2_handle_mme_err(hdev, index,
+		error_count = gaudi2_handle_mme_err(hdev, index,
 				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info, &event_mask);
-		gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
+		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8899,8 +9011,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_QMAN_SW_ERROR) /
 				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
 					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
-		gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR", &eq_entry->razwi_info,
-					&event_mask);
+		error_count = gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR",
+					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8911,25 +9023,26 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID) /
 				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
 					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
-		gaudi2_handle_mme_wap_err(hdev, index, &eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_mme_wap_err(hdev, index,
+					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_KDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_KDMA0_CORE:
-		gaudi2_handle_kdma_core_event(hdev,
+		error_count = gaudi2_handle_kdma_core_event(hdev,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HDMA2_CORE ... GAUDI2_EVENT_PDMA1_CORE:
-		gaudi2_handle_dma_core_event(hdev,
+		error_count = gaudi2_handle_dma_core_event(hdev,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
-		gaudi2_print_pcie_addr_dec_info(hdev,
+		error_count = gaudi2_print_pcie_addr_dec_info(hdev,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data), &event_mask);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
@@ -8939,27 +9052,27 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
 	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
 	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
-		gaudi2_handle_mmu_spi_sei_err(hdev, event_type, &event_mask);
+		error_count = gaudi2_handle_mmu_spi_sei_err(hdev, event_type, &event_mask);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_HIF0_FATAL ... GAUDI2_EVENT_HIF12_FATAL:
-		gaudi2_handle_hif_fatal(hdev, event_type,
+		error_count = gaudi2_handle_hif_fatal(hdev, event_type,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PMMU_FATAL_0:
-		gaudi2_handle_pif_fatal(hdev,
+		error_count = gaudi2_handle_pif_fatal(hdev,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC63_RAZWI_OR_PID_MIN_MAX_INTERRUPT:
-		gaudi2_ack_psoc_razwi_event_handler(hdev, &event_mask);
+		error_count = gaudi2_ack_psoc_razwi_event_handler(hdev, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8969,33 +9082,39 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 			reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 			reset_required = true;
 		}
+		error_count++;
 		break;
 
 	case GAUDI2_EVENT_HBM_CATTRIP_0 ... GAUDI2_EVENT_HBM_CATTRIP_5:
-		gaudi2_handle_hbm_cattrip(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		error_count = gaudi2_handle_hbm_cattrip(hdev,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HBM0_MC0_SPI ... GAUDI2_EVENT_HBM5_MC1_SPI:
-		gaudi2_handle_hbm_mc_spi(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		error_count = gaudi2_handle_hbm_mc_spi(hdev,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_DRAIN_COMPLETE:
-		gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
+		error_count = gaudi2_handle_pcie_drain(hdev, &eq_entry->pcie_drain_ind_data);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC59_RPM_ERROR_OR_DRAIN:
-		gaudi2_handle_psoc_drain(hdev, le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		error_count = gaudi2_handle_psoc_drain(hdev,
+				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_AXI_ECC:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_CPU_L2_RAM_ECC:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
@@ -9009,25 +9128,30 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		sbte_index = (event_type - GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP) %
 				(GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP -
 					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
-		gaudi2_handle_mme_sbte_err(hdev, index, sbte_index,
-						le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		error_count = gaudi2_handle_mme_sbte_err(hdev, index, sbte_index,
+					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 	case GAUDI2_EVENT_VM0_ALARM_A ... GAUDI2_EVENT_VM3_ALARM_B:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PSOC_AXI_ERR_RSP:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PSOC_PRSTN_FALL:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PCIE_APB_TIMEOUT:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_PCIE_FATAL_ERR:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_TPC0_BMON_SPMU:
@@ -9080,6 +9204,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC8_BMON_SPMU:
 	case GAUDI2_EVENT_DEC9_BMON_SPMU:
 	case GAUDI2_EVENT_ROTATOR0_BMON_SPMU ... GAUDI2_EVENT_SM3_BMON_SPMU:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9088,65 +9213,83 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
 		gaudi2_print_clk_change_info(hdev, event_type, &event_mask);
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_QUEUE_OUT_SYNC:
 		gaudi2_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_FLR_REQUESTED:
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		/* Do nothing- FW will handle it */
 		break;
 
 	case GAUDI2_EVENT_PCIE_P2P_MSIX:
-		gaudi2_handle_pcie_p2p_msix(hdev);
+		error_count = gaudi2_handle_pcie_p2p_msix(hdev);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE ... GAUDI2_EVENT_SM3_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE;
-		gaudi2_handle_sm_err(hdev, index);
+		error_count = gaudi2_handle_sm_err(hdev, index);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_PSOC_MME_PLL_LOCK_ERR ... GAUDI2_EVENT_DCORE2_HBM_PLL_LOCK_ERR:
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
 		dev_info(hdev->dev, "CPLD shutdown cause, reset reason: 0x%llx\n",
 						le64_to_cpu(eq_entry->data[0]));
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_EVENT:
 		dev_err(hdev->dev, "CPLD shutdown event, reset reason: 0x%llx\n",
 						le64_to_cpu(eq_entry->data[0]));
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_SANITY_FAILED:
 		gaudi2_print_cpu_pkt_failure_info(hdev, &eq_entry->pkt_sync_err);
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_ARC_DCCM_FULL:
-		hl_arc_event_handle(hdev, &eq_entry->arc_data);
+		error_count = hl_arc_event_handle(hdev, &eq_entry->arc_data);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_FP32_NOT_SUPPORTED:
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		error_count = GAUDI2_NA_EVENT_CAUSE;
 		is_critical = true;
 		break;
 
 	default:
-		if (gaudi2_irq_map_table[event_type].valid)
+		if (gaudi2_irq_map_table[event_type].valid) {
 			dev_err_ratelimited(hdev->dev, "Cannot find handler for event %d\n",
 						event_type);
+			error_count = GAUDI2_NA_EVENT_CAUSE;
+		}
 	}
 
+	/* Make sure to dump an error in case no error cause was printed so far.
+	 * Note that although we have counted the errors, we use this number as
+	 * a boolean.
+	 */
+	if (error_count == 0 && !is_info_event(event_type))
+		dev_err_ratelimited(hdev->dev,
+			"No Error cause for H/W event %d\n", event_type);
+
 	if ((gaudi2_irq_map_table[event_type].reset || reset_required) &&
 				(hdev->hard_reset_on_fw_events ||
 				(hdev->asic_prop.fw_security_enabled && is_critical)))
-- 
2.25.1

