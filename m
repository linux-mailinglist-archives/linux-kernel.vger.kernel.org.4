Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2F6E8FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDTKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjDTKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874134C30
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94ed7e49541so49813666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985784; x=1684577784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rqhyU6uXoU+/LhRADh+Yrxp3II6kKdCrObNCj5zZIk=;
        b=Ut6iQ/+CoIv1rPMxqnZvK0NSWdqeCFUzd6OEx1lKkUgb/r52SzTay59vOp6CZkva05
         8SGuiVyeXnxzYx/n6GIJRR8oUGw9tjeCMCLAcQATcoAebowSItrF3GwVrDQDCqTYJTfv
         nVq35AQtK5pxpUcHSNBA7H0d14o3p7Dzu0lQ4p8r82XQdBVUBsvr4GJ7X4HY22Xt/IIt
         bUMDdwpLFNd8eyAy7mD+F1M84wUS4ga+3/PganPMZM3Cln5eEY8lqVR/OApIs0lFZn9M
         pVShqreCbx9e8O1gOETlPSNg8pzNbkIaLUyskwjwBn/1ifnBr+LoakoKoqAWmiDuDezk
         A3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985784; x=1684577784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rqhyU6uXoU+/LhRADh+Yrxp3II6kKdCrObNCj5zZIk=;
        b=R0TWbzthFA8nHaLA2jp/V/ZJr65IqYEoVPmKBYUfFGJYFPDIc7SSUj0siiCHu0QNED
         9V/wkSle0kKKKFlEy3KCTQP4tdLwNpmBYZQtOzKyB0Pb5jmBT7/zluWoNuEa4CAPeKlz
         w2E7Tv22Iizp7h6oKHl28qeSP/ikYAixrY5u2ulSBqZV/uDxHkzb+V6bu+R3QuzNzsc6
         F9cvqmdNSRIOjs5co6StNZByLqjTMWQhSiLLORVMARd1BH2Sn5VXdp53dlvAIxiq9R6o
         NzytVovZPMwLfyvJpvUFi/O8Ga8AqRt1S39W35dAOLHWkAVbTzrSgb8VwMXMb73PJRZZ
         eymA==
X-Gm-Message-State: AAQBX9dY0aQ6eMCDT1lhvHDLo6LOwjU/ItmBoqjqdsbM1wSi5T4jlJ/a
        XEFtN5msAQ93TRZXajTH+qcqxQ==
X-Google-Smtp-Source: AKy350Y+TpaiL2KGRHt+2QkWwuPO6mgxsHGZDuQwdBnUEOwDHb/sJRBqccPNe3HpJgRk5w3gFxXlBw==
X-Received: by 2002:aa7:d81a:0:b0:504:98f1:464c with SMTP id v26-20020aa7d81a000000b0050498f1464cmr1260446edq.23.1681985783905;
        Thu, 20 Apr 2023 03:16:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
Date:   Thu, 20 Apr 2023 12:16:12 +0200
Message-Id: <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[krzysztof: rebased on recent dev_err_probe() changes]
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 sound/soc/codecs/wcd938x.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 11b264a63b04..33fd8fdde9fd 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -6,12 +6,14 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
 #include <sound/tlv.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -194,7 +196,7 @@ struct wcd938x_priv {
 	int flyback_cur_det_disable;
 	int ear_rx_path;
 	int variant;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct gpio_desc *us_euro_gpio;
 	u32 micb1_mv;
 	u32 micb2_mv;
@@ -4234,16 +4236,16 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	struct wcd_mbhc_config *cfg = &wcd938x->mbhc_cfg;
 	int ret;
 
-	wcd938x->reset_gpio = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
-	if (wcd938x->reset_gpio < 0)
-		return dev_err_probe(dev, wcd938x->reset_gpio,
-				     "Failed to get reset gpio\n");
+	wcd938x->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(wcd938x->reset_gpio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get reset gpio\n");
 
 	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
 						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio))
-		return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
-				     "us-euro swap Control GPIO not found\n");
+	ret = PTR_ERR_OR_ZERO(wcd938x->us_euro_gpio);
+	if (ret)
+		return dev_err_probe(dev, ret, "us-euro swap Control GPIO not found\n");
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
 
@@ -4278,11 +4280,11 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 
 static int wcd938x_reset(struct wcd938x_priv *wcd938x)
 {
-	gpio_direction_output(wcd938x->reset_gpio, 0);
-	/* 20us sleep required after pulling the reset gpio to LOW */
+	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
+	/* 20us sleep required after asserting the reset gpio */
 	usleep_range(20, 30);
-	gpio_set_value(wcd938x->reset_gpio, 1);
-	/* 20us sleep required after pulling the reset gpio to HIGH */
+	gpiod_set_value_cansleep(wcd938x->reset_gpio, 0);
+	/* 20us sleep required after releasing the reset gpio */
 	usleep_range(20, 30);
 
 	return 0;
-- 
2.34.1

