Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7457307D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjFNTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjFNTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:09:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED111FC8;
        Wed, 14 Jun 2023 12:09:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so7037456f8f.1;
        Wed, 14 Jun 2023 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686769740; x=1689361740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAUtpUkmmhsyD80FnhDUBBy4OWnp591lWDfp6Sr6AQA=;
        b=Y7iKWvFqR3xMVaVi6SLvCGA0HJuuGysh1kRcF/Dq+qpdCR0Eyh02TsQ68Ade4q5+Bl
         gDxWvT/iTsLIwQNiOGiCenuheK0g0rES1g94SBMChOe0DPHfj7PBb6OR1vi4TfoDJxo/
         9q05owb/naGthGDNDI7BvxfWCHEqiabs+ewAthdFRLxCRTexSVuCO8+5Bdd+UcOLj3mj
         uAETR3sLMTN6jsnWI6fqbuqSSnyN8dBFqinKR4GJCpf+lgDP/vdKt/c+Rs3U0WRuzmCs
         j7Ut+Ew26g2g0z6Dxnr94jp4T28jBOxyH82YRHW3W3kSETE2epWoSfjVDStUrCkXZ3aB
         i1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769740; x=1689361740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAUtpUkmmhsyD80FnhDUBBy4OWnp591lWDfp6Sr6AQA=;
        b=MkQm2lQDEnu1RrVCU0PrHFusIpapMbvvhwigFsiIUs3QI2y1TE8NooGVs06M1MPiex
         +K5bT9h6R6FTfIWImSo1qzjCuq9Z3k9dXvHt5d36xZEJ3nj0F623cTpafsTCSKhaQCPU
         X14A4T+6L4fuiQtdafoSAl2dswAZ7VpXzLpJ7QyKlgjqJoyAytb/oSCXgGa5tt6Qv4wk
         9x4sE1Rp72BwBXulDh7WmUHuiL9tbvbV2gm0TsGtUc1n24JfJtwhcOu1X9YZY6pg5zVM
         GHsz/4XluXziBdzUXz8AsO4bwAVgv0w/ecHvGIte/4C12FgXdsdv08MDSXext3KQn95r
         UNOA==
X-Gm-Message-State: AC+VfDzu23z6Re1E/jROxscijCPxVo4X6CNb9hnCFzaxGWp6FQLKemRa
        8emqIDcMRTg+2LKh5OcUd1k=
X-Google-Smtp-Source: ACHHUZ6Jn0/GSY62ytFj0l9l8DWHDmZVjOfGQa0PejhOUnsR8P6+XrFk96WHW+De2W0lOy/SONNTYA==
X-Received: by 2002:adf:fe8e:0:b0:311:f28:c65b with SMTP id l14-20020adffe8e000000b003110f28c65bmr1545941wrr.23.1686769740607;
        Wed, 14 Jun 2023 12:09:00 -0700 (PDT)
Received: from [127.0.1.1] (2001-4dd6-393b-ff-f59e-4402-63f8-7ff5.ipv6dyn.netcologne.de. [2001:4dd6:393b:ff:f59e:4402:63f8:7ff5])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b003110ab70a4fsm2341094wrv.83.2023.06.14.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:09:00 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
Date:   Wed, 14 Jun 2023 21:08:52 +0200
Subject: [PATCH 1/3] backlight: lm3630a: add support for changing the boost
 frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-lm3630a_boost_frequency-v1-1-076472036d1a@mweigand.net>
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
In-Reply-To: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686769738; l=2973;
 i=mweigand@mweigand.net; s=20230601; h=from:subject:message-id;
 bh=wQuvpc/SGDC/TXlDGAxz9aEj3nBI4XnZFq1GHSX9eFY=;
 b=MXZMkmZjabryYF/am5YsxkzeHOPo8Y9hH1lMYmwWqgDHqSVYdpnW0TIYVT1Z4bkLVSl1tKpwR
 +pMYlaGXRrhB7uSH2NS9ouQ+Pdq6jQB2MjWbRfBztW2dcBVfCwSr+/G
X-Developer-Key: i=mweigand@mweigand.net; a=ed25519;
 pk=Tjuj6PXmCCxzGTRw+9suZuZ41q/etgDHrIbPdkAaTpM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

The led driver supports changing the switching frequency of the boost
converter by two means: the base switching frequency can be changed from
500 kHz to 1 MHz, and a frequency shift can be activated, leading to
switching frequencies of 560 kHz or 1.12 Mhz, respectively.

Add this functionality to the led driver by introducing two dts entries
that control the boost frequency (500 kHz by default) and the frequency
shift (no shift by default).

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
 drivers/video/backlight/lm3630a_bl.c     | 9 ++++++++-
 include/linux/platform_data/lm3630a_bl.h | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index d8c42acecb5d..1e8645694ab5 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -92,7 +92,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 	/* set Cofig. register */
 	rval |= lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
 	/* set boost control */
-	rval |= lm3630a_write(pchip, REG_BOOST, 0x38);
+	rval |= lm3630a_write(pchip, REG_BOOST, pdata->boost_ctrl);
 	/* set current A */
 	rval |= lm3630a_update(pchip, REG_I_A, 0x1F, 0x1F);
 	/* set current B */
@@ -528,6 +528,13 @@ static int lm3630a_probe(struct i2c_client *client)
 		pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
 		pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
 		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
+		pdata->boost_ctrl = LM3630A_BOOST_CTRL_DEFAULT;
+
+		if (device_property_read_bool(pchip->dev, "ti,boost_frequency_shift"))
+			pdata->boost_ctrl |= LM3630A_BOOST_SHIFT_FREQ;
+
+		if (device_property_read_bool(pchip->dev, "ti,boost_use_1mhz"))
+			pdata->boost_ctrl |= LM3630A_BOOST_USE_1MHZ;
 
 		rval = lm3630a_parse_node(pchip, pdata);
 		if (rval) {
diff --git a/include/linux/platform_data/lm3630a_bl.h b/include/linux/platform_data/lm3630a_bl.h
index 530be9318711..fb5ffb906dcf 100644
--- a/include/linux/platform_data/lm3630a_bl.h
+++ b/include/linux/platform_data/lm3630a_bl.h
@@ -33,6 +33,9 @@ enum lm3630a_ledb_ctrl {
 };
 
 #define LM3630A_MAX_BRIGHTNESS 255
+#define LM3630A_BOOST_CTRL_DEFAULT 0x38
+#define LM3630A_BOOST_USE_1MHZ BIT(0)
+#define LM3630A_BOOST_SHIFT_FREQ BIT(1)
 /*
  *@leda_label    : optional led a label.
  *@leda_init_brt : led a init brightness. 4~255
@@ -44,6 +47,7 @@ enum lm3630a_ledb_ctrl {
  *@ledb_ctrl     : led b disable, enable linear, enable exponential
  *@pwm_period    : pwm period
  *@pwm_ctrl      : pwm disable, bank a or b, active high or low
+ *@boost_ctrl    : boost converter control
  */
 struct lm3630a_platform_data {
 
@@ -60,6 +64,7 @@ struct lm3630a_platform_data {
 	/* pwm config. */
 	unsigned int pwm_period;
 	enum lm3630a_pwm_ctrl pwm_ctrl;
+	unsigned int boost_ctrl;
 };
 
 #endif /* __LINUX_LM3630A_H */

-- 
2.39.2

