Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127464729E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLHPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLHPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14425AD302
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7670DB82433
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F52C433C1;
        Thu,  8 Dec 2022 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512451;
        bh=AYCT82xl+8PhF00u32+sGmaa0COjC7ofaZy8iEkbCuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJ3KwRJEBgA2cRkunpBTasni+OESvvhp/0+k+1C5IWDGRfv13D/OEFGIK4/wEfIGl
         y2yrXp07I0JD5Cf5SUfHml3WfmzUxmkNo3eSLE0HSgqy7Cqpvn/A3eJ+SJxYOLCs0t
         kMHsxlzFlxJ76vS7WLj8Tq33hD6M5FMwZ3VINmS+fHCjFqoYdbxxXlZjiFAStN6UL1
         9FqiuXzSqy518gX/V6SkZ0dabV56We2Yj+2xnl+rmD9npDbT3ShjEgByQiDn+CN3ii
         7Dnjdhg76MGh6pkZnF/HCde9unOwBqRt5mgQ/GPiCt/H7hskNFkhO8tYlMpZvh8Djm
         c7NBI4qdV2Daw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 12/26] habanalabs/gaudi2: remove duplicated event prints
Date:   Thu,  8 Dec 2022 17:13:36 +0200
Message-Id: <20221208151350.1833823-12-ogabbay@kernel.org>
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

In order to reduce error log, we try to minimize the dumped rows
while keeping all relevant error info. In addition we completely
remove clock throttling debug logs.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 339 +++++++++++-------------
 1 file changed, 149 insertions(+), 190 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index b8da2aa024ca..8373239ad1bc 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6804,38 +6804,37 @@ static inline bool is_info_event(u32 event)
 	switch (event) {
 	case GAUDI2_EVENT_CPU_CPLD_SHUTDOWN_CAUSE:
 	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_S ... GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_E:
+
+	/* return in case of NIC status event - these events are received periodically and not as
+	 * an indication to an error.
+	 */
+	case GAUDI2_EVENT_CPU0_STATUS_NIC0_ENG0 ... GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1:
 		return true;
 	default:
 		return false;
 	}
 }
 
-static void gaudi2_print_irq_info(struct hl_device *hdev, u16 event_type)
+void gaudi2_print_event(struct hl_device *hdev, u16 event_type,
+			bool ratelimited, const char *fmt, ...)
 {
-	char desc[64] = "";
-	bool event_valid = false;
-
-	/* return in case of NIC status event - these events are received periodically and not as
-	 * an indication to an error, thus not printed.
-	 */
-	if (event_type >= GAUDI2_EVENT_CPU0_STATUS_NIC0_ENG0 &&
-		event_type <= GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1)
-		return;
+	struct va_format vaf;
+	va_list args;
 
-	if (gaudi2_irq_map_table[event_type].valid) {
-		snprintf(desc, sizeof(desc), gaudi2_irq_map_table[event_type].name);
-		event_valid = true;
-	}
-
-	if (!event_valid)
-		snprintf(desc, sizeof(desc), "N/A");
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
 
-	if (is_info_event(event_type))
-		dev_info_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
-								event_type, desc);
+	if (ratelimited)
+		dev_err_ratelimited(hdev->dev, "%s: %pV\n",
+			gaudi2_irq_map_table[event_type].valid ?
+			gaudi2_irq_map_table[event_type].name : "N/A Event", &vaf);
 	else
-		dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
-								event_type, desc);
+		dev_err(hdev->dev, "%s: %pV\n",
+			gaudi2_irq_map_table[event_type].valid ?
+			gaudi2_irq_map_table[event_type].name : "N/A Event", &vaf);
+
+	va_end(args);
 }
 
 static bool gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
@@ -6848,7 +6847,7 @@ static bool gaudi2_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 	ecc_syndrom = le64_to_cpu(ecc_data->ecc_syndrom);
 	memory_wrapper_idx = ecc_data->memory_wrapper_idx;
 
-	dev_err(hdev->dev,
+	gaudi2_print_event(hdev, event_type, !ecc_data->is_critical,
 		"ECC error detected. address: %#llx. Syndrom: %#llx. block id %u. critical %u.\n",
 		ecc_address, ecc_syndrom, memory_wrapper_idx, ecc_data->is_critical);
 
@@ -6988,7 +6987,7 @@ static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base, u32 str
 		gaudi2_print_last_pqes_on_err(hdev, qid_base, i, qman_base, false);
 }
 
