Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97ED72DBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjFMH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjFMH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657231713
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so38591955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642971; x=1689234971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=IZ+56ICQhYAEP3JTkTvPnGa7/R8yALyGiTC1BJAjbOxSDdcZFB49umC5gMOFd4Fxud
         dl3LsNaIIswLxLPdCHLXOPg0Rn4juifFwrFXM2WS1jfAkwbSIfh1a56dKxZzFwATK2UR
         ft3E1w8Bmwf+0N99ANn3HMOiuNA8b2VECeKTnRQtQ87FCnwMhPF2DR6UpMzOfTX9p4xo
         DQEE6+LW/gF4s/8rNGM1OvQsbrGnIGqplipHyBIMKX/iMQxwdOPrpbvXDgWFxeOhT9Bb
         +FpCYz709Iy7z/NINjV71BfSfoAmYBDRoNEYdr0M5szSk+8It2Q1usxveOXTK6Xxxu57
         sQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642971; x=1689234971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W4DDI67tlbAaFkIpRMuH4m4GXyLOYQLIt7UXn6qsRg=;
        b=K+9A7jDtXHXyv5ThLc2OGK2Js56jbg4dg0tIiLcY5DabSXvvITRhxE95lixy0MHOaV
         uWhG3oFJU1qqEeSVYifFxsol0I6alllYugUELiBLTeUGG+SEpOReuSu0eOCmME6gi+8/
         Rw+Isu2b3Ur9rDDeBQte6k2arxvIvRZgCHmMfAg/7xoHF6NBJMklg1RHWk6jTJRaNkgO
         EwdxPjRbFOoCDD97b4wjGN+u3PlxkMBSxwTCBfV00ZfLs3K092PSYIduYSpKj5frsvzk
         WgNFLqiExMUnt7t9h95Dtrle013JTdNpWHbp6ldmCBKpUp+3H0rTEHI5Jmhvj+3a5BG4
         3/wg==
X-Gm-Message-State: AC+VfDxxqhtucrK+PU+LAODeLKSfesrS/mPVmU7IVhWv2GFww8hL7rlc
        2MyaomhdguHAcYs7zwLSUXo7qQ==
X-Google-Smtp-Source: ACHHUZ4jjQQ6fkfq5aHsPGYujSfRUBHzEFHJGX5LgUATnUm5UPaqMaBsAE1bQR+87OJcUGqlOOtPGw==
X-Received: by 2002:a1c:7203:0:b0:3f6:580:b082 with SMTP id n3-20020a1c7203000000b003f60580b082mr7225804wmc.0.1686642970618;
        Tue, 13 Jun 2023 00:56:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:55:57 +0200
Subject: [PATCH v3 4/8] qcom: pmic_glink_altmode: add retimer-switch
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-4-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCESpq85KSFlDFjrIEDli6bXlDoTgLhC6wiEt1lZ
 1tY4NqKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEgAKCRB33NvayMhJ0S5EEA
 CEjEOZQKJ4lBBRM1BcRNQYpWofQtcXxe+o09Exwq8JrghqkpAacYu4hKxJHoMQ1VOarYySYHchfmRw
 sxc6/gxiG4s06vkj3oVJn/yr/Ka1v5Lndj29GmsGb+NsRsU6AY9V3yr6Igepq21IcTlSVuwXWWen22
 qGTG1CWZFwgA0z5oGhNRy+HmCFww/uDWFYqLGCR9IjhIsOtQCScEVQAhAXclv/x6eWsw1CLp+mrVpY
 JV1dEOIn71kGbmt21a5PVHECj1Tj2ie6G2xUzOuasI805MKlTHlVNcVxPYlI4qx0fNQnMzQPOwUYY1
 QkCt2RcTXaspVWRVoEFC911P0+7JgoZEU7Ozcxj8C/xhqqhO6EvsYBqWkpzNP8H7jF/VcPLShTHoKg
 kjzkBU34qjvaser05a1+eRMq0Ovqme45MPhT34A9E7iWJ38sHgPGTEgHykxQ1nZii/Bv409syFi0sT
 +Q3CriIWoKxe+kB0o6j4ROCp0iWkSC52ZvouLfOuzpUZ4TT8hypGudFt9ZPrncB6qzzpJGcJHIp+lc
 AFl7/LFHEHh54NQVmh3KH1teoWwXxKanZVAAkJG/q2abVJoFL7IM9qyCve3EpDU58dWPFIzgV0YipK
 8dJDT0bre1GiRTvX9bAamkRGDUoOtiv42Q4TK7K/ophojXHI5z5rlqAfAGWw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

