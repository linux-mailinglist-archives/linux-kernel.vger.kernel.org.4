Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79284722C65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjFEQVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjFEQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:21:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B131EA;
        Mon,  5 Jun 2023 09:21:32 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB2896606E8F;
        Mon,  5 Jun 2023 17:21:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685982091;
        bh=FBxkyNk+wH42mt6PnhdzeId5YI52PJ33/87A7v+PAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WjIsU6PBPQljs3cQ78Cgl3WM66ZSuCLbOq5VIHZioKLnkOeABvFutQ6grd6TD3vk6
         xwjYiWrpsAji/CfOAUSGybbUcMMOXplj4rqdJ8sfCb6ffrbnirCMI4MerrgFD5jKjw
         R6GPE3W/yPlYSYJhRtYvny8+cT/IM43tkOB7k/mbchRqjvZbU6fniXBFC2XIwEhrHE
         2xGvvoWP/OfQ38BUzu45bjim1SUxYND4Ka1yH7NRYhoFlKsjwZ+N0c7iHMES046Aj+
         jWOHzBtjIcCfJkrOBXTCJg/plkgykkiy98zFO2JDGnocRCaCYWozJwBeyI8FxUjZCQ
         294Sym1jSsP5Q==
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
Subject: [PATCH 3/6] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS for mt8183
Date:   Mon,  5 Jun 2023 12:20:27 -0400
Message-Id: <20230605162030.274395-4-nfraprado@collabora.com>
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

Also add reg-names to be able to tell that this new register schema is
used, so the driver can keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../media/mediatek,vcodec-decoder.yaml        | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 6447e6c86f29..36a53b2484d6 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -21,17 +21,21 @@ properties:
       - mediatek,mt8183-vcodec-dec
 
   reg:
+    minItems: 11
     maxItems: 12
 
+  reg-names:
+    minItems: 11
+
   interrupts:
     maxItems: 1
 
   clocks:
-    minItems: 1
+    minItems: 2
     maxItems: 8
 
   clock-names:
-    minItems: 1
+    minItems: 2
     maxItems: 8
 
   assigned-clocks: true
@@ -84,6 +88,24 @@ allOf:
         clock-names:
           items:
             - const: vdec
+            - const: active
+
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
 
   - if:
       properties:
@@ -108,6 +130,9 @@ allOf:
             - const: venc_lt_sel
             - const: vdec_bus_clk_src
 
+        reg:
+          minItems: 12
+
 additionalProperties: false
 
 examples:
-- 
2.40.1

