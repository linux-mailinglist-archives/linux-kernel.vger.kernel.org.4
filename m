Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1D6E8036
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjDSRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:19:00 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B58769D;
        Wed, 19 Apr 2023 10:18:57 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 25DB11C0003;
        Wed, 19 Apr 2023 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681924736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IKopK6ySs5davKjamt5/6SrPTUXqWy10uMvUkbDLpMw=;
        b=opbBz3i4AlnSeXYPRzVoCf/grp9GjMYTtivQDNZDLVgCVm2kcMxsrWz7UkG95gNA5IbwPR
        RH9tC1I5NRjBPKbef++M45g259SeHE4cjL9XUrE+Oi26zlxSh+qu9jnwmC/4zx4xxcgnse
        NGeziyfdGb3Z5tGbW/wDSJPA+RSfxgRgKw+MehLb592JbWDBji9uiUBwGDrbT6jYYoQO1A
        PZx+C7d0GHxeJ12x8JS/AY+e4404RskSWuVQB3Kz7wjmt5ijldXyAd6EJ97N2PoDAosDz7
        2cl3oCUwZhL+SqCJLiChkGMnxDMQ/oi3wDYsUOejQ6//5yzaJQxuQImSCLcqUA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] dt-bindings: input: touchscreen: goodix: clarify irq-gpios misleading text
Date:   Wed, 19 Apr 2023 19:18:49 +0200
Message-Id: <20230419171849.946986-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq-gpios description misleading, apparently saying that driving the
IRQ GPIO resets the device, which is even more puzzling as there is a reset
GPIO as well.

In reality the IRQ pin can be driven during the reset sequence to configure
the client address, as it becomes clear after checking both the datasheet
and the driver code. Improve the text to clarify that.

Also rephrase to remove reference to the driver, which is not appropriate
in the bindings.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../devicetree/bindings/input/touchscreen/goodix.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
index 3d016b87c8df..26ad104052ba 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
@@ -37,8 +37,8 @@ properties:
     maxItems: 1
 
   irq-gpios:
-    description: GPIO pin used for IRQ. The driver uses the interrupt gpio pin
-      as output to reset the device.
+    description: GPIO pin used for IRQ. The IRQ line can be driven during the
+      reset sequence to configure the client address.
     maxItems: 1
 
   reset-gpios:
-- 
2.34.1

