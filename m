Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61956710D60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbjEYNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbjEYNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:38:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6239F1A8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3093d10442aso1429864f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685021929; x=1687613929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyuLCEhn8GX5O7IyV3OsDqUmT5UuCj/vH6uAj7jFQ0U=;
        b=X916qYIOlP2m32ZpnG9P9ll3mYMCDzS1HhJHfPkU9SptQ4EpmpeTWxXEcu+VwpK4BH
         xmw5QJwQWqHyAfxhuO3CQ/nTD85vSeKKEC7fgPHvpuLh4DlrHIS7akh/A9XFK8cM1CJY
         g/JzfCtgU4HjHgPvbJbEUYinHXKsn7j+Z7rWF2N8NBCS1rq7RoiCHRBPwvd2gdvsTrn+
         Jfc5mi30sITqFdL79WFHe/SUO+2C+zHQyYxiuUhJl9tQbelV9htUipV/IMB35fCTaa+w
         DQ30OxUemA2kjVyQhUwP6sW6G5L7RcNgS5XfGN6xUhaKdnhzaWsnyh2PPpJ4oq7nujoS
         KLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021929; x=1687613929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyuLCEhn8GX5O7IyV3OsDqUmT5UuCj/vH6uAj7jFQ0U=;
        b=kFNR8kB/JRaVYqv/XKd6f6t4Oct7jtdcWirPTc8KT4p0/HP58aBH8QGMd3gVtXiLMr
         XrZlgxBKR48Z5JjB9SILMBKsqZZPY4zTVBn0HHatQz62e9BLV6OhJO/CJWiVDCBvGqp5
         75IhAX0yrL6SdxHrNql7NTDWD99l7Ii7R2OSLN0uiKmpyK+DfICAcXsKaNNG0gWfOSlb
         JpoNTMPbDT1Hdd6o9JboCabywfSddNvCUmDT6IGwaiGae+zDqTfYvSbjSmtB2dN9RSl7
         ynbsg5B77KBFQv/1Pucezw3eRUMAWOXuAwkF5pk+3bPUN5gonlDWNoCl7WJYgyvpAioJ
         gMEg==
X-Gm-Message-State: AC+VfDy8iZ1RGEzwsFN1BTslJFFglwW2V5+5jf+bCjvdUnMZkP7T2I3Q
        PHJArmO6PS3uoJ121SQHgxhXuw==
X-Google-Smtp-Source: ACHHUZ4bTttKZxh7vwGsOqquSDQW3VpZNQJ26RqX4KKyHaCGAIXJhw0NoJTiFO4JjCyEAnFfONBeSg==
X-Received: by 2002:adf:f251:0:b0:306:31e0:958 with SMTP id b17-20020adff251000000b0030631e00958mr2346226wrp.15.1685021928828;
        Thu, 25 May 2023 06:38:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b00301a351a8d6sm1803641wrv.84.2023.05.25.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 06:38:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/4] soundwire: qcom: wait for fifo to be empty before suspend
Date:   Thu, 25 May 2023 14:38:10 +0100
Message-Id: <20230525133812.30841-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
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

Wait for Fifo to be empty before going to suspend or before bank
switch happens. Just to make sure that all the reads/writes are done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 9440787e924b..adf025194a31 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -404,6 +404,32 @@ static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *ctrl)
 	return 0;
 }
 
+static bool swrm_wait_for_wr_fifo_done(struct qcom_swrm_ctrl *ctrl)
+{
+	u32 fifo_outstanding_cmds, value;
+	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	/* Check for fifo overflow during write */
+	ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS], &value);
+	fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+
+	if (fifo_outstanding_cmds) {
+		while (fifo_retry_count) {
+			usleep_range(500, 510);
+			ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS], &value);
+			fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+			fifo_retry_count--;
+			if (fifo_outstanding_cmds == 0)
+				return true;
+		}
+	} else {
+		return true;
+	}
+
+
+	return false;
+}
+
 static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
 				     u8 dev_addr, u16 reg_addr)
 {
@@ -434,6 +460,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
 		usleep_range(150, 155);
 
 	if (cmd_id == SWR_BROADCAST_CMD_ID) {
+		swrm_wait_for_wr_fifo_done(ctrl);
 		/*
 		 * sleep for 10ms for MSM soundwire variant to allow broadcast
 		 * command to complete.
@@ -1230,6 +1257,7 @@ static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
 
+	swrm_wait_for_wr_fifo_done(ctrl);
 	sdw_release_stream(ctrl->sruntime[dai->id]);
 	ctrl->sruntime[dai->id] = NULL;
 	pm_runtime_mark_last_busy(ctrl->dev);
@@ -1688,6 +1716,7 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
+	swrm_wait_for_wr_fifo_done(ctrl);
 	if (!ctrl->clock_stop_not_supported) {
 		/* Mask bus clash interrupt */
 		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
-- 
2.21.0

