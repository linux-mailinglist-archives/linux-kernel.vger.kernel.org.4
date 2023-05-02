Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F756F3EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjEBIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjEBIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:17:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6719AC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:17:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22C2A6605634;
        Tue,  2 May 2023 09:17:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683015425;
        bh=WyrIuIC4WGagg8kPRhnWHAVOa63zEnurfQ7HDmqCi64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHSeO1eiLtSX6zE+WqnJSOda/SpaKrBHCZibLMPDYlqCZxRpPFh2q6tRJ6pSP+uE7
         4tZO3gSLiTflVhXtWw68m9WJBEHdkYCkfQs/6gelGUS4qR7W78mbd3MxVnRp/8EtMr
         NZvwDXisnEzJrhCulFVYZDvYEtRng6Z3BhPczRSuyw0WSWjIYSB4n/TsoK1VEO0kbW
         kbmPr68GuH3tOq9MIp1qhnSsMwIDZr+buT6La9cQeC2ygbIFmoSwjpxAgoH9fJfl0a
         Cv0hr1wFHKT2oA7pA1XPRvFG4upfgrLiJzUf3HylAFmLbupZN9dfRNCpe+vmOxt+1K
         hDevIRUW5l0nA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH 10/11] drm/mediatek: gamma: Make sure relay mode is disabled
Date:   Tue,  2 May 2023 10:16:49 +0200
Message-Id: <20230502081650.25947-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502081650.25947-1-angelogioacchino.delregno@collabora.com>
References: <20230502081650.25947-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable relay mode at the end of LUT programming to make sure that the
processed image goes through.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 8dc6371db56a..3501c8b549be 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -19,6 +19,7 @@
 #define DISP_GAMMA_EN				0x0000
 #define GAMMA_EN					BIT(0)
 #define DISP_GAMMA_CFG				0x0020
+#define GAMMA_RELAY_MODE				BIT(0)
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
@@ -183,6 +184,9 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
+	/* Disable RELAY mode to pass the processed image */
+	cfg_val &= ~GAMMA_RELAY_MODE;
+
 	writel(cfg_val, regs + DISP_GAMMA_CFG);
 }
 
-- 
2.40.1

