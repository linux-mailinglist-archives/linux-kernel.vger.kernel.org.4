Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF26D1FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjCaMSi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjCaMSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:18:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2CA1EFE0;
        Fri, 31 Mar 2023 05:18:31 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1654524E362;
        Fri, 31 Mar 2023 20:18:29 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 20:18:29 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 20:18:28 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v3 4/9] media: dt-bindings: cadence-csi2rx: Add resets property
Date:   Fri, 31 Mar 2023 20:18:21 +0800
Message-ID: <20230331121826.96973-5-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331121826.96973-1-jack.zhu@starfivetech.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets property for Cadence MIPI-CSI2 RX controller

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../bindings/media/cdns,csi2rx.yaml           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
index 89f414eeef47..f8da4a35e98e 100644
--- a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
+++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
@@ -38,6 +38,24 @@ properties:
       - const: pixel_if2_clk
       - const: pixel_if3_clk
 
+  resets:
+    items:
+      - description: CSI2Rx system reset
+      - description: Gated Register bank reset for APB interface
+      - description: pixel reset for Stream interface 0
+      - description: pixel reset for Stream interface 1
+      - description: pixel reset for Stream interface 2
+      - description: pixel reset for Stream interface 3
+
+  reset-names:
+    items:
+      - const: sys
+      - const: reg_bank
+      - const: pixel_if0
+      - const: pixel_if1
+      - const: pixel_if2
+      - const: pixel_if3
+
   phys:
     maxItems: 1
     description: MIPI D-PHY
@@ -120,6 +138,12 @@ examples:
         clock-names = "sys_clk", "p_clk",
                       "pixel_if0_clk", "pixel_if1_clk",
                       "pixel_if2_clk", "pixel_if3_clk";
+        resets = <&bytereset 9>, <&bytereset 4>,
+                 <&corereset 5>, <&corereset 6>,
+                 <&corereset 7>, <&corereset 8>;
+        reset-names = "sys", "reg_bank",
+                      "pixel_if0", "pixel_if1",
+                      "pixel_if2", "pixel_if3";
         phys = <&csi_phy>;
         phy-names = "dphy";
 
-- 
2.34.1

