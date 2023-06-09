Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA0729C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbjFIOIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjFIOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:08:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265335B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:08:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97467e06511so309595366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319660; x=1688911660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PM1+SjJYojGEjAWqB7qXG+oGVKE+NT1y/yCIj8gw4kI=;
        b=B9bzP8KHaUay+nKM3UhpdU30byyDgOxqktPySg+JSTCL4C1fZ+33YCdhu1sXZfo2q8
         PHYAh1+j7wG6yyNYIqXywA565XlxqP4TO4W+JcvSZ6J8tM/+4JYBdHvFhOLpLyZPWdI+
         DJSp8dc1v3Y3xYhotel4J51+o5THfjoq+fHuVk8byexhvxcWi+Iz5TuO2ycLQqZL2ZPy
         u2xwzdylMjLRNDfel+LvyEMWQLqYA2A8F19ldiAAEGpRnIN+pFVwC0SmuQSONhQztcmm
         bp5C3yRKqObjut5cQlnGsQ/hQhkR+RCWVuOzKnX4UCQu1aXKUHnkT/AViRbMrSutxo2L
         A90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319660; x=1688911660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM1+SjJYojGEjAWqB7qXG+oGVKE+NT1y/yCIj8gw4kI=;
        b=DkHp3E4ErxdUB+kIVakOkoUdpr9D2sr38gD2aoGkCbW8oq/32JjgxYGIVgyq4/dhAj
         SWaGW62QVdctXE5/hO+A32gYRUqLr2Y+kSBybp+1A6VRWMg0vFcw1zRxsFr9GI8QajE1
         eeqf8BJBGPagLEVhaNPc5YGTVANnGx2nP8+5py++a15PLrEdLTxa5x2Potsj+vE9H97n
         s5AItZ1Nwp+4JREye3WyTRJZB36jYqKmmfki7UJUIaXm4ATeW8dxGWdqg9tAhHohR/+6
         zxG/z/KiQ6WiJ0BGwZXUQgt6by7RYn04/7XF4N7SH5u19EUcwmsnkXIPl0SHkrdGV9Qz
         1TOg==
X-Gm-Message-State: AC+VfDxm4bc29n7DJQdkLXaIrUUPENRXn2M99EYvxDXr5Pr0ZG6RX+qD
        vMp8rPxkVRXKi1Wm7sC5YtWmVg==
X-Google-Smtp-Source: ACHHUZ4rZbL6GyNl0wF0oxUXCCTFkxuMP5kmQvcmb210bJV7Mbm05+0wKT84SKIN6RigtsrymRZfPg==
X-Received: by 2002:a17:907:980d:b0:969:e9ec:9a0 with SMTP id ji13-20020a170907980d00b00969e9ec09a0mr1874567ejc.77.1686319659931;
        Fri, 09 Jun 2023 07:07:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906471500b00974564fa7easm1370518ejq.5.2023.06.09.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:07:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: gpu: drop unneeded quotes
Date:   Fri,  9 Jun 2023 16:07:38 +0200
Message-Id: <20230609140738.64958-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 +-
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 0400a361875d..e796a1ff8c82 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -86,7 +86,7 @@ properties:
     const: 2
 
   dynamic-power-coefficient:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       A u32 value that represents the running time dynamic
       power coefficient in units of uW/MHz/V^2. The
diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 2a25384ca3ef..ca02baba5526 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -92,7 +92,7 @@ properties:
   dma-coherent: true
 
   dynamic-power-coefficient:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       A u32 value that represents the running time dynamic
       power coefficient in units of uW/MHz/V^2. The
-- 
2.34.1

