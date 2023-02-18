Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8269B9A7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBRLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:17:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9181CACB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b3-20020a17090ae38300b002341fadc370so442156pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRUarQyWTXy/UaQ+aTCiS9aEshqx6SrntwaJME4vnY0=;
        b=FhaH7iwlgirzBhkctvbPIaE33nUBelcGHAF8fq0lsjOkQ+cusRFz/4cccjVw6NEftK
         PpoX0TZ8w3vqQVGe5P/lYxblKHcsFlSVpBKNCV54TFjvgawSpSzJc1EE02sPm2cIp82b
         392DVfxuznUnL2wiI4prL2FfCxja2ElN7chAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRUarQyWTXy/UaQ+aTCiS9aEshqx6SrntwaJME4vnY0=;
        b=NRHfTP8ltXkVl0e1ZKrlJjV5oncRdHtFvWg3vXPCAL1wxHQ32lgvOgqnsbzvREK6Bo
         z/zF/64Q8YRU/CvVIEGOoYBHiIj7FmA2tYEpCduHoCOExBhF7Mc3rNF3l3TT6wBOdkCw
         wyYhz8F5G6x6BYvsoDwUkD6eo8jN8zMzct+e3xVWXJM+dIImNMn3Ox+lm85w6eJ+F2xu
         rckv22QwxUB4O/PIJ+iMDxNZwg9j59+xGIDvGaI/cFhMyQh2HIWWs4TvKiOrk2V0dEpo
         od/gWNVL0HPfjwcp09bfd3g8HATaNPG5pxNFhuuy90yEGlmC3laWL9wTYPKcBhWymueO
         hxZQ==
X-Gm-Message-State: AO0yUKVViIEZKoI1RcjkiQ2X8i7JOuVxmHi+a/XsAJdyGcMd5pTfVVu6
        dpUJj6ovIPJTbzPUX2Vt8GLjHw==
X-Google-Smtp-Source: AK7set+FohWYixBOFWTvodfYG9ONEn4rCbUp2cY1CE91qYHZ6E0/D4C1ES2aYaY6oImj8VUL+8mG8A==
X-Received: by 2002:a05:6a20:1610:b0:c7:5983:7a82 with SMTP id l16-20020a056a20161000b000c759837a82mr7002881pzj.27.1676719049830;
        Sat, 18 Feb 2023 03:17:29 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:88dd:be84:8f65:fec2])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b005a8686b72fcsm4457829pfi.75.2023.02.18.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 03:17:29 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 1/5] dt-bindings: display: bridge: Add ddc-i2c-bus for anx7688
Date:   Sat, 18 Feb 2023 19:17:08 +0800
Message-Id: <20230218111712.2380225-2-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230218111712.2380225-1-treapking@chromium.org>
References: <20230218111712.2380225-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a optional "ddc-i2c-bus" property for anx7688 bridge. This
allows the bridge to register a .get_edid callback.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- New in v3

 .../bindings/display/bridge/google,cros-ec-anx7688.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
index a44d025d33bd..9d5ce8172e88 100644
--- a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
@@ -25,6 +25,10 @@ properties:
     maxItems: 1
     description: I2C address of the device.
 
+  ddc-i2c-bus:
+    description: phandle link to the I2C controller used for DDC EDID probing
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -59,6 +63,7 @@ examples:
         anx7688: anx7688@2c {
             compatible = "google,cros-ec-anx7688";
             reg = <0x2c>;
+            ddc-i2c-bus = <&hdmiddc0>;
 
             ports {
                 #address-cells = <1>;
-- 
2.39.2.637.g21b0678d19-goog

