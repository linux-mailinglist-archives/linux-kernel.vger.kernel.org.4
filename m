Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04172360F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjFFEGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFFEGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:06:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D01B3;
        Mon,  5 Jun 2023 21:05:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f86875b122so19989031cf.0;
        Mon, 05 Jun 2023 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686024357; x=1688616357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/5Ew/nWKQC0Hp+PQTU4XGdu9OmMQKTpW4O893GVieI=;
        b=TdZhC4fK9DyYXDuCcL99ezhhzR2FYt5SIbcIGNGUEACCtmtsKkCwRtxsijJbkV6kRC
         bySvqYT1hfdbs/wqWfgksdGbUqtETeL6afYwVlY2SNDvXXqRV5bi4PCGkKr26owu/2pV
         /He6pn1J99ITVTlRUTSMW/l4+IwJJ9d7GK/TlaLuK0t9/UabMnoLEOjMNV76r/QihlSL
         qD7OcOs3KpGuY+M1VSzX3OvfwsxLXbzT3CYbS3hsmYgeXuQuxQZ1NnuLEKbKDblDLK6Z
         7iV3tfYrTGw6OVhLwZrT4OJ19vrmGbe3BsB8cy0if8J3l9mmes4T4QxHykexeSlHG0ou
         DxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686024357; x=1688616357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/5Ew/nWKQC0Hp+PQTU4XGdu9OmMQKTpW4O893GVieI=;
        b=hw7GgbK5k3XYVRdatPMz1LeeytfTMk5OSTbkvchJySWOc0fHgpdl07ivWu4uLWlIji
         uGrUzAZQJwHbJAB/gYFLId0+rXvr+sLbUPfXsa6isamAqDnCl7Iq4eFpaGyzJZUsTZdz
         ZW2u8cK/qRdVKIs98E2gv/CJI5Yl4pcoLcqoyT+WhRPUS7XVNcgq+Pkod/h+Dc7swAoQ
         Id29kMV/JGt8f0/ihHVCS1h0RzUcOVAQVnrRW6lI6Yjr4JF318s1OqAtPUEGz3+qQHmK
         yxCdJiZOLBEVgn4eWinY+hLnxTxVtDTa6lFcML8P/hfU5exI5jReqNeonSdapUNknMcW
         Eh1w==
X-Gm-Message-State: AC+VfDyeAL3pBMmbjXFmHq2Juk4mTKn3laq8s5J3wft8mxHLN06U1evf
        lMVK7R/IRxnO4idzD6u3tww=
X-Google-Smtp-Source: ACHHUZ48ICTMK8+jPajYie1seRRfS8Ys1Qbmh2kMJZTCbKIUEJYe04P9PZ6VW4QJWdw6nHCyIIObcQ==
X-Received: by 2002:ac8:7c56:0:b0:3f9:a73b:57a2 with SMTP id o22-20020ac87c56000000b003f9a73b57a2mr749030qtv.26.1686024357354;
        Mon, 05 Jun 2023 21:05:57 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:aac8:d62:35cc:958c])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b003e388264753sm382980qts.65.2023.06.05.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 21:05:57 -0700 (PDT)
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
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] ARM: dts: qcom: msm8960: Add USB node
Date:   Tue,  6 Jun 2023 00:05:26 -0400
Message-Id: <20230606040529.122433-4-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606040529.122433-1-guptarud@gmail.com>
References: <20230606040529.122433-1-guptarud@gmail.com>
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
 arch/arm/boot/dts/qcom-msm8960.dtsi | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2a668cd535cc..581b3ab5c4ca 100644
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
@@ -370,5 +371,36 @@ gsbi1_spi: spi@16080000 {
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
+			#reset-cells = <1>;
+			status = "disabled";
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
 	};
 };
-- 
2.34.1

