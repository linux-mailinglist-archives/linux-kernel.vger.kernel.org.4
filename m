Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B6610BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJ1Hy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJ1HyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:54:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9141E1C0717
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:54:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f7so1045271edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp4/jQvbIENnP1QtwrwaDwXz/OkxdZKv0tvGrojWyT4=;
        b=MjpM9MZ7KQ626nARv3VQkkMBWuqaYLA6tkr1hOd6GZ6IAtXB4zudJ4/iuy9hAz458Y
         tEI167n/yqixhstwbRoAcgOvgZ5kKQ7iJf3Zv0yuL/tB/p2uCBMZls68h18JOHYPQV8X
         2sqqBopQf1M93sNmQIK1oOAk+fi8GYwIigwZYoe3T7I397UzonpZPRaF0MD/XL3AGTFa
         HfzoW2auUjhvGYQba1WKljPugn7/u5PuByl5ff0q4tRocNkS13rRrma6G1MBo9oCnTsH
         qajoTRk2kFwVfiibOtu9V/a7RWdvfsr2rbIhVJ8VSXt3JwuMYSZw7Jtz/RPeRZQ9hJku
         w/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp4/jQvbIENnP1QtwrwaDwXz/OkxdZKv0tvGrojWyT4=;
        b=cqQMRj0NHvlEoALzkMDkAYdM0HVmlGGyRTtS/C1ek1zUEYuJeQSv7ypZFSAUClpIIY
         aPGnssTdHNEhPrvZLwa99u5YTDXdUcYxK7cmV1JY1iN4kiD3e975NiILkJXckE9SKUAc
         tCjmslfJpyZmMS+re1wsswqdQzQBH2dmtu31J8uZl44rCbls5ZNrYYvyCrmlfH9KrgRB
         f3+HWfj9HLbleO6SSW/xXP1mcezfcCHQZSO3Zn8uM8AAEs6bMxY9E+luXoXd6k2zkwS8
         r73qTw9EC1tyvDt515adgwJqnoGQBaRGAbm5Zq3ZbkfzlpobSynLURsFw4ESHEhC0ZcE
         RpOA==
X-Gm-Message-State: ACrzQf0sIyk5T/GUr+7m3I31TcuL23dBaJxZ5SNX4ZhrJhFuPM7VyHI+
        vXLhZ0IIFnrrN747pxqNNAvhaw==
X-Google-Smtp-Source: AMsMyM7THOtjXHLgJ6CYUAmJKnXAQalP7vJeG16re2V6aCrp9nYdbkbV3EHye5aN5aatiizbQvx7Eg==
X-Received: by 2002:a05:6402:414f:b0:456:c2c1:23ec with SMTP id x15-20020a056402414f00b00456c2c123ecmr50812155eda.420.1666943656207;
        Fri, 28 Oct 2022 00:54:16 -0700 (PDT)
Received: from otso.. (31-151-115-246.dynamic.upc.nl. [31.151.115.246])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906b00800b0078dce9984afsm1776009ejy.220.2022.10.28.00.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:54:15 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm6150l: add temp sensor and thermal zone config
Date:   Fri, 28 Oct 2022 09:54:05 +0200
Message-Id: <20221028075405.124809-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028075405.124809-1-luca.weiss@fairphone.com>
References: <20221028075405.124809-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add temp-alarm device tree node and a default configuration for the
corresponding thermal zone for this PMIC. Temperatures are based on
downstream values, except for trip2 where 125°C is used instead of 145°C
due to limitations without a configured ADC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
* new patch, very similar to pm6350 one

 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index f02c223ef448..3f7e047cfc06 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -5,6 +5,37 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm6150l-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm6150l_temp>;
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
+
+				trip2 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pm6150l_lsid4: pmic@4 {
 		compatible = "qcom,pm6150l", "qcom,spmi-pmic";
@@ -12,6 +43,13 @@ pm6150l_lsid4: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm6150l_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x4 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm6150l_adc: adc@3100 {
 			compatible = "qcom,spmi-adc5";
 			reg = <0x3100>;
-- 
2.38.1

