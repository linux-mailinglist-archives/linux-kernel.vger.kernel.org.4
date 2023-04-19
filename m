Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA86E71F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjDSD45 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 23:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDSD4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:56:53 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7075FFE;
        Tue, 18 Apr 2023 20:56:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6B8F724E1B5;
        Wed, 19 Apr 2023 11:56:50 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:56:50 +0800
Received: from ubuntu.localdomain (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 11:56:49 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Walker Chen <walker.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Date:   Tue, 18 Apr 2023 20:56:41 -0700
Message-ID: <20230419035646.43702-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AON PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY
rx/tx power switch, and it don't need the properties of reg and
interrupts.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../bindings/power/starfive,jh7110-pmu.yaml       | 15 +++++++++++++--
 include/dt-bindings/power/starfive,jh7110-pmu.h   |  3 +++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
index 98eb8b4110e7..c50507c38e14 100644
--- a/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
+++ b/Documentation/devicetree/bindings/power/starfive,jh7110-pmu.yaml
@@ -8,6 +8,7 @@ title: StarFive JH7110 Power Management Unit
 
 maintainers:
   - Walker Chen <walker.chen@starfivetech.com>
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
 
 description: |
   StarFive JH7110 SoC includes support for multiple power domains which can be
@@ -17,6 +18,7 @@ properties:
   compatible:
     enum:
       - starfive,jh7110-pmu
+      - starfive,jh7110-aon-pmu
 
   reg:
     maxItems: 1
@@ -29,10 +31,19 @@ properties:
 
 required:
   - compatible
-  - reg
-  - interrupts
   - "#power-domain-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-pmu
+    then:
+      required:
+        - reg
+        - interrupts
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
index 132bfe401fc8..0bfd6700c144 100644
--- a/include/dt-bindings/power/starfive,jh7110-pmu.h
+++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
@@ -14,4 +14,7 @@
 #define JH7110_PD_ISP		5
 #define JH7110_PD_VENC		6
 
+#define JH7110_PD_DPHY_TX	0
+#define JH7110_PD_DPHY_RX	1
+
 #endif
-- 
2.25.1

