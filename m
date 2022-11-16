Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256FF62BC03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiKPLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiKPLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:33:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BC1006F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:23:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r127-20020a1c4485000000b003cfdd569507so348501wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N1mOPkZ3MzR0fsML9fgfG9WIBiiWvpE6G+bsj4JBTc=;
        b=ZUMybwO/HC36h+YEBFiFcnrR8/RjEiEateLLSxPHoI0e4h3kgQKD5hxsY1lY8EkCvk
         3CjCJfDJgDqREUf81LK53mdWnsDPtK/7zApQ9IFIp+/CaEo+4+9kmcdr+bJcgH98X+Jj
         guj7CI30/LAXUwxtIFrQ2ixY/vUL2eyT9b+hyE91zoCIBwyW5p0vF/pjQG5jpvMmI6io
         W5VUfdK6mvI7c1/GYwFFUTqMNdjhu9DHzTjvLogc3shwUJJsRCGFzY0AhJ/r6sxvrZ+x
         myhDmcL8isLscu2LWLTZRLjjK+TPWokjEB+08jk9YbvugYHnwR9QJwqX0U3+c5XvGhIF
         eXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N1mOPkZ3MzR0fsML9fgfG9WIBiiWvpE6G+bsj4JBTc=;
        b=1YJPtsGOQsCm4MbVgO3n/eEANKWVoS8gZNS4UFLkO6NWsZOb+4AbJ49Um5FicoEBxx
         PgGwCvfpksbGCLL2wQnfmoIz+VJxiMBhNtwf0/uUwCP0bUhsC8B74b32GsPttF8FzV7Y
         LB+P/YyGKqYkGFRSim+Dm6RKDvstmz2FcEIqATN6vzGOXrA5YwEwXkBGe2t8w5QDV/pK
         8JNiZWAE6pcTtxRd8eRY7Q8+ZUKkPfYA2/nA0X5ST+aBiKRbXmhHblRMcmvUI0AndcNw
         KnrmANCrKOPSuo3S1RflWlpdbSu+RJjOgR8D4IyAbzaQnLApYiXYuEVvpfnXmCwk1O3e
         Aa8A==
X-Gm-Message-State: ANoB5plo45Zossoe5zUmNy/GQQDXE6XGKn2Aqr4kkcGCZGgfJneqpa9Y
        LYp3nHTcqlRBSojD6bQhV4lqug==
X-Google-Smtp-Source: AA0mqf71+ajTcmJNX7P4cfklm/EFFrrdYgWdEfyfRhJ9ejBlnLInOH3FdtNj5i99pGGufHdMREzQhg==
X-Received: by 2002:a05:600c:6890:b0:3cf:54f4:eea with SMTP id fn16-20020a05600c689000b003cf54f40eeamr1851925wmb.105.1668597779316;
        Wed, 16 Nov 2022 03:22:59 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05600c1e0600b003cfd42821dasm1972894wmb.3.2022.11.16.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:22:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets
Date:   Wed, 16 Nov 2022 13:22:45 +0200
Message-Id: <20221116112246.2640648-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 RSC has a new set of register offsets due to its version bump.
So read the version from HW and use the proper register offsets based on
that.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |   7 ++
 drivers/soc/qcom/rpmh-rsc.c      | 161 ++++++++++++++++++++-----------
 2 files changed, 110 insertions(+), 58 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 39f53586f724..0160c1669583 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -86,6 +86,11 @@ struct rpmh_ctrlr {
 	struct list_head batch_cache;
 };
 
