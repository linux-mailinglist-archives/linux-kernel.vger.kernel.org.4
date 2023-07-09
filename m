Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22974C0C1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGIDsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjGIDsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:48:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090CBE5A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:48:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so5585031e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688874490; x=1691466490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pYCYaD1I9NzXxuURGxzFdIQMsoW5k/5IxfRvjuLiHQ=;
        b=ZyPoV8VuNEvccc+hchM2pV6o8vTlDW1fWllTLYlBPNPdfOWULamhpXnfM9RqU8+Rv8
         Nh4VQ/qEJ31/7gfzz29xep2rxDobhZqI+YQLk3TXyylAyJLs2PqASFqiuTBQufvwfSc8
         hi0ViseEb36NIaUgo40Q0kZUWsgojp/RZc9c5zOV+RSY4wq7cOd/LhybO1+qXPBonSfo
         UGOqQsV8NKhAgJH091u85RjIZBSgAfcSHmfKoa3G2P1RQGn7pSpsvu4xwk9uFM24q9M4
         g4euo0l0gzByhVXZF9YkYGMIcNI0Oij+lFnLVOASE08O5+zEQ9TGuEc2GP15VI07Hf9g
         3Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688874490; x=1691466490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pYCYaD1I9NzXxuURGxzFdIQMsoW5k/5IxfRvjuLiHQ=;
        b=ke1/5b/PH0IQhJDM770r6aEKyh0lqp+ijCyEFp5TZD79qxXjSVYwlyFCtlwSHkRrBE
         bZOd3SpZOkgisVh7C71ATeK+CAzRkdtSXC+q/d0HtdaLN0+0qqcckrxXeCYV9+j7KiGW
         6cPkQ3xhXRiGhdtXw34py3RSP97/Gyts+HWE173v623iA5ENoLpCcrDUFlYmyypFBvty
         X13fxe4Op5dEQSCi/fM7VPYjbw7Bbohu8Xw1PEWZcZbBBVYES5N9NQxb0D4j/kK24E7k
         BJaokZuNBxx5nqUzpXWn+7TR8KdqpPenkdEug0PDsnJOy10L2b2U4+c9OjHboKy7RH57
         pcQA==
X-Gm-Message-State: ABy/qLYR6Zi44oTmF8a/Nn406fsrX/Z45Vujvwc6uXieNcbVn2nl04cP
        ym8TW+0mdS27hpaSsH5vNr5wBg==
X-Google-Smtp-Source: APBJJlGpQHNclYa9samGTpOPC2huFZCJkKbTh7Lxrme1df9/NO10/U3dJhp/jvqWu6VUBS7HAXXP8w==
X-Received: by 2002:a2e:9086:0:b0:2b6:eceb:9b8 with SMTP id l6-20020a2e9086000000b002b6eceb09b8mr3593555ljg.10.1688874490407;
        Sat, 08 Jul 2023 20:48:10 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9b17000000b002b70206cd45sm1398633lji.90.2023.07.08.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 20:48:10 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Date:   Sun,  9 Jul 2023 06:48:08 +0300
Message-Id: <20230709034808.4049383-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
References: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current approach to handling DP on bridge-enabled platforms requires
a chain of DP bridges up to the USB-C connector. Register a last DRM
bridge for such chain.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index a905160dd860..ca832a28176e 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -17,6 +17,9 @@
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
+
+#include <drm/drm_bridge.h>
+
 #include "qcom_pmic_typec_pdphy.h"
 #include "qcom_pmic_typec_port.h"
 
@@ -33,6 +36,7 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
+	struct drm_bridge	bridge;
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -146,6 +150,16 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
+				     enum drm_bridge_attach_flags flags)
+{
+	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
+}
+
+static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
+	.attach = qcom_pmic_typec_attach,
+};
+
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -208,6 +222,17 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
+	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+#if CONFIG_OF
+	tcpm->bridge.of_node = of_get_child_by_name(dev->of_node, "connector");
+#endif
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_USB;
+
+	ret = devm_drm_bridge_add(dev, &tcpm->bridge);
+	if (ret)
+		return ret;
+
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (IS_ERR(tcpm->tcpc.fwnode))
 		return PTR_ERR(tcpm->tcpc.fwnode);
-- 
2.39.2

