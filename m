Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044F72FF97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbjFNNLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbjFNNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:11:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEB2689
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso7802725e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686748245; x=1689340245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ryHJYj8SuHK1Fpj/7T+/dhtmp5a7mPpMgbt52XOOoY=;
        b=yHbrEfRM/nMoPaU6NJkYzVxOGVz7j/pY3q+K9Ga56ay0Bl/tIVeFPzUmwnBYqcmGbi
         ItyMTegESrBhrcMvn6nFPEXd1mbnkazEvxRKz3QNJkJbRe+nqv8ve30swTrXEGbXu41C
         nWIql+TaSFhsZIUYBkhy5sb6WRAhvilmUbd5Dg3aGSu/SvmbWDfV5qvyZhzswV8arNml
         2X4WOpmxYVoNKdGd7VmurpUGXIR1gVoGfBRHMQid/u++KnIC1PE5D1UcziXclrgfNebG
         8r9zfkS5K6axx8ErhcoW5KbpqzthyOhTFoO0O9fwtmtE0Rlk8+d4JM2InX4ltj4nAf40
         PEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748245; x=1689340245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ryHJYj8SuHK1Fpj/7T+/dhtmp5a7mPpMgbt52XOOoY=;
        b=NpGK4kKYVPbtFzGJWHkNuVRVwdjueaytIYhCbz4DZNkkAVDW+tjyUr+6M/3MyD0DDl
         kFPZkjYtHDX/4Itdt397kbz1g2rimHm1JQbW8ouKy3K7IC/jPX14eMX3n+o4yi2q9Pp4
         wY/9gKBADAuOQm4Cq3lyDDWqoqBYhPVo94k8WNdyjcw4Cl7Pp/b3u+DJkX+I652/1b1L
         KX/q39LAAGYYS6cMCCsJ+qeYzIF9MiJBOs2SayGbD97fIP58zPU0Meg49uJRIVcd9wiI
         qU0Sfnlu/jkR+mgPRPwP6IqoU1SJ5KnTFnmNX2SU+Sp2ib9xKIxA/QLv3p3CwaJXrxjY
         ALJw==
X-Gm-Message-State: AC+VfDzDUlYJI2yCWj2EuOXfBvdYctGNl3KCCpkUeExM38U3A6eOk3ws
        5TNMASRhVqbSGMDwBH8xjE4o0vDOKmdBBHsncPzTIg==
X-Google-Smtp-Source: ACHHUZ4LPZs0WrsTGUtJ6EUJ+pfuunak8jjNQdc5Zq6hLEf93D82dKWEQpYf8GODfNMyFlQAbFSmlA==
X-Received: by 2002:a7b:c4da:0:b0:3f7:f90c:4978 with SMTP id g26-20020a7bc4da000000b003f7f90c4978mr11817404wmk.21.1686748245323;
        Wed, 14 Jun 2023 06:10:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a7-20020a05600c224700b003f60a9ccd34sm17548661wmm.37.2023.06.14.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:10:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 14 Jun 2023 15:10:40 +0200
Subject: [PATCH 2/3] usb: typec: fsa4480: rework mux & switch setup to
 handle more states
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-sm8550-upstream-type-c-audio-v1-2-15a92565146b@linaro.org>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5398;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QarI/JISSj/rhGR4VdIVmKxfvzqx9rkOwDJ/2WosLjU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkibxSHRni5b6A/0yaMrWRH2dqpShK1pJn0rgEcOaT
 7bUY38aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIm8UgAKCRB33NvayMhJ0a/LEA
 DMo3j2DaCaw6ioaGzRmATCzZpwL0rEoHVw3mZ+qCiMPZ//lDkDnEKEnk8F0anWD5q26d/OJduz2N5F
 ATUMVRFKD/oAs5D5WYMx3PBBuQ2P6QT93X/Our/Eb9lx3QQuGKC+nskR+Sd7poyIYXqUMV5gjCRH97
 v/2cG+lTWHbtgdfsdNJtOuRAQio0lB+YZrs+DiF+SzPwGXl0VKQ3OGR1lv046xB99QUPxwKqz9bBjG
 xHiokT5rIl7qTBCFN3Kx52v3AafnLQg3uXbV1DqIrl+wf6QRFtSBHmaUAiSA1MoaodRQHs+UFy8ZpM
 7yHcB30Re63woYtcvXEtrM9BbdAIb5Jua/D2nZjmd6cyJXbyF8kSWrSE5MeijblLohNQJeTbLrbnQY
 vWedOihhOKvJJexBMt7tYlIAnN2SEnj2l4nsleJ21QFsoORg+imp7NKu5TmX6129v33n7vhIi7lOdd
 46W+oYclJzsX/vIUzsW4hItnmxlrU2PejCBtiJSF54bM6AxX06vIOu5LkuwIgoFoemCDq5DlqNgYkV
 FS1OswD+Xc0WNPcqB6+eHzsj+oaBmDdxlRHmw2VoUqZsMi9FuGEmlol6jCP6utJcZ1smvh+2E9QUFP
 2KCzzpo1b5uHRKUt9BBRTM0J/z2maX7XdCpXQeMxJ/DeHvclGQz0nI9nOkqQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to handle the Audio Accessory mode, refactor the mux
and switch setup in a single function.