+struct rsc_ver {
+	u32 major;
+	u32 minor;
+};
+
 /**
  * struct rsc_drv: the Direct Resource Voter (DRV) of the
  * Resource State Coordinator controller (RSC)
@@ -129,6 +134,8 @@ struct rsc_drv {
 	wait_queue_head_t tcs_wait;
 	struct rpmh_ctrlr client;
 	struct device *dev;
+	struct rsc_ver ver;
+	u32 *regs;
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c51567b778ef..cc24874d0a95 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -36,16 +36,38 @@
 #define CREATE_TRACE_POINTS
 #include "trace-rpmh.h"
 
-#define RSC_DRV_TCS_OFFSET		672
-#define RSC_DRV_CMD_OFFSET		20
+
+#define RSC_DRV_ID			0
+
+#define MAJOR_VER_MASK			0xFF
+#define MAJOR_VER_SHIFT			16
+#define MINOR_VER_MASK			0xFF
+#define MINOR_VER_SHIFT			8
+
+enum {
+	RSC_DRV_TCS_OFFSET,
+	RSC_DRV_CMD_OFFSET,
+	DRV_SOLVER_CONFIG,
+	DRV_PRNT_CHLD_CONFIG,
+	RSC_DRV_IRQ_ENABLE,
+	RSC_DRV_IRQ_STATUS,
+	RSC_DRV_IRQ_CLEAR,
+	RSC_DRV_CMD_WAIT_FOR_CMPL,
+	RSC_DRV_CONTROL,
+	RSC_DRV_STATUS,
+	RSC_DRV_CMD_ENABLE,
+	RSC_DRV_CMD_MSGID,
+	RSC_DRV_CMD_ADDR,
+	RSC_DRV_CMD_DATA,
+	RSC_DRV_CMD_STATUS,
+	RSC_DRV_CMD_RESP_DATA,
+};
 
 /* DRV HW Solver Configuration Information Register */
-#define DRV_SOLVER_CONFIG		0x04
 #define DRV_HW_SOLVER_MASK		1
 #define DRV_HW_SOLVER_SHIFT		24
 
 /* DRV TCS Configuration Information Register */
-#define DRV_PRNT_CHLD_CONFIG		0x0C
 #define DRV_NUM_TCS_MASK		0x3F
 #define DRV_NUM_TCS_SHIFT		6
 #define DRV_NCPT_MASK			0x1F
@@ -59,35 +81,6 @@
 #define RSC_DRV_CTL_TCS_DATA_LO_MASK	0xFFFFFFFF
 #define RSC_DRV_CTL_TCS_DATA_SIZE	32
 
-/* Offsets for common TCS Registers, one bit per TCS */
-#define RSC_DRV_IRQ_ENABLE		0x00
-#define RSC_DRV_IRQ_STATUS		0x04
-#define RSC_DRV_IRQ_CLEAR		0x08	/* w/o; write 1 to clear */
-
-/*
- * Offsets for per TCS Registers.
- *
- * TCSes start at 0x10 from tcs_base and are stored one after another.
- * Multiply tcs_id by RSC_DRV_TCS_OFFSET to find a given TCS and add one
- * of the below to find a register.
- */
-#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10	/* 1 bit per command */
-#define RSC_DRV_CONTROL			0x14
-#define RSC_DRV_STATUS			0x18	/* zero if tcs is busy */
-#define RSC_DRV_CMD_ENABLE		0x1C	/* 1 bit per command */
-
-/*
- * Offsets for per command in a TCS.
- *
- * Commands (up to 16) start at 0x30 in a TCS; multiply command index
- * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
- */
-#define RSC_DRV_CMD_MSGID		0x30
-#define RSC_DRV_CMD_ADDR		0x34
-#define RSC_DRV_CMD_DATA		0x38
-#define RSC_DRV_CMD_STATUS		0x3C
-#define RSC_DRV_CMD_RESP_DATA		0x40
-
 #define TCS_AMC_MODE_ENABLE		BIT(16)
 #define TCS_AMC_MODE_TRIGGER		BIT(24)
 
@@ -160,16 +153,54 @@ static inline unsigned long xloops_to_cycles(u64 xloops)
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
 
