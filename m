Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027665D1D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbjADLx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjADLxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:53:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA7A1ADA6;
        Wed,  4 Jan 2023 03:53:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E60EA6602D0D;
        Wed,  4 Jan 2023 11:53:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672833231;
        bh=vP3IAcg06zI74g3paG4cXxNW+LMkpVI/HPlq08rPNm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlFYipZI9wBvadHJlDs3O0ADsIrxmlpLkBnGKw5RNDS8To3+QNFhXvVLwrWABIR4E
         MNxpDL2tnCDB8QDv6uKbanD2jxChPdL+MBFLJ7kk8I1Z1GofdwrXR0GrZrMQ2Pxva/
         kIfBvnVSFETVHM9NBpM70al6Dfs3TBtFeLIMVNU4mbAw+KpYyTmaI/xa5s5MYDF18f
         yJnd7HxEmEzY81mx8f9xapa1hin+HhoKnBeqw5rj41F8Jl+WyfrtSHcDWe/8NpmDRz
         aQQyQySLuaHcdbvEmANhyie7SKkl7NEM9qcIL33jiPcS0gSCHJcexyeQNc6He4164N
         O4jlIWuoFMm1w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     andersson@kernel.org
Cc:     mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] remoteproc/mtk_scp: Use readl_poll_timeout_atomic() for polling
Date:   Wed,  4 Jan 2023 12:53:40 +0100
Message-Id: <20230104115341.320951-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104115341.320951-1-angelogioacchino.delregno@collabora.com>
References: <20230104115341.320951-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the usage of an open-coded custom tight poll while loop
with the provided readl_poll_timeout_atomic() macro.

This cleanup brings no functional change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp_ipi.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index 4c0d121c2f54..af47504bdb61 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -6,13 +6,17 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/time64.h>
 #include <linux/remoteproc/mtk_scp.h>
 
 #include "mtk_common.h"
 
+#define SCP_TIMEOUT_US		(2000 * USEC_PER_MSEC)
+
 /**
  * scp_ipi_register() - register an ipi function
  *
@@ -157,6 +161,7 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 {
 	struct mtk_share_obj __iomem *send_obj = scp->send_buf;
 	unsigned long timeout;
+	u32 val;
 	int ret;
 
 	if (WARN_ON(id <= SCP_IPI_INIT) || WARN_ON(id >= SCP_IPI_MAX) ||
@@ -173,14 +178,12 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 	mutex_lock(&scp->send_lock);
 
 	 /* Wait until SCP receives the last command */
-	timeout = jiffies + msecs_to_jiffies(2000);
-	do {
-		if (time_after(jiffies, timeout)) {
-			dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
-			ret = -ETIMEDOUT;
-			goto unlock_mutex;
-		}
-	} while (readl(scp->reg_base + scp->data->host_to_scp_reg));
+	ret = readl_poll_timeout_atomic(scp->reg_base + scp->data->host_to_scp_reg,
+					val, !val, 0, SCP_TIMEOUT_US);
+	if (ret) {
+		dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
+		goto unlock_mutex;
+	}
 
 	scp_memcpy_aligned(send_obj->share_buf, buf, len);
 
-- 
2.39.0

