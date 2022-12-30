Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07119659BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiL3UXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiL3UWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:22:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028511B9E3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so7467484wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=NzOPT85TaEKN5YimiKRFKQ5nBZdd5zlF497DNz1Fk/xQZ7P8/fprzm/lJg09MYnQCO
         cmxjhDOqO0XtUqbyYNV/0vDF2zb2ErlyBevBwHADYeUNAIz79Tg0aB30bC9aLJa6KZJ6
         IyPpKKUeOTmhH4785lY3XlmItxlXlFVbp+oK+3RHr1NgsdjzhPIF2WpBPZQmfkYnLtrU
         XNEcWMphBbe2oUfbcz845ciBmy3BVUzMyP668QPrNF5Fq4d8v2pLdwjZqkPaPOSwspCt
         tA1orLOj4+CADlDaN0ajKbNBELXVLjSX75Zt31o+KycotxfpJczNrnRobklrYnheP1Ib
         +JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=7BQ3LmZW5xpMjg9wB/7bdqSVZqICDKrRY4c4btWnlChQ5HtwBBSoN9ZXXACRbeSOs2
         rhIlJ8PLEyh/zIFRVCCPsp08bv+PgbOA1uObQsTv7LY/Zmbr15Y690j64G0b+poZw3av
         3wDLoGuoEF52TBcrZnsvEb1lXMHuFtDG+t88mpYU7G23uKhsAW7YAO3e44e3EL3g7EOa
         s7PHmB+Agch5EbmJ0XpspV4LCpbmsjrRcEWsbg8XauPXGg78++tiXYS6AtyZcerEdvTY
         9DcE18LEGmhgEXsiini8nLreZP0UKna279ZEAU3PYmwhW50rjybj3pCd2SABANGYOSNI
         xdZQ==
X-Gm-Message-State: AFqh2kq9iyMNzg+OH9B1hpm3WVqVZF+C0sPDOwxvdMoThk/n+TOhbDLR
        m9p9an7RZ5PbdpjW+SHtqGp69A==
X-Google-Smtp-Source: AMrXdXtOfJru10su3LESOQsRfqm9Ohh5kbnBCGkaUqsfh+TEt/lfQbkwJ15RtqNiPDw4pl0XxgPV5g==
X-Received: by 2002:a05:6000:1a47:b0:242:78e5:6c13 with SMTP id t7-20020a0560001a4700b0024278e56c13mr20661445wry.44.1672431767573;
        Fri, 30 Dec 2022 12:22:47 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z1-20020adfdf81000000b00268aae5fb5bsm21359142wrl.3.2022.12.30.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:22:47 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Fri, 30 Dec 2022 22:22:26 +0200
Message-Id: <20221230202230.2493494-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230202230.2493494-1-abel.vesa@linaro.org>
References: <20221230202230.2493494-1-abel.vesa@linaro.org>
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

