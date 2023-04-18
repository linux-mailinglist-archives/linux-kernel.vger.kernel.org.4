Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6686E5AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDRHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDRHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C7448C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw30so18027077ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681803996; x=1684395996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KzlXWIM5HS1BOW2B1whAuoVKMTEgEYpaiz3Oizdn5U=;
        b=H19N0PQ5GtqPopJUPGOAT/1G76UPeZ8HVJxVpqisflVlalw7nlPEiStSQ6EUPADPbX
         YOX4RZbH9DQimMFZSa1e71+njuTL+LKQBoWCiOFEQH42PQWhKQn5J4+YJ310hkCWTwkQ
         qegT3GXD/L86fdNBpIW77DKCxA7FSb1wfKCjFVfg6FNM+Wrzhy5i6Vf72g3rAHArR92W
         u2h01c9IK6TbCrZOP9RlYCbVLP/rU9YovAro5tTsIQDDeVFqfqQTLGwU7583IadZz+Sn
         tJ4FvFtuV72mQIyjyk90db9ghTwKLgSwuL80xp7HgwphEo/bzmaY0h7nbv1qy83b2O0o
         LiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803996; x=1684395996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KzlXWIM5HS1BOW2B1whAuoVKMTEgEYpaiz3Oizdn5U=;
        b=JrrB12vvcNCWaVxtoEifIJopvgK459nfN4PKUcIa9X8Q4ca08/8Xnjo914P8gl8Elq
         szVCSFCGFY//aoQ9+zM+9BDeqFBRwqXASL+HsMkr9qhqLGrHmErr1ZQSAM5nxNhkMaoG
         QLNbTVVdUloYeiOM20lNCJAVFVvhEPUYjmvlSMyOFxNHVQ+zbzS1Z+R6fEPZt3kj+1gq
         iA3z8Qqp5hFOy2n3LX2YqynveZSH0vJ6flMVdBSqVqYs5O5ETKOND014gIQ4OqZnCnKQ
         r7ofBeaOSr/NMM9RUP60E+QtLFxD6M2DjWPB65H859U5ASh8TUsFMtSb7CFuHpynhYqn
         1kPQ==
X-Gm-Message-State: AAQBX9e96XsDnqEWXpHh5Jv0dbHbbg6HYumrN+FO2GptKOWYmJ18Cyf0
        PtfpI704AXqjO1P4C7GQXy60mw==
X-Google-Smtp-Source: AKy350Zktflt25b9vERxQO2FlE7z26UszBD/EKXSmSLPNH5/5HFIpsNYYm+dcrfZ6V6BBlaahPNzCQ==
X-Received: by 2002:a17:906:7e0b:b0:94e:5c28:1c19 with SMTP id e11-20020a1709067e0b00b0094e5c281c19mr11010367ejr.5.1681803995746;
        Tue, 18 Apr 2023 00:46:35 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm3731993ejc.169.2023.04.18.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:46:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] ASoC: codecs: wcd934x: Simplify &pdev->dev in probe
Date:   Tue, 18 Apr 2023 09:46:29 +0200
Message-Id: <20230418074630.8681-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
References: <20230418074630.8681-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe already stores pointer to &pdev->dev, so use it to make the
code a bit easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None.
---
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 56487ad2f048..c0d1fa36d841 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5892,12 +5892,12 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 
 static int wcd934x_codec_probe(struct platform_device *pdev)
 {
-	struct wcd934x_ddata *data = dev_get_drvdata(pdev->dev.parent);
-	struct wcd934x_codec *wcd;
 	struct device *dev = &pdev->dev;
+	struct wcd934x_ddata *data = dev_get_drvdata(dev->parent);
+	struct wcd934x_codec *wcd;
 	int ret, irq;
 
-	wcd = devm_kzalloc(&pdev->dev, sizeof(*wcd), GFP_KERNEL);
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
 	if (!wcd)
 		return -ENOMEM;
 
-- 
2.34.1

