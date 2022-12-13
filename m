Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555DE64AC69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiLMAZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiLMAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:24:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5E12AE5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:40 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so2289792lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NqADL9fRikgvphogBytlGfLHviEG2IYDDL43EsbLJM=;
        b=fxIG0R1YWutzDM2ebme2YUNsnVBPR9NhVIaIyS5WlfSb4y6x1FAZ/sq7GgpgwGIOCI
         u/7OD29+NCKkclW9EhgH/ygrjOeHaHiQ3fHqXCbQmnbyTWw4UgKog0zKd8R8FfIFLKeO
         NQ6WwxkPe6prynwNHD+GTA7HxB5gm/cuRFVgl0v4eoMh9kls3rRH6imiaOstAy6/+QY2
         ODSspyfa0Rs0Tcci7bjgC6Zieefm03DIfYPLNs7u0DeF/HiDGA/XfEdtMHMfq4Db6Ab5
         e5g4sK6C3j3rNM7/0BYJZeeDAyG8ctHpWgy1QwhqEaTn7Lrk/V9IV7z5pMccP9tmtt4T
         nrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NqADL9fRikgvphogBytlGfLHviEG2IYDDL43EsbLJM=;
        b=m25jm6IhSuwnr4tcyIDoF5IwbGn5liWNSVksLXh1CPTy3Og8jUgfW+2labqvVqyjsd
         YRplJ1YQKsV3g5ny0rHcJdix/olUWTJXAEMk4MSyqSufEaCb7Bv9PQJEuP/h4UKyYbfQ
         SUAc34U1FeM6jhmXhxwKOAeWbThA5muGUD87Q8yiy3V8w4T40LVlX9HfTOjJbL2AMGUj
         HbM6v41MwsXB5Z1DZ5QWnhT3VD4x0vVSYBA+60Y0Gdt5Zk/HY6jlQvUzlGvDcP0i6l0a
         2yQLrfBQGUKyWIlO3c34d78WbsJXsT0tDlZ6Hw6/Rx+1hNeBJOzSH9aJsgVYHfJfkutA
         0fEw==
X-Gm-Message-State: ANoB5pnTXB4nCLUJkuDoMrbjNG4lmCq1b/v78pJ35mmZGqXFHGH70KJ2
        TfmUQc6Yr7uCFS9JfXlrJ6LJ0XMrXILTCQT0
X-Google-Smtp-Source: AA0mqf7ztEvfed14f5GISkGdaXHFag5HjecBnWyEV2K7hdOGQx80J51qVunnDxiJBg94adYD058YeA==
X-Received: by 2002:a05:6512:b91:b0:4a4:68b8:c2e4 with SMTP id b17-20020a0565120b9100b004a468b8c2e4mr7478764lfv.59.1670891079853;
        Mon, 12 Dec 2022 16:24:39 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24257000000b004978e51b691sm137352lfl.266.2022.12.12.16.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:24:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: qcom: sm8250: Add GPU speedbin support
Date:   Tue, 13 Dec 2022 01:24:23 +0100
Message-Id: <20221213002423.259039-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213002423.259039-1-konrad.dybcio@linaro.org>
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c008f49b5852..0c4ecdab1244 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -955,6 +955,18 @@ ipcc: mailbox@408000 {
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
@@ -2563,49 +2575,58 @@ gpu: gpu@3d00000 {
 
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
2.39.0

