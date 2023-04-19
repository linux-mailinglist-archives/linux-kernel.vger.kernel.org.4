Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B36E72E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjDSGMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDSGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:11:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055565FEC;
        Tue, 18 Apr 2023 23:11:54 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1007E6603204;
        Wed, 19 Apr 2023 07:11:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681884713;
        bh=aJRWxVnGzaGr2J9P6apJi4W995EeNeVBfHiYi7QxHyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHr8J0wKmm7tde/rnTrd4tzahXo0FD9+w38AygmVIQBAEd+P5Vpg7za5cTPowyhO7
         vlHIgGGnqqwnEs/J4QSl8KiX4BUklaP/pu54gcOfSSmeCUw6zlY2wHxz013bvthZg4
         L6p7R15+wddaFtGbgbsvdynxvzr6tw5G12qhRuTptjAG3d/vtHJ2E2WCxjcVlT0Wwr
         pIc+yABvm+gM1Rq6iWsonDMKpNE0DPNZUbETvqUVca/GNkVW/ugs+I0JZOl9ZiFmrp
         75l7vZ08k3iwTrQnXREsdbuo85scacvuWCjuQZWcoZo3Bv/WTtxVu0tvEFvDwQdxiW
         xwlZeWFlfZaBA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, bchihi@baylibre.com,
        daniel@makrotopia.org, ye.xingchen@zte.com.cn, hsinyi@chromium.org,
        michael.kao@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH 1/2] Revert "thermal/drivers/mediatek: Add delay after thermal banks initialization"
Date:   Wed, 19 Apr 2023 08:11:45 +0200
Message-Id: <20230419061146.22246-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
References: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
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

Some more testing revealed that this commit introduces a regression on some
MT8173 Chromebooks and at least on one MT6795 Sony Xperia M5 smartphone due
to the delay being apparently variable and machine specific.

Another solution would be to delay for a bit more (~70ms) but this is not
feasible for two reasons: first of all, we're adding an even bigger delay
in a probe function; second, some machines need less, some may need even
more, making the msleep at probe solution highly suboptimal.

This reverts commit 10debf8c2da8011c8009dd4b3f6d0ab85891c81b.

Fixes: 10debf8c2da8 ("thermal/drivers/mediatek: Add delay after thermal banks initialization")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index b6bb9eaafb74..3c959a827451 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -816,6 +816,14 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 			mt, conf->bank_data[bank->id].sensors[i], raw);
 
 
+		/*
+		 * The first read of a sensor often contains very high bogus
+		 * temperature value. Filter these out so that the system does
+		 * not immediately shut down.
+		 */
+		if (temp > 200000)
+			temp = 0;
+
 		if (temp > max)
 			max = temp;
 	}
@@ -1273,9 +1281,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	/* Delay for thermal banks to be ready */
-	msleep(30);
-
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {
-- 
2.40.0

