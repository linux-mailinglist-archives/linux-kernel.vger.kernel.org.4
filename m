Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF451734CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFSH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFSH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4DBE63
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f86dbce369so1131648e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161521; x=1689753521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=RQt3m4J4Da/tuK8Zr7xcxMZ4jMfOpQCtBBssjfPgcE2rfOPo+ipfSAbt0HMrZMx0Dv
         tfuTOWC2gx2gH0VwvHBQ0PCHlGjEa+gdQAhvjec+iSUgRhuz6HwG9KGlVnEv7JNuWczL
         nyjhzISwF5yVkzMvW7IkiGpZvnr3ywvE15XagXitmuAYYxzG9Cj+EF+l1J4nmu+oRC+k
         gN3VtWaOlMj7xmNRhR14Y2IMxlM/ljL7yO+/wogm4/oamjuB5uK7u0qpq/7aFVov+O+Z
         GY8UuQD0DvN0xMJcE5R6UiiQnSUQLufTlx47WglX3oHVFRe2nOZr9H+f1fEx9JrMYMgU
         mxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161521; x=1689753521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=iRwVd3Si8vyQ4wtYXirtnAWylkrRnG2oog2KjSs0VuLryHL2rqjMT1aqI/DItUC0OG
         vaBRMTDpdmAaV6KwTj0Xdwpr6CjgBH7KkKOmDgZNGWIYJQhq8CKVPvoUXXmyrlaVb/pS
         ON+4HlSfLIc4AL0MHgCS6z5QdUbQXSmnVWUxRa1VxDLBSjCXm+r+81QV/vvOwUC4TMd8
         TTBUCToKT4BMGGqgdar9Xv4vFZ+FyG941/p6c88mFAJKXZolg9bwjhrbGx5vd7xhvZOQ
         5MRKxIWdkqO7rHVpGttf4sapXV6uFDoxrJueo/ECxblX7OmJdE5OkEpmQIPOJVtblQdX
         NqZw==
X-Gm-Message-State: AC+VfDy5FySl86ZN6plTLbZsAeVttfqjsLbpP5XXDmGuMs4cHkCzK9AL
        RMtC2H4AW2NQhhsR5LIOavAd/Q==
X-Google-Smtp-Source: ACHHUZ7XGvKnV3yJAy5//KAzL08FM8XkI69KFiNDDy7AAxhwdpdQh8KKDUkpNE2XOzRdZACCyZ81EQ==
X-Received: by 2002:a19:385a:0:b0:4f4:b38c:1f8a with SMTP id d26-20020a19385a000000b004f4b38c1f8amr3885028lfj.53.1687161520705;
        Mon, 19 Jun 2023 00:58:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:40 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 09:58:17 +0200
Subject: [PATCH v4 2/6] qcom: pmic_glink_altmode: add retimer-switch
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-2-eb2ae960b8dc@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqr+oPppKm8uZmmn0MEZmkNcfdKZZnK4rEpqr6u
 NMCVHfuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKqwAKCRB33NvayMhJ0YvwD/
 9DbP8N9jvpgqvOx0972X413z5tywwCs3FQ3i/fc7wn2PkjCzlo//ORWwH03fjmuzH17DbVmvB0vpJF
 DEbjl03DdUHUaUwRdLSfVWb4Tu3kWkutrfcZ6q756aayzO8O/kr2Q1lxqESzuCh7eFJVgQagXPIUjj
 6crg87jFDwn3+yt7jxmWZVdFWkFF4MuGKVpTEdcZ1UwWO6zkpNoBuOte2w4Y037I/6W7FNfYMCRq3U
 CvER9TwUUs8NXweEq58qcqDc+OdlqItqicrLPljSNof+q8FwreWh7ZOiwquRmLGZzRAQ5cuauILLqy
 rHlMY3ur7fzcDjyzmt/bUJLE0zg2dtvgq87fPa10BN7585gnObYTLaqbfR3w+HGovlPSvaE1cLAyrY
 RSP6v3UCLs0yh7P6ePxVcjK1i3fDaYKUEw2S1hX9ro67wwUX3isDWQzzYcPDodgR5LRPoYSWmAhezJ
 1AYqiU/nAoV7vQe4TB2kH+w0mEioRrSnvn3IetGXwfexobr6tAYNMtmIjE4pa1vncNn6IWHfG7Sb8I
 G3lAfIbZS2zzThCHUpuM8ZJ5+TvaBBey3Q6eEnzGPCKBWq9ZUQGsbStC6ymRKp0ChesfHbtJmkZrOH
 grV1SW15pN2mo6OjHz6kTu/fP5MZqDNLYHJx/s5aQzKN44q3IO9fuUUWuCEQ==
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

