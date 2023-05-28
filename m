Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14371374B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjE1ALJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjE1ALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:11:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8454ED;
        Sat, 27 May 2023 17:10:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f767eec104so19804071cf.1;
        Sat, 27 May 2023 17:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685232654; x=1687824654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxL0PbJXvl5Whcio0hte+d8fY5qOd/JOohZDFbRWZJ4=;
        b=ZZf0VXNqrJ97iOah24XtxGRQ+EiZBEv589J8AQxLmizYrOXqjWvRuI1qkByCN07IVg
         YpSc2FTzEqgjYOj4s2rWC0kTI3gu3BZqUEEC4oiI+QL8MTiDCZICcWwB5LBAHv8+O8Zq
         5fLej0veV/XEhL4Awp5YJJp+N7kGlOKT7WMIWTZ9l8vRLOHyjmCAbvH9YArUSQLtEP4s
         +80BBmax7JvN62XBiebRvyFP5Durzlbi0byoEWdWVeb5iZzmCiiGV8q4LR+ucld6DATW
         ZtRUeHrptU9KL4zrrz6lJ98lO3BhY7XGM+3xTiHfdn+LWSUiKGW/G3c2woApdZi3PG9g
         /JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685232654; x=1687824654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxL0PbJXvl5Whcio0hte+d8fY5qOd/JOohZDFbRWZJ4=;
        b=iB8dR02/m1TiBmr2zwZr/7s3w9Alj4rBopM/CviFwa5ACYsiKCuipqAM4jEOfve4IR
         fz5+RgWkJrjuafR0YSpFwHBNDEUFEB7eDE2IHZfZKJa4GLqCokURjngT33d02mnhbjxk
         8yORlnVa9FGC5TfPxvzNxnoNIY3CwCRqkb4sxt/DgytZ5/aDuBLaU53KS0LseKiWKXGb
         ISFoVeYEfa1ULFOZmmiD4aHBO/LlCA+S/8PtGDGHhy3fJrHKUvrwui93R+Ol7OnaR9sc
         8zqhJQfvTJdvSL06iOtiLefxppyl3YrOawI928GMKhN70XTqg57rEtl9+HQoExRZQpJ7
         ml5A==
X-Gm-Message-State: AC+VfDwrTvTipF9ao7U0g6isyFWRm8SA0Y/jyUY1mpcQQYZ71LEw0KUt
        XEYKc/P7rlJm52PpzfC0FNV0BsLlAMNqsg==
X-Google-Smtp-Source: ACHHUZ4mTky6H6gxephaGU2QhnztmGVpYXtr5/SkPNW9dzvCvbbUFQbGWkK6HsQWQcF8UfBgZgrl2Q==
X-Received: by 2002:ac8:5795:0:b0:3f7:fd1f:9e4c with SMTP id v21-20020ac85795000000b003f7fd1f9e4cmr6901176qta.2.1685232653901;
        Sat, 27 May 2023 17:10:53 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:28b2:2867:6311:b7d0])
        by smtp.gmail.com with ESMTPSA id t18-20020ac865d2000000b003f6a7ab1450sm2518454qto.30.2023.05.27.17.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:10:53 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH v2 3/4] ARM: dts: qcom: msm8960: Add USB node
Date:   Sat, 27 May 2023 20:10:08 -0400
Message-Id: <20230528001010.47868-4-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527040905.stmnoshkdqgiaex6@ripper>
References: <20230527040905.stmnoshkdqgiaex6@ripper>
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

Add the required nodes to support USB on the MSM8960 SoC. As it's very
similar to the APQ8064 SoC, the nodes are almost identical

Add a label to sleep_clk for the USB node to reference

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 35 ++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2a668cd535cc..b11e606440cd 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
@@ -71,7 +72,7 @@ pxo_board: pxo_board {
 			clock-output-names = "pxo_board";
 		};
 
-		sleep_clk {
+		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
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

