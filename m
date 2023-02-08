Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3868ED23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjBHKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjBHKhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C74474D3;
        Wed,  8 Feb 2023 02:37:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAD6E6602091;
        Wed,  8 Feb 2023 10:37:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675852651;
        bh=2pa0jFRatcXMZ9SnaIXUtFWvuVZm0Clr55bqDu2qpDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpkWOXIGyP9vosdNbC4o+VzOZQgIPd0IMHDDiDb6HoXAtn48eT7pQhg7LHKJ3OYPd
         NqLjqw1PCw14weP0jrt5K/9cwIB2nKVtoYx0+t1KlA3LVfzcnz4P53OC/Ud2b3lcEm
         FetNWbRbu29E7KDL0YkEN4w9vbaQm2HjcKmth3zuF1oUsOt5npxcVo/cah+iPdE041
         ZhQJ12wIQ2wGyBhAaYMfKzb6ak8V6kGaOs+HNEOUh3fh4wDZ9Lk680IVxQiXeRhk5W
         8flOvLKXuYzyxUsXNrqbmTvAjTB2cJU6wpHqnZl2jYz1VgHYZw3lJO09Uc86ToKjUI
         gPKGCQhsWpFoQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 7/9] drm/panfrost: Add the MT8192 GPU ID
Date:   Wed,  8 Feb 2023 11:37:07 +0100
Message-Id: <20230208103709.116896-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
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
2.39.1

