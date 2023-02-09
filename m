Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7B69099E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBINOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBINN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B45EBFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so3905842wmp.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efw37swPmywJmQt7P4bh+b3QJPTdP5Sd+iv+/8BqF9I=;
        b=Hm2UVZKn8j00Xjy+/2jHbryM9Im/P1TEbXrvCJSQWCI6WDeX7JKZNB+r2LeTFR8Duw
         52SEspmzdvCK7mZpMpE6Agh8BZZJihf+YT70iQ1F4ISTC7PC3AOpxn9ITwD8rZ+JfnoI
         HOvRf/nRzH9eqPec2J9G+fldT14gl3Rt7V/8u6ZrQ2pAJYnunMy+MIxLx219gj5BUEM7
         6GKNHu1jwzOCT8D3gVJWXcntWIifvc4H8c9q/fdeGKyghfeMfbS9X5WY/dfG1PxFYu/i
         McaheEHsr8hGwE0cqZi0umwPzXKer2TiGkMMnBSXrisXnd3RzyOpGL/JY22nDtqROyfR
         Fg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efw37swPmywJmQt7P4bh+b3QJPTdP5Sd+iv+/8BqF9I=;
        b=wrUo9qAHRfb+CFKlLdgacSq//oDgrmg6m1J4ZP22OHqgQuUESecjXUjgVuZMGu9LDM
         ITr9HKkzxBpkb0IFduLqUAX6hK3taNDWBxcLSvjgE+5HF6ebx8NavDjnjroUy02j9rrB
         Dp/6cmpMvDckKxZ+r1vgxHRYdr36uG1nx6TLn4gzTUYZgr2NDSAwplq3S0Tgm8qJNM6V
         vqcQM1LWdnwKUjW6uUROQjiRKyu2cLDNO3KomGJJwhMvZ3tcR2aY4mkNxrp8BFGwxsNP
         C+rz4EqddaSzrfazkSDZYa33gVeBEmzRw6mdI5oP5mx43kkJ4t6VP+1+5IYPENgjN+4t
         BA6A==
X-Gm-Message-State: AO0yUKVVM4cFKyDx2u59L3obPI4BuJQnP9k/+zFPRfKL1nk1qx2c9+cJ
        eIf2YxFqT/8p6qxC1vu68dm2NQ==
X-Google-Smtp-Source: AK7set/5t4R6vkbCi7xHYljKhRpCdrMwM173eSMG153XkPcECEZOP9zQsPoLSZqZJbWVxrvSBb6VEA==
X-Received: by 2002:a05:600c:1686:b0:3db:2df0:f2b8 with SMTP id k6-20020a05600c168600b003db2df0f2b8mr5574813wmn.36.1675948432059;
        Thu, 09 Feb 2023 05:13:52 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] soundwire: qcom: add software workaround for bus clash interrupt assertion
Date:   Thu,  9 Feb 2023 13:13:35 +0000
Message-Id: <20230209131336.18252-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
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

Sometimes Hard reset does not clear some of the registers,
this sometimes results in firing a bus clash interrupt.
Add workaround for this during power up sequence, as
suggested by hardware manual.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 55 ++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 465b2a2ef0d5..74e38c0d651b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -697,6 +697,26 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
+{
+	int retry = SWRM_LINK_STATUS_RETRY_CNT;
+	int comp_sts;
+
+	do {
+		swrm->reg_read(swrm, SWRM_COMP_STATUS, &comp_sts);
+
+		if (comp_sts & SWRM_FRM_GEN_ENABLED)
+			return true;
+
+		usleep_range(500, 510);
+	} while (retry--);
+
+	dev_err(swrm->dev, "%s: link status %s\n", __func__,
+		comp_sts & SWRM_FRM_GEN_ENABLED ? "connected" : "disconnected");
+
+	return false;
+}
+
 static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 {
 	u32 val;
@@ -741,16 +761,27 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
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
+	ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, 0xFFFFFFFF);
 
 	/* enable CPU IRQs */
 	if (ctrl->mmio) {
 		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
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
@@ -1504,26 +1535,6 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
-{
-	int retry = SWRM_LINK_STATUS_RETRY_CNT;
-	int comp_sts;
-
-	do {
-		swrm->reg_read(swrm, SWRM_COMP_STATUS, &comp_sts);
-
-		if (comp_sts & SWRM_FRM_GEN_ENABLED)
-			return true;
-
-		usleep_range(500, 510);
-	} while (retry--);
-
-	dev_err(swrm->dev, "%s: link status not %s\n", __func__,
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

