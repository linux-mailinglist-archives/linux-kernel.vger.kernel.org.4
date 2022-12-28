Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B8657FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiL1QIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiL1QHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B441573F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD68B8171C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAADFC433EF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243657;
        bh=78wymq3OwhxZbBEu6j8CWmZ7ee2RToTwyEazzIecNnQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qWGI/qZXQrvbsRLEANtX3fm1WDjFS6urXa4fJcbzQzViocsxXS1LhYjIVXOsQ07/D
         n/c1KbvBAhLtIASL/NAZkGEtRLNP0QXGD5sOaXESekzToC0mFbAbLAxOyro4Ea7xy4
         eNi5SivTKkCAOp1N65WCQvlwymbLVc5iBHfMWJkzVYvF2QH8XuuI4l28QqcuHPEWcC
         tjFph7XGD5W7zUuuMpRe5X8j4BzsClqrdQ6tlnrMs60wdrfjMZrCrxCpyiP5Qnfl8e
         ayfkJPGFJL7cM2JMH8hGGHfVYASCrxzvFGiOrH4uW5THifG504yp/WOTy6/T5OGJzA
         OG2yiTkv50CPA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] habanalabs/gaudi2: update f/w files
Date:   Wed, 28 Dec 2022 18:07:18 +0200
Message-Id: <20221228160723.387-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
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

Update gaudi2 firmware files with the latest version.
There is no functional change.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/include/gaudi2/gaudi2_fw_if.h  | 23 +++++++++++--------
 .../include/gaudi2/gaudi2_reg_map.h           | 16 +++++++------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
index e4a7d5725096..82f3ca2a3966 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_fw_if.h
@@ -20,22 +20,25 @@
 
 #define GAUDI2_NUM_MME			4
 
+#define NUM_OF_GPIOS_PER_PORT		16
+#define GAUDI2_WD_GPIO			(62 % NUM_OF_GPIOS_PER_PORT)
+
 #define GAUDI2_ARCPID_TX_MB_SIZE	0x1000
 #define GAUDI2_ARCPID_RX_MB_SIZE	0x400
 #define GAUDI2_ARM_TX_MB_SIZE		0x400
 #define GAUDI2_ARM_RX_MB_SIZE		0x1800
 
 #define GAUDI2_DCCM_BASE_ADDR		0x27020000
-#define GAUDI2_ARCPID_TX_MB_ADDR	GAUDI2_DCCM_BASE_ADDR
-
-#define GAUDI2_ARCPID_RX_MB_ADDR	(GAUDI2_ARCPID_TX_MB_ADDR +	\
-					GAUDI2_ARCPID_TX_MB_SIZE)
 
 #define GAUDI2_ARM_TX_MB_ADDR		GAUDI2_MAILBOX_BASE_ADDR
 
 #define GAUDI2_ARM_RX_MB_ADDR		(GAUDI2_ARM_TX_MB_ADDR + \
 					GAUDI2_ARM_TX_MB_SIZE)
 
+#define GAUDI2_ARCPID_TX_MB_ADDR	(GAUDI2_ARM_RX_MB_ADDR + GAUDI2_ARM_RX_MB_SIZE)
+
+#define GAUDI2_ARCPID_RX_MB_ADDR	(GAUDI2_ARCPID_TX_MB_ADDR + GAUDI2_ARCPID_TX_MB_SIZE)
+
 #define GAUDI2_ARM_TX_MB_OFFSET		(GAUDI2_ARM_TX_MB_ADDR - \
 					GAUDI2_SP_SRAM_BASE_ADDR)
 
@@ -58,7 +61,9 @@ struct gaudi2_cold_rst_data {
 			u32 spsram_init_done : 1;
 			u32 fake_security_enable : 1;
 			u32 fake_sig_validation_en : 1;
-			u32 reserved : 26;
+			u32 bist_skip_enable : 1;
+			u32 bist_need_iatu_config : 1;
+			u32 reserved : 24;
 		};
 		__le32 data;
 	};
