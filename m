Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EFF668BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjAMFop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjAMFnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:43:14 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C31687BA;
        Thu, 12 Jan 2023 21:43:13 -0800 (PST)
X-UUID: 27c21c2c930511eda06fc9ecc4dadd91-20230113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xMKQs0iaxWchhcj+xlpojqq6qDjBdKU+MZPCQE4PFNE=;
        b=jHInxI1cAkzFKQdi34a/9O9aJqJeeUWr6Kuzxdv7+WWdWqCw6z37z+EX8ZA5fNXxeKL/QwB8P0r/vU9Hb0AVR8vBODE9YhdQT/3o7DX0tD5BkXsMCdRioduaUtLw7XNpjS58vCnwyNN0VDsGxe/Geiw9BV4mSOkJbPzPkUCPKvI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:71c4666f-6c1d-4334-9760-2a095277ba6b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:71c4666f-6c1d-4334-9760-2a095277ba6b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:6536b4f5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230113134309BJNLWH5D,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 27c21c2c930511eda06fc9ecc4dadd91-20230113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1910929589; Fri, 13 Jan 2023 13:43:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 13 Jan 2023 13:43:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 13 Jan 2023 13:43:05 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v5 01/10] dt-bindings: arm: mediatek: migrate MT8195 vppsys0/1 to mtk-mmsys driver
Date:   Fri, 13 Jan 2023 13:42:55 +0800
Message-ID: <20230113054304.21841-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230113054304.21841-1-moudy.ho@mediatek.com>
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
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

MT8195 vppsys0/1 should be probed from mtk-mmsys driver to
populate device by platform_device_register_data then start
its own clock driver.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index 17fcbb45d121..d62d60181147 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -28,11 +28,9 @@ properties:
           - mediatek,mt8195-imp_iic_wrap_s
           - mediatek,mt8195-imp_iic_wrap_w
           - mediatek,mt8195-mfgcfg
-          - mediatek,mt8195-vppsys0
           - mediatek,mt8195-wpesys
           - mediatek,mt8195-wpesys_vpp0
           - mediatek,mt8195-wpesys_vpp1
-          - mediatek,mt8195-vppsys1
           - mediatek,mt8195-imgsys
           - mediatek,mt8195-imgsys1_dip_top
           - mediatek,mt8195-imgsys1_dip_nr
@@ -92,13 +90,6 @@ examples:
         #clock-cells = <1>;
     };
 
-  - |
-    vppsys0: clock-controller@14000000 {
-        compatible = "mediatek,mt8195-vppsys0";
-        reg = <0x14000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
   - |
     wpesys: clock-controller@14e00000 {
         compatible = "mediatek,mt8195-wpesys";
@@ -120,13 +111,6 @@ examples:
         #clock-cells = <1>;
     };
 
-  - |
-    vppsys1: clock-controller@14f00000 {
-        compatible = "mediatek,mt8195-vppsys1";
-        reg = <0x14f00000 0x1000>;
-        #clock-cells = <1>;
-    };
-
   - |
     imgsys: clock-controller@15000000 {
         compatible = "mediatek,mt8195-imgsys";
-- 
2.18.0

