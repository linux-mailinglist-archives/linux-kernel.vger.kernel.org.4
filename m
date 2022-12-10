Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1235648E88
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLJL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLJL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:57:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446110B45
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:09 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so11048887lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXM/ZzQf3i83h9TWbUQNWzaHxNpC3fWU4P5IeO/SlrM=;
        b=pi/xxaQJP3Gab0CcC8mIr8CIVqw5IgnkcLFWRo8KmH9qXJg6yESHyINGyzUKjb5fmF
         0D89U8j6bo5hy1JIHnKczyEfHvL6STsIutwDlm+sLu5EPZqu1N3ALILNjj5POrY4p8Lt
         JXjU3Wp8BPvcAmXJ/rrLMBcK54xQoI202IXBhUeqj5haVaTHqRxsFxO0ZV3y6TrbgiZs
         cfkwd4hV7pP95Abx2fRmYiWg4L79WvsJyLi0Ep3gOKHK2wR7SY9bfphqLyUMWGRwV9zM
         k0DeR6a0Soq5xI1HdXlvkwP2R/QmtvrKmpnC+lHwI6kHPan2qYFPaj4fON1/cRlAPSfS
         WbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXM/ZzQf3i83h9TWbUQNWzaHxNpC3fWU4P5IeO/SlrM=;
        b=TuUTjM7YyJDldld1OqmVgNeYXCmDpjaDWq7Yq+lecuhC2tB3DoqyoZg9jgbn994B7d
         vnmWYCngSweik6Wk3r5D2OisqrXrLH+rlieDyYO+wM/7HQDCCbmMMdQqXAU3+TfsF3xr
         mRuDiuBFBpv1zJ2t3ewhghEAu/KP2MkbkBHvgvHWJQ45c5XH05RQ1SxMWmPY8pLZDtK8
         rsajP1sqmW6lemxrGAkiGsEIQXRcb72zyoOcOUAJogKiZQ9OpiL1F4BP4koPhXD0wMFQ
         DiBe5aVTpkJca7ePP2R52qD71TRJWszeJFLuZuqD1gk1YsnKWNBuYgQAfoYERwaUP5hP
         cYlg==
X-Gm-Message-State: ANoB5pnivAIC0toh7RLTQI6zu1XSi+FA/c2iOosLYW13jxtA5NVigKKj
        2qGrRxGbd2lzw4lMqjXll4N6bg==
X-Google-Smtp-Source: AA0mqf5XaOq7OV4/HZSBVoFJvhrmxRR53GKZ/sazpnkP5JCsmbrdEjUcBJ7GAqW3DoEHSzIT7rPbfw==
X-Received: by 2002:a05:6512:3c99:b0:4b5:5f2e:3cc6 with SMTP id h25-20020a0565123c9900b004b55f2e3cc6mr4395279lfv.47.1670673427883;
        Sat, 10 Dec 2022 03:57:07 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u20-20020a2eb814000000b002778d482800sm578343ljo.59.2022.12.10.03.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:57:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp tables out of SoC node
Date:   Sat, 10 Dec 2022 12:57:01 +0100
Message-Id: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC node is a simple-bus and its schema expect to have nodes only
with unit addresses:

  sc7180-trogdor-lazor-r3.dtb: soc@0: opp-table-qspi: {'compatible': ['operating-points-v2'], 'phandle': [[186]], 'opp-75000000':
    ...  'required-opps': [[47]]}} should not be valid under {'type': 'object'}

Move to top-level OPP tables:
 - QUP which is shared between multiple nodes,
 - QSPI which cannot be placed in its node due to address/size cells.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 76 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ea886cf08b4d..735581097295 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -538,6 +538,44 @@ cpu6_opp16: opp-2553600000 {
 		};
 	};
 
+	qspi_opp_table: opp-table-qspi {
+		compatible = "operating-points-v2";
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
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
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -739,25 +777,6 @@ opp-384000000 {
 			};
 		};
 
-		qup_opp_table: opp-table-qup {
-			compatible = "operating-points-v2";
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
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x008c0000 0 0x6000>;
@@ -2655,25 +2674,6 @@ opp-202000000 {
 			};
 		};
 
-		qspi_opp_table: opp-table-qspi {
-			compatible = "operating-points-v2";
-
-			opp-75000000 {
-				opp-hz = /bits/ 64 <75000000>;
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
 		qspi: spi@88dc000 {
 			compatible = "qcom,sc7180-qspi", "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x600>;
-- 
2.34.1