The refactor will help add new states and make the process
simpler to understand.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/fsa4480.c | 111 +++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index d6495e533e58..b2913594a58f 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -46,8 +46,11 @@ struct fsa4480 {
 
 	struct regmap *regmap;
 
+	enum typec_orientation orientation;
+	unsigned long mode;
+	unsigned int svid;
+
 	u8 cur_enable;
-	u8 cur_select;
 };
 
 static const struct regmap_config fsa4480_regmap_config = {
@@ -58,19 +61,42 @@ static const struct regmap_config fsa4480_regmap_config = {
 	.disable_locking = true,
 };
 
-static int fsa4480_switch_set(struct typec_switch_dev *sw,
-			      enum typec_orientation orientation)
+static int fsa4480_set(struct fsa4480 *fsa)
 {
-	struct fsa4480 *fsa = typec_switch_get_drvdata(sw);
-	u8 new_sel;
-
-	mutex_lock(&fsa->lock);
-	new_sel = FSA4480_SEL_USB;
-	if (orientation == TYPEC_ORIENTATION_REVERSE)
-		new_sel |= FSA4480_SEL_SBU_REVERSE;
-
-	if (new_sel == fsa->cur_select)
-		goto out_unlock;
+	bool reverse = (fsa->orientation == TYPEC_ORIENTATION_REVERSE);
+	u8 enable = FSA4480_ENABLE_DEVICE;
+	u8 sel = 0;
+
+	/* USB Mode */
+	if (fsa->mode < TYPEC_STATE_MODAL ||
+	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
+			    fsa->mode == TYPEC_MODE_USB3))) {
+		enable |= FSA4480_ENABLE_USB;
+		sel = FSA4480_SEL_USB;
+	} else if (fsa->svid) {
+		switch (fsa->mode) {
+		/* DP Only */
+		case TYPEC_DP_STATE_C:
+		case TYPEC_DP_STATE_E:
+			enable |= FSA4480_ENABLE_SBU;
+			if (reverse)
+				sel = FSA4480_SEL_SBU_REVERSE;
+			break;
+
+		/* DP + USB */
+		case TYPEC_DP_STATE_D:
+		case TYPEC_DP_STATE_F:
+			enable |= FSA4480_ENABLE_USB | FSA4480_ENABLE_SBU;
+			sel = FSA4480_SEL_USB;
+			if (reverse)
+				sel |= FSA4480_SEL_SBU_REVERSE;
+			break;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+	} else
+		return -EOPNOTSUPP;
 
 	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
 		/* Disable SBU output while re-configuring the switch */
@@ -81,48 +107,59 @@ static int fsa4480_switch_set(struct typec_switch_dev *sw,
 		usleep_range(35, 1000);
 	}
 
-	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, new_sel);
-	fsa->cur_select = new_sel;
-
-	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
-		regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
+	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, sel);
+	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, enable);
 
+	if (enable & FSA4480_ENABLE_SBU) {
 		/* 15us to allow the SBU switch to turn on again */
 		usleep_range(15, 1000);
 	}
 
-out_unlock:
-	mutex_unlock(&fsa->lock);
+	fsa->cur_enable = enable;
 
 	return 0;
 }
 
+static int fsa4480_switch_set(struct typec_switch_dev *sw,
+			      enum typec_orientation orientation)
+{
+	struct fsa4480 *fsa = typec_switch_get_drvdata(sw);
+	int ret = 0;
+
+	mutex_lock(&fsa->lock);
+
+	if (fsa->orientation != orientation) {
+		fsa->orientation = orientation;
+
+		ret = fsa4480_set(fsa);
+	}
+
+	mutex_unlock(&fsa->lock);
+
+	return ret;
+}
+
 static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
 {
 	struct fsa4480 *fsa = typec_mux_get_drvdata(mux);
-	u8 new_enable;
+	int ret = 0;
 
 	mutex_lock(&fsa->lock);
 
-	new_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
-	if (state->mode >= TYPEC_DP_STATE_A)
-		new_enable |= FSA4480_ENABLE_SBU;
+	if (fsa->mode != state->mode) {
+		fsa->mode = state->mode;
 
-	if (new_enable == fsa->cur_enable)
-		goto out_unlock;
+		if (state->alt)
+			fsa->svid = state->alt->svid;
+		else
+			fsa->svid = 0; // No SVID
 
-	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, new_enable);
-	fsa->cur_enable = new_enable;
-
-	if (new_enable & FSA4480_ENABLE_SBU) {
-		/* 15us to allow the SBU switch to turn off */
-		usleep_range(15, 1000);
+		ret = fsa4480_set(fsa);
 	}
 
-out_unlock:
 	mutex_unlock(&fsa->lock);
 
-	return 0;
+	return ret;
 }
 
 static int fsa4480_probe(struct i2c_client *client)
@@ -143,8 +180,10 @@ static int fsa4480_probe(struct i2c_client *client)
 	if (IS_ERR(fsa->regmap))
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
 
+	/* Safe mode */
 	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
-	fsa->cur_select = FSA4480_SEL_USB;
+	fsa->mode = TYPEC_STATE_SAFE;
+	fsa->orientation = TYPEC_ORIENTATION_NONE;
 
 	/* set default settings */
 	regmap_write(fsa->regmap, FSA4480_SLOW_L, 0x00);
@@ -156,7 +195,7 @@ static int fsa4480_probe(struct i2c_client *client)
 	regmap_write(fsa->regmap, FSA4480_DELAY_L_MIC, 0x00);
 	regmap_write(fsa->regmap, FSA4480_DELAY_L_SENSE, 0x00);
 	regmap_write(fsa->regmap, FSA4480_DELAY_L_AGND, 0x09);
-	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, fsa->cur_select);
+	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, FSA4480_SEL_USB);
 	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
 
 	sw_desc.drvdata = fsa;

-- 
2.34.1

