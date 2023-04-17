Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818F46E4B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDQOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDQOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:15:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0625580
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:14:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50672fbf83eso14693688a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681740897; x=1684332897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdSLfFTkv6LYV3M0mzyuGaPRuWS7s/5vp6QK5VHSwvw=;
        b=RzE+hWQvLG+ToUxcaDtEz9Q3e8NAYpfR7V5FIpzDQuomR5owNFdDhUvH2QaJipF10D
         GWjQqAHBtrZGC615Ls7NgtT+6C4C1jOjVw0B7hMOEY3u/fUyHuT3t4TsOAkAKWsVI1h4
         AEfglOWetOIog4xZls6MOZJkql6492Ni2Zw4EoF5Qo+zrz5dJPENj1jeJIRTF9U1khZ6
         fn936x3xvUrAzwgWBXafJCWCBWUufiAkTrw9X8JlPtynRTseumDspzinwkfJVPxg/qgG
         ZZ4hsxxTHKzvHpblKwulKigeP7Nw7tZNwiWpKpZlNnxIC1QrXUS+vvo4QSm+yRiHh8Qc
         zanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740897; x=1684332897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdSLfFTkv6LYV3M0mzyuGaPRuWS7s/5vp6QK5VHSwvw=;
        b=B5/viSX84/tk7bbED0bG+mxUYqxk1xhb8EJJIdcQBXB566UI59WsyZzRjAJWdWTPeL
         FZKmpeNkyiJ/tqBRQnEeDu0a0dIWv9dnSWoSblKOVjmPvCjlvDMa82LflPHFKw8Aipkk
         seQmlmHk4NDB8JNi29KEsUm2yoZWmJ8GA9wWj2o6kerXNFroqEAsOpBOOL68Q7UZ5+VG
         LTqhvfVwS++UOOXV4cro2E8nKFiNCH8t1H3nVBEs3+dB6rP/9NT7ciTprUgxpn9HDi8l
         w6ekVp6idX+PJGpFriMAc3pNncI91kRf/r/tzdkXocZh2M95n9eD6QjBs13Hvk9l6fiK
         32fQ==
X-Gm-Message-State: AAQBX9ekS0XVwT57FiHIzRJsg4DaHxUvUqgg+JUMQdRqttNkdmOELu0t
        db34zjshQhj9rI2FtwCYN+2iDw==
X-Google-Smtp-Source: AKy350ZpK+Q0Lk/sUrpuzdbTEMJgrM0zQiaQj9MfhnmQ30N0Ripjw7eud+5jh+xVfNdGhumzqyNY+Q==
X-Received: by 2002:a05:6402:4cb:b0:504:9350:f458 with SMTP id n11-20020a05640204cb00b005049350f458mr13585489edw.1.1681740897195;
        Mon, 17 Apr 2023 07:14:57 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402040600b004f9e6495f94sm5832034edv.50.2023.04.17.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:14:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Date:   Mon, 17 Apr 2023 16:14:51 +0200
Message-Id: <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
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
 sound/soc/codecs/wcd934x.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 783479a4d535..56487ad2f048 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5868,10 +5868,9 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	slim_get_logical_addr(wcd->sidev);
 	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
 				  &wcd934x_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap)) {
-		dev_err(dev, "Failed to allocate ifc register map\n");
-		return PTR_ERR(wcd->if_regmap);
-	}
+	if (IS_ERR(wcd->if_regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
+				     "Failed to allocate ifc register map\n");
 
 	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
 			     &wcd->dmic_sample_rate);
@@ -5923,19 +5922,15 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	memcpy(wcd->tx_chs, wcd934x_tx_chs, sizeof(wcd934x_tx_chs));
 
 	irq = regmap_irq_get_virq(data->irq_data, WCD934X_IRQ_SLIMBUS);
-	if (irq < 0) {
-		dev_err(wcd->dev, "Failed to get SLIM IRQ\n");
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(wcd->dev, irq, "Failed to get SLIM IRQ\n");
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					wcd934x_slim_irq_handler,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					"slim", wcd);
-	if (ret) {
-		dev_err(dev, "Failed to request slimbus irq\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request slimbus irq\n");
 
 	wcd934x_register_mclk_output(wcd);
 	platform_set_drvdata(pdev, wcd);
-- 
2.34.1

