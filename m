Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445B718589
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjEaPEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjEaPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:04:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9793412B;
        Wed, 31 May 2023 08:03:58 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DBB26606EB1;
        Wed, 31 May 2023 16:03:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685545437;
        bh=ZwlXPYQPfk+GWd3QIJF4+YV66sRpXFI0cOCa/2Pkr1c=;
        h=From:To:Cc:Subject:Date:From;
        b=gJv5lCZCo9TpspztOoSp2+J7yKGfADEev9Peyk9pHP7lLl4bXSMcO45nu0OzA5AqA
         tg+zuNhlup2nWOeoe+1TGtwT97dGLvVmolwotYkCXOsdXoEwxLIAX6AuAUFTkjtr1f
         jVnkYEzZs/PraQjzYXfz3UpDNg8ZPbs2TH2Yi8KXAiQu888SPZ8sdF5iUt97+ohnXM
         j6XHJqmJvzugy/w5VxFSHrd6jdO5CT/kCq3FNjG5VSVRMpiE+KbiryXuLVKpIfeSWr
         SkNj24+b3ct8s/fR05oSjtFKD7aoinOrzpUK/b3uP6+QzO4m3BCIJR0NuJklenbgI+
         J2ck/yqQlZBlw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 1/2] dt-bindings: net: phy: Support external PHY xtal
Date:   Wed, 31 May 2023 11:03:39 -0400
Message-Id: <20230531150340.522994-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethernet PHYs can have external an clock that needs to be activated before
probing the PHY.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../devicetree/bindings/net/ethernet-phy.yaml          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 4f574532ee13..e83a33c2aa59 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,16 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  clock-names:
+    items:
+      - const: xtal
+
+  clocks:
+    maxItems: 1
+    description:
+      External clock connected to the PHY. If not specified it is assumed
+      that the PHY uses a fixed crystal or an internal oscillator.
+
   enet-phy-lane-swap:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.39.3

