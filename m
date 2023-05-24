Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CCB710179
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjEXXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjEXXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:05:24 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE33C5;
        Wed, 24 May 2023 16:05:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-625bb54004dso209246d6.1;
        Wed, 24 May 2023 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684969523; x=1687561523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4GI9mhEsvaLybeUdgU7X1HdrEKhJkxPJObS9ygc9RM=;
        b=rOmcd5OqwuATj4gWmBaUaZM0fcu7p+tkhTEDK3pF8+jUwh+Uds7w44wTEV+kHZ6b7J
         KA8Qyjyv1mwVvbvFZdA50jr36maTqqatuevx+DyBXGK3bGw+PMiEi6MFccqcAVEqIDQ6
         MKv2iOAp2XpDbs2LQEXM/wR2mYJ96nTOZ9lQgiaKgaqoFB3mSDykq3AEsMehHIVo2ntw
         oyE/T7JegOVIKVfr1x7FarXmFoPjfjTw8Oq8eUviGV89DxXUTHARGTan/LjLA5nZqYWW
         7Zmjo05+LGNRR3jf8d7L8W5etI+Z2KIoVeFOO2tBcemOPAoXP+XIubGkSjBUvJgCDNUI
         5JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969523; x=1687561523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4GI9mhEsvaLybeUdgU7X1HdrEKhJkxPJObS9ygc9RM=;
        b=TFIFESp3mCmCzZBlPWWl3v8LPR9ZzLbhlw58CxwCBeQCeI4f3uuKXSsheE7D0ZDjbX
         Y1WKMpQsmbl1M4YZgiKNLDNcyhmL+ZCt/E0sYnNrDY4NnCrugdZoAgOnDTf13enD4b3g
         XsnHtzKKIyS7j4RcAcckXkpi8x4mVp26Dky8owi9tPmI6+wCff10RRzEte/9y2pNUFXv
         MsuxvJx8jCcf6o4sYlfb5ahVzD8Dw/pGuEOHg+Gpv6wDEXJc/uAWMGmLLduMangQr3Yg
         dvUZrxWUNymauCFp5jSe3z1df1qfJz8BlY0rntg0+WRgpmgT63+nULc1Lm90xpK84HBW
         KwDw==
X-Gm-Message-State: AC+VfDwgoukKg5JlB3n1NB17aFf0UDSrYEOVRsuEjbu05vEbqltRXz5F
        quQMuA8G/CKOXn4BWRkJDeU=
X-Google-Smtp-Source: ACHHUZ69MiLVKa+pG18DCmWDTxloknLSJKBawROXUdgxG2xILSRw3U9mIh1nK7ZUFH8l3SkFVXNHhg==
X-Received: by 2002:a05:6214:2243:b0:623:8818:197e with SMTP id c3-20020a056214224300b006238818197emr1235979qvc.21.1684969522764;
        Wed, 24 May 2023 16:05:22 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:650f:ad8b:38f6:d091])
        by smtp.gmail.com with ESMTPSA id ea15-20020ad458af000000b0062075f40f61sm3914019qvb.73.2023.05.24.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:05:22 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: Blindly copy the usb node from apq8064.dtsi
Date:   Wed, 24 May 2023 19:04:57 -0400
Message-Id: <20230524230459.120681-4-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524230459.120681-1-guptarud@gmail.com>
References: <20230524230459.120681-1-guptarud@gmail.com>
MIME-Version: 1.0
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

apq8064 and msm8960 are extremely similar SoCs. Therefore copying this
from the apq8064 dtsi file should not be a problem. Tested this on the
Samsung Galaxy Express and this works.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index a4d8dd2d24a6..b11e606440cd 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
@@ -370,5 +371,37 @@ gsbi1_spi: spi@16080000 {
 				status = "disabled";
 			};
 		};
+
+		usb1: usb@12500000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12500000 0x200>,
+			      <0x12500200 0x200>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS1_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs1_phy>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs1_phy: phy {
+					compatible = "qcom,usb-hs-phy-msm8960",
+						     "qcom,usb-hs-phy";
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb1 0>;
+					reset-names = "por";
+					#phy-cells = <0>;
+				};
+			};
+		};
+
 	};
 };
-- 
2.34.1

