Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77660709EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjESSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjESSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:09:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08FB1A5;
        Fri, 19 May 2023 11:09:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so2305914a12.1;
        Fri, 19 May 2023 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519764; x=1687111764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE2czkRUGQFVQ3kTZwHE+KiPxSvXioMK05vHyS7BUOM=;
        b=HmKe4ZBvFoFR+AEbrNRMOVUmVCOfY9dOl0ifMdl0i5+dBtYkuP1jcEF4rnFUsNZv07
         zCyywr+WtfKmuv9ls9b7XAlBJn3sgwaoidVwMOJG6H/KpYU5zjW+iRiqqY/wlUDMNh1e
         ZlTy7bdUDq2gbPlVYhxnl4E4IZ8fzGj2JffgpxIVDxCtdddaAzxGiRuI5oebrt7h8Ah/
         wCWGJJBSfrC5bg51AxrCqen5EPFsNMlMGptE2jvU/CGPW748YMxyUDY7ahth7b8AXzuN
         5j/6T1z1usf/Yw3LcBCLjIEAgEGzVozB9OwmYfaWwnntU8dDf+S/ZJp5RxywM56KBjjj
         oWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519764; x=1687111764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE2czkRUGQFVQ3kTZwHE+KiPxSvXioMK05vHyS7BUOM=;
        b=MPqOX8P0Btr4/YYw1PgR0sgotAUeK4s7vGLlIzNcsijBjdhN2ttPoA9R6mTaWHjGB/
         tZw0NLYKlw9eHg58vidPdDiK2kWHFotXinKipXSnC1uAPGBYZLTrtT+nCo0RCCYcJaWN
         w6PBmJ4Xr86b31CUhrkZAqpV0Cg51RCYIkqI0uvox3jt/Atbc1lHMxJnwbqnXh0A2ezr
         iCzx02keKzsNQkZLYFsY5mm+mbr4ykFFZKHoEmnoZD7jnBtjfD+GH1M9uYHCdW4YoFO8
         CQqB6tOm4RlGQwWLzf6EPrwX+ISVLlZyB96m1fcVDSvGIodVL/nPYmPumUoVBWMNWQOy
         HuEw==
X-Gm-Message-State: AC+VfDxjvhvfSkB9pihRehnGHSlZxWDtNejmKoDph8/Ck5odzGgSG0JD
        2TLWh1u7a4IiHNHYjuvx0ME=
X-Google-Smtp-Source: ACHHUZ62zfEHo+Fh34se+ZKL6eKs9Vh2UrEwRcPyiOf+P8tgH5Q/5Ol4xlTzjlmomEvGVyUiwILyRA==
X-Received: by 2002:a05:6402:190c:b0:506:bbf8:5152 with SMTP id e12-20020a056402190c00b00506bbf85152mr9819481edz.9.1684519763945;
        Fri, 19 May 2023 11:09:23 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm19824edt.18.2023.05.19.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:09:23 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 2/4] video: backlight: lp855x: get PWM for PWM mode during probe
Date:   Fri, 19 May 2023 20:07:26 +0200
Message-Id: <20230519180728.2281-3-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also deprecate the pwm-period DT property, as it is now redundant
(pwms property already contains period value).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 48 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index a57c9ef3b1cc..0ef850dd8e84 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -218,23 +218,10 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	struct pwm_device *pwm;
 	struct pwm_state state;
 
-	/* request pwm device with the consumer name */
-	if (!lp->pwm) {
-		pwm = devm_pwm_get(lp->dev, lp->chipname);
-		if (IS_ERR(pwm))
-			return;
-
-		lp->pwm = pwm;
-
-		pwm_init_state(lp->pwm, &state);
-	} else {
-		pwm_get_state(lp->pwm, &state);
-	}
+	pwm_get_state(lp->pwm, &state);
 
-	state.period = lp->pdata->period_ns;
 	state.duty_cycle = div_u64(br * state.period, max_br);
 	state.enabled = state.duty_cycle;
 
@@ -339,6 +326,7 @@ static int lp855x_parse_dt(struct lp855x *lp)
 	of_property_read_string(node, "bl-name", &pdata->name);
 	of_property_read_u8(node, "dev-ctrl", &pdata->device_control);
 	of_property_read_u8(node, "init-brt", &pdata->initial_brightness);
+	/* Deprecated, specify period in pwms property instead */
 	of_property_read_u32(node, "pwm-period", &pdata->period_ns);
 
 	/* Fill ROM platform data if defined */
@@ -399,6 +387,7 @@ static int lp855x_probe(struct i2c_client *cl)
 	const struct i2c_device_id *id = i2c_client_get_device_id(cl);
 	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &cl->dev;
+	struct pwm_state pwmstate;
 	struct lp855x *lp;
 	int ret;
 
@@ -457,11 +446,6 @@ static int lp855x_probe(struct i2c_client *cl)
 		}
 	}
 
-	if (lp->pdata->period_ns > 0)
-		lp->mode = PWM_BASED;
-	else
-		lp->mode = REGISTER_BASED;
-
 	lp->supply = devm_regulator_get(dev, "power");
 	if (IS_ERR(lp->supply)) {
 		if (PTR_ERR(lp->supply) == -EPROBE_DEFER)
@@ -472,11 +456,31 @@ static int lp855x_probe(struct i2c_client *cl)
 	lp->enable = devm_regulator_get_optional(dev, "enable");
 	if (IS_ERR(lp->enable)) {
 		ret = PTR_ERR(lp->enable);
-		if (ret == -ENODEV) {
+		if (ret == -ENODEV)
 			lp->enable = NULL;
-		} else {
+		else
 			return dev_err_probe(dev, ret, "getting enable regulator\n");
-		}
+	}
+
+	lp->pwm = devm_pwm_get(lp->dev, lp->chipname);
+	if (IS_ERR(lp->pwm)) {
+		ret = PTR_ERR(lp->pwm);
+		if (ret == -ENODEV || ret == -EINVAL)
+			lp->pwm = NULL;
+		else
+			return dev_err_probe(dev, ret, "getting PWM\n");
+
+		lp->mode = REGISTER_BASED;
+		dev_dbg(dev, "mode: register based\n");
+	} else {
+		pwm_init_state(lp->pwm, &pwmstate);
+		/* Legacy platform data compatibility */
+		if (lp->pdata->period_ns > 0)
+			pwmstate.period = lp->pdata->period_ns;
+		pwm_apply_state(lp->pwm, &pwmstate);
+
+		lp->mode = PWM_BASED;
+		dev_dbg(dev, "mode: PWM based\n");
 	}
 
 	if (lp->supply) {
-- 
2.40.1

