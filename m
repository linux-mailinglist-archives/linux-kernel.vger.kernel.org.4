Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1178B694043
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBMJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBMJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:01:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01E30C8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:01:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso3614162pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knZk8UU+gILKuGNRfB7GT0O6VmEC+8WJYZQJqqmgOU0=;
        b=KNEceGhov0dwIzDFqRccLblZBmNCS12Y+7pw2sezMNDnTZkMcE1yexx71pOlAdF9Zk
         EGnJXkH0JkzRvWgutMCejHyyA4OtlPi65jEh6B/3/8eW50MEz8Fc0Tx5XEd4woZP/E0C
         mHkTHAyg7maQNuNgiHDForqvujhi3a1CRUNVwah0ohtAbcOvKsLAWytGLEDv9z08D2zD
         76O29qVsBldSfiRN1oZOp0yObO6pY7U/Cemp4NzONI3USI+tS4FoIJ4dl7F+TDomjg4H
         lWAvTC4ZgB0o1Jd7gshnH3tgNQm4jlTJ5WuuTH2u51LPNvZ63VaNuGJFvDoasQefa17X
         rSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knZk8UU+gILKuGNRfB7GT0O6VmEC+8WJYZQJqqmgOU0=;
        b=zkEo9wOTl7EvN8PDwYj4NeWBjOSACGpuWX+usLhqqWfD6DuWq4V4pbHJntHQnKh/H4
         8NarpiLBjgTa0AYMG5G5+W7jJVfQ0uEDFJ96dUX6fR8QCNJY6scpcfyRkKkC79JxXtFq
         UBY5b+D9XFb9IRhVfCLHYqOkjmDhWk0KipViCalSzeIn7oYCjMUi5W7qvZWzQUKdHY+H
         V9dv9h1HSyd5wBfiDqpbURQ6emLGZvTzyZY8NA6NMR5vOKH5qqsYA98J6IrMAX2yv9z4
         tbzWo3Hn6vq3S9QSuUQrACfXI/JpnxttA8AxTOBX+iAwyylfgaHmWcLP+KoDc0DO5oNI
         z+TA==
X-Gm-Message-State: AO0yUKWwWYLrdwNhlCNyjRURiMRTC1ELQJOEkKgg/UfSxg+xTqikbK2l
        hmHGf1hWOFnu2HRpbZ29vvh1
X-Google-Smtp-Source: AK7set/09d393s5gixpvWGjjSLjuwgH5lvWqLfMrJsru5MwM0BE1bIBxx1IfXj2obI5BB0vLe8KJiQ==
X-Received: by 2002:a17:902:9a42:b0:199:1804:48aa with SMTP id x2-20020a1709029a4200b00199180448aamr23251087plv.13.1676278898566;
        Mon, 13 Feb 2023 01:01:38 -0800 (PST)
Received: from localhost.localdomain ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b001964c8164aasm7677963plb.129.2023.02.13.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:01:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Patrick Wildt <patrick@blueri.se>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-pmics: Specify interrupt parent explicitly
Date:   Mon, 13 Feb 2023 14:31:18 +0530
Message-Id: <20230213090118.11527-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes like pwrkey, resin, iadc, adc-tm, temp-alarm which are the grand
children of spmi_bus node represent the interrupt generating devices but
don't have "interrupt-parent" property.

As per the devicetree spec v0.3, section 2.4:

"The physical wiring of an interrupt source to an interrupt controller is
represented in the devicetree with the interrupt-parent property. Nodes
that represent interrupt-generating devices contain an interrupt-parent
property which has a phandle value that points to the device to which the
device’s interrupts are routed, typically an interrupt controller. If an
interrupt-generating device does not have an interrupt-parent property,
its interrupt parent is assumed to be its devicetree parent."

This clearly says that if the "interrupt-parent" property is absent, then
the immediate devicetree parent will be assumed as the interrupt parent.
But the immediate parents of these nodes are not interrupt controllers
themselves.

This may lead to failure while wiring the interrupt for these nodes by an
operating system. But a few operating systems like Linux, workaround this
issue by walking up the parent nodes until it finds the "interrupt-cells"
property. Then the node that has the "interrupt-cells" property will be
used as the interrupt parent.

But this workaround is not as per the DT spec and is not being implemented
by other operating systems such as OpenBSD.

Hence, fix this issue by adding the "interrupts-extended" property that
explicitly specifies the spmi_bus node as the interrupt parent. Note that
the "interrupts-extended" property is chosen over "interrupt-parent" as it
allows specifying both interrupt parent phandle and interrupt specifiers in
a single property.

Reported-by: Patrick Wildt <patrick@blueri.se>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

I just fixed one dtsi since wanted to make sure that everyone agrees to
this implementation, otherwise I'll end up wasting too much time fixing
every other DTs making use of these nodes.

Next step would be to fix the bindings of these nodes to include interrupt-
parent or interrupts-extended properties and affected DTs.

 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index f2c0b71b5d8e..df7d28f7ae60 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -64,14 +64,14 @@ pmk8280_pon: pon@1300 {
 
 			pmk8280_pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				interrupts-extended = <&spmi_bus 0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
 			pmk8280_pon_resin: resin {
 				compatible = "qcom,pmk8350-resin";
-				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				interrupts-extended = <&spmi_bus 0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
 			};
 		};
@@ -79,7 +79,7 @@ pmk8280_pon_resin: resin {
 		pmk8280_vadc: adc@3100 {
 			compatible = "qcom,spmi-adc7";
 			reg = <0x3100>;
-			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus 0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
@@ -89,7 +89,7 @@ pmk8280_vadc: adc@3100 {
 		pmk8280_adc_tm: adc-tm@3400 {
 			compatible = "qcom,spmi-adc-tm5-gen2";
 			reg = <0x3400>;
-			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus 0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#thermal-sensor-cells = <1>;
@@ -106,7 +106,7 @@ pmc8280_1: pmic@1 {
 		pm8280_1_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&spmi_bus 0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
@@ -158,7 +158,7 @@ pmc8280_2: pmic@3 {
 		pm8280_2_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-- 
2.25.1

