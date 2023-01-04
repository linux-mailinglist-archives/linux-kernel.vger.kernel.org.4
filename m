Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9350865D1D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjADLyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjADLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:53:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392361ADB0;
        Wed,  4 Jan 2023 03:53:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DC066602D0F;
        Wed,  4 Jan 2023 11:53:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672833232;
        bh=2wlL/l4UVdjL1Sgoaf9FkMG8l//bAlIIYXjMNm/jsVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nG9YtxlCpjBCeQOKrMwEtYzNapyLY6ccOPHmL66vj0KAIBNw72cQvDIaARvyeFDaL
         yYNo7gzc8J8hgzJX9qwqb/3CHf28jwOdr4e36SnO5d6gmSoiiSpDozdp6wlj+B90oM
         mj37MP7AlorWVTwZLmQzYwRz/sfuAobepb9Sw8TPRTk8Ed6aLcPnDeoJphwmYQhhlU
         cnbVpVFvFM76Hu/cy03ym3Bbh2qJjEIRtkrayygYRVtG2OJqEwzoYDLpslteYrzU9u
         DJTQrLYpAO2s7LxbJ7AZowZj7cPJW6e96VS4e3/Mcox5bxnTkUzkHI61kBhWrceozk
         Pr3ijnFVb6kYQ==
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
Subject: [PATCH 2/2] remoteproc/mtk_scp: Remove timeout variable from scp_ipi_send()
Date:   Wed,  4 Jan 2023 12:53:41 +0100
Message-Id: <20230104115341.320951-3-angelogioacchino.delregno@collabora.com>
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

That variable was used twice, but now it's just used once to store
msecs_to_jiffies(wait), fed to wait_event_timeout(): we might as
well remove it for the sake of cleaning up.

This brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_scp_ipi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
index af47504bdb61..fc55df649b40 100644
--- a/drivers/remoteproc/mtk_scp_ipi.c
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -160,7 +160,6 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 		 unsigned int wait)
 {
 	struct mtk_share_obj __iomem *send_obj = scp->send_buf;
-	unsigned long timeout;
 	u32 val;
 	int ret;
 
@@ -197,10 +196,9 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
 
 	if (wait) {
 		/* wait for SCP's ACK */
-		timeout = msecs_to_jiffies(wait);
 		ret = wait_event_timeout(scp->ack_wq,
 					 scp->ipi_id_ack[id],
-					 timeout);
+					 msecs_to_jiffies(wait));
 		scp->ipi_id_ack[id] = false;
 		if (WARN(!ret, "scp ipi %d ack time out !", id))
 			ret = -EIO;
-- 
2.39.0

