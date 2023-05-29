Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239D7151A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjE2WQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjE2WP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:15:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E744FF;
        Mon, 29 May 2023 15:15:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4eed764a10cso3922965e87.0;
        Mon, 29 May 2023 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685398538; x=1687990538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmlJr9255kWhzt9IbTlRjHFJizJ8Idr5O0YOfzVhjSk=;
        b=sYITLYmGSawdm8kiiiMjyvlHX0qvVL9z8uaz7kFbWzQwrsLLdzVME2YZIDbgvh05Xv
         1Kp/dCGIaxve32gBHeIhpkEgnS/8b9EBY+ksB61vQ++QI9FVT2RbPHthDqx4CJFQPY0q
         ELmy0iqFQi1Dg9CERW1AWlU+BfBTeYU1IPPo16Llobrz+4Qqm2MyrQRuy+eVVM81KuZk
         TzNbXT6EK2yE1ID1FAFL55v0v+tR2jM4pq/KhHorxitGOW6q79YebnB6lUenqwYJtSWL
         C4WK8FqziqMSA/5rS6vpolEJCvCFc+dhaoYtiDdVb8mcJzwX1XZLOUCFNBMzF+OLErVh
         NjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398538; x=1687990538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmlJr9255kWhzt9IbTlRjHFJizJ8Idr5O0YOfzVhjSk=;
        b=CIaHYeDAAvIKaQA0ETFdzYcZvsseHvgJ3ro3IKUlmF7yuPdjnWuKjRIsHX2c6dR6VE
         xlJfMZBlnof45aRddczqsBE6AsYFycgqHVVodXiyNmLedr4hbqbd8dPTvMr2vNH0nPVN
         f1uxWXJzsqlSyZ6eZGMIXx0i/avobRG1Za2MUcHLw7U2lIRMSqWYmU2m2oSfYQQfAtxH
         cla+SBP+t2q1HcldtpIHdB9ySPStd76oGSMA7f3tY++WgpZJOE8CCV/ows0zo8P20WQr
         E0SbOV57wrQzBBofGT5x/pUcyFQitkyy7la63A+8IF2QjNyrCP9qPUAtBIIPnzQfCLDq
         BMdQ==
X-Gm-Message-State: AC+VfDx8ejWTE41xQ1EtZznzA7jOH11t8h344VTINC2JjxqOI7XinHni
        AE7MdkyxGVSzfwUNHWkL1usOiDGXKhJbqg==
X-Google-Smtp-Source: ACHHUZ7XvUl5Fal5p/aF2zN6yfWyuWeQZkCXnWiPDGdUgtmWyALh+TmbVjIWaokF9ePdkCFNGD7B1g==
X-Received: by 2002:a19:7516:0:b0:4f3:bb84:a775 with SMTP id y22-20020a197516000000b004f3bb84a775mr15499lfe.47.1685398538339;
        Mon, 29 May 2023 15:15:38 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b004eb12850c40sm132993lfi.14.2023.05.29.15.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 15:15:37 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: qcom: pm8841: Add thermal zone config
Date:   Tue, 30 May 2023 01:15:00 +0300
Message-Id: <20230529221501.43455-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
References: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zone for the PMIC thermal sensor. Temperatures are based on
downstream values, except for critical trip point where 140°C is used
instead of 145°C due to limitations without a configured ADC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8841.dtsi | 33 +++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
index b5cdde034d18..3bf2ce5c86a6 100644
--- a/arch/arm/boot/dts/qcom-pm8841.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -2,6 +2,37 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+
+/ {
+	thermal-zones {
+		pm8841-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8841_temp>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				crit {
+					temperature = <140000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 
 	pm8841_0: pm8841@4 {
@@ -20,7 +51,7 @@ pm8841_mpps: mpps@a000 {
 			#interrupt-cells = <2>;
 		};
 
-		temp-alarm@2400 {
+		pm8841_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <4 0x24 0 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

