Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49F6AFFDA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCHHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCHHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:36 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357EF1EBC2;
        Tue,  7 Mar 2023 23:35:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so62021673edy.8;
        Tue, 07 Mar 2023 23:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBcnq48gZafulICVd9tvrELT8WaB8t4pfISzUK/pzOI=;
        b=LtOCJHK4KvMX8bwTtHJrl8sZHkh+iEgZz6I87FKs713yXXegtKWTWcWFc/1P5V9pzf
         3uY+McYYdyOoCIzWMZN/E8S7P226CMZ9IOdn2mjGDHGkVxhkMf3rW5KFJaSLlBL9654V
         y1PqPvye6lBWlzcGm2qHm/B3ECEH07bWwXAKuc32lJ/CkfDb1kSVmODkVoVVHSnWM1Ua
         VU592RmHtzHhiVi/XRlwqqmbsN6WI2OA+EimSNlXcN2lb3nwUSI/2pzvGnb42sZ+zTvg
         usP2J3osvVH8ExlHymqazrZHFPd2jryxCbmCMxDygSxQlrVZr/yP6hgm8W3rx1utFwFR
         sLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBcnq48gZafulICVd9tvrELT8WaB8t4pfISzUK/pzOI=;
        b=OlIjTofCt+U2ao2LluRkA5CWloWLYcVQtMbET/M9mpGLifjerJ69UDufRzAzIYChih
         KLKo5KFTDV/rnCLTNgCXuRa1OTz2/iTyBSrPeLKgH9B14bydCLtEzCY9Evkt+/7R32cT
         Bd1/23tC5awBtMZ+qMC2huJGrv4N1njje0IQj/4aRbsDD90pl/a1W4iyluwkVqwjuo44
         MJNMA16hXobmdUesmc/zggv6gkaDNnmCbD3IQDEjlQc8rXFJH/t9oeWFGo8+RUBdQZoU
         OR+LZWQyvRdfFIHW/GIk77xb02khuDHGhcfyEkhWWeg6ozaEjdIwNyPI0UTUeGPjr1Fk
         bQdw==
X-Gm-Message-State: AO0yUKWP52EUF+CRr3gYF+YL2XZEHGE1F/rx7diz2MV4HiNvo12XeF5E
        dCe4hY2xRzwI7635rJIt2Xo=
X-Google-Smtp-Source: AK7set+zGCxAlpvDYOch6Rucm3mfAoV+frk+zkxD07ypTa4bSC5gYI3kTWWYePSU4FynWRc4Obe4oQ==
X-Received: by 2002:a17:906:2db1:b0:7c9:6e0e:1427 with SMTP id g17-20020a1709062db100b007c96e0e1427mr15342605eji.6.1678260927608;
        Tue, 07 Mar 2023 23:35:27 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:27 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2 4/8] dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC
Date:   Wed,  8 Mar 2023 09:34:58 +0200
Message-Id: <20230308073502.5421-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308073502.5421-1-clamor95@gmail.com>
References: <20230308073502.5421-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Add dt-binding for RT5631 CODEC.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../sound/nvidia,tegra-audio-rt5631.yaml      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
new file mode 100644
index 000000000000..a04487002e88
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-rt5631.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with RT5631 CODEC
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
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-rt5631(-[a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-rt5631
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
+        - "Mic Jack"
+        - "Int Mic"
+
+        # CODEC Pins
+        - MIC1
+        - MIC2
+        - AXIL
+        - AXIR
+        - MONOIN_RXN
+        - MONOIN_RXP
+        - DMIC
+        - MIC Bias1
+        - MIC Bias2
+        - MONO_IN
+        - AUXO1
+        - AUXO2
+        - SPOL
+        - SPOR
+        - HPOL
+        - HPOR
+        - MONO
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+    #include <dt-bindings/soc/tegra-pmc.h>
+    sound {
+        compatible = "asus,tegra-audio-rt5631-tf700t",
+                     "nvidia,tegra-audio-rt5631";
+        nvidia,model = "Asus Transformer Infinity TF700T RT5631";
+
+        nvidia,audio-routing =
+                "Headphone Jack", "HPOL",
+                "Headphone Jack", "HPOR",
+                "Int Spk", "SPOL",
+                "Int Spk", "SPOR",
+                "MIC1", "MIC Bias1",
+                "MIC Bias1", "Mic Jack",
+                "DMIC", "Int Mic";
+
+        nvidia,i2s-controller = <&tegra_i2s1>;
+        nvidia,audio-codec = <&rt5631>;
+
+        clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+                 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+                 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
-- 
2.37.2

