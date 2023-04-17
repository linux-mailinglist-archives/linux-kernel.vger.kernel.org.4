Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8833F6E4B21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjDQOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjDQOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:15:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DEF4C17
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:15:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so4682326a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740900; x=1684332900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Gqwd50O978CgcnfFnllVcskvaI5UoRb9w8Mjh4Qt4=;
        b=NhvozIn9uNmaKOvuqJ4W3H9KLBsRVfD3pBTemHy3QP44mHjFSwo3ili22DRVQ4xWD2
         OENCn9eEIw0SMkaOA13LqHh5rbD7i+R0pxasR8Gto4yvtRxOdNYS7CT9T+lpWTPEMvxY
         5vZG9kd5Y3MhRasLTy+paVpBOWBMGe5Pf3CfaRG+XzYCvPfK+5c9FJoRbLQO7SeMJJWU
         VLK9DT7gjljEdPIhzFuQM8YbEIbjSUFqIumrHJ1BNFpzaQwx/uDRfN2SRMAy0u+JGZ2H
         D2z63Fdwi7Ef0StiEurf7clLKLKs5Yrzesf6m6AXNmVp10RwfIZh62BWxFtp70qdHlOw
         6soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740900; x=1684332900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+Gqwd50O978CgcnfFnllVcskvaI5UoRb9w8Mjh4Qt4=;
        b=kBXpb3pYLa7Fcw+nV3ga+Vl27bRqBHP431DmeOP3ROQAzIOZhjVpq6FSSaAiyJIF8H
         NZ2qNMFJftBl2wt1ggYgRdkqJ/PKdTsksrp70hh0qspTTinfP8liIYNa329UR0Zx6qB5
         QCVf3xAmxBqgrVvnDnySEqpKh0TnLdS611LLkx+w8qJimLXodAirY3wOtKLZS4raH6Wo
         MN9HOuqJ2Ew7c6mOVZ/nnw5Y7Inbcu7lmhCX4A9FrmflJrmhfwLuU+OPSDe8AADqYCat
         ls4GYtGRZSTB1RGL6iV7yDfwSJcqO+njDjffHOm2LxQqp5SGC/RK/JBpMobrWYN3aRxf
         d0fw==
X-Gm-Message-State: AAQBX9d9Pw2+pxTKlys49+2iyJwI2lZpdyB/krUK31UgD0uPX1lksoo4
        vMr1fBcgryPnQ7oIOuqf6WOjYQ==
X-Google-Smtp-Source: AKy350bTx5UrQe52hGZ0GfeZUicEE0hKJ0FthhddapTmbFaB6awlUd7hq072M3AacWUZkbPTwr9Zaw==
X-Received: by 2002:aa7:c90b:0:b0:506:7385:9653 with SMTP id b11-20020aa7c90b000000b0050673859653mr13444365edt.39.1681740900005;
        Mon, 17 Apr 2023 07:15:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402040600b004f9e6495f94sm5832034edv.50.2023.04.17.07.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:14:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ASoC: codecs: wcd938x: Simplify with dev_err_probe
Date:   Mon, 17 Apr 2023 16:14:53 +0200
Message-Id: <20230417141453.919158-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

