Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1095F1944
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiJADKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiJADHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392615FC71;
        Fri, 30 Sep 2022 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593635; x=1696129635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQgRHlGF52JMt3yqBBmYEQyjjKnhvWp1CTJBgGLGTYI=;
  b=cv4U77yRG0Bhe3ZMnwxZkJ2kpk6XK5S0YLBk65p/1JIyKHLaEkD+RMPF
   8yvf1smfCJprpZAcun0wfpjxnj90pigIQNAiVO96qEsWjOYF0nlf+dY9K
   GKINCV2fU5Xv+DXhq15g12CS9CCnno88Zv3FdOUeIbIWC58aPxzpxEO4b
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2022 20:07:14 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:14 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:13 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 06/19] arm64: dts: qcom: qdru1000: Add smmu nodes
Date:   Fri, 30 Sep 2022 20:06:43 -0700
Message-ID: <20221001030656.29365-7-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smmu nodes for the QDU1000 and QRU1000 SoCs.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
index 39b9a00d3ad8..8c2af08b8329 100644
--- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -396,5 +396,62 @@ arch_timer: timer {
 				     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 			clock-frequency = <19200000>;
 		};
+
+		apps_smmu: apps-smmu@15000000 {
+			compatible = "qcom,qdu1000-smmu-500", "qcom,qru1000-smmu-500",
+				"arm,mmu-500";
+			reg = <0x0 0x15000000 0x0 0x100000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.37.3

