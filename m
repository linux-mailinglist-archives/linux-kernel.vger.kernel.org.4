Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3989871F5FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjFAWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:32:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A14136;
        Thu,  1 Jun 2023 15:32:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ae141785bso1382194f8f.3;
        Thu, 01 Jun 2023 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685658731; x=1688250731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDQovBoms3FLau58BysfqmyJWkZDGP+mDWm5zuqZL/Y=;
        b=nJ5nrB/K65xBQKeS4GK49exb8oASXvkB07wZO02wNCVCzxUG+fXPDtEcDX1berfUJd
         +Dnim0ocLAx6/xp4BqZHLDSdO5QS9me/pYMaRIrhky0TGnpJbxDqO7aDu8BcOELRIMIV
         T1FMGnigqZwePfryfBXqE8S6Um91z4H7ji7M6+YlBlSeaJxylPSlgpsSFbnmXAeNQ/H+
         WzpMtM1IbWpS4PUsNYMkWRN6+G7FtIdvkbA4F1Fd2UWBP8woALbMjNjERKg2hovSBsH3
         0y0YkI4wO8qI2MI3pKH5oA+nA+L6qGqsRXDsSiH58FHQshYUIdHAxwdUS2TU9nh2dsMa
         exYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685658731; x=1688250731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDQovBoms3FLau58BysfqmyJWkZDGP+mDWm5zuqZL/Y=;
        b=Ms0yKumrEMSmJ+b9jOl4IyTYQMMs8p7ggZL3O9UQH1qpsfsIhzM8O+BUJ0N0vsS+Bi
         rKGE1RtzY0xT5vrkNjhFZojYPpDHzZehEtpr3B/m5DbfObXl68t7sVgnl38o8Ek+Vlis
         hzkr0B7E1CFjzgFKiGjHCssPEj0FIE3ibqTpgASuND7eeA6e0rG/UxvjZLXutMQKGEc0
         8eB/M3YLKQVypAEsrLuQa3GnCOI/R3bYMoosXOmg8bqLef+z6IjlvzbULq/+c/xRl8Jo
         w4Dbh4+JbbeqoNE2EDNwFRT+9+tDhcn4589beNQK6mYT8dUgWY8+SCW552+iW1s5xDH+
         1J0Q==
X-Gm-Message-State: AC+VfDyUDVjWGQ4CxjktjdRhXbRJZzraTGqwY6xOkfYVfdp9Ef9XegzQ
        cspgHSm+tfoK/W3EnRwERt5kaMTGy3m4Gdtu
X-Google-Smtp-Source: ACHHUZ4UrAst4qPVDvoXKTVPsJrseXBlcZmYfr9vB25sGSdLTIpkgvX8Re139ignQ4DE5Du+R0qDmw==
X-Received: by 2002:a05:6000:1191:b0:300:cb8c:fd8f with SMTP id g17-20020a056000119100b00300cb8cfd8fmr2588538wrx.54.1685658731484;
        Thu, 01 Jun 2023 15:32:11 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4d87000000b0030af8da022dsm8619149wru.44.2023.06.01.15.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:32:11 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
Date:   Fri,  2 Jun 2023 01:30:40 +0300
Message-Id: <20230601223104.1243871-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601223104.1243871-1-bigunclemax@gmail.com>
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
This ADC is the same for all of this SoCs. The only difference is
the number of available channels.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
new file mode 100644
index 000000000000..94f15bb48231
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/allwinner,sun20i-d1-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 General Purpose ADC
+
+properties:
+  "#io-channel-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-gpadc
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - "#io-channel-cells"
+  - clocks
+  - compatible
+  - interrupts
+  - reg
+  - resets
+
+patternProperties:
+  "^channel@([0-15])$":
+    $ref: adc.yaml
+    type: object
+    description: |
+      Represents the internal channels of the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number.
+          Up to 16 channels, numbered from 0 to 15.
+        items:
+          minimum: 0
+          maximum: 15
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    gpadc: adc@2009000 {
+        compatible = "allwinner,sun20i-d1-gpadc";
+        reg = <0x2009000 0x1000>;
+        clocks = <&ccu 80>;
+        resets = <&ccu 32>;
+        interrupts = <0 57 4>;
+        #io-channel-cells = <1>;
+
+        channel@0 {
+          reg = <0>;
+        };
+
+        channel@1 {
+          reg = <1>;
+        };
+    };
+
+...
-- 
2.39.2

