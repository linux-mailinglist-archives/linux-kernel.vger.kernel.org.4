Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36216562EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLZNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiLZNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7212110D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672062566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw7xpxVI9Q/Jnt3L05urCEGaaPOXvycGiSQd0FrpIik=;
        b=KjEJJa3exCPgBlZhn11G2jOupsf4SsmtnhfK0NZ93TUfRuUL3f4EryYBIH0W5QFkT2rAo/
        l036xHm13WKPiEkhZH7ree+8K0DH+lTGUM+ENz6rzLz+obLc+4iMZ3MpAxJku2x1nSMO5r
        wYckTZwllqzgRamJ1dFNUM+DpY7HUn4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-OUKp_NuVOkCU1ahXR8Gcbw-1; Mon, 26 Dec 2022 08:49:25 -0500
X-MC-Unique: OUKp_NuVOkCU1ahXR8Gcbw-1
Received: by mail-wm1-f71.google.com with SMTP id m38-20020a05600c3b2600b003d1fc5f1f80so8116676wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mw7xpxVI9Q/Jnt3L05urCEGaaPOXvycGiSQd0FrpIik=;
        b=IlRPVFWU5FIB/ZzEBHJ/zqKpMbxhiyKrdFsE3Q/z4SrhT0D7gQa2WJHZeXkbTFcL8p
         kQXhOZCNWjM20L5clc6q4VllxVvCWwYIpJOc+36zjuRgbVTvIg8BkUxA0vXCJdYoLDe/
         S4XNSyiZiCENKTv/dJdtzIuQh+quNsiWiRz0up2LulZRuBlkRj94ypv4VWi3aFeSeV5x
         L60rS5nrIumhwbKPeOmRzznwL0SOLu44rlbqqESkCFx+CLsEvlpiNXM5Sfa12QAImMWq
         2YIHI4c8nqgCzAF9Z2seOAAM+l23B9yI581kxv5igrbnoGIf8xpbH6zlQlQZEoF5jeU/
         gnhg==
X-Gm-Message-State: AFqh2koxmqa5cde+YTFGEXeodPyLGEa1D2o4Tx9Mzg0CDfx2QBhrEHv+
        M9EEK6j1EaZSyaCmM830SnKk0CC1YkazphwAkQ+fQi4a3uIhLhVwmbWdwM3xgDrnlue4idFCMD2
        KxF3F1CZtULDFhtbvdjp/XRPD8bl5Y20CJl1zB9TB/Mshl8QWn1LvZn4TkeJLOA9oL33dHyVv8X
        M=
X-Received: by 2002:a05:6000:1246:b0:24f:869a:6c13 with SMTP id j6-20020a056000124600b0024f869a6c13mr11747365wrx.2.1672062563948;
        Mon, 26 Dec 2022 05:49:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUvZdjNR7Fa8fpKiew/GyjwBoEhaZv2N568YBi4HBO08rtzrVuxhbL312QdhdG1u5YjDEtcA==
X-Received: by 2002:a05:6000:1246:b0:24f:869a:6c13 with SMTP id j6-20020a056000124600b0024f869a6c13mr11747344wrx.2.1672062563708;
        Mon, 26 Dec 2022 05:49:23 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a18-20020adfed12000000b0027cfd9463d7sm3340947wro.110.2022.12.26.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 05:49:23 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/4] dt-bindings: display: Add Himax HX8394 panel controller
Date:   Mon, 26 Dec 2022 14:49:06 +0100
Message-Id: <20221226134909.2822179-3-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226134909.2822179-1-javierm@redhat.com>
References: <20221226134909.2822179-1-javierm@redhat.com>
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

Changes in v2:
- Drop redundant "bindings" in subject (Krzysztof Kozlowski).
- Drop "device tree bindings" in title (Krzysztof Kozlowski).
- Put port next to other "true" properties (Krzysztof Kozlowski).
- Add Krzysztof Kozlowski's Reviewed-by tag.

 .../bindings/display/panel/himax,hx8394.yaml  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
new file mode 100644
index 000000000000..bead3f0b05c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -0,0 +1,65 @@
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
+  vcc-supply:
+    description: Panel power supply
+
+  iovcc-supply:
+    description: I/O voltage supply
+
+  port: true
+
+  reset-gpios: true
+
+  backlight: true
+
+required:
+  - compatible
+  - vcc-supply
+  - iovcc-supply
+  - port
+  - reset-gpios
+  - backlight
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
+        };
+    };
+
+...
-- 
2.38.1

