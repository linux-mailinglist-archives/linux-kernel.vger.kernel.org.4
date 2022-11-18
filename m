Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23E662EDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiKRGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbiKRGkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5082BDA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so3355213wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6tFEMtBh3ilrlAcOEMTxiLXV0PbJ6qC9TxuM/fjwWE=;
        b=j7FRe43l2XVbwLA5mr0jmObCXYe6kgQQq8whf0nv3xIVGWzGIs6wzaEoNWxguRGgFi
         7kKJfotlEsXHLgQLQtrAtJ4FFtv4fK18J+v98jNwDiK1uGnC4XHheUIgJ37aosI9i8IN
         MUhmd4W8qhGP+bkByCj31BKj97YkX9HaFfbs1n6iyWtLWmZOFQ/sx7NhXhJS6ieA2M3f
         bXibX8RWZIq7to9fZ8jBtuS2xsMkmHvN4SU1xXDjjmpGTWpNrlTPur9+m5mGgkZWKwsU
         UCqthP7nxcFzBE+TrlWhS6QhQz9ftsKuS2SH7k17vOlH5noXmRuJFbNFDSCpk9d+hA7z
         GLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6tFEMtBh3ilrlAcOEMTxiLXV0PbJ6qC9TxuM/fjwWE=;
        b=vQeZ5waH8HosAGK0IS4h9jQOcCgTFTnczOUl6gPryCw/vicbvm3/wDkVVvMD8xFM7a
         RwIOvJ0jp3VSmEJYZKETtST5ZYqF9iIP6yKUQbDrGtdmTUVXQbDbarBCb9W06jZlRWoy
         hG01pB+iy3DooEdMfbqEe8udtkUxuSLMDPGhdqRGwqJr/pcy/VfqrFKUOUHWpBPqTQVy
         JKze2Ocea+ufdmzHDw6KOCTnsjvLaQXTUF74DPBslwMPhwDP6wyuBJ/kpwZzMU+eiK/v
         Fp4lTL5FsOWJc29cDG6ewY6hBMUBlJW7b7tO02HpWRg47l4X7QJGGiJkFJvIkulroJhD
         ZGUQ==
X-Gm-Message-State: ANoB5pk8/ffDipNy/gMMsFZMwvKLVbZTS39j41q8yBDclWDVOCGwh76s
        WpenbwgMR+GZVq+ORsXkVXsGjI2gXTB7hQ==
X-Google-Smtp-Source: AA0mqf6DwC64eDwhjQ6cOi25Dlsf9Rrw/KP6M49WmE1HjQxEjMdjEk1xSj0tvE9NcPi3No7LAGVE+g==
X-Received: by 2002:a1c:2b81:0:b0:3b4:88ba:a74c with SMTP id r123-20020a1c2b81000000b003b488baa74cmr7536110wmr.77.1668753604974;
        Thu, 17 Nov 2022 22:40:04 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/13] dt-bindings: eeprom: Inherit from nvmem.yaml
Date:   Fri, 18 Nov 2022 06:39:29 +0000
Message-Id: <20221118063932.6418-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

EEPROMs can be nvmem providers. Let's make all EEPROM bindings
reference nvmem.yaml as they should, so that nvmem cells and layout
parsers can be safely described within the EEPROM nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

