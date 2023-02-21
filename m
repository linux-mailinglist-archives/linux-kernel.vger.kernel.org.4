Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AC69E78C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBUScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBUSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720412E0F7;
        Tue, 21 Feb 2023 10:32:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so21178562edz.10;
        Tue, 21 Feb 2023 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mbS3PQtaiGcPdHVmHK5KHmqLpEohCcTweQJ5EgXuiY=;
        b=Ku08TnoYik5za8z9qvRzVXLT6c1xZUixmrWodB6t+suqVat/3n0Jrtzr2IhboiCRAY
         5FMHqXM69Wqmuv37UIZs9hnkJDlSU5NXr8q/eTdNH6ijCZ14qZDxT5F0MjOKYzrCqedA
         ZgN/y+y2CWqj8Dvo0DImcvd1Cwzz2/uU9y22Coi3WqQPRw72Hc07WlrlD6Xu4ESJznPF
         53etHxCFf0ql6+sX4Dc8LbjYpRLpFA3qEdH6Ca5ytApvCVqCXWjN7OTBrGS9d3jahpq7
         EoMseFH8UTUkyIFmVLW1cA8Ae76cpFEXGNlY7Yo4U14vWM1R1Pke0ywsLllqLCT5uNSF
         B/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mbS3PQtaiGcPdHVmHK5KHmqLpEohCcTweQJ5EgXuiY=;
        b=hlOEI/cMl/MhnhXNiXrXelh95TOOrUYwijZ2e7BYmdaBztsa1I/xLJu0jiCkRh+8mk
         xNz5tRd+0YB5uYczlp6DkqM8L9eGgv1+niOnXWc6nnoN09Hg1DzOUkg0IkHzuDRwa1xA
         yoZy4UDeHPQC394GuGfCWx3hKpnIjljXOTVMFifJlRklFcfgTXg4k1SBv48aoxsmoQzJ
         evI2gkPxSuCwiRUgJUQU0HMlmJ7NCs7ES9YzFb/HNu9ak7BbEMgLe2A5MW1+w8SjTze3
         GgzOs8suGx7WxkEIXl/pMRiqj+UAcDzPrxr39Bjwm1aprzhV6+pWGRmnM4r7K6eLu7Mu
         dtBw==
X-Gm-Message-State: AO0yUKXSr1hGC7uqHZvAnR8SF0EmFciyLyXawrNrGeHTixIDSJdm0Tu3
        6Hio5ImlTXZo327ukdOeX5HEI4aNeOGUSg==
X-Google-Smtp-Source: AK7set/LteK3qpbAq1LKdw+rlpbLWNJhpurzLhgxg23pB6vb+FQgCIHXqCxN3v958CVxug40jX9oFw==
X-Received: by 2002:a50:ee01:0:b0:4ae:eb0f:892e with SMTP id g1-20020a50ee01000000b004aeeb0f892emr5579895eds.20.1677004348983;
        Tue, 21 Feb 2023 10:32:28 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:28 -0800 (PST)
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
Subject: [PATCH v1 05/10] dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
Date:   Tue, 21 Feb 2023 20:32:06 +0200
Message-Id: <20230221183211.21964-6-clamor95@gmail.com>
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

Add dt-binding for MAX9808x CODEC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../sound/nvidia,tegra-audio-max9808x.yaml    | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
new file mode 100644
index 000000000000..256ca4ad081e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-max9808x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with MAX9808x CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - pattern: '^[a-z0-9]+,tegra-audio-max98088(-[a-z0-9]+)+$'
+          - const: nvidia,tegra-audio-max98088
+      - items:
+          - pattern: '^[a-z0-9]+,tegra-audio-max98089(-[a-z0-9]+)+$'
+          - const: nvidia,tegra-audio-max98089
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Int Spk"
+        - "Headphone Jack"
+        - "Earpiece"
+        - "Headset Mic"
+        - "Internal Mic 1"
+        - "Internal Mic 2"
+
+        # CODEC Pins
+        - HPL
+        - HPR
+        - SPKL
+        - SPKR
+        - RECL
+        - RECR
+        - INA1
+        - INA2
+        - INB1
+        - INB2
+        - MIC1
+        - MIC2
+        - MICBIAS
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+    #include <dt-bindings/soc/tegra-pmc.h>
+    sound {
+        compatible = "lge,tegra-audio-max98089-p895",
+                     "nvidia,tegra-audio-max98089";
+        nvidia,model = "LG Optimus Vu MAX98089";
+
+        nvidia,audio-routing =
+            "Headphone Jack", "HPL",
+            "Headphone Jack", "HPR",
+            "Int Spk", "SPKL",
+            "Int Spk", "SPKR",
+            "Earpiece", "RECL",
+            "Earpiece", "RECR",
+            "INA1", "Headset Mic",
+            "MIC1", "MICBIAS",
+            "MICBIAS", "Internal Mic 1",
+            "MIC2", "Internal Mic 2";
+
+        nvidia,i2s-controller = <&tegra_i2s0>;
+        nvidia,audio-codec = <&codec>;
+
+        clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+                 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+                 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
-- 
2.37.2

