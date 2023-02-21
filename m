Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0869E784
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBUSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBUScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8ED30289;
        Tue, 21 Feb 2023 10:32:28 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cq23so20729753edb.1;
        Tue, 21 Feb 2023 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH8T3uIDsMsshselwDvDLZiGP6dvAgAvE+M69z4Yx3w=;
        b=H/CTM8eqll4oT5mdFcfpaEYryD5fvk1h+y1Tbx39YEVekGOVolmb/0uTeQLtxZE1fl
         nDKd8uCmSKwbzkevYopP8oOoFWbX2MXvWsA+tthPw6mCF7xFgwJQ6ewYSQWOnIpFuEp0
         usH3bVyQ8WsYbQNcJKdo4W66lYT+ccTnrksgYnsj25QXX8kAA6kb7EjfloCTaMMZbNj4
         qEDw4FB3oxyV9Tde9ie1Giv02lSDCDtlfinG12y6McC7sJDtCpXccNxQH57lziAcFRC8
         Pi1gP8ynmxlLGKRC1nrgyosthPKS7dQQve9gmYtWzxYIsSWDWD41OQDvf9v+PnrIDjL0
         4yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH8T3uIDsMsshselwDvDLZiGP6dvAgAvE+M69z4Yx3w=;
        b=EHx8vFrGbWsID4deej76ZP77U8d2yryibh7fMmOPRRzRDMCTzSTFyFFPM5Cwu1sbSS
         V0hat0JFwhdDNAHbJGWZSJhNkSJDS61OARaOWg3lXsAv50YCsuFgcjRulAtAEZv3fBRP
         aMOgDnSEyxMWUH05vuSllPWY+zO8o4NLBf3yQSl5aMgpSTaU/bErk2KYNYZIQnxPrHzs
         v+UF+HZQMRrHuSyOKoCqR/hqS433OKrB1I3ikXayNc3s5YeBE7QNQdP9VGMWiZAfAcIY
         WdUNe19Ug+cwLuXPmmo4rloYvb6R+bsh1R2OCw+EonMaI4f9L0+9pu87SthALW7BZHkH
         75pw==
X-Gm-Message-State: AO0yUKXqSioXf+B5V4zsCMlzjN367KOfxJCUVBNUfpkzeTM/XkBenSyY
        TwEruqIatpjHAQkLS8pIs4QuH0apitgdpw==
X-Google-Smtp-Source: AK7set9MPFA7PiA4Qwf584jP14HcozBU036cScKVnlwHTZJuOfvIsNU4rUdHRJDpVcT91NlLdpB80w==
X-Received: by 2002:aa7:c055:0:b0:4ac:bbd8:d04a with SMTP id k21-20020aa7c055000000b004acbbd8d04amr6237682edo.5.1677004346521;
        Tue, 21 Feb 2023 10:32:26 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:26 -0800 (PST)
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
Subject: [PATCH v1 03/10] dt-bindings: sound: nvidia,tegra-audio: add RT5631 CODEC
Date:   Tue, 21 Feb 2023 20:32:04 +0200
Message-Id: <20230221183211.21964-4-clamor95@gmail.com>
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

From: David Heidelberg <david@ixit.cz>

Add dt-binding for RT5631 CODEC.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../sound/nvidia,tegra-audio-rt5631.yaml      | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
new file mode 100644
index 000000000000..b347f34c47f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml
@@ -0,0 +1,88 @@
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

