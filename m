Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06EB6CAF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC0T4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjC0T4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:56:12 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976A30C6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:56:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l9so5235654iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679946970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP/VsmA4BckPjvamc/Cc2ascVR6mBrF8rg+wdmACWrI=;
        b=NPNz3TVGkvaO256UAKbq4AubVwD+LlOkMzWl/F3X1abnmdB7IWo0A3SAGTy/00pgTy
         cMTBmDkYS14dxTWMFY2M0esWPSjbT9R7ab8eQSyHKmE8vDwTTGm99/8BLok8VPFE/y4o
         SXB7+cxAOpscjb6W6+h7ozPEb01UfKx9veJIbeOa357LtTn1P/yO2Lc3XjvEgypoeyaT
         adiev2b3zMuPuNkvAIEnsygXPD8ZkCLxgYnrskSt2GJacyI85hETwPEbX4HdfDuTtsxz
         /r/pywZVaJBBmor6Xbu2qIu7Yz4uVdQV7M0qSEXXh8jSTbXIOEjJVoV/72VoOraH0Gu0
         UBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP/VsmA4BckPjvamc/Cc2ascVR6mBrF8rg+wdmACWrI=;
        b=7qUToU3B9LRAJ/Qn94Pjbez7izPVbVSxBqmMjy5z/M+LhTkHvn6qPdvdO67RN/I4V/
         3tUvfG/feGrx63u2VeT2RnsS3WSajFsTc4XW8o54zXVzwxvmH2lE14YAfv3/l2Xp0q4p
         EQQcajYHV5SkE6STgmCAmUBgdhFDd0ceVE/8dt0aPin70HOml/fRXHBwgdMvF7lTE1to
         6mO7ZB6WiAwZdqeNDbHPCBNMvs/VIradrGumWxQqX4uBIr/pCkSZtgB6jD3TmRaZidgW
         hUNKLUDNGXJ8G66yToXdwS8+fTwkCq+UPKe7ku50o0ubO2wNd6zL+UAF1on6pVPw7Yzn
         MM9g==
X-Gm-Message-State: AAQBX9ewRYGT4oCr8q9f2RkV6Ab8Lhr8QrvS4NbKOgZkqGcMx1AaZxTL
        pRe/Dv5S0qAuMuFvzE3xRvPnGg==
X-Google-Smtp-Source: AKy350YwcQ7Kuco3hoH7bmd+Ta4BhXfbhheCtvvYo8i2ejIhv5KSKJPA9zIS1Xnel98M0jk2sa3Atw==
X-Received: by 2002:a92:dc91:0:b0:325:c8ee:96e2 with SMTP id c17-20020a92dc91000000b00325c8ee96e2mr9606416iln.7.1679946970638;
        Mon, 27 Mar 2023 12:56:10 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a18-20020a027a12000000b003e69be53404sm9011984jac.150.2023.03.27.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:56:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/2] ARM: dts: qcom: sdx65: add IPA information
Date:   Mon, 27 Mar 2023 14:56:04 -0500
Message-Id: <20230327195605.2854123-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327195605.2854123-1-elder@linaro.org>
References: <20230327195605.2854123-1-elder@linaro.org>
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

Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.

Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
Zone on this platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
v3: - Use ipa@3f40000 rather than ipa@3e04000 for the IPA node.
v2: - Fixed an alignment issue noticed by Krzysztof.
    - Moved the "iommus" property as suggested by Konrad.

 arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 39 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index ed98c83c141fc..72e25de0db5fc 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -245,6 +245,11 @@ &blsp1_uart3 {
 	status = "okay";
 };
 
+&ipa {
+	qcom,gsi-loader = "skip";
+	status = "okay";
+};
+
 &qpic_bam {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 192f9f94bc8b4..74671cc12c884 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/interconnect/qcom,sdx65.h>
 
 / {
 	#address-cells = <1>;
@@ -299,6 +300,44 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		ipa: ipa@3f40000 {
+			compatible = "qcom,sdx65-ipa";
+
+			reg = <0x03f40000 0x10000>,
+			      <0x03f50000 0x5000>,
+			      <0x03e04000 0xfc000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			iommus = <&apps_smmu 0x5e0 0x0>,
+				 <&apps_smmu 0x5e2 0x0>;
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&system_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
+					<&mem_noc MASTER_APPSS_PROC &system_noc SLAVE_IPA_CFG>;
+			interconnect-names = "memory",
+					     "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			status = "disabled";
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.34.1

