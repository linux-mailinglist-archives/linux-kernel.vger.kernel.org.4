Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A22604E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJSRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJSRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DBF1BFBB7;
        Wed, 19 Oct 2022 10:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5737B82566;
        Wed, 19 Oct 2022 17:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C8C433D7;
        Wed, 19 Oct 2022 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199256;
        bh=Dk8qulf7jy4RWXliAjjhHRDUCVMa6Eye2Ux3gVAfoAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duAoc9H9OeX3W/6PGFEYsZT011cxJEKkxYnu1SMaRL3cH07K3KMnNZF0Z1+dokqeN
         EhBe0DTaRGyqE9oIJE82E4KnIWnhRlwwe0Gif6yOoyqTvRdrLjn6vRyXApie32+DgZ
         BkpPsjhJWb+iQ0ZhyZ5dYhE8EpYHDr6D+U4kHa+344RyxDeyy636ZRQgyLIzNQKFkv
         ugQppV8t6Uv5xKxqWX8E0cs/YcwMacVgCB2644k1YHsoYj7X/jX/nt2QWbk20kbKTO
         6F1AyUCQVZomcwATxgMRj4I9WdxF4Dh4vEVYoNYSuAtedpk64cnEFdz228x3U8LXAC
         r7BUVzkBJyx3Q==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv5 1/6] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Wed, 19 Oct 2022 12:06:52 -0500
Message-Id: <20221019170657.68014-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019170657.68014-1-dinguyen@kernel.org>
References: <20221019170657.68014-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v5: document reg shift
v4: add else statement
v3: document that the "altr,sysmgr-syscon" binding is only applicable to
    "altr,socfpga-dw-mshc"
v2: document "altr,sysmgr-syscon" in the MMC section
---
 .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index ae6d6fca79e2..950fa6bd11fd 100644
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
+      Contains the phandle to System Manager block that contains
+      the SDMMC clock-phase control register. The first value is the pointer
+      to the sysmgr, the 2nd value is the register offset for the SDMMC
+      clock phase register, and the 3rd value is the bit shift for the
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
+      required:
+        - altr,sysmgr-syscon
+    else:
+      properties:
+        altr,sysmgr-syscon: false
+
 required:
   - compatible
   - reg
-- 
2.25.1

