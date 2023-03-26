Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDA6C9643
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCZPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjCZPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:54:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1A4222
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so26220300edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4IC+z7HRU8Cc1CVtVPGm+haTyIr4zX0D35b4yR5tds=;
        b=Ph6Y/hVqttSfYXlBGzcTialeVGkVtWDDKWN8favtE6wSfsbYgDYRVvWZGr8nPVZS7l
         vwX7rnAwVjIYAUKC6QRsNlKuJGlSDQVzFiwFapkg5H3xpgKuVFQLZi7OpCh6lbthpIaS
         TDZwsmT2ZbhrKY3vSjJkTams4iKKCaokAMaYYHub2/xpDuMiCffg4o3MwCkUKj/U/saz
         s+v2EP1oxdndnbH5duBVTGyDcoN1QiS4Him4qTYabhI7h9m6GPSoChvwQtwzrt1ex/NJ
         L3ysUgjwZezKbFNnb4lPgMUD/7Xk1PsGffs+g4mZLY2jNfNEYiAbmEi7neKx7M4mYwiM
         S5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4IC+z7HRU8Cc1CVtVPGm+haTyIr4zX0D35b4yR5tds=;
        b=s96J/2lftOOyI6GRgyF3sROAavnaCob9qQxxmilKgEnsbe2OkjDoOjS307qfrRB/r5
         +W0EpNNpF/jA7usLhjHmrXoEt3nE0bWCXmXqCGcuo2eBMNQudq3d4lO3RUwi/nnHTc6F
         nAj+Z8o16Qz9rUvBhBqEHY2Q18C4mRAXqtnZVwHbgiLobCZneeHNvk21sUo9JBtOYMWR
         zGeqBXTQJpeqUVdMiK9sMSLAWA79yirfFpV0LnNhSIunoikHFmRMxgwEZFEd9ANSzKE5
         bpuRuzr0t3e/gn/8YTYY2GTn9xIkErXa/BFXmRH/H+E+5EQutdpSa3g5tu2EoAHpiZfK
         sAPw==
X-Gm-Message-State: AAQBX9esW2zBKRShTQ8IPXaRQTJE/VV3FFKTEaZW9BdvumACtZjLc2aP
        9jS7S0Q2XlZG+CW9HpGwiOgzcG0DwWGDx+6loAs=
X-Google-Smtp-Source: AKy350b350FJxZeh2eoZVFcQ0aCc50sB3xZPWqjZmfZflxoA8LKai5AuCdZB+dqInD4yF2PChjC40g==
X-Received: by 2002:aa7:d806:0:b0:501:d43e:d1e6 with SMTP id v6-20020aa7d806000000b00501d43ed1e6mr9921345edq.4.1679846069161;
        Sun, 26 Mar 2023 08:54:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm13506742edj.18.2023.03.26.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 08:54:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] dt-bindings: display: panel-simple: merge Innolux p120zdg-bf1
Date:   Sun, 26 Mar 2023 17:54:20 +0200
Message-Id: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing special in Innolux p120zdg-bf1 panel, so just like
other Innolux panels it can be made part of panel-simple.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/panel/innolux,p120zdg-bf1.yaml    | 43 -------------------
 .../bindings/display/panel/panel-simple.yaml  |  2 +
 2 files changed, 2 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml
deleted file mode 100644
index 243dac2416f3..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/display/panel/innolux,p120zdg-bf1.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
-
-maintainers:
-  - Sandeep Panda <spanda@codeaurora.org>
-  - Douglas Anderson <dianders@chromium.org>
-
-allOf:
-  - $ref: panel-common.yaml#
-
-properties:
-  compatible:
-    const: innolux,p120zdg-bf1
-
-  enable-gpios: true
-  power-supply: true
-  backlight: true
-  no-hpd: true
-
-required:
-  - compatible
-  - power-supply
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
-
-    panel_edp: panel-edp {
-        compatible = "innolux,p120zdg-bf1";
-        enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
-        power-supply = <&pm8916_l2>;
-        backlight = <&backlight>;
-        no-hpd;
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 18241f4051d2..01560fe226dd 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -192,6 +192,8 @@ properties:
       - innolux,n125hce-gn1
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
+        # Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
+      - innolux,p120zdg-bf1
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
-- 
2.34.1

