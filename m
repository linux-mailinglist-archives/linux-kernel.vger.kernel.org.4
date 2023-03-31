Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D16D14D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 03:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCaBPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 21:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCaBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:15:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826D1204C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:15:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q14so21475574ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680225301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYSzPLydtmK2JKcRhPPJf/WCaXdAIMHqEJnKMvnOMFk=;
        b=QB9AJhVUigoXflzaqK7rWan9FMupoyp/wjPCEWPrRuOD6jYiWwHo82ekHqx8y7Y4c6
         XGMdr2D1+kFtG4J0IJ2gdzEMiwAhFJQus3wIcHXSOsspm+P2L8mTLnaJ3up3yWo1iu2J
         QTR240DGs6kRd2Gk0jOFqRqS1/A3CBnNJcyYdapa/aFt+/jC3Kk/oUbZH+BXd8maBZKz
         gF0R61U6wNxSJ+S03+AdTG8HT3oh99Cb1WtFSo3Kmhll/6/udnBPTRVoIZkEV8XNdVMU
         AzADUEQ9zV3iW4zeySzI4KNJaCD3WmsAD3S9OwPwhwOHa0P7U6jbaVSDOe024omWVN0C
         hJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680225301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYSzPLydtmK2JKcRhPPJf/WCaXdAIMHqEJnKMvnOMFk=;
        b=ZQvsZLKVBaYkqDoF7JvsIlLUNyLsZG8MKC+9bnSPLJQU/PjzZvadp5KVM5hYJ1D9g7
         di2b9mh2fyjm2x4MYLyMQPkpEIe4Uy1Gn+8QF9hUIi/ydwGmhbzthKQEehowOzNcCgyr
         vxVHwp2xK17Jz/p9P2AJf5L0Z9JisDEQQNZLs/RNhUbAL60MZ1BhZaM+7giZqxWzBBIH
         ilgqqKVbl4CgAcMFtbH4IQ6fLd9uYcrzOF8gFcnsJM8VT/J6uNiT2ousWGilbokk2+RV
         GR/ba8HsTAbSKJSP5qeZ295zNM7HeP3IIyC6agVXUt19vg/F7qp9VtCZSnL9rmsykGzT
         8z5Q==
X-Gm-Message-State: AAQBX9fx4b6Zlq5GKDbcDMgUK8kbtnytN9XAtntgh0BpiS+DXLO0z1bo
        fbaYtIv+sUKF180sGwly2wtJYw==
X-Google-Smtp-Source: AKy350bM6SamDQIPnoK5ZV65Xwd526bmZB2kbPdT3rNXJMHLa+/Z0XO3jm3EO29ULFIcPuQvnUET+w==
X-Received: by 2002:a2e:888f:0:b0:299:a8e2:2181 with SMTP id k15-20020a2e888f000000b00299a8e22181mr8005791lji.43.1680225301285;
        Thu, 30 Mar 2023 18:15:01 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n7-20020a2e7207000000b002986854f27dsm134573ljc.23.2023.03.30.18.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:15:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 31 Mar 2023 03:14:52 +0200
Subject: [PATCH v3 4/5] arm64: dts: qcom: sm8150: Add GPU speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-konahana_speedbin-v3-4-2dede22dd7f7@linaro.org>
References: <20230331-topic-konahana_speedbin-v3-0-2dede22dd7f7@linaro.org>
In-Reply-To: <20230331-topic-konahana_speedbin-v3-0-2dede22dd7f7@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680225294; l=2592;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=koZEmO1fkF/bnaYkvF93NsF8DQclVperHMMUdURxE4o=;
 b=j2Z9eJ2Mqm4KOtIUJKp9MRUSZpdT9SbI2GcYYME7XSdmYXJ3KKnNeJZ2tOf0YD3GBAikO/WhSGNM
 fPPJDeCQD3HadP8gcr+3JLBcWjvTqcN/z0+zY0kYv64lwnnN4BDp
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

SM8150 has (at least) two GPU speed bins. With the support added on the
driver side, wire up bin detection in the DTS to restrict lower-quality
SKUs from running at frequencies they were not validated at.

Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 (speed bin 0x3)
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 880483922f22..e4230877555d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -952,6 +952,17 @@ ethernet: ethernet@20000 {
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
@@ -2169,44 +2180,52 @@ gpu: gpu@2c00000 {
 
 			qcom,gmu = <&gmu>;
 
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
 			status = "disabled";
 
 			zap-shader {
 				memory-region = <&gpu_mem>;
 			};
 
-			/* note: downstream checks gpu binning for 675 Mhz */
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
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
2.40.0

