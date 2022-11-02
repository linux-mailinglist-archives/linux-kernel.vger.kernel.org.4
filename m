Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7E616AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiKBRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKBRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A6DDC;
        Wed,  2 Nov 2022 10:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC19461A32;
        Wed,  2 Nov 2022 17:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E80CC433C1;
        Wed,  2 Nov 2022 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667410731;
        bh=/ON+gsXdFppkI6cKXNcthQ/QCtA2Pr6PzO03HRm7PDc=;
        h=From:To:Cc:Subject:Date:From;
        b=FjY+MwJ1cGJ3hWSa+inCk7llbc3rznAhNJ1KoHHNuIcE7dbjsUv6TqLQmaW0qxhbR
         ZjqDy6Q+hBQqxrADq1wtPzX3iIfeJzAvB9eBi4EyhRH5qI6qUrilA0pnsi0DZzf7lB
         /86Osba7IWuUp35Y7dIVFAQgn8847vJeyOkhrjFCFSAlVt7ryrhqYG0r9a+sm/IkXc
         Y7XebqST9SSD39b8PE5vnS9RK565woRHiQtlPHmfRGMvfbyo8kScoWD0xCx5+SnFny
         O2elFs8ly8wo8uRvOwSkaa8OsjQVJbufLxTxVaKJQAtRtktm95Sp8huiAXDIgCigw9
         XyS+eTGTN0/VA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv7 1/6] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Wed,  2 Nov 2022 12:38:38 -0500
Message-Id: <20221102173843.409039-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v7: and "not" for the required "altr,sysmgr-syscon" binding
v6: make "altr,sysmgr-syscon" optional
v5: document reg shift
v4: add else statement
v3: document that the "altr,sysmgr-syscon" binding is only applicable to
    "altr,socfpga-dw-mshc"
v2: document "altr,sysmgr-syscon" in the MMC section
---
 .../bindings/mmc/synopsys-dw-mshc.yaml        | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index ae6d6fca79e2..80dd3d72424f 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Synopsys Designware Mobile Storage Host Controller Binding
 
-allOf:
-  - $ref: "synopsys-dw-mshc-common.yaml#"
-
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
 
@@ -38,6 +35,36 @@ properties:
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
+  - $ref: "synopsys-dw-mshc-common.yaml#"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: altr,socfpga-dw-mshc
+    then:
+      not:
+        required:
+          - altr,sysmgr-syscon
+    else:
+      properties:
+        altr,sysmgr-syscon: false
+
 required:
   - compatible
   - reg
-- 
2.25.1

