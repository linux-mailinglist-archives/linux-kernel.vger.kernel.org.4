Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1715BDA82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiITC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiITC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:58:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0C5850E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:58:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw17so1097866plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bG3TOlajU16P3gbCwMauLa0qhe+go+yuIOUL4RNlsMs=;
        b=mB0m4QXG1bWuQUYi3KqzpGAYgP8XshwcXa4pcBNoksZRgGI46KWHie5yLhFC+vyYPJ
         NjCkck5Vo0qK30wnb3TD0bVCAB71TJmZSgFtnbxkFmeeU6s6TaRcOZJfmcwSYqRdQei2
         CD4g18SdBpe0zEaU0Kw1GiAICKMXrE26WOWXc/689WbeWxT9Dgm+bYKPgmIpqTb9BbIa
         DiIQzVllOQRwvJ2Ro/adFfTxKEW1HO99ODpEKb64oEx0PMS6b+g0ASjMq24KQDBgUj3a
         nXOnSL1q6BHo1cGSp//lXHCWmuNn/ZrvV8xuLmU3QoRsDEFBMCQeYB9IFip3F2Z6Pb+I
         +tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bG3TOlajU16P3gbCwMauLa0qhe+go+yuIOUL4RNlsMs=;
        b=fHfx2hjh1tOKJq7GXZVhNHNuPGm6DusUhqXkceT/kSiiqsBJB4V2hFW0lvfwb4Kjtm
         dhexVlVRfDX+RS7RqUasQokKsUekJfNPUdFjt8HEhnigrzdJr7iPR2CJDbchS5q43vKW
         RjJ1NJCHx/rJ6z4lkc5SrhTfY1GGoqEjkRAAqmkBn/Pmjh2VGmKTBaMJeLk+pYyop3eY
         0otXRe5SYxVa9k5pa7Ct755at7mcYKl0wxYtBsUNGsDjMjoijDuR41+ktkK72Kdj7RbH
         AafVP9Y1zUWX5ae1jHKTySGwSH8aalQG9bWf5NafAq7Ir03cSXztiDhlfkNMGR9dHTEj
         cJlg==
X-Gm-Message-State: ACrzQf0gkVlXTBD2e7iIEa5hVBWx7NehG1uGSIj+uJXDNJbstHemcQxR
        lBnqQxGOa7ywggBdafTDBKg=
X-Google-Smtp-Source: AMsMyM422QwAquVOaMXBpgC0AQASMi7a0PhUei0xAJVzNK/fyN+cnM/gRRAeitNAdCFk83iiMBHuoQ==
X-Received: by 2002:a17:90b:1b10:b0:200:934b:741f with SMTP id nu16-20020a17090b1b1000b00200934b741fmr1482826pjb.212.1663642688676;
        Mon, 19 Sep 2022 19:58:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id z128-20020a626586000000b00542e190f6bcsm147499pfb.102.2022.09.19.19.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 19:58:07 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: ssm2518: drop support for platform data
Date:   Mon, 19 Sep 2022 19:58:03 -0700
Message-Id: <20220920025804.1788667-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently no users of this driver's platform data in the
mainline kernel, so let's drop it.

Newer devices should use DT, ACPI, or static software properties to
describe the hardware.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/platform_data/ssm2518.h | 21 ---------------------
 sound/soc/codecs/ssm2518.c            |  6 +-----
 2 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 include/linux/platform_data/ssm2518.h

diff --git a/include/linux/platform_data/ssm2518.h b/include/linux/platform_data/ssm2518.h
deleted file mode 100644
index 3f9e632d6f63..000000000000
--- a/include/linux/platform_data/ssm2518.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * SSM2518 amplifier audio driver
- *
- * Copyright 2013 Analog Devices Inc.
- *  Author: Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_PLATFORM_DATA_SSM2518_H__
-#define __LINUX_PLATFORM_DATA_SSM2518_H__
-
-/**
- * struct ssm2518_platform_data - Platform data for the ssm2518 driver
- * @enable_gpio: GPIO connected to the nSD pin. Set to -1 if the nSD pin is
- *            hardwired.
- */
-struct ssm2518_platform_data {
-	int enable_gpio;
-};
-
-#endif
diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 6d8847848299..feee28207e5d 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
-#include <linux/platform_data/ssm2518.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -736,7 +735,6 @@ static const struct regmap_config ssm2518_regmap_config = {
 
 static int ssm2518_i2c_probe(struct i2c_client *i2c)
 {
-	struct ssm2518_platform_data *pdata = i2c->dev.platform_data;
 	struct ssm2518 *ssm2518;
 	int ret;
 
@@ -744,9 +742,7 @@ static int ssm2518_i2c_probe(struct i2c_client *i2c)
 	if (ssm2518 == NULL)
 		return -ENOMEM;
 
-	if (pdata) {
-		ssm2518->enable_gpio = pdata->enable_gpio;
-	} else if (i2c->dev.of_node) {
+	if (i2c->dev.of_node) {
 		ssm2518->enable_gpio = of_get_gpio(i2c->dev.of_node, 0);
 		if (ssm2518->enable_gpio < 0 && ssm2518->enable_gpio != -ENOENT)
 			return ssm2518->enable_gpio;
-- 
2.37.3.968.ga6b4b080e4-goog

