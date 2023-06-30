Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D386743E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjF3PPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjF3PPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:15:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5D35A6;
        Fri, 30 Jun 2023 08:15:02 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DF3E6606E97;
        Fri, 30 Jun 2023 16:14:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688138101;
        bh=tcKN7V8jMwtJgXP8lIYDvUvaVxlTOIgSGTz9xCOpjsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/aAyYSmIBa5KAv+QEzgrw1/k4ttW/5EKTk8U3srrHGpLEBI0R3HuOhFpa9sE0skj
         j6vJ2sKO9t9B2gXTTn1w0U58UMIdTPR76ATQgVaGFiHD2aMeL7vQ8Eu4tKdFugmJNE
         AxKr7tSCDMQSGh3zE61Eh3gw9ow+K6skcdPLSmwvd2HI/+0xOKJzs4FUW9EM6AdEcf
         hdYWe3tvOnLAnlJfO3wMfl7KkqiEcRnZG3VHn6aN+2DHC8zW/tghjLa6CLSec/FxEn
         akRfYWRNZKJTZSklrd+Bs4wdfKIcwx/q8rfH1mSy2Pup+D4TiCgmYOPUi56sDPbaeI
         1M5gNEtdQ4L5g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v5 4/7] media: mediatek: vcodec: Define address for VDEC_HW_ACTIVE
Date:   Fri, 30 Jun 2023 11:14:10 -0400
Message-ID: <20230630151436.155586-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630151436.155586-1-nfraprado@collabora.com>
References: <20230630151436.155586-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The VDEC_HW_ACTIVE bit is located at offset 0, bit 4 of the VDECSYS
iospace. Only the mask was previously defined, with the address being
implicit. Explicitly define the address, and append a '_MASK' suffix to
the mask, to make accesses to this bit clearer.

This commit brings no functional change.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v4)

Changes in v4:
- Made use of BIT() macro for mask

Changes in v3:
- Added this commit

 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 4 ++--
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c  | 4 ++--
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h  | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index d41f2121b94f..83780d29a9cf 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -50,8 +50,8 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
 	ctx = mtk_vcodec_get_curr_ctx(dev, MTK_VDEC_CORE);
 
 	/* check if HW active or not */
-	cg_status = readl(dev->reg_base[0]);
-	if ((cg_status & VDEC_HW_ACTIVE) != 0) {
+	cg_status = readl(dev->reg_base[0] + VDEC_HW_ACTIVE_ADDR);
+	if ((cg_status & VDEC_HW_ACTIVE_MASK) != 0) {
 		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
 			     cg_status);
 		return IRQ_HANDLED;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
index e1cb2f8dca33..41aa66c7295b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
@@ -75,8 +75,8 @@ static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
 	ctx = mtk_vcodec_get_curr_ctx(dev->main_dev, dev->hw_idx);
 
 	/* check if HW active or not */
-	cg_status = readl(dev->reg_base[VDEC_HW_SYS]);
-	if (cg_status & VDEC_HW_ACTIVE) {
+	cg_status = readl(dev->reg_base[VDEC_HW_SYS] + VDEC_HW_ACTIVE_ADDR);
+	if (cg_status & VDEC_HW_ACTIVE_MASK) {
 		mtk_v4l2_err("vdec active is not 0x0 (0x%08x)",
 			     cg_status);
 		return IRQ_HANDLED;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
index 36faa8d9d681..ff250e3be78e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
@@ -12,7 +12,8 @@
 
 #include "mtk_vcodec_drv.h"
 
-#define VDEC_HW_ACTIVE 0x10
+#define VDEC_HW_ACTIVE_ADDR 0x0
+#define VDEC_HW_ACTIVE_MASK BIT(4)
 #define VDEC_IRQ_CFG 0x11
 #define VDEC_IRQ_CLR 0x10
 #define VDEC_IRQ_CFG_REG 0xa4
-- 
2.41.0

