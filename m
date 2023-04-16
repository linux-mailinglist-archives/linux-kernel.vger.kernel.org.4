Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677406E3707
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDPKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDPKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:11:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15041701
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:11:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a5so241667ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681639899; x=1684231899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwGnjcRXQbhcnPDcAoTH9XUhfokLgFY+kCQQTm3iXKY=;
        b=NJYy5uxfdNbrGF+BjqZCXQveQt2Ll7qS3BTrajnquu+oUnyzfuL83HDxP5nfojiZhe
         b06+0s/9FAUwW4KC02xxPiKX+/Xq6Oa80lopWO9dKO0gu9ZuC+X5Rt+oqA7dIKjlJxpo
         /QznXyeFstKnKFYbLpKTm0BEZyX7W77eLVDYpfbvyR63bf40zlIUQ4RLTGNZ2n3a5yZ8
         iaqi982yrnFrOTKT4gmevowtyq4CBv8qIiDYaNu6xdzFU0L0iK6oYydi0fr//Q7/BZAk
         iVKSvDEdyKjomcaClXi9uAqUjvXRStnvC/L2/spdSdtH4+kMJphBjdqdtHqmIg/CnHg5
         3MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639899; x=1684231899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwGnjcRXQbhcnPDcAoTH9XUhfokLgFY+kCQQTm3iXKY=;
        b=HE7189JLAMUvbyb8hjfubENg9bzvaIhzZ2PrleEvevQR2Kh1taAIvWlW+uA9FLRENY
         UsLgTlJjmYoSum0P+HmeR45rbrhsasffW2ttkPCgymOB28Eo9csaob+YKkmm7pqaK54D
         8tsxj9RZnPTF2Hwn3J9pTh6Ai4k+jdV0+5cJwuH8HrIMkqF39uj+FxIqxXZdWQMYhYRs
         XeVSzCYuSiy4D0DvSIBeKAHqbZIPpEuXdgXYDs57AGzeq50U2z3yi+wgtpJti01ekYU3
         ZUbDaVFG9nF4rVQLH0iCPx0POXksR3rJYVbyDIkwz2CTU99Z2HptJZaEKutKp+0PfW4D
         swng==
X-Gm-Message-State: AAQBX9dxkVg0jh+dlMuYPJAr8HnBQpZz47S8WO1qXXQ5LF0PgSWr4ZZs
        OJUj4nmhYiyignQ+JnwbpEv/EA==
X-Google-Smtp-Source: AKy350YJrDMOOIyqh90qX70vTZp1MtYZLE6vgA9lDnxG1Ge5tGGzIOI2Y4kQy0E1u+QBdT6olOE5BQ==
X-Received: by 2002:a17:906:3e5b:b0:94f:31ee:ba36 with SMTP id t27-20020a1709063e5b00b0094f31eeba36mr2512937eji.37.1681639899143;
        Sun, 16 Apr 2023 03:11:39 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id wg9-20020a17090705c900b0094ea48e9052sm4742755ejb.32.2023.04.16.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:11:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: add missing cache properties
