Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1788679EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjAXQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjAXQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:40:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191309EFB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:39:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso11756394wmn.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSku+g0bwjaLrkc/iXNsucUFnEKlTzMW68UCbPKqtB8=;
        b=yFOqlXOBrsDarRfGGNu9VLdX1sSQsW/82WpbKLgzNC2xsN5o7iNl/lZYlWDTcNMZqd
         zn7utDsMYHgEY3q49J8p2vdCk/tAXYtnehqj8G27K0JlZCsw8J8j9hJ/hwmVwH5peUYG
         p7VKsKshkkRnQ6Pe6/xcfWOYkYxw20qb7P2BYCGarMiQKkjSkaMUyGFDZTdkkxq/nHuq
         0NPI8ml/nIWG/nwcAm/FzPLilKGP3h6cj3uFHaqxbnLxcurWXGMvcB1IPqohtx4/k/w1
         hy3f10sZwjCee6fOtRj//UQjsjzDx2qiJUTKwQ4Ll/lSZFPo6lu5jEjSyriCUxh5GgUj
         jMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSku+g0bwjaLrkc/iXNsucUFnEKlTzMW68UCbPKqtB8=;
        b=6ShVDmpQxkwSdGdm/oFdbq5QegbqqaBTzeDmihxKPspwnWcmkpQPmBoy+oLtNcihcn
         /Zw6NYZfOJzxpXyf8KCbJ84+TM3Y3x4Rjqw3ft/pf7PMJ11stSkWxbOvwz5qqAPwtL3k
         mB0kmo/mtWzy51t50bcJ+HYvWMpXQBRUfwyL4q03g1tfHrlcvYOX6He57MiVs2CRMjDE
         czK2tUVSTj4on3S1Wfy0hsJ9qC6sDWI2b7zk91fAfpQRPSs08dJ61cwOu8w9LrlLHnxw
         3mhntyZ3kqHu6MOo5juOPVxQBhQL41hkfT24uFenW/DKzJ/YvO4weNSzwwe4ZAT8i64m
         KfoA==
X-Gm-Message-State: AFqh2kpp1tqWC35+lcvqur8RfnoAFJeVqSEUR45YFb4g2nEQE1MwmJSE
        lpXDqDdzvWgAoHbNstjmxwBr8w==
X-Google-Smtp-Source: AMrXdXujBZ5t7YodisYosOp+ESpSQ34PhMPaTAchZYG+gNWDBcGkBAPdonoMnLaX4x3c/2wIZll2aA==
X-Received: by 2002:a05:600c:3d19:b0:3db:1810:8c9e with SMTP id bh25-20020a05600c3d1900b003db18108c9emr24306739wmb.38.1674578396592;
        Tue, 24 Jan 2023 08:39:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h20-20020a1ccc14000000b003dafbd859a6sm13477147wmb.43.2023.01.24.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:39:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ASoC: codecs: constify static sdw_slave_ops struct
Date:   Tue, 24 Jan 2023 17:39:51 +0100
Message-Id: <20230124163953.345949-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The struct sdw_slave_ops is not modified and sdw_driver takes pointer to
const, so make it a const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1316-sdw.c     | 2 +-
 sound/soc/codecs/rt1318-sdw.c     | 2 +-
 sound/soc/codecs/rt711-sdca-sdw.c | 2 +-
 sound/soc/codecs/rt715-sdca-sdw.c | 2 +-
 sound/soc/codecs/wcd938x-sdw.c    | 2 +-
 sound/soc/codecs/wsa881x.c        | 2 +-
 sound/soc/codecs/wsa883x.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index e6294cc7a995..45a3eff31915 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -584,7 +584,7 @@ static int rt1316_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1316_slave_ops = {
+static const struct sdw_slave_ops rt1316_slave_ops = {
 	.read_prop = rt1316_read_prop,
 	.update_status = rt1316_update_status,
 };
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index f85f5ab2c6d0..c6ec86e97a6e 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -697,7 +697,7 @@ static int rt1318_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1318_slave_ops = {
+static const struct sdw_slave_ops rt1318_slave_ops = {
 	.read_prop = rt1318_read_prop,
 	.update_status = rt1318_update_status,
 };
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 88a8392a58ed..e23cec4c457d 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -338,7 +338,7 @@ static int rt711_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt711_sdca_slave_ops = {
+static const struct sdw_slave_ops rt711_sdca_slave_ops = {
 	.read_prop = rt711_sdca_read_prop,
 	.interrupt_callback = rt711_sdca_interrupt_callback,
 	.update_status = rt711_sdca_update_status,
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index 3f981a9e7fb6..75468e91ffef 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -172,7 +172,7 @@ static int rt715_sdca_read_prop(struct sdw_slave *slave)
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_sdca_slave_ops = {
+static const struct sdw_slave_ops rt715_sdca_slave_ops = {
 	.read_prop = rt715_sdca_read_prop,
 	.update_status = rt715_sdca_update_status,
 };
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1bf3c06a2b62..33d1b5ffeaeb 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -191,7 +191,7 @@ static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 	return IRQ_HANDLED;
 }
 
-static struct sdw_slave_ops wcd9380_slave_ops = {
+static const struct sdw_slave_ops wcd9380_slave_ops = {
 	.update_status = wcd9380_update_status,
 	.interrupt_callback = wcd9380_interrupt_callback,
 	.bus_config = wcd9380_bus_config,
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 7a5d31483cfc..35bd6f7727ed 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1106,7 +1106,7 @@ static int wsa881x_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa881x_slave_ops = {
+static const struct sdw_slave_ops wsa881x_slave_ops = {
 	.update_status = wsa881x_update_status,
 	.bus_config = wsa881x_bus_config,
 	.port_prep = wsa881x_port_prep,
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index be211422d38f..4fc7c01c27ae 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1073,7 +1073,7 @@ static int wsa883x_port_prep(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa883x_slave_ops = {
+static const struct sdw_slave_ops wsa883x_slave_ops = {
 	.update_status = wsa883x_update_status,
 	.port_prep = wsa883x_port_prep,
 };
-- 
2.34.1

