Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165967E3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjA0Lrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjA0LrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:47:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7A7D6E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so3263059wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1vX2NfXMPJ2n77uZ2Iq8KCN2mMlBamUruQdnMhKP6s=;
        b=bBiqrOwoyMbDgVFbz4VgGVpD1ypfz0ejKvZmGZuhDdz99zAoTeqzvx1pULZNF+RVXB
         WYV6tKPB8qe2Xeofvzan9GNU2hSQMm5uSKbMucn1abizE3zKT4QuF9wQh9gUkSuJBY53
         sY5d3x119Co+yIOjZkzKrK7JfLGXqXeWfZZHrNkYkusa0rxNSD7ab6DNAr198Xe6P/4y
         GdHxiHZGQjPp9EGjAQBhIFENvuUFKVINz0wVHW5dlm0LfLWKnaGccmHvNnNHfa7ASPrn
         AY5gijclRF2EYSi0agGrS9BYWxqeUXpxLQ82WjHUdH1WQH328NJVNA8MTgLgm+dyfdWP
         LgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1vX2NfXMPJ2n77uZ2Iq8KCN2mMlBamUruQdnMhKP6s=;
        b=C99WsZ6b9PMmgf10AIIZYicIFN+wdRq18tmkM9cx+ZPk2YMXvBF64OBSXXoReb5d91
         iQcurvtgKC0FWgzJ8NWa32tgzANFUZ69ZgB31Iu+OqxoI1x6107cSTzXPWLP8GAv9pvw
         Pfx21fvkA4XfaBH6kYdFIH7dy/2rXdTqlMopps2msk4jdpdi3RigaJtw2AvTzcdroaNg
         lVxtaueB6ITlxYfvY/6V1ApfCBm9q8nFbocGHGPqbpPT18bT9qc6E1j8YU60mcnbYMTB
         bLewD3DFyTdjPUcuJNN34hWxmE17HwkXs4wauqDYSgHJCm6+gRrGQtLbfXwAPOmd9w4Y
         wXMQ==
X-Gm-Message-State: AFqh2kroyJPle+lmWeFp5LHkxArym0K7kCcYAKpa4LKG7cSR3+sxTx8D
        s2qaasmsg8aLs+9dHW3SK998ZQ==
X-Google-Smtp-Source: AMrXdXvRXwy9/CSz46uzKGxLJUHM/91AI7/38BMl8r7o/OAjEeKX086cntZWs4YX3KW5dJ7adcQnGQ==
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr38504168wmb.36.1674819859074;
        Fri, 27 Jan 2023 03:44:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm3807760wrs.47.2023.01.27.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:44:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/11] arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings
Date:   Fri, 27 Jan 2023 12:43:42 +0100
Message-Id: <20230127114347.235963-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
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

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                  | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                  | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi              | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                     | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi         | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts     | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts           | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi       | 6 +++---
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts          | 6 +++---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts        | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts            | 2 +-
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e19178c1ec44..f2b48241d15c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -339,7 +339,7 @@ flash@0 {
 
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -621,7 +621,7 @@ src_pp1800_lvs2: lvs2 {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 9c9a587ea7a9..0b7940c130af 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -270,7 +270,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 		vdd-s1-supply = <&vph_pwr>;
@@ -395,7 +395,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 36f291d4d691..f942c5afea9b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -166,7 +166,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -419,7 +419,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -433,7 +433,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 482f43fe0151..d1440b790fa6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -117,7 +117,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -382,7 +382,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -396,7 +396,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 548e34632de2..601f6467146d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -145,7 +145,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -281,7 +281,7 @@ vreg_l28a_3p0: ldo28 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -295,7 +295,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index e742c27fe91f..d37a433130b9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -73,7 +73,7 @@ memory@a1300000 {
 
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -332,7 +332,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 5d0509f61fe8..b54e304abf71 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -111,7 +111,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -376,7 +376,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -390,7 +390,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 85ff0a0789ea..4984c7496c31 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -99,7 +99,7 @@ ramoops@ffc00000 {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -329,7 +329,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -340,7 +340,7 @@ src_vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 0d19506dc54c..8de01a84f8a0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -124,7 +124,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 40185eda28a8..a08d9c97e414 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -144,7 +144,7 @@ vreg_s4a_1p8: vreg-s4a-1p8 {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
@@ -344,7 +344,7 @@ vreg_lvs2a_1p8: lvs2 {
 		};
 	};
 
-	pmi8998-rpmh-regulators {
+	regulators-1 {
 		compatible = "qcom,pmi8998-rpmh-regulators";
 		qcom,pmic-id = "b";
 
@@ -356,7 +356,7 @@ vreg_bob: bob {
 		};
 	};
 
-	pm8005-rpmh-regulators {
+	regulators-2 {
 		compatible = "qcom,pm8005-rpmh-regulators";
 		qcom,pmic-id = "c";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index e9e960b1ad9f..25f88215986b 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -100,7 +100,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index eae696f0dbe4..b650fa846d23 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -130,7 +130,7 @@ &adsp_pas {
 };
 
 &apps_rsc {
-	pm8998-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pm8998-rpmh-regulators";
 		qcom,pmic-id = "a";
 
-- 
2.34.1

