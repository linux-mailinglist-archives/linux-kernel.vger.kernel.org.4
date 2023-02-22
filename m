Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3382069F220
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBVJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBVJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:47:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8203A86F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:46:07 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B0B4866021D4;
        Wed, 22 Feb 2023 09:43:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058985;
        bh=QLUE6gweejlnVZKkySch/QDsSqbrZL8wTCZxRZLCRkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Az6tc/ddE8y2KAl2HzuVlrtJbg8p6y/QCMj+LY17E+uey84JRNm4RVFIoZInorF/8
         8P06AalpXwNGCvZwN2beagEfIoBEJengdPxXi8M4KTcGMs+pqnrMn3YTtRQh5QXbpy
         t7KnGth9jk9pw9XF9pVr0tsCB3A90pAj8CJ5+d6Iox2XfTluMl1PpdeELngEaK5GYG
         10+7PsORVre2ca4geI2lapOhIoFMSUVkUcQTjBGEAzMsK/LpbrmdWY8TzukUu4FlLM
         6HDMs+UNts96Sn2BVBlrarM439J7aJO00j+tAD92TV10isK9HWbKyueRoZW3eYg9bI
         I0uVTCubJK0WA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 8/9] soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
Date:   Wed, 22 Feb 2023 10:42:52 +0100
Message-Id: <20230222094253.23678-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.39.2

