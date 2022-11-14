Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D15628CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiKNXC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiKNXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5F1A22B;
        Mon, 14 Nov 2022 15:02:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA6961480;
        Mon, 14 Nov 2022 23:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9DEC433C1;
        Mon, 14 Nov 2022 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466942;
        bh=Sl9o27hByjI3ej53FtoyhZf0M6+nUUScj+ybS1qbm94=;
        h=From:To:Cc:Subject:Date:From;
        b=kvaRqXhnMOXQESXOcsSVDo9Nk5CfbUfiap5x3pirS63xGR0VKoMJQe/8swsU6lR2/
         nj0/iy8dsmsKjtbwzv6x6xJTAT6O40cOmknYtSNS7n84AlCJOmV2FV9pRh+JT3UZk9
         XRY648tdsjZiO7KwY7cNjkJkO8CdJNNb9pE6Yo9AJ8kgED99oG+niLLf4dJNWLCD72
         I3c61IWEQRHappsuGvNhQlQ0a3crDiBBAMWorFOU4UzcclHyLsoSvbynpHhWRH/H6u
         D2ba8ZgZn/Lr1SmljJkvnHBT6op43L9EF5olnIRnfbB8ITEMed1xGfVdvVHoKxMaSF
         Jl2bDWEFiAKBQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv9 1/6] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Mon, 14 Nov 2022 17:02:12 -0600
Message-Id: <20221114230217.202634-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the optional "altr,sysmgr-syscon" binding that is used to
access the System Manager register that controls the SDMMC clock
phase.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v9: remove required for "altr,sysmgr-syscon"
v8: remove "" around synopsys-dw-mshc-common.yaml#
v7: and "not" for the required "altr,sysmgr-syscon" binding
v6: make "altr,sysmgr-syscon" optional
v5: document reg shift
v4: add else statement
v3: document that the "altr,sysmgr-syscon" binding is only applicable to
    "altr,socfpga-dw-mshc"
v2: document "altr,sysmgr-syscon" in the MMC section
---
 .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index ae6d6fca79e2..e1f5f26f3f1c 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Synopsys Designware Mobile Storage Host Controller Binding
 
-allOf:
-  - $ref: "synopsys-dw-mshc-common.yaml#"
-
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
@@ -38,6 +35,35 @@ properties:
       - const: biu
       - const: ciu
 
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the sysmgr node
+          - description: register offset that controls the SDMMC clock phase
+          - description: register shift for the smplsel(drive in) setting
+    description:
+      This property is optional. Contains the phandle to System Manager block
+      that contains the SDMMC clock-phase control register. The first value is
+      the pointer to the sysmgr, the 2nd value is the register offset for the
+      SDMMC clock phase register, and the 3rd value is the bit shift for the
+      smplsel(drive in) setting.
+
+allOf:
+  - $ref: synopsys-dw-mshc-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: altr,socfpga-dw-mshc
+    then:
+      properties:
+        altr,sysmgr-syscon: true
+    else:
+      properties:
+        altr,sysmgr-syscon: false
+
 required:
   - compatible
   - reg
-- 
2.25.1