-static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm_name,
+static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, u16 event_type,
 							u64 qman_base, u32 qid_base)
 {
 	u32 i, j, glbl_sts_val, arb_err_val, num_error_causes, error_count = 0;
@@ -7015,11 +7014,11 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm
 
 		for (j = 0 ; j < num_error_causes ; j++)
 			if (glbl_sts_val & BIT(j)) {
-				dev_err_ratelimited(hdev->dev, "%s %s. err cause: %s\n",
-						qm_name, reg_desc,
-						i == QMAN_STREAMS ?
-						gaudi2_qman_lower_cp_error_cause[j] :
-						gaudi2_qman_error_cause[j]);
+				gaudi2_print_event(hdev, event_type, true,
+					"%s. err cause: %s", reg_desc,
+					i == QMAN_STREAMS ?
+					gaudi2_qman_lower_cp_error_cause[j] :
+					gaudi2_qman_error_cause[j]);
 				error_count++;
 			}
 
@@ -7033,8 +7032,9 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, const char *qm
 
 	for (j = 0 ; j < GAUDI2_NUM_OF_QM_ARB_ERR_CAUSE ; j++) {
 		if (arb_err_val & BIT(j)) {
-			dev_err_ratelimited(hdev->dev, "%s ARB_ERR. err cause: %s\n",
-						qm_name, gaudi2_qman_arb_error_cause[j]);
+			gaudi2_print_event(hdev, event_type, true,
+				"ARB_ERR. err cause: %s",
+				gaudi2_qman_arb_error_cause[j]);
 			error_count++;
 		}
 	}
@@ -7761,7 +7761,7 @@ static int gaudi2_ack_psoc_razwi_event_handler(struct hl_device *hdev, u64 *even
 	return error_count;
 }
 
-static int _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
+static int _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base, u16 event_type)
 {
 	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
@@ -7769,8 +7769,8 @@ static int _gaudi2_handle_qm_sei_err(struct hl_device *hdev, u64 qman_base)
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_QM_SEI_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "QM SEI. err cause: %s\n",
-						gaudi2_qm_sei_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_qm_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -7827,13 +7827,13 @@ static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 		return 0;
 	}
 
-	error_count = _gaudi2_handle_qm_sei_err(hdev, qman_base);
+	error_count = _gaudi2_handle_qm_sei_err(hdev, qman_base, event_type);
 
 	/* There is a single event per NIC macro, so should check its both QMAN blocks */
 	if (event_type >= GAUDI2_EVENT_NIC0_AXI_ERROR_RESPONSE &&
 			event_type <= GAUDI2_EVENT_NIC11_AXI_ERROR_RESPONSE)
 		error_count += _gaudi2_handle_qm_sei_err(hdev,
-					qman_base + NIC_QM_OFFSET);
+					qman_base + NIC_QM_OFFSET, event_type);
 
 	/* check if RAZWI happened */
 	if (razwi_info)
@@ -7846,7 +7846,6 @@ static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 {
 	u32 qid_base, error_count = 0;
 	u64 qman_base;
-	char desc[32];
 	u8 index;
 
 	switch (event_type) {
@@ -7854,125 +7853,104 @@ static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type)
 		index = event_type - GAUDI2_EVENT_TPC0_QM;
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmDCORE0_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_TPC%d_QM", index);
 		break;
 	case GAUDI2_EVENT_TPC6_QM ... GAUDI2_EVENT_TPC11_QM:
 		index = event_type - GAUDI2_EVENT_TPC6_QM;
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmDCORE1_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_TPC%d_QM", index);
 		break;
 	case GAUDI2_EVENT_TPC12_QM ... GAUDI2_EVENT_TPC17_QM:
 		index = event_type - GAUDI2_EVENT_TPC12_QM;
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmDCORE2_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_TPC%d_QM", index);
 		break;
 	case GAUDI2_EVENT_TPC18_QM ... GAUDI2_EVENT_TPC23_QM:
 		index = event_type - GAUDI2_EVENT_TPC18_QM;
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_TPC_0_0 + index * QMAN_STREAMS;
 		qman_base = mmDCORE3_TPC0_QM_BASE + index * DCORE_TPC_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_TPC%d_QM", index);
 		break;
 	case GAUDI2_EVENT_TPC24_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_TPC_6_0;
 		qman_base = mmDCORE0_TPC6_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_TPC6_QM");
 		break;
 	case GAUDI2_EVENT_MME0_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_MME_0_0;
 		qman_base = mmDCORE0_MME_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_MME_QM");
 		break;
 	case GAUDI2_EVENT_MME1_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_MME_0_0;
 		qman_base = mmDCORE1_MME_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_MME_QM");
 		break;
 	case GAUDI2_EVENT_MME2_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_MME_0_0;
 		qman_base = mmDCORE2_MME_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_MME_QM");
 		break;
 	case GAUDI2_EVENT_MME3_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_MME_0_0;
 		qman_base = mmDCORE3_MME_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_MME_QM");
 		break;
 	case GAUDI2_EVENT_HDMA0_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0;
 		qman_base = mmDCORE0_EDMA0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_EDMA0_QM");
 		break;
 	case GAUDI2_EVENT_HDMA1_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0;
 		qman_base = mmDCORE0_EDMA1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_EDMA1_QM");
 		break;
 	case GAUDI2_EVENT_HDMA2_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0;
 		qman_base = mmDCORE1_EDMA0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_EDMA0_QM");
 		break;
 	case GAUDI2_EVENT_HDMA3_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0;
 		qman_base = mmDCORE1_EDMA1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_EDMA1_QM");
 		break;
 	case GAUDI2_EVENT_HDMA4_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0;
 		qman_base = mmDCORE2_EDMA0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_EDMA0_QM");
 		break;
 	case GAUDI2_EVENT_HDMA5_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0;
 		qman_base = mmDCORE2_EDMA1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_EDMA1_QM");
 		break;
 	case GAUDI2_EVENT_HDMA6_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0;
 		qman_base = mmDCORE3_EDMA0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_EDMA0_QM");
 		break;
 	case GAUDI2_EVENT_HDMA7_QM:
 		qid_base = GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0;
 		qman_base = mmDCORE3_EDMA1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_EDMA1_QM");
 		break;
 	case GAUDI2_EVENT_PDMA0_QM:
 		qid_base = GAUDI2_QUEUE_ID_PDMA_0_0;
 		qman_base = mmPDMA0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "PDMA0_QM");
 		break;
 	case GAUDI2_EVENT_PDMA1_QM:
 		qid_base = GAUDI2_QUEUE_ID_PDMA_1_0;
 		qman_base = mmPDMA1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "PDMA1_QM");
 		break;
 	case GAUDI2_EVENT_ROTATOR0_ROT0_QM:
 		qid_base = GAUDI2_QUEUE_ID_ROT_0_0;
 		qman_base = mmROT0_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "ROTATOR0_QM");
 		break;
 	case GAUDI2_EVENT_ROTATOR1_ROT1_QM:
 		qid_base = GAUDI2_QUEUE_ID_ROT_1_0;
 		qman_base = mmROT1_QM_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "ROTATOR1_QM");
 		break;
 	default:
 		return 0;
 	}
 
