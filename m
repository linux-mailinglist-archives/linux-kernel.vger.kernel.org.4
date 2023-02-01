Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDAA6868AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjBAOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjBAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:10 -0500
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 06:43:04 PST
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3E206AC;
        Wed,  1 Feb 2023 06:43:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18DBAC0332;
        Wed,  1 Feb 2023 15:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262101; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=tRPLVPhQGfVkVFWzPuN9DvSL3QBjCj23rMy0j/6al9U=;
        b=CwqeB4dTR4bNwnbWH+uy8G3p5eaDqx2CL3VBGwSjEhHDwdgRV1RpUGfDxY1zycrhDuROCk
        /VL8MRxVzVbgNf0WUqKIDEuNKuGk9blUnlz1j+ZieGIKne3DjlrR4G71P8WZrLF1h0N+LG
        gPOljEtesiFpL5OnCMJ33a93OGGqmMNiN8AINW+IQ6naVFFtgmWnEfkeYD9mJiBkVXWj6G
        x6NqTYHYxqhpFbmfE2lG584wmUtL38K4wiNF5dETxa8DYmEvoyq8XlhxZZ72b5VufBguAK
        6xhGrusdfgmCd1JiuRPHvKvct3JhNAK3KEcN7K/b6XhAm11vHVvY8f1iqCDiGg==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 3/7] dt-bindings: rtc: microcrystal,rv3032: Add backup-switch-mode property
Date:   Wed,  1 Feb 2023 15:34:25 +0100
Message-Id: <20230201143431.863784-4-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
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

Add the new backup-switch-mode property that allows to set the BSM
via devicetree.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../devicetree/bindings/rtc/microcrystal,rv3028.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
index 4667ba86fd0c..2637c4c313ac 100644
--- a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
@@ -22,6 +22,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  backup-switch-mode: true
+
   start-year: true
 
   trickle-resistor-ohms:
@@ -40,6 +42,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/rtc/rtc.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -49,6 +52,7 @@ examples:
             reg = <0x52>;
             pinctrl-0 = <&rtc_nint_pins>;
             interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            backup-switch-mode: <RTC_BSM_LEVEL>;
             trickle-resistor-ohms = <3000>;
         };
     };
-- 
2.39.1

