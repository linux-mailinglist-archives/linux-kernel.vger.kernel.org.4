Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830A06E387C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjDPNIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjDPNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:08:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C3C2122;
        Sun, 16 Apr 2023 06:08:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw30so4574646ejc.5;
        Sun, 16 Apr 2023 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650486; x=1684242486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/HOJNcL7jdKqwCHI8Ml1ezJfov1pJyurOhORPKyJms=;
        b=fEX+/66QON1CimKQ44axbXAR1jljjeY8kP4tpF8xW4+ZHCVK/yIstCDRUlL4+/ru2F
         FsXHUEikFbGCkK4q52xoiMAmEACpD8G0sBwkwm2Vg/N+D7g6VMgKSNGywxpoLdC2ZjDN
         wx1f3PTDcxRRt9ZpTSr0cjVofbrha6NqnvzQOABCmr5oI6SiTgtBLyrOLuO04lkoDvSI
         ZJzIbtuEiBStgiWTkUcU+WfORGoyxEsbaRAIzBb895Nen5SN8YHTBXBlUAIcTLgov0ID
         ao4bQQTLoPifrKgqUlAm4zUXTY5q8Xxw6b+Q9siBvtjkXgio8vRKSAAtr4GILLfvIT/b
         11aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650486; x=1684242486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/HOJNcL7jdKqwCHI8Ml1ezJfov1pJyurOhORPKyJms=;
        b=DiFizIoMc+bwtOcfzDNyZgTBAt9vmFyyAxxKp082jF2o0VWoWAy/AznXsr5CrGD4bW
         Ar0QSX1nSb46EGwNgdFGNGJ9lh09FVweLpX92aWez3w49pyXbySHqC5QD1gH4CgbfXQI
         sSoyScAryMGB1oVBAg+OFufu/L3Ra2JK5p4gFgZ03cMmX42Vcagy4gYWPYrNf8omHn/O
         aO5Fo8FPa9fOT/NJr8iDwp0aM+KfCBl1WfJX7zdmJDinYg44jyGH0Rel5ZR9nJFOSxYZ
         5x4zHebWpYY92N/14BxdhAkH54r7NO9zQIclNAZCg37fGvcCpg8QdPM0Ch7l9ejmLfDY
         GhjQ==
X-Gm-Message-State: AAQBX9fdMRqGVwO/GggtbD1Ym3PDmqOUmw1grT3n6QG8BdYEnBKIkQSt
        iJXhXp/HnR+0QgRYOCTA6TY=
X-Google-Smtp-Source: AKy350YWln8BLpm78SWWGr3v55H/L+uHy3iZw/ZKD7WsYnM01aPKEm4birBmq2/3rBDGsvsgoohbDw==
X-Received: by 2002:a17:906:6c9:b0:94a:959f:6d58 with SMTP id v9-20020a17090606c900b0094a959f6d58mr5045680ejb.18.1681650485785;
        Sun, 16 Apr 2023 06:08:05 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm4511609edc.44.2023.04.16.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:08:05 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
Date:   Sun, 16 Apr 2023 15:07:33 +0200
Message-Id: <20230416130735.30965-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416130735.30965-1-aweber.kernel@gmail.com>
References: <20230416130735.30965-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the S6D7AA0 LCD panel controller, including the
S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
of tablets.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changed in v2:
  - Updated commit message
  - Applied suggestions from Krzysztof Kozlowski
---
 .../display/panel/samsung,s6d7aa0.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
new file mode 100644
index 000000000000..969cef7738b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6d7aa0-lsl080al02
+
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+  enable-supply:
+    description: Enable supply
+
+required:
+  - compatible
+  - reset-gpios
+  - enable-supply
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
+
+        panel@0 {
+            compatible = "samsung,s6d7aa0-lsl080al02";
+            reg = <0>;
+            enable-supply = <&lcd_enable_supply>;
+            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.40.0

