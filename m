Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A264AC67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiLMAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiLMAYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:24:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F371B1F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g7so2319355lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=484kpt6M8crrqJsBdPMWKiVNmZINIXNPAP5xDyx65J0=;
        b=uxJbmngwkiYc3dtFUkEW23+umw0pts3sm6vJ0n0PSjKBED/dw9scYOmk57vtu4kbjB
         vqzArufPxfZoFt90xxtLiHt8qZtOVOP/GPF3q6KAIkcrUt3m/nSpCuYwecrJanAJ/jXm
         UICVoec0f3kRplcK+y8+lETzpjBvYH765CyHJ9YecDHMr7DYQgeHBH6KeHDL0XMqpn6f
         q7/lA1y5HN2h+ndoznydxLeqKkPOlt551S3zBjpayxU5VDWq16lH+qZ8spLGcg5zO0S7
         oiYNB9YARY5jeoP7Sx/lat6WAz5UejW2QNxz3WFn3krpNu+GakAYfm2Ty4QtcFXXN6+c
         f3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=484kpt6M8crrqJsBdPMWKiVNmZINIXNPAP5xDyx65J0=;
        b=hWfl+qdmmnZqpjSw5VDpxuUFWMyU/LVK5sEIbMRrjK0Dy8XzpZYruFj82Ph8OPkjUt
         cv2sCAYblOfOoEUR2fzXKSrP97+iLSBwRtcsJYIvDUfEHD490HC6UlipfVhPvprxa1aZ
         SH3bSdvkKd+S2L/z8LESykc+a2/+HzlZ+0RnWKQIC4ilti2mJOJHomq97btSKtW+Agf2
         vVTCBs1wEGlBwaOFWXtwTFbMtk5U/jHABTfqr5MjAx7UFgqYt8SCK/X4rXWtBPfrjW73
         FJLnNdf0I0RNzzHamrDtQLxhItY+hU8nR67zrMDoWBtv+Gk1xgsN06wS9uZJL4fT/ZMZ
         mlDg==
X-Gm-Message-State: ANoB5pmA8KQYf9uUO+kBGlV2017/j2SPQ6AyOmBjFUtxHMHJm+Vu/H8j
        c0Gyi0WCiPZE4bcJRrYmjKfk6w==
X-Google-Smtp-Source: AA0mqf7POXDdTzNkuyXTi10RQjyptGynl2zyz98smwto/7Y0eW9DfQ+VPVjAz+KyGie4fLw8Y0aZgA==
X-Received: by 2002:a05:6512:c1e:b0:4b6:e726:45b9 with SMTP id z30-20020a0565120c1e00b004b6e72645b9mr2431702lfu.37.1670891078435;
        Mon, 12 Dec 2022 16:24:38 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24257000000b004978e51b691sm137352lfl.266.2022.12.12.16.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:24:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: sm8150: Add GPU speedbin support
Date:   Tue, 13 Dec 2022 01:24:22 +0100
Message-Id: <20221213002423.259039-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213002423.259039-1-konrad.dybcio@linaro.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
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

SM8150 has (at least) two GPU speed bins. With the support added on the
driver side, wire up bin detection in the DTS to restrict lower-quality
SKUs from running at frequencies they were not validated at.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index e160acb47cd9..3f940cc3f32b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -936,6 +936,17 @@ ethernet: ethernet@20000 {
 			status = "disabled";
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sm8150-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
+			};
+		};
 
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
@@ -2137,6 +2148,9 @@ gpu: gpu@2c00000 {
 
 			qcom,gmu = <&gmu>;
 
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2150,31 +2164,37 @@ gpu_opp_table: opp-table {
 				opp-675000000 {
 					opp-hz = /bits/ 64 <675000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-supported-hw = <0x2>;
 				};
 
 				opp-585000000 {
 					opp-hz = /bits/ 64 <585000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-499200000 {
 					opp-hz = /bits/ 64 <499200000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-427000000 {
 					opp-hz = /bits/ 64 <427000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-345000000 {
 					opp-hz = /bits/ 64 <345000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-257000000 {
 					opp-hz = /bits/ 64 <257000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 			};
 		};
-- 
2.39.0

