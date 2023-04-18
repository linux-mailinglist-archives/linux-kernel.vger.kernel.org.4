Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7943B6E5AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDRHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDRHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:46:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D7510D0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94a342f15e4so530575166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681803994; x=1684395994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o12ebF9++JVUvhpdQh9deSW0oeUpmXNibeCUjBiWaVA=;
        b=YZNWGQskAWaR2q2RjOEHZVsl62XSVmgC9xJB4lIqLtYzbrKBJz9znlfxGyiVdkUTbD
         EdeEYATXSTBAFfnp8Of6o0p0Uf2s+9SyXuvyOyxfPgt4ElqPM2VawcxGGjm4EneE+kXt
         MFGh3VUrnCJsnlbq5X3xajzuvSiFwvpWOONF6u/LlD3QjoUItBVl2mDDU4QDy6Jf1COf
         UdYS8a/nH8SD5rlQc+EwU0y7vDaPjQopGhqdBx03jnsbrewjWqtwhOVOb9wNjo+m44ey
         OJzBONsullh0IJU0uKe574dyfz+TgD703l8I35ZXWMUAvAiTmgSxUOqOfU0rvXxsOjZ0
         Q8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681803994; x=1684395994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o12ebF9++JVUvhpdQh9deSW0oeUpmXNibeCUjBiWaVA=;
        b=DU6fsV+8SkaB95s/SuOc9zqYvkq8R6RBzyH6zwCYyEpJl5WqpKRL9f29JS2ch1/2TT
         Vzpt/M/0eVVpqqs4zq/QmSczNMnQatsXP+pmVfn97V5B8xQhXI6i8v9FwRv07/azyqR1
         gGsAJbAAWl44UaKUZEj2sXFFuafEx+yVh0JdkPcOrUELV5BZgOjYmo/fz19Mr0JoxxWO
         EjVQIp7/JvU74vWhf7BkHh7J1v74Oi8r5Ahd3XIYlXLA53DG3EFnWGZWgZ+ZACCJ0xSP
         y7agr0WzTX9HWycQpCOUMxgCBxRPx8N5M6HRe3BoSfkbJ5OW3auze04ESnb2gDDKmOXF
         UmfQ==
X-Gm-Message-State: AAQBX9fkQFEpvKqmymJx88KTCpELnTiQZh2Mz9QjiZs8jqF0tS1/A/xo
        OwNrx3PSHRM5MoSeVxFGF/1HSA==
X-Google-Smtp-Source: AKy350ZtFKag5MXhYcTH62ouNdlygN8c6TqlGXIZNzZsHErco0sFZK5MTskdQ6jMWuQg2eohYm3VYw==
X-Received: by 2002:a05:6402:748:b0:506:ae87:a36a with SMTP id p8-20020a056402074800b00506ae87a36amr1550021edy.14.1681803994735;
        Tue, 18 Apr 2023 00:46:34 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm3731993ejc.169.2023.04.18.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:46:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Date:   Tue, 18 Apr 2023 09:46:28 +0200
Message-Id: <20230418074630.8681-2-krzysztof.kozlowski@linaro.org>
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

