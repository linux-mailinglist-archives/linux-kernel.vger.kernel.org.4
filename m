Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3AF6CF2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjC2TRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjC2TRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:17:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1856A45
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e11so17260491lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680117457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i75VT9iHv+RQumVifxqdOqhI73icvNqP22fPvcEQdoU=;
        b=ubhALSethZ3f57tX9OLKfXZrI7UmEbjyqygzC9f/0RoaLeA0fadM8d/iX861w3RGtM
         6M2Xp8CTCtvrKlSDSqfuDmvH+eSQaoDxSQkfWdQ8S+CWQJ1O8FmR22mleoW1CBDxHrzU
         mWQ+qj6i/aft5e7XlmFuLW8kFRmtJHkyMdZeZ7KidKSWkMWp4cqc+psqRjfbE5rJTj78
         BI1qjAf1GORpcZ+AXr5e3vfJrwYhtWw/hCOKso5L1qDvlDAQ9Moasxs8DyI4QjWleIzX
         ht2kkmk+DbRqlzMDmJMCQOm/ty+uKB2i9nBlkCM76D9yAeKlMC0Uof+CcDkDmmgWA+/X
         Dv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i75VT9iHv+RQumVifxqdOqhI73icvNqP22fPvcEQdoU=;
        b=S+9aG4jaSajhJ8lSU3cHTnHrO+rJoWtcV+BNKhhkQqRKN3c2iCbWsdId5vxcEeaTw9
         XvncjSK44BAep2uiIcQ6KJ+Oo1T6EVldFYL7RvabEw17T1MhhOT3sCiMKu2e1Ae9GCKm
         m8+TyBJPryzBoRx1OySui2k+aeDGniOfF0IFpe1xmOpdAqqyUbsZupS6WzUYvv/X8VsS
         mQM/3oIaC8irxw9cl4XgujnR8QeP3r5wrtgEmU3BxnBFXutYdbO2QLZbuDEGC6QpRuF3
         a88oHQ2EEWmxQhcZCNhKv7tdmueKqfcYNeKF4LNwZaj2ufJjB1pxdvYiI5Sv0/9Ukw58
         MoPQ==
X-Gm-Message-State: AAQBX9ebLAC18dwSQJEVdVlPp5Yiga/wLgU1xhosiY3vba5RydDih5z5
        pBvatgAW+mrsEQOqWip1NXr+Mg==
X-Google-Smtp-Source: AKy350ZfvqbkKUbInO2LPR9pxLn1EXDL65EJxZnE6SDdRR8dw4JsDXmbGJXMSH4xzaiqosqmIyGTEg==
X-Received: by 2002:a2e:9c04:0:b0:29e:e7b1:1202 with SMTP id s4-20020a2e9c04000000b0029ee7b11202mr5746591lji.43.1680117457657;
        Wed, 29 Mar 2023 12:17:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f4-20020a2e3804000000b0029ad1fc89b3sm5189658lja.60.2023.03.29.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:17:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:17:28 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: msm8998: Improve GPU OPP table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-topic-adreno_opp-v1-1-24d34ac6f007@linaro.org>
References: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
In-Reply-To: <20230329-topic-adreno_opp-v1-0-24d34ac6f007@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680117452; l=3231;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BuTOgjCT81kJFbrqBabPtOTaRvqV7WCYi0kTMwbrGyM=;
 b=sIueiwaBv29WZYicIP/gR6f1I5FJrtIi4R/EoqLoj5R6f4Cpwk3nADWHqIKjdyJsZQNZ5nsG2rgH
 BOk3yWWuDdxPFGzt0xsYbCEE08QXV0aCsCc9Zw/ZrDReYpsf8AdS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a newline before the first OPP subnode, remove useless
opp-supported-hw (there's only a single speed bin anyway) and replace
opp-level with required-opps to make sure the power domain level is
actually set, as opp-level is not the right property for this..
Furthermore, correct the levels that were incorrect before (confirmed
against downstream).

Round off frequencies that had uneven fluff on the last two digits.

To top if off, leave a note that we should really be scaling the
VDD GFX power domain coming from CPR4, which is not yet supported.
Scaling MX is still very important though and can be considered
valid for the time being - it's better if we scale at one of
two voltage rails than if we scaled none..

Fixes: 87cd46d68aea ("arm64: dts: qcom: msm8998: Configure Adreno GPU and related IOMMU")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 39 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 09b222f363c2..11952f9ed9ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1396,51 +1396,46 @@ adreno_gpu: gpu@5000000 {
 			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
 			iommus = <&adreno_smmu 0>;
 			operating-points-v2 = <&gpu_opp_table>;
+			/* TODO: also scale VDDGFX with CPR4 */
 			power-domains = <&rpmpd MSM8998_VDDMX>;
 			status = "disabled";
 
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
-				opp-710000097 {
-					opp-hz = /bits/ 64 <710000097>;
-					opp-level = <RPM_SMD_LEVEL_TURBO>;
-					opp-supported-hw = <0xff>;
+
+				opp-710000000 {
+					opp-hz = /bits/ 64 <710000000>;
+					required-opps = <&rpmpd_opp_turbo>;
 				};
 
-				opp-670000048 {
-					opp-hz = /bits/ 64 <670000048>;
-					opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					opp-supported-hw = <0xff>;
+				opp-670000000 {
+					opp-hz = /bits/ 64 <670000000>;
+					required-opps = <&rpmpd_opp_turbo>;
 				};
 
-				opp-596000097 {
-					opp-hz = /bits/ 64 <596000097>;
-					opp-level = <RPM_SMD_LEVEL_NOM>;
-					opp-supported-hw = <0xff>;
+				opp-596000000 {
+					opp-hz = /bits/ 64 <596000000>;
+					required-opps = <&rpmpd_opp_nom>;
 				};
 
-				opp-515000097 {
-					opp-hz = /bits/ 64 <515000097>;
-					opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					opp-supported-hw = <0xff>;
+				opp-515000000 {
+					opp-hz = /bits/ 64 <515000000>;
+					required-opps = <&rpmpd_opp_nom>;
 				};
 
 				opp-414000000 {
 					opp-hz = /bits/ 64 <414000000>;
-					opp-level = <RPM_SMD_LEVEL_SVS>;
-					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_svs>;
 				};
 
 				opp-342000000 {
 					opp-hz = /bits/ 64 <342000000>;
-					opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_svs>;
 				};
 
 				opp-257000000 {
 					opp-hz = /bits/ 64 <257000000>;
-					opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					opp-supported-hw = <0xff>;
+					required-opps = <&rpmpd_opp_svs>;
 				};
 			};
 		};

-- 
2.40.0

