Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE296608BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJVKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJVKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:44:18 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA22F31BF49;
        Sat, 22 Oct 2022 03:01:50 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 8AA8A41A25;
        Sat, 22 Oct 2022 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666429540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwE9fx2tS9oduVfTIs9Hd6/Fb9a+3JIsjdgPxEZuCWk=;
        b=G1xnd0RAP2vFdUQcNsw9U+lz+xRBas2yonC7dKl/xdx4sQpNoL0h2wCEjl4zSw/hjbN97h
        XqXubJCBuU3O8GVbLOnfbLZ8regoUcyCtf/Iinridt3NAixHPzUNZHPfCHH4313o5u5VVv
        IXlpKKROuQzbWa7VeD+offVODzc0hm8=
Received: from frank-G5.. (fttx-pool-80.245.73.148.bambit.de [80.245.73.148])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id CB46C40690;
        Sat, 22 Oct 2022 09:05:39 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: mmc: mtk-sd: add mt7986
Date:   Sat, 22 Oct 2022 11:05:30 +0200
Message-Id: <20221022090530.16265-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022090530.16265-1-linux@fw-web.de>
References: <20221022090530.16265-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 2ff8b4a6-6a4a-400a-8436-ce86973b8370
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add SoC specific section for defining clock configuration.

Add compatible in "not" section to avoid override the settings again.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../devicetree/bindings/mmc/mtk-sd.yaml       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index c7bcf0c3dd5d..9df63c461f1f 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -229,6 +229,33 @@ allOf:
             - const: hclk
             - const: source_cg
             - const: bus_clk
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7986-mmc
+    then:
+      properties:
+        assigned-clock-parents:
+          maxItems: 2
+        assigned-clocks:
+          maxItems: 2
+        clocks:
+          minItems: 3
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: bus clock used for internal register access
+            - description: msdc subsys clock gate
+        clock-names:
+          minItems: 3
+          items:
+            - const: source
+            - const: hclk
+            - const: axi_cg
+            - const: ahb_cg
   - if:
       not:
         properties:
@@ -237,6 +264,7 @@ allOf:
               enum:
                 - mediatek,mt2712-mmc
                 - mediatek,mt8192-mmc
+                - mediatek,mt7986-mmc
     then:
       properties:
         clocks:
-- 
2.34.1

