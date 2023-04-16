Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629CB6E3706
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDPKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDPKLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:11:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DEFDE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:11:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id xd13so22867143ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681639900; x=1684231900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paR9xnnqoHafGWhtevGVPO7lCDkAStM4xbbA9pEeU/E=;
        b=ObhszkQ5pMvOfAtBxaUpv8DZA89joVFNMDBz6+4btDrP4AlzBs224JzKs8aLppD+ys
         OTL8pkC5hoEeveNPEvQfqxsRi5K0BD6mKhBtO9ikbsmOsX6XozlPeZnl+VCOEzc/y4DO
         wGu+bIsj3CHM5tlQcD83xWi36jfnVuwG6IEinOT77qGM+IupV6dcxMjscdhIb3GREj45
         99kkpm1e3j4+/mbxQEWmw5Rwk8+wB2BIFsY6mQViQBGpYNi4I4k+vbQFRP4H+ewoymLZ
         9+qhoUEvNZGaGlogDcbzlJRROVsbLlnr0NgUp7H7nQPvXLIPVe7+E4enhkeAqFqlQ7Z6
         UWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639900; x=1684231900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paR9xnnqoHafGWhtevGVPO7lCDkAStM4xbbA9pEeU/E=;
        b=IG399nx8zCVD0GOD4v659XwebylB+J4PjUGiiAAX5Og353YvStXsD6BIgRtMp9lUTP
         0iV9ekzXbG33wec5AgTs5ortejNdH5NWG6Hztm2VrI4C5aSJlam05Gu2O2YTCVu4ayrX
         f4Pd4o84dGt/878YFM+g8A3uD2Z049CJfjJfd3/o7Se9s9akz5UdhNSuQPPuFUsqrUud
         aeys0ZwcPZc6mrLzP5w7y9LeVHAqPdyVTPSv7L7SmLLqzT+OK1to/O+sXI6KymzKOi9U
         H4W2KsZgunR9zeM4T5iytg3A8BJMemu092tMgLpiQXGFTCpNWkCXicrLnQHAabrYFVsw
         6sOw==
X-Gm-Message-State: AAQBX9e/ZeAdlWotUXNs2jf6z9tQAzvECn1yTtUau9AKZBTe0DT+Z161
        YS5wM3u6gvhrqhLXITasNbiB+g==
X-Google-Smtp-Source: AKy350aaS1mm/iGLzgMsJE+nL20g1KKZd0nySFL3Ajcx6uEjxEFEWi/0n0V34xf7g27EONkW4UXpyA==
X-Received: by 2002:a17:907:1245:b0:94e:6294:9d23 with SMTP id wc5-20020a170907124500b0094e62949d23mr3401890ejb.26.1681639900439;
        Sun, 16 Apr 2023 03:11:40 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id wg9-20020a17090705c900b0094ea48e9052sm4742755ejb.32.2023.04.16.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:11:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ARM: dts: qcom: add missing cache properties
Date:   Sun, 16 Apr 2023 12:11:34 +0200
Message-Id: <20230416101134.95686-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required cache-unified properties to fix warnings like:

  qcom-ipq4019-ap.dk01.1-c1.dtb: l2-cache: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi | 1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 672b246afbba..d2289205ff81 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -83,6 +83,7 @@ CPU3: cpu@3 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		idle-states {
diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index b653ea40c441..83839e1ec4d1 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -74,6 +74,7 @@ cpu@3 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			qcom,saw = <&saw_l2>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index dfcfb3339c23..f0ef86fadc9d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -102,6 +102,7 @@ cpu@3 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			qcom,saw = <&saw_l2>;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index bcdc37bfef54..621edf508a88 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -45,6 +45,7 @@ cpu1: cpu@1 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index f601b40ebcf4..78023ed2fdf7 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -36,6 +36,7 @@ cpu@1 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2a668cd535cc..616fef2ea682 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -42,6 +42,7 @@ cpu@1 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 38d3ee152dcb..a22616491dc0 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -80,6 +80,7 @@ CPU3: cpu@3 {
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			qcom,saw = <&saw_l2>;
 		};
 
-- 
2.34.1

