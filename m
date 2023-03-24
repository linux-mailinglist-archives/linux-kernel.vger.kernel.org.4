Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEB6C869D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCXUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCXUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:16:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A911A48D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:16:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e13so1271907ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679688998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dtj5wCvvcI9i8AwEStAyJGT2y/5uBrj75y51U29C6g=;
        b=zAa/imWV2mUefmFRMa8BIaY3Ilfwyc5ol+wnOnFBakanyz5DG4C2cog0/S6CJ+g7ca
         WrfIcLzH3IDAtHNb5hV2ejvRuDY+cOrwZNWt73J0MoPFRJN2Qs6fnBPrNyOl2GrqlU4b
         /GTdUdsl+EuedoshYBC/z6RJx9ntKXkKxQ4wu/IuWJIHEPIF0u+YeiyZA/5s3w/JBaOm
         wVFP3guIqM3diM9DMmIgAJ6u9InW4Me3eXUmDc35UAtBSEdVpj8uanRKX5z+Lj//xVGD
         IvfQMRJG4OnXP3VOH+BYVcuDgxu9UITFFm38jBtudruMDcOyRLszbtXppZMPO0GZjY07
         WZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679688998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dtj5wCvvcI9i8AwEStAyJGT2y/5uBrj75y51U29C6g=;
        b=bgqODLaULotx0/rXDLgutc3l6/rNLN89l6SwMlt2LJsk6WjrxR5KIN4NHFexBZUSWa
         yasP0RTzVnVAsvbLOM+jMIBFgjWUe/lTXh/lu3R8Qn9friMp6lo2uPerrqMePNGPg0zo
         bHk80Sv1xXTWuFr3v6p5SKcZGnS22mEaNeU1kAe/GjGAkQ+GIvqDsjwfTihoQkVuOZgM
         zcIlfilcb/OZP9zX5iae/zOQdKkdmwI7vfBL1NdrrY+iCijZWlzOPWdJ3h9Hb7bJEihz
         3euAfmqCmSqRKdQkZkc1zt0qKN/tSBp0OSV2/QO8McH6RhwOJ2GxtL76CjmBXNj6E21U
         uJHA==
X-Gm-Message-State: AO0yUKXT3M5k5LbFpa/EiyPLCdBXvPckCU1NjeBQsfTCjWVeWaa2SExZ
        jsI66WN70d8DKQc41B5r84BN7Q==
X-Google-Smtp-Source: AK7set83AMpZtZI1S9jPlUv8qA1bflf98vG6Zpk80qJuh0rUnN3eZWUn+6ZWjrk9AAxtE6JljTpDTw==
X-Received: by 2002:a5e:c001:0:b0:752:8aee:6d91 with SMTP id u1-20020a5ec001000000b007528aee6d91mr3041688iol.12.1679688998477;
        Fri, 24 Mar 2023 13:16:38 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id q12-20020a05663810cc00b003e8a17d7b1fsm7173445jad.27.2023.03.24.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:16:25 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Date:   Fri, 24 Mar 2023 15:15:27 -0500
Message-Id: <20230324201528.2540564-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324201528.2540564-1-elder@linaro.org>
References: <20230324201528.2540564-1-elder@linaro.org>
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

Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
 arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

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
index 192f9f94bc8b4..360d6dc144811 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/interconnect/qcom,sdx65.h>
 
 / {
 	#address-cells = <1>;
@@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		ipa: ipa@3e04000 {
+			compatible = "qcom,sdx65-ipa";
+
+			iommus = <&apps_smmu 0x5e0 0x0>,
+				 <&apps_smmu 0x5e2 0x0>;
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
+					   "gsi",
+					   "ipa-clock-query",
+					   "ipa-setup-ready";
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

