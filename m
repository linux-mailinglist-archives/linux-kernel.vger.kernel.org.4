Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A2648E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLJL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLJL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:57:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD58B19282
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:10 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so11056393lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFb4si21ffSYYK/qJ1bR5Dkl24vvEDw+ifpOVVdfTyQ=;
        b=TX2ru+NJpghvCb+IXtJGwGG6Nc5NTKU288N2csOarkbl0pD0ruQ39dpozQaV6ojKbr
         SoyBthYq4tlUZigKQY8rRfuFKivi8cUQLdiuPxBN/9NS8+I1xvsIDi/ysjQWu24Qg6jt
         y5DCZpiUnEvMWHP/Aa5n5lQZw5w4xLAhWDFJkSBb7QuDaMbhie1JgbD/bH/b9XKmvs4g
         mtA9ERZrFwca918p8OrpMOA40JANfa0Pty1MKJX0jrl0qG91AKpb6mo5u/p1ICxhLYFr
         ax7j8b5wmByy/bjjDwEci+OugXb1Au4z0Sq3ehF95prXOMQKN4ZIfTaRpk5Pj0QUOPf7
         eBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFb4si21ffSYYK/qJ1bR5Dkl24vvEDw+ifpOVVdfTyQ=;
        b=LD94BInODNT3PQOnAwbBI+S4+ZUlZWoj4O8Vrx/oEdzOOT9n9NFRr6IJi1UOtS0LAj
         eo0RYkg/3ts/QnhRcQk8WuLJ9hbV/1X1QHHanrEiyddFt5Bc0Vwe/o/KLTxvAZiwq00S
         qxTadfUk3vKMJ63v0GXZjWRc/IWiZn+pvnKH33yZAIUpt25JK/utGgyPNUrTRLT4E0ob
         CSmp0Dkl0/mI/8uGyPEgrDsnG+8GgkfDi9267rq5u2MtgapmLcMVFoFtTXJ/5Z6pZxgc
         iNR+UrnoCrRVtps98PeHM9lUxIaLUASgyPHK+uFT5N3xvVhOzQgbb4rf/IHQZEAr1yR+
         ScMw==
X-Gm-Message-State: ANoB5pktAkWWgTbkS30caunCTfEC4vKcoTc0j/v6DWrR0VKZXVRvSVU5
        2QDPwAvWhF0akDis5/1lqENs4A==
X-Google-Smtp-Source: AA0mqf7wdOCyHACo/mpe6aHJ2ST++Y5pO734AbnfgA6NFU2Ha624Xxu6c9AvAKoxmZCUybr4/afozQ==
X-Received: by 2002:ac2:4c49:0:b0:4a9:f2e3:3cfa with SMTP id o9-20020ac24c49000000b004a9f2e33cfamr3304944lfk.32.1670673429236;
        Sat, 10 Dec 2022 03:57:09 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u20-20020a2eb814000000b002778d482800sm578343ljo.59.2022.12.10.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:57:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sdm845: move DSI/QUP/QSPI opp tables out of SoC node
Date:   Sat, 10 Dec 2022 12:57:02 +0100
Message-Id: <20221210115704.97614-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
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

The SoC node is a simple-bus and its schema expect to have nodes only
with unit addresses:

  sdm850-lenovo-yoga-c630.dtb: soc@0: opp-table-qup: {'compatible': ['operating-points-v2'], 'phandle': [[60]], 'opp-50000000':
  ... 'required-opps': [[55]]}} should not be valid under {'type': 'object'}

Move to top-level OPP tables:
 - DSI and QUP which are shared between multiple nodes,
 - QSPI which cannot be placed in its node due to address/size cells.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 154 +++++++++++++--------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a63dbd12230f..573b2394e63f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -696,6 +696,83 @@ cpu4_opp32: opp-2803200000 {
 		};
 	};
 
