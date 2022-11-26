Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1656395D7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKZLrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKZLrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:47:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E75220E9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t1so5203591wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=IsC/E2ivv8AMAGnEXa3S6kBz/XUxJsbzOvKJKTHDBV/BcPLRNdFEHVwKUhOWsSGpmD
         zMN5A5xF4nDlQozPsj77kPugX8iXtinuGw/G+40vFdo5O0L1azbpdss3VQNLYAavnkWw
         3aAwaycMIozAkZGLyv+FQpAw+gQWqBcFd7VGW0ZD6RaWOnyJPoRxa9CX7c3n0Yi7Wbtb
         EsV0oN3URbOhNr5BBtUgJJIGYuuesekTluGu4VDa/8C8G2QJe1m69c65BtcYjfx85D0n
         99Z80QsEvOKw1HI629SORl23aKSNnKmRY04EmH4hCCL0+c+1pg78shI6IHi4bb9V8FlS
         ZApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=udprNQ9Tu/fltxCEzdxMZ7Yb+1OScvl1DsOv0C6VSI3MstdODEzRHAkVQnRe+N0fYv
         dOeV8VSD86wLZ6p8TxeDAvj7xESU9Nn88D1Skz/3DTmS982A69TOkjjLlRlqKdlpkcX5
         Vp/QPzN+m4xPm3ii2+sAW1KMDDIbA2nsL/CYcQhbc9Z7qRDuStKBcJ0oecahEmB5Cd1u
         MRYkZd67TXs5IRF8IY0H2XK+CTBzqCacI7MlF+6UbtjNTyCuPr+qmqUsyyEz/WwR4XC2
         FpYo0Z4PEwM9fPJrlnH7dlvtZ7Tmiq3KZ9FiNuJUHFcAULjWA5Zpb1vLlI6dRNhKPbYx
         nPJA==
X-Gm-Message-State: ANoB5pkkrjuzQ/sl7uM73V5kXwUiq5sPxom4rgbQWeq2qLtW5YwwKf7P
        p1SjbHJsASyilJtzluUmp4+eOg==
X-Google-Smtp-Source: AA0mqf7+V2Gr/Ke4yyIpvNcQBLPSjNnLeDCOjphI8m1F81muAHe2LX6jCO85mgHKC8if69Bdn6O8lA==
X-Received: by 2002:a05:600c:3543:b0:3cf:a6e8:b59b with SMTP id i3-20020a05600c354300b003cfa6e8b59bmr34810344wmq.128.1669463209451;
        Sat, 26 Nov 2022 03:46:49 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h5-20020adfa4c5000000b0023659925b2asm5942621wrb.51.2022.11.26.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:46:47 -0800 (PST)
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
Subject: [PATCH v3 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Sat, 26 Nov 2022 13:46:13 +0200
Message-Id: <20221126114617.497677-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126114617.497677-1-abel.vesa@linaro.org>
References: <20221126114617.497677-1-abel.vesa@linaro.org>
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

