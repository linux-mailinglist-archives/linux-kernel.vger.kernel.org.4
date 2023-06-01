Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA55719995
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjFAKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjFAKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:19:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A475CE7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:16:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKZ-0004WD-5l; Thu, 01 Jun 2023 12:14:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKX-004KWH-WF; Thu, 01 Jun 2023 12:14:54 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q4fKW-001V3z-KX; Thu, 01 Jun 2023 12:14:52 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>, Marek Vasut <marex@denx.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-input@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v1 3/7] dt-bindings: timer: gpt: Support 3rd clock for i.MX6DL
Date:   Thu,  1 Jun 2023 12:14:47 +0200
Message-Id: <20230601101451.357662-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601101451.357662-1-o.rempel@pengutronix.de>
References: <20230601101451.357662-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a 3rd clock, 'osc_per', for i.MX6DL to the 'fsl,imxgpt'
binding to resolve the following dtbs_check warning:
  imx6dl-alti6p.dtb: timer@2098000: clocks: [[2, 119], [2, 120], [2, 237]]
    is too long
  From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
  imx6dl-alti6p.dtb: timer@2098000: clock-names: ['ipg', 'per', 'osc_per']
    is too long
  From schema: Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index adf617b8f353..21ff51c3f38f 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -46,14 +46,24 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: SoC GPT ipg clock
-      - description: SoC GPT per clock
+    anyOf:
+      - items:
+          - description: SoC GPT ipg clock
+          - description: SoC GPT per clock
+      - items:
+          - description: SoC GPT ipg clock
+          - description: SoC GPT per clock
+          - description: SoC GPT osc_per clock
 
   clock-names:
-    items:
-      - const: ipg
-      - const: per
+    anyOf:
+      - items:
+          - const: ipg
+          - const: per
+      - items:
+          - const: ipg
+          - const: per
+          - const: osc_per
 
 required:
   - compatible
-- 
2.39.2

