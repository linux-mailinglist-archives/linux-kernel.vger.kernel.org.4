Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB97743E69
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjF3PPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF3PPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:15:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCF273B;
        Fri, 30 Jun 2023 08:14:58 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB8CA6606E8F;
        Fri, 30 Jun 2023 16:14:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688138097;
        bh=oehAssFz6HAeQ18vLi/DNl45rJUtL7SfPUb+CugYsgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjenjVT8x02X5Wo0J0gQVKMdrn7KPbNZe5TdqpzE8N9uSXVuzSAo7RdtVWKEdodv5
         AxBF3Y/aaaOyE3H98BxTwiDOlsgXv87xs11HUGNfF2KQnoz0fiOAJZcbR4IU0uVLal
         MYdfmjNfl1QjllztRWsS1GMwuQhR81paUtgQoaE+s+w8GL+OntScy2ejXhLx8ZziT0
         q7uhxdBOFsF8g0DHAhfX42r4LSFIHU28AlG+vGMMAHJEi1Nbhu3Md21HGK1/fPSwQz
         /WOQKJpalRNTHdOeO1dMbONIwLy6o2cRyNN8I7owOYtSLb9CzQ0mzZ0canXGp59VmS
         ofdrcY4X7CnAg==
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
Subject: [PATCH v5 3/7] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS register space
Date:   Fri, 30 Jun 2023 11:14:09 -0400
Message-ID: <20230630151436.155586-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630151436.155586-1-nfraprado@collabora.com>
References: <20230630151436.155586-1-nfraprado@collabora.com>
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

The binding expects the first register space to be VDEC_SYS. However
this register space is already assigned to a different node on both
MT8173 and MT8183: a clock-controller node called 'vdecsys' which is
also a syscon.

In order to resolve the overlapping address ranges, remove the VDEC_SYS
register space from the video decoder, and add a new property to hold
the phandle to the syscon, so that iospace can still be handled.

Also add reg-names to be able to tell that this new register schema is
used, so the driver can keep backward compatibility.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v4)

Changes in v4:
- Removed VDEC_SYS reg from mt8173 as well
- Reworded commit

Changes in v3:
- Removed the active clock
- Added a mediatek,vdecsys syscon property

Changes in v2:
- Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
  clock for mt8183) to avoid changing number of clocks twice
- Added maxItems to reg-names
- Constrained clocks for each compatible
- Reordered properties for each compatible

 .../media/mediatek,vcodec-decoder.yaml        | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 1e56ece44aee..b401c67e3ba0 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -21,7 +21,22 @@ properties:
       - mediatek,mt8183-vcodec-dec
 
   reg:
-    maxItems: 12
+    minItems: 11
+    maxItems: 11
+
+  reg-names:
+    items:
+      - const: misc
+      - const: ld
+      - const: top
+      - const: cm
+      - const: ad
+      - const: av
+      - const: pp
+      - const: hwd
+      - const: hwq
+      - const: hwb
+      - const: hwg
 
   interrupts:
     maxItems: 1
@@ -60,6 +75,10 @@ properties:
     description:
       Describes point to scp.
 
+  mediatek,vdecsys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the vdecsys syscon node.
+
 required:
   - compatible
   - reg
@@ -67,6 +86,7 @@ required:
   - clocks
   - clock-names
   - iommus
+  - mediatek,vdecsys
 
 allOf:
   - if:
@@ -126,10 +146,9 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/power/mt8173-power.h>
 
-    vcodec_dec: vcodec@16000000 {
+    vcodec_dec: vcodec@16020000 {
       compatible = "mediatek,mt8173-vcodec-dec";
-      reg = <0x16000000 0x100>,   /*VDEC_SYS*/
-          <0x16020000 0x1000>,  /*VDEC_MISC*/
+      reg = <0x16020000 0x1000>,  /*VDEC_MISC*/
           <0x16021000 0x800>,   /*VDEC_LD*/
           <0x16021800 0x800>,   /*VDEC_TOP*/
           <0x16022000 0x1000>,  /*VDEC_CM*/
@@ -150,6 +169,7 @@ examples:
              <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
              <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
       mediatek,vpu = <&vpu>;
+      mediatek,vdecsys = <&vdecsys>;
       power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
       clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
              <&topckgen CLK_TOP_UNIVPLL_D2>,
-- 
2.41.0

