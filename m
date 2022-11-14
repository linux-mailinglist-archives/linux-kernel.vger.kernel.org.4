Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37E7627849
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiKNI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiKNI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:57:12 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB801C401;
        Mon, 14 Nov 2022 00:57:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8F3E410000B;
        Mon, 14 Nov 2022 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RuwsiKOoT3RSiv0ATWGMePKlt2FePql8/L/NJA2t6w=;
        b=drBSkcHiGiZIoU8VLro96xlsTfAl0dgPYa0+Cv2zh2EBC5K124WsKrQdPmfcQOFl0KPpH9
        kk7VpvjLl56WgiMO2s+9X5RZXZ9UR/W6prHjQzSMtYwzA8KiCwQitzldAmX9ix4xGJpNBt
        RwOl9o359I8aEN0wYn/OOdNsIExx2lxZRGboJEEwZqtS/yq0B8H1IGvTAuZhWvIvKjtHfp
        roS++IRFlm58JFSDVQX/IXx8PyHpJJ0WbxrkQ/bHbR+lTUtOB4H7FgXtx7P1N64VgAL7k0
        6JXj+bA3XwjwvPIlN6s5/0Wn571UgTE4KL00ISuTF9L2TmmoEto6bOzuZB4ZYQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 2/5] dt-bindings: eeprom: Inherit from nvmem.yaml
Date:   Mon, 14 Nov 2022 09:56:56 +0100
Message-Id: <20221114085659.847611-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114085659.847611-1-miquel.raynal@bootlin.com>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEPROMs can be nvmem providers. Let's make all EEPROM bindings
reference nvmem.yaml as they should, so that nvmem cells and layout
parsers can be safely described within the EEPROM nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml           | 5 ++++-
 Documentation/devicetree/bindings/eeprom/at25.yaml           | 1 +
 .../devicetree/bindings/eeprom/microchip,93lc46b.yaml        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index d14e0accbda8..84af0d5f52aa 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -10,6 +10,9 @@ title: I2C EEPROMs compatible with Atmel's AT24
 maintainers:
   - Bartosz Golaszewski <bgolaszewski@baylibre.com>
 
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml
+
 select:
   properties:
     compatible:
@@ -183,7 +186,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 8b1c997caac1..0f5a8ef996d3 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -104,6 +104,7 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/nvmem/nvmem.yaml
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
index 0c2f5ddb79c5..64cfd971c9c5 100644
--- a/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
+++ b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
@@ -47,6 +47,7 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/nvmem/nvmem.yaml
 
 unevaluatedProperties: false
 
-- 
2.34.1

