Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746A0726F61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjFGU56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjFGU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC142113;
        Wed,  7 Jun 2023 13:57:36 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95F0D6606F08;
        Wed,  7 Jun 2023 21:57:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686171454;
        bh=p/U679O+aC/H7H+CqRcp2tK9NBFgpymNdt1qg5tXhR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qprx3F0+l6LD4cltZLZV0ciBVQ/u2OvCFwQpiknLGaVxcKthB1EVzOCkm8Cj/5xEu
         pDGxNi2JrjK3TopSoRVL4p6LPQaDMk08urVEm8zxJcUEXR081L76orRRBwWNgMECbD
         3Z5GoVcvACdO5QARlrPqfLNYT81gCnld2oEqwqi1hXhKugJst/47ztOWDIRapFBl+w
         94LSoET34wMHWtBnMA9fzcev4RKN0A143IsJseGsL9dIjq5Y9HwGtfvrDhQkWr2RSl
         Bl5+JgQkgFRG55z8OVrikywtttnO9d0fq4RkukevUnCurLsan/XMq19nJFY1Kh0Ghf
         rsR9ybQexDRTQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v2 2/5] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
Date:   Wed,  7 Jun 2023 16:53:39 -0400
Message-ID: <20230607205714.510012-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607205714.510012-1-nfraprado@collabora.com>
References: <20230607205714.510012-1-nfraprado@collabora.com>
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
the driver is to read the status of a clock that indicates the hardware
is active, remove the VDEC_SYS register space from the binding and
describe an extra clock that will be used to directly check the hardware
status.

While adding the active clock, split the mt8183 clocks since there are
less of them than in mt8173. This is done in this same commit to avoid
changing the number of clocks twice.

Also add reg-names to be able to tell that this new register schema is
used, so the driver can keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
  clock for mt8183) to avoid changing number of clocks twice
- Added maxItems to reg-names
- Constrained clocks for each compatible
- Reordered properties for each compatible

 .../media/mediatek,vcodec-decoder.yaml        | 63 ++++++++++++++++---
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 63be42560948..2b29748b1d22 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -21,24 +21,23 @@ properties:
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
 
   clocks:
+    minItems: 2
     maxItems: 8
 
   clock-names:
-    items:
-      - const: vcodecpll
-      - const: univpll_d2
-      - const: clk_cci400_sel
-      - const: vdec_sel
-      - const: vdecpll
-      - const: vencpll
-      - const: venc_lt_sel
-      - const: vdec_bus_clk_src
+    minItems: 2
+    maxItems: 8
 
   assigned-clocks: true
 
@@ -86,6 +85,33 @@ allOf:
       required:
         - mediatek,scp
 
+      properties:
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
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: vdec
+            - const: active
+
   - if:
       properties:
         compatible:
@@ -97,6 +123,25 @@ allOf:
       required:
         - mediatek,vpu
 
+      properties:
+        reg:
+          minItems: 12
+
+        clocks:
+          minItems: 8
+          maxItems: 8
+
+        clock-names:
+          items:
+            - const: vcodecpll
+            - const: univpll_d2
+            - const: clk_cci400_sel
+            - const: vdec_sel
+            - const: vdecpll
+            - const: vencpll
+            - const: venc_lt_sel
+            - const: vdec_bus_clk_src
+
 additionalProperties: false
 
 examples:
-- 
2.41.0

