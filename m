Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD226E5E03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDRJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjDRJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:55:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C37A8A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50677365fd1so3170098a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811698; x=1684403698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Nx1BeZSP+2eDoJ5Z7QTitc5BQuzRj7iPixLgT5uLpw=;
        b=cP2Tgbs9PJW8SJKjyhmIKm4CekbTUX8t6OmfP91YAFKLOkbZM6kWE4m/KVKPVPYsEE
         evP4Rn/qR7hHUOfsEEOOloeVCgUrsKuB5J/U3MT+KXmNtZnb5rXVPPb5GyT41n4zXs1L
         Dqg1eOtg5Ozsh3uJg3N96tcIAL1SuDgcYH4YurqBxxV3EaRtK2kzsN3KQiT5Qosxrwq8
         mPk0tXCjfAik4Mq/QWm8Q94DfCl+VISQ0MUXka07xoUcapykDIcBN76NtQ/AiPas42zj
         UdnYuz4QWZ8Iw3iG5hT0INx40IP8V8zzwR75gKDNItflwMZl/GSXEo8z1RaNT4GXp8f7
         88og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811698; x=1684403698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Nx1BeZSP+2eDoJ5Z7QTitc5BQuzRj7iPixLgT5uLpw=;
        b=jcNGj6RexBKLmwgQ91ABVpQxPsvXWvRTPrSn8GURU2GTi0Nf0mUgFIx7BGiA/BWEMM
         lk+YDZXzTUTsAWGJuegFciTQhnaWSIYPfuDF8A8iEo5CElUuk7bzAQd1bjL5gscTKIey
         BR2HZwYXkIrJdGCsT0fxj3JUpV+84PvvUIvjIcNz4mf49gk/k7gvdTt911zSsJE1GD36
         8XsAjTQZyHXJRtDQmMRI/SsJufhNCXGQs3YKMucM2XEmwcxL/j4a4wMZmOh3U2BgRUyr
         ERu99Edtk1G338Hbe+JjzOoY8M1aCUc0flQ2wcxAiU+42YPnfqNpOUhLxZpIJMlT+nYQ
         UtWA==
X-Gm-Message-State: AAQBX9dDWSkKQeKinMBehSiyl7VdPhB01enJKgMbQsrNDOf88OCSvBTk
        ffzIOwJGlzlZjxjA2CWU+OQVHw==
X-Google-Smtp-Source: AKy350Yg8RmJxNJ1gaWfyyJzXgyJ2voFZOhEdiT/87+AsNokT5yzDzf/cLx+B0npO9/hGoGaMVKfxQ==
X-Received: by 2002:a50:fc18:0:b0:504:7ffa:98d9 with SMTP id i24-20020a50fc18000000b005047ffa98d9mr1664216edr.42.1681811698250;
        Tue, 18 Apr 2023 02:54:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id o4-20020a509b04000000b00504d04c939fsm7076578edi.59.2023.04.18.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:54:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 6/7] soundwire: qcom: add support for v2.0.0 controller
Date:   Tue, 18 Apr 2023 11:54:46 +0200
Message-Id: <20230418095447.577001-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Qualcomm Soundwire Controller with a bit different
register layout.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Add tags.
---
 drivers/soundwire/qcom.c | 65 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index eac566f168da..90afc8f15b82 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -31,6 +31,7 @@
 #define SWRM_VERSION_1_3_0					0x01030000
 #define SWRM_VERSION_1_5_1					0x01050001
 #define SWRM_VERSION_1_7_0					0x01070000
+#define SWRM_VERSION_2_0_0					0x02000000
 #define SWRM_COMP_HW_VERSION					0x00
 #define SWRM_COMP_CFG_ADDR					0x04
 #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
@@ -42,6 +43,7 @@
 #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
 #define SWRM_COMP_MASTER_ID					0x104
 #define SWRM_V1_3_INTERRUPT_STATUS				0x200
+#define SWRM_V2_0_INTERRUPT_STATUS				0x5000
 #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
 #define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
 #define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
@@ -54,24 +56,32 @@
 #define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
 #define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
 #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
+#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(11)
+#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(12)
 #define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
 #define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
 #define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
 #define SWRM_INTERRUPT_MAX					17
 #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
 #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
+#define SWRM_V2_0_INTERRUPT_CLEAR				0x5008
 #define SWRM_V1_3_INTERRUPT_CPU_EN				0x210
+#define SWRM_V2_0_INTERRUPT_CPU_EN				0x5004
 #define SWRM_V1_3_CMD_FIFO_WR_CMD				0x300
+#define SWRM_V2_0_CMD_FIFO_WR_CMD				0x5020
 #define SWRM_V1_3_CMD_FIFO_RD_CMD				0x304
+#define SWRM_V2_0_CMD_FIFO_RD_CMD				0x5024
 #define SWRM_CMD_FIFO_CMD					0x308
 #define SWRM_CMD_FIFO_FLUSH					0x1
 #define SWRM_V1_3_CMD_FIFO_STATUS				0x30C
+#define SWRM_V2_0_CMD_FIFO_STATUS				0x5050
 #define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
 #define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
 #define SWRM_CMD_FIFO_CFG_ADDR					0x314
 #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
 #define SWRM_RD_WR_CMD_RETRIES					0x7
 #define SWRM_V1_3_CMD_FIFO_RD_FIFO_ADDR				0x318
