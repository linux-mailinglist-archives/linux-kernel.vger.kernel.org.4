Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED6639A84
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiK0MdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiK0MdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:33:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F10DFB6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:33:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f13so13479239lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R150jh6hIsEIRbJZYKF6ButqqrlO23mFgihHTi2zgwY=;
        b=S+hLAccwjMx6+lWYZVHy1rev13gTMxKOC4B9EHt2zOWdrdHY9bNlSZ6rcBFFuR9/3w
         CrEsdQnAqz4vySMxE0axqhWsBoV4qBg/zs79oj4h8pbbUWNWWysuLWslcEFfU5VkwtOA
         hN6JmbMbzKvK4JBix/lBOUu4D86Cg7T3eflx3mzQuWPw3/oZdKdTjvi0ivjivV0WbVyo
         EjgnCotDUHaefjkJBNvfoFsk/nwpMmyBFY1quanJEAJUaRwA+DHWM6A5Vo91om07MW9e
         W7PJDiQYULM22E2J8ijNz4rmIYg4KUU8/C8JlEtGTDoJf4O6mjVsy1QNzAsioNN/3yMq
         g16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R150jh6hIsEIRbJZYKF6ButqqrlO23mFgihHTi2zgwY=;
        b=nU0e0lwMuBWHYKrqzXggSeL2l5l393TVLsy4WaLGtXPZi3rmZoMXqqec7+ZF/p6Rkw
         //5AfQ+3eic5get+FPWY/LCVoXAg5S2y4cGDNMtMGHEspz3quBBnym8uGjL3Vbwk6PPi
         fWJ+RBqKTpq38Z+kK2tLxcDTo7U1Fc9ceBhLhKxmMZGcZgneJNPaPhf26QoQA8Pjpu/L
         Y03s3ZYWdjwiAsoEaocLtGOQ+pW9e+bxi2bt0nsogfiTNnnK+BqsVy0KAfwitgcr2YPL
         BO/Cp3n27bw24r95GI4grBAVjmcO4h7mEEAQeefKGc5Aqi9BfCcc9wPsyX+wteuHWONo
         cPkA==
X-Gm-Message-State: ANoB5pmeDpIqLqerOGaavxp5xvJGP6s3H8Bek0tR+bkt0NbTWRmLONhj
        9z9A5hlLahYxuw3NIM770UuuHw==
X-Google-Smtp-Source: AA0mqf4IMmKxlfhiMCYnD0x3FSe8Uvha1FpyVVrqp8MUs675XreSRYN9WD+BITxHQ/e+wireqt2RnQ==
X-Received: by 2002:a05:6512:281b:b0:4b3:e086:87d8 with SMTP id cf27-20020a056512281b00b004b3e08687d8mr8985991lfb.259.1669552383598;
        Sun, 27 Nov 2022 04:33:03 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf36-20020a05651225a400b0049fff3f645esm1270435lfb.70.2022.11.27.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 04:33:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 2/4] dt-bindings: soc: samsung: exynos-sysreg: split from syscon
Date:   Sun, 27 Nov 2022 13:32:57 +0100
Message-Id: <20221127123259.20339-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
References: <20221127123259.20339-1-krzysztof.kozlowski@linaro.org>
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

Split Samsung Exynos SoC SYSREG bindings to own file to narrow the
bindings and do not allow other parts of syscon.yaml.  This allows
further customization of Samsung SoC bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Lee Jones <lee@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Sriranjani P <sriranjani.p@samsung.com>

---

Changes since v1:
1. Add Rb tags.

Cc: Sriranjani P <sriranjani.p@samsung.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
 .../soc/samsung/samsung,exynos-sysreg.yaml    | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd010431..b73ba1ea08f7 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -64,12 +64,6 @@ properties:
               - rockchip,rk3568-qos
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
-              - samsung,exynos3-sysreg
-              - samsung,exynos4-sysreg
-              - samsung,exynos5-sysreg
-              - samsung,exynos5433-sysreg
-              - samsung,exynos850-sysreg
-              - samsung,exynosautov9-sysreg
 
           - const: syscon
 
diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
new file mode 100644
index 000000000000..68064a5e339c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/samsung,exynos-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series System Registers (SYSREG)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,exynos3-sysreg
+              - samsung,exynos4-sysreg
+              - samsung,exynos5-sysreg
+              - samsung,exynos5433-sysreg
+              - samsung,exynos850-sysreg
+              - samsung,exynosautov9-sysreg
+          - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@10010000 {
+        compatible = "samsung,exynos4-sysreg", "syscon";
+        reg = <0x10010000 0x400>;
+    };
-- 
2.34.1

