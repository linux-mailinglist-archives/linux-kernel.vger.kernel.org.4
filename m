Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1F736059
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjFTAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjFTAEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:04:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF87DE60;
        Mon, 19 Jun 2023 17:04:10 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1483E6605992;
        Tue, 20 Jun 2023 01:04:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687219449;
        bh=huc4PCyi2wohDcBEAt/Zmelm5/+bM8JEir6rTSmhk94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrb8e9Zq/JK4DTXUleA0EF6LIMnSoHA16pBv694k0kb4kALUEU3Z8GY/eD3e9KIKX
         C1BTIl3SJ0O8YHwE3KCZkRdL0vjRLrTTKxC46qntc4s0uZL9oyJdfYDOq1l5/6l1gu
         UZhHJaBtkdogV/6rLphp4LQEBcQmpo7jsv8mRjE7+FuKg98+lH/vf0P2SA/bWzci7+
         rolgPLlxl/75fyAnjUiRVJMF0zt5h4XbHqI6TdspyrLfnYtbgb9Z4Kjcdmej48akcN
         GdDDZNe/mQlQTWT0uU7AjH7a2dhMmetuLnGJ1S8lHefS8P9+wDVe4FRphJw9zfV7Lk
         SjsM+CwEssQtw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
Date:   Mon, 19 Jun 2023 20:03:36 -0400
Message-ID: <20230620000349.2122191-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620000349.2122191-1-nfraprado@collabora.com>
References: <20230620000349.2122191-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding expects the first register space to be VDEC_SYS. But on
mt8183, which uses the stateless decoders, this space is used only for
controlling clocks and resets, which are better described as separate
clock-controller and reset-controller nodes.

In fact, in mt8173's devicetree there are already such separate
clock-controller nodes, which cause duplicate addresses between the
vdecsys node and the vcodec node. But for this SoC, since the stateful
decoder code makes other uses of the VDEC_SYS register space, it's not
straightforward to remove it.

In order to avoid the same address conflict to happen on mt8183,
since the only current use of the VDEC_SYS register space in
the driver is to read the status of a hardware controlled clock, remove
the VDEC_SYS register space from the binding and describe an extra
syscon that will be used to directly check the hardware status.

Also add reg-names to be able to tell that this new register schema is
used, so the driver can keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
I dropped the tags from this commit since a syscon is now used instead
of an extra clock.

Changes in v3:
- Removed the active clock
- Added a mediatek,vdecsys syscon property

Changes in v2:
- Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
  clock for mt8183) to avoid changing number of clocks twice
- Added maxItems to reg-names
- Constrained clocks for each compatible
- Reordered properties for each compatible

 .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 1e56ece44aee..2f625c50bbfe 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -21,8 +21,13 @@ properties:
       - mediatek,mt8183-vcodec-dec
 
   reg:
+    minItems: 11
     maxItems: 12
 
+  reg-names:
+    minItems: 11
+    maxItems: 11
+
   interrupts:
     maxItems: 1
 
@@ -60,6 +65,10 @@ properties:
     description:
       Describes point to scp.
 
+  mediatek,vdecsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the vdecsys syscon node.
+
 required:
   - compatible
   - reg
@@ -79,8 +88,26 @@ allOf:
     then:
       required:
         - mediatek,scp
+        - mediatek,vdecsys
 
       properties:
+        reg:
+          maxItems: 11
+
+        reg-names:
+          items:
+            - const: misc
+            - const: ld
+            - const: top
+            - const: cm
+            - const: ad
+            - const: av
+            - const: pp
+            - const: hwd
+            - const: hwq
+            - const: hwb
+            - const: hwg
+
         clocks:
           minItems: 1
           maxItems: 1
@@ -101,6 +128,9 @@ allOf:
         - mediatek,vpu
 
       properties:
+        reg:
+          minItems: 12
+
         clocks:
           minItems: 8
           maxItems: 8
-- 
2.41.0

