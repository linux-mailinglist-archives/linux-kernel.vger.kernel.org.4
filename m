Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84126C964B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjCZPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjCZPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C14220
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er18so14979669edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35gnd9Aoe6xXafnL7UjQDr8l7FiduXH+e+bO3yaocVQ=;
        b=cvQf/CMin7njufwpp/za+I8Rz68YWTJ0WXpvpJSwzMc0Ae/C7X3H6xcgseB6KgZISn
         XtnHRWABl8Y/QVYTbfS8MjyfpXKZbwl1htuDRc8yL+wa74KTDuwjJyrUAD/R+/heMcJf
         XuVH0nbjkc686q7IgCRJLc25Wt7FzouTHZ/bBRFl53ZcFI/Kb8ydh1EGxdaOJsG2z4I5
         MyiTX0evsN+zBKWEGVwn+uspghSWyf3ajUrkD3KlQTiUlyuCKEvP+riuohmENzDSZ27/
         CsnMLkBpuGrLv8sbsyYmAwroTRjJAF6ie3OxEYnMgo7bLG0l/jd+RaHEYdFzCCkac4iN
         yUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35gnd9Aoe6xXafnL7UjQDr8l7FiduXH+e+bO3yaocVQ=;
        b=qEn+/vnuA7E7aFSjZJL0KUxfITE5q9ZX6GggbBE6koG5P4U1tN0fXvN06afWFWMXan
         CsrYvudNaCCdlUfd9PHw36cQrric/y/otD2+9yXhJOP50OLDbdHIJHG090RsfbxS7tL5
         6U385pg0BxPIYsNLQzZQjnOtdtA2smf8i6cZ+USC2Mqz86L0+coOZ2CF59TqtGeCPCHd
         CTRC6OapOBNtnue1V11ZQGAJYh/Gmtsaz6bw3aJk8hlGj1yibuevvowIS+smEIUuJMoP
         PM0G8jqtJTCsjhx7UIc70g0syuMh/69WtjNIhQGv8SUi+loGKIdewMaaogoQlSKpjfIn
         FOEQ==
X-Gm-Message-State: AAQBX9dG/aBVe1MNt7z7rkiNWwioOwfy9wrpnVCo406vYQvjL42LnwoU
        kb80diUXfgZ0qPvPdbRvk0wR6A==
X-Google-Smtp-Source: AKy350YeMSofZ0QLOlunDhezkNrl7kEmCVRPmLyxkHTFWj/WDls9x8pkSZccXelwW71dBv6N1tZ6PQ==
X-Received: by 2002:aa7:cc05:0:b0:4fb:8f07:edbd with SMTP id q5-20020aa7cc05000000b004fb8f07edbdmr10358380edt.10.1679846071248;
        Sun, 26 Mar 2023 08:54:31 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/6] dt-bindings: display: panel-simple-dsi: allow vddio variant
Date:   Sun, 26 Mar 2023 17:54:22 +0200
Message-Id: <20230326155425.91181-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few panels like Samsung s6e3fc2x01 and sofef00 use vddio-supply instead
of power-supply (in DTS and Linux driver), so allow it to fix:

  sdm845-oneplus-enchilada.dtb: panel@0: 'power-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/panel-simple-dsi.yaml       | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index 2c00813f5d20..90c04cff8281 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -19,9 +19,6 @@ description: |
 
   If the panel is more advanced a dedicated binding file is required.
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
 
   compatible:
@@ -67,12 +64,31 @@ properties:
   reset-gpios: true
   port: true
   power-supply: true
+  vddio-supply: true
+
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - samsung,s6e3fc2x01
+            - samsung,sofef00
+    then:
+      properties:
+        power-supply: false
+      required:
+        - vddio-supply
+    else:
+      properties:
+        vddio-supply: false
+      required:
+        - power-supply
 
 additionalProperties: false
 
 required:
   - compatible
-  - power-supply
   - reg
 
 examples:
-- 
2.34.1

