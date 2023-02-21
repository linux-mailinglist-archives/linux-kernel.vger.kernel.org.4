Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E420D69E397
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjBUPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjBUPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:37:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36832A9B7;
        Tue, 21 Feb 2023 07:37:47 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CDB4166021CE;
        Tue, 21 Feb 2023 15:37:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676993866;
        bh=dYSlQLXMyB6AD5hy1+lsca8EHSPk5mj7QuNmBK+ZBoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fruQtiaCFMTjf65J3alfeo62CbcoagqQqYvW554EK9LoXS9Jq6sdepSifhbe9eSCT
         IAXo3KLtInJZRV1NQWbBeXKRWC0mWHT07qmVMNNv6WYiU4A7yrnesuAIc6oOhgmPM6
         SbHmDPIjvKdhhEBGdJR3G35/PACkTxb/MnHm8twuGJhNia6fdirTD/65IEd3kcVju9
         SxUTm+McN27gp5Z6FKgX9+DY+S6ra/n7qrN3gKTOZwWD9GNyTEObNyl/VRwK2VSDCy
         O7VDCYayuQXWe/ABLKOnd3dhnuiYB/IR4RsdrNAYvLgGNOxXPYN/P6PqpKBPVvlInt
         R6TyvdcMlrwzg==
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
Subject: [PATCH v2 02/10] dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains variation
Date:   Tue, 21 Feb 2023 16:37:32 +0100
Message-Id: <20230221153740.1620529-3-angelogioacchino.delregno@collabora.com>
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

In preparation for adding new bindings for new MediaTek SoCs, split out
the power-domain-names and power-domainsvariation from the `else` in
the current mediatek,mt8183-mali conditional.

The sram-supply part is left in place to be disallowed for anything
that is not compatible with "mediatek,mt8183-mali" as this regulator
is MediaTek-specific and it is, and will ever be, used only for this
specific string due to the addition of the mediatek-regulator-coupler
driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 02699d389be1..ac174c17e25f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -145,6 +145,18 @@ allOf:
         - power-domains
         - resets
         - reset-names
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - mediatek,mt8183-mali
+    then:
+      properties:
+        power-domains:
+          maxItems: 1
+        power-domain-names: false
   - if:
       properties:
         compatible:
@@ -166,9 +178,6 @@ allOf:
         - power-domain-names
     else:
       properties:
-        power-domains:
-          maxItems: 1
-        power-domain-names: false
         sram-supply: false
   - if:
       properties:
-- 
2.39.2

