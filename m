Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFA69950F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBPNAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBPNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C77460B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 972F066021B0;
        Thu, 16 Feb 2023 13:00:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552432;
        bh=xTuZaQlAntk6Qk8/c2NRbpSHRNuDsWSTVCBYxnSeJHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ynv7Jtbakt/v+F2cJ9nfEm5iNvpmNj+OocNu2bT5JlxjwFbO2G8jlYzWbr3HGhBim
         7d/574+cvtxNQt7IgKuClYtcyGBQs/Qy0lrf6RE49n8Dp3HvT1NDurROGpFhQPpeo9
         RMKNgT5acXH2ejf4i77vnJ7ZK8ZKP6Zz3n15QpfU/vXGYzmA0eo+ZVM7njlNYv4MkN
         Iaz35OUTgBpt3g7IbUBMzLV/l2vV6G9eR9K57GAM8n5AyoEZ9KtpNAyFpDsdGGUKCB
         z/SY3OHOOWJ90SP9n+6HnkSzUQzHCVQyW6z83aEAtDKTOZFfKlB6jLalDT/l3U0uRd
         NAsWou8XmM71Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 8/9] soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
Date:   Thu, 16 Feb 2023 14:00:20 +0100
Message-Id: <20230216130021.64875-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
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

In preparation for a cleanup of ifdef instances of IS_REACHABLE() for
the CONFIG_MTK_CMDQ configuration option, add inline functions that
will either return a failure or, for void functions, do nothing.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/linux/soc/mediatek/mtk-cmdq.h | 114 ++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 2b498f4f3946..649955d2cf5c 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -27,6 +27,8 @@ struct cmdq_client {
 	struct mbox_chan *chan;
 };
 
+#if IS_ENABLED(CONFIG_MTK_CMDQ)
+
 /**
  * cmdq_dev_get_client_reg() - parse cmdq client reg from the device
  *			       node of CMDQ client
@@ -277,4 +279,116 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
  */
 int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
 
+#else /* IS_ENABLED(CONFIG_MTK_CMDQ) */
+
+static inline int cmdq_dev_get_client_reg(struct device *dev,
+					  struct cmdq_client_reg *client_reg, int idx)
+{
+	return -ENODEV;
+}
+
+static inline struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void cmdq_mbox_destroy(struct cmdq_client *client) { }
+
+static inline  struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline void cmdq_pkt_destroy(struct cmdq_pkt *pkt) { }
+
+static inline int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
+				      u16 offset, u32 value, u32 mask)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_read_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
+				  u16 addr_low, u16 reg_idx)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
+				   u16 addr_low, u16 src_reg_idx)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
+					u16 addr_low, u16 src_reg_idx, u32 mask)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
+					 u16 addr_low, u32 value)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_write_s_mask_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
+					      u16 addr_low, u32 value, u32 mask)
+{
+	return -ENOENT;
+}
+
+static inline int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_poll(struct cmdq_pkt *pkt, u8 subsys,
+				u16 offset, u32 value)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
+				     u16 offset, u32 value, u32 mask)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
+{
+	return -EINVAL;
+}
+
+static inline int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
+{
+	return -EINVAL;
+}
+
+#endif /* IS_ENABLED(CONFIG_MTK_CMDQ) */
+
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.39.1

