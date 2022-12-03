Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5987A64179A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLCQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLCQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:05:00 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54C1EAF7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:04:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h10so8644855ljk.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8s/BzOwhxQIlxHUBYJ4oHPfR09CSoSGvGG+JpoNTu0=;
        b=eYIi4hgooxDpD1NV+FF5vfQnUmip7fWcTWuPt0CGhwIp8KwLS7xeamBNDwWwgN03vr
         5wgdGYEHoboyRIn6Q/MD4DWaFkqNdjiGEXIxe8QWen38kp/9aWEOXf7ntp+ccDma818H
         Y8JBT5raTEYbfbY8M8973YIvB+7cnSk/+zVt+x5KrZuOrOXlWxF0FlAxB/Wj23NJnVx4
         OMRCV5AZ5jvZhNwxl9fCpj87LlJnHV6+YkjA2BbZIG1fPfypXiHIaUCDed1LCpA4+IwU
         ejnTcI9E/mMSDFmRH5fCGyvt21ERzet1j4+J5VW9NOajXMmv7hvv/eOz1tOR+cgE+sbm
         WYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8s/BzOwhxQIlxHUBYJ4oHPfR09CSoSGvGG+JpoNTu0=;
        b=LjYqqvDuCT8q8llSkDlwXjvkvcUqO6/ey0wj5/yat6PYDQJEn9FbbEO0va2E5WNUl5
         onkV3R+6uZg8kBE5enLZONWHnWZE2XRypeTTxz/07iQWbLI22pK47XYkDiGEEkwHs+cX
         GQpl5sMeIUJBTPHyXxb2st7jBjOp6nI7Cp5hLAsIxAzdeh+73rPbuDIarC1CNNDwebxx
         1eY5DNcuul2ecnacweL8Timv57OuCwaxKCYnDL0zYGojx9UAarb5qeDAxJOz4dFbLB5H
         dkUFIbqUcf+hgK/wU+fvbQi9k9Y4SxsbdBOxphheUquUhKR8jXqyfC/ks8hepd41lAOV
         5Kzg==
X-Gm-Message-State: ANoB5pmxzQy79aORo40Po3WjHh4GQKT/+jE0GLQ3/FU5FCzyliDUshVZ
        nwBYKTde4xjLOGki5Yl9Dh3YKQ==
X-Google-Smtp-Source: AA0mqf58/79Rqg4yRCVG1xawZLwuCnaSB+HmPh+D7DumMA2xgZArvwb0/P7UWd6mDLsK8wlUOJjcvw==
X-Received: by 2002:a05:651c:1788:b0:277:4e4:d21a with SMTP id bn8-20020a05651c178800b0027704e4d21amr17825924ljb.196.1670083496599;
        Sat, 03 Dec 2022 08:04:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d11-20020ac2544b000000b004946bb30469sm1441320lfn.82.2022.12.03.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 08:04:51 -0800 (PST)
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
Subject: [PATCH 1/3] ASoC: dt-bindings: Extend name-prefix.yaml into common DAI properties
Date:   Sat,  3 Dec 2022 17:04:40 +0100
Message-Id: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename name-prefix.yaml into common DAI schema and document
'#sound-dai-cells' for completeness.  The '#sound-dai-cells' cannot be
really constrained, as there are users with value of 0, 1 and 2, but at
least it brings definition to one common place.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is an output of discussion here:
https://lore.kernel.org/all/Y255C+TGNVJ9fs8A@sirena.org.uk/
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml  | 2 +-
 Documentation/devicetree/bindings/sound/amlogic,aiu.yaml    | 2 +-
 .../devicetree/bindings/sound/amlogic,g12a-toacodec.yaml    | 2 +-
 Documentation/devicetree/bindings/sound/amlogic,t9015.yaml  | 2 +-
 Documentation/devicetree/bindings/sound/awinic,aw8738.yaml  | 2 +-
 .../bindings/sound/{name-prefix.yaml => dai-common.yaml}    | 6 ++++--
 Documentation/devicetree/bindings/sound/dmic-codec.yaml     | 2 +-
 .../devicetree/bindings/sound/linux,spdif-dit.yaml          | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra186-asrc.yaml     | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra186-dspk.yaml     | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-adx.yaml      | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-amx.yaml      | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-dmic.yaml     | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-i2s.yaml      | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-mixer.yaml    | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-mvc.yaml      | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-ope.yaml      | 2 +-
 .../devicetree/bindings/sound/nvidia,tegra210-sfc.yaml      | 2 +-
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml    | 2 +-
 Documentation/devicetree/bindings/sound/rt5659.txt          | 2 +-
 .../devicetree/bindings/sound/simple-audio-amplifier.yaml   | 2 +-
 .../devicetree/bindings/sound/simple-audio-mux.yaml         | 2 +-
 Documentation/devicetree/bindings/sound/ti,src4xxx.yaml     | 2 +-
 23 files changed, 26 insertions(+), 24 deletions(-)
 rename Documentation/devicetree/bindings/sound/{name-prefix.yaml => dai-common.yaml} (81%)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 7cdffdb131ac..74cefdf1b843 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Neil Armstrong <neil.armstrong@linaro.org>
 
 allOf:
