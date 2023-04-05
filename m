Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB86D7B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjDELVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbjDELVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:21:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A22736
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:21:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Ce-0004S4-00; Wed, 05 Apr 2023 13:21:24 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cc-0098SP-HB; Wed, 05 Apr 2023 13:21:22 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cb-005Gtp-Ab; Wed, 05 Apr 2023 13:21:21 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jun.li@nxp.com,
        haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     j.zink@pengutronix.de
Subject: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning properties
Date:   Wed,  5 Apr 2023 13:21:17 +0200
Message-Id: <20230405112118.1256151-2-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405112118.1256151-1-j.zink@pengutronix.de>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional properties for tuning of usb phy.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index e6f9f5540cc3..f452a41b4f32 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -35,6 +35,46 @@ properties:
     description:
       A phandle to the regulator for USB VBUS.
 
+  fsl,phy-tx-vref-tune:
+    description:
+      HS DC Voltage level adjustment
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
+
+  fsl,phy-tx-rise-tune:
+    description:
+      HS Transmitter Rise/Fall Time Adjustment
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  fsl,phy-tx-preemp-amp-tune:
+    description:
+      HS Transmitter Pre-Emphasis Current Control
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  fsl,phy-tx-vboost-level:
+    description:
+      TX Voltage Boost Level
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 3]
+
+  fsl,phy-comp-dis-tune:
+    description:
+      Disconnect Threshold Adjustment
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  fsl,phy-pcs-tx-deemph-3p5db:
+    description:
+      TX De-Emphasis at 3.5 dB
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fsl,phy-pcs-tx-swing-full:
+    description:
+      TX Amplitude
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
-- 
2.39.2

