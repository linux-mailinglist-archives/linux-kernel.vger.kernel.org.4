Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497BC6B2563
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCIN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjCIN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E775559D9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so3398003wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZMb1WJobMURULo4bjzgB17D0z5nD/a0F5Do6LjeNkA=;
        b=oy0SGJJmMCZ2Q6ekJVGiTUZ7sYhNTDg9a3an8b99eb0FdZ01y5tvhn6LiYLOSoNBBl
         pB1ZlNRkWVhMusZpJYISEFWtiFgYfFvAdPC1vYl5Sse8njPuHb97kDKPr3QEEj4QE+F/
         LEiyX/ylrREjDYqOdsReNRssM879auUrlpfnpltrCE3b71EZ+5lLa5KFxK3Cw09yFg5l
         AvfAHR0yNHLEL9kWoJBiCjWFVHR1Blcr81TztTZpaIP+hkzCfVnvDWA9D8F3oTGoKUTk
         IDIWz+/eVnxrliQLVh4FiAOhxQxXFnFqWBWBcvO1IkG+CA7XvvuzYlv+/XjL/Q/S4895
         hi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZMb1WJobMURULo4bjzgB17D0z5nD/a0F5Do6LjeNkA=;
        b=wPmk60ufaoG3BBeXr+RDzR6E5hTkY2i0QbtdHaR6URq+qdpx6WH7hMhG7QJ2xCelDu
         WsEKSATcQFeY/lqmMjhttPxcV/fLAQ+LM8yYhhJPbzYh84H/+390A3gLlAiTdfEVkoow
         Q1xijXEAX1jvIJdh1QaIbIxzNBOmAlzaccOfwwVaKcKR2UWKhW/xNBFCUBfpniigiQEL
         cio4FE+vSySnUtG1c7CtOrbXUIz1hfq8gfgiOkEHvrwvmj1M0FiZlw3TwcaaoW1pCjBv
         xNIKzXEWwAxiY64K/gigU7Ok7CsYCdJV35NR6Br0hjezlub6gy3IpzmrDo8ITz0WDvlr
         91FA==
X-Gm-Message-State: AO0yUKVtwYk4CCPy04k/072VEH/IDeque/p/fbm6mDWA0OfMHeA848kz
        QZxVTGyvK/4BGbnrrxTMbtyBkAScQRubCSGBG5mQ8g==
X-Google-Smtp-Source: AK7set/hvc/5oZVxKFuGrLT+zEB4vP2532b0ew0SiOt0goZLDcbcvhwQv6UJqMer64EyJVCvSQ5qJg==
X-Received: by 2002:a05:600c:5492:b0:3eb:25ff:3446 with SMTP id iv18-20020a05600c549200b003eb25ff3446mr19789312wmb.4.1678368490851;
        Thu, 09 Mar 2023 05:28:10 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:10 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Mar 2023 14:28:01 +0100
Subject: [PATCH v3 10/12] arm64: dts: qcom: sm8450-hdk: add pmic glink node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-10-4c860d265d28@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pmic glink node linked with the DWC3 USB controller
switched to OTG mode and tagged with usb-role-switch.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 45 ++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index feef3837e4cd..1755ee3aa04c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -87,6 +87,40 @@ lt9611_3v3: lt9611-3v3-regulator {
 		enable-active-high;
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss>;
+					};
+				};
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -724,7 +758,16 @@ &usb_1 {
 };
 
 &usb_1_dwc3 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&pmic_glink_ss_in>;
 };
 
 &usb_1_hsphy {

-- 
2.34.1

