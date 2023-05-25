Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80A7710D61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjEYNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbjEYNi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:38:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F35197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3093a778089so1414132f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685021930; x=1687613930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e4d294AXuwEBJZs4agoGK3jhgST3++yYamvsMPJTfc=;
        b=enk4tTOQPqyHhGGVUkh9wjJsA+DGP6BHKoVWWDAlaJEvZCUrr23mZ+YlG9L5sjUQjQ
         GEbt9AUjp5qgBY+RhmWKG3vK5BHzOlewlsaGRCa3wk5O5rFzoe9gn5CfCObtYlzoG9dq
         Mt0xwQH5Qa6wKEBBKGo6mrCCfEFHuGI0HUipri/Op0kJkA5JrBfnIxFtu6upGjumZ6rO
         JEXdo73k+YDPY5oQTEVGWGPllS34akWbHkst6za7pkb8f55CmRUBcWPgor7mkJEv5WVa
         mZgY1O/guESCD+AxM6rKPYsbU191IRl2aQjtVQbwqFPG+vc64TJcGKiDZ97dhvLasFSn
         0wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021930; x=1687613930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e4d294AXuwEBJZs4agoGK3jhgST3++yYamvsMPJTfc=;
        b=HMcvyfMrcE/aSD/Vv6wi26sVMFyGY+d6jRPnLfSBOF7ZcOecPZAhHOTebOpC8+8/zp
         yi7LSP7NpHpPdvEOfG1mpG8D0TChj05fXEPw0NbqiNZS30vfvB9FJH+fGxBrRovY0KBg
         /0Ezif+VGYS42PwDHVwATOai7tqwLEZb6enAlvTtQZ5EBn3ilW/cNzvj5dAiOpx2Y4lr
         20zbEgXsnh1oGSGHYHkNwBej09ervFeQ1w5LU3TWI4NZzG24+eG5/UDqEnsXu93G1Wbu
         rvZY4CKmPKFqLjUfjNlY6sAlf3DkPPVdE8305BszX0YfPQJZ06kCo+dVX5XvKIaWbdBr
         NZkA==
X-Gm-Message-State: AC+VfDy1vSbv6ojnMHuJUx/iLmu3jy4s3ExPkOywMinjI2mhicdJuZwt
        4Ha2gXBVInvv0JwjGzt6YvU1BA==
X-Google-Smtp-Source: ACHHUZ4O35f2uYOCtYMctE+1Yzb4uQOY0hA9HEUzlSdXlmKszPcNeQYC9QWL6M48LVxqYKuT78K5iQ==
X-Received: by 2002:a5d:5710:0:b0:30a:bdfd:5c3c with SMTP id a16-20020a5d5710000000b0030abdfd5c3cmr1549534wrv.17.1685021930276;
        Thu, 25 May 2023 06:38:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b00301a351a8d6sm1803641wrv.84.2023.05.25.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 06:38:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/4] soundwire: qcom: add software workaround for bus clash interrupt assertion
Date:   Thu, 25 May 2023 14:38:11 +0100
Message-Id: <20230525133812.30841-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes Hard reset does not clear some of the registers,
this sometimes results in firing a bus clash interrupt.
Add workaround for this during power up sequence, as
suggested by hardware manual.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 56 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index adf025194a31..1d2a105cb77f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -793,6 +793,26 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *ctrl)
+{
+	int retry = SWRM_LINK_STATUS_RETRY_CNT;
+	int comp_sts;
+
+	do {
+		ctrl->reg_read(ctrl, SWRM_COMP_STATUS, &comp_sts);
+
+		if (comp_sts & SWRM_FRM_GEN_ENABLED)
+			return true;
+
+		usleep_range(500, 510);
+	} while (retry--);
+
+	dev_err(ctrl->dev, "%s: link status not %s\n", __func__,
+		comp_sts & SWRM_FRM_GEN_ENABLED ? "connected" : "disconnected");
+
+	return false;
+}
+
 static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 {
 	u32 val;
@@ -841,16 +861,28 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 				SWRM_RD_WR_CMD_RETRIES);
 	}
 
+	/* COMP Enable */
+	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR, SWRM_COMP_CFG_ENABLE_MSK);
+
 	/* Set IRQ to PULSE */
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
-			SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
-			SWRM_COMP_CFG_ENABLE_MSK);
+			SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK);
+
+	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
+			0xFFFFFFFF);
 
 	/* enable CPU IRQs */
 	if (ctrl->mmio) {
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 				SWRM_INTERRUPT_STATUS_RMSK);
 	}
+
+	/* Set IRQ to PULSE */
+	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
+			SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
+			SWRM_COMP_CFG_ENABLE_MSK);
+
+	swrm_wait_for_frame_gen_enabled(ctrl);
 	ctrl->slave_status = 0;
 	ctrl->reg_read(ctrl, SWRM_COMP_PARAMS, &val);
 	ctrl->rd_fifo_depth = FIELD_GET(SWRM_COMP_PARAMS_RD_FIFO_DEPTH, val);
@@ -1626,26 +1658,6 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *ctrl)
-{
-	int retry = SWRM_LINK_STATUS_RETRY_CNT;
-	int comp_sts;
-
-	do {
-		ctrl->reg_read(ctrl, SWRM_COMP_STATUS, &comp_sts);
-
-		if (comp_sts & SWRM_FRM_GEN_ENABLED)
-			return true;
-
-		usleep_range(500, 510);
-	} while (retry--);
-
-	dev_err(ctrl->dev, "%s: link status not %s\n", __func__,
-		comp_sts & SWRM_FRM_GEN_ENABLED ? "connected" : "disconnected");
-
-	return false;
-}
-
 static int __maybe_unused swrm_runtime_resume(struct device *dev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
-- 
2.21.0

