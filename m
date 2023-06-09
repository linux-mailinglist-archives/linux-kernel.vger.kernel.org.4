Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1488F729B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbjFIN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbjFIN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:29:28 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940026B1;
        Fri,  9 Jun 2023 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317366; x=1717853366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5CSDyfpcwogrVwSeDi4wB4m0Q0tiotgMun3y07NDXo=;
  b=FnTfq/b8MYZ7+gpmxGzqQ/+XSSa41l7cUJkjsJDTUHh//20B5QvFwJ+c
   3HF9KRuaFPTiQRVx0RpcgFzf8OgELCxu0wzXHM+oFpkBIs5UQbZ2KZX5I
   8RNccuew3muTNy6GUK9wBVEnnbHN2rndkwXlrJsVilD4U/7UYc1k1s7lh
   UerWnpOv07e+v3+1mPELbF38sOQ0FnAwQpTJW3FT7q25e5j6mdGTXdFTR
   +/VK+DZahGijsu3Q9N7cx09dbqkKblNan8UnS15V6zGNx4wSopYL6fdya
   kzPwG2fCggPsqHiWfIoyI34TeevGBTKPwEl8PD2G4GpYLpT+sWJ97J/UD
   w==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366200"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 15:29:22 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 15:29:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317362; x=1717853362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5CSDyfpcwogrVwSeDi4wB4m0Q0tiotgMun3y07NDXo=;
  b=XFfnE6ljGzQRwtbmUJal9B62UZkXabq+rbWzkkVTz8OlrXNThtlCUsaD
   +xTCCQ8cD4Eil/gSOdZ74z7lHiWO9+r6ha7dLtedIbJIPlgIuon8U4UJA
   Ck5iiwHaVxesXW9f9p6EWlGTt/qrzpIvBW0wKNNvsCDoqGMIAwv5FafXh
   x1T/avwhAej/livjdTJ+8KIwpQOG6onmHZB99nhSgGE/L8Z0+HEziUpgI
   BBF2Ws3ZoJeuz8JtGl5cMh30IQbh/cj9V11T3jDAeHNyxJrOlN6b9BqPn
   qTsebabvxQrbUcS4rbxPaI5H2q6C0w6Hm/1omNna3yKtnleLYZ0+UXTHK
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366199"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2682528008C;
        Fri,  9 Jun 2023 15:29:22 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/3] dt: bindings: add bindings for TQMa93xxLA SOM
Date:   Fri,  9 Jun 2023 15:29:13 +0200
Message-Id: <20230609132915.634338-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
References: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

TQMa93xxLA is a SOM variant in the TQ-Systems GmbH TQMa93xx series using
NXP i.MX93 CPU on an LGA type board.
MBa93xxCA is a starterkit base board for TQMa93xxLA on an adapter board.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../devicetree/bindings/arm/fsl.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906dd..8048c7f6a299d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1219,6 +1219,25 @@ properties:
               - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
           - const: fsl,imxrt1170
 
+      - description:
+          TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
+          using NXP i.MX93 SOC in 11x11 mm package.
+          TQMa93xxLA is designed to be soldered on different carrier boards.
+          TQMa93xxCA is a compatible variant using board to board connectors.
+          All SOM and CPU variants use the same device tree hence only one
+          compatible is needed. Bootloader disables all features not present
+          in the assembled SOC.
+          MBa93xxCA mainboard can be used as starterkit for the SOM
+          soldered on an adapter board or for the connector variant
+          MBa93xxLA mainboard is a single board computer using the solderable
+          SOM variant
+        items:
+          - enum:
+              - tq,imx93-tqma9352-mba93xxca # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM on MBa93xxCA
+              - tq,imx93-tqma9352-mba93xxla # TQ-Systems GmbH i.MX93 TQMa93xxLA SOM on MBa93xxLA SBC
+          - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQMa93xxCA/LA SOM
+          - const: fsl,imx93
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.34.1