+static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
+	[RSC_DRV_TCS_OFFSET]		= 672,
+	[RSC_DRV_CMD_OFFSET]		= 20,
+	[DRV_SOLVER_CONFIG]		= 0x04,
+	[DRV_PRNT_CHLD_CONFIG]		= 0x0C,
+	[RSC_DRV_IRQ_ENABLE]		= 0x00,
+	[RSC_DRV_IRQ_STATUS]		= 0x04,
+	[RSC_DRV_IRQ_CLEAR]		= 0x08,
+	[RSC_DRV_CMD_WAIT_FOR_CMPL]	= 0x10,
+	[RSC_DRV_CONTROL]		= 0x14,
+	[RSC_DRV_STATUS]		= 0x18,
+	[RSC_DRV_CMD_ENABLE]		= 0x1C,
+	[RSC_DRV_CMD_MSGID]		= 0x30,
+	[RSC_DRV_CMD_ADDR]		= 0x34,
+	[RSC_DRV_CMD_DATA]		= 0x38,
+	[RSC_DRV_CMD_STATUS]		= 0x3C,
+	[RSC_DRV_CMD_RESP_DATA]		= 0x40,
+};
+
+static u32 rpmh_rsc_reg_offset_ver_3_0[] = {
+	[RSC_DRV_TCS_OFFSET]		= 672,
+	[RSC_DRV_CMD_OFFSET]		= 24,
+	[DRV_SOLVER_CONFIG]		= 0x04,
+	[DRV_PRNT_CHLD_CONFIG]		= 0x0C,
+	[RSC_DRV_IRQ_ENABLE]		= 0x00,
+	[RSC_DRV_IRQ_STATUS]		= 0x04,
+	[RSC_DRV_IRQ_CLEAR]		= 0x08,
+	[RSC_DRV_CMD_WAIT_FOR_CMPL]	= 0x20,
+	[RSC_DRV_CONTROL]		= 0x24,
+	[RSC_DRV_STATUS]		= 0x28,
+	[RSC_DRV_CMD_ENABLE]		= 0x2C,
+	[RSC_DRV_CMD_MSGID]		= 0x34,
+	[RSC_DRV_CMD_ADDR]		= 0x38,
+	[RSC_DRV_CMD_DATA]		= 0x3C,
+	[RSC_DRV_CMD_STATUS]		= 0x40,
+	[RSC_DRV_CMD_RESP_DATA]		= 0x44,
+};
+
 static inline void __iomem *
 tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
 {
-	return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
+	return drv->tcs_base + drv->regs[RSC_DRV_TCS_OFFSET] * tcs_id + reg;
 }
 
 static inline void __iomem *
 tcs_cmd_addr(const struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
-	return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
+	return tcs_reg_addr(drv, reg, tcs_id) + drv->regs[RSC_DRV_CMD_OFFSET] * cmd_id;
 }
 
 static u32 read_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
@@ -237,7 +268,7 @@ static void tcs_invalidate(struct rsc_drv *drv, int type)
 		return;
 
 	for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++)
-		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
+		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], m, 0);
 
 	bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
 }
@@ -351,24 +382,25 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
 static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
 {
 	u32 enable;
+	u32 reg = drv->regs[RSC_DRV_CONTROL];
 
 	/*
 	 * HW req: Clear the DRV_CONTROL and enable TCS again
 	 * While clearing ensure that the AMC mode trigger is cleared
 	 * and then the mode enable is cleared.
 	 */
-	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id);
+	enable = read_tcs_reg(drv, reg, tcs_id);
 	enable &= ~TCS_AMC_MODE_TRIGGER;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
 	enable &= ~TCS_AMC_MODE_ENABLE;
-	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	write_tcs_reg_sync(drv, reg, tcs_id, enable);
 
 	if (trigger) {
 		/* Enable the AMC mode on the TCS and then trigger the TCS */
 		enable = TCS_AMC_MODE_ENABLE;
-		write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+		write_tcs_reg_sync(drv, reg, tcs_id, enable);
 		enable |= TCS_AMC_MODE_TRIGGER;
-		write_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, enable);
+		write_tcs_reg(drv, reg, tcs_id, enable);
 	}
 }
 
@@ -384,13 +416,14 @@ static void __tcs_set_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)
 static void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
 {
 	u32 data;
+	u32 reg = drv->regs[RSC_DRV_IRQ_ENABLE];
 
-	data = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_ENABLE);
+	data = readl_relaxed(drv->tcs_base + reg);
 	if (enable)
 		data |= BIT(tcs_id);
 	else
 		data &= ~BIT(tcs_id);
