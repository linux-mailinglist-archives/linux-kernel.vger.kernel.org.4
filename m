Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107174C80B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGIUNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGIUNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:13:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77E131
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 13:13:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso4441312e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688933592; x=1691525592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA1kyr+5gi8wVBQq27truSLCLcCOixtjsbYq8TbHk5o=;
        b=RxgHzFQV/TWZ8R5SPiK8DcLlBe3SX/+rkewBMUcj4n2kCJR/8C60Iw/USlcoZYXjLB
         mH3UyXwvcyYtrUbs34pKjSeD2xaT1sBZGGy5OVqXUT/gLQ435YDTKktPMaaeFJCE2WLe
         ny/LKsqCvy+Jel0jWCFmMXrdXfHPycYj2sDE6ckKZkC7N54BJiKOGfKbg1KIPRDOoTiB
         34dq63AoOph46rMHIx1vUJgjg0IdXEyfyNkwkwUjBUP++y1ISel6QZEHbeO5S0MlDTNV
         piDSj6QgbonE6GrJvAvo891JMDT5u75rwprntRAvNRAJgZmAfxIQ09vMwVZLdluXVOC9
         bQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688933592; x=1691525592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA1kyr+5gi8wVBQq27truSLCLcCOixtjsbYq8TbHk5o=;
        b=HfmBGxNqii+rCC/uxb8tZpPTvimElpDkqc3SQJZL7b+JVbuek6pBXDxTeH38BpWRvo
         yn35qr4nE6cwsEafQo3fSKLZK8L0VzfyqPbTtC8d6HWyZjoybiA29m3cD1KmBMjBDq+Q
         +YktFgSvqYb5ol2ARMIUtGksJaAPYut6E+RDWhm6+ljyUEuYdAhPUvYZn0gz4xni1JOJ
         1ok7TtGt+M3AkKEfCgYarTEwMhITdvDnM2nLvMtm4sVNVQeEfgGpin4o9pmlpjrIIAMb
         lza+TuUQDK4Z4s2EpfYHiX0BOQSKb1yKHj47yU+jSGeEczw6CAx9G5t504AKdayyJOqQ
         Spyw==
X-Gm-Message-State: ABy/qLYAJfiFO0cK06mF2RWz6jyWAKHYSCohCl4LZ0g7zpAKMt55iOm7
        BiNhF1v30AZfh5goAmLGDzE/uQ==
X-Google-Smtp-Source: APBJJlGeqDYei5cft5PMP/m5vV3TDpr4OYU84Zf3OoRCAr1nK1Jed/uealwGZ7MMNYE1s7YyZFtEVQ==
X-Received: by 2002:a05:6512:2528:b0:4fa:d522:a38f with SMTP id be40-20020a056512252800b004fad522a38fmr4231630lfb.26.1688933591924;
        Sun, 09 Jul 2023 13:13:11 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id c12-20020ac2530c000000b004fb77d6cab3sm1420378lfh.261.2023.07.09.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 13:13:11 -0700 (PDT)
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
Subject: [PATCH v2 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Date:   Sun,  9 Jul 2023 23:13:09 +0300
Message-Id: <20230709201309.274306-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
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
 drivers/usb/typec/tcpm/Kconfig                |  1 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 5d393f520fc2..0b2993fef564 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -79,6 +79,7 @@ config TYPEC_WCOVE
 config TYPEC_QCOM_PMIC
 	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on DRM || DRM=n
 	help
 	  A Type-C port and Power Delivery driver which aggregates two
 	  discrete pieces of silicon in the PM8150b PMIC block: the
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index a905160dd860..0722fb8d75c4 100644
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
 
@@ -33,6 +36,9 @@ struct pmic_typec {
 	struct pmic_typec_port	*pmic_typec_port;
 	bool			vbus_enabled;
 	struct mutex		lock;		/* VBUS state serialization */
+#ifdef CONFIG_DRM
+	struct drm_bridge	bridge;
+#endif
 };
 
 #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
@@ -146,6 +152,35 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
 	return 0;
 }
 
+#ifdef CONFIG_DRM
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
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
+#if CONFIG_OF
+	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
+#endif
+	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
+	tcpm->bridge.type = DRM_MODE_CONNECTOR_USB;
+
+	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
+}
+#else
+static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
+{
+	return 0;
+}
+#endif
+
 static int qcom_pmic_typec_probe(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm;
@@ -208,6 +243,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	mutex_init(&tcpm->lock);
 	platform_set_drvdata(pdev, tcpm);
 
+	ret = qcom_pmic_typec_init_drm(tcpm);
+	if (ret)
+		return ret;
+
 	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
 	if (IS_ERR(tcpm->tcpc.fwnode))
 		return PTR_ERR(tcpm->tcpc.fwnode);
-- 
2.39.2

