Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C3694BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjBMP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjBMP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:59:46 -0500
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028182687;
        Mon, 13 Feb 2023 07:59:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F64DC0176;
        Mon, 13 Feb 2023 16:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676303984; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=1hMuNgLfmYKnEteM9D2HKTHTutb/TpNG5wgcFSK2t6I=;
        b=EYOHLaahGl9AS5iE/8SSCDIFFURc8P60qTcUkxBkiX+UIXON6UQC+WV3qmIwjAQmyUp6iS
        01fYBcrJOXFxoOnhZ/NxCFoINDiNw5CuU6m4zL2lol829B2DEvVMGpw+Ka2r4K1GiNtohP
        LZaWUFbQvPH4AygtVS84gUZT8TsAmqelmsVW3IOA67Fl4u40xHr9UvOkrQKVgXL4iz3/bK
        rD0Vap2FcH68o11+3G1A0pZDyGT2Y09t+i0ekuqhqUHcMJQWzjt8i/3qCMP6hUnW2B7xw7
        N7b3wJh+dDIs5CEGTvTbVhuGjfEw6IEWGMAf4GxsP764IPKUM751BZHog+azPg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>
Subject: [PATCH 1/6] dt-bindings: regulator: pca9450: Document new usage of sd-vsel-gpios
Date:   Mon, 13 Feb 2023 16:58:19 +0100
Message-Id: <20230213155833.1644366-2-frieder@fris.de>
In-Reply-To: <20230213155833.1644366-1-frieder@fris.de>
References: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The sd-vsel-gpios property is abandoned in its current meaning as an
output. We now use it to specify an optional signal that can be
evaluated by the driver in order to retrieve the current status
of the SD_VSEL signal that is used to select the control register
of LDO5.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../regulator/nxp,pca9450-regulator.yaml      | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 835b53302db8..c86534538a4e 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -40,8 +40,24 @@ properties:
     description: |
       list of regulators provided by this controller
 
+    properties:
+      LDO5:
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO5 regulator.
+
+        properties:
+          sd-vsel-gpios:
+            description:
+              GPIO that can be used to read the current status of the SD_VSEL
+              signal in order for the driver to know if LDO5CTRL_L or LDO5CTRL_H
+              is used by the hardware.
+
+        unevaluatedProperties: false
+
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO[1-4]$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -76,11 +92,6 @@ properties:
 
     additionalProperties: false
 
-  sd-vsel-gpios:
-    description: GPIO that is used to switch LDO5 between being configured by
-      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL signal is
-      connected to a host GPIO.
-
   nxp,i2c-lt-enable:
     type: boolean
     description:
-- 
2.39.1

