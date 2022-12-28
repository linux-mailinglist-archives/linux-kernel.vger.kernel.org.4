Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B266580B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiL1QTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiL1QSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:18:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBF19C16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so13303097pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCFU0KCqTh7FlQ8evG955AiRt86XIvSnki+8nWo+njQ=;
        b=GC4TcWpBQl00n4Y1fqaF8bTVq2/KnhyWyJ3s4AMB8/9MIP9ntBMY0TWweRIge8i1EQ
         lk4F1KiY+FtYLf2e7QqDESspd2fPqQoqPNNvhGinnvehLQ2M9LZ5gT14gT+7XcyvXzT1
         rx1YJowuaJrw3OYziAYFJwAWOdKSo27bKmzAg4SM8exV+5Jp7tTRJTK2YN9Db2TJjIO6
         KKXS2G8qz4MkJT+3Ky6SZklbrn/zo9a7xZbs5o49mRBSE7+5f6yy0+XiHzlBrlJNX9yW
         3DgOnA3pjb+V1nngG6/WLfY/BaSWyelZpfesVsTNQPHd/iJFXocVBjkq7J//BxUxSsDv
         jMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCFU0KCqTh7FlQ8evG955AiRt86XIvSnki+8nWo+njQ=;
        b=laV8NmdiXGPp9wNbzeRMSJOH6jDVQRR+7ur6ENMx28nU9ktPhQlxFQkNnYlhn6OTKW
         p2IBTxYcm9b6kLoxyeuWks5G21jwcAPjn3FxgylhHsuSenLuBB/a5VHXkmx9TdaGteYY
         ugtjvzHRQGF6aLLjWx8YSoDgrVvhfWPQxpyvIHAnpuoIE851fZo5BgcuLkspRtYrVWFq
         p5R4PN04alCVIWHNPUfVuxiC9gDjm/YD6uXOpnXt21/MzIlBOw8y3wlf7HEoMsWRyGFt
         UASgUGA6q87b0WlFt7HUMDaL8G5FZH+rixOSi3MFxk/9cp1A27qcWw4PbRJ49nPi7G9u
         9HIg==
X-Gm-Message-State: AFqh2kp9xRWH29yzr/SUJ071bSB+Rui8A0hQ+xKnP6+IdTi1gGSutq6q
        6JHcWUO6sclzD8ZcLxVfoR/a
X-Google-Smtp-Source: AMrXdXslfCaH8dI1dD3KxXGW8+I2yw8KJ/SiFwQ5aFGEWO/GU5SuXXkjlkDm87wvjtrevGu/DF2Whg==
X-Received: by 2002:a17:902:b401:b0:189:aa51:e27f with SMTP id x1-20020a170902b40100b00189aa51e27fmr32379244plr.44.1672244246949;
        Wed, 28 Dec 2022 08:17:26 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.100])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b00186abb95bfdsm11256798pls.25.2022.12.28.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:17:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/6] bus: mhi: ep: Only send -ENOTCONN status if client driver is available
Date:   Wed, 28 Dec 2022 21:47:01 +0530
Message-Id: <20221228161704.255268-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
References: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
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

For the STOP and RESET commands, only send the channel disconnect status
-ENOTCONN if client driver is available. Otherwise, it will result in
null pointer dereference.

Cc: <stable@vger.kernel.org> # 5.19
Fixes: e827569062a8 ("bus: mhi: ep: Add support for processing command rings")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 8b065a3cc848..7d68b00bdbcf 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -203,9 +203,11 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 		mhi_ep_mmio_disable_chdb(mhi_cntrl, ch_id);
 
 		/* Send channel disconnect status to client drivers */
-		result.transaction_status = -ENOTCONN;
-		result.bytes_xferd = 0;
-		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		if (mhi_chan->xfer_cb) {
+			result.transaction_status = -ENOTCONN;
+			result.bytes_xferd = 0;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
 
 		/* Set channel state to STOP */
 		mhi_chan->state = MHI_CH_STATE_STOP;
@@ -235,9 +237,11 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 		mhi_ep_ring_reset(mhi_cntrl, ch_ring);
 
 		/* Send channel disconnect status to client driver */
-		result.transaction_status = -ENOTCONN;
-		result.bytes_xferd = 0;
-		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		if (mhi_chan->xfer_cb) {
+			result.transaction_status = -ENOTCONN;
+			result.bytes_xferd = 0;
+			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
+		}
 
 		/* Set channel state to DISABLED */
 		mhi_chan->state = MHI_CH_STATE_DISABLED;
-- 
2.25.1

