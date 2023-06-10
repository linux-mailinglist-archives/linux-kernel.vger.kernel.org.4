Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E0E72ADB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjFJRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjFJRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:25:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBB3590;
        Sat, 10 Jun 2023 10:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BAE6097A;
        Sat, 10 Jun 2023 17:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A51C4339C;
        Sat, 10 Jun 2023 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686417914;
        bh=3wpZ8o+35iL6424lyV2DUmQ6SjU6/eZ7YzznRGiRZCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErJlmji9Custi1BOYzOMGjAI58K4rcxusnBFYJ+9i875fwP/pg5q/9okCyYp3egqx
         gq68ML+QfH7Uw96mEvB+u6912njCHEy9yoOJNy6CVS1jqX+v+I11NWJGvR+A+yWYZa
         arMCDeystOsRagfgbuiItdVZN/1vOeCLipkxlnHuoqjporSl+XhHNC44iFOo+ctUMz
         YrnrLsRkGQgDP4K/rI4A+X1voa2jTnWZGccQwIltHa+P068e19sZR8tz3Ts8GSGXGQ
         4urtmB0yAqCIVmzZ6lIXDz3U+x/Zr2WzQuNXo50NWtgaJxIF1gFCSeafLdOxBMM/NH
         ulIy63uO1MWiQ==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] dt-bindings: riscv: cpus: allow clocks property
Date:   Sat, 10 Jun 2023 18:24:49 +0100
Message-Id: <20230610-purge-pretended-a0815886d300@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=56khd3m28bySZd+RhG9G5vkREjzLjNJIdu3gjjupwM4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCktGx9UJhbyHuKe7mvttKJwMtO1NM4DDMaCBrsTq4rsu BZkdod3lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIpuYwMHfcmPzA7naHwdvrP VT/POu8sjSs2PHN/4pKvjM9zL1RM3sXwv0Rr7mbOu2X+rrYHTy15/l027OB+w4VBHb8YnbxEDnz RZgIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Having disallowed additionalProperties, dtbs_check complains about
unevaluated clocks properties. Permit a single clock, as that's all any
current dts uses.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e89a10d9c06b..3808a6703b2d 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -58,6 +58,9 @@ properties:
       Identifies that the hart uses the RISC-V instruction set
       and identifies the type of the hart.
 
+  clocks:
+    maxItems: 1
+
   mmu-type:
     description:
       Identifies the MMU address translation mode used on this
-- 
2.39.2

