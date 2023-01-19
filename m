Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35306739AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjASNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjASNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:12:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908583
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:10:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b7so1822026wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blNpZwh2SZlig8QQ/nC77W3/O0N7mDjpaqH8VDOv2eU=;
        b=DzFy88bDZoVlfwhHlTp6yaa4pDvXz2S+rRv+4hM9hJnwR6Pea0ryUtzFRVDKTcUUsl
         M4WGeBQ4f5np3UXyL67X+o7x7P/J5qmVp0R5lkDakCtZEQtlusfYKHLxzghATAV4nd0a
         z98YCC83E6ttozJrFFjGynwEZszZmhKvl9UoIjEdSD7XkJiDRHgQRbis6wO6FxJADvfK
         cktGAaPSDhZo4THEOHj8dKlw+WulH7V4oQJ2on2nX0h1OfkOosTQ7XIRanih5OYRUAxK
         ltD8viS7fmAMLiiNqe9YAR8H52ZHuJTSCfhfO8zLeGpcQBwvgn9pof+aob41Ehwdclxf
         BgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blNpZwh2SZlig8QQ/nC77W3/O0N7mDjpaqH8VDOv2eU=;
        b=hJTxVZFVoM8o2bhfibPcKA6VIyOOH9aNgUwSnbPL41hfEifqikDpHEcYwqL8QXbsvk
         oWRTUDELtqI7jQj9X4wFtEDfQTejmzpM8mmCxCEIVL1VVfFvbyqSAMjmnz9683S72lfF
         XUm37m8UGFd0kMoR1gD+tqMZ/9QagqdbH6PN7K4TEWZw/0dCyHXW0IBo/pBQdnAhDrBg
         q+pMg1PFplBzVNx5AjuXdqT/ciFebPy5z1Zo26o4m3C8kYdimuWr6HTOlFeL24j4BnDP
         FucWPGCjoq14stD+WKKZewrHTTulozZByQ0ozWMD91fibcJXoHfTYpy76HZQHrdcIdcy
         E2Rg==
X-Gm-Message-State: AFqh2koAKHeVwWx/p6YSEXZxcwhgqZaY4xyxGJU5EcV5NMHJFBjZUTRQ
        wD1JLOp6mFZvU5z0neeNKIap0A==
X-Google-Smtp-Source: AMrXdXvrY6LK2dvL+iGhjr8puYL3YHweG43wf3Hfc7anlN9+EMnZ5/F6pOfVqjpVCAvI/2eVrdRgvw==
X-Received: by 2002:a05:6000:1816:b0:2bd:fe5a:b579 with SMTP id m22-20020a056000181600b002bdfe5ab579mr8424345wrh.70.1674133837495;
        Thu, 19 Jan 2023 05:10:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b002755e301eeasm15881791wrt.100.2023.01.19.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:10:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: drop type for operating-points-v2
Date:   Thu, 19 Jan 2023 14:10:33 +0100
Message-Id: <20230119131033.117324-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The type for operating-points-v2 property is coming from dtschema
(/schemas/opp/opp.yaml), so individual bindings can just use simple
"true".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on my pull request, at least logically:
https://github.com/devicetree-org/dt-schema/pull/95

Patch could be applied in parallel but only if above PULL is
accepted/correct.
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml  | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml  | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml | 3 +--
 .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml  | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml  | 3 +--
 .../devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml   | 3 +--
 .../devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml          | 3 +--
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml          | 3 +--
 Documentation/devicetree/bindings/power/power-domain.yaml      | 3 ---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml  | 3 +--
 15 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 3e54956e57db..d7678fcd1710 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -71,8 +71,7 @@ properties:
     items:
       - const: dp
 
-  operating-points-v2:
-    maxItems: 1
+  operating-points-v2: true
 
   opp-table: true
 
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 6eedee503aa0..69be95afd562 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -59,8 +59,7 @@ properties:
   iommus:
     maxItems: 1
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
index 75546f250ad7..511cbe74e729 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
@@ -47,8 +47,7 @@ properties:
     items:
       - const: dsi
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
index 0d55e6206b5e..3c095a5491fe 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
@@ -46,8 +46,7 @@ properties:
   interconnect-names:
     maxItems: 4
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
index bf38accd98eb..1026b0bc3dc8 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
@@ -49,8 +49,7 @@ properties:
   interconnect-names:
     maxItems: 4
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
index 4755a73473c7..59a52e732ca3 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
@@ -51,8 +51,7 @@ properties:
     minItems: 4
     maxItems: 10
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
index 035b9f1f2eb5..f65e59cfffa7 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
@@ -50,8 +50,7 @@ properties:
     items:
       - const: hdmi
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 913ca104c871..94c5242c03b2 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -90,8 +90,7 @@ properties:
     items:
       - const: dma-mem # read
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
index 5f4f0fb4b692..2cd3e60cd0a8 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
@@ -47,8 +47,7 @@ properties:
   interconnect-names:
     maxItems: 6
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
index 467b015e5700..6c84d8b7eb7b 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
@@ -30,8 +30,7 @@ properties:
     items:
       - description: module clock
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
index 782a4b10150a..a42bf33d1e7d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
@@ -55,8 +55,7 @@ properties:
     minItems: 4
     maxItems: 5
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml
index 481901269872..02f0b0462377 100644
--- a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml
+++ b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.yaml
@@ -44,8 +44,7 @@ properties:
     items:
       - const: fuse
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
index fe0270207622..fda0b45ee577 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
@@ -82,8 +82,7 @@ properties:
   iommus:
     maxItems: 1
 
-  operating-points-v2:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  operating-points-v2: true
 
   power-domains:
     items:
diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 889091b9814f..d1235e562041 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -43,9 +43,6 @@ properties:
       domain would be considered as capable of being powered-on or powered-off.
 
   operating-points-v2:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
     description:
       Phandles to the OPP tables of power domains provided by a power domain
       provider. If the provider provides a single power domain only or all
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 739d3155dd32..41cea4979132 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -63,8 +63,7 @@ properties:
   pinctrl-1:
     description: configuration for the sleep state
 
-  operating-points-v2:
-    $ref: /schemas/types.yaml#/definitions/phandle
+  operating-points-v2: true
 
   power-domains:
     items:
-- 
2.34.1

