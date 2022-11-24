Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD163763F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKXKWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKXKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:21:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B815B4E7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ci10so1047469pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI+gZT0pcePdydFoBeIT1UIcJJFwcuKGSk5zJ0RL4tU=;
        b=h0Y+v3WtWtEa8b3ysBdsgKHNq8g5LNo8YXyeBfLFNKlHmk2xzqlJdZf8/dacjprErY
         tqXVFAUTRiP5vbsey1w3Bn7mDO1Aj5qfei74MJMrTMNQGNjyKJFzy0/VEY2MFVV/zBrN
         g0H+3UT1NOjdvCDGiisvDtceQxOMvoHjs9rpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI+gZT0pcePdydFoBeIT1UIcJJFwcuKGSk5zJ0RL4tU=;
        b=f3BFN04f6+0YdWGaO6hgoPmj+i8s16Uca//ylaOmjdHu1K9jae239TQo22yvqzSpfh
         WIL7DgC0lTnp0pS7CuG56eo3w/Zxp3TZYzFGOrT2dpl5pcxx0mRdIU8Fr6f0RsK9DO6N
         kOaBkuT8anFkmiHLRH4HUrKQEGaYytdwAA+5X6mlW29DIzIniHbs3x06taFzxG/CWK4N
         taUlnKHEYlCqPmYAJ1eUc3dqhj8VeAau2jo8i5CM11Qsx9Tt1qeK7UpsNxPwhffTs6oQ
         bSr1IU0ABuAWVocf9tkNngWF3NTHLG3RXAlavxJ0HvFV+9PyQoEVIoZ32PCzOTXJ/T7w
         WS9w==
X-Gm-Message-State: ANoB5pnLz6Ta2o59YWGcs8bAWyMOPGgHpHRE8EK2g5AIxdfFjiCIt0Xw
        X4C8UeUhZh6/8oFBfypag+h/bw==
X-Google-Smtp-Source: AA0mqf7hh4W9Fkbv8iFQguyRhGwjrTAFkMKQsz1viXpfZVWTjFkqR6ffAp9vqXowTDad2gm63u4YVA==
X-Received: by 2002:a17:902:b613:b0:181:9900:18df with SMTP id b19-20020a170902b61300b00181990018dfmr13219005pls.70.1669285305357;
        Thu, 24 Nov 2022 02:21:45 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:d446:708:8556:dfee])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b005747b59fc54sm854584pfb.172.2022.11.24.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:21:44 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
        chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org,
        Marek Vasut <marex@denx.de>, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Subject: [PATCH v6 6/7] dt/bindings: drm/bridge: it6505: Add mode-switch support
Date:   Thu, 24 Nov 2022 18:20:55 +0800
Message-Id: <20221124102056.393220-7-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221124102056.393220-1-treapking@chromium.org>
References: <20221124102056.393220-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ITE IT6505 can be used in systems to switch the DP traffic between
two downstreams, which can be USB Type-C DisplayPort alternate mode
lane or regular DisplayPort output ports.

Update the binding to accommodate this usage by introducing a
data-lanes and a mode-switch property on endpoints.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v6:
- Remove switches node and use endpoints and data-lanes property to
  describe the connections.

 .../bindings/display/bridge/ite,it6505.yaml   | 94 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
index 833d11b2303a..b4b9881c7759 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
@@ -52,9 +52,53 @@ properties:
     maxItems: 1
     description: extcon specifier for the Power Delivery
 
-  port:
-    $ref: /schemas/graph.yaml#/properties/port
-    description: A port node pointing to DPI host port node
+  data-lanes:
+    maxItems: 1
+    description: restrict the dp output data-lanes with value of 1-4
+
+  max-pixel-clock-khz:
+    maxItems: 1
+    description: restrict max pixel clock
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: A port node pointing to DPI host port node
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port-base
+        description:
+          Video port for panel or connector.
+
+        patternProperties:
+          "^endpoint@[01]$":
+            $ref: /schemas/media/video-interfaces.yaml#
+            type: object
+            unevaluatedProperties: false
+
+            properties:
+              reg:
+                maxItems: 1
+
+              remote-endpoint: true
+
+              data-lanes:
+                minItems: 1
+                uniqueItems: true
+                items:
+                  - enum: [ 0, 1, 2, 3]
+
+              mode-switch:
+                type: boolean
+                description: Register this node as a Type-C mode switch or not.
+
+	    required:
+        - reg
+	      - remote-endpoint
 
 required:
   - compatible
@@ -62,7 +106,7 @@ required:
   - pwr18-supply
   - interrupts
   - reset-gpios
-  - extcon
+  - ports
 
 additionalProperties: false
 
@@ -92,3 +136,45 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    &i2c3 {
+        clock-frequency = <100000>;
+
+        it6505dptx: it6505dptx@5c {
+            compatible = "ite,it6505";
+            interrupts = <8 IRQ_TYPE_LEVEL_LOW 8 0>;
+            reg = <0x5c>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&it6505_pins>;
+            ovdd-supply = <&mt6366_vsim2_reg>;
+            pwr18-supply = <&pp1800_dpbrdg_dx>;
+            reset-gpios = <&pio 177 0>;
+            hpd-gpios = <&pio 10 0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    it6505_in: endpoint {
+                        remote-endpoint = <&dpi_out>;
+                    };
+                };
+                port@1 {
+                    reg = <1>;
+                    ite_typec0: endpoint@0 {
+                        mode-switch;
+                        data-lanes = <0 1>;
+                        remote-endpoint = <&typec_port0>;
+                    };
+                    ite_typec1: endpoint@1 {
+                        mode-switch;
+                        data-lanes = <2 3>;
+                        remote-endpoint = <&typec_port1>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.38.1.584.g0f3c55d4c2-goog

