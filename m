Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C269E795
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBUSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBUSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5330289;
        Tue, 21 Feb 2023 10:32:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ck15so22233163edb.0;
        Tue, 21 Feb 2023 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7LUck7NKntyvJrTtA9Mcdll1GuNCKTVdIZE+EmCgf0=;
        b=aY7iZeMyl0Yy8TJGNzIOWQT4yV4aIZcrA3QtuCr/sgIo+n/gxDCoTdT9Spqa1B+tu8
         /dJfWEwQ8nRKNBY8rRsKdfrHGSQzyCwfP6ZSshom4XAj+TMDHalSV1W9TTZQHMcGdGCe
         eWc0zIx+9X6n+te+u0x5OogQyDQcuHXiOWhLH1qR0H8+5rk+1J5lwTSslKQed70+2oUv
         LtxzXfOGmlkPMkzy5mR8E4tYbnF3VlfYWTUPidZu7xM8P5wSWX6ODOQ9S0z8/zB9dw8Q
         npin8zoTuVWLndrSehCYNM0jkKFHaKlOHfDeQghz1wksvpNKfl3AYwwzGfrXxUt70g8h
         5rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7LUck7NKntyvJrTtA9Mcdll1GuNCKTVdIZE+EmCgf0=;
        b=gZJ7hwRrkX++V2rlItPrpRCzTlU4bLz5byTV337+7g35jbMD4N8pZZbNKlgAEc16ra
         cEWDZxdg7OBdl0rLVOwzWaPjGasc5dw2hkxKlBNMVd+dr/juEgXxmoGSV4IJOrUqEXdt
         S/8gGyMTMyks0koSpimzdkr8GxBQQJ3kokUlASpgtjdwUfHwsudhayNllOwrPrei8Oe3
         CpwXTK5p02fa4Fgq6djFb+94GUlEYLG88FNfbz3aCp6maRPfidCxEW7OnqTAIY6pWRAv
         QsxpIWI7NsUbmNNFwaFblepeiYMLaBFR9rql52/IQRUraay20Jnv7clM3CRr6fIblnQm
         zz8w==
X-Gm-Message-State: AO0yUKU7CKTsv4FdrMRvW91KwZl7UIem/wqRekZOQCxrD1nUaMv3VOtN
        CSELy99MGxMRsFK00sp8KOY=
X-Google-Smtp-Source: AK7set9Sdi1je3qVvo0qJXZlUkQyErQ4YoQjaz7cj/on0XVdGldV/BpKlkhyI10FlvJ9jEcLz1Kylg==
X-Received: by 2002:a05:6402:31fb:b0:4ac:d2bc:32f9 with SMTP id dy27-20020a05640231fb00b004acd2bc32f9mr5753304edb.4.1677004352701;
        Tue, 21 Feb 2023 10:32:32 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:32 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v1 08/10] dt-bindings: dsp: add Fortemedia FM34 DSP
Date:   Tue, 21 Feb 2023 20:32:09 +0200
Message-Id: <20230221183211.21964-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221183211.21964-1-clamor95@gmail.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for Fortemedia FM34NE DSP.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/dsp/fortemedia,dsp.yaml          | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml b/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
new file mode 100644
index 000000000000..78f30969d9bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/fortemedia,dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fortemedia DSP core
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: |
+  Asus Transformer T20/T30 tablet family contains a DSP core
+  used for advanced noise cancellation.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - asus,tf101-dsp
+          - asus,tf201-dsp
+          - asus,tf300t-dsp
+          - asus,tf700t-dsp
+          - pegatron,chagall-dsp
+
+      - const: fortemedia,fm34
+
+  reg:
+    maxItems: 1
+
+  bypass-gpios:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+    #include <dt-bindings/soc/tegra-pmc.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsp@60 {
+            compatible = "asus,tf201-dsp", "fortemedia,fm34";
+            reg = <0x60>;
+
+            bypass-gpios = <&gpio 222 0>;
+            reset-gpios = <&gpio 115 1>;
+
+            vdd-supply = <&vdd_1v8_dsp>;
+
+            clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+            clock-names = "mclk";
+
+            assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+            assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
+        };
+    };
+
+    vdd_1v8_dsp: regulator-dsp {
+        compatible = "regulator-fixed";
+        regulator-name = "vdd_1v8_dsp";
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+        gpio = <&gpio 165 0>;
+        enable-active-high;
+    };
-- 
2.37.2

