Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471372CC26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjFLRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjFLRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:13:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0C10D0;
        Mon, 12 Jun 2023 10:13:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-210-131.ewe-ip-backbone.de [91.248.210.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC835660217A;
        Mon, 12 Jun 2023 18:13:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686590021;
        bh=n54yxi0NbW+9j5w95zW2R5gmOueJZM48CLnOI1FoEB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MikiQcRGOiFOSxmoBB/jq8DkOGToAcx9ny7kd5HyQLvOJjkUdEY7XMGZTAKrpavSG
         qGB4EsjoXVQDOiPUjGooYvCiiep7/d5jSuNjnxqj6WADEQLNRChE5HFXJ2edmEzcxG
         yWQ3+PEHRJ1NvULmUAnXYIyNTXScTFHb+7JAfAETjZP30wE6REdzg33bYru62aQcdT
         ZDgsGDA8Wbc2bhRyFokFJFRMsmtuSPeUSwIcht+pW8DK3ECzJDjsu9s+0X9w3gsTYj
         PxVcL1/D6Og+wgRyJVvqknab6ZAp9BIbYsyApKEZ5CYvHy6OGnVRRmfEjzPz7i5m2a
         EbVUzTjnrP6VA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A3C8D4805B8; Mon, 12 Jun 2023 19:13:38 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] dt-bindings: ata: dwc-ahci: add PHY clocks
Date:   Mon, 12 Jun 2023 19:13:33 +0200
Message-Id: <20230612171337.74576-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612171337.74576-1-sebastian.reichel@collabora.com>
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY transmit and receive clocks as described by the
DW SATA AHCI HW manual.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
index c1457910520b..34c5bf65b02d 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
@@ -31,11 +31,11 @@ properties:
       PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
       clock, etc.
     minItems: 1
-    maxItems: 4
+    maxItems: 6
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 6
     items:
       oneOf:
         - description: Application APB/AHB/AXI BIU clock
@@ -48,6 +48,10 @@ properties:
           const: pmalive
         - description: RxOOB detection clock
           const: rxoob
+        - description: PHY Transmit Clock
+          const: asic
+        - description: PHY Receive Clock
+          const: rbc
         - description: SATA Ports reference clock
           const: ref
 
-- 
2.39.2

