Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D397363A65B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiK1Kt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiK1KtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:49:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCDAE92
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:49:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b8so14814574edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs91y4YHGaU4u34bShI3KgPuCoRDr3inolegFmFOmPY=;
        b=g1wT1jbJufkUIzwh72l46wsx1uYKO6vUXth/QRDGsWDYmz2itJuh2wgRz8gFB54ual
         76YJb90ReXIyTt4Key/8F9QfduafhRtX1068ym/ARwB/w3JJhr4W7HkfdQ4HaSrDoWWJ
         9yhqFuIIlIl5iPlcxM9r1KT+oCOFR18mXqDpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs91y4YHGaU4u34bShI3KgPuCoRDr3inolegFmFOmPY=;
        b=4PFt2LFLw8ihZOOkskCKRHaUe6Dqxt9hbo0RzQV00OYKsOdhdGm4dblopLrgdiuBGu
         sb5kevYU5ROTcViKomW3E65tltM89zlvleZwz7SgYtUGJW1jUoP4/FrN4BOyrE+o5Cad
         jPbrIthMJ9jyJpxJdhWcW8pz+W5YJxUL5215nURM8Pr2v0KdtyGJhFCO6D+JjZrRiVTN
         CTRYaIM/Ec/hnQXuaz/R1Osq2H2Dk1/O+kyIrsEYODDbRXLYZkft6ATORfVvrApn/dTr
         s5kTf2c2FnwP3HsSYqe1bcRtMaMcCNxYTHv3IMEKDTAclQAABfdK8OOhDCKGBgjhglm4
         Sl2g==
X-Gm-Message-State: ANoB5plO1jCxAEjL9VkTOYNWecOvi7hS6XLdcszCsBpuzg6uij7gDXxA
        xa7YfiIJqEiZjrYukP2X/uap7Q==
X-Google-Smtp-Source: AA0mqf5hrXjmKOSXxjiJqKrhc6FaO+hU2zOidPRgql2hNwlfmPs5esNtOtTjU/0Dp9iwo7rwPZ433w==
X-Received: by 2002:a05:6402:25c6:b0:461:b825:d7cb with SMTP id x6-20020a05640225c600b00461b825d7cbmr23424438edb.167.1669632562801;
        Mon, 28 Nov 2022 02:49:22 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0078d793e7927sm4804807eje.4.2022.11.28.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:49:22 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 11:49:16 +0100
Subject: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=1iNfBQprbCL5uuwJdOOHqaHKJMFyiY6IxXgcAY+v+5g=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhJIviHDnwbhEMYFc1DDyoI7BOTyJsA2fKfNMrK8p
 kvF64PuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4SSLwAKCRDRN9E+zzrEiP7nD/
 44biNT3txpSfvfha5zX+nfGnR6vEZ5/aUznIE7t3v5EjRczkRaxGRDUahFKxVrfRp0FA49fA7X4sFd
 KVwoYZDahx0sO2UZxEkDCC2LgvSbZzCEdIBWK5khVTH5HskDhrUhnGNGMnla7oNl7syeaiWE2TK0M9
 N1fva9c3htr0ZJ4TTVsX3/QgzTcX3yjBBGsWuEEMKJOsZbv2Etaxg5SdJ9iiHbLW/Hy9Zf5gHWTx1J
 gscAlxKYeJVhkbwzm14KK4VZvycIxGcN7ct4cPbdxBz9r7fmPE1hSgAgqGX8Bw2awcXoEpEe0eOuCs
 yxvMeHXMK7dqnwhM+kXYPhljHkACNAwQORPRj1kvh+UnQQ/rE9yW9+5vyXrUGT0h8YsjMYqXSdMu9p
 fqp2TviL9spcEmukM+bgvHcAr/gzuJE+2xWosZ9Jt+Ybc0kwbc2pk755JkN7A5i2TdRHUz86L2xwhZ
 Qqz5NG6qp+qhX6wxx/dEiBOKhrr3MlAyVNVRohBN+iuAJ4ZfirvCLaI6Q/9YgyvlXszvfCWDna9Len
 bTmuYjX7Dqe1S6kyc25W/v6t+rlWao7KXbvFxUuRa0trMISstb93p+uLXVzc9eHR5uqgp+sralQNnL
 hu3L2ogYp6R3e3Gj58KOCtpPWzOgnY4fNwe77KAuxySKgrqpyu2TSBpelY0g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device does not come straight from reset, we might receive an IRQ
before we are ready to handle it.

Fixes:

[    2.334737] Unable to handle kernel read from unreadable memory at virtual address 00000000000001e4
[    2.522601] Call trace:
[    2.525040]  regmap_read+0x1c/0x80
[    2.528434]  mt8173_afe_irq_handler+0x40/0xf0
...
[    2.598921]  start_kernel+0x338/0x42c

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index dcaeeeb8aac7..bc155dd937e0 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1070,16 +1070,6 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	afe->dev = &pdev->dev;
 
-	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0)
-		return irq_id < 0 ? irq_id : -ENXIO;
-	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
-			       0, "Afe_ISR_Handle", (void *)afe);
-	if (ret) {
-		dev_err(afe->dev, "could not request_irq\n");
-		return ret;
-	}
-
 	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(afe->base_addr))
 		return PTR_ERR(afe->base_addr);
@@ -1185,6 +1175,16 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup_components;
 
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id <= 0)
+		return irq_id < 0 ? irq_id : -ENXIO;
+	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
+			       0, "Afe_ISR_Handle", (void *)afe);
+	if (ret) {
+		dev_err(afe->dev, "could not request_irq\n");
+		goto err_pm_disable;
+	}
+
 	dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");
 	return 0;
 

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221128-mt8173-afe-5fda4512e8b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
