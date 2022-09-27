Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF745EBCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiI0IH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiI0IHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:07:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C35115464
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n10so13653895wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5mdo6NGLlB92HNx1YdBVXQY1nz6YTKAI7LSgWV6iJpg=;
        b=TSMUqXpBGA6O740Vbe76KnkTC6Rzlba5NxIu8AhZkfGCcFSJjaFFBtesClkcZA+GXr
         d86YrtgrRC7mOqx+CXyq29Bl5ZNd13wRycLSj+hmLJLqApJpA86x0NZ46MZGXkETE13V
         GRTEp4Z3u1MKMPRXmjoo9rcz7lC1fMCTe2cnLgEjjuQCFqQTB3UPygH+Fpd8f/rvrP8E
         T8gQeE6GHf7rfXIiNZUX+ZFYjAACzbEqsamzVviFOrVBJrmBKPz8KvXpPSth3xZeB0VB
         QJH3xwSiGZt9nG3yXTqpIFwEeZQ1kz1c/GkNTFSheME1zrNrbJN1IxKCCqIVnqo2HuVW
         8Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5mdo6NGLlB92HNx1YdBVXQY1nz6YTKAI7LSgWV6iJpg=;
        b=dYZ3yOP2XlhVR9SxN++i5M47RasQAmz3eOZQo/9pfaM2u3tffrxlXQZ5/1JlWrwFHG
         ++CZQv/EHbDmoIwfLw++RrTqgvmQe3hXBPQOmWcaZ9QaedojJbcV0bJi+Y+DLFCsRoTj
         QLPTIe+QSB5LICfW9sm4imdg4Wn3GvrGWDORadQlMBnGOCi0KSz3W7KzZOVFy4Jg8AEy
         m0keVkvzyKrnd+8Y32Z8R0VoNTHyF/Imsh36JEf6FxJ0B9pVQjO/9gqJ+mkOpG4rJD7d
         C5ud92HYNDSzawhqAtdSlAcCt9GLZ5dE0Dx+Av1vVSA58K2+8p8jWXmuc+vUAQHyEZ1+
         zFAw==
X-Gm-Message-State: ACrzQf3opZ+L1eb1Qle82aLrVO/6ZyDGr/3BavcUfSTnv02mlvum6TVi
        2hJcGcijQCgQ9rbKqmXg858NLQ==
X-Google-Smtp-Source: AMsMyM57EG7r/INW+QuGEjqPJWyO6T++k36fW0Iawm5RTeCdV8Ph+Z3zSVihCgeH5lWgEy/GWHK8gQ==
X-Received: by 2002:adf:9dd0:0:b0:22c:3fe0:42ef with SMTP id q16-20020adf9dd0000000b0022c3fe042efmr12390756wre.348.1664265668642;
        Tue, 27 Sep 2022 01:01:08 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p4-20020a1c5444000000b003a5c7a942edsm13357199wmi.28.2022.09.27.01.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 01:01:08 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT 2/5] dt-bindings: crypto: add support for rockchip,crypto-rk3588
Date:   Tue, 27 Sep 2022 08:00:45 +0000
Message-Id: <20220927080048.3151911-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927080048.3151911-1-clabbe@baylibre.com>
References: <20220927080048.3151911-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for the Rockchip cryptographic
offloader V2.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3588-crypto.yaml        | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
new file mode 100644
index 000000000000..aa01c3c681f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3588-crypto.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/rockchip,rk3588-crypto.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip cryptographic offloader V2
+
+maintainers:
+  - Corentin Labbe <clabbe@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-crypto
+      - rockchip,rk3588-crypto
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 4
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+      - const: sclk
+      - const: pka
+
+  resets:
+    minItems: 5
+
+  reset-names:
+    items:
+      - const: core
+      - const: a
+      - const: h
+      - const: rng
+      - const: pka
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3568-cru.h>
+    crypto@fe380000 {
+      compatible = "rockchip,rk3588-crypto";
+      reg = <0xfe380000 0x4000>;
+      interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru ACLK_CRYPTO_NS>, <&cru HCLK_CRYPTO_NS>,
+               <&cru CLK_CRYPTO_NS_CORE>, <&cru CLK_CRYPTO_NS_PKA>;
+      clock-names = "aclk", "hclk", "sclk", "pka";
+      resets = <&cru SRST_CRYPTO_NS_CORE>, <&cru SRST_A_CRYPTO_NS>,
+               <&cru SRST_H_CRYPTO_NS>, <&cru SRST_CRYPTO_NS_RNG>,
+               <&cru SRST_CRYPTO_NS_PKA>;
+      reset-names = "core", "a", "h", "rng", "pka";
+    };
-- 
2.35.1

