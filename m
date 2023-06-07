Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025037256DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjFGIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjFGIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B77AA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so58620155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125111; x=1688717111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=dHsk4gk7Y2eq8T6jiA8wIxwu3/IUyCzuTMbGyXUhNug2p/F3Aj5JbTkZNf9Zg7Mihl
         PkofCQ+kLB6tvLf1oUVwEs5mXIh7v486uJFu4uC3zEYbSWsIAN7RNIEid4oNvBgpqjea
         MVvE3vmws+cBAqTqjZ6Nipx3/2rW230pFCEvbklhUMsZApp6HswAiP06lKPdxyDCNO/8
         66/3SKDgGtnf0/t44e9kamzS2EtmRZGbK5z0V5gN6bF/QHxdtGRADJgHcfXop+NJlQyP
         Qj/N7nRVckl4qhBnlsUHHC3jCuPLWsWM93mUuv06vCupkCbzP1jJgw507xY6JKYzvXeU
         hIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125111; x=1688717111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=POQnC8Cty6b/3oje+ZSYzkTsQVCbn3c3tbSElY7nY1HxTdWiEbtYwffDqFWpGR3J6y
         Dlw+YFh6E1ZMp44YfWUdA9Q6BFZe0acPzLBCYJfiNAICUvyG8fsvaEOiRya8Frnewrbu
         OMhjejHJpbsvcg96bhPJOeqCeTCQ5+dYoHKUpP2MheuW5j3BWydprZ5PBpTQFy0vXLBc
         OnLjWln7KDFVNLWaZeE8zZApd+2SVkzAnBvs3mgoWWsMHZckpTuEHfdHEoh5bt7WjGDQ
         U/m4QP7OKnGOPWxeCfIHxTNDntz2/6i3s0OLj9VFyCbSLZbojl6g9rDmbW7CAVkPNjsR
         oMdg==
X-Gm-Message-State: AC+VfDzHszQpSkZoOu0VxS9M0QNYXyCUkGTCP+a7+qcvkpZG4i5HQlXI
        te4syBzPMSf8qheDqPw5WBZeRw==
X-Google-Smtp-Source: ACHHUZ5l73ErYal5dkq1AWpzDpLCPdosyXXcUgfbUVJoCWodlzWlnrStMzim50b0XHrnusTHb3mreQ==
X-Received: by 2002:a1c:7717:0:b0:3f7:eadb:9413 with SMTP id t23-20020a1c7717000000b003f7eadb9413mr3327427wmi.33.1686125110895;
        Wed, 07 Jun 2023 01:05:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:03 +0200
Subject: [PATCH v2 4/8] qcom: pmic_glink_altmode: add retimer-switch
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-4-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fCvaaaAL0Gx7Xnks6/BexPRt3VhZDwY4J3jOffW33Do=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDoujbS4ZNRfx7YmYkKVJwLBYleJfyoNH8eLHHaS
 VcFjjkuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LgAKCRB33NvayMhJ0Uj3D/
 4gXh6t8IYHXkRBp/aFfuGRwYCbO1dx/Cn4lPojQgJ3PXWGBdinI7H/BPZtj+vIUsfELrUp+7lH2nxv
 kcOkKpb5BYdnGp7PgEpXSIETeehm7+BDxtgzRwcwz/lb5lW/15DwvNeyFWzy8FFOpX5xz3XdyCM0Ux
 WLa6DVWrsPZl8cV38jlLj/wTf1az0e7yLg/2caJQZrAlJ3YJkKErsckTmdpFFg/c81zcQTUOzBlYNM
 BPqZmpzVRphot91ic1Pbx+7x+QKZnnGpD2/Gmvaaan9tf/XMziN1LUVFz9QJCjArOulz2/esNwjg1b
 lFPpCoq5U2DFCdP2i4R3gJkYNhh/nArwY1cwSS8qBo/grDbildq5u6m2xNCQaeKK7V125sNFmHZREs
 C+sea8DoPYAdKLBn1ko31NC7cuiHaFAzhdglkjrM/xp5Wqd0dNiLUNsa3vR1EWKy3ha/rjE3jHy2Wx
 kqlX4kyQz2qhLz6NP/BWKYz51GwTEWYMzE5UYCm7epyCHlEdguyL9Pn3G3+Zhp8jR6AKMfz3k8LxeD
 md3J8PMTAV47AclxUPmfI/zVLfiKgRQHuPewNX5oqSavmkGLCwEpSPgC9yjccaw25mmvSKk2ooVmPd
 t0MIFBVkdqLQjqOjoIvFcXDTYJpkGOWFdjzw8hqSzcLSvfoMWFV85n97oaMQ==
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

