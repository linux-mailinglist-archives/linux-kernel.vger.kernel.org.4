Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436D6CAE61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjC0TPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC0TPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:15:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC911988
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o14so4349451ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679944547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t963gctnE04mv7BG+3mCC4eaSqmmJmoi+AUYlyxi07Y=;
        b=GBeKDtuxwsUe9l05JQqubfcmANezRkK96IcnNy670u7OvuwL+d/Ij9EKVdoHp0Ou4r
         uKMH1DlOxNSUg+me2PIk0Wjyle9NSuoz/nLtC2p/Xwu57wyQzF5j1sWcbM/ZWSIhsYgt
         zlLwCOYEphyjA2VFIvWpgF1g/lpdbIPD0eXeQTnrBQZsvG1wTs/EmBGgDqk7yrNlrqsC
         iPLRR8I/SQHFUytK++WUIC3XuugoNLqhKxm7wf+UeN5vzIvX7wawQd161D6GoFJgtp+M
         eKV7wYmEibw+UgTAWoZZpiyOliCagZyG6Xrxxs5lu+kiAcfXCsJnp+NQ4riTrXdkQ8ST
         ydOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t963gctnE04mv7BG+3mCC4eaSqmmJmoi+AUYlyxi07Y=;
        b=OUpK20ATNyTePBNchT1QHryzFEvYzuubNQj/fgm1Tlt5LXbiZQRQH6/4+Gzfi7pWFZ
         Ac7rEXGgebbP6RxoH774m3dCFwmz9yVCDJ00rYcgTDB7khrPEtXOt9XHxpEFOTc7VkGR
         0VZGljc47JBLn/LJP8Ng/jeuGg9g0YKmU8QPLirwpFQftB+37WDLZx9SZ5RPrb/8VfFB
         aW1zxBTey4kqUBNN9+xJZfteGr1/VauLbNtM9sjte0bXqb3uYT3OpDtZiiSXtFkmjnuz
         +wGb2DllbWX0YJI7KUvbrGYllJiySAXOeQsDhhvRKOnwUCuwzAaZdQnmBNxUtUHt0yer
         +HKA==
X-Gm-Message-State: AO0yUKXI7tgzUFTZ6/nkxbMTws3SSgYVW9FvlNvmqdPXrHMBzm8+Cl7Y
        soplLwLtoj3cEopv9MuDwZt69A==
X-Google-Smtp-Source: AK7set91sz5GQAVOrxdol27D17aTuRolszXy5yVRTXBTP/F6Oo+BQVGwXSxII4/wd7W623WveRS5PA==
X-Received: by 2002:a6b:650f:0:b0:758:6728:7023 with SMTP id z15-20020a6b650f000000b0075867287023mr9245400iob.21.1679944546783;
        Mon, 27 Mar 2023 12:15:46 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n13-20020a5e8c0d000000b0074555814e73sm3460548ioj.32.2023.03.27.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:15:46 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/2] ARM: dts: qcom: sdx65: add IPA information
Date:   Mon, 27 Mar 2023 14:15:41 -0500
Message-Id: <20230327191542.2765834-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327191542.2765834-1-elder@linaro.org>
References: <20230327191542.2765834-1-elder@linaro.org>
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
index 192f9f94bc8b4..f35061e5b7fb8 100644
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
 
+		ipa: ipa@3e04000 {
+			compatible = "qcom,sdx65-ipa";
+
+			reg = <0x3f40000 0x10000>,
+			      <0x3f50000 0x5000>,
+			      <0x3e04000 0xfc000>;
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