-	writel_relaxed(data, drv->tcs_base + RSC_DRV_IRQ_ENABLE);
+	writel_relaxed(data, drv->tcs_base + reg);
 }
 
 /**
@@ -411,7 +444,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
 
-	irq_status = readl_relaxed(drv->tcs_base + RSC_DRV_IRQ_STATUS);
+	irq_status = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
 
 	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
@@ -423,7 +456,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			u32 sts;
 
 			cmd = &req->cmds[j];
-			sts = read_tcs_cmd(drv, RSC_DRV_CMD_STATUS, i, j);
+			sts = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], i, j);
 			if (!(sts & CMD_STATUS_ISSUED) ||
 			   ((req->wait_for_compl || cmd->wait) &&
 			   !(sts & CMD_STATUS_COMPL))) {
@@ -444,8 +477,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			__tcs_set_trigger(drv, i, false);
 skip:
 		/* Reclaim the TCS */
-		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
-		writel_relaxed(BIT(i), drv->tcs_base + RSC_DRV_IRQ_CLEAR);
+		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
+		writel_relaxed(BIT(i), drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
 		/*
@@ -496,14 +529,14 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		 */
 		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
 
-		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
-		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
-		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
+		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
 		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
 	}
 
-	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
-	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
+	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
+	write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, cmd_enable);
 }
 
 /**
@@ -535,10 +568,10 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 	int i = tcs->offset;
 
 	for_each_set_bit_from(i, drv->tcs_in_use, tcs->offset + tcs->num_tcs) {
-		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i);
+		curr_enabled = read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i);
 
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
-			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, i, j);
+			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
 				if (addr == msg->cmds[k].addr)
 					return -EBUSY;
@@ -649,7 +682,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		 * repurposed TCS to avoid triggering them. tcs->slots will be
 		 * cleaned from rpmh_flush() by invoking rpmh_rsc_invalidate()
 		 */
-		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+		write_tcs_reg_sync(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id, 0);
 		enable_tcs_irq(drv, tcs_id, true);
 	}
 	spin_unlock_irqrestore(&drv->lock, flags);
@@ -957,7 +990,7 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev, struct rsc_drv *d
 		return ret;
 	drv->tcs_base = drv->base + offset;
 
-	config = readl_relaxed(drv->base + DRV_PRNT_CHLD_CONFIG);
+	config = readl_relaxed(drv->base + drv->regs[DRV_PRNT_CHLD_CONFIG]);
 
 	max_tcs = config;
 	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
@@ -1019,6 +1052,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	char drv_id[10] = {0};
 	int ret, irq;
 	u32 solver_config;
+	u32 rsc_id;
 
 	/*
 	 * Even though RPMh doesn't directly use cmd-db, all of its children
@@ -1049,6 +1083,17 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	if (IS_ERR(drv->base))
 		return PTR_ERR(drv->base);
 
+	rsc_id = readl_relaxed(drv->base + RSC_DRV_ID);
+	drv->ver.major = rsc_id & (MAJOR_VER_MASK << MAJOR_VER_SHIFT);
+	drv->ver.major >>= MAJOR_VER_SHIFT;
+	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
+	drv->ver.minor >>= MINOR_VER_SHIFT;
+
+	if (drv->ver.major == 3 && drv->ver.minor == 0)
+		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
+	else
+		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
+
 	ret = rpmh_probe_tcs_config(pdev, drv);
 	if (ret)
 		return ret;
@@ -1072,7 +1117,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
-	solver_config = readl_relaxed(drv->base + DRV_SOLVER_CONFIG);
+	solver_config = readl_relaxed(drv->base + drv->regs[DRV_SOLVER_CONFIG]);
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
@@ -1088,7 +1133,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 
 	/* Enable the active TCS to send requests immediately */
 	writel_relaxed(drv->tcs[ACTIVE_TCS].mask,
-		       drv->tcs_base + RSC_DRV_IRQ_ENABLE);
+		       drv->tcs_base + drv->regs[RSC_DRV_IRQ_ENABLE]);
 
 	spin_lock_init(&drv->client.cache_lock);
 	INIT_LIST_HEAD(&drv->client.cache);
-- 
2.34.1

