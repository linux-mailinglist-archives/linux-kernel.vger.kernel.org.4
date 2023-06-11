Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8672B22D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjFKOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFKOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54210E2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso24303575e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492234; x=1689084234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdOiX3FKcjlJJS2UzLSyrdBrswEWVUKPHD0bqmPS4vs=;
        b=BwJ/g26lp9KQ8ao/kcZ7jHbAv8aRQA9Z7kesk+HAl/MqLTWrxLGVCrKxDmH2vpPkLI
         KCGtb2rh4mlq4xqvzC2bLf/lgzBe+KytLa3dAvi1o4zwTE69r87IpkC9fnAj41JrHAdK
         GpwMjRgB3urb+DKoYXWdFsWvWsTGeU78HCJRZhqtpaAhewIv/DSlRgoe9KIDhLH9yOCd
         l8gCDJpg5UTbbrPme/kOedOKSw/tCeXMmBA3a7Fk3HGbfi/AZrIrbRX4u1vetNLR4GJR
         ia+EYZ/ISYBxPh0IsidGrxSPHPEoJuXJp7UVh3etlpuomnYb9SZZYmRJz6tWPq7GIVSp
         OVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492234; x=1689084234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdOiX3FKcjlJJS2UzLSyrdBrswEWVUKPHD0bqmPS4vs=;
        b=OgnlJmq92ZTMEFjLz/0bzH5WUsgF/XB3aE2ySYp0vqoJE4Txp9KWx3nZTShRJtF5pp
         VbyfiI89CdOip8ealzzuFghVwVxRTjy9svafFV2JEIxA4uwyQVPocyB6B+SGIwyvJR3G
         esqIpmWUHbt3SHGNZNgLNjQW0fBVykI8Ue3qy69eZtFrmEz3kmpLTnAuCK37Buos/jN6
         53BYYDIBzYcfP0hzhmf4DM9THaO/BUwZTz76UYtgGFY1xD2sowTHywbbQNZnoelPU2dU
         CYffheOvUM2EUwg/kdM8pM5ASICu3LU7bDEyUXyUQOP1fgpdtfHXY5Gd1s7/KbrjjtmK
         EGVQ==
X-Gm-Message-State: AC+VfDwJycZtxQyo4YMAXWm91aDvBTAoi0ZFHRWHklqgvUzu0R9zAVFs
        AxK4zFrmFO+WJoud/5crc7z3OQ==
X-Google-Smtp-Source: ACHHUZ4MkKRLqdMNmJYfL4gL3SIhpZzeYHLmDqM8swFhyPRVUWMIZlxuqIO/Bklhq7V73jj2P02a1A==
X-Received: by 2002:a05:600c:114c:b0:3f7:38dd:5e9f with SMTP id z12-20020a05600c114c00b003f738dd5e9fmr3972014wmz.28.1686492234206;
        Sun, 11 Jun 2023 07:03:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/26] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
Date:   Sun, 11 Jun 2023 15:03:12 +0100
Message-Id: <20230611140330.154222-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Document the OTP memory found on Rockchip RK3588 SoC.

Since RK3588 uses different clocks & resets configurations than PX30 /
RK3308, provide the required changes in the binding to be able to handle
both variants.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/rockchip,otp.yaml          | 54 ++++++++++++++++---
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index 4cd425ae2823..9c6eff788928 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -9,33 +9,35 @@ title: Rockchip internal OTP (One Time Programmable) memory
 maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
-allOf:
-  - $ref: nvmem.yaml#
-
 properties:
   compatible:
     enum:
       - rockchip,px30-otp
       - rockchip,rk3308-otp
+      - rockchip,rk3588-otp
 
   reg:
     maxItems: 1
 
   clocks:
-    maxItems: 3
+    minItems: 3
+    maxItems: 4
 
   clock-names:
+    minItems: 3
     items:
       - const: otp
       - const: apb_pclk
       - const: phy
+      - const: arb
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: phy
+    minItems: 1
+    maxItems: 3
 
 required:
   - compatible
@@ -45,6 +47,44 @@ required:
   - resets
   - reset-names
 
+allOf:
+  - $ref: nvmem.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-otp
+              - rockchip,rk3308-otp
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: phy
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-otp
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: otp
+            - const: apb
+            - const: arb
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

