Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A46722C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbjFEQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjFEQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:21:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BC94;
        Mon,  5 Jun 2023 09:21:26 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51F236605840;
        Mon,  5 Jun 2023 17:21:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685982085;
        bh=ATz/rOCQK/30QpZGojesEllhUcbCxgG6yCEU3vGr3XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUdKxlsBSpoteFxUFwz5M/rh+iK0lAMHfnQTu9vVSa4MmYwD6UIW5J5kdH0UOcKgV
         mvA2puSQ0KrQXzt5QqpYefEbBoCXtb7uDrINRj04CEaAhKMbAK4x0APzlEQosIthFO
         IkPpQg0xlMHsty2D/qCp/RiT2TMETjYZx9Xq0DZvTVvHpSQqV84kGen81Pi12dowNW
         3aSyP8DCPv+l6yFbb8F3jEjQRw7SxSoKxS8LxvtqBZSf2E5QoLf1mdmh0RkdgQqhSj
         j7iiRiozlSOjqzgGAaG584JoRxZWKDfvigsFB1RJtxqomAXNWlxf0A03GYRo5I7Asd
         rhlHlpNqKK3ng==
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
Subject: [PATCH 1/6] media: dt-bindings: mediatek,vcodec: Allow single clock for mt8183
Date:   Mon,  5 Jun 2023 12:20:25 -0400
Message-Id: <20230605162030.274395-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605162030.274395-1-nfraprado@collabora.com>
References: <20230605162030.274395-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8173 and MT8183 have different clocks, and consequently clock-names.
Relax the number of clocks and set clock-names based on compatible.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../media/mediatek,vcodec-decoder.yaml        | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index fad59b486d5d..57d5ca776df0 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -27,18 +27,12 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
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
+    minItems: 1
+    maxItems: 8
 
   assigned-clocks: true
 
@@ -88,6 +82,11 @@ allOf:
       required:
         - mediatek,scp
 
+      properties:
+        clock-names:
+          items:
+            - const: vdec
+
   - if:
       properties:
         compatible:
@@ -99,6 +98,18 @@ allOf:
       required:
         - mediatek,vpu
 
+      properties:
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
2.40.1

