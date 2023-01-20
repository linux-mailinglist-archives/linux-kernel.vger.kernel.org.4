Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D2C6748B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjATBSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjATBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:18:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D83A259A;
        Thu, 19 Jan 2023 17:18:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so2946127wmo.1;
        Thu, 19 Jan 2023 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQS0UPbaBoarfLXOGtyFBjEzAD9Dxq+lDRq2U9zCnqg=;
        b=DGjiIbB9aw1rfohZXvXIM3LiXbbCeUhtxz4CSgt/4LclPcNh8AHWJnTi7YyxAtaKDR
         Wsdb5hJLbJZ6O5iwPKC5779WIBOhwyMZJHBlKw5nFtMafymVrQrlc3O8PSvnHRS3iCB9
         F0FU/4NwElAsfHNmwFGHmNfMLn+KQ8c8VTQ2rC1bKcL/NLRng6Sg4v8wKosKPwjutGOr
         RQNoi5EACd3mPzLsHThjfz2hScy7MLlWd6YRokBp9rYShxUXGEmYh+9L6j92/lly4+4S
         qFjSWbmBqX8JlJLeAybhD3hlbcLNzEhjuR92/IZcSAuSRNjK+yciPkqYlxG7Fr9RgFgZ
         lTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQS0UPbaBoarfLXOGtyFBjEzAD9Dxq+lDRq2U9zCnqg=;
        b=CbI6Kl7MIQ4+YIbW+KKUI0LAAonWt+dLryPPXbPkuoQGTqgBIOsxoyBsbAI0SEnciu
         Lgve1xeIqAfkzr7nDl66S5/H61z1VGOtGxNrj4ek5Xg1yQ41NMSTMCsYILb3OO6tKjUW
         4EPj+hzT4ZIIZuVQJwJz93hlNEPHb1ovqS7ob0mUSEwhUsX3mVIITwLkJe3kUfp/k9W7
         AmWN74Tr5TMhLKmicyGt3B2XkFxFipN+/BXpTkREBc/rTFQ5HyNKUpHwSMXCdBGK5obh
         vTisjbiIkk3Fdw/a0o1gwG6n8rpKRQFB6gssNMuE9BuAUn1NQ/aVpDZPLe8BgWzTrYqK
         Fq3g==
X-Gm-Message-State: AFqh2kqNSQxWOiLkQVO4YIF9//HvSRJU6dfhDl5COppHvkK/TYMyPvo4
        9KKo2EsN0n8FVKFEHvynEb7Q5ggg5WALuFDk
X-Google-Smtp-Source: AMrXdXv57EVOqsHRdscs+3XcGB88r4I/YioRgQpMS2rKNUR+B7M3EDAQBG/JVryNMXHj8tkX91IyIA==
X-Received: by 2002:a05:600c:225a:b0:3d3:5c21:dd99 with SMTP id a26-20020a05600c225a00b003d35c21dd99mr11996935wmm.18.1674177494240;
        Thu, 19 Jan 2023 17:18:14 -0800 (PST)
Received: from fedora.36 ([78.10.206.41])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm715696wmq.29.2023.01.19.17.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:18:12 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Grzelak?= <mchl.grzlk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Grzelak?= <mchl.grzlk@gmail.com>
Subject: [PATCH] dt-bindings: sound: audio-graph-port: Add capture and playback
Date:   Fri, 20 Jan 2023 02:17:44 +0100
Message-Id: <20230120011744.550701-1-mchl.grzlk@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running 'make DT_SCHEMA_FILES=renesas,rsnd.yaml dt_binding_check'
gives following warning:

bindings/sound/renesas,rsnd.example.dtb:
sound@ec500000: port:endpoint: Unevaluated properties are not allowed
('capture', 'playback' were unexpected)
        From schema: bindings/sound/renesas,rsnd.yaml

Running 'make ARCH=arm64 DT_SCHEMA_FILES=renesas,rsnd.yaml dtbs_check'
gives 140 warnings presented under tag [WARNINGS].

Fix all of them by allowing capture and playback in subnode 'endpoint'
in sound/audio-graph-port.yaml.

While editing audio-graph-port.yaml, drop quotes after referencing some
schemas.

Regarding files referencing audio-graph-port.yaml, no new errors were
observed after applying this change, tested with DT_SCHEMA_FILES set to:
	marvell,mmp-sspa.yaml          nvidia,tegra186-asrc.yaml
	nvidia,tegra186-dspk.yaml      nvidia,tegra210-admaif.yaml
	nvidia,tegra210-adx.yaml       nvidia,tegra210-ahub.yaml
	nvidia,tegra210-amx.yaml       nvidia,tegra210-dmic.yaml
	nvidia,tegra210-i2s.yaml       nvidia,tegra210-mixer.yaml
	nvidia,tegra210-mvc.yaml       nvidia,tegra210-ope.yaml
	nvidia,tegra210-sfc.yaml       renesas,rsnd.yaml
	sgtl5000.yaml                  socionext,uniphier-aio.yaml
	socionext,uniphier-evea.yaml   st,stm32-sai.yaml
	wlf,wm8962.yaml

[WARNINGS]:

sound@ec500000: ports:port:endpoint: Unevaluated properties are not
allowed ('capture', 'playback' were unexpected)
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb

sound@ec500000: ports:port@0:endpoint: Unevaluated properties are not
allowed ('capture', 'playback' were unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb

sound@ec500000: ports:port@1:endpoint: Unevaluated properties are not
allowed ('playback' was unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb

sound@ec500000: ports:port@2:endpoint: Unevaluated properties are not
allowed ('playback' was unexpected)
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb

sound@ec500000: ports:port@3:endpoint: Unevaluated properties are not
allowed ('capture' was unexpected)
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb

sound@ec500000: port:endpoint: Unevaluated properties are not allowed
('playback' was unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb

sound@ec500000: Unevaluated properties are not allowed ('ports' was
unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dtb
	arch/arm64/boot/dts/renesas/r8a77950-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77950-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77960-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77960-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77961-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dtb
	arch/arm64/boot/dts/renesas/r8a77961-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a77965-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a77995-draak.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m1-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-salvator-xs.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb.dtb
	arch/arm64/boot/dts/renesas/r8a779m3-ulcb-kf.dtb
	arch/arm64/boot/dts/renesas/r8a779m5-salvator-xs.dtb

sound@ec500000: Unevaluated properties are not allowed ('port' was
unexpected)
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
	arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dtb
From schema: bindings/sound/renesas,rsnd.yaml

Signed-off-by: Michał Grzelak <mchl.grzlk@gmail.com>
---
 .../bindings/sound/audio-graph-port.yaml         | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index f5b8b6d13077..4238128eb52e 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -19,11 +19,11 @@ properties:
     description: "device name prefix"
     $ref: /schemas/types.yaml#/definitions/string
   convert-rate:
-    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
+    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-rate
   convert-channels:
-    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-channels
   convert-sample-format:
-    $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
+    $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-format
 
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
@@ -67,12 +67,16 @@ patternProperties:
             - pdm
             - msb
             - lsb
+      playback:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+      capture:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
       convert-rate:
-        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-rate"
+        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-rate
       convert-channels:
-        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-channels"
+        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-channels
       convert-sample-format:
-        $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
+        $ref: /schemas/sound/dai-params.yaml#/$defs/dai-sample-format
 
       dai-tdm-slot-num:
         description: Number of slots in use.
-- 
2.37.3

