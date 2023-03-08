Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28506AFFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCHHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCHHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:35:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290614227;
        Tue,  7 Mar 2023 23:35:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ec29so31189447edb.6;
        Tue, 07 Mar 2023 23:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678260931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fl8uW/bQJEJTin+QIg8DWseVdDDVo44lOoVAOeBzPc=;
        b=Qm6adxrvZNiyIQbLUCsj66urFNjR/BgPWPxUMP16ivYCXpi1zIYeSQe3B2yITeMI3u
         +AuwNDUqk1IB12ZPyulZha3fwvbO0M3KCw9u45yMdbfZHe+PypAHHybYmS7QqV1X2Mz9
         gp/AhXVhWCpZb0l9wBU7lQjQgYrYuWGo8Nr/y/ypJcFe3lUgCd0gMSFHQvmSBhryxtmj
         l7bZ1pn37/vkR2VS0HK8TdOWdFro+H/2GMrXTc95U3EZ72b9x9SGYvp7nANgg5HbSi9x
         4lUkHhKPuF50dmL+J1rYVJXtPVxo2DVnahdjWzVpW743ojRgB/LWD6wiynXWGrLCLqkE
         eDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fl8uW/bQJEJTin+QIg8DWseVdDDVo44lOoVAOeBzPc=;
        b=OL6x6N+ugcAOSYhBKtCJzMjavoDgKjIDFb5h+oJVw6nlRqCrDSWP+BpDPooN14v8su
         N5or3QfXDDgwsETHfu97n+x93RPLogilh7FdhuZALyIJ9d6ohSQwsD2GqNOTdkaLVK1j
         //mZlyTIXhxpmDTChxbBufh498jTRZGNp1UIEw/JO/yIOATrwgNGhIHa+qahc6blXXbx
         ZHCtk82SwSTUtFDEjvivtP0Uf6L9txfg/VOrm+ZwDPAy1QKt44Z81G9KuTFOLoSf8u6R
         j+6b2ATbYx+ydGoKg8NGp+MPSLL1HMfXqnP7WZM+2s844BAZf+ETssEORNkshdxzUuoW
         UMMA==
X-Gm-Message-State: AO0yUKW3Qs+VqlzagRn6Jcm9MGufM3aVfhghYaH6XFST9khVYOU9vlgw
        saNNZe/6NmcaNJ1EuCWucWDGM2uQ0b0=
X-Google-Smtp-Source: AK7set/NFf6G0tf6b/6ZRhaWwjmnNrR8ydXanCprah2G3RGIl8hZqeFlEBgXKgqA6/TtHiX34T82dA==
X-Received: by 2002:a17:906:fe44:b0:88f:8a5:b4cd with SMTP id wz4-20020a170906fe4400b0088f08a5b4cdmr19309704ejb.1.1678260931239;
        Tue, 07 Mar 2023 23:35:31 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709062dcf00b008dffda52d71sm7051880eji.124.2023.03.07.23.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:35:31 -0800 (PST)
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
Subject: [PATCH v2 7/8] dt-bindings: sound: nvidia,tegra-audio: add MAX9808x CODEC
Date:   Wed,  8 Mar 2023 09:35:01 +0200
Message-Id: <20230308073502.5421-8-clamor95@gmail.com>
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

Add dt-binding for MAX9808x CODEC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../sound/nvidia,tegra-audio-max9808x.yaml    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
new file mode 100644
index 000000000000..fc89dbd6bf24
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml
@@ -0,0 +1,90 @@
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