+	dsi_opp_table: opp-table-dsi {
+		compatible = "operating-points-v2";
+
+		opp-19200000 {
+			opp-hz = /bits/ 64 <19200000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-180000000 {
+			opp-hz = /bits/ 64 <180000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-328580000 {
+			opp-hz = /bits/ 64 <328580000>;
+			required-opps = <&rpmhpd_opp_svs_l1>;
+		};
+
+		opp-358000000 {
+			opp-hz = /bits/ 64 <358000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
+	qspi_opp_table: opp-table-qspi {
+		compatible = "operating-points-v2";
+
+		opp-19200000 {
+			opp-hz = /bits/ 64 <19200000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-150000000 {
+			opp-hz = /bits/ 64 <150000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
+	qup_opp_table: opp-table-qup {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+
+		opp-128000000 {
+			opp-hz = /bits/ 64 <128000000>;
+			required-opps = <&rpmhpd_opp_nom>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -1125,30 +1202,6 @@ rng: rng@793000 {
 			clock-names = "core";
 		};
 
-		qup_opp_table: opp-table-qup {
-			compatible = "operating-points-v2";
-
-			opp-50000000 {
-				opp-hz = /bits/ 64 <50000000>;
-				required-opps = <&rpmhpd_opp_min_svs>;
-			};
-
-			opp-75000000 {
-				opp-hz = /bits/ 64 <75000000>;
-				required-opps = <&rpmhpd_opp_low_svs>;
-			};
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-				required-opps = <&rpmhpd_opp_svs>;
-			};
-
-			opp-128000000 {
-				opp-hz = /bits/ 64 <128000000>;
-				required-opps = <&rpmhpd_opp_nom>;
-			};
-		};
-
 		gpi_dma0: dma-controller@800000 {
 			#dma-cells = <3>;
 			compatible = "qcom,sdm845-gpi-dma";
@@ -3807,30 +3860,6 @@ opp-201500000 {
 			};
 		};
 
-		qspi_opp_table: opp-table-qspi {
-			compatible = "operating-points-v2";
-
-			opp-19200000 {
-				opp-hz = /bits/ 64 <19200000>;
-				required-opps = <&rpmhpd_opp_min_svs>;
-			};
-
-			opp-100000000 {
-				opp-hz = /bits/ 64 <100000000>;
-				required-opps = <&rpmhpd_opp_low_svs>;
-			};
-
-			opp-150000000 {
-				opp-hz = /bits/ 64 <150000000>;
-				required-opps = <&rpmhpd_opp_svs>;
-			};
-
-			opp-300000000 {
-				opp-hz = /bits/ 64 <300000000>;
-				required-opps = <&rpmhpd_opp_nom>;
-			};
-		};
-
 		qspi: spi@88df000 {
 			compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
 			reg = <0 0x088df000 0 0x600>;
@@ -4428,35 +4457,6 @@ clock_camcc: clock-controller@ad00000 {
 			clock-names = "bi_tcxo";
 		};
 
-		dsi_opp_table: opp-table-dsi {
-			compatible = "operating-points-v2";
-
-			opp-19200000 {
-				opp-hz = /bits/ 64 <19200000>;
-				required-opps = <&rpmhpd_opp_min_svs>;
-			};
-
-			opp-180000000 {
-				opp-hz = /bits/ 64 <180000000>;
-				required-opps = <&rpmhpd_opp_low_svs>;
-			};
-
-			opp-275000000 {
-				opp-hz = /bits/ 64 <275000000>;
-				required-opps = <&rpmhpd_opp_svs>;
-			};
-
-			opp-328580000 {
-				opp-hz = /bits/ 64 <328580000>;
-				required-opps = <&rpmhpd_opp_svs_l1>;
-			};
-
-			opp-358000000 {
-				opp-hz = /bits/ 64 <358000000>;
-				required-opps = <&rpmhpd_opp_nom>;
-			};
-		};
-
 		mdss: mdss@ae00000 {
 			compatible = "qcom,sdm845-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.34.1

