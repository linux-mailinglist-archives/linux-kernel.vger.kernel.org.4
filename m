Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFF6BCC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCPKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCPKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:21:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14386BD4FD;
        Thu, 16 Mar 2023 03:20:50 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E845C66030A0;
        Thu, 16 Mar 2023 10:20:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962048;
        bh=vym02gfUeFtMkZA43yUlFdqpHJiV8QIzeChJfzjI5R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpuX2RQEQblFvVlA7uJOEnSjVUFXexzWEE/YHcNPmudmm7wBcVbhDyeCcz0HytihH
         QYyQvyV1KUPfBuFYVRXjYBWitRc1/PDQVEoJ3NwwBdlagUZLljRznoSR9VBltb115K
         sSIb8uAvevtYftC68I6ie/HvBHpjGLp3GDzeN7VwZC6QKZwBs4Tt7akIlqvaMdGgYg
         9wUqlcy4JrZGu5PCvcsn45YWj80jUHqUoSXEnH5CVmUYUyB+TJ0mXOdlNvGbaRPTqq
         i442BMbVucu3fEyfzp45+wMpBVdKbUA54NgVaZfU3/d60oaM7ykeJnezgsvJAa97lk
         5ZmtnXLNoHEhA==
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
Subject: [PATCH v5 03/12] dt-bindings: gpu: mali-bifrost: Fix power-domain-names validation
Date:   Thu, 16 Mar 2023 11:20:32 +0100
Message-Id: <20230316102041.210269-4-angelogioacchino.delregno@collabora.com>
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

Commit ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
incorrectly introduced power domain names for MT8183, causing
validation issues.

Add power-domain-names to the base schema, allowing a maximum of
five elements; since platforms having a single power domain don't
need any actual domain name, disallow that for each sub-schema.

Fixes: a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 5b7f1c9d2b30..7c61524aae26 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -65,6 +65,10 @@ properties:
     minItems: 1
     maxItems: 5
 
+  power-domain-names:
+    minItems: 2
+    maxItems: 5
+
   resets:
     minItems: 1
     maxItems: 3
@@ -112,6 +116,7 @@ allOf:
       properties:
         power-domains:
           maxItems: 1
+        power-domain-names: false
       required:
         - resets
   - if:
@@ -136,6 +141,7 @@ allOf:
             - const: bus_ace
         power-domains:
           maxItems: 1
+        power-domain-names: false
         resets:
           minItems: 3
         reset-names:
@@ -186,6 +192,7 @@ allOf:
             - const: bus
         power-domains:
           maxItems: 1
+        power-domain-names: false
       required:
         - clock-names
 
-- 
2.39.2

