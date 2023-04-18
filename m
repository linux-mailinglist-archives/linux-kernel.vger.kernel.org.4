Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D26E5ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjDRHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjDRHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15728A8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dm2so70924826ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681803996; x=1684395996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSTh/SJop5c2Us/dQwQInLvSKG2b28WOhmpUgImXSN4=;
        b=JIXcMkwqYs0HXlx9VovWlfO/IO9++uYT98RcF6INoHP4EgPbfvGOPQK1wUAQELPIdB
         W5T7j/au9BAmdU7nOY6jxXvLUxudGbK1t1mOIpCUqZRqqnzCUwe2ix1fZ9h7oXecqx+r
         PyJKJspYUymwBkNi7sFxN0azJce4VLjL0qv2hLFOauSfxPl5bOIguOqqj+0sWIW7s3qx
         HqN3ScBUfGn9fW4WGfbxWWhkGmHcR5o/US0p2E5zTGOoGQXMVn+jna9bK+zN6Qh9rUAl
         K5mxSbz9fS89h4O1enbZ+FldagCVrl9P7cAvtfb9NI2aB7WETL6ND2nVlMSBtEl0Qz6Z
         /ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803996; x=1684395996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSTh/SJop5c2Us/dQwQInLvSKG2b28WOhmpUgImXSN4=;
        b=kFruY4n3tqcQ3ql3qZPkkoNKxbP+J32hUC83OByEDdU0cD/imXJgUR0bfRssmNIQu8
         rIY0N9D6rIJyJZWmaT5iqdHGIudz/PKQ2+YxF5QCKOh/iRClYwP62AN571qDLVPlhyBU
         USvPlXM1vT9IWVrbnWM29XPSUdDXc570z7I/5kZ+WvaPOHN6HFYhSMoXr9ubsQ0rzfBf
         /8bvqtezb/DFHs5eCMgcwloA1/SMvsIsV1dkorHtt1z7deQemTmsRJdJ++9I97CuF0iz
         YwujsgeTjTvlLNUFqED/vCeDQCjTOSw5pury92U48wMZZbFfHeSQbbrZxWB7PUcKmT4i
         g9tw==
X-Gm-Message-State: AAQBX9cywXBXYmD00zKy2KiKdak6Qf2QOJw7mnnya0vfa7nSjO2YvITz
        SLaeQPF7XuqcSQsARy1vqrSPZg==
X-Google-Smtp-Source: AKy350aFbYeUj+m3sjqAo982f1YulOZ6YRhgeEz5UQC+6oQsPQ9qMNORKSSgrLdCZEKgnbCvHw3jVg==
X-Received: by 2002:a17:907:2d09:b0:94f:444c:fc25 with SMTP id gs9-20020a1709072d0900b0094f444cfc25mr8326449ejc.12.1681803996664;
        Tue, 18 Apr 2023 00:46:36 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm3731993ejc.169.2023.04.18.00.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:46:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/4] ASoC: codecs: wcd938x: Simplify with dev_err_probe
Date:   Tue, 18 Apr 2023 09:46:30 +0200
Message-Id: <20230418074630.8681-4-krzysztof.kozlowski@linaro.org>
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

Replace dev_err() in probe() path with dev_err_probe() to:
1. Make code a bit simpler and easier to read,
2. Do not print messages on deferred probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Re-write commit msg.
---
 sound/soc/codecs/wcd938x.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index f033f79ed238..11b264a63b04 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -4235,18 +4235,15 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	int ret;
 
 	wcd938x->reset_gpio = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
-	if (wcd938x->reset_gpio < 0) {
-		dev_err(dev, "Failed to get reset gpio: err = %d\n",
-			wcd938x->reset_gpio);
-		return wcd938x->reset_gpio;
-	}
+	if (wcd938x->reset_gpio < 0)
+		return dev_err_probe(dev, wcd938x->reset_gpio,
+				     "Failed to get reset gpio\n");
 
 	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
 						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio)) {
-		dev_err(dev, "us-euro swap Control GPIO not found\n");
-		return PTR_ERR(wcd938x->us_euro_gpio);
-	}
+	if (IS_ERR(wcd938x->us_euro_gpio))
+		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
+				     "us-euro swap Control GPIO not found\n");
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
@@ -4256,16 +4253,12 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	wcd938x->supplies[3].supply = "vdd-mic-bias";
 
 	ret = regulator_bulk_get(dev, WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	ret = regulator_bulk_enable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to enable supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
 
 	wcd938x_dt_parse_micbias_info(dev, wcd938x);
 
-- 
2.34.1

