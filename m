Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A341B6F5732
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjECLeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjECLeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:34:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E111268B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:34:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CBFE56603137;
        Wed,  3 May 2023 12:34:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683113662;
        bh=Gj6A+un8r1QWElAagp5zDVAgfl0pGla/oA/vRjwfzxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbCuGRvcGZM3gl/VcwXhnEvM3JsvydoH6TP/0t+ncFEZqbKdHKjJf73zqAPPzFGW2
         nJb6xnVZhrj48PS+tPMX0M9/acadRZOg8lcrb/+KJ2KBclN+dDP175/MdxII2Ymkjs
         9RdpRCYeJbB18jj6RE6+ylyJca9UCZaqh/PL7y4ELbMScGnjrVE+BR/z+Zk7aWMAfY
         rkzuXMboJZHL1Aza50FpNuMspCTVN8wPuNnh1At2iYvpH6Wm2tDlxuh1c1gd78rC66
         EvwCXq3sOiwfLU6HZ0utyT8V6/ntdsT6ZlsszEzNPo5KEf1zfUrm73nvvu0EPlRGPq
         qmjKZjSeVITmg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, nicolas.ferre@microchip.com,
        u.kleine-koenig@pengutronix.de, chunxu.li@mediatek.com,
        tinghan.shen@mediatek.com, error27@gmail.com, ribalda@chromium.org,
        yc.hung@mediatek.com, Allen-KH.Cheng@mediatek.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 1/5] ASoC: SOF: mediatek: mt8195: Use snd_sof_ipc_process_reply() helper
Date:   Wed,  3 May 2023 13:34:09 +0200
Message-Id: <20230503113413.149235-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
References: <20230503113413.149235-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mt8195_get_reply() performs practically the same operation
as the common snd_sof_ipc_get_reply() helper: removing the custom
function allows us to simply perform a call to the sof-priv helper
snd_sof_ipc_process_reply(), simplifying and shortening this driver
and getting all the benefits of using a common API.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 36 +-------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 42bae574c87a..7d6a568556ea 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -49,47 +49,13 @@ static int mt8195_send_msg(struct snd_sof_dev *sdev,
 	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
 }
 
-static void mt8195_get_reply(struct snd_sof_dev *sdev)
-{
-	struct snd_sof_ipc_msg *msg = sdev->msg;
-	struct sof_ipc_reply reply;
-	int ret = 0;
-
-	if (!msg) {
-		dev_warn(sdev->dev, "unexpected ipc interrupt\n");
-		return;
-	}
-
-	/* get reply */
-	sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
-	if (reply.error < 0) {
-		memcpy(msg->reply_data, &reply, sizeof(reply));
-		ret = reply.error;
-	} else {
-		/* reply has correct size? */
-		if (reply.hdr.size != msg->reply_size) {
-			dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
-				msg->reply_size, reply.hdr.size);
-			ret = -EINVAL;
-		}
-
-		/* read the message */
-		if (msg->reply_size > 0)
-			sof_mailbox_read(sdev, sdev->host_box.offset,
-					 msg->reply_data, msg->reply_size);
-	}
-
-	msg->reply_error = ret;
-}
-
 static void mt8195_dsp_handle_reply(struct mtk_adsp_ipc *ipc)
 {
 	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
-	mt8195_get_reply(priv->sdev);
-	snd_sof_ipc_reply(priv->sdev, 0);
+	snd_sof_ipc_process_reply(priv->sdev, 0);
 	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
 }
 
-- 
2.40.1

