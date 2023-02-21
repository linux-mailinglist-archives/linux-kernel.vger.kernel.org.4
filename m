Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE269E3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjBUPiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjBUPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:37:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E623103;
        Tue, 21 Feb 2023 07:37:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29E9266021CF;
        Tue, 21 Feb 2023 15:37:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676993871;
        bh=HedQD3Ilc5pEnx8vhQO81s7TTNK+oqpJPvaglDZ6DvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzSAB68huZi2FWdjCmbPQLcRx/D12xji2dNq7yFIsN0pLXxptw/dMPR76n0abG8lz
         xcx+ldXx+RYzOJ0Z/EyrgyjHYxS4dTBHPe2puZUkPf/pqMKV8sRY1BqdI0UsmEnFg0
         yzMHNEuaeXf5jQBw+Psxdkt5mOTiW3OzmMMjwCSCoDv9X+G8ZnMwlqAH994GT/GuCR
         dmmBdZCS+Sv+N6O0da+H4/DQgL+2F7TAHQL6yqMcObaqIG7Z2q5RBfSXyZSsn9DdWZ
         LVGdO2sQLN7DPcdiZnyMxP6vAvdeKXavJeqC495UgF84b0OOVHDvdQ88rKmu6hSnYm
         9OL2oeVX36WjA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 08/10] drm/panfrost: Add the MT8192 GPU ID
Date:   Tue, 21 Feb 2023 16:37:38 +0100
Message-Id: <20230221153740.1620529-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
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

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

MediaTek MT8192 has a Mali-G57 with a special GPU ID. Add its GPU ID,
but treat it as otherwise identical to a standard Mali-G57.

We do _not_ fix up the GPU ID here -- userspace needs to be aware of the
special GPU ID, in case we find functional differences between
MediaTek's implementation and the standard Mali-G57 down the line.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 6452e4e900dd..d28b99732dde 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -204,6 +204,14 @@ static const struct panfrost_model gpu_models[] = {
 
 	GPU_MODEL(g57, 0x9001,
 		GPU_REV(g57, 0, 0)),
+
+	/* MediaTek MT8192 has a Mali-G57 with a different GPU ID from the
+	 * standard. Arm's driver does not appear to handle this model.
+	 * ChromeOS has a hack downstream for it. Treat it as equivalent to
+	 * standard Mali-G57 for now.
+	 */
+	GPU_MODEL(g57, 0x9003,
+		GPU_REV(g57, 0, 0)),
 };
 
 static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
-- 
2.39.2