-	error_count = gaudi2_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
+	error_count = gaudi2_handle_qman_err_generic(hdev, event_type, qman_base, qid_base);
 
 	/* Handle EDMA QM SEI here because there is no AXI error response event for EDMA */
 	if (event_type >= GAUDI2_EVENT_HDMA2_QM && event_type <= GAUDI2_EVENT_HDMA5_QM)
-		error_count += _gaudi2_handle_qm_sei_err(hdev, qman_base);
+		error_count += _gaudi2_handle_qm_sei_err(hdev, qman_base, event_type);
 
 	return error_count;
 }
 
-static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
+static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev, u16 event_type)
 {
 	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
@@ -7980,8 +7958,8 @@ static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_ARC_SEI_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "ARC SEI. err cause: %s\n",
-						gaudi2_arc_sei_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_arc_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -7992,7 +7970,7 @@ static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev)
 	return error_count;
 }
 
-static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
+static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev, u16 event_type)
 {
 	u32 i, sts_val, sts_clr_val = 0, error_count = 0;
 
@@ -8000,8 +7978,8 @@ static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_CPU_SEI_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "CPU SEI. err cause: %s\n",
-						gaudi2_cpu_sei_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_cpu_sei_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -8012,7 +7990,7 @@ static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev)
 	return error_count;
 }
 
-static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
+static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index, u16 event_type,
 					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
 					u64 *event_mask)
 {
@@ -8022,8 +8000,8 @@ static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_ROT_ERR_CAUSE ; i++)
 		if (intr_cause_data & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "ROT%u. err cause: %s\n",
-						rot_index, guadi2_rot_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", guadi2_rot_error_cause[i]);
 			error_count++;
 		}
 
@@ -8034,7 +8012,7 @@ static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index,
 	return error_count;
 }
 
-static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, char *interrupt_name,
+static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, u16 event_type,
 					struct hl_eq_razwi_with_intr_cause *razwi_with_intr_cause,
 					u64 *event_mask)
 {
@@ -8044,8 +8022,8 @@ static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, char
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_TPC_INTR_CAUSE ; i++)
 		if (intr_cause_data & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "TPC%d_%s interrupt cause: %s\n",
-					tpc_index, interrupt_name, gaudi2_tpc_interrupts_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"interrupt cause: %s",  gaudi2_tpc_interrupts_cause[i]);
 			error_count++;
 		}
 
@@ -8056,7 +8034,7 @@ static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, char
 	return error_count;
 }
 
-static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const char *interrupt_name,
+static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, u16 event_type,
 				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_val = 0, error_count = 0;
@@ -8076,8 +8054,8 @@ static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const cha
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_DEC_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "DEC%u_%s err cause: %s\n",
-					dec_index, interrupt_name, gaudi2_dec_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_dec_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -8093,7 +8071,7 @@ static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, const cha
 	return error_count;
 }
 
-static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const char *interrupt_name,
+static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, u16 event_type,
 				struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
@@ -8106,8 +8084,8 @@ static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const cha
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_MME_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "MME%u_%s err cause: %s\n",
-					mme_index, interrupt_name, guadi2_mme_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", guadi2_mme_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -8123,22 +8101,22 @@ static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, const cha
 	return error_count;
 }
 
-static int gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u8 mme_index, u8 sbte_index,
+static int gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u16 event_type,
 					u64 intr_cause_data)
 {
 	int i, error_count = 0;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_MME_SBTE_ERR_CAUSE ; i++)
 		if (intr_cause_data & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "MME%uSBTE%u_AXI_ERR_RSP err cause: %s\n",
-					mme_index, sbte_index, guadi2_mme_sbte_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", guadi2_mme_sbte_error_cause[i]);
 			error_count++;
 		}
 
 	return error_count;
 }
 
