Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D21705641
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEPSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjEPSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:46:36 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8A7ED5;
        Tue, 16 May 2023 11:46:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GIkShJ101895;
        Tue, 16 May 2023 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684262788;
        bh=nNBe5P/DBo3Uk1BRjtGrx8bcwS7/b+ZkZy8oqUawqAo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Pj1SqnvECNYa2vLo/1a+QKA6B8qQfLfBqrrVZ4C26GAwMM+lOT5Q2P24BsCk0niX0
         rshCmWd3/QPb3bDQSTe7row7Jtik50sjFTVG8KCDh6D7C+wOrgM9dveSbqCgZCg5ea
         BvJ/bxKJ1DGXHbDIQXcfA1uTFiUXxCgI7on9i4yQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GIkSY5094765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 13:46:28 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 13:46:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 13:46:28 -0500
Received: from lelv0326.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GIkRGP025014;
        Tue, 16 May 2023 13:46:27 -0500
From:   Andrew Davis <afd@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon compatible
Date:   Tue, 16 May 2023 13:46:26 -0500
Message-ID: <20230516184626.154892-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516184626.154892-1-afd@ti.com>
References: <20230516184626.154892-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This node's register space is not accessed by any other node, which
is the traditional use for the "syscon" hint. It looks to have been
added here to make use of a Linux kernel helper syscon_node_to_regmap().
The Linux driver now uses a more appropriate helper that does not
require the hint, so let's remove it from the binding.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
index 66765116aff5..64b8bce5962c 100644
--- a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
+++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
@@ -16,7 +16,6 @@ properties:
           - ti,am654-ehrpwm-tbclk
           - ti,am64-epwm-tbclk
           - ti,am62-epwm-tbclk
-      - const: syscon
 
   "#clock-cells":
     const: 1
@@ -33,8 +32,8 @@ additionalProperties: false
 
 examples:
   - |
-    ehrpwm_tbclk: syscon@4140 {
-        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+    ehrpwm_tbclk: clock@4140 {
+        compatible = "ti,am654-ehrpwm-tbclk";
         reg = <0x4140 0x18>;
         #clock-cells = <1>;
     };
-- 
2.39.2

