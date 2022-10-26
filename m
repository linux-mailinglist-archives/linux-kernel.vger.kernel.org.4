Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888960DF35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiJZLCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:02:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC4B7EDB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so25671531wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv+lK711vFeOkaa3Qp58DAbyPphjfDZDE3jaNs67Gvk=;
        b=nCFoVQj1TzEu56BZ7+4z29jNcy1DdPyggeQccdQjjd4B46gWsDCDhN9iz/QOxic6lA
         k/nygJ4hASyHt5AZCV6JOveUNr3H2UNBSyveXcadxsD8gINgBi4FWkX1teanfP1nibIW
         SFQ4Vi+fbvTBB1Ge5AjaV9bQXRHqssoGl8Fyfov+2EIoRzOkdH/7jqCUuNRwddNgBtRT
         UUBM0Bx9ZsTkhhC/s36tCYQa3gIV0mADpFbUqQnPLVHOOfJ5FyreoLeiJT4YVriyLN0C
         LESJ1P062nzfBJzNRlOvZrh/cXTBDxzd0mKTaH3Ve9FmOsgcFLJNUDQhul+CIZEfV41U
         T38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv+lK711vFeOkaa3Qp58DAbyPphjfDZDE3jaNs67Gvk=;
        b=vJheMe0LsA0ZavE+VxnTrRYL0xhiKZ0qgnn3Tums+a/rWE82OjmipjwJZrcJvHnpr/
         M5L21/utWUMNIj1InKIaqGHxNu0VAFnh5SvFIg/V1WO9gzZrmtc5a04C59YrS5zdq1vc
         kYZEPAUrlLYjUxKRPYcE4eeM+K/HL7iWqUgcFwkG8ipp/odRcT/HwHPuidIRsML7LDUR
         zsy1b7LG8lBjZva3IdFmganfiLIKTYBEczXwc+SkeI7rR9FRBsCrAvXy66xjA3GkuGbb
         iJB5IIFdMSu+D8w9YOwLONOdfG3dfIsx+IvYlp0mwcYVgb4GGPYlwlrW0rBIsvqB5bfB
         Qo5w==
X-Gm-Message-State: ACrzQf3SIL4ewd+V1AnWYp3E3REbnivbmpTlLYW7LNVjhs4oN8nyLB6J
        Un7IxtRxXr3eSO4lFOSMT4/8R0x9uPu3Yw==
X-Google-Smtp-Source: AMsMyM5/IK0Y55jZRn1DGhW6Oe8RtJZuWJ+ACBij9XW/Sp94JeJDtzyZVdNkfNfHekrL8fZcLBSS2Q==
X-Received: by 2002:a05:6000:1687:b0:231:95e6:e9ec with SMTP id y7-20020a056000168700b0023195e6e9ecmr30383929wrd.275.1666782149546;
        Wed, 26 Oct 2022 04:02:29 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d44c7000000b0023672104c24sm5237415wrr.74.2022.10.26.04.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:02:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 6/6] soundwire: qcom: add support for v1.7 Soundwire Controller
Date:   Wed, 26 Oct 2022 12:02:10 +0100
Message-Id: <20221026110210.6575-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for v1.7 SoundWire Controller which has
support for Multi-EE (Execution Environment), resulting in a
new register and extending field in BUS_CTRL register.

With these updates v1.7.0 is fully supported.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 54d370f4b291..335424870290 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -25,6 +25,8 @@
 
 #define SWRM_COMP_SW_RESET					0x008
 #define SWRM_COMP_STATUS					0x014
+#define SWRM_LINK_MANAGER_EE					0x018
+#define SWRM_EE_CPU						1
 #define SWRM_FRM_GEN_ENABLED					BIT(0)
 #define SWRM_COMP_HW_VERSION					0x00
 #define SWRM_COMP_CFG_ADDR					0x04
@@ -693,7 +695,14 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
 	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
 
-	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
+	if (ctrl->version >= 0x01070000) {
+		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
+		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
+				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
+	} else {
+		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
+	}
+
 	/* Configure number of retries of a read/write cmd */
 	if (ctrl->version > 0x01050001) {
 		/* Only for versions >= 1.5.1 */
@@ -1518,7 +1527,13 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 	} else {
 		reset_control_reset(ctrl->audio_cgcr);
 
-		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
+		if (ctrl->version >= 0x01070000) {
+			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
+			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
+					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
+		} else {
+			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
+		}
 		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
 			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
 
@@ -1582,6 +1597,7 @@ static const struct of_device_id qcom_swrm_of_match[] = {
 	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
 	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
 	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
+	{ .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
 	{/* sentinel */},
 };
 
-- 
2.21.0

