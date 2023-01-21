Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3A56767DC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjAUR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAUR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD3274BC;
        Sat, 21 Jan 2023 09:57:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so7995400plo.1;
        Sat, 21 Jan 2023 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWhDX4KFx106+qYAgyDcB+XV4NL80nKQ25X8LQ/8aus=;
        b=ptnIGJ7DHlTlXBsb2o7MvDKWy8JBZq11tBcdFBh4UHANl+tKS+pEJZ8tT7YNHuAnyA
         TSufAnWU1xEd3/+wEjZxB6rDVlH5WeOl6Poo/QwTSMsYdnEpGyznE0IDCxNk2Ob0dUXl
         aCOfkWwWk/+76atl6KE0kb9cDkgsYb5EY4KfOxSlraTC02RehhvwRUGBJEUfEVv/xmjQ
         OJ8bda9FoymRtpZNoFKAqotul3t9BkNOyz1/KqMkyCdSats/qU5zirhpKBuHzDXP6N1f
         B0HaBrk8luJEYD7LQzp9vQN0GtsB2RdF6MZV8WSHiHuega+vq/biFnbASLT0/49mQXH0
         h0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWhDX4KFx106+qYAgyDcB+XV4NL80nKQ25X8LQ/8aus=;
        b=stk6Jqb8YnO3BnJDPNdvQSqtCCMCgpCRzyYGcjck3uOsZaSlBLG7za037Mf7KX8qJY
         rdA3QnfmAP8W2cJCbQeYWUrGHw4GraO23kueA33U9+XMt2EE3kVvDw/n1b0ZhxzYn3wk
         xz4d/W30c6BhAFuZSIIU8ROC6BXox3CrRfGXhEDQJ9IFDVDvpadb8kd3L074sxVqVrpl
         MtFUqXBCSgV9tKq94/2kzEvUDgQsun5BGcV2TkxBHCfDbW4idzx+ymicBPoHEXIubDG0
         CaJsUlfyZpQw+YaRvSQIqtz4O2RGw9x4YlFd1jokXVB1eNS12K8NTJ8goVbiHwNYsoWL
         zoFQ==
X-Gm-Message-State: AFqh2kpNDZGAphEmhEaVAqjA8tVQ+tK5CTuzd9iOtEXitr0RXXYE+hDS
        B4E2EOO6jh7O6rUyn3aZnxg=
X-Google-Smtp-Source: AMrXdXtkECfuRVbf5RNXn7jC9dWHZYTvp6jDX/+/JRhq0UUsYz3F5pz49H/ZJ7msZ33qySMylf336w==
X-Received: by 2002:a05:6a20:a593:b0:af:aa38:12e0 with SMTP id bc19-20020a056a20a59300b000afaa3812e0mr22380250pzb.34.1674323854075;
        Sat, 21 Jan 2023 09:57:34 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:33 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] dt-bindings: usb: Add Via lab VL817 hub
Date:   Sat, 21 Jan 2023 17:56:34 +0000
Message-Id: <20230121175639.12818-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIA Lab VL817 is a USB 3.1 Gen 1 hub and USB 2.0 hub
controller that features 4 downstream ports and 1 otg, with
an internal 5V regulator and has external reset pin.

Add a device tree binding for its USB protocol part.
The internal LDO is not covered by this and can just be modelled
as a fixed regulator.

Add combo of USB 2.0 and USB 3.0 root hub using peer-hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3 - address review coments - Krzysztof
     dropped dr_mode
v2 - fix the compatible string and fix the $id
   - update the commit message.
   - update the example for use peer-hub node because it
     combo of USB 2.0 and USB 3.0 hub.
   - rename the yaml file from vialab,vl817q7.yaml to vialab,vl817.yaml
     as q7 suffix is ued for USB 3.1 and q5 suffix is used for USB 2.0.
---
 .../devicetree/bindings/usb/vialab,vl817.yaml | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817.yaml

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
new file mode 100644
index 000000000000..23a13e1d5c7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/vialab,vl817.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Via labs VL817 USB 3.1 hub controller
+
+maintainers:
+  - Anand Moon <linux.amoon@gmail.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb2109,2817
+      - usb2109,817
+
+  reg: true
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling the RESET# pin.
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+  peer-hub:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the peer hub on the controller.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - peer-hub
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* 2.0 hub on port 1 */
+        hub_2_0: hub@1 {
+            compatible = "usb2109,2817";
+            reg = <1>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+        };
+
+        /* 3.1 hub on port 4 */
+        hub_3_0: hub@2 {
+            compatible = "usb2109,817";
+            reg = <2>;
+            vdd-supply = <&vcc_5v>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.38.1