@@ -77,10 +82,10 @@ enum gaudi2_rst_src {
 };
 
 struct gaudi2_redundancy_ctx {
-	int redundant_hbm;
-	int redundant_edma;
-	int redundant_tpc;
-	int redundant_vdec;
+	__le32 redundant_hbm;
+	__le32 redundant_edma;
+	__le32 redundant_tpc;
+	__le32 redundant_vdec;
 	__le64 hbm_mask;
 	__le64 edma_mask;
 	__le64 tpc_mask;
diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
index ae7feb388f63..f3eaeb6d9b7e 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_reg_map.h
@@ -24,14 +24,14 @@
 #define mmGIC_HOST_HALT_IRQ_POLL_REG		mmPSOC_GLOBAL_CONF_SCRATCHPAD_10
 #define mmGIC_HOST_INTS_IRQ_POLL_REG		mmPSOC_GLOBAL_CONF_SCRATCHPAD_11
 #define mmGIC_HOST_SOFT_RST_IRQ_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_12
-#define mmEEPROM_COPY_LOCATION_REG		mmPSOC_GLOBAL_CONF_SCRATCHPAD_13
 #define mmCPU_RST_STATUS_TO_HOST		mmPSOC_GLOBAL_CONF_SCRATCHPAD_14
-#define mmENGINE_ARC_IRQ_CTRL_POLL_REG		mmPSOC_GLOBAL_CONF_SCRATCHPAD_15
-#define mmPID_CFG_REG				mmPSOC_GLOBAL_CONF_SCRATCHPAD_18
 /*
- * TODO: mmGIC_RAZWI_STATUS_REG is temporary
- * macro and to be removed after GAUDI2 PO
+ *  Single scratchpad register used for all ARCs to notify dccm queue full event to FW.
+ *  So a new event would overwrite any unhandled previous event. In other words, incase
+ *  of multiple events before previous ones are handled, last one would be considered.
  */
+#define mmENGINE_ARC_IRQ_CTRL_POLL_REG		mmPSOC_GLOBAL_CONF_SCRATCHPAD_15
+#define mmPID_CFG_REG				mmPSOC_GLOBAL_CONF_SCRATCHPAD_18
 #define mmGIC_RAZWI_STATUS_REG			mmPSOC_GLOBAL_CONF_SCRATCHPAD_19
 #define mmCPU_BOOT_DEV_STS0			mmPSOC_GLOBAL_CONF_SCRATCHPAD_20
 #define mmCPU_BOOT_DEV_STS1			mmPSOC_GLOBAL_CONF_SCRATCHPAD_21
@@ -40,11 +40,10 @@
 #define mmCPU_BOOT_ERR1				mmPSOC_GLOBAL_CONF_SCRATCHPAD_25
 #define mmUPD_STS				mmPSOC_GLOBAL_CONF_SCRATCHPAD_26
 #define mmUPD_CMD				mmPSOC_GLOBAL_CONF_SCRATCHPAD_27
-#define mmUBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_29
+#define mmPPBOOT_VER_OFFSET			mmPSOC_GLOBAL_CONF_SCRATCHPAD_28
 #define mmRDWR_TEST				mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
 #define mmBTL_ID				mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
 #define mmRST_SRC				mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_0
-#define mmPREBOOT_PCIE_EN			mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_1
 #define mmCOLD_RST_DATA				mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_2
 #define mmUPD_PENDING_STS			mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_3
 #define mmPID_CMD_REQ_REG			mmPSOC_PID_PID_CMD_0
@@ -55,5 +54,8 @@
 #define mmPID_CMD_TELEMETRY_REG_0_HI		mmPSOC_PID_PID_CMD_5
 #define mmPID_CMD_TELEMETRY_REG_1		mmPSOC_PID_PID_CMD_6
 #define mmPID_CMD_TELEMETRY_REG_1_HI		mmPSOC_PID_PID_CMD_7
+#define mmWD_GPIO_OUTSET_REG			mmPSOC_GPIO3_OUTENSET
+#define mmWD_GPIO_DATAOUT_REG			mmPSOC_GPIO3_DATAOUT
+#define mmSTM_PROFILER_SPE_REG			mmPSOC_STM_STMSPER
 
 #endif /* GAUDI2_REG_MAP_H_ */
-- 
2.34.1

