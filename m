Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68666637AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKXN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiKXN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:58:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C9FFAA4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id cl5so2580539wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3mUw3WAFJms85vIR5glpftx63nEOz1wwmMM7KjPZPo=;
        b=FPoWFRmSIYYS3LC+wEODQqTz0Pug1qDTB+kwZw4bxdcypjCA2cWV6GIyx3UH65YAv5
         ouH9aVCApNIvN7drbfkhrbQfBrkqDJIDxg6zkUIsZFmFwXcQodpNG7PEqkGbWXViv2IV
         /dKYkuweLpEQpiA9L+JKGclAX/MDzwBhF5O4hvtf1pcwFu7r89eT5ln65uZ0LvhEjvFg
         fRjjCfxk84C2pMlTKh2/K6zO6g33+I4WobYbvsQntMdF+xSq54qR2co4Wt5UM3oOKtic
         GLabikbVAIe4dePBRfpCC4vI0o8Kt2o5XQqO+rUQElWoARymBSMu2OgDENUFKqVlpXuX
         3a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3mUw3WAFJms85vIR5glpftx63nEOz1wwmMM7KjPZPo=;
        b=RU2ZNeQ9lg4r+M2HUpVouzcRR6Xo+r+Sy4wKGldByLDkp5L5blDzZ8qlJFcKriTIMu
         e4lMM4vVKX8+xl7bJvmXX2WDdac53QN2xfjFyCJf4xcY02LyAnvbrr4oDMOLkJXmTEj8
         r6rH+l8K2igTmPXKaMJAcuxxi4C/j+qu4QYDZWY7cErGVSOh/R99kvPYpLdLcUkEW/AR
         pZX49BK2MOQj8xRgJBOHZbEUSf8hEOmZnswKXkmwVxw+XHo/3oM94034YqDB53SQTWGi
         Tcv4RtWCxDMT0NglD8E2nqphP8B3QmWbXGyW7z415eVSDg42npa9nzGD/tciCjroqPQ6
         TfRQ==
X-Gm-Message-State: ANoB5plGvv8omrI06ot2ngPCwd2kYY9gj5OGG1mSpIYuPnLz+wIxXolY
        abBRV6yGGHEkn3N54bDlN4b5Zw==
X-Google-Smtp-Source: AA0mqf6D1IOuOInFxjKTgwpEvUvm3QiIlwIKNihbNY47dxua2xMVDDml3PUy/DDkXvKpROX95TZ/NQ==
X-Received: by 2002:adf:ecd2:0:b0:236:6fd9:9efa with SMTP id s18-20020adfecd2000000b002366fd99efamr19336831wro.101.1669298219093;
        Thu, 24 Nov 2022 05:56:59 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020adfebce000000b00241d21d4652sm1414322wrn.21.2022.11.24.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:56:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Thu, 24 Nov 2022 15:56:42 +0200
Message-Id: <20221124135646.1952727-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124135646.1952727-1-abel.vesa@linaro.org>
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for PM8550ve in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

Changes since v1:
 * added Konrad's R-b tag

 arch/arm64/boot/dts/qcom/pm8550ve.dtsi | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550ve.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
new file mode 100644
index 000000000000..c47646a467be
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8550ve-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550ve_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+	};
+};
+
+
+&spmi_bus {
+	pm8550ve: pmic@5 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550ve_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x5 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550ve_gpios: gpio@8800 {
+			compatible = "qcom,pm8550ve-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550ve_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

