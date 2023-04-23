Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6616EC0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDWPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDWPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:09:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0BE73
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:09:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a39f6e8caso619922266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682262589; x=1684854589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uaEulRobE0OCNfNMXefVDjWL4Gofpr35/oMUFxTi2M=;
        b=tBOjUEXE7a/z4qdXVVlepEWEfiaBFS15wT4QriqPSwAfx/p67u7M5auXe+iAum/UNH
         XKt0ZAb4HD0gy01JOObv95yU9MvEO2a187IIjBS/mARaI+aY985DZ2mYrBiF0htuWbSP
         90AHy0N+zT7iu9XZzX+l2gpXfDXDNP8pyyPlOZxD3hRD9HfsLUkd7GiNm1AKMe7jQrRz
         jAz1Dw1zxgTEKl5Udsn4yv2c5pN4y9b8oCQLl4g3Wpq1sIMLhvWsu3U5M+9cn9NA4JXX
         0bVUo9+mfa2QFT8MLa5fMR0wmhABJShijjOFljKZy0DVG4uR71mjjvsmiq+oUAEW1nhi
         oJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682262589; x=1684854589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uaEulRobE0OCNfNMXefVDjWL4Gofpr35/oMUFxTi2M=;
        b=VtqvWz7yU5FPev4AQvdVMNB6LE6wPOG1j8j9epy5v3sLT7cPXz2dylpCvGKJtkuxu1
         HxIBFQhlPKlKX8kN/XcsQcQ5dUmtSRN6JKnYmD/LHzfZwndEMMAjGEWxx2qJjM7E2TAm
         +Fk2TTfACm+Ff1Cr5lW4Wtp5NpQTm4LZ4CvoDJB/IKZUYWfgSXWNd9eTVqnHFiNDtrSm
         7HG/PfvaV1FGFYQ6t5nZ4gFw0hJWBUPXhN6JGbEkrxQlvoj7OJ+/Iy6SPBPD0Kg/sEj+
         A8pZafHTWy3LNz8wADtZ8PjyR/rXNJ2wGiG2alWjGqI4r0FS99OjdSNs4gl8nP0k8nvv
         7LOQ==
X-Gm-Message-State: AAQBX9csKmDha+pn8GjCCG86fdIyY9n/hNRdq2X/Q5BygsK3uc0nwuaK
        6T+M3oviyuvjsfvw+6EzQ0PbJA==
X-Google-Smtp-Source: AKy350bOWwQmma+aSBSnWVbFJgHURaUFsRjSOzzceCWFsCgemUK6U8xV32q4cxAikUeFlFO4EgSkrg==
X-Received: by 2002:a17:906:f8d9:b0:94f:720b:1b14 with SMTP id lh25-20020a170906f8d900b0094f720b1b14mr7001243ejb.29.1682262588877;
        Sun, 23 Apr 2023 08:09:48 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:5d52:d466:d57f:118c])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906114d00b0094a44867e0asm4489141eja.52.2023.04.23.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:09:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: broadcom: add missing cache properties
Date:   Sun, 23 Apr 2023 17:09:43 +0200
Message-Id: <20230423150943.118576-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  bcm963148.dtb: l2-cache0: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/bcm47622.dtsi | 1 +
 arch/arm/boot/dts/bcm63148.dtsi | 1 +
 arch/arm/boot/dts/bcm63178.dtsi | 1 +
 arch/arm/boot/dts/bcm6756.dtsi  | 1 +
 arch/arm/boot/dts/bcm6846.dtsi  | 1 +
 arch/arm/boot/dts/bcm6855.dtsi  | 1 +
 arch/arm/boot/dts/bcm6878.dtsi  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/bcm47622.dtsi
index cd25ed2757b7..7cd38de118c3 100644
--- a/arch/arm/boot/dts/bcm47622.dtsi
+++ b/arch/arm/boot/dts/bcm47622.dtsi
@@ -52,6 +52,7 @@ CA7_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm63148.dtsi b/arch/arm/boot/dts/bcm63148.dtsi
index ba7f265db121..24431de1810e 100644
--- a/arch/arm/boot/dts/bcm63148.dtsi
+++ b/arch/arm/boot/dts/bcm63148.dtsi
@@ -36,6 +36,7 @@ B15_1: cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm63178.dtsi b/arch/arm/boot/dts/bcm63178.dtsi
index d8268a1e889b..3f9aed96babf 100644
--- a/arch/arm/boot/dts/bcm63178.dtsi
+++ b/arch/arm/boot/dts/bcm63178.dtsi
@@ -44,6 +44,7 @@ CA7_2: cpu@2 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6756.dtsi b/arch/arm/boot/dts/bcm6756.dtsi
index 49ecc1f0c18c..1d8d957d65dd 100644
--- a/arch/arm/boot/dts/bcm6756.dtsi
+++ b/arch/arm/boot/dts/bcm6756.dtsi
@@ -52,6 +52,7 @@ CA7_3: cpu@3 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6846.dtsi b/arch/arm/boot/dts/bcm6846.dtsi
index fbc7d3a5dc5f..cf92cf8c4693 100644
--- a/arch/arm/boot/dts/bcm6846.dtsi
+++ b/arch/arm/boot/dts/bcm6846.dtsi
@@ -36,6 +36,7 @@ CA7_1: cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6855.dtsi b/arch/arm/boot/dts/bcm6855.dtsi
index 5e0fe26530f1..52d6bc89f9f8 100644
--- a/arch/arm/boot/dts/bcm6855.dtsi
+++ b/arch/arm/boot/dts/bcm6855.dtsi
@@ -44,6 +44,7 @@ CA7_2: cpu@2 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm6878.dtsi b/arch/arm/boot/dts/bcm6878.dtsi
index 96529d3d4dc2..2c5d706bac7e 100644
--- a/arch/arm/boot/dts/bcm6878.dtsi
+++ b/arch/arm/boot/dts/bcm6878.dtsi
@@ -36,6 +36,7 @@ CA7_1: cpu@1 {
 		L2_0: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