-  - $ref: /schemas/sound/name-prefix.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#
 
 description: |
   The Amlogic Meson Synopsys Designware Integration is composed of
diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
index 0705f91199a0..6350dfc0a926 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
index 77469a45bb7a..23f82bb89750 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
index 580a3d040abc..5f5cccdbeb34 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,t9015.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml b/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml
index dce86dafe382..bc6c6b172238 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw8738.yaml
@@ -15,7 +15,7 @@ description:
   function (primarily the power limit for the amplifier).
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/name-prefix.yaml b/Documentation/devicetree/bindings/sound/dai-common.yaml
similarity index 81%
rename from Documentation/devicetree/bindings/sound/name-prefix.yaml
rename to Documentation/devicetree/bindings/sound/dai-common.yaml
index 2fe57f87ac52..d858eea73ed7 100644
--- a/Documentation/devicetree/bindings/sound/name-prefix.yaml
+++ b/Documentation/devicetree/bindings/sound/dai-common.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/sound/name-prefix.yaml#
+$id: http://devicetree.org/schemas/sound/dai-common.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Component sound name prefix
+title: Digital Audio Interface Common Properties
 
 maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
@@ -18,4 +18,6 @@ properties:
       sink/source names may use this property to prepend the name of their
       sinks/sources with the provided string.
 
+  '#sound-dai-cells': true
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.yaml b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
index bba27c985996..59ef0cf6b6e5 100644
--- a/Documentation/devicetree/bindings/sound/dmic-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml b/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
index 808f6d2736c7..fe5f0756af2f 100644
--- a/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
+++ b/Documentation/devicetree/bindings/sound/linux,spdif-dit.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Mark Brown <broonie@kernel.org>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
index d82415c21271..e15f387c4c29 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-asrc.yaml
@@ -23,7 +23,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
index 3d538df878ea..e1362c77472b 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
@@ -18,7 +18,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
index ea0dc0ece1bc..e4c871797fa6 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-adx.yaml
@@ -19,7 +19,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
index 1aff61f072bb..021b72546ba4 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-amx.yaml
@@ -18,7 +18,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
index 0f9d2b461e02..bff551c35da7 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
index 12cd17eede99..a82f11fb6c9a 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
index 570b03282aeb..049898f02e85 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mixer.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
index 4aecbc847b98..d0280d8aa3af 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mvc.yaml
@@ -20,7 +20,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
index 9dc9ba590fa3..5fc03b8771b1 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
index 694f890d6305..185ca0be4f02 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-sfc.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Sameer Pujar <spujar@nvidia.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index 7f2e68ff6d34..fd2415e231eb 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Stephan Gerhold <stephan@gerhold.net>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
index 013f534fa059..8f3f62c0226a 100644
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ b/Documentation/devicetree/bindings/sound/rt5659.txt
@@ -42,7 +42,7 @@ Optional properties:
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 - realtek,reset-gpios : The GPIO that controls the CODEC's RESET pin.
 
-- sound-name-prefix: Please refer to name-prefix.yaml
+- sound-name-prefix: Please refer to dai-common.yaml
 
 - ports: A Codec may have a single or multiple I2S interfaces. These
   interfaces on Codec side can be described under 'ports' or 'port'.
diff --git a/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml b/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
index 5428ba9e23a6..5db1f989d050 100644
--- a/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-audio-amplifier.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Jerome Brunet <jbrunet@baylibre.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
index b5fc35ee9b65..9f319caf3db7 100644
--- a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
@@ -14,7 +14,7 @@ description: |
   their input line is connected to the output line.
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/sound/ti,src4xxx.yaml b/Documentation/devicetree/bindings/sound/ti,src4xxx.yaml
index 9681b72b4918..988ce8d8028f 100644
--- a/Documentation/devicetree/bindings/sound/ti,src4xxx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,src4xxx.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Matt Flax <flatmax@flatmax.com>
 
 allOf:
-  - $ref: name-prefix.yaml#
+  - $ref: dai-common.yaml#
 
 properties:
   compatible:
-- 
2.34.1

