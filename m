Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9C62B9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiKPKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiKPKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073082BB2C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id h186-20020a1c21c3000000b003cfe48519a6so1304285wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBLdk6CIr4nsexgTsIaAvKj9UzU1NeK6BDO+l9f0nh0=;
        b=RA75zzhdv93Y5eQkODsVEo5kAkP/roa1avWcArTc86bFrFLnu94F70Fq2bEbNQW7Qs
         61jZT6cTy1py3QLwJWD6YKzJW7GreHCt0lm3Dal1+mN+3MLCiIXcTeeteTaIoqjquRG/
         IqvFsTeSBgefkzyW2FIWn70QxaPu88naD5sBMfSSNvfMqmvUo4FxZgcgp/hOOCRl8FpP
         7FnLvzF8d2/nqm7wmX8hFM5xjcISIN/gLMcnUGWMMmB7AyY9lsSNsOGvIwppeuNVVKer
         ZUxbkYrffKBEgoUCONrjt6QHCFKXtzIN6N/3qrfk87Wbld90PPGm1ERAJMZrtyCCReBV
         BrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBLdk6CIr4nsexgTsIaAvKj9UzU1NeK6BDO+l9f0nh0=;
        b=1eEQVNo/uMHDfPQK9B8+5BKpehU95QV9KhPzt7m5Yztk+JZS7JExdwtYp0yAfpJfqO
         FYWgzsiAiCNAYpdFr1ea25CbzBGmbDUhBoAddDtRepQbszxL29FlTkeYOF9xwGE2N543
         fJ/L0lu+khbR/zSnS47ZdAVRQW2Brv61cMlEdaPtj7Lj+V1iHpXGQwgnMn/c07fHYM12
         akGq6ritydwwedCIdtzjPiYnlsz9i5202T3OOsgMBGKnzNjfBqhj9xaOjsbrzHlz1spM
         XbANoINDnd62Qg5Q0uG2oEK3qahZnzg16pcpLeu4QLzh9FJgVJ2TfIa4utrReHqkkpo4
         NzPg==
X-Gm-Message-State: ANoB5pldUn0OyEy5Cb9DF2HvSoxT4IhTq5Q0eqQtStHeDh9zgbrv00Zf
        NULlLncRVoCQZ6hId5Sj9GTjBg==
X-Google-Smtp-Source: AA0mqf4lNPVl7Yunmgna4zPf9OPPKJFy7kqNhqqjckToHoEuFEQbOujyoikgr8ojJiAjgCgWn3ppSQ==
X-Received: by 2002:a05:600c:2296:b0:3cf:baa6:8ca5 with SMTP id 22-20020a05600c229600b003cfbaa68ca5mr1611369wmf.178.1668594747530;
        Wed, 16 Nov 2022 02:32:27 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022e36c1113fsm15107032wrb.13.2022.11.16.02.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:32:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Wed, 16 Nov 2022 12:31:41 +0200
Message-Id: <20221116103146.2556846-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116103146.2556846-1-abel.vesa@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
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

Add nodes for PM8550b in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550b.dtsi | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550b.dtsi b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
new file mode 100644
index 000000000000..16bcfb64d735
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
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
+		pm8550b-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550b_temp_alarm>;
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
+	pm8550b: pmic@7 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550b_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550b_gpios: gpio@8800 {
+			compatible = "qcom,pm8550b-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550b_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

