Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC074F308
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGKPJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGKPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:08:34 -0400
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC010A;
        Tue, 11 Jul 2023 08:08:33 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 1343F601F065;
        Tue, 11 Jul 2023 18:08:32 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 11 Jul 2023 18:08:31 +0300
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     vesa.jaaskelainen@vaisala.com, Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Date:   Tue, 11 Jul 2023 18:08:04 +0300
Message-Id: <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jul 2023 15:08:31.0713 (UTC) FILETIME=[8E2C8D10:01D9B409]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fsl,fec-tx-clock-output one can control if TX clock is routed outside
of the chip.

With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
reference clock.

Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
---
 .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index b494e009326e..c09105878bc6 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -166,6 +166,21 @@ properties:
     description:
       If present, indicates that the hardware supports waking up via magic packet.
 
+  fsl,fec-tx-clock-output:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, ENETx_TX_CLK output driver is enabled.
+      If not present, ENETx_TX_CLK output driver is disabled.
+
+  fsl,fec-tx-clk-as-ref-clock:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
+      this use case, an external OSC provides the clock for both the external
+      PHY and the internal controller.
+      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
+      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.
+
   fsl,err006687-workaround-present:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.34.1

