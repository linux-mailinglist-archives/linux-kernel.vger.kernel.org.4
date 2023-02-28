Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCD6A5698
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjB1K1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjB1K1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:27:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1287F29E30;
        Tue, 28 Feb 2023 02:27:11 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31DF46602F90;
        Tue, 28 Feb 2023 10:27:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677580029;
        bh=g3NFpJH4/03P+ic0BhIheOKxhuMMGL+BE+w/2aTRtIY=;
        h=From:To:Cc:Subject:Date:From;
        b=LA/b4pGc1pYewDwhPssPa64PjNlqjxa1iWFAH07T1+oVAmCIJpmHfi2DrgrlXbnLO
         m1Anv6hn3Fyb3U8XwyXAKrN46v85PD2nrrUSg7sTLnvlwbCt5CWyPKV7TbLw6krpjI
         6SuFxwHXemINV4Swuufmdx1Mj29/0zebztcOBizo93nt1I1jhZW+jB3O981Ko1Cjyy
         Z341bJKmyJUQ1I70Ofj/WLt9GsCMMDuh/lZHKayubYicQ30TA0Shz5moJLDEAmWglp
         pQAWHnK9yBUxgIrNBpgDgqg8agXKBviPVnvO78eez7ZbkbOCO4AeMoryvyhSQP5YIH
         DJmeqg3wSBXow==
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
Subject: [PATCH v4 01/12] dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains variation
Date:   Tue, 28 Feb 2023 11:26:53 +0100
Message-Id: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
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

In preparation for adding new bindings for new MediaTek SoCs, split out
the power-domains variation from the `else` in the current
mediatek,mt8183-mali conditional.

The sram-supply part is left in place to be disallowed for anything
that is not compatible with "mediatek,mt8183-mali" as this regulator
is MediaTek-specific and it is, and will ever be, used only for this
specific string due to the addition of the mediatek-regulator-coupler
driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml        | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 78964c140b46..7e110751353e 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -109,6 +109,9 @@ allOf:
           contains:
             const: amlogic,meson-g12a-mali
     then:
+      properties:
+        power-domains:
+          maxItems: 1
       required:
         - resets
   - if:
@@ -131,6 +134,8 @@ allOf:
             - const: gpu
             - const: bus
             - const: bus_ace
+        power-domains:
+          maxItems: 1
         resets:
           minItems: 3
         reset-names:
@@ -164,8 +169,6 @@ allOf:
         - power-domain-names
     else:
       properties:
-        power-domains:
-          maxItems: 1
         sram-supply: false
   - if:
       properties:
@@ -180,6 +183,8 @@ allOf:
           items:
             - const: gpu
             - const: bus
+        power-domains:
+          maxItems: 1
       required:
         - clock-names
 
-- 
2.39.2

