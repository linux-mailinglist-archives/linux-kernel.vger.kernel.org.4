Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4007C6569B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiL0LFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiL0LE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355C95A4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672139024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woUir0Lts/Iv/2E8U+LoYyfYL4VWI99Q3r6CZZFNa7I=;
        b=iJMWltozYAWAlvI0LG0WBiOAwmpWcbgwcz7Ouu22+0Yb0D/NrjMfzk5dSbU8C4hrty9b1s
        7zk2+X09fIyCUo0HLSeid3kX2kfAYTiyJcbjXAi+OMFKL7KbyV8FlfysHaLLs91QnvWsj5
        2iEkzGztMP0Kn4r9Nc2SRrjm+YzCTd0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-1QJBs5ptO6iLaDaJpdW8Hg-1; Tue, 27 Dec 2022 06:03:43 -0500
X-MC-Unique: 1QJBs5ptO6iLaDaJpdW8Hg-1
Received: by mail-wr1-f71.google.com with SMTP id j27-20020adfa55b000000b0027f710a6ceeso364028wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woUir0Lts/Iv/2E8U+LoYyfYL4VWI99Q3r6CZZFNa7I=;
        b=Xbw9lDKHI8NPgf5uMeKB8qKZqfEfnVVy5yYnPL+vsJ7O1HcwT5i4/ielQTHc/4somv
         0g1cs4CJ6S4dJKJBeTG14C7CWT3T2lNqfr9PyJE7WAsR9qKcBjbqN8nnXUWstQo6NquF
         sON6MKBvvRbTJ/riXdjGkIBeYBpmpwswFh07dDC2T/aLUDSjXlMz1oyFhn1v47II5U7D
         2cn4RlFLupzBR4d4iXkv9SKWyqP3oJcfsMOxljGokYs5JWRmGVt8esr4z9KOcqLQos7R
         Kxt/T8h3Q2izGMvDYRk7oc5V8ei09sEfFtu6ARGRGNyQnD+ebMvjebNqlnMkIXQ4i6zZ
         y2dA==
X-Gm-Message-State: AFqh2kq+lgqqROrYkM2c6/7lBa3BbvO3IYsOSuKH2ptV9WQI6qwveFEr
        GoJwMqoUM4djJeKuHhUK5NUU30Fcaox8/mxCaxMD2XJNA51TKlwSS+Gq4Wm3YOFGsDcosTBgBVJ
        IOpWXKkwgao6sKzQhbmK3/FpEjGJ0I2oJJpsanoabEEJPwWVYxcpVAw6+h9GtadA81pfvD0lO+v
        g=
X-Received: by 2002:adf:e283:0:b0:242:324e:b3d with SMTP id v3-20020adfe283000000b00242324e0b3dmr12664704wri.1.1672139021706;
        Tue, 27 Dec 2022 03:03:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7zMUDKll3qV0ZETnVhuW7RvKZ8fTiq1amBtPxkYibGhjX8ph/GklBGnF4PA+Z7Kdki684zg==
X-Received: by 2002:adf:e283:0:b0:242:324e:b3d with SMTP id v3-20020adfe283000000b00242324e0b3dmr12664672wri.1.1672139021448;
        Tue, 27 Dec 2022 03:03:41 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p18-20020a056000019200b00279d23574c4sm7374557wrx.13.2022.12.27.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 03:03:41 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: display: Add Himax HX8394 panel controller
Date:   Tue, 27 Dec 2022 12:03:32 +0100
Message-Id: <20221227110335.2923359-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221227110335.2923359-1-javierm@redhat.com>
References: <20221227110335.2923359-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for panels based on the Himax HX8394 controller,
such as the HannStar HSD060BHW4 720x1440 TFT LCD panel that is connected
through a MIPI-DSI video interface.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
- Fix example snippet for `make dt_binding_check` to pass (Krzysztof Kozlowski).

Changes in v2:
- Drop redundant "bindings" in subject (Krzysztof Kozlowski).
- Drop "device tree bindings" in title (Krzysztof Kozlowski).
- Put port next to other "true" properties (Krzysztof Kozlowski).
- Add Krzysztof Kozlowski's Reviewed-by tag.

 .../bindings/display/panel/himax,hx8394.yaml  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
new file mode 100644
index 000000000000..fb1981cacfc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx8394.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX8394 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+description:
+  Device tree bindings for panels based on the Himax HX8394 controller,
+  such as the HannStar HSD060BHW4 720x1440 TFT LCD panel connected with
+  a MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      # HannStar HSD060BHW4 5.99" 720x1440 TFT LCD panel
+      - hannstar,hsd060bhw4
+
+  reg: true
+
+  reset-gpios: true
+
+  backlight: true
+
+  port: true
+
+  vcc-supply:
+    description: Panel power supply
+
+  iovcc-supply:
+    description: I/O voltage supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - backlight
+  - port
+  - vcc-supply
+  - iovcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "hannstar,hsd060bhw4";
+            reg = <0>;
+            vcc-supply = <&reg_2v8_p>;
+            iovcc-supply = <&reg_1v8_p>;
+            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                mipi_in_panel: endpoint {
+                    remote-endpoint = <&mipi_out_panel>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.38.1

