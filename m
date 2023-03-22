Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE96C5216
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCVRQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjCVRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071562B6E;
        Wed, 22 Mar 2023 10:15:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso922070wmo.0;
        Wed, 22 Mar 2023 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxcHrlsE//QuvJuOK3pbjMlstNP3JEw2xAmrcUtcbhs=;
        b=T5TktDVxzliUxnC99ZrKsAZv2D0J809LAueD3aEEEk+iWS4XwHy5OdozlLiDxpnbTv
         0Ig5/zisKpN/yV1SwCZGJtGbDYHoi4uSNIHA5I9sQc4TI/YQRNtts8oJwn/zBgrrqrkr
         Mb6MnBhsuViS0EbvuMzzh9ymoHT1+3OxYBzVfAPn/1dVoXa/5WX2PlBZmaHGFGx7t8Yg
         juV1bpGZRDqzsyoBrvQOxgi9UiCt7IwdopXxaxJe/sGbnExcNFsKNzmigvTKzDw+pkYr
         0jLz/AtisVrojL/sSozf3lxR1P7kcqrAtkSyO7+XoLzajCdZaEsXjrLeVR+e0oSeIbsN
         hBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxcHrlsE//QuvJuOK3pbjMlstNP3JEw2xAmrcUtcbhs=;
        b=wbV122JwSeJz+9YZ65mW7+h/91S39TGveo5t4+PlJb906P0LzGjcc7Vsd6Ipb5GHV7
         eFgzio9CcrJXJXADj9WK19ENKNk4IEpQSi+ZW5hi0JurnZSGqPw+Qlx0Y069+TOUWbR8
         dVoW6pl7vwFtN1gdG7i8pDHgMMATkS61N5RsGnMc2qK0WJTky8TGbFEI5bDXfdFioSey
         IWgPsaHwU0GguHuf+9mA6610s3s5SqkPHw1ZuwUjscVswgdmL8Ku63nAsHOEL3HnqjqT
         H1R/8fQ5Z9sYYvk4hFjpAz+zpReMc7NZwAjxzv11QxKAaWpFHrJMyNA3z48fNg6hBrDX
         IhUg==
X-Gm-Message-State: AO0yUKVgO4Wk8A+rKMT7sOnvf0zM0xfwmDw6cHM+jI5ardLobia2cCBo
        NoBUc+5q8lQXKW69maKmkTA=
X-Google-Smtp-Source: AK7set/sulvTXWCsaOiQOQtXBYZKorHMy47DIJBhzabtkFvhqbqqYlk62RSr8eHpcbj5qOpj0t1qGA==
X-Received: by 2002:a7b:c049:0:b0:3ed:e6c8:f11d with SMTP id u9-20020a7bc049000000b003ede6c8f11dmr232940wmc.7.1679505324531;
        Wed, 22 Mar 2023 10:15:24 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ee11ac2288sm8414333wmo.21.2023.03.22.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/4] dt-bindings: clock: Add BCM63268 timer binding
Date:   Wed, 22 Mar 2023 18:15:14 +0100
Message-Id: <20230322171515.120353-4-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230322171515.120353-1-noltari@gmail.com>
References: <20230322171515.120353-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom BCM63268 Clock and Reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 v4: no changes
 v3: no changes
 v2: no changes

 .../clock/brcm,bcm63268-timer-clocks.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
new file mode 100644
index 000000000000..199818b2fb6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/brcm,bcm63268-timer-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm63268-timer-clocks
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    timer_clk: clock-controller@100000ac {
+      compatible = "brcm,bcm63268-timer-clocks";
+      reg = <0x100000ac 0x4>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.30.2