Date:   Sun, 16 Apr 2023 12:11:33 +0200
Message-Id: <20230416101134.95686-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required cache-level and cache-unified properties to fix warnings
like:

  qdu1000-idp.dtb: l3-cache: 'cache-unified' is a required property
  qdu1000-idp.dtb: l2-cache: 'cache-level' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi  |  2 ++
 arch/arm64/boot/dts/qcom/msm8976.dtsi  |  2 ++
 arch/arm64/boot/dts/qcom/msm8994.dtsi  |  2 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi  |  2 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi  |  2 ++
 arch/arm64/boot/dts/qcom/qcm2290.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi  | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  9 +++++++++
 arch/arm64/boot/dts/qcom/sdm630.dtsi   |  2 ++
 arch/arm64/boot/dts/qcom/sdm670.dtsi   | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |  2 ++
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  2 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm6375.dtsi   | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  9 +++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi   |  9 +++++++++
 28 files changed, 170 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 12e0e179e139..af4d97143bcf 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -73,6 +73,7 @@ CPU3: cpu@3 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index ece652a0728a..f531797f2619 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -84,6 +84,7 @@ CPU3: cpu@3 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 4056ce59d43f..5b2c1986c8f4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -67,6 +67,7 @@ CPU3: cpu@3 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 3bb7435f5e7f..0ed19fbf7d87 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -72,6 +72,7 @@ CPU3: cpu@3 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7e0fa37a3adf..834e0b66b7f2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -180,6 +180,7 @@ CPU3: cpu@3 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		idle-states {
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 602cb188a635..d44cfa0471e9 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -153,11 +153,13 @@ core3 {
 		L2_0: l2-cache-0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		L2_1: l2-cache-1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 1f0bd24a074a..f47fb8ea71e2 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -193,11 +193,13 @@ big_cpu_sleep_1: cpu-sleep-1-1 {
 		l2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		l2_1: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 2831966be960..bdc3f2ba1755 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -52,6 +52,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -88,6 +89,7 @@ CPU4: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 2c5780008c84..30257c07e127 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -55,6 +55,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -85,6 +86,7 @@ CPU2: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b150437a8355..3ec941fed14f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -146,6 +146,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -190,6 +191,7 @@ CPU4: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index ae5abc76bcc7..b29bc4e4b837 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -51,6 +51,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index eefed585738c..972f753847e1 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -95,6 +95,7 @@ CPU3: cpu@103 {
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		idle-states {
diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 734438113bba..fb553f0bb17a 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -35,9 +35,13 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -54,6 +58,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -70,6 +76,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -86,6 +94,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 2343df7e0ea4..c3310caf9f68 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -42,9 +42,13 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -58,6 +62,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -71,6 +77,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_2>;
 			L2_2: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -84,6 +92,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_3>;
 			L2_3: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -97,9 +107,13 @@ CPU4: cpu@10000 {
 			next-level-cache = <&L2_4>;
 			L2_4: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_1>;
 				L3_1: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
 				};
 
 			};
@@ -114,6 +128,8 @@ CPU5: cpu@10100 {
 			next-level-cache = <&L2_5>;
 			L2_5: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_1>;
 			};
 		};
@@ -127,6 +143,8 @@ CPU6: cpu@10200 {
 			next-level-cache = <&L2_6>;
 			L2_6: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_1>;
 			};
 		};
@@ -140,6 +158,8 @@ CPU7: cpu@10300 {
 			next-level-cache = <&L2_7>;
 			L2_7: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_1>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ea1ffade1aa1..f479cab8ab45 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -92,10 +92,12 @@ &LITTLE_CPU_SLEEP_1
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -120,6 +122,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -144,6 +147,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -168,6 +172,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -192,6 +197,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -216,6 +222,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -240,6 +247,7 @@ &BIG_CPU_SLEEP_1
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -264,6 +272,7 @@ &BIG_CPU_SLEEP_1
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 31728f461422..2fd1d3c0eb34 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -182,10 +182,12 @@ &LITTLE_CPU_SLEEP_1
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -208,6 +210,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -230,6 +233,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -252,6 +256,7 @@ &LITTLE_CPU_SLEEP_1
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -274,6 +279,7 @@ &BIG_CPU_SLEEP_1
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -296,6 +302,7 @@ &BIG_CPU_SLEEP_1
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -318,6 +325,7 @@ &BIG_CPU_SLEEP_1
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -340,6 +348,7 @@ &BIG_CPU_SLEEP_1
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 8fb766f9e8e0..6d3780a75024 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -58,10 +58,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -83,6 +85,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -104,6 +107,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -125,6 +129,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -146,6 +151,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -167,6 +173,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -188,6 +195,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -209,6 +217,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 37e72b1c56dc..eaead2f7beb4 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -63,6 +63,7 @@ &PERF_CLUSTER_SLEEP_1
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -127,6 +128,7 @@ &PWR_CLUSTER_SLEEP_1
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 49c07cb76b20..b61e13db89bd 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -41,8 +41,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
+				cache-level = <2>;
+				cache-unified;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -57,6 +61,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -71,6 +77,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -85,6 +93,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -99,6 +109,8 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -113,6 +125,8 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -127,6 +141,8 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -141,6 +157,8 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ae0510e687b4..cdeb05e95674 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -108,10 +108,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -135,6 +137,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -158,6 +161,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -181,6 +185,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -204,6 +209,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -227,6 +233,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -250,6 +257,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -273,6 +281,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 631ca327e064..43f31c1b9d5a 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -50,6 +50,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -102,6 +103,7 @@ CPU4: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 9484752fb850..2aa093d16858 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -47,6 +47,7 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
@@ -87,6 +88,7 @@ CPU4: cpu@100 {
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 18c4616848ce..ad34301f6cdd 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -60,10 +60,12 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -86,6 +88,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -108,6 +111,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -130,6 +134,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -152,6 +157,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -174,6 +180,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -196,6 +203,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -218,6 +226,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 4e8b99e7cf66..f8d9c34d3b2f 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -49,9 +49,13 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -69,6 +73,8 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -86,6 +92,8 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -103,6 +111,8 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -120,6 +130,8 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -137,6 +149,8 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -154,6 +168,8 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -171,6 +187,8 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 1a229caad8aa..27dcda0d4288 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -63,10 +63,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -90,6 +92,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -113,6 +116,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -136,6 +140,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -159,6 +164,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -182,6 +188,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -205,6 +212,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -228,6 +236,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ebe59bd7bcc7..3efdc03ed0f1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -60,10 +60,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -82,6 +84,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -100,6 +103,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -118,6 +122,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -136,6 +141,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -154,6 +160,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -172,6 +179,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -190,6 +198,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index b15b585f3548..d59ea8ee7111 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -59,10 +59,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -81,6 +83,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -99,6 +102,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -117,6 +121,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -135,6 +140,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -153,6 +159,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -171,6 +178,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -189,6 +197,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e9bad8f6f33..43192ef21aec 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -80,10 +80,12 @@ CPU0: cpu@0 {
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
+					cache-unified;
 				};
 			};
 		};
@@ -104,6 +106,7 @@ CPU1: cpu@100 {
 			L2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -124,6 +127,7 @@ CPU2: cpu@200 {
 			L2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -144,6 +148,7 @@ CPU3: cpu@300 {
 			L2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -164,6 +169,7 @@ CPU4: cpu@400 {
 			L2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -184,6 +190,7 @@ CPU5: cpu@500 {
 			L2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -204,6 +211,7 @@ CPU6: cpu@600 {
 			L2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -224,6 +232,7 @@ CPU7: cpu@700 {
 			L2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
+				cache-unified;
 				next-level-cache = <&L3_0>;
 			};
 		};
-- 
2.34.1

