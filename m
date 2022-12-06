Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3D64445E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbiLFNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLFNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:13:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49527CCD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:13:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vv4so6115081ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxTuDuP9N5RzZdY9G7Umgi4OKE3T+v4Fwox44/I+AkY=;
        b=ypkbZjGT4Z4uMg9Ntv3w4lpO8IRqwTWiV97jNT6lyXfjkkcnMkPRZdREhFxHdfUKHy
         BHsOUwdyUDBd77lFtpaFBDFVIkmSWm5bIEgzCSyCyETIsfAtvC5/1zNBYIgqTFP/w+Md
         KREg7EjJZ4T3TjPzJMpCfnq4xHSnBCg9aC1Dyk87adiEKLgq1mM2znjpvvAuNwZgLB4W
         f5CHLX/U89eJpZg3ILguRF+a9u0yNo0vdjW1v3TqkuilPG3hgpChkF79qWqU1b2MPEXi
         7hnVCKuuCrPyxyi6mNHVlJVO/Byxvwzq66KItLFGhnvEXEuDakWt5lfFbxv1jRFWCUO/
         TOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxTuDuP9N5RzZdY9G7Umgi4OKE3T+v4Fwox44/I+AkY=;
        b=vn3WMXTMEXYOR8vsMf6n01mpIbBqytiF0kZBZFATlpY+Y1PGC95qRIAwL7hNE5kK7y
         kQqV2kSiLZV5/z+AXwVhXB6IJB86aR+GMO35J9PqBB5DIK2MVqWE+fE9amdJCts4oJVW
         Re+coKR/96Am9/fi7SyMIxCx0GnpNdElGvGTiWbrCxKwuFMxlh2rVaZ+lSshKNlBi30E
         i1SW/1NH3ETwHVWAp+ZTwIR1qid4eSVvAns0y2S6SFL7UcoQRroBC2vzAMd1OZcnErD8
         eH2dCkqaLcRNxTnIpxCEbLzYTum1a5KfjA5YL0Yt0mS6BRlC1/AAqWjfR8uLD115jHHh
         TKYg==
X-Gm-Message-State: ANoB5pmoRD9yXVuM+fpuc73zIajqqrbfWQ4CjBhxNDjxKUie+cz614i6
        xOhO0mjiNqG97PU/+mEnKXFsJA==
X-Google-Smtp-Source: AA0mqf49oFAqt14KKLJwAVdRSsrOuwZxSrraZp/0Y4SKi5FsOw/25ZCR8aoXRGqIdYAxhKrcGccp/Q==
X-Received: by 2002:a17:907:7613:b0:7c1:5a7:b91c with SMTP id jx19-20020a170907761300b007c105a7b91cmr3819859ejc.749.1670332407653;
        Tue, 06 Dec 2022 05:13:27 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b007b8a8fc6674sm7345775ejh.12.2022.12.06.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:13:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 09/10] arm64: dts: qcom: Add PMR735d pmic dtsi
Date:   Tue,  6 Dec 2022 15:12:51 +0200
Message-Id: <20221206131252.977369-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206131252.977369-1-abel.vesa@linaro.org>
References: <20221206131252.977369-1-abel.vesa@linaro.org>
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

Add nodes for PMR735d in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmr735d.dtsi | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmr735d.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmr735d.dtsi b/arch/arm64/boot/dts/qcom/pmr735d.dtsi
new file mode 100644
index 000000000000..41fb664a10b3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmr735d.dtsi
@@ -0,0 +1,104 @@
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
+		pmr735d-k-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmr735d_k_temp_alarm>;
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
+		pmr735d-l-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pmr735d_l_temp_alarm>;
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
+	pmr735d_k: pmic@a {
+		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
+		reg = <0xa SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmr735d_k_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0xa 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmr735d_k_gpios: gpio@8800 {
+			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmr735d_k_gpios 0 0 2>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmr735d_l: pmic@b {
+		compatible = "qcom,pmr735d", "qcom,spmi-pmic";
+		reg = <0xb SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmr735d_l_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0xb 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmr735d_l_gpios: gpio@8800 {
+			compatible = "qcom,pmr735d-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmr735d_l_gpios 0 0 2>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

