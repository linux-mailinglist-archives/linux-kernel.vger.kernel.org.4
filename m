Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B1734D26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjFSIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFSIHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E91A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8fa2cf847so28457825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162040; x=1689754040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=ufhYg53l4+1jEFiUvB9iYxTEDauMoIP6CKQPjGg4g+TpW5GB4u22fwBviDgR6VtM5x
         ODl1A18KE7PT5qqV+QgsNa7rXktkfBNfgWaDeCo/7fCcbIzFLyLmnIif2SZTaOuT4YcP
         G+PvHzbz7JD1urGNUzWFbqaX4ANKmnnvXLqOdZnL6tS6DBuoDuSP1tzthf9HuUMwAtSd
         rgwmef4QRDlnJ3aY0Evi34UYWLNAA4/KMKpXM+PpCjTDHruwIgYQLK6nVDsDUB1lFiP6
         oJ5yi82NchgIpRMCvV+lyA4ZfPYX/6EGtLN3zCzu5lS0KWIoZgkKZms1noGzrAGC6Y1K
         AjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162040; x=1689754040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=WvdDIpkkEgDlFDTkcY82p56RZgA0uRm9tCatNIf38EQXLagfBoYejE/P3aw+niXXNA
         r8OTStckOJ/Yj8cPHIdwqXeKV5I2XdraeYtRTYN0hE48KvvIy36uq176/saarWhB4FOU
         0/1WXXcoUKCc7C2QZDAOJgYMCSWciPt3lcMDVTBWAgYCZJ3VvxkqVHINQcc9GJtRMWXr
         jsXXK9aZ1p4K5fCEMyVQLquuW+YU2qNM5hQzKgvTrDrKDr6hDq3qEdIsZSN+rtNLlFtu
         xywdlT+haMDwU++15R80RnzaF4wRLlzHP56ZEn4r9eHZPmc9SwNvW48zBg7f0xVU+zsv
         y2kQ==
X-Gm-Message-State: AC+VfDyyV/TLNm5khSZ9KlcB3YJFcKoBqINC+kkeqYL8sxSsUSpyAN7e
        2QnWsq/YXKaAcJyGprW8wctSdw==
X-Google-Smtp-Source: ACHHUZ7v3gdLIlHqxN78NWrUZHoYR3P8EebnZies9tQeWq+unj2l6NzxOU3Pl+BDZKb+S6B50wFf8g==
X-Received: by 2002:a05:600c:2104:b0:3f9:988:b77d with SMTP id u4-20020a05600c210400b003f90988b77dmr3553869wml.38.1687162039927;
        Mon, 19 Jun 2023 01:07:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:14 +0200
Subject: [PATCH v5 2/6] qcom: pmic_glink_altmode: add retimer-switch
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-2-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fCvaaaAL0Gx7Xnks6/BexPRt3VhZDwY4J3jOffW33Do=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAyzjUBYmMjJQwjikzcX1W3z664ANJQ64ggrTUII
 MRuhZkqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMswAKCRB33NvayMhJ0ScSD/
 90p4RlhRc3DwL3ZtUBrRVFRmTyQjZqoeR9p1JxYIJushCZf3vBG8M2UGk9Ff1it6rwzhhmmF3+DdLT
 i4X0m+IYIkRaOU4Lk7ZPxEpoVnyum/AGWfSPuVGhlHu2NeEsJHcUroRrrWxzjLqNpTQwaE18ZdZoQC
 SH80vwUuOmwJlA4ThmQnr+NtV2Vn41Dk0lK2uwM43pdwBq0x2l4edSZCy1VBBcFS+uc3dob2oFPZ1v
 ufsmAeHHU/CFkFlIHUrsRCTQ7NOPluOP9nl2S97SUK+Wur3rNIpKAh7CG6Cc95tn1Gwm24iqnWx8NY
 3GTh9/lELM5iG0Bexrq19/jEgUm9Y69syMGuU8YfK6w3pS9W8TAdi7Du3XGWukZgO4lFYmNC0Om6nM
 62ynqs8mVfaKJy3b4EgtDTtsUkS15nrcqsCMJKyEyZNNAzKiKj19nSRAMjTevrVfQIuNgxUYulDav8
 VhSVEfCd5aSM207P4Jtis9ZYKm3ClWti5UgXB0RNJ6ZDROIzJkUGSZpJFpn1ynYAonz3+o2BuQkSOZ
 SepPWUBhFtDpWLRsUxRuaO4aoItd1KsDVY+2Q1Qxe/Dso1EvnKg8fz6sf3o1hfVgkZN9tQb4bJXwLy
 LQXWPwxzMKs95USVC2QMxwL27Nsj6PEElq72C/GfTlcwWYk18wA7I7t3cL0Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards have a retimer/redriver between the SuperSpeed
PHY and the USB-C connector to compensates signal integrity
losses mainly due to PCB & transmission cables.

Add support for an optional retimer-switch in the USB-C
connector graph.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 007d308e2f15..41d732f5b647 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -15,6 +15,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_retimer.h>
 
 #include <linux/soc/qcom/pmic_glink.h>
 
@@ -68,6 +69,8 @@ struct pmic_glink_altmode_port {
 	struct typec_switch *typec_switch;
 	struct typec_mux *typec_mux;
 	struct typec_mux_state state;
+	struct typec_retimer *typec_retimer;
+	struct typec_retimer_state retimer_state;
 	struct typec_altmode dp_alt;
 
 	struct work_struct work;
@@ -157,6 +160,14 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
 		dev_err(altmode->dev, "failed to switch mux to DP\n");
+
+	port->retimer_state.alt = &port->dp_alt;
+	port->retimer_state.data = &dp_data;
+	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
+
+	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
+	if (ret)
+		dev_err(altmode->dev, "failed to setup retimer to DP\n");
 }
 
 static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
@@ -171,6 +182,14 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
 		dev_err(altmode->dev, "failed to switch mux to USB\n");
+
+	port->retimer_state.alt = NULL;
+	port->retimer_state.data = NULL;
+	port->retimer_state.mode = TYPEC_STATE_USB;
+
+	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
+	if (ret)
+		dev_err(altmode->dev, "failed to setup retimer to USB\n");
 }
 
 static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
@@ -185,6 +204,14 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
 		dev_err(altmode->dev, "failed to switch mux to safe mode\n");
+
+	port->retimer_state.alt = NULL;
+	port->retimer_state.data = NULL;
+	port->retimer_state.mode = TYPEC_STATE_SAFE;
+
+	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
+	if (ret)
+		dev_err(altmode->dev, "failed to setup retimer to USB\n");
 }
 
 static void pmic_glink_altmode_worker(struct work_struct *work)
@@ -347,6 +374,11 @@ static const struct drm_bridge_funcs pmic_glink_altmode_bridge_funcs = {
 	.attach = pmic_glink_altmode_attach,
 };
 
+static void pmic_glink_altmode_put_retimer(void *data)
+{
+	typec_retimer_put(data);
+}
+
 static void pmic_glink_altmode_put_mux(void *data)
 {
 	typec_mux_put(data);
@@ -453,6 +485,17 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		if (ret)
 			return ret;
 
+		alt_port->typec_retimer = fwnode_typec_retimer_get(fwnode);
+		if (IS_ERR(alt_port->typec_retimer))
+			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
+					     "failed to acquire retimer-switch for port: %d\n",
+					     port);
+
+		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
+					       alt_port->typec_retimer);
+		if (ret)
+			return ret;
+
 		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
 		if (IS_ERR(alt_port->typec_switch))
 			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),

-- 
2.34.1

