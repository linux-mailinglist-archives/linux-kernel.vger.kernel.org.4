Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FBC6EB4E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjDUWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjDUWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBE4487
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so16150248a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116332; x=1684708332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+asJO3lKNpyKewDhntjul2HKZTaQG/ZxnJvEiKtxXc=;
        b=iUypOhzpIKSooSHJrdZ7+29N5xuSi8jpGDsf0mh4IKHSxy9dcHWof8tlwE2rFcTI+D
         DFpns5hbgPcEMJSrAei8O9/hwss05UPguicMCLtAQvMLjJ7y4+ZasYd2JffBbbrNocvy
         ooIdbgk2iS/xI2QczoLoONNdV/gNSQVGqqXQlramZ4X3Q5Ys/llcuePYU4Eoskq0C/8U
         nFt1ir2a/dIvn3BHe257L7JppKYdD2ERkf1SLFqaiet229FAdyEwjGArr+fL+NxkZn9/
         1L3YTPasbI3ztaUt1jR+K5OYlnAJ2FFyblLv7zGm1oOlBqSCpgomp3L3iwua+8fSAAHD
         WZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116332; x=1684708332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+asJO3lKNpyKewDhntjul2HKZTaQG/ZxnJvEiKtxXc=;
        b=GhjqeK4lR+2mbBdUT6o5clES2ARlxpxPbWp36uwyNLFZnxAUAlhYEgFWCzV1x3tYPs
         oPVmdXwWO2/PTrOp5xYPINXwl8riDMwFfimUE1cG5bO+LVZmeiCTKaKoVp0jP/Doc0vZ
         IX/o3HqP3mXZ7/j1WzHEVDdBfP5M+533/1qMr/oiwlDNABNAvlOqX81rH01k6MI6MyQa
         Zdz09GXtedN8X9+96K+ocZ3ijY0XySQDmTa3jwamRnOOJt9/CgihAHViC1uB4+5iVPa2
         ub3Kfcc0FW6d01qJSeRqUxPJaFehr9vIcs5HLrK7dqDlBdXgWheyOUreuhSS08Fuj/et
         m/bg==
X-Gm-Message-State: AAQBX9eEE+BYKniz3XwHajHVT/tquXjQDNrCzsn/N8vzr5o9ZgCfdn1g
        P75mSi08qV3sPuZOSQ5lkqJW0Q==
X-Google-Smtp-Source: AKy350bgR3ssd8qcJxiCwGuNeiC4063YsIgtI9oaMySRyGQu9S/ZxI+sVcBFW63gvJ012X1SwdtH0g==
X-Received: by 2002:a05:6402:711:b0:4fb:5fe1:bc3b with SMTP id w17-20020a056402071100b004fb5fe1bc3bmr6313735edx.0.1682116332767;
        Fri, 21 Apr 2023 15:32:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7d1c7000000b005068fe6f3d8sm2233947edp.87.2023.04.21.15.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:10 +0200
Message-Id: <20230421223211.115612-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  meson-a1-ad401.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index eed96f262844..c8f344596285 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -37,6 +37,7 @@ cpu1: cpu@1 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b984950591e2..768d0ed78dbe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -106,6 +106,7 @@ cpu3: cpu@3 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f58fd2a6fe61..543e70669df5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -51,6 +51,7 @@ cpu3: cpu@3 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 431572b384db..86e6ceb31d5e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -106,6 +106,7 @@ cpu103: cpu@103 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 11f89bfecb56..2673f0dbafe7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -133,6 +133,7 @@ cpu3: cpu@3 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 617d322af0df..643f94d9d08e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -89,6 +89,7 @@ cpu3: cpu@3 {
 		l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

