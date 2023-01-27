Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D567E9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjA0PqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjA0Ppx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:45:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F386269
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b7so5354102wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pizfg/aH6e9K5CXGoTWYposMWJMO47zqqi8cq0NPoNU=;
        b=hWjOUen6VB+r+Bf1HFCafrQMXmXl835/ZOBdz6umvqbR2mgz2vUW+KQX09IJ3SXHuK
         1A76JaZo2UnxxNAMibz/Udf2YyQ/sHrcmJnIVTJLHKRGOd2HO1rnEStn5OTWu3m7BAat
         KBvJlh88kgcaYcz41Z0B5ZdJ54uGX/gpZZpkfd+7Df2sSviqRuwpvQ63BEMF2+gO8SjX
         YXg0dXoyWCbmkn/9CWLD1BOBdUQ4OeACCNUl5j5ZUkz6TLPnEgHoSmE2k5z3FtcdD7vX
         peDYH9vTTwsaCSY/l5pDqN18pjrTIXMNDCfLmQjPIje48qWGzMBoA0sOtxKV53J/2lkR
         ckAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pizfg/aH6e9K5CXGoTWYposMWJMO47zqqi8cq0NPoNU=;
        b=Lz6X6TlV7ujBF7EJ1xVhV8qB2kfmzb/aY0r/AQP0XgNWHwdRUfIEn6jNk4cGaYPPCI
         3L35HECs4Tps7qFT4uBgwHGas5/kzAk9OTQW01h+TZ9CYsGxhiQu2rMqdu9Evl8WagM+
         Tb6CyJVB6S2SizbTkVMLVtdzfr22b3DaaZJP6emvbc7rjfylSM2UvVGTvFf+Zq/Ds8VU
         f16gxMfS+kPAOFStEq2TfYqgLtAcxDuS1D3lyuBEXE7Pz0wo393HxNH43G0w7ddZhmRb
         t8M7mRYfyaAORhPVpQizu4MzfprTv1zPsyxArcDSZ3i0wQWl71xrsaJp2WJ6defSCDHe
         5N8A==
X-Gm-Message-State: AFqh2kpCUXCnjDXAyQFVmAAdxgh4ghjEhCADr4MWE+qVessmlg4sphAv
        QItyr2Gq1MuCBr7YRzmRN8Xlrw==
X-Google-Smtp-Source: AMrXdXsxzSN0WyjWzIdnAj4L8HtS85ARxt8imhE3EgjX9zbIsSGmlZ1+pv0OcjI1zkVtWVDICMmOgw==
X-Received: by 2002:a05:6000:98d:b0:2bd:f172:94fe with SMTP id by13-20020a056000098d00b002bdf17294femr38050435wrb.17.1674834319583;
        Fri, 27 Jan 2023 07:45:19 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:19 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 27 Jan 2023 16:44:46 +0100
Subject: [PATCH v9 5/5] thermal: mediatek: add delay after thermal banks
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v9-5-55a1ae14af74@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=1567;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=fzmYYuArpv3TgjQmZi16fKXqYLE8Qo9JdtSrD1YAY5s=;
 b=MFTrCKH6Grd+hiqf7XlaT3d7PqHP384ilZ1t/Y0qFtXPGTpXcf79S/w4BloEnMVX32kgpJ/LQKIK
 q29F4NunDC16TysUENhaOg467p+38Wwi/oLGbSzCHLmF+AGZ0vQC
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal sensor reads performed immediately after thermal bank
initialization returns bogus values. This is currently tackled by returning
0 if the temperature is bogus (exceeding 200000).

Instead, add a delay between the bank init and the thermal zone device
register to properly fix this.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index b8e06f6c7c42..ab7db385afb3 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -730,14 +730,6 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 		temp = mt->raw_to_mcelsius(mt, i, raw);
 
-		/*
-		 * The first read of a sensor often contains very high bogus
-		 * temperature value. Filter these out so that the system does
-		 * not immediately shut down.
-		 */
-		if (temp > 200000)
-			temp = 0;
-
 		if (temp > max)
 			max = temp;
 	}
@@ -1160,6 +1152,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
+	// Delay for thermal banks to be ready
+	msleep(30);
+
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {

-- 
2.39.1
