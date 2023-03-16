Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5106BCC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCPKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCPKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:21:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3206BDD00;
        Thu, 16 Mar 2023 03:20:52 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD3D966030A1;
        Thu, 16 Mar 2023 10:20:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962049;
        bh=cvXpJ8LbxubJEtHvxk8Psw3/s85Oor+YdZdxHV1BvnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaRZ4u7T2R2eNSV5sEw9n2rokz8EIIh9g3ilN7C700K2R+bZ50POfJlz9WcqMNubk
         7Km6JlWLgGcL7zZ13CMx4wVWRvFC+3vpXiXrW8e1Jo4i6nGcMsq0bsvUwBIeFlgOP9
         pkMZSKHhW7xd0q7M1kJg8kJEqyVmhJ3ZZqlK+hdJnIbcx7gUT8RQisOeaCpBUTLzqt
         V0pFeyDva4lz2iqPUO9UDjOGZLZ0MHS85N+mnaDDtYh91CYuM5saXaaKynjHhZ3hSm
         ODxHBVVJIX76MhqWsS0pU+QVQS5q+Y1hysd2KmHVfcGfK+Ql+GB+kHCYOGOLzJ/ffp
         9rLDEFBU0wAsQ==
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
Subject: [PATCH v5 04/12] dt-bindings: gpu: mali-bifrost: Add sub-schema for MT8192's power domains
Date:   Thu, 16 Mar 2023 11:20:33 +0100
Message-Id: <20230316102041.210269-5-angelogioacchino.delregno@collabora.com>
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

MediaTek MT8192 (and similar) needs five power domains for the
Mali GPU and no sram-supply: change the binding to allow so by
also introducing power-domain-names in the generic binding;
while at it, also disallow the newly introduced power-domain-names
for all non-MediaTek bindings.

Fixes: 5d82e74a97c2 ("dt-bindings: Add compatible for Mali Valhall (JM)")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 7c61524aae26..9ede51427012 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -177,6 +177,25 @@ allOf:
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

