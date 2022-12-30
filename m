Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE46597B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiL3LdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiL3LdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BEB1AD9C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672399941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c32qrgWmsjRJO1IBGWxTMshwA3bwdd46Bo/ATwGKrQ0=;
        b=M3l5jAMkQ69EMarAXpviqCPaiQkZggW38FMGvw4eKUPP6EdxRm2gZnwz9hT/WdWhimCUzx
        ACFC0DF+4WL6KCSFI+JUFxHSbgd41/RFf0MwJ7iu2zyjsrSQwM9+Wjam+OJgQAo6cIOnxV
        i+a7iqB/c0CDZMu7TUObc2u4jXgmTYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-vtZVmYCHMTOnN7yrVzl4_w-1; Fri, 30 Dec 2022 06:32:20 -0500
X-MC-Unique: vtZVmYCHMTOnN7yrVzl4_w-1
Received: by mail-wm1-f71.google.com with SMTP id c66-20020a1c3545000000b003d355c13229so14138771wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c32qrgWmsjRJO1IBGWxTMshwA3bwdd46Bo/ATwGKrQ0=;
        b=ZDgre1f/W/yXkm9cZ3NCKHaneMS7r53CnChqSLjpFtmgRJwEFORBhdhlOaWh5lEziF
         PG4XGVIrqgZjJmeAhbbkB5OSrDvSBnB2dgazmStUNyeNP5e4eZ1QoanOSkFT5yRx7gA9
         +ODJg/acBeuzzEoMH0Nox9YCWmTm65mPuO/zfQCx8+Cy7W/cRmUCB7OaGAcmvVZBkIx/
         3AeN6vfEGSl71VPQ3Xm6p8tRW+izK390rsOJWl/Ve5qkHpfbK1UOi+EF+etHfQufqPjC
         xDgclF+/W5zgcL27Ql50xiKA2eRl+I5+nheoYDz9ObDN3n6Kkt36QcruIhKxUs/SrEx7
         ry7A==
X-Gm-Message-State: AFqh2kr676c9EAH5+TkWVnTj7XwKI00Ai8WztPcFY2+tq7UI5y+CxaFw
        6rSIRCuZ2U85y/x9DiBQBFAHTT2y+rvAuXEreVCj0N3dX7GsWDv1Oa9BTHHZ5j3TbdZjHSe5chb
        HvmNzGITFJJ9ZbcwYOWG8E1MFQqfCa1IqZeywLTmLUGI384xFr5MSejfbiP488fQCuvoVeu00PB
        0=
X-Received: by 2002:a05:600c:214a:b0:3cf:6910:51d4 with SMTP id v10-20020a05600c214a00b003cf691051d4mr22097946wml.29.1672399939101;
        Fri, 30 Dec 2022 03:32:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuyvNz4H4CAUhlF4mxnZIIIX/2FxJMl1v41S8jUhr1TFV0zd/ZnoTK01haVO0OFBOoUnJaEbQ==
X-Received: by 2002:a05:600c:214a:b0:3cf:6910:51d4 with SMTP id v10-20020a05600c214a00b003cf691051d4mr22097907wml.29.1672399938744;
        Fri, 30 Dec 2022 03:32:18 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b003d01b84e9b2sm27638432wma.27.2022.12.30.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 03:32:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org, Ondrej Jirman <megi@xff.cz>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: display: Add Himax HX8394 panel controller
Date:   Fri, 30 Dec 2022 12:31:51 +0100
Message-Id: <20221230113155.3430142-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230113155.3430142-1-javierm@redhat.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

Changes in v4:
- Add fallback "himax,hx8394" compatible for the panel controller (Jagan Teki).

Changes in v3:
- Fix example snippet for `make dt_binding_check` to pass (Krzysztof Kozlowski).

Changes in v2:
- Drop redundant "bindings" in subject (Krzysztof Kozlowski).
- Drop "device tree bindings" in title (Krzysztof Kozlowski).
- Put port next to other "true" properties (Krzysztof Kozlowski).
- Add Krzysztof Kozlowski's Reviewed-by tag.

 .../bindings/display/panel/himax,hx8394.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
new file mode 100644
index 000000000000..058b4eae68a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -0,0 +1,75 @@
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
+    items:
+      - enum:
+          - hannstar,hsd060bhw4
+      - const: himax,hx8394
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
+            compatible = "hannstar,hsd060bhw4", "himax,hx8394";
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

