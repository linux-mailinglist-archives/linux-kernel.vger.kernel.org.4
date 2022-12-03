Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3E6417A9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLCQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiLCQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:05:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E91F2F0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:05:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so7590216lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQQgA2B6JuQCl9Sn47gIOr5BLct1XCSVPgZ5wpqRd04=;
        b=Kj4DNPgsIyL3BIhG4CqIcBbcV1s+qCWiZr8CGSJQs9OvpzKtotQ465N2CNEnsvvZ1A
         3QpfbS43IgnSlXlDAYeRa7K+Olx/mZUocnOqdyDFZreb57z32+RvduL2PrG9zQHtbDcu
         73pdpp0PHB80Rl1+seCpOf9SYbLR7mNG159IaxkTLXTzFv0jxrgyezAxeLnjtcx5F1dn
         Hjf1PA4M8aFbQaCLterflhYSLXdvYo0sjQcKB4h4jgHBH+FrTaO+QAaCw4JQ96x0JYNW
         Wc28txwTUMBoRrciXidG353d4zSfbOpNnvzJODZQMCT+ey5IySIBHDdnwMUbIHqSVzBS
         Kq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQQgA2B6JuQCl9Sn47gIOr5BLct1XCSVPgZ5wpqRd04=;
        b=0h9utFUby7uAngVn8D8hesh7lYo2N6PkKkFrnjFdw/My2rtqgKum9m9jVYTh6nSkit
         yWDNXijSxd/2yd4aJ1cDcmBfqbfaZajlP9jyRdJAjx3KICAvy9CY4kwSeA3ll7sBFxth
         i8DGWIuzc/TB8kUSpCiGcr8WSVT/hmwRnDMjPjp2CU2VJaKTzvdY//rJoRM7xhbKLhZE
         /9Ie8hpoxVUnVceihFmVKfgwIv7pLm8eAAnuxw3GPjw9hs535+2ebLoD64ireefTR4jl
         NRypESGZa+QCgQ61QJBtmgnBnXYIbKEqmZQB2S2J+4M8rGlRWMRpM0GfxIup1xVSY0R7
         wJeA==
X-Gm-Message-State: ANoB5pkBW8OFp4QfO9Pe2NcwUOlxnw03CVWEMPZezezmdezxzoc7NcI/
        FnscBm83uUFZq6Obk9gm5m5fPQ==
X-Google-Smtp-Source: AA0mqf72BVKnpn+MA5xJGVYlL5SnIsGDKLeZoYK756z5Q92VunWvwd331oN9TV1SKnOL4zeD/GFMxg==
X-Received: by 2002:ac2:4310:0:b0:4a2:3e6c:a32b with SMTP id l16-20020ac24310000000b004a23e6ca32bmr24364674lfh.54.1670083510167;
        Sat, 03 Dec 2022 08:05:10 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d11-20020ac2544b000000b004946bb30469sm1441320lfn.82.2022.12.03.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 08:05:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ban Tao <fengzheng923@gmail.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.om>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        - <patches@opensource.cirrus.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jee Heng <jee.heng.sia@intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Derek Fang <derek.fang@realtek.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jose Abreu <joabreu@synopsys.com>, Andrew Davis <afd@ti.com>,
        Shi Fu <shifu0704@thundersoft.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matt Flax <flatmax@flatmax.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        asahi@lists.linux.dev, chrome-platform@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: dt-bindings: maxim,max98357a: Convert to DT schema
Date:   Sat,  3 Dec 2022 17:04:42 +0100
Message-Id: <20221203160442.69594-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org>
References: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim Integrated MAX98357A/MAX98360A amplifier bindings to
DT schema.  Add missing properties ('#sound-dai-cells' and
'sound-name-prefix' from common DAI properties).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

As a maintainer I added recent contributor to this driver/bindings:
Tzung-Bi Shih.  Please ack if you agree to keep an eye on the bindings.
---
 .../devicetree/bindings/sound/max98357a.txt   | 28 ----------
 .../bindings/sound/maxim,max98357a.yaml       | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98357a.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98357a.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
deleted file mode 100644
index 75db84d06240..000000000000
--- a/Documentation/devicetree/bindings/sound/max98357a.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Maxim MAX98357A/MAX98360A audio DAC
-
-This node models the Maxim MAX98357A/MAX98360A DAC.
-
-Required properties:
-- compatible   : "maxim,max98357a" for MAX98357A.
-                 "maxim,max98360a" for MAX98360A.
-
-Optional properties:
-- sdmode-gpios : GPIO specifier for the chip's SD_MODE pin.
-        If this option is not specified then driver does not manage
-        the pin state (e.g. chip is always on).
-- sdmode-delay : specify delay time for SD_MODE pin.
-        If this option is specified, which means it's required i2s clocks
-        ready before SD_MODE is unmuted in order to avoid the speaker pop noise.
-        It's observed that 5ms is sufficient.
-
-Example:
-
-max98357a {
-	compatible = "maxim,max98357a";
-	sdmode-gpios = <&qcom_pinmux 25 0>;
-};
-
-max98360a {
-	compatible = "maxim,max98360a";
-	sdmode-gpios = <&qcom_pinmux 25 0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml b/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml
new file mode 100644
index 000000000000..83ba8666fbb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98357a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98357A/MAX98360A amplifier
+
+maintainers:
+  - Tzung-Bi Shih <tzungbi@kernel.org>
+
+description:
+  Maxim Integrated MAX98357A/MAX98360A is a digital pulse-code modulation (PCM)
+  input Class D amplifier.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98357a
+      - maxim,max98360a
+
+  '#sound-dai-cells':
+    const: 0
+
+  sdmode-gpios:
+    maxItems: 1
+    description:
+      Chip's SD_MODE pin.  If missing the chip is always on.
+
+  sdmode-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay time for SD_MODE pin changes intended to make I2S clocks ready
+      before SD_MODE is unmuted in order to avoid the speaker pop noise.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    amplifier {
+        compatible = "maxim,max98360a";
+        #sound-dai-cells = <0>;
+        sdmode-gpios = <&qcom_pinmux 25 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.34.1

