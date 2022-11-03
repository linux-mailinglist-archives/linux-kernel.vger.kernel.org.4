Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423D6181B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiKCPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiKCPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:15:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140919C20;
        Thu,  3 Nov 2022 08:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20203B828DC;
        Thu,  3 Nov 2022 15:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79FFC433D7;
        Thu,  3 Nov 2022 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667488531;
        bh=iW4uEWQBBg7P34LNP+tKGYl5kuiCd+1lTZZRFWO6evg=;
        h=From:To:Cc:Subject:Date:From;
        b=XcA2bYmVE7H9mi8RYOH9IslXv5fWpd2E3o6wCynM5jBI7EQ2TdM2ebgFFKuET3O8+
         P4V0Z1GNT7RN+CKX6Fa72aBq2bmCO5CnRl+/8ikaABpPzCRz8WixtkpK/5squdXCzT
         cTFN0LOjNjdKUfFTuKdZ51ags1e12QsBwG/LRsas27eu15aUEIbF0NU7sGKbiPa4Xe
         KsIKmT0h79Thdgm/Gakuv5m77nvnTTVxv4ZFdpDiQu0eGMZL4DV5AL3PThbY9afIcm
         CsOwFIs8QcxY74ShGuyahHRnzdJqrw7dGDM6K513WJtT1L7z+Vr6cN6L75OEcZlvA3
         F0HnLvtKOnLaQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv8 1/6] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Thu,  3 Nov 2022 10:15:20 -0500
Message-Id: <20221103151525.474833-1-dinguyen@kernel.org>
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
v8: remove "" around synopsys-dw-mshc-common.yaml#
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
index ae6d6fca79e2..a37cd7a68417 100644
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
+  - $ref: synopsys-dw-mshc-common.yaml#
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

