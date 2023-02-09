Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECB369099D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBINOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBINNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4CD5D1F6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:52 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3843959wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtCm7HHmygVV89PU04X4kKxKy0d9QS0qb0ALCWzJ2AE=;
        b=eSuI9ZqfTFGJOUknn/oOE6Qc01UKQtJJwm8VLN8g1fySb9QrJk6G4Hp6FLYreiKmA8
         0CiV/M+NSOwLIvlOFBCO4kCFbkNmdhiNUkHEYUa4+yYKKPcx4Ixm2Y3/d8ZhNTYpJlPQ
         mdTKwLDVP3iLzONlcUZT9P5bT2/jVxg6HJbRiRhm3e0LsXBCkALnt9kpadjxUtx9SM5e
         dN9Run2nQ2NC0RJEXdwEcXzfWAsUNAPXeVJzYrRM8oZZ+Jm/GuoGWHFpbyBzUnw/TViC
         33RQpX9wjEPe/5l2sAsCHy+7eCHOPTipoEnzHpRfNTZO3KvAIuFmqNZ5CKwZ+9yWPfJs
         Abkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtCm7HHmygVV89PU04X4kKxKy0d9QS0qb0ALCWzJ2AE=;
        b=HyEqA1aOtK5Uwzy0b0l+SYw7P+r/MOIiZBrYEXWM3o4i3gwVUqg8UU7Js58jqDBf5R
         hYLz7tD6bj+CWqiToPIZsHRUcpgaJAVvBvy5ez+q2pTFwBc8AokZTz6UXksMQB++bL/D
         TYjy54K0KWbq6t+DUTDx/g8r8ltHtc5NSjJnVucgzXIZc3RQho39YIsnOYSLn39QB0mK
         m5gFVxcCCAcd+CoPnXSyArW/4eN8mMzv4xU22Rn9DPLlrixht7cnK1oD/gQxHV+pBDOJ
         VHJ5quoEyn43VnrSyULHsFkPq2LAWUIcKilIh7ewvFycXnbf2mjeZyLiWshXLv/ldpkB
         FBrA==
X-Gm-Message-State: AO0yUKWAljLyZJcsxNk86z5Hj1G8QTgQUHOCi3USHb/9/UndGZ95Lw0m
        Iif2DTY6L6A5TAeULrQJEHu+xprxwgFfJkLB
X-Google-Smtp-Source: AK7set/MyhWYDmBCQIobeqNcHgJIA0aF22fzJ/STfU/NfAy05+kaDxntzWIP9Kfc8s8dkxaOHTLHPg==
X-Received: by 2002:a05:600c:3198:b0:3e0:15c:3573 with SMTP id s24-20020a05600c319800b003e0015c3573mr9426269wmp.35.1675948430859;
        Thu, 09 Feb 2023 05:13:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] soundwire: qcom: wait for fifo to be empty before suspend
Date:   Thu,  9 Feb 2023 13:13:34 +0000
Message-Id: <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
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

Wait for Fifo to be empty before going to suspend or before bank
switch happens. Just to make sure that all the reads/writes are done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index b2363839624c..465b2a2ef0d5 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -325,6 +325,32 @@ static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
 	return 0;
 }
 
+static bool swrm_wait_for_wr_fifo_done(struct qcom_swrm_ctrl *swrm)
+{
+	u32 fifo_outstanding_cmds, value;
+	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
+
+	/* Check for fifo overflow during write */
+	swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
+	fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
+
+	if (fifo_outstanding_cmds) {
+		while (fifo_retry_count) {
+			usleep_range(500, 510);
+			swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
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
 static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 				     u8 dev_addr, u16 reg_addr)
 {
@@ -356,6 +382,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
 		usleep_range(150, 155);
 
 	if (cmd_id == SWR_BROADCAST_CMD_ID) {
+		swrm_wait_for_wr_fifo_done(swrm);
 		/*
 		 * sleep for 10ms for MSM soundwire variant to allow broadcast
 		 * command to complete.
@@ -1122,6 +1149,7 @@ static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
 
+	swrm_wait_for_wr_fifo_done(ctrl);
 	sdw_release_stream(ctrl->sruntime[dai->id]);
 	ctrl->sruntime[dai->id] = NULL;
 	pm_runtime_mark_last_busy(ctrl->dev);
@@ -1558,6 +1586,7 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
+	swrm_wait_for_wr_fifo_done(ctrl);
 	if (!ctrl->clock_stop_not_supported) {
 		/* Mask bus clash interrupt */
 		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
-- 
2.21.0

