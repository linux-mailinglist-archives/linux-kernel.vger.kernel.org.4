Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4D70538B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjEPQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEPQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:20:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C2A269
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:20:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPd-0002nv-Im; Tue, 16 May 2023 18:20:33 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPc-000eDz-Pm; Tue, 16 May 2023 18:20:32 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPb-00DODy-Q4; Tue, 16 May 2023 18:20:31 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Tue, 16 May 2023 18:20:19 +0200
Subject: [PATCH v2 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-lustige-usb-phy-dinge-v2-1-3383a0de34ac@pengutronix.de>
References: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
In-Reply-To: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     patchwork-jzi@pengutronix.de, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional properties for tuning of usb phy.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index e6f9f5540cc3..dc3a3f709fea 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -35,6 +35,53 @@ properties:
     description:
       A phandle to the regulator for USB VBUS.
 
+  fsl,phy-tx-vref-tune-percent:
+    description:
+      Tunes the HS DC level relative to the nominal level
+    minimum: 94
+    maximum: 124
+
+  fsl,phy-tx-rise-tune-percent:
+    description:
+      Adjusts the rise/fall time duration of the HS waveform relative to
+      its nominal value
+    minimum: 97
+    maximum: 103
+
+  fsl,phy-tx-preemp-amp-tune-microamp:
+    description:
+      Adjust amount of current sourced to DPn and DMn after a J-to-K
+      or K-to-J transition. Default is 0 (disabled).
+    minimum: 0
+    maximum: 1800
+
+  fsl,phy-tx-vboost-level-microvolt:
+    description:
+      Adjust the boosted transmit launch pk-pk differential amplitude
+    minimum: 880
+    maximum: 1120
+
+  fsl,phy-comp-dis-tune-percent:
+    description:
+      Adjust the voltage level used to detect a disconnect event at the host
+      relative to the nominal value
+    minimum: 91
+    maximum: 115
+
+  fsl,phy-pcs-tx-deemph-3p5db-attenuation-db:
+    description:
+      Adjust TX de-emphasis attenuation in dB at nominal
+      3.5dB point as per USB specification
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 36
+
+  fsl,phy-pcs-tx-swing-full-percent:
+    description:
+      Scaling of the voltage defined by fsl,phy-tx-vboost-level-microvolt
+    minimum: 0
+    maximum: 100
+
 required:
   - compatible
   - reg

-- 
2.39.2

