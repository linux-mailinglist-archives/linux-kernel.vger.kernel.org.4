Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D165DCF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjADTi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbjADTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:38:04 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9060DF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:38:03 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e129so10004068iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udCwkO8StA61yER1zDj2O8kMSYGesvjzVzZN5NG0PbI=;
        b=Qtz6OjE0+Ue98DAChw8egdd+LgPk2N3iw9NFXaVAfc1AKrLBrMPDdMFiVHR6zjsSph
         rLj7lbvLo3xuOL+M/LI5YZrR3EVt9zg2FAjexYMQoY9qvWzpAPNBy1Kzl4RtGI5UEEYa
         7EchOJSBZSZSVGqmLUDNiCvh0Xq8uxnMur20GI7ju2cSQqXnlSI0Ib17YWdT2AhIDecl
         AfXvPP72rrGmzhlZcJqp7R+oO8ZGx2b2F9Da/HxIJ5mvXlAIRyOHvZtlrMvs6ern/Cck
         iGas00OgdicHcnlGu+FXItyhiaKVWSZqTwBtQ0innThXvUdhkwFfyzay4gI1SUOfYYVm
         m2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udCwkO8StA61yER1zDj2O8kMSYGesvjzVzZN5NG0PbI=;
        b=Gnt85xykZl53aGSPIyg3Exj0C+Uyo8b5RyOk57Vf715HvdFVOLJ4Wx6MhQ+dfpEoTP
         K8AOP/SdPt43OanWBw+U7C77fA8bPUm0jnUeF60UWIkffaKk8L7fAvShGfsnqtGSURlM
         DKnoqyVPK/86/8C8xPHAQkGSXMLF6hpY9MBDYjRWqdesZxLJU/xYLq2jUcwsVAUtSIUt
         nPeoKXVixZSQM5QajYAHTr2R1k0u/v08gRSzWQhNsmm743wrlDfgZ1ZYzZ7uyhG+dLrF
         FqhdkPQHEjSMhyo6nbDxNOkqosUD97Fhhsc/Ls9J/YqtTlhmzLhDArVzvDs/TsoOB4gA
         m8lg==
X-Gm-Message-State: AFqh2krDpgkFmLiljPYQzqTaGt3kQD9Lq+QFIabKZIC3t9xYdlq1PNT+
        YtzZwfGkpDVBQgQxVnOQ2DIBmA==
X-Google-Smtp-Source: AMrXdXuKTGMY3y5HrmbYYjnupxuth1oTWPBDo+6OX37UewAqZ4UKmqwlt7rxER0Bwkd60oQ+8aFu9g==
X-Received: by 2002:a6b:b4d1:0:b0:6ed:308f:f807 with SMTP id d200-20020a6bb4d1000000b006ed308ff807mr35432843iof.21.1672861082915;
        Wed, 04 Jan 2023 11:38:02 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id h13-20020a056602130d00b006cab79c4214sm6972498iov.46.2023.01.04.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:38:02 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Luca Weiss <luca.weiss@fairphone.com>, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm6350: add IPA node
Date:   Wed,  4 Jan 2023 13:37:58 -0600
Message-Id: <20230104193759.3286014-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104193759.3286014-1-elder@linaro.org>
References: <20230104193759.3286014-1-elder@linaro.org>
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

From: Luca Weiss <luca.weiss@fairphone.com>

IPA is used for mobile data. Add a node describing it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43324bf291c30..f622d870bc827 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -432,7 +432,17 @@ modem_smp2p_out: master-kernel {
 
 		modem_smp2p_in: slave-kernel {
 			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
@@ -847,6 +857,43 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		ipa: ipa@1e40000 {
+			compatible = "qcom,sm6350-ipa";
+
+			iommus = <&apps_smmu 0x440 0x0>,
+				 <&apps_smmu 0x442 0x0>;
+			reg = <0 0x01e40000 0 0x8000>,
+			      <0 0x01e50000 0 0x3000>,
+			      <0 0x01e04000 0 0x23000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&aggre2_noc MASTER_IPA 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_OCIMEM 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_IPA_CFG 0>;
+			interconnect-names = "memory", "imem", "config";
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
-- 
2.34.1

