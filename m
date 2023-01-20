Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E4675B29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjATRXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjATRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:22:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FB4ABC4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:22:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id tz11so15802386ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0ezJCiejYKH3mHjjOi3D4bAnLIutlLPwGAfzv+fbpQ=;
        b=g13LZ40zbQtq1kR0e2MKIJwJyHXgoa0hMLRRDRQw91OP3YOoSOmR6a7eALnD8Z1tQE
         ipyaeJaBmjP83JhEziARP4SVSnWtggAatHwHH/3rLqJ9cYWsvedUqo7PE91bdwhF6ihY
         MDO9S3thXGpajBtKNJMdBnoy0LZ9UDJ2SX2KByUnFMWoMyxbvfNfn7fRUk6CI3pO7ZY5
         jyFAkHzbYseDhAEcRu/qL4IwufIoM3Y6CpqTtkz8joRVMwLwhjsbJoGPBV9AxHi5cj8f
         uZcznvRe45QG6nE9Yn5HfZ824BZtPRXb/ivebY+pdQRrYnE2739AekENceva2VA1bM97
         nsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0ezJCiejYKH3mHjjOi3D4bAnLIutlLPwGAfzv+fbpQ=;
        b=YB/LT3afwRd3cY5ak4vPYslTKVxoY7t2S6ssvCQkhjrPIBmLlkQHweNmgpEr4I0iTK
         cERxvojYYlG5FTh1d8XzsCSaBjehXqq/qrmrsaEZO9hebHxyfuuLaIRVOxENSFzfURdW
         iBctXre8GElaheOz4esOuHWVJLl1GlLNbzIBWCtqvNn8xbPaNAJikatd5Aftd/XTZpAs
         CXDyql0GUdiR/ib5beqGaFhn2ZLLRuIfk6SyuvPi6/tbthzqbV3nZBL45Wi1D92RnDkv
         gz1UtNnFCvq7q6cfX2jHyfKbgmx3Y1L1sxGNJHrHxbTSR78pHln3EqpGy/O44IcI2M8c
         taoA==
X-Gm-Message-State: AFqh2kp+pn/VZYDXZaDTvugpB80DBurSvmozSlJSsuGM8COzxaTypte4
        COFg8uGKXRAzgnNS3iAskDI7vA==
X-Google-Smtp-Source: AMrXdXtx8X/yBlmU7Fn46+gnHPnWsfBg6M83EWkjsFYdNYROQddqutpTfrlJF4gWuidhWPJdJCqhKQ==
X-Received: by 2002:a17:906:29d8:b0:86f:a1fe:237a with SMTP id y24-20020a17090629d800b0086fa1fe237amr16070806eje.54.1674235368997;
        Fri, 20 Jan 2023 09:22:48 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm18313857ejf.179.2023.01.20.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:22:48 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm8250: Add GPU speedbin support
Date:   Fri, 20 Jan 2023 18:22:33 +0100
Message-Id: <20230120172233.1905761-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
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

SM8250 has (at least) four GPU speed bins. With the support added on the
driver side, wire up bin detection in the DTS to restrict lower-quality
SKUs from running at frequencies they were not validated at.

Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 II (speed bin 0x7)
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 059c83003fb6..95f1a6afcd43 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -981,6 +981,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sm8250-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@19b {
+				reg = <0x19b 0x1>;
+				bits = <5 3>;
+			};
+		};
+
 		rng: rng@793000 {
 			compatible = "qcom,prng-ee";
 			reg = <0 0x00793000 0 0x1000>;
@@ -2576,49 +2588,58 @@ gpu: gpu@3d00000 {
 
 			qcom,gmu = <&gmu>;
 
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
 			status = "disabled";
 
 			zap-shader {
 				memory-region = <&gpu_mem>;
 			};
 
-			/* note: downstream checks gpu binning for 670 Mhz */
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-670000000 {
 					opp-hz = /bits/ 64 <670000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-supported-hw = <0x6>;
 				};
 
 				opp-587000000 {
 					opp-hz = /bits/ 64 <587000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-525000000 {
 					opp-hz = /bits/ 64 <525000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-supported-hw = <0xf>;
 				};
 
 				opp-490000000 {
 					opp-hz = /bits/ 64 <490000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw = <0xf>;
 				};
 
 				opp-441600000 {
 					opp-hz = /bits/ 64 <441600000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-supported-hw = <0xf>;
 				};
 
 				opp-400000000 {
 					opp-hz = /bits/ 64 <400000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw = <0xf>;
 				};
 
 				opp-305000000 {
 					opp-hz = /bits/ 64 <305000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0xf>;
 				};
 			};
 		};
-- 
2.39.1

