Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5793C717A90
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjEaIrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjEaIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:47:19 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB78611C;
        Wed, 31 May 2023 01:47:08 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(746:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 31 May 2023 16:46:54 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 31 May
 2023 16:46:54 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 31 May 2023 16:46:54 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <cy_huang@richtek.com>, <chiaen_wu@richtek.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: power: supply: Fix rt9467 charger enable gpio active level
Date:   Wed, 31 May 2023 16:46:53 +0800
Message-ID: <1685522813-14481-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

The RT9467 charger enable pin is an external signal that used to enable
battery charging. From the datasheet, the active level is low. Although
it's already configured to logic low at driver probe function, but the
current binding example declared it as 'GPIO_ACTIVE_LOW', this causes
this pin be output high and disable battery charging.

Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

  This patch is to fix the active level for charger enable gpio polarity.
Currently, the wrong active level makes the user confused and
unexpectedly disable battery charging by default.
---
 Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
index 3723717..cdc7678 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml
@@ -69,7 +69,7 @@ examples:
         reg = <0x5b>;
         wakeup-source;
         interrupts-extended = <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
-        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_LOW>;
+        charge-enable-gpios = <&gpio26 1 GPIO_ACTIVE_HIGH>;
 
         rt9467_otg_vbus: usb-otg-vbus-regulator {
           regulator-name = "rt9467-usb-otg-vbus";
-- 
2.7.4

