Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A2369F6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBVOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBVOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:44:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B173B66D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:44:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so3755489wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xj+mM0ucKmHJT5sr91ZY2NlPnqIfjLGto59YBLJZG8=;
        b=mm5b3EYoWyTwISYAKMHJjmQ1XpiKWHTk60XFv+YfAB9oXmIOOCtYX9ASecKqG016Fb
         6Lk3KnzVwiBJPBUhkm491tFqodYPr6uLamG0ltgktPH7tKTO0ILx8xsPwtn1WTWynjrY
         MdjtiDOv0fyIJasjRno29dnT4NmEOt06VNIapvCLFzk2nrhu8Fl34MB4J/W4lX0MEa2h
         0t+dXK00KRKOc/eS+0Vfg/Jm9BO0z/kCPD7C4YBEtgfCzVBTDU1SA1KXtertIZ99j333
         Qw9AALaKTioiqN5ztjFf4cPUPNX4gH+8dwUgd6Ur4bMfd5wl/rTU/bGhcyf8uUzowDEP
         9VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xj+mM0ucKmHJT5sr91ZY2NlPnqIfjLGto59YBLJZG8=;
        b=5SF6AO6kcMyXDgAT8zLhisUf3m5g5n3rThAHWQiQ63KkNjQDbrFHUyT87OLVObK2z4
         7+QT+JHl2dypysBNXiVIykFnj+MkhSP/bFb+qBp/KW8BX8x3Oe+XJpUON0t+XQMUILDP
         w+C4SKhL7izeQ3fFMUcNNXdlQrVqN0I26Mh0YQVUa1ghbFk6kJZf87/EAIfe8761bIB0
         B8nIwRbVBpxJAQIzUii61DZBjSeCFHc4viNfMSgzS53fpKj/P6V4FJXxzRL47VHRS8j2
         kPmGKsNC3OW/mYzOqk0kdgg0npjV1r9FBZqTdu7LdU2dHVgOshFtHDKn2yIHiZvl0yih
         bsIA==
X-Gm-Message-State: AO0yUKWry/x9c/HpcmDmwQSymS6MT25GIiMqJ+h0QfLMc7ANg9rfjyCC
        lmKd6g7VLWqRAxUtXj53dkUSRA==
X-Google-Smtp-Source: AK7set9zWsGzEIloEL18ZmWsS6kdw9oFWQlNYXiZz/tMZy+rFWGdGw5nFWdWC/pAkubjXOw8zCoktA==
X-Received: by 2002:a05:600c:5112:b0:3e2:201a:5bce with SMTP id o18-20020a05600c511200b003e2201a5bcemr2199872wms.40.1677077055983;
        Wed, 22 Feb 2023 06:44:15 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003e7c89b3514sm5059776wmc.23.2023.02.22.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:44:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] soundwire: qcom: define hardcoded version magic numbers
Date:   Wed, 22 Feb 2023 15:44:11 +0100
Message-Id: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
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

Use a define instead of hard-coded register values for Soundwire
hardware version number, because it is a bit easier to read and allows
to drop explaining comment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index ba502129150d..79bebcecde6d 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -28,6 +28,9 @@
 #define SWRM_LINK_MANAGER_EE					0x018
 #define SWRM_EE_CPU						1
 #define SWRM_FRM_GEN_ENABLED					BIT(0)
+#define SWRM_VERSION_1_3_0					0x01030000
+#define SWRM_VERSION_1_5_1					0x01050001
+#define SWRM_VERSION_1_7_0					0x01070000
 #define SWRM_COMP_HW_VERSION					0x00
 #define SWRM_COMP_CFG_ADDR					0x04
 #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
@@ -351,8 +354,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 	/* Its assumed that write is okay as we do not get any status back */
 	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
 
-	/* version 1.3 or less */
-	if (swrm->version <= 0x01030000)
+	if (swrm->version <= SWRM_VERSION_1_3_0)
 		usleep_range(150, 155);
 
 	if (cmd_id == SWR_BROADCAST_CMD_ID) {
@@ -695,7 +697,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
-	if (ctrl->version >= 0x01070000) {
+	if (ctrl->version >= SWRM_VERSION_1_7_0) {
 		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
 		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
 				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
@@ -704,8 +706,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	}
 
 	/* Configure number of retries of a read/write cmd */
-	if (ctrl->version >= 0x01050001) {
-		/* Only for versions >= 1.5.1 */
+	if (ctrl->version >= SWRM_VERSION_1_5_1) {
 		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
 				SWRM_RD_WR_CMD_RETRIES |
 				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
@@ -1239,7 +1240,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
 					bp_mode, nports);
 	if (ret) {
-		if (ctrl->version <= 0x01030000)
+		if (ctrl->version <= SWRM_VERSION_1_3_0)
 			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
 		else
 			return ret;
@@ -1442,7 +1443,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	/* Clk stop is not supported on WSA Soundwire masters */
-	if (ctrl->version <= 0x01030000) {
+	if (ctrl->version <= SWRM_VERSION_1_3_0) {
 		ctrl->clock_stop_not_supported = true;
 	} else {
 		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
@@ -1527,7 +1528,7 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 	} else {
 		reset_control_reset(ctrl->audio_cgcr);
 
-		if (ctrl->version >= 0x01070000) {
+		if (ctrl->version >= SWRM_VERSION_1_7_0) {
 			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
 			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
 					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
-- 
2.34.1