-static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
+static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index, u16 event_type,
 					struct hl_eq_razwi_info *razwi_info, u64 *event_mask)
 {
 	u32 sts_addr, sts_val, sts_clr_addr, sts_clr_val = 0, error_count = 0;
@@ -8151,9 +8129,8 @@ static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_MME_WAP_ERR_CAUSE ; i++) {
 		if (sts_val & BIT(i)) {
-			dev_err_ratelimited(hdev->dev,
-					"MME%u_WAP_SOURCE_RESULT_INVALID err cause: %s\n",
-					mme_index, guadi2_mme_wap_error_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", guadi2_mme_wap_error_cause[i]);
 			sts_clr_val |= BIT(i);
 			error_count++;
 		}
@@ -8170,7 +8147,8 @@ static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index,
 	return error_count;
 }
 
-static int gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_kdma_core_event(struct hl_device *hdev, u16 event_type,
+					u64 intr_cause_data)
 {
 	u32 error_count = 0;
 	int i;
@@ -8182,23 +8160,24 @@ static int gaudi2_handle_kdma_core_event(struct hl_device *hdev, u64 intr_cause_
 	 */
 	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
 		if (intr_cause_data & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "kdma core err cause: %s\n",
-						gaudi2_kdma_core_interrupts_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_kdma_core_interrupts_cause[i]);
 			error_count++;
 		}
 
 	return error_count;
 }
 
-static int gaudi2_handle_dma_core_event(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_dma_core_event(struct hl_device *hdev, u16 event_type,
+					u64 intr_cause_data)
 {
 	u32 error_count = 0;
 	int i;
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_DMA_CORE_INTR_CAUSE ; i++)
 		if (intr_cause_data & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "dma core err cause: %s\n",
-						gaudi2_dma_core_interrupts_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_dma_core_interrupts_cause[i]);
 			error_count++;
 		}
 
@@ -8238,8 +8217,8 @@ static void gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(struct hl_device *hdev,
 	}
 }
 
-static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_cause_data,
-						u64 *event_mask)
+static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u16 event_type,
+					u64 intr_cause_data, u64 *event_mask)
 {
 	u32 error_count = 0;
 	int i;
@@ -8248,8 +8227,8 @@ static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_caus
 		if (!(intr_cause_data & BIT_ULL(i)))
 			continue;
 
-		dev_err_ratelimited(hdev->dev, "PCIE ADDR DEC Error: %s\n",
-					gaudi2_pcie_addr_dec_error_cause[i]);
+		gaudi2_print_event(hdev, event_type, true,
+			"err cause: %s", gaudi2_pcie_addr_dec_error_cause[i]);
 		error_count++;
 
 		switch (intr_cause_data & BIT_ULL(i)) {
@@ -8264,7 +8243,8 @@ static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u64 intr_caus
 	return error_count;
 }
 
-static int gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_pif_fatal(struct hl_device *hdev, u16 event_type,
+				u64 intr_cause_data)
 
 {
 	u32 error_count = 0;
@@ -8272,8 +8252,8 @@ static int gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_PMMU_FATAL_ERR_CAUSE ; i++) {
 		if (intr_cause_data & BIT_ULL(i)) {
-			dev_err_ratelimited(hdev->dev, "PMMU PIF err cause: %s\n",
-					gaudi2_pmmu_fatal_interrupts_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_pmmu_fatal_interrupts_cause[i]);
 			error_count++;
 		}
 	}
@@ -8283,16 +8263,13 @@ static int gaudi2_handle_pif_fatal(struct hl_device *hdev, u64 intr_cause_data)
 
 static int gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64 intr_cause_data)
 {
-	u32 dcore_id, hif_id, error_count = 0;
+	u32 error_count = 0;
 	int i;
 
-	dcore_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) / 4;
-	hif_id = (event_type - GAUDI2_EVENT_HIF0_FATAL) % 4;
-
 	for (i = 0 ; i < GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE ; i++) {
 		if (intr_cause_data & BIT_ULL(i)) {
-			dev_err_ratelimited(hdev->dev, "DCORE%u_HIF%u: %s\n", dcore_id, hif_id,
-					gaudi2_hif_fatal_interrupts_cause[i]);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_hif_fatal_interrupts_cause[i]);
 			error_count++;
 		}
 	}
@@ -8343,7 +8320,7 @@ static void gaudi2_handle_access_error(struct hl_device *hdev, u64 mmu_base, boo
 	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_ERROR_CAPTURE), 0);
 }
 
