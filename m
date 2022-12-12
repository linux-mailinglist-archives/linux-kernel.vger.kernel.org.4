Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03862649D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiLLLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiLLLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247AB11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so17957503lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wss/TO72szNDMaYxDBXvoiPTSx4um7YH2CrXI+/i5D8=;
        b=feEfWRHOO1wk9n2kIVNoSOFxBEbaskPhucSjz2VVFLIPmBMt4i4UXGlp1AdCvR1p4J
         NyqPmNqQFBMqlIq0v1q3yzoGNcV0165zckRKwKvOQnNZeZTIhl6P8ERf8i58+e5klG25
         v8N0/4cA+x2ILUYZczhtoU2a8/fVxRBj3LLkXn5R7uVR0C9vUALQzkkddukQygCi9a9y
         QBmmaRgQtsXK3jJHW8LxIjUFNZm/F4Ui4+S6vZQlhDAmHCd/o2FWInAGI6Q6njummTBF
         ym+CHrF3shHnZIq65hNt3baTEq6BHV2ThuJd4nNgHyJ0/hOmZk+B/RQ4//YJVl0fAGmJ
         nvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wss/TO72szNDMaYxDBXvoiPTSx4um7YH2CrXI+/i5D8=;
        b=l3Rc2O22J6QBpgomOXBtLLKla3CcG2PQFd30aOgj3g13iG+TznY1F3SCTXUKKAAV7l
         NHRxwQI4CqHab8tDsdrSOfAQQaJh+PojAzCgePIrTknuBKh99amNcp9JWPKQem81rH0F
         uE+4Ug2U6zaxu5A7C2dr1DFIffxxUQvJxyTIihAhbub+fDTeLpBhnrVsxCLKeF5ENfgT
         6QO0sdTry8zJzxdg0NyoZTjvlE8khPVJvmmoQRWrtdiS+6brqYyFQc+sD2/eQ3Dsu70+
         jWGz4rGTbrb0KPzTDhQ50JwZ01pvlShaif8MhATnEV9H73UCS6e2tpDCq537kmLQe9S3
         qGPQ==
X-Gm-Message-State: ANoB5pkQS43mlX7nUUlUBgxw9jHjkQ38jZQdffoR3OioKhiWVoT0rkbk
        8nAM/aMwxnRhY8SB3RZ1U4mKaQ==
X-Google-Smtp-Source: AA0mqf7I0YPl3Ece8l3+P2iieRKkEyUi7RDXILwYsccOKykO8dPj/TRIvHyDuMgVmUpDCGQhK+I38g==
X-Received: by 2002:ac2:4bd5:0:b0:4b4:a460:c995 with SMTP id o21-20020ac24bd5000000b004b4a460c995mr6651795lfq.5.1670843450784;
        Mon, 12 Dec 2022 03:10:50 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b004b57a810e09sm1599110lfe.288.2022.12.12.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] arm64: dts: qcom: sdm630: Use lowercase hex
Date:   Mon, 12 Dec 2022 12:10:32 +0100
Message-Id: <20221212111037.98160-5-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212111037.98160-1-konrad.dybcio@linaro.org>
References: <20221212111037.98160-1-konrad.dybcio@linaro.org>
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

Use lowercase hex, as that's the preferred and overwhermingly present
style.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 13e6a4fbba27..c899ddd5a381 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -678,7 +678,7 @@ a2noc: interconnect@1704000 {
 
 		mnoc: interconnect@1745000 {
 			compatible = "qcom,sdm660-mnoc";
-			reg = <0x01745000 0xA010>;
+			reg = <0x01745000 0xa010>;
 			#interconnect-cells = <1>;
 			clock-names = "bus", "bus_a", "iface";
 			clocks = <&rpmcc RPM_SMD_MMSSNOC_AXI_CLK>,
@@ -1044,43 +1044,43 @@ opp-775000000 {
 					opp-hz = /bits/ 64 <775000000>;
 					opp-level = <RPM_SMD_LEVEL_TURBO>;
 					opp-peak-kBps = <5412000>;
-					opp-supported-hw = <0xA2>;
+					opp-supported-hw = <0xa2>;
 				};
 				opp-647000000 {
 					opp-hz = /bits/ 64 <647000000>;
 					opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
 					opp-peak-kBps = <4068000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 				opp-588000000 {
 					opp-hz = /bits/ 64 <588000000>;
 					opp-level = <RPM_SMD_LEVEL_NOM>;
 					opp-peak-kBps = <3072000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 				opp-465000000 {
 					opp-hz = /bits/ 64 <465000000>;
 					opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
 					opp-peak-kBps = <2724000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 				opp-370000000 {
 					opp-hz = /bits/ 64 <370000000>;
 					opp-level = <RPM_SMD_LEVEL_SVS>;
 					opp-peak-kBps = <2188000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 				opp-240000000 {
 					opp-hz = /bits/ 64 <240000000>;
 					opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
 					opp-peak-kBps = <1648000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 				opp-160000000 {
 					opp-hz = /bits/ 64 <160000000>;
 					opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
 					opp-peak-kBps = <1200000>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 			};
 		};
-- 
2.38.1

