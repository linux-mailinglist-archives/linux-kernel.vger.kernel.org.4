Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975176C9356
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCZJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCZJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:16:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5693CE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:16:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so24256245edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679822168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVdcLdPzcznfLu5pV3m1WzbNiFmKRhHrUVaPMwriaSA=;
        b=zobcUBWPrSp/4y+k/WK+lZBW+LnOtpPGzz007TUEr69BtXLN8ouhoLpQSFmm0NEZp2
         prpyGUwygdKax2iOjdm/M3CicbZ3oiSHDgh2M/8I601mxLM6cB7Uo8JB494tpEGKs/Nl
         9vIP9uXcvrH8crfzLvt5W0trcvzOkvp6IIJl1qMw2tW6BXGU95zpjXezuGfJk/tGGSNX
         eGBG0CzYApzkloxW0mRqeQ8vNpo70VXeGwIt2cy4sDpzRDU0u8hq2T07yuAhmNU0JoXE
         6DPUE98k3OpMzOv+o83wgndCT3+XUqSvdvHWqnWe+mtTE2V1Cc37K2iszpVwzgTS+uw7
         CZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVdcLdPzcznfLu5pV3m1WzbNiFmKRhHrUVaPMwriaSA=;
        b=6UWP6d30yLP4NVP418pm+UI0qVXPJlUXjEexQ34MI66W+Rz2lqUwj1q+QHTwu6JpL5
         tkWLNBATditpCEV9cmVtPCqQ8bF/FNOO0a14TnxsFA8DxNFiGGK3KgKGQmipjyk2SNsr
         VSnHwnZmfJLmuc8jAwruoiVbb36RblY9xVA8K3XRnP9XsdOaCPsosLpe+oPu/wzdwm8I
         QW2SpLFQm2YPAz5+hJp7aB8dzDc42GoYw49elNsXbUSSnwdMM9i0Hv2BJuWfs71dSDEw
         jIDrqb3xM47W7lH4Q6RkBL5VLuA++B1j2p9bbVBlNfGbP+NJ6NFDaWEhm9xkIK4fk4qi
         +itA==
X-Gm-Message-State: AO0yUKV+4qc4yRmh7PPncJoPlgjv/dKX06tlXZBGOPN5Is/DGd1u9yXg
        LMJI6g9ZEhGXLg24nn5VeHJEog==
X-Google-Smtp-Source: AK7set+21ZfoJE99Nq9jkZpPELlJ6LrY+qn8O3F+7udZkpqYQMkG59FrMIxIMxGZivvwWOl0kN1TrQ==
X-Received: by 2002:a05:6402:c17:b0:4ac:d90e:92b with SMTP id co23-20020a0564020c1700b004acd90e092bmr16023867edb.10.1679822168485;
        Sun, 26 Mar 2023 02:16:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b004fa268da13esm13409297edi.56.2023.03.26.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:16:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of soc node
Date:   Sun, 26 Mar 2023 11:16:05 +0200
Message-Id: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soc node is supposed to have only device nodes with MMIO addresses,
so move the DSI OPP out of it (it is used also by second DSI1 on
SDM660):

  sda660-inforce-ifc6560.dtb: soc: opp-table-dsi: {'compatible': ['operating-points-v2'], ... should not be valid under {'type': 'object'}
    From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Move the node out of soc. Don't add Konrad's review tag.
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 72d9a12b5e9c..b91e423a3cfc 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -328,6 +328,25 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	dsi_opp_table: opp-table-dsi {
+		compatible = "operating-points-v2";
+
+		opp-131250000 {
+			opp-hz = /bits/ 64 <131250000>;
+			required-opps = <&rpmpd_opp_svs>;
+		};
+
+		opp-210000000 {
+			opp-hz = /bits/ 64 <210000000>;
+			required-opps = <&rpmpd_opp_svs_plus>;
+		};
+
+		opp-262500000 {
+			opp-hz = /bits/ 64 <262500000>;
+			required-opps = <&rpmpd_opp_nom>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -1450,25 +1469,6 @@ mmcc: clock-controller@c8c0000 {
 					<0>;
 		};
 
-		dsi_opp_table: opp-table-dsi {
-			compatible = "operating-points-v2";
-
-			opp-131250000 {
-				opp-hz = /bits/ 64 <131250000>;
-				required-opps = <&rpmpd_opp_svs>;
-			};
-
-			opp-210000000 {
-				opp-hz = /bits/ 64 <210000000>;
-				required-opps = <&rpmpd_opp_svs_plus>;
-			};
-
-			opp-262500000 {
-				opp-hz = /bits/ 64 <262500000>;
-				required-opps = <&rpmpd_opp_nom>;
-			};
-		};
-
 		mdss: display-subsystem@c900000 {
 			compatible = "qcom,mdss";
 			reg = <0x0c900000 0x1000>,
-- 
2.34.1

