Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2C68045F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3Dd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjA3DdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:33:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044181C336;
        Sun, 29 Jan 2023 19:33:17 -0800 (PST)
X-UUID: d291d010a04e11eda06fc9ecc4dadd91-20230130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3Ung9oFBm33rXOG7FFhNcYNioi3ccW9m3+5fbEJMqX0=;
        b=oSZ6y/ADErueq2lxe2wqgnOpoWh1kmTwu+1DvI+r0EydCZVSFzANq3vhRrlsK97qgRM6pZxFB2CYmI1KcDqRMszqHjvJ/cSpUpyfp2TsNV60eIK5JQ3+3sY6zpiqkahW6VqkQWm/pSvL/fHqDc1qPsa0fDKIebtQpmHdP6UgBgA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:f7fdc806-bf8d-4786-a0bd-3064080b8b31,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.18,REQID:f7fdc806-bf8d-4786-a0bd-3064080b8b31,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:3ca2d6b,CLOUDID:a633b355-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230130113313494307RR,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: d291d010a04e11eda06fc9ecc4dadd91-20230130
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1179411382; Mon, 30 Jan 2023 11:33:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 30 Jan 2023 11:33:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 30 Jan 2023 11:33:10 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yunfei.dong@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 4/6] media: dt-bindings: media: mediatek: vcodec: adapt to the 'clock-names' of different platforms
Date:   Mon, 30 Jan 2023 11:33:03 +0800
Message-ID: <20230130033305.31830-5-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
References: <20230130033305.31830-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

mt8195 and mt8192 have different clock numbers, separate 'clock-names'
according to compatible name.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index 7efc70ae4406..51c0ff7baa52 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -110,15 +110,12 @@ patternProperties:
           Refer to bindings/iommu/mediatek,iommu.yaml.
 
       clocks:
+        minItems: 4
         maxItems: 5
 
       clock-names:
-        items:
-          - const: sel
-          - const: soc-vdec
-          - const: soc-lat
-          - const: vdec
-          - const: top
+        minItems: 4
+        maxItems: 5
 
       assigned-clocks:
         maxItems: 1
@@ -160,6 +157,38 @@ then:
   required:
     - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8192-vcodec-dec
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sel
+            - const: soc-vdec
+            - const: soc-lat
+            - const: vdec
+            - const: top
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-vcodec-dec
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sel
+            - const: vdec
+            - const: lat
+            - const: top
+
 additionalProperties: false
 
 examples:
-- 
2.18.0

