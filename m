Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9D68F42F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjBHRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBHRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCE10AA6;
        Wed,  8 Feb 2023 09:17:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D636174A;
        Wed,  8 Feb 2023 17:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695ABC433D2;
        Wed,  8 Feb 2023 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675876667;
        bh=IYH2Y4ODFkY1kTcBDDNXIx49akbBHzGilU5aXrsBM0c=;
        h=From:To:Cc:Subject:Date:From;
        b=mbKUSl8kK8Vt110dm77g0TJeL3JF1O89RUJ3GkVhi/7EaP1h2YXAkCfIE7oFh7Bz7
         qDeOrSgH60QZz7gMElZA7lQY0moRIJIg4EcuqXKV30WQCARLCe91+IxbmYgBMjvubm
         Gtn1QJ4GgkWg1hbQrTgQtj20WPDOF5guTpVzPaM2XLQTY1wXM4c7Bn9hJwrpuRucgx
         tdl6o2rFtMLZq1nmHbjHG4irgorHnr4g1lp8bOWfuMqHW6qV/vDTZDU+H6/vwmSazb
         BT9iQ87NX8Q6HztIRXt5sQ0yds5izvCBakybLyZZK4lmCpokLBv7GLiU8JBHOFuIqW
         v9MplqD9Uncig==
From:   Conor Dooley <conor@kernel.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: serial: snps-dw-apb-uart: add dma & dma-names properties
Date:   Wed,  8 Feb 2023 17:17:16 +0000
Message-Id: <20230208171715.70862-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=conor.dooley@microchip.com; h=from:subject; bh=xSxJD2irQlzPRyhGvv2ObBjMIMpYQW5PWeCkcZOME+w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMmPb0opay6fN03sk4SYUoNF2uymk2ue6x9zvPi/bwpbZfSy uRyBHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIDllGhsOJhy9p+ax+eyHRakI2T0 02V3X939XGf7+Xr+gOybv3qomR4defw5cFTPmT5+1OaouJeDjhwGOTZWfi+r7y9+67OSXkIgsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Commit 0c559bc8abfb ("dt-bindings: serial: restrict possible child node
names") exposed the Allwinner D1 devicetrees as users of unevaluated
properties, with a slew of similar warnings now appearing during
dtbs_check:
sun20i-d1-nezha.dtb: serial@2500400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)

Document the missing properties.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
The commit exposing it is in Rob's tree, but I figure this can go either
way as it has no dependancy.
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index b9c2287c5d1e..2becdfab4f15 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -67,6 +67,14 @@ properties:
       - const: baudclk
       - const: apb_pclk
 
+  dmas:
+    minItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   snps,uart-16550-compatible:
     description: reflects the value of UART_16550_COMPATIBLE configuration
       parameter. Define this if your UART does not implement the busy functionality.
-- 
2.39.1

