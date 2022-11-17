Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5450362E166
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiKQQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiKQQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690878D7A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03A06B82104
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB3FC433C1;
        Thu, 17 Nov 2022 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668701998;
        bh=0qrYKoGFSGwe6KK/rIbg5V80Mliqyjd1Au0nd5otEuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhfGgnwZSSHpYJQzOnJ01AWNsCXy86vxm4Q90h202h8wU2iF4AFRQ98InonYPqwkc
         nrvxrTcRU40fwUWyRBXOz+94KyjK7/iArX4KVNOey53AvBogPwz4WmqzfeE09vBYft
         YEn+dB7uplZ0vvYN4gIXJiPdYRlt0KlzzMZOHLT+v7btBpqyxv/3EtIMJoEwv4Zefn
         E+spwYDeR3jMoVlqff7ws1T6R67xvxuli+VyVIhMN7mVVnw/Qz0fgTQBaidCSeMYm5
         fJoqyhSX1gJTvLuLqUn4wAQ1R8lfHxIcSHxZze4qYXEj4KMCwrqOIzMgrSGTwe4uPt
         QByv6zdcUMH8Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 02/20] habanalabs/gaudi: add razwi notify event
Date:   Thu, 17 Nov 2022 18:19:33 +0200
Message-Id: <20221117161951.845454-2-ogabbay@kernel.org>
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

Each time razwi (read-only zero, write ignore) happens, besides
capturing its data, also notify the user about it.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     |  8 +++++
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 37 +++++++++++----------
 include/uapi/misc/habanalabs.h              |  2 ++
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 35ed494fcfdf..d1a609589558 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2409,6 +2409,14 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 			num_of_engines * sizeof(u16));
 	hdev->captured_err_info.razwi.flags = flags;
 }
+
+void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
+			u8 flags, u64 *event_mask)
+{
+	hl_capture_razwi(hdev, addr, engine_id, num_of_engines, flags);
+	*event_mask |= HL_NOTIFIER_EVENT_RAZWI;
+}
+
 static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 {
 	struct page_fault_info *pgf_info = &hdev->captured_err_info.pgf_info;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e391e7951fb7..d9335f3769b8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3812,6 +3812,8 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 __printf(2, 3) void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
 void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
 			u8 flags);
+void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
+			u8 flags, u64 *event_mask);
 void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3dfb9ecf7db3..035865cb097c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7301,7 +7301,7 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 }
 
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
-					bool razwi)
+					bool razwi, u64 *event_mask)
 {
 	bool is_read = false, is_write = false;
 	u16 engine_id[2], num_of_razwi_eng = 0;
@@ -7337,7 +7337,8 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 				num_of_razwi_eng = 1;
 		}
 
-		hl_capture_razwi(hdev, razwi_addr, engine_id, num_of_razwi_eng, razwi_flags);
+		hl_handle_razwi(hdev, razwi_addr, engine_id, num_of_razwi_eng, razwi_flags,
+				event_mask);
 	}
 }
 
@@ -7675,7 +7676,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
 	case GAUDI_EVENT_MMU_DERR:
 	case GAUDI_EVENT_NIC0_CS_DBG_DERR ... GAUDI_EVENT_NIC4_CS_DBG_DERR:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
@@ -7685,7 +7686,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_AXI_ECC:
 	case GAUDI_EVENT_L2_RAM_ECC:
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
@@ -7694,7 +7695,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_HBM1_SPI_0:
 	case GAUDI_EVENT_HBM2_SPI_0:
 	case GAUDI_EVENT_HBM3_SPI_0:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
@@ -7706,7 +7707,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_HBM1_SPI_1:
 	case GAUDI_EVENT_HBM2_SPI_1:
 	case GAUDI_EVENT_HBM3_SPI_1:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
@@ -7728,7 +7729,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		 * if the event is a TPC Assertion or a "real" TPC DEC.
 		 */
 		event_mask |= HL_NOTIFIER_EVENT_TPC_ASSERT;
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_dec_event_to_tpc_id(event_type),
 					"AXI_SLV_DEC_Error");
@@ -7753,7 +7754,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_TPC5_KRN_ERR:
 	case GAUDI_EVENT_TPC6_KRN_ERR:
 	case GAUDI_EVENT_TPC7_KRN_ERR:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_krn_event_to_tpc_id(event_type),
 					"KRN_ERR");
@@ -7792,7 +7793,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
 		fallthrough;
 	case GAUDI_EVENT_MMU_SERR:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		hl_fw_unmask_irq(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
@@ -7802,14 +7803,14 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_CPU_AXI_SPLITTER:
 	case GAUDI_EVENT_PSOC_AXI_DEC:
 	case GAUDI_EVENT_PSOC_PRSTN_FALL:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		break;
 
 	case GAUDI_EVENT_MMU_PAGE_FAULT:
 	case GAUDI_EVENT_MMU_WR_PERM:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -7838,14 +7839,14 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_NIC4_QM1:
 	case GAUDI_EVENT_DMA0_CORE ... GAUDI_EVENT_DMA7_CORE:
 	case GAUDI_EVENT_TPC0_QM ... GAUDI_EVENT_TPC7_QM:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		gaudi_handle_qman_err(hdev, event_type, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
 		event_mask |= (HL_NOTIFIER_EVENT_USER_ENGINE_ERR | HL_NOTIFIER_EVENT_DEVICE_RESET);
 		break;
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
-		gaudi_print_irq_info(hdev, event_type, true);
+		gaudi_print_irq_info(hdev, event_type, true, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		goto reset_device;
 
@@ -7858,7 +7859,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	case GAUDI_EVENT_TPC6_BMON_SPMU:
 	case GAUDI_EVENT_TPC7_BMON_SPMU:
 	case GAUDI_EVENT_DMA_BM_CH0 ... GAUDI_EVENT_DMA_BM_CH7:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		hl_fw_unmask_irq(hdev, event_type);
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
@@ -7870,7 +7871,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		break;
 
 	case GAUDI_EVENT_DMA_IF_SEI_0 ... GAUDI_EVENT_DMA_IF_SEI_3:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		gaudi_print_sm_sei_info(hdev, event_type,
 					&eq_entry->sm_sei_data);
 		rc = hl_state_dump(hdev);
@@ -7899,18 +7900,18 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 		break;
 
 	case GAUDI_EVENT_DEV_RESET_REQ:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_PKT_QUEUE_OUT_SYNC:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_FW_ALIVE_S:
-		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_irq_info(hdev, event_type, false, &event_mask);
 		gaudi_print_fw_alive_info(hdev, &eq_entry->fw_alive);
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		goto reset_device;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 58343998bd63..7747e19e81fe 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -721,6 +721,7 @@ enum hl_server_type {
  * HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	- Indicates device is unavailable
  * HL_NOTIFIER_EVENT_USER_ENGINE_ERR	- Indicates device engine in error state
  * HL_NOTIFIER_EVENT_GENERAL_HW_ERR     - Indicates device HW error
+ * HL_NOTIFIER_EVENT_RAZWI              - Indicates razwi happened
  */
 #define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
 #define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
@@ -729,6 +730,7 @@ enum hl_server_type {
 #define HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE	(1ULL << 4)
 #define HL_NOTIFIER_EVENT_USER_ENGINE_ERR	(1ULL << 5)
 #define HL_NOTIFIER_EVENT_GENERAL_HW_ERR	(1ULL << 6)
+#define HL_NOTIFIER_EVENT_RAZWI			(1ULL << 7)
 
 /* Opcode for management ioctl
  *
-- 
2.25.1

