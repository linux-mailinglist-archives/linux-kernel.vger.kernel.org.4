Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C367565CE59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjADIbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjADIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:31:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EFE186AA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:31:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g16so25541405plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4+dLuHlcC9jnNQMQw94DnzReVIGUmjOcxr5KvYMev8U=;
        b=Y6p8ZQAFtVMjaWUXOOmJW3dVg7sTCZDpqgmsww1yv78ELTsTvUOzzh1vI4HKCoA/I/
         YDKeO3dbrEB3Uxq4ikf+PWOZI49nPxuRhtLY//2wK2Jj4JLmZE8cxt4ADlPRaqFJRfJd
         LTxf/SNUMnvBAqj9hsojG7XuTAN2ANr3weauE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+dLuHlcC9jnNQMQw94DnzReVIGUmjOcxr5KvYMev8U=;
        b=UlJ4aIqtSwaH1V8NqkThLALIwl0b1wQweIpKgSe6z8t2D3/5m2QSYf5MYqpRBJbS+W
         AYgyPviBVpcLOozI84v+SpEUdLST3e2JJRWrUdM2I8DoFtuOTtTU8Zf4K9uWmeY4fuws
         Gw5yuU5z2WLcUBcr43zmX6bmKn6GFdZ5zCBjI1vYnhR/mXqpqWcAPT4nM2lxMnFooJrW
         SPXoUe8oqfguTppL7MhSzF0omQziZATx6H18enfJXAENRmpLOUj158/nGo3AipTqZFdN
         hv+sTzp9R/q5MmxVo3Qrn1FYpSgvngnS8V+ClO7rNaxfeUUbVXU6yhnGpW0vzeTLr8pz
         nPmg==
X-Gm-Message-State: AFqh2kpRCGYgpmetwB1iYSTsWLtFYfs3YajtatPnuZSdWtOM3Z2+W5by
        Q9VDSAeDIF0hDwLdVK1+gmqZSw==
X-Google-Smtp-Source: AMrXdXujFnG7dDV9MJtsjkA59x1G95RzXq9CimM7pdZKe0Di/GVPavoCYPnyhRWzT/EOvKLsFiYF/g==
X-Received: by 2002:a05:6a20:1e55:b0:a2:a636:70c2 with SMTP id cy21-20020a056a201e5500b000a2a63670c2mr66048817pzb.24.1672821085870;
        Wed, 04 Jan 2023 00:31:25 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:9ef5:c3c1:77a5:2cd])
        by smtp.gmail.com with ESMTPSA id g16-20020a63fa50000000b0046b1dabf9a8sm19781604pgk.70.2023.01.04.00.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 00:31:25 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH] remoteproc/mtk_scp: Move clk ops outside send_lock
Date:   Wed,  4 Jan 2023 16:31:10 +0800
Message-Id: <20230104083110.736377-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks are properly reference counted and do not need to be inside the
lock range.

Right now this triggers a false-positive lockdep warning on MT8192 based
Chromebooks, through a combination of mtk-scp that has a cros-ec-rpmsg
sub-device, the (actual) cros-ec I2C adapter registration, I2C client
(not on cros-ec) probe doing i2c transfers and enabling clocks.

This is a false positive because the cros-ec-rpmsg under mtk-scp does
not have an I2C adapter, and also each I2C adapter and cros-ec instance
have their own mutex.

Move the clk operations outside of the send_lock range.

Fixes: ("63c13d61eafe remoteproc/mediatek: add SCP support for mt8183")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/remoteproc/mtk_scp_ipi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 00f041ebcde6..4c0d121c2f54 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -164,21 +164,21 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
 		return -EINVAL;
 
-	mutex_lock(&scp->send_lock);
-
 	ret = clk_prepare_enable(scp->clk);
 	if (ret) {
 		dev_err(scp->dev, "failed to enable clock\n");
-		goto unlock_mutex;
+		return ret;
 	}
 
+	mutex_lock(&scp->send_lock);
+
 	 /* Wait until SCP receives the last command */
 	timeout = jiffies + msecs_to_jiffies(2000);
 	do {
 		if (time_after(jiffies, timeout)) {
 			dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
 			ret = -ETIMEDOUT;
-			goto clock_disable;
+			goto unlock_mutex;
 		}
 	} while (readl(scp->reg_base + scp->data->host_to_scp_reg));
 
@@ -205,10 +205,9 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 			ret = 0;
 	}
 
-clock_disable:
-	clk_disable_unprepare(scp->clk);
 unlock_mutex:
 	mutex_unlock(&scp->send_lock);
+	clk_disable_unprepare(scp->clk);
 
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

