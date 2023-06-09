Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D4729009
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbjFIGgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjFIGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:36:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777330ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:36:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b039168ba0so4882465ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686292593; x=1688884593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORhDRjsPJgq36LWDEz4NyoRdPPVr5GxVUW38IXtaYD4=;
        b=0LBDVZOWpX75RD7WNATAWCE0fA3NqmWXpfkgMjzlsmHtFdrlJOpSiTBcj607akNqlG
         OnNOZeFA9hwsB1AqMgB3gwwCJsyzdKiEb/CJVDp51D8SdtCdTpQsGU+n0xC1uyDyx2hK
         e/r+jorWGBGAobj5QjvtQ1VRYkROJ+qN4kRsX5tx0zez4nPrz0jeYq/j0tpYp+JW2bKN
         0HR4GWguoU5QUVvsI7ErlrB0E58BBhKwFyNJkl+blU3DyTIZc0447P3Ncg3h1GteR/dZ
         Nr0u9geYncnF4G2dSQbHezlESdElpi04Y1yS4ma3h7po8dek4e/lKGPvLSifQdLbRguB
         /Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292593; x=1688884593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORhDRjsPJgq36LWDEz4NyoRdPPVr5GxVUW38IXtaYD4=;
        b=hFjKdxVq5A+ZnvmIPVFW36YzZ+opVe4ZRwScynsekR4eP/2a3AzHGvMa7SclgGF8Bc
         cJF9q5HUYkTM07I6qzZf1I7TCcf/n/Q0GFbqwGsgmzADKdew1J4oAv0hzA9aA+MRpwFb
         sqr6Zvzj9/Ym++pnLIkX0uSJY0qdMzCk+mU9+2G8pwu2qY0/sCRb9vghKV3oiqLZHEfq
         0zHtxtNGEU4kDm9ZxWTRkRw3RekoKsDqhGkuleUmbhtddlNZBCT6M8u5Qumnl4KL2/uM
         FRC+/BKLpu/bjYayCatWYI5u3fwrdf17rwEFsEypIxAJM5LUa9G+c+E0YG50YW30NpDL
         GJdg==
X-Gm-Message-State: AC+VfDwyCryZshNJOHv1+0qGkzAztTwTD/BMJSnIHpBhNfBp+nUUd22V
        dXLHNQW9wFW9nSEchvAMyXGAFQ==
X-Google-Smtp-Source: ACHHUZ4gpx6DzCVgZ9AgZ5eFGHFefmt/uQnouUPu0M9P+ifeZKL7S44CrfjvFtx41svv0m3X3l0Nww==
X-Received: by 2002:a17:902:f54f:b0:1ac:b449:3528 with SMTP id h15-20020a170902f54f00b001acb4493528mr579434plf.46.1686292593703;
        Thu, 08 Jun 2023 23:36:33 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b211283294sm2445709plg.163.2023.06.08.23.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 23:36:33 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v5 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce bindings for Ilitek ili9882t
Date:   Fri,  9 Jun 2023 14:36:14 +0800
Message-Id: <20230609063615.758676-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that ili9882t needs to use
vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
and touchscreens to power on/off together, let's add a phandle for this.

[1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
new file mode 100644
index 000000000000..c5d9e0e919f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ilitek,ili9882t.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ili9882t touchscreen controller
+
+maintainers:
+  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
+
+description:
+  Supports the Ilitek ili9882t touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    const: ilitek,ili9882t
+
+  reg:
+    const: 0x41
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+    description: Reset GPIO.
+
+  vccio-supply:
+    description: The 1.8V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - panel
+  - vccio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen: touchscreen@41 {
+        compatible = "ilitek,ili9882t";
+        reg = <0x41>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+
+        panel = <&panel>;
+        reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+        vccio-supply = <&mt6366_vio18_reg>;
+      };
+    };
-- 
2.25.1

