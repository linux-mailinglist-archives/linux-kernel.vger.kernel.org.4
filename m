Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A3E5E722B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIWCw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiIWCwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:52:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384211ADF5;
        Thu, 22 Sep 2022 19:52:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w13so10577977plp.1;
        Thu, 22 Sep 2022 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=PRy5R4lxKDMClfo9ClMeZwHLHwg+CMUfGmWsvA5PLdSlc2fYm7cHntlIvJROamCed/
         pmP4MntMC43VonjlZSqXjqd32LnbNUOom3wijGLB5UVqzdAomQagq0yql2svfwLU5xOo
         bZH401vrBvTyvZp9t75mV2ZrIpdDEw7EkLOgBmfgtDgCPMfqV8LZU60+oNY66iJz5sBX
         OBJTVK1wpZr93zZGGDas2EVf9sYlli414l2k1LlLjuXwqmr2I33Ks/gs9YKQqMebMjR9
         qBjFEPUj+GxudAlTE6upcjoIB55Q378C4amjSiqRFrK2oD7OH0Lh4oxKBsocR4TfzkoR
         uHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=0ES5fGReC6tNjPZU7pp372LRg04iwGzssehZ6AzpzHZ0aOJZuhZDTnzhp+4WMjEBbA
         SuIg2ALJGBM7J/We/N5SFybG5OpiomUbWrXQ24WgWDSORa9Wo7g7Z2FVvYBiT9o6FaP1
         3hlrQX9bvaPPttWQkrUR1TE1fyAvhBW7v1WEG8HNR1OAesRvaY+Q60z1d18UYm/x0Ghu
         lnzwaLht1aFgdzqFAhRJ7yfbKeO/q4wrho6qjtxUD+mwiVzZC239YCbgnZXrE6hNSCkk
         BS0SESwVuSAzlNKqyvmRxlRqhjJIWgB7Oo+/pQ76Xs1QpRfodEsFhdhTU5rQCssB7NTL
         xPeg==
X-Gm-Message-State: ACrzQf3g30PrjCZetHN99F7EbYcZyATAQkiEwEr3oWXem4lEFbmHC+LD
        MCcTVmJeJBf85N+fTg0PNws=
X-Google-Smtp-Source: AMsMyM4jHr2MN2G8b50aY1XwhZ/0Wz2PFQmHztqebe7MVZwgW0tBDk2ggQzkliJno4m5mMvMkcJ+sg==
X-Received: by 2002:a17:902:9006:b0:178:b494:c15a with SMTP id a6-20020a170902900600b00178b494c15amr6558358plp.37.1663901533427;
        Thu, 22 Sep 2022 19:52:13 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-76-89-227.emome-ip.hinet.net. [42.76.89.227])
        by smtp.gmail.com with ESMTPSA id f21-20020a623815000000b0053e85a4a2c9sm5167058pfa.5.2022.09.22.19.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 19:52:13 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 2/5] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Fri, 23 Sep 2022 10:51:23 +0800
Message-Id: <5632ef04d7807f78259e4e9f3d952849a839a50c.1663926551.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663926551.git.chiaen_wu@richtek.com>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

