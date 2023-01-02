Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D932C65B151
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjABLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjABLmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:42:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47087F18
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:42:01 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bt23so24592678lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMNnSXj/QiOhqHsI5QRJCgQgDJelef4FSyVTSnv9aFE=;
        b=HasjY8J87SavHdaA7R8pq2SIcm1kxvmhAxkPBIP9ffbBrJqjq1tpRAeRfF5WdMCKGA
         4FMQ7jY0j26hnr9NMhpYHH4gfWmLsey/y5sp19xoS5ru3/P7GQu2NTv7VIQbos+76TZC
         1rZ2Kv1caFFXXhuAKCM/DAJ+mjONC+Qa9nZqHoNXoyjJQzy160WBDmmwJPvoJ4W9wzIE
         QmopCkZwnK5nS8EELiWsGe7wYOZD59GYSdKH0d+LbAWkdWb33uJPwY8jAxtxvQmXsR2n
         LxnY489R2f+mUii7e55hjHxsdb85JE4MLHWjLZwIpC/GPjoPZ9hMgpEIyoRsFi5o6HUq
         9nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMNnSXj/QiOhqHsI5QRJCgQgDJelef4FSyVTSnv9aFE=;
        b=RMfE8zAER8cKh2+gSOkuGPKc3V26VA1IjcYfRNGisCFt7cCgUpmKuTssgZZ1E4ymyZ
         DQYXsx2Zl+GtKBLy/9+Lrzy/QN4bYX9r591l+WEALKIGes9cYUTDIYcor+Ta9wN5jnYE
         zT7XDxxgBF8HCGZWGeNq55LERKRleS1ajKEolsvUkxoNkb/jyYAD5aXIbUzx2P3TlaDd
         j7OrJBuBypdkEYGZ6RiAbtco7mZtlrgwH3dBhtqkmDNRVkZD9meA/HyneFChnI8Lpcvr
         KlESt7NO0mJysC9QDWJLYKic7nKTgvTNybev/OauIELY2Ln44PC2dFJdwF29uyTqzXaS
         1ABA==
X-Gm-Message-State: AFqh2kobYJdcaeNRr1EpsaUB4qAGDgDGO6/MFSOq+V+zsYp7UjynPVaL
        RKSwzLuA7EhGvpVcV+LFJG6ILA==
X-Google-Smtp-Source: AMrXdXt60VEsqEb6zfQW8P+NRa9yhyF9KUBMbhGc5D9YDyuOq2KnGpl7VUrL6NynXEuHQy+QRk48ww==
X-Received: by 2002:ac2:43cf:0:b0:4b5:aa85:3874 with SMTP id u15-20020ac243cf000000b004b5aa853874mr12567219lfl.68.1672659720767;
        Mon, 02 Jan 2023 03:42:00 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b0048a8c907fe9sm4356397lfi.167.2023.01.02.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:42:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity
Date:   Mon,  2 Jan 2023 12:41:48 +0100
Message-Id: <20230102114152.297305-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
References: <20230102114152.297305-1-krzysztof.kozlowski@linaro.org>
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

The shutdown GPIO is active low (SD_N), but this depends on actual board
layout.  Linux drivers should only care about logical state, where high
(1) means shutdown and low (0) means do not shutdown.

Invert the GPIO to match logical value while preserving backwards DTB
compatibility.  It is not possible to detect whether ACTIVE_HIGH flag in
DTB is because it is an old DTB (using incorrect flag) or it is a new
DTB with a correct hardware pin polarity description.  Therefore the
solution prioritizes backwards compatibility while relying on relevant
DTS being upstreamed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 6df9c48f42bf..7a5d31483cfc 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -679,6 +679,11 @@ struct wsa881x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA881X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	/*
+	 * Logical state for SD_N GPIO: high for shutdown, low for enable.
+	 * For backwards compatibility.
+	 */
+	unsigned int sd_n_val;
 	int version;
 	int active_ports;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
@@ -1123,6 +1128,26 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 		return dev_err_probe(dev, PTR_ERR(wsa881x->sd_n),
 				     "Shutdown Control GPIO not found\n");
 
+	/*
+	 * Backwards compatibility work-around.
+	 *
+	 * The SD_N GPIO is active low, however upstream DTS used always active
+	 * high.  Changing the flag in driver and DTS will break backwards
+	 * compatibility, so add a simple value inversion to work with both old
+	 * and new DTS.
+	 *
+	 * This won't work properly with DTS using the flags properly in cases:
+	 * 1. Old DTS with proper ACTIVE_LOW, however such case was broken
+	 *    before as the driver required the active high.
+	 * 2. New DTS with proper ACTIVE_HIGH (intended), which is rare case
+	 *    (not existing upstream) but possible. This is the price of
+	 *    backwards compatibility, therefore this hack should be removed at
+	 *    some point.
+	 */
+	wsa881x->sd_n_val = gpiod_is_active_low(wsa881x->sd_n);
+	if (!wsa881x->sd_n_val)
+		dev_warn(dev, "Using ACTIVE_HIGH for shutdown GPIO. Your DTB might be outdated or you use unsupported configuration for the GPIO.");
+
 	dev_set_drvdata(dev, wsa881x);
 	wsa881x->slave = pdev;
 	wsa881x->dev = dev;
@@ -1134,7 +1159,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	wsa881x->regmap = devm_regmap_init_sdw(pdev, &wsa881x_regmap_config);
 	if (IS_ERR(wsa881x->regmap))
@@ -1157,7 +1182,7 @@ static int __maybe_unused wsa881x_runtime_suspend(struct device *dev)
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
 
-	gpiod_direction_output(wsa881x->sd_n, 0);
+	gpiod_direction_output(wsa881x->sd_n, wsa881x->sd_n_val);
 
 	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
@@ -1172,13 +1197,13 @@ static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
 	unsigned long time;
 
-	gpiod_direction_output(wsa881x->sd_n, 1);
+	gpiod_direction_output(wsa881x->sd_n, !wsa881x->sd_n_val);
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 					   msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(dev, "Initialization not complete, timed out\n");
-		gpiod_direction_output(wsa881x->sd_n, 0);
+		gpiod_direction_output(wsa881x->sd_n, wsa881x->sd_n_val);
 		return -ETIMEDOUT;
 	}
 
-- 
2.34.1

