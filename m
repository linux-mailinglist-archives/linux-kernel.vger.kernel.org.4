Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021BE624359
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiKJNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiKJNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:35:30 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A7329348
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:35:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s24so1156944ljs.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVYq2N7Rct5i92MPe3IgInkaL5zJNoRo/Ju3+MkjpVM=;
        b=aHLYA+6xo0R01ED2csKLZEyU5drBe0n7gYOHCzxbSi5EqgfZxi2pGxMv+sefXP/L0j
         VmuRoM+0PKVqaomTrPcj5wBVGNtAhukRrEvIpS1E321pynM+zGJ6ASHPX2KFg4bag4EU
         ZzE5sZhB7nJaITsz/ddH8ZuAffQp+u4e/jUQVIte4af8F7SOPf8UH7WA/LRh6zcBV7Vr
         AXxzq8/CbX14HV3L/Q9XmJtNY/LeHFNVAVImJMEKVfOH9vs/k6T6pT9wZtN9MQBmbpFw
         66Pquh1lhM1B7Mp0hnscP1TrRIUobtEoUhbcoRhrFKw+MtrDynZmTir+qqjbvuv+Yx0x
         xPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVYq2N7Rct5i92MPe3IgInkaL5zJNoRo/Ju3+MkjpVM=;
        b=pUrWRQo6UjAx04Hta0L7Sc1XYi3Fsznv4xzZ1vVTtVMsIt3T4JMOZ/fnmBlfTTp2aS
         ffVCeLQUyIg8B+7/QbD5z23IJHjfyUY8QJpJ3/F9ce5MXoE7o71/7N/WEthOPf7lpX7V
         hnl19bU0S2+7eHA+t8HjOaUXkZ0wADpq0bIBn+jo+LJGqBSLR4ZLlf6FdKbESzvMQvcG
         6SgtS3VwSNkfDVUvb/G9+0cWuJfx1upEhF2B8coyJzuSeX8YnGlt1dE8btNFz/U4MTwA
         I7kFm1tHrQ4nepcNxzcwrS0SQtoYWy/xt0nVuWxb+VUMchzdLCurrq1inma8uj2/87IQ
         yAbQ==
X-Gm-Message-State: ACrzQf0keqSiuFWxlQWbSrLOavier72JPlzfNSQzYMTsBOx5N5tkt1sc
        wFy7CO1a5s0dGYZtfL5peyEyLA==
X-Google-Smtp-Source: AMsMyM5uuuy6vzbm6Wss8li0CVLMJd7xDK+0FdYwv7VWxMESFwlGkAuH/yOIdWdL1vP4Kcok92FBvg==
X-Received: by 2002:a2e:8602:0:b0:277:2217:c7e1 with SMTP id a2-20020a2e8602000000b002772217c7e1mr8784168lji.407.1668087327523;
        Thu, 10 Nov 2022 05:35:27 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id q14-20020a0565123a8e00b004ad5f5c2b28sm2752576lfu.119.2022.11.10.05.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:35:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] ASoC: codecs: wsa883x: Use proper shutdown GPIO polarity
Date:   Thu, 10 Nov 2022 14:35:12 +0100
Message-Id: <20221110133512.478831-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110133512.478831-1-krzysztof.kozlowski@linaro.org>
References: <20221110133512.478831-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shutdown GPIO is active low (SD_N), but this depends on actual board
layout.  Linux drivers should only care about logical state, where high
(1) means shutdown and low (0) means do not shutdown.

Invert the GPIO to match logical value.

Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None.
---
 sound/soc/codecs/wsa883x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index c7b10bbfba7e..77a7dd3cf495 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1392,7 +1392,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	}
 
 	wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
 	if (IS_ERR(wsa883x->sd_n)) {
 		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
 		ret = PTR_ERR(wsa883x->sd_n);
@@ -1411,7 +1411,7 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa883x->sd_n, 1);
+	gpiod_direction_output(wsa883x->sd_n, 0);
 
 	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
 	if (IS_ERR(wsa883x->regmap)) {
-- 
2.34.1

