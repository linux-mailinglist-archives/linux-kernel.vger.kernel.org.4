Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192A710C21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbjEYMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbjEYM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:29:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188112F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3095b1b6e02so1403227f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685017791; x=1687609791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wVbIEaJsM5OY8HZfy/cSLi92iOlN1XdJzTfl08SL0Y=;
        b=S/hiQcj54EasvfNMkjHUVX6tN8iBKcwjc7ZOTCAzwfyxbQNeRCyIHOKYkfrDpkS75u
         Mcn3yRvyf76C9a2C4EDuKPG1Wo8Nh9470waOjYv69VI/Y1y8NJbdqGdJqhQbLKzQ1Czu
         1WZldN5lrxJvQ2lDlRmyJnbXoSIAbY6UMHFJCeKDMQ1GOPsoITa9fWyR8T+/quL7nPze
         2lcrpGq6I0V7s/I/blTh97B1PYILSLJdt6ZIgQrPMErZ/91HslnPGP5fhyf0jrS8cs5B
         WnvF6TEbxfmj+SsQeOmPBqfBCdQgtolhX3sUHD2AJgvHAdEXmF05pdIcM5mXCDIkdUMe
         vGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017791; x=1687609791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wVbIEaJsM5OY8HZfy/cSLi92iOlN1XdJzTfl08SL0Y=;
        b=ZyhZ098R6ognhcR0g7XVP/XOMqLKRuUyqHMMMamriKl4gFVMBXDORBdDK+NwnxxihC
         45XG1d2bi6t7bwax0sYKjK/BVQ4JCqgN6r0lQzH1qldRf3rlb5xkRnaJEIJndU4ihq22
         umjznEr1t6kZkDVK6gwJ4q1Y3FG+JDs12vfsNkIaMFt3bCszw9XknNa+TT0Hla80i4vZ
         6c/nqSmbVsqOq27HI5tCGSW+FH1u2NYDusahXlfcb3370Bh3M2OLw7UNKx6VTIjZpG1Q
         481YIblCt9/5jcssw3WHLO2AIrnoz39fsslw/qDm+zbytwFNX2LU8OwnaJYNwXq+wRlO
         ooqg==
X-Gm-Message-State: AC+VfDx7tRplWB2qhXG+CaZY5W6+6kyfvny/QBYOmyT0eT1CsWgPQqXh
        Eei0bTR/1NSZdR1wO3+pkIFI+A==
X-Google-Smtp-Source: ACHHUZ5Grhz0788eONWDVICfoGRUxWBdSbED9SQaNLN5MQHRvisw8ihyAmiEoGzgINo4jt9nP7kQEg==
X-Received: by 2002:adf:ee90:0:b0:306:4239:4cd with SMTP id b16-20020adfee90000000b00306423904cdmr2547779wro.31.1685017791314;
        Thu, 25 May 2023 05:29:51 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003062b2c5255sm1700227wrm.40.2023.05.25.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:29:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/6] arm64: dts: qcom: sc8280xp: add resets for soundwire controllers
Date:   Thu, 25 May 2023 13:29:29 +0100
Message-Id: <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire controllers on sc8280xp needs an explicit reset, add
support for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 6730349e34f4..39be2e89ce05 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
@@ -2560,6 +2561,8 @@
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rxmacro>;
 			clock-names = "iface";
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "RX";
 
 			qcom,din-ports = <0>;
@@ -2634,6 +2637,8 @@
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&wsamacro>;
 			clock-names = "iface";
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "WSA";
 
 			qcom,din-ports = <2>;
@@ -2656,6 +2661,14 @@
 			status = "disabled";
 		};
 
+		lpass_audiocc: clock-controller@32a9000 {
+			compatible = "qcom,sc8280xp-lpassaudiocc";
+			reg = <0 0x032a9000 0 0x1000>;
+			qcom,adsp-pil-mode;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		swr2: soundwire-controller@3330000 {
 			compatible = "qcom,soundwire-v1.6.0";
 			reg = <0 0x03330000 0 0x2000>;
@@ -2665,6 +2678,8 @@
 
 			clocks = <&txmacro>;
 			clock-names = "iface";
+			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "TX";
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
@@ -2901,6 +2916,14 @@
 			};
 		};
 
+		lpasscc: clock-controller@33e0000 {
+			compatible = "qcom,sc8280xp-lpasscc";
+			reg = <0 0x033e0000 0 0x12000>;
+			qcom,adsp-pil-mode;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		usb_0_qmpphy: phy@88eb000 {
 			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
 			reg = <0 0x088eb000 0 0x4000>;
-- 
2.21.0