-static int gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char *mmu_name,
+static int gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, u16 event_type,
 						u64 mmu_base, bool is_pmmu, u64 *event_mask)
 {
 	u32 spi_sei_cause, interrupt_clr = 0x0, error_count = 0;
@@ -8353,8 +8330,8 @@ static int gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 
 	for (i = 0 ; i < GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE ; i++) {
 		if (spi_sei_cause & BIT(i)) {
-			dev_err_ratelimited(hdev->dev, "%s SPI_SEI ERR. err cause: %s\n",
-						mmu_name, gaudi2_mmu_spi_sei[i].cause);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s", gaudi2_mmu_spi_sei[i].cause);
 
 			if (i == 0)
 				gaudi2_handle_page_error(hdev, mmu_base, is_pmmu, event_mask);
@@ -8377,7 +8354,7 @@ static int gaudi2_handle_mmu_spi_sei_generic(struct hl_device *hdev, const char
 	return error_count;
 }
 
-static int gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
+static int gaudi2_handle_sm_err(struct hl_device *hdev, u16 event_type, u8 sm_index)
 {
 	u32 sei_cause_addr, sei_cause_val, sei_cause_cause, sei_cause_log,
 		cq_intr_addr, cq_intr_val, cq_intr_queue_index, error_count = 0;
@@ -8400,11 +8377,11 @@ static int gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 			if (!(sei_cause_cause & BIT(i)))
 				continue;
 
-			dev_err_ratelimited(hdev->dev, "SM%u SEI ERR. err cause: %s. %s: 0x%X\n",
-					sm_index,
-					gaudi2_sm_sei_cause[i].cause_name,
-					gaudi2_sm_sei_cause[i].log_name,
-					sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
+			gaudi2_print_event(hdev, event_type, true,
+				"err cause: %s. %s: 0x%X\n",
+				gaudi2_sm_sei_cause[i].cause_name,
+				gaudi2_sm_sei_cause[i].log_name,
+				sei_cause_log & gaudi2_sm_sei_cause[i].log_mask);
 			error_count++;
 			break;
 		}
@@ -8433,7 +8410,6 @@ static int gaudi2_handle_sm_err(struct hl_device *hdev, u8 sm_index)
 static int gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type, u64 *event_mask)
 {
 	bool is_pmmu = false;
-	char desc[32];
 	u32 error_count = 0;
 	u64 mmu_base;
 	u8 index;
@@ -8442,54 +8418,46 @@ static int gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type,
 	case GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM ... GAUDI2_EVENT_HMMU3_SECURITY_ERROR:
 		index = (event_type - GAUDI2_EVENT_HMMU0_PAGE_FAULT_OR_WR_PERM) / 3;
 		mmu_base = mmDCORE0_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_3_AXI_ERR_RSP:
 		index = (event_type - GAUDI2_EVENT_HMMU_0_AXI_ERR_RSP);
 		mmu_base = mmDCORE0_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE0_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU8_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU11_SECURITY_ERROR:
 		index = (event_type - GAUDI2_EVENT_HMMU8_PAGE_FAULT_WR_PERM) / 3;
 		mmu_base = mmDCORE1_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU_8_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_11_AXI_ERR_RSP:
 		index = (event_type - GAUDI2_EVENT_HMMU_8_AXI_ERR_RSP);
 		mmu_base = mmDCORE1_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE1_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU7_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU4_SECURITY_ERROR:
 		index = (event_type - GAUDI2_EVENT_HMMU7_PAGE_FAULT_WR_PERM) / 3;
 		mmu_base = mmDCORE2_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU_7_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_4_AXI_ERR_RSP:
 		index = (event_type - GAUDI2_EVENT_HMMU_7_AXI_ERR_RSP);
 		mmu_base = mmDCORE2_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE2_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU15_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_HMMU12_SECURITY_ERROR:
 		index = (event_type - GAUDI2_EVENT_HMMU15_PAGE_FAULT_WR_PERM) / 3;
 		mmu_base = mmDCORE3_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_HMMU_15_AXI_ERR_RSP ... GAUDI2_EVENT_HMMU_12_AXI_ERR_RSP:
 		index = (event_type - GAUDI2_EVENT_HMMU_15_AXI_ERR_RSP);
 		mmu_base = mmDCORE3_HMMU0_MMU_BASE + index * DCORE_HMMU_OFFSET;
-		snprintf(desc, ARRAY_SIZE(desc), "DCORE3_HMMU%d", index);
 		break;
 	case GAUDI2_EVENT_PMMU0_PAGE_FAULT_WR_PERM ... GAUDI2_EVENT_PMMU0_SECURITY_ERROR:
 	case GAUDI2_EVENT_PMMU_AXI_ERR_RSP_0:
 		is_pmmu = true;
 		mmu_base = mmPMMU_HBW_MMU_BASE;
-		snprintf(desc, ARRAY_SIZE(desc), "PMMU");
 		break;
 	default:
 		return 0;
 	}
 
-	error_count = gaudi2_handle_mmu_spi_sei_generic(hdev, desc, mmu_base, is_pmmu, event_mask);
+	error_count = gaudi2_handle_mmu_spi_sei_generic(hdev, event_type, mmu_base,
+							is_pmmu, event_mask);
 
 	return error_count;
 }
@@ -8611,22 +8579,17 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 
 	cause_idx = sei_data->hdr.sei_cause;
 	if (cause_idx > GAUDI2_NUM_OF_HBM_SEI_CAUSE - 1) {
-		dev_err_ratelimited(hdev->dev, "Invalid HBM SEI event cause (%d) provided by FW\n",
-					cause_idx);
+		gaudi2_print_event(hdev, event_type, true,
+			"err cause: %s",
+			"Invalid HBM SEI event cause (%d) provided by FW\n", cause_idx);
 		return true;
 	}
 
-	if (sei_data->hdr.is_critical)
-		dev_err(hdev->dev,
-			"System Critical Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
-			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
-			hbm_mc_sei_cause[cause_idx]);
-
-	else
-		dev_err_ratelimited(hdev->dev,
-			"System Non-Critical Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
-			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
-			hbm_mc_sei_cause[cause_idx]);
+	gaudi2_print_event(hdev, event_type, !sei_data->hdr.is_critical,
+		"System %s Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
+		sei_data->hdr.is_critical ? "Critical" : "Non-critical",
+		hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
+		hbm_mc_sei_cause[cause_idx]);
 
 	/* Print error-specific info */
 	switch (cause_idx) {
@@ -8670,12 +8633,12 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 	return require_hard_reset;
 }
 
-static int gaudi2_handle_hbm_cattrip(struct hl_device *hdev, u64 intr_cause_data)
+static int gaudi2_handle_hbm_cattrip(struct hl_device *hdev, u16 event_type,
+				u64 intr_cause_data)
 {
 	if (intr_cause_data) {
-		dev_err(hdev->dev,
-			"HBM catastrophic temperature error (CATTRIP) cause %#llx\n",
-			intr_cause_data);
+		gaudi2_print_event(hdev, event_type, true,
+			"temperature error cause: %#llx", intr_cause_data);
 		return 1;
 	}
 
@@ -8708,13 +8671,13 @@ static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type,
 		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_POWER;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].start = ktime_get();
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = zero_time;
-		dev_info_ratelimited(hdev->dev, "Clock throttling due to power consumption\n");
+		dev_dbg_ratelimited(hdev->dev, "Clock throttling due to power consumption\n");
 		break;
 
 	case GAUDI2_EVENT_CPU_FIX_POWER_ENV_E:
 		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_POWER;
 		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = ktime_get();
-		dev_info_ratelimited(hdev->dev, "Power envelop is safe, back to optimal clock\n");
+		dev_dbg_ratelimited(hdev->dev, "Power envelop is safe, back to optimal clock\n");
 		break;
 
 	case GAUDI2_EVENT_CPU_FIX_THERMAL_ENV_S:
@@ -8741,16 +8704,18 @@ static void gaudi2_print_clk_change_info(struct hl_device *hdev, u16 event_type,
 	mutex_unlock(&hdev->clk_throttling.lock);
 }
 
-static void gaudi2_print_out_of_sync_info(struct hl_device *hdev,
+static void gaudi2_print_out_of_sync_info(struct hl_device *hdev, u16 event_type,
 					struct cpucp_pkt_sync_err *sync_err)
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
 
-	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
-		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
+	gaudi2_print_event(hdev, event_type, false,
+		"FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
+		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci),
+		q->pi, atomic_read(&q->ci));
 }
 
-static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
+static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev, u16 event_type)
 {
 	u32 p2p_intr, msix_gw_intr, error_count = 0;
 
@@ -8758,7 +8723,7 @@ static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
 	msix_gw_intr = RREG32(mmPCIE_WRAP_MSIX_GW_INTR);
 
 	if (p2p_intr) {
-		dev_err_ratelimited(hdev->dev,
+		gaudi2_print_event(hdev, event_type, true,
 			"pcie p2p transaction terminated due to security, req_id(0x%x)\n",
 			RREG32(mmPCIE_WRAP_P2P_REQ_ID));
 
@@ -8767,7 +8732,7 @@ static int gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
 	}
 
 	if (msix_gw_intr) {
-		dev_err_ratelimited(hdev->dev,
+		gaudi2_print_event(hdev, event_type, true,
 			"pcie msi-x gen denied due to vector num check failure, vec(0x%X)\n",
 			RREG32(mmPCIE_WRAP_MSIX_GW_VEC));
 
@@ -8822,17 +8787,18 @@ static int gaudi2_handle_psoc_drain(struct hl_device *hdev, u64 intr_cause_data)
 	return error_count;
 }
 
-static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev,
+static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev, u16 event_type,
 					struct cpucp_pkt_sync_err *sync_err)
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
 
-	dev_warn(hdev->dev,
+	gaudi2_print_event(hdev, event_type, false,
 		"FW reported sanity check failure, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
 		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
-static int hl_arc_event_handle(struct hl_device *hdev, struct hl_eq_engine_arc_intr_data *data)
+static int hl_arc_event_handle(struct hl_device *hdev, u16 event_type,
+					struct hl_eq_engine_arc_intr_data *data)
 {
 	struct hl_engine_arc_dccm_queue_full_irq *q;
 	u32 intr_type, engine_id;
@@ -8846,12 +8812,12 @@ static int hl_arc_event_handle(struct hl_device *hdev, struct hl_eq_engine_arc_i
 	case ENGINE_ARC_DCCM_QUEUE_FULL_IRQ:
 		q = (struct hl_engine_arc_dccm_queue_full_irq *) &payload;
 
-		dev_err_ratelimited(hdev->dev,
+		gaudi2_print_event(hdev, event_type, true,
 				"ARC DCCM Full event: EngId: %u, Intr_type: %u, Qidx: %u\n",
 				engine_id, intr_type, q->queue_index);
 		return 1;
 	default:
-		dev_err_ratelimited(hdev->dev, "Unknown ARC event type\n");
+		gaudi2_print_event(hdev, event_type, true, "Unknown ARC event type\n");
 		return 0;
 	}
 }
@@ -8860,8 +8826,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	bool reset_required = false, is_critical = false;
-	u32 ctl, reset_flags = HL_DRV_RESET_HARD, error_count = 0;
-	int index, sbte_index;
+	u32 index, ctl, reset_flags = HL_DRV_RESET_HARD, error_count = 0;
 	u64 event_mask = 0;
 	u16 event_type;
 
@@ -8877,8 +8842,6 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	gaudi2->events_stat[event_type]++;
 	gaudi2->events_stat_aggregate[event_type]++;
 
-	gaudi2_print_irq_info(hdev, event_type);
-
 	switch (event_type) {
 	case GAUDI2_EVENT_PCIE_CORE_SERR ... GAUDI2_EVENT_ARC0_ECC_DERR:
 		fallthrough;
@@ -8901,12 +8864,12 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_ARC_AXI_ERROR_RESPONSE_0:
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
-		error_count = gaudi2_handle_arc_farm_sei_err(hdev);
+		error_count = gaudi2_handle_arc_farm_sei_err(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_CPU_AXI_ERR_RSP:
-		error_count = gaudi2_handle_cpu_sei_err(hdev);
+		error_count = gaudi2_handle_cpu_sei_err(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
@@ -8921,7 +8884,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE:
 	case GAUDI2_EVENT_ROTATOR1_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_ROTATOR0_AXI_ERROR_RESPONSE;
-		error_count = gaudi2_handle_rot_err(hdev, index,
+		error_count = gaudi2_handle_rot_err(hdev, index, event_type,
 					&eq_entry->razwi_with_intr_cause, &event_mask);
 		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
@@ -8929,7 +8892,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_TPC0_AXI_ERR_RSP ... GAUDI2_EVENT_TPC24_AXI_ERR_RSP:
 		index = event_type - GAUDI2_EVENT_TPC0_AXI_ERR_RSP;
-		error_count = gaudi2_tpc_ack_interrupts(hdev, index, "AXI_ERR_RSP",
+		error_count = gaudi2_tpc_ack_interrupts(hdev, index, event_type,
 						&eq_entry->razwi_with_intr_cause, &event_mask);
 		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
@@ -8937,8 +8900,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 
 	case GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE ... GAUDI2_EVENT_DEC9_AXI_ERR_RSPONSE:
 		index = event_type - GAUDI2_EVENT_DEC0_AXI_ERR_RSPONSE;
-		error_count = gaudi2_handle_dec_err(hdev, index, "AXI_ERR_RESPONSE",
-					&eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_dec_err(hdev, index, event_type,
+						&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8969,8 +8932,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_TPC24_KERNEL_ERR:
 		index = (event_type - GAUDI2_EVENT_TPC0_KERNEL_ERR) /
 			(GAUDI2_EVENT_TPC1_KERNEL_ERR - GAUDI2_EVENT_TPC0_KERNEL_ERR);
-		error_count = gaudi2_tpc_ack_interrupts(hdev, index, "KRN_ERR",
-				&eq_entry->razwi_with_intr_cause, &event_mask);
+		error_count = gaudi2_tpc_ack_interrupts(hdev, index, event_type,
+					&eq_entry->razwi_with_intr_cause, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -8986,7 +8949,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_DEC9_SPI:
 		index = (event_type - GAUDI2_EVENT_DEC0_SPI) /
 				(GAUDI2_EVENT_DEC1_SPI - GAUDI2_EVENT_DEC0_SPI);
-		error_count = gaudi2_handle_dec_err(hdev, index, "SPI",
+		error_count = gaudi2_handle_dec_err(hdev, index, event_type,
 					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -8998,8 +8961,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE) /
 				(GAUDI2_EVENT_MME1_CTRL_AXI_ERROR_RESPONSE -
 						GAUDI2_EVENT_MME0_CTRL_AXI_ERROR_RESPONSE);
-		error_count = gaudi2_handle_mme_err(hdev, index,
-				"CTRL_AXI_ERROR_RESPONSE", &eq_entry->razwi_info, &event_mask);
+		error_count = gaudi2_handle_mme_err(hdev, index, event_type,
+				&eq_entry->razwi_info, &event_mask);
 		error_count += gaudi2_handle_qm_sei_err(hdev, event_type, NULL, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -9011,7 +8974,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_QMAN_SW_ERROR) /
 				(GAUDI2_EVENT_MME1_QMAN_SW_ERROR -
 					GAUDI2_EVENT_MME0_QMAN_SW_ERROR);
-		error_count = gaudi2_handle_mme_err(hdev, index, "QMAN_SW_ERROR",
+		error_count = gaudi2_handle_mme_err(hdev, index, event_type,
 					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -9023,26 +8986,26 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		index = (event_type - GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID) /
 				(GAUDI2_EVENT_MME1_WAP_SOURCE_RESULT_INVALID -
 					GAUDI2_EVENT_MME0_WAP_SOURCE_RESULT_INVALID);
-		error_count = gaudi2_handle_mme_wap_err(hdev, index,
+		error_count = gaudi2_handle_mme_wap_err(hdev, index, event_type,
 					&eq_entry->razwi_info, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_KDMA_CH0_AXI_ERR_RSP:
 	case GAUDI2_EVENT_KDMA0_CORE:
-		error_count = gaudi2_handle_kdma_core_event(hdev,
+		error_count = gaudi2_handle_kdma_core_event(hdev, event_type,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_HDMA2_CORE ... GAUDI2_EVENT_PDMA1_CORE:
-		error_count = gaudi2_handle_dma_core_event(hdev,
+		error_count = gaudi2_handle_dma_core_event(hdev, event_type,
 					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_PCIE_ADDR_DEC_ERR:
-		error_count = gaudi2_print_pcie_addr_dec_info(hdev,
+		error_count = gaudi2_print_pcie_addr_dec_info(hdev, event_type,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data), &event_mask);
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
@@ -9065,7 +9028,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_PMMU_FATAL_0:
-		error_count = gaudi2_handle_pif_fatal(hdev,
+		error_count = gaudi2_handle_pif_fatal(hdev, event_type,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		reset_flags |= HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
@@ -9086,7 +9049,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_HBM_CATTRIP_0 ... GAUDI2_EVENT_HBM_CATTRIP_5:
-		error_count = gaudi2_handle_hbm_cattrip(hdev,
+		error_count = gaudi2_handle_hbm_cattrip(hdev, event_type,
 				le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
@@ -9122,14 +9085,8 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	case GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME1_SBTE4_AXI_ERR_RSP:
 	case GAUDI2_EVENT_MME2_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME2_SBTE4_AXI_ERR_RSP:
 	case GAUDI2_EVENT_MME3_SBTE0_AXI_ERR_RSP ... GAUDI2_EVENT_MME3_SBTE4_AXI_ERR_RSP:
-		index = (event_type - GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP) /
-				(GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP -
-					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
-		sbte_index = (event_type - GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP) %
-				(GAUDI2_EVENT_MME1_SBTE0_AXI_ERR_RSP -
-					GAUDI2_EVENT_MME0_SBTE0_AXI_ERR_RSP);
-		error_count = gaudi2_handle_mme_sbte_err(hdev, index, sbte_index,
-					le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
+		error_count = gaudi2_handle_mme_sbte_err(hdev, event_type,
+						le64_to_cpu(eq_entry->intr_cause.intr_cause_data));
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 	case GAUDI2_EVENT_VM0_ALARM_A ... GAUDI2_EVENT_VM3_ALARM_B:
@@ -9217,7 +9174,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_QUEUE_OUT_SYNC:
-		gaudi2_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
+		gaudi2_print_out_of_sync_info(hdev, event_type, &eq_entry->pkt_sync_err);
 		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
@@ -9229,13 +9186,13 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_PCIE_P2P_MSIX:
-		error_count = gaudi2_handle_pcie_p2p_msix(hdev);
+		error_count = gaudi2_handle_pcie_p2p_msix(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
 	case GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE ... GAUDI2_EVENT_SM3_AXI_ERROR_RESPONSE:
 		index = event_type - GAUDI2_EVENT_SM0_AXI_ERROR_RESPONSE;
-		error_count = gaudi2_handle_sm_err(hdev, index);
+		error_count = gaudi2_handle_sm_err(hdev, event_type, index);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9258,13 +9215,13 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_CPU_PKT_SANITY_FAILED:
-		gaudi2_print_cpu_pkt_failure_info(hdev, &eq_entry->pkt_sync_err);
+		gaudi2_print_cpu_pkt_failure_info(hdev, event_type, &eq_entry->pkt_sync_err);
 		error_count = GAUDI2_NA_EVENT_CAUSE;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI2_EVENT_ARC_DCCM_FULL:
-		error_count = hl_arc_event_handle(hdev, &eq_entry->arc_data);
+		error_count = hl_arc_event_handle(hdev, event_type, &eq_entry->arc_data);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
@@ -9286,7 +9243,9 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 	 * Note that although we have counted the errors, we use this number as
 	 * a boolean.
 	 */
-	if (error_count == 0 && !is_info_event(event_type))
+	if (error_count == GAUDI2_NA_EVENT_CAUSE && !is_info_event(event_type))
+		gaudi2_print_event(hdev, event_type, true, "%d", event_type);
+	else if (error_count == 0)
 		dev_err_ratelimited(hdev->dev,
 			"No Error cause for H/W event %d\n", event_type);
 
-- 
2.25.1

