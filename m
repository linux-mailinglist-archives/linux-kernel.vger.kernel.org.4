Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9363D326
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiK3KTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiK3KSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:18:55 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64B324F36
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n21so40118753ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4rFInHPvXMY21RVSYqFleaDBM1EbzDLtUryUWQU3DY=;
        b=xJ2wKXA7FP1v6QuMtfO+soT5q0T5C2YYLggv9iyfhwdAoiStz40FwHwIAAZx4NMtL8
         67fb5l8AAj/XHiHiVzsoc1bggeR3HVmLkGhgfC+b4L22J9hBqRFZ4DrvZctfzQUqTMke
         K6M2IzQLtfVPeTKy6x4p0X3LfI3LntwftopT6PtZtZS/ur/C/uAoAdKGMRTn/Q4pvCb5
         LJv4d/LMUUDgAnThZqiwwiclswpqyJwplHouqjGYeFw+3QLTeYRt9B7KuWWUY9Y9h+t5
         Ghh2C4tBDe+kx1/hzO/eWod5azBBSyJfobOb+5l8ucpeLyVrbqTrEIH6Zx3TFmIgBKTx
         MKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4rFInHPvXMY21RVSYqFleaDBM1EbzDLtUryUWQU3DY=;
        b=BBt/wIpjg+f3f+YIbUauc9LkD4YjObMaQ6OJkDaeo26OkJ/IsPTvUsBiIKclqKgpqQ
         DXx8RGUVDyNIvjH9gwnAQHtoeHsHCROjV2nUNRdRbCmphMhB5IlowFOasJgCOn9QnE0p
         IUAMH+ZC5zFU/d962Wi0XW6iS3rCvyjD+7BVgaV2NHPbneJFT2YFXgXGLbixkHegTtYe
         ZHBSzuTm9weWC8k7I/VaCNgagneho6DDOpk71oR1H2ipZeaQ4LwsKuynO0iHS4KGPdqv
         XSZSl17YktB6ve984UuYwQ2tPRmMHvfSiaOhrDASekSUDS88+A+RyIn2YpBB70Inq0SY
         kghQ==
X-Gm-Message-State: ANoB5plz/XcfPFyvoA0HS6V82WAh3es5HtjOOZ3/sfRgUwgR6cKyLAXK
        GfUPYhBvrJd0J8n+w+Mj8rtNLg==
X-Google-Smtp-Source: AA0mqf4VRmLLA4Yd9wBTn1w03ZPuHyvtf+89yVnys5qOpK0+VBK52gSz+5k616FzufphTHGSj7HGYA==
X-Received: by 2002:a17:906:27d8:b0:7bd:6264:a022 with SMTP id k24-20020a17090627d800b007bd6264a022mr18879606ejc.693.1669803530231;
        Wed, 30 Nov 2022 02:18:50 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b00458dc7e8ecasm449462edq.72.2022.11.30.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:18:49 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Date:   Wed, 30 Nov 2022 12:17:37 +0200
Message-Id: <20221130101744.2849294-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130101744.2849294-1-abel.vesa@linaro.org>
References: <20221130101744.2849294-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for pm8010 in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
new file mode 100644
index 000000000000..0ea641e12209
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
@@ -0,0 +1,84 @@
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
+		pm8010-m-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8010_m_temp_alarm>;
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
+
+		pm8010-n-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8010_n_temp_alarm>;
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
+	pm8010_m: pmic@c {
+		compatible = "qcom,pm8010", "qcom,spmi-pmic";
+		reg = <0xc SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8010_m_temp_alarm: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0xc 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
+	pm8010_n: pmic@d {
+		compatible = "qcom,pm8010", "qcom,spmi-pmic";
+		reg = <0xd SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8010_n_temp_alarm: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0xd 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+};
-- 
2.34.1

