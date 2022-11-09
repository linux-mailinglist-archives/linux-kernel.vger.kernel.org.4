Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4363E62304C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKIQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKIQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:38:07 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71067205ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:38:06 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z24so26470383ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7C2hHnfI1uYNjIWJLHD9FrtHQvprfeg/2R452u0Yvw=;
        b=KUe0/9raCDsxcD15jNaoHEKQGY1/z3OYfBstsqbbVT0/dTZxxlTFOP7vThUbFzgweK
         wKugzPaXOIsI8vcmjF78XPW8V1wzRqrh5vsdKK4h6RyMV03ReqPKUrnU6l2xZNv7PnW+
         z60fruvLAa+BQWl199mTBWEmipiZ/6Vj1L3VuvC9mFuZUzABF5Ssvu5nianwySzBUx49
         Us5PwbT86nEgP//Oq8Qo+Omv9uK8ys0RVQeEuKVU9/In3rfFRhz2cvHl0dAup9ChQl6k
         JhrIx/DpNSts9N+FanVuzj5AMI2K/pAOFZK6z/rbR0bemlDVlF5FuPMNGJ5VEceZ/XiD
         vCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7C2hHnfI1uYNjIWJLHD9FrtHQvprfeg/2R452u0Yvw=;
        b=J9q4mlpNNzNBggQFSW7QfRFqYr1jO4IXhjc2bi45KyxwjKM7aMO0Y1aqQ0gLMUGRoO
         xzfNr4/Ir23nuBWdLhXCAJyHE/Ri7rIpu+cWR0uDkR6DHzH0w8k8tzNhUZgYf+aIKb+z
         Ik5zV4ioqmz/0Q7uzoQIXEYWw8q98hjcvt6Ikw1xalGJHUsv0EchmZ47RI/GI+4sVrk8
         0bul6Ym5ib0/Ox2SPneHkvMGF00RKleyXpcXep58wS8T1P64qoUYZhx9McjHHiFejxMs
         UTIdahnwO62gLfiO/j4hx4SCIm3m8Mjcg1t+b1K6iCkCD/bFldNUO6lutSXmjo6jUz/m
         gz8Q==
X-Gm-Message-State: ACrzQf2KTdqRSjle4zSpVvgzkOnkB/wMxLNeaqxHQ3s4XClnIYZnRWo8
        izbj2y5fmyrDoBhTLu5B5o5d6Q==
X-Google-Smtp-Source: AMsMyM6FrG459irhWWgn/mdmV+tHUH+ng59iK8pFUv1yvdPiS8GI/H82o+kBVrPB7FU5hsLAxaBwGQ==
X-Received: by 2002:a2e:b626:0:b0:26e:6fb:4845 with SMTP id s6-20020a2eb626000000b0026e06fb4845mr7796442ljn.120.1668011884830;
        Wed, 09 Nov 2022 08:38:04 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512074f00b0049476667228sm2309168lfs.65.2022.11.09.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:38:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: codecs: wsa883x: Simplify with dev_err_probe
Date:   Wed,  9 Nov 2022 17:37:59 +0100
Message-Id: <20221109163759.1158837-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109163759.1158837-1-krzysztof.kozlowski@linaro.org>
References: <20221109163759.1158837-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 4ad8b875eb8f..85a2d928db13 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1380,22 +1380,19 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 		return -ENOMEM;
 
 	wsa883x->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(wsa883x->vdd)) {
-		dev_err(dev, "No vdd regulator found\n");
-		return PTR_ERR(wsa883x->vdd);
-	}
+	if (IS_ERR(wsa883x->vdd))
+		return dev_err_probe(dev, PTR_ERR(wsa883x->vdd),
+				     "No vdd regulator found\n");
 
 	ret = regulator_enable(wsa883x->vdd);
-	if (ret) {
-		dev_err(dev, "Failed to enable vdd regulator (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd regulator\n");
 
 	wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
 						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
 	if (IS_ERR(wsa883x->sd_n)) {
-		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
-		ret = PTR_ERR(wsa883x->sd_n);
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(wsa883x->sd_n),
+				    "Shutdown Control GPIO not found\n");
 		goto err;
 	}
 
@@ -1416,8 +1413,8 @@ static int wsa883x_probe(struct sdw_slave *pdev,
 	wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
 	if (IS_ERR(wsa883x->regmap)) {
 		gpiod_direction_output(wsa883x->sd_n, 1);
-		dev_err(&pdev->dev, "regmap_init failed\n");
-		ret = PTR_ERR(wsa883x->regmap);
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(wsa883x->regmap),
+				    "regmap_init failed\n");
 		goto err;
 	}
 	pm_runtime_set_autosuspend_delay(dev, 3000);
-- 
2.34.1

