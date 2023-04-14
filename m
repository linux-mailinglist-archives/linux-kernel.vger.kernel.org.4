Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476656E2127
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNKmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:42:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82D95
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:42:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50672fbf83eso5736843a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681468954; x=1684060954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlR+xSiTjnc2SLlMey8CvdA1HO2rDpDlXaNoW69NFc0=;
        b=zmUd3JoFz7Tv3Vx3luqjYIZjlQtlyaeuFd+OzfpBA9c7rp/ziS2FdfeDuPsrYQtq1z
         kq7caNrwLhd08UehIxFjfRrljBj/baEVLCQ+rGlTPY6NVq/av0qfmCMvwmfVjG/Y534t
         yHl6IlLtsqJstYTzc+fFCm9T1g1/UUQF9HVIXIISfAmYYW1GZl8TcwC1YRMWetZypgkI
         qlztK+3VOTDeTrrV2/XpUuHrxhkgt7nC95w6p1w/0dn2OOrPBo8UBkjeW0y5ZgH0b37L
         P+8GAmEl/DSEHevlWAY3lMSLpPVIZEDp0MUMCpaS+XK6JdORsDpYQWrMLuUkTEFnCe/T
         dr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468954; x=1684060954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlR+xSiTjnc2SLlMey8CvdA1HO2rDpDlXaNoW69NFc0=;
        b=hdjkUiqshn13sq8+xh99j7FMNaUe5hDBtSaS0PMNWPCuPUCr/FczmbhBFJ+o7ShsUO
         7zsRv8Vn9FzfvfRP2QhEl1sL7/IPGQGuU0mxU4itu3yXCszeLVyE1YcIKt+Q1cYUUGdp
         Bjy5jKe/z3q8tUnyjLNKx9Fo5o5fcEGDTUwOv/kn/wX12/9u9HV/uQEj10NTvuIeJXRn
         06AuQClW8oA4FtUhnwAoFoBLrahj5WNjxXkaGEqhPdu7fuzLpkdw8FHdxSaH+9+1wv9y
         t/PY86Xu1ZnybGZT9TMhBRzgMGSpP/zt6KijHsj0svRS1Mbvm0qrSzVHyJev8aEd+FMc
         lltw==
X-Gm-Message-State: AAQBX9fEfIT30b8X5F3gJF+o/UhI0j+nJJL9aGe0szxlBbXdeeHBgx37
        vjCuq4MlS8XQWCXE3BizNN/OEw==
X-Google-Smtp-Source: AKy350a8p/Dm34e6FTIrwnmd/FYPe6DCZ5aMSRnZbXAhFybe2SHbqsToCcm2MWHCebPZJuVwNc96pw==
X-Received: by 2002:a05:6402:114e:b0:504:9e79:e86f with SMTP id g14-20020a056402114e00b005049e79e86fmr5349108edw.18.1681468953929;
        Fri, 14 Apr 2023 03:42:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7d358000000b00504706aa54esm1966447edr.57.2023.04.14.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:42:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        Thierry Reding <treding@nvidia.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: simplify compatibles syntax
Date:   Fri, 14 Apr 2023 12:42:30 +0200
Message-Id: <20230414104230.23165-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lists (items) with one item should be just const or enum because it is
shorter and simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rebased on next-20230406. I hope it applies cleanly...
---
 .../display/bridge/analogix,anx7625.yaml      |  3 +--
 .../display/panel/sharp,lq101r1sx01.yaml      |  4 ++--
 .../bindings/display/solomon,ssd1307fb.yaml   | 24 +++++++++----------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 7960745a8dbe..a1ed1004651b 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -16,8 +16,7 @@ description: |
 
 properties:
   compatible:
-    items:
-      - const: analogix,anx7625
+    const: analogix,anx7625
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
index 9ec0e8aae4c6..57b44a0e763d 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -34,8 +34,8 @@ properties:
       - items:
           - const: sharp,lq101r1sx03
           - const: sharp,lq101r1sx01
-      - items:
-          - const: sharp,lq101r1sx01
+      - enum:
+          - sharp,lq101r1sx01
 
   reg: true
   power-supply: true
diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 8bd58913804a..94bb5ef567c6 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -14,20 +14,18 @@ properties:
   compatible:
     oneOf:
       # Deprecated compatible strings
-      - items:
-          - enum:
-              - solomon,ssd1305fb-i2c
-              - solomon,ssd1306fb-i2c
-              - solomon,ssd1307fb-i2c
-              - solomon,ssd1309fb-i2c
+      - enum:
+          - solomon,ssd1305fb-i2c
+          - solomon,ssd1306fb-i2c
+          - solomon,ssd1307fb-i2c
+          - solomon,ssd1309fb-i2c
         deprecated: true
-      - items:
-          - enum:
-              - sinowealth,sh1106
-              - solomon,ssd1305
-              - solomon,ssd1306
-              - solomon,ssd1307
-              - solomon,ssd1309
+      - enum:
+          - sinowealth,sh1106
+          - solomon,ssd1305
+          - solomon,ssd1306
+          - solomon,ssd1307
+          - solomon,ssd1309
 
   reg:
     maxItems: 1
-- 
2.34.1