+#define SWRM_V2_0_CMD_FIFO_RD_FIFO_ADDR				0x5040
 #define SWRM_RD_FIFO_CMD_ID_MASK				GENMASK(11, 8)
 #define SWRM_ENUMERATOR_CFG_ADDR				0x500
 #define SWRM_ENUMERATOR_SLAVE_DEV_ID_1(m)		(0x530 + 0x8 * (m))
@@ -98,6 +108,11 @@
 #define SWRM_DP_SAMPLECTRL2_BANK(n, m)	(0x113C + 0x100 * (n - 1) + 0x40 * m)
 #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
 #define SWR_V1_3_MSTR_MAX_REG_ADDR				0x1740
+#define SWR_V2_0_MSTR_MAX_REG_ADDR				0x50ac
+
+#define SWRM_V2_0_CLK_CTRL					0x5060
+#define SWRM_V2_0_CLK_CTRL_CLK_START				BIT(0)
+#define SWRM_V2_0_LINK_STATUS					0x5064
 
 #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
 #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
@@ -243,6 +258,26 @@ static const struct qcom_swrm_data swrm_v1_6_data = {
 	.reg_layout = swrm_v1_3_reg_layout,
 };
 
+static const unsigned int swrm_v2_0_reg_layout[] = {
+	[SWRM_REG_FRAME_GEN_ENABLED] = SWRM_V2_0_LINK_STATUS,
+	[SWRM_REG_INTERRUPT_STATUS] = SWRM_V2_0_INTERRUPT_STATUS,
+	[SWRM_REG_INTERRUPT_MASK_ADDR] = 0, /* Not present */
+	[SWRM_REG_INTERRUPT_CLEAR] = SWRM_V2_0_INTERRUPT_CLEAR,
+	[SWRM_REG_INTERRUPT_CPU_EN] = SWRM_V2_0_INTERRUPT_CPU_EN,
+	[SWRM_REG_CMD_FIFO_WR_CMD] = SWRM_V2_0_CMD_FIFO_WR_CMD,
+	[SWRM_REG_CMD_FIFO_RD_CMD] = SWRM_V2_0_CMD_FIFO_RD_CMD,
+	[SWRM_REG_CMD_FIFO_STATUS] = SWRM_V2_0_CMD_FIFO_STATUS,
+	[SWRM_REG_CMD_FIFO_RD_FIFO_ADDR] = SWRM_V2_0_CMD_FIFO_RD_FIFO_ADDR,
+};
+
+static const struct qcom_swrm_data swrm_v2_0_data = {
+	.default_rows = 50,
+	.default_cols = 16,
+	.sw_clk_gate_required = true,
+	.max_reg = SWR_V2_0_MSTR_MAX_REG_ADDR,
+	.reg_layout = swrm_v2_0_reg_layout,
+};
+
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
 static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
@@ -748,18 +783,23 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
-	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
-			SWRM_INTERRUPT_STATUS_RMSK);
+	if (ctrl->version < SWRM_VERSION_2_0_0)
+		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
+				SWRM_INTERRUPT_STATUS_RMSK);
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
-	if (ctrl->version >= SWRM_VERSION_1_7_0) {
+	if (ctrl->version == SWRM_VERSION_1_7_0) {
 		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
 		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
 				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
+	} else if (ctrl->version >= SWRM_VERSION_2_0_0) {
+		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
+		ctrl->reg_write(ctrl, SWRM_V2_0_CLK_CTRL,
+				SWRM_V2_0_CLK_CTRL_CLK_START);
 	} else {
 		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	}
@@ -1609,10 +1649,14 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 	} else {
 		reset_control_reset(ctrl->audio_cgcr);
 
-		if (ctrl->version >= SWRM_VERSION_1_7_0) {
+		if (ctrl->version == SWRM_VERSION_1_7_0) {
 			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
 			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
 					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
+		} else if (ctrl->version >= SWRM_VERSION_2_0_0) {
+			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
+			ctrl->reg_write(ctrl, SWRM_V2_0_CLK_CTRL,
+					SWRM_V2_0_CLK_CTRL_CLK_START);
 		} else {
 			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 		}
@@ -1620,8 +1664,10 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
 
 		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
-		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
-				ctrl->intr_mask);
+		if (ctrl->version < SWRM_VERSION_2_0_0)
+			ctrl->reg_write(ctrl,
+					ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
+					ctrl->intr_mask);
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 				ctrl->intr_mask);
 
@@ -1645,8 +1691,10 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 	if (!ctrl->clock_stop_not_supported) {
 		/* Mask bus clash interrupt */
 		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
-		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
-				ctrl->intr_mask);
+		if (ctrl->version < SWRM_VERSION_2_0_0)
+			ctrl->reg_write(ctrl,
+					ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
+					ctrl->intr_mask);
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 				ctrl->intr_mask);
 		/* Prepare slaves for clock stop */
@@ -1684,6 +1732,7 @@ static const struct of_device_id qcom_swrm_of_match[] = {
 	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
 	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
 	{ .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
+	{ .compatible = "qcom,soundwire-v2.0.0", .data = &swrm_v2_0_data },
 	{/* sentinel */},
 };
 
-- 
2.34.1

