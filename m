Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E136BCC88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCPKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCPKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:20:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6DB1A4A;
        Thu, 16 Mar 2023 03:20:48 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28F90660309E;
        Thu, 16 Mar 2023 10:20:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962046;
        bh=t6e55TKXpWDXs7rKf1rewUoc056XoaKTiofz8DN9RjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RynW8u0Dr4ZczODzCd2SqpQk6l0qle1QQQKYJReaYbbgC/NiBVgsx8YY/z1d86idK
         f4IQC1dpbvJM61+JNY8IKP3oQ3PpwHoBs7UUqYHCj6Hf+mpHt16S/pCwrxDVGXPCQb
         2CpXPfrQWFani4dmmdV1QUymIn8bWPeUP6lXbkml5nQ+M2RQaejKmWT8827i8yhght
         mM5Rc3MYdRtOp7i5UkB5BO7y3t40z1vH9I7tV5N3MeYSICkOyFEoBOcu1ZgiYofuTo
         0K53H3tkpCB5WHdMIl6yQ8txBdOSaapyxAbhB24sRX3Q9svQ2dhqp7TneaTHHTbDLC
         oCABAxTCASlUQ==
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
Subject: [PATCH v5 01/12] dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains variation
Date:   Thu, 16 Mar 2023 11:20:30 +0100
Message-Id: <20230316102041.210269-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
References: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

