Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7989A642D43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiLEQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiLEQjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCAB14000
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:38:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m19so16541654edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdoZ3Re0757L2mwn1KYvl/6yc6DEIjLF3AShLHyNWWM=;
        b=JMKm0kKI+noLyReu0/ATNV8+wCuvNS7JEXXZjPRL1OtYRGio4ViGJUflWj7brVgXas
         hHkilrRB8y+qxQUqknlsPwjsVvkLy+tBUiEA6qBRKVaAS9poy8CR/yCUkVC9vrA5quks
         9g8uu6qPxj+J5aokqc31cjTXxXvw9zAMzoajM8F7Tn61q8Xc4WuqzPy2dDvNLUVpu0uB
         XKjp0aBeypxdLgtp9c3OCAxcMjsB1AdIilVFaCSB4AgqgU5Jx9wbnYWKoAeEGigfD8WU
         Z8JrPjAHGx8MUNqKT2BsqWJ4L5rOC5FLsd4MkwiveXOp1ONLKg7djDPU2safEJzmiWLo
         hqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdoZ3Re0757L2mwn1KYvl/6yc6DEIjLF3AShLHyNWWM=;
        b=KR6jN1nucECQYVPFGK/whs8dVhqsRACVgzfKxIxRwI0LEWA0SGjSuNXIr5dOvfNpgq
         Uq+Zbv4fN9MWA2o1holc5OgaelJNGD4HsX+oYVGb0YUmoulxu0TTuYD+cXFMsLBl2GIV
         92kWCqG/JYiJxUZa0XmibySFV0jy52kwlK5I9zNF80laMyaFOSBNvZuOEDPbZ/wfqXPW
         HvxxxDfxtE0b44qQEa4YafGTDZFo2lJUTbRBAV1qKVVhiMaANN6+tHucHH5Ktuh0+xg1
         MR6qPJnM70l4s8hMvg/3QrUwKx8v50schtGl26unIAKXk4P1BjuwF3IrDPK8ot9pLFhG
         q7GA==
X-Gm-Message-State: ANoB5pnqzp7wUQVBBt/J17wagk769AcssYWHbwbO2LcCk1hSEE7PLsnd
        OHdR2mVuqmA6cJmbqk2vpxPyMA==
X-Google-Smtp-Source: AA0mqf54xMct7ysrBdlruu+pyTFTsdOmHgBo3Vbycr9HMKr2aqqvpzU3+jbN410wfqAOZv8Wq/9jMA==
X-Received: by 2002:aa7:c585:0:b0:46b:635a:ed8f with SMTP id g5-20020aa7c585000000b0046b635aed8fmr27387734edq.406.1670258292371;
        Mon, 05 Dec 2022 08:38:12 -0800 (PST)
Received: from prec5560.localdomain (ip5f58f364.dynamic.kabel-deutschland.de. [95.88.243.100])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm6413610eje.18.2022.12.05.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:38:11 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, angelogioacchino.delregno@somainline.org,
        robert.foss@linaro.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 08/11] arm64: dts: qcom: sm8350: Use 2 interconnect cells
Date:   Mon,  5 Dec 2022 17:37:51 +0100
Message-Id: <20221205163754.221139-9-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205163754.221139-1-robert.foss@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
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

Use two interconnect cells in order to optionally
support a path tag.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 805d53d91952..434f8e8b12c1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1543,56 +1543,56 @@ apps_smmu: iommu@15000000 {
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sm8350-config-noc";
 			reg = <0 0x01500000 0 0xa580>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mc_virt: interconnect@1580000 {
 			compatible = "qcom,sm8350-mc-virt";
 			reg = <0 0x01580000 0 0x1000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		system_noc: interconnect@1680000 {
 			compatible = "qcom,sm8350-system-noc";
 			reg = <0 0x01680000 0 0x1c200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre1_noc: interconnect@16e0000 {
 			compatible = "qcom,sm8350-aggre1-noc";
 			reg = <0 0x016e0000 0 0x1f180>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		aggre2_noc: interconnect@1700000 {
 			compatible = "qcom,sm8350-aggre2-noc";
 			reg = <0 0x01700000 0 0x33000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		mmss_noc: interconnect@1740000 {
 			compatible = "qcom,sm8350-mmss-noc";
 			reg = <0 0x01740000 0 0x1f080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		lpass_ag_noc: interconnect@3c40000 {
 			compatible = "qcom,sm8350-lpass-ag-noc";
 			reg = <0 0x03c40000 0 0xf080>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		compute_noc: interconnect@a0c0000{
 			compatible = "qcom,sm8350-compute-noc";
 			reg = <0 0x0a0c0000 0 0xa180>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
@@ -1620,8 +1620,8 @@ ipa: ipa@1e40000 {
 			clocks = <&rpmhcc RPMH_IPA_CLK>;
 			clock-names = "core";
 
-			interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
-					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
 			interconnect-names = "memory",
 					     "config";
 
@@ -1661,7 +1661,7 @@ mpss: remoteproc@4080000 {
 					<&rpmhpd SM8350_MSS>;
 			power-domain-names = "cx", "mss";
 
-			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
+			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1 0>;
 
 			memory-region = <&pil_modem_mem>;
 
@@ -2239,7 +2239,7 @@ cdsp: remoteproc@98900000 {
 					<&rpmhpd SM8350_MXC>;
 			power-domain-names = "cx", "mxc";
 
-			interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
+			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
 
 			memory-region = <&pil_cdsp_mem>;
 
@@ -2421,14 +2421,14 @@ usb_2_ssphy: phy@88ebe00 {
 		dc_noc: interconnect@90c0000 {
 			compatible = "qcom,sm8350-dc-noc";
 			reg = <0 0x090c0000 0 0x4200>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
 		gem_noc: interconnect@9100000 {
 			compatible = "qcom,sm8350-gem-noc";
 			reg = <0 0x09100000 0 0xb4000>;
-			#interconnect-cells = <1>;
+			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
-- 
2.34.1

