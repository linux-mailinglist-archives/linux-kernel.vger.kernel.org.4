Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EEF69E39B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjBUPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjBUPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:37:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183010C5;
        Tue, 21 Feb 2023 07:37:48 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B411566021D0;
        Tue, 21 Feb 2023 15:37:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676993867;
        bh=JLv1ypqmRwA4sZAh0v4tJj4CqhA/6gB3AMkCmc8wtN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRERP9lHxptyHbkUIZZpTJEqOpnNczybSXcyIV2hS8lxN1Xf3IbrOuPaPNYKST+ZN
         Fz5zFhdeoF6ZzKr8f0ZsVa5aoa63K7JcIZCAfSjclssml45FkFuiK/miXMO46sUTwv
         rZLajVOGcKKAZf7CR2I86/6OTqe74T2xWUg2wjULhETlbTdPH8WvNX97XqxLUjC7Jm
         Vpxx7rw5rxf6QFFGSrlVCQ6qP7PfNW6Qc/UY8qGR6hU+cdPyRUMtxqqWcWx5llNodm
         gKq02ZgAYkvQEL4I6wFUv6qC2CmQrzstTzSWYBRIGibzsZlJh1HORevo5JzmS4Lo4A
         iNwNkr5vSAYtg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 03/10] dt-bindings: gpu: mali-bifrost: Allow up to 5 power domains for MT8192
Date:   Tue, 21 Feb 2023 16:37:33 +0100
Message-Id: <20230221153740.1620529-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
References: <20230221153740.1620529-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek MT8192 (and similar) needs five power domains for the
Mali GPU and no sram-supply: change the binding to allow so.

Fixes: 5d82e74a97c2 ("dt-bindings: Add compatible for Mali Valhall (JM)")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index ac174c17e25f..65fe139ceb83 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -63,7 +63,7 @@ properties:
 
   power-domains:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   power-domain-names: true
 
@@ -152,6 +152,7 @@ allOf:
             contains:
               enum:
                 - mediatek,mt8183-mali
+                - mediatek,mt8192-mali
     then:
       properties:
         power-domains:
@@ -179,6 +180,25 @@ allOf:
     else:
       properties:
         sram-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8192-mali
+    then:
+      properties:
+        power-domains:
+          minItems: 5
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+            - const: core3
+            - const: core4
+      required:
+        - power-domains
+        - power-domain-names
   - if:
       properties:
         compatible:
-- 
2.39.2

