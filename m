Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE7613DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJaTCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:02:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E0C6464;
        Mon, 31 Oct 2022 12:02:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l32so7677351wms.2;
        Mon, 31 Oct 2022 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oV8q4wH8HpohJNQjMdeR7O1zCaZlSwCcpOd8wfP+xo=;
        b=CkmNTdCg2hm0WKFji5qn+ppi0wBgT0tymI0lGqt8zxO/GV/swvpxIzhFKsUcN8OJ2F
         7wWFzfaJnQK29Ob5JTj+SW+p4OELn3tpBiNM8QC2vl7xxs1SfHLQM3zKtItbYez7WAHM
         jMDmLDcK4NQVxdkXo/xk8yqqXxVqrIcaUaZxHAucpIu0BcQiqDHymdgZmEwOH+xrtbGn
         zyJ3ofscC5xzf5J4j4U9iFE1fyP5k6seTBkLqDtHpnLkyoI+C7yrqJGOAubKj/AT5CRv
         32wvoqsJiEpCVKbiekhrxHdoTOP0utH48+xbnvJ/NPv/0TbsjWKwB/RJvWHpwv7OkJqw
         7T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oV8q4wH8HpohJNQjMdeR7O1zCaZlSwCcpOd8wfP+xo=;
        b=lUHq6TyPV3Y8jV1nFEqGpv6JX6e+m2l5A34Y6PZuT2gSvEBLVGZiyhsJlZQhDxzbif
         96y6imTc/o+smZYqOdYNlqvQKVV5eP9rjGFj2wmj1fJ6lAJ0ZX1p3ipnEolleOzxQT1Z
         If5VJ/keB+hFMxvryfJ9B5uTaWR8XuJc2VjyjbdQp5DI5d1DlcqyGtjoAj4TKsvJMaJS
         ZUFYJqqESDMWaRnMH1gN3zZPOyWSCmwLiggFldNtrnzG1b9mLOFWH3QT5JlD4ypkV39z
         enW4fB69ZMlz5+XsuXIr8EftTsm67GibkHmcicLN9niLNlnlxn2G5jDSbzZlFYh7Rf7z
         JWcw==
X-Gm-Message-State: ACrzQf31UCKyO5QutNKTiO97tTg3WGgbFPX2HvpXE9KVNROdMi52xryE
        wGIDZC0uegPBarD/IgSOHP8=
X-Google-Smtp-Source: AMsMyM6an+h8DT653j80VCIZ2lAUUYqeZ+j2b92KBjL0rtiB3+pJxS5ESw8vtrP0Fpf+THDLvEnZjA==
X-Received: by 2002:a7b:c4cf:0:b0:3cf:497c:ae3a with SMTP id g15-20020a7bc4cf000000b003cf497cae3amr19112421wmk.177.1667242953401;
        Mon, 31 Oct 2022 12:02:33 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003a2f2bb72d5sm9141750wmc.45.2022.10.31.12.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:02:32 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Siarhei Volkau <lis8215@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: adc-joystick: add valid-range
Date:   Mon, 31 Oct 2022 22:01:58 +0300
Message-Id: <20221031190159.1341027-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221031190159.1341027-1-lis8215@gmail.com>
References: <20221031190159.1341027-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid-range property aims to cover detachable/lock-able
joysticks where measured value goes outside valid-range.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 .../bindings/input/adc-joystick.yaml          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index da0f8dfca..0483f0afe 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -91,6 +91,20 @@ patternProperties:
           Omitting this property indicates the axis always returns to exactly
           the center position.
 
+      valid-range:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - description: minimum value
+          - description: maximum value
+        description: >
+          Minimum and maximum values which are still valid for the axis.
+          If the value is outside the range an event won't emitted.
+          Shall fully cover the abs-range with some space added,
+          to take into account imprecise analog nature of the joystick.
+          When value goes out of valid range - corresponding axis is
+          centered. The center point calculated on abs-range basis.
+          This property is interpreted as two signed 32 bit values.
+
     required:
       - reg
       - linux,code
@@ -125,3 +139,51 @@ examples:
               abs-flat = <200>;
       };
     };
+  # A rather complex joystick hardware definition
+  # with two axes muxed into one ADC channel.
+  - |
+    #include <dt-bindings/iio/adc/ingenic,adc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    gpio_mux: mux-controller {
+      compatible = "gpio-mux";
+      #mux-control-cells = <0>;
+
+      mux-gpios = <&gpe 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    adcmux: adc-mux {
+      compatible = "io-channel-mux";
+      io-channels = <&adc INGENIC_ADC_AUX>;
+      io-channel-names = "parent";
+      #io-channel-cells = <1>;
+
+      mux-controls = <&gpio_mux>;
+
+      channels = "joystick-axis-x", "joystick-axis-y";
+    };
+
+    joystick: joystick {
+      compatible = "adc-joystick";
+      io-channels = <&adcmux 0>, <&adcmux 1>;
+      io-channel-names = "joystick-axis-x", "joystick-axis-y";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      poll-interval = <16>;
+
+      axis@0 {
+        reg = <0>;
+        linux,code = <ABS_X>;
+        abs-range = <3400 670>;
+        valid-range = <300 3700>;
+      };
+
+      axis@1 {
+        reg = <1>;
+        linux,code = <ABS_Y>;
+        abs-range = <670 3400>;
+        valid-range = <300 3700>;
+      };
+    };
-- 
2.36.1

