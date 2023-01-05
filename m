Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B3F65ED05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjAEN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjAENZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:25:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7A392CD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:25:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so2039858pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqO6o8ZziGkIoOqjoSOzWXc91CpV6gR03ce64pYL0vM=;
        b=YcKvS+Lp0xVVZn/icmzAmy07hYJkl0Oy97nHOC/lY3pcQt+0deVNdyXj80mprqXVHo
         JXSuy529B9n57Jgb67pU45VqmzF+xKVFXBvZolr/V07B1wPzMCpQlVQzVvwCyb+HwVXj
         5ukmVlTY1j56EYdU2w1gdVCaQfX7rxXJJWMFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqO6o8ZziGkIoOqjoSOzWXc91CpV6gR03ce64pYL0vM=;
        b=0U6zWdyPiZcnIvBOEMmtMTgrOk9KW2qsBHrQ7CdeDqfkngyTL7GiSmClxWqF4X0Wi8
         zMGnbxYwAYWNvKhHhoA4t3Ki8SCss7xsj6wa0pyIu/6346657rW3ZJQjts+DUZpw3k96
         valLEjs/uAs5Sc9vZ4GKwJnQWRPSzD7JK1mwK19k9VcJEWUtrsUbj7crgFfzUUSPLnDs
         akZ4BabckIHDHSCfb1dQM4xyZhl/fYITYH4tiVSk7EnnU2YR3vNApkK+LcEgRt3E2mWr
         SbvT0C/ZaSaS7EFfoR9OxbieXHDALKZ1vl2HuZQqtcGtLJSZCekxYIu/ASaIlIUBC8qi
         PPbg==
X-Gm-Message-State: AFqh2kr32IB5ZECAaF6vBYl+jEt1rZPz8cjLGNhcYWc0DCL9PN0k9BNl
        9t59na9J5skRBf7wSRYKbGU6vA==
X-Google-Smtp-Source: AMrXdXsTZ912ZfoZw5BCFpbbUQxnFTjLsLf/PBTkCVcY+h6lA8ALjaBDMaumoybWeZcPwt4nYVJb8w==
X-Received: by 2002:a17:90b:698:b0:226:9982:70c9 with SMTP id m24-20020a17090b069800b00226998270c9mr10455808pjz.30.1672925132647;
        Thu, 05 Jan 2023 05:25:32 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7a61:eb85:2e3:2bd0])
        by smtp.gmail.com with ESMTPSA id gk22-20020a17090b119600b00225e670e4c7sm1372682pjb.35.2023.01.05.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:25:32 -0800 (PST)
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
Cc:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Pin-yen Lin <treapking@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v7 4/9] dt-bindings: drm/bridge: anx7625: Add mode-switch support
Date:   Thu,  5 Jan 2023 21:24:52 +0800
Message-Id: <20230105132457.4125372-5-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105132457.4125372-1-treapking@chromium.org>
References: <20230105132457.4125372-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analogix 7625 can be used in systems to switch the DP traffic between
two downstreams, which can be USB Type-C DisplayPort alternate mode
lane or regular DisplayPort output ports.

Update the binding to accommodate this usage by introducing a
data-lanes and a mode-switch property on endpoints.

Also include the link to the product brief in the bindings.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v7:
- Fixed issues reported by dt_binding_check
- Updated the schema and the example dts for data-lanes.
- Changed to generic naming for the example dts node.

Changes in v6:
- Remove switches node and use endpoints and data-lanes property to
  describe the connections.

 .../display/bridge/analogix,anx7625.yaml      | 101 +++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 4590186c4a0b..536dbe8eaf60 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -12,7 +12,8 @@ maintainers:
 
 description: |
   The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
-  designed for portable devices.
+  designed for portable devices. Product brief is available at
+  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
 
 properties:
   compatible:
@@ -112,10 +113,50 @@ properties:
               data-lanes: true
 
       port@1:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
         description:
           Video port for panel or connector.
 
+        patternProperties:
+          "^endpoint@[01]$":
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              reg:
+                maxItems: 1
+
+              remote-endpoint: true
+
+              data-lanes:
+                oneOf:
+                  - minItems: 1
+                    maxItems: 1
+                    items:
+                      enum: [0, 1, 2, 3]
+
+                  - items:
+                      - const: 0
+                      - const: 1
+
+                  - items:
+                      - const: 2
+                      - const: 3
+
+                  - items:
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+
+              mode-switch:
+                type: boolean
+                description: Register this node as a Type-C mode switch or not.
+
+            required:
+              - reg
+              - remote-endpoint
+
     required:
       - port@0
       - port@1
@@ -164,8 +205,12 @@ examples:
                 };
 
                 mipi2dp_bridge_out: port@1 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
                     reg = <1>;
-                    anx7625_out: endpoint {
+                    anx7625_out: endpoint@0 {
+                        reg = <0>;
                         remote-endpoint = <&panel_in>;
                     };
                 };
@@ -186,3 +231,53 @@ examples:
             };
         };
     };
+  - |
+    i2c3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        encoder@58 {
+            compatible = "analogix,anx7625";
+            reg = <0x58>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&anx7625_dp_pins>;
+            enable-gpios = <&pio 176 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+            vdd10-supply = <&pp1100_dpbrdg>;
+            vdd18-supply = <&pp1800_dpbrdg_dx>;
+            vdd33-supply = <&pp3300_dpbrdg_dx>;
+            analogix,audio-enable;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    anx7625_dp_in: endpoint {
+                        bus-type = <7>;
+                        remote-endpoint = <&dpi_out>;
+                    };
+                };
+
+                port@1 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    reg = <1>;
+                    anx_typec0: endpoint@0 {
+                        reg = <0>;
+                        mode-switch;
+                        data-lanes = <0 1>;
+                        remote-endpoint = <&typec_port0>;
+                    };
+                    anx_typec1: endpoint@1 {
+                        reg = <1>;
+                        mode-switch;
+                        data-lanes = <2 3>;
+                        remote-endpoint = <&typec_port1>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.39.0.314.g84b9a713c41-goog

