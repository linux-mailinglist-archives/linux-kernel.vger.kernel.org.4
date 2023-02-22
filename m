Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FE69FB41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBVSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBVSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331141B46;
        Wed, 22 Feb 2023 10:40:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v3so8678214wrp.2;
        Wed, 22 Feb 2023 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER0vFI5ErhPpjBGFO4kcWk4X1/JJbNjdl3KY04hLIxU=;
        b=fr+C4nCniGBv/+XrMWb+6QS0YLPvFrIVUeIH1AiW92b0gF4mU5BCEKXz/gP5f3vm9q
         X8qwt2biAAHZP+vh3zkfHTY7Zfjx9Bo0OhkXafnAA/klJDLmMeQjvYpw4ILaL8l1cLHu
         vTbqfyjndrLYZQljI+Is0w+Zz4RhqqwnFRYVtzCjFQIfskP7ETx1D7vzvL+F7osCT7/L
         q0P4KckrybXqS/yas96RskQE3ttlpD5sDnx0GwVefIVosFGy+8GsBgW8MK4XiU/i0Fmh
         pyb1fFOq+HyviNflqtVLB7SlneKR17VlqH1Q6/0BbfzevyeoNSaaiKa06f+9Az8p+3BU
         /1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER0vFI5ErhPpjBGFO4kcWk4X1/JJbNjdl3KY04hLIxU=;
        b=KtFzzJeeB3ZVBCHUIDu0uoMo6DRkE7o3enZpga9E0kla0ZFof5Ixfnpwj28R24RIf6
         tjmOVwVCiudLzcx5m0us/OgDRpLSqAN1jmqZpgZm3CpKB9E/6va8rUIFzqzQJ3chaI5f
         8LhoUPEtlJKcSjKDjhvSnUJZOdFqg3KZWi9HcCA6vSBjvpX7W8jJRjJWgyPyCTiZaYax
         LFjKqEXvZUkJJ5NolyES7K00CWlckaLd1MLqE60Yo8CeIIAHqXIyvqNcu+Wp3OH7y32D
         dU19DS8s+1LJe3oxmdPfNJAAUYxiogj8PTjHEuVT+HEcbu8IE1rZNka+c9emYY6uZyb7
         JYHQ==
X-Gm-Message-State: AO0yUKXhgw9wg4TJF3gWI7/EoSRD0M9K5zJbYpF+h5hoR2ag2RGOYykU
        vtiPb9ObY4f6XT2/UgPdjb3e+PVCFPIYAEkH
X-Google-Smtp-Source: AK7set+hUEzBr/atsckOQnBk4amaaKvrW6cIYsaW6dVu0IN7hMFgpj+XblzOrIPYeGOhOG/wQdNDrA==
X-Received: by 2002:a5d:5087:0:b0:2c5:60a9:9cd2 with SMTP id a7-20020a5d5087000000b002c560a99cd2mr7204948wrt.28.1677091222807;
        Wed, 22 Feb 2023 10:40:22 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:22 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 08/16] dt-bindings: pinctrl: ralink: rename to mediatek
Date:   Wed, 22 Feb 2023 21:39:24 +0300
Message-Id: <20230222183932.33267-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Ralink was acquired by MediaTek in 2011. These SoCs have been rebranded as
MediaTek. Rename the schemas to mediatek.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 ...ink,mt7620-pinctrl.yaml => mediatek,mt7620-pinctrl.yaml} | 6 +++---
 ...ink,mt7621-pinctrl.yaml => mediatek,mt7621-pinctrl.yaml} | 6 +++---
 ...ink,rt2880-pinctrl.yaml => mediatek,rt2880-pinctrl.yaml} | 6 +++---
 ...ink,rt305x-pinctrl.yaml => mediatek,rt305x-pinctrl.yaml} | 6 +++---
 ...ink,rt3883-pinctrl.yaml => mediatek,rt3883-pinctrl.yaml} | 6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7620-pinctrl.yaml => mediatek,mt7620-pinctrl.yaml} (98%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,mt7621-pinctrl.yaml => mediatek,mt7621-pinctrl.yaml} (97%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinctrl.yaml => mediatek,rt2880-pinctrl.yaml} (95%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt305x-pinctrl.yaml => mediatek,rt305x-pinctrl.yaml} (97%)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt3883-pinctrl.yaml => mediatek,rt3883-pinctrl.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
index 531b5f616c3d..3bf58da8a394 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,mt7620-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt7620-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink MT7620 Pin Controller
+title: MediaTek MT7620 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
+  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
index 74923ca35c81..4dfe3da5fd40 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,mt7621-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt7621-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink MT7621 Pin Controller
+title: MediaTek MT7621 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink MT7621 pin controller for MT7621 SoC.
+  MediaTek MT7621 pin controller for MT7621 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
index aceea6248614..7395e4434e64 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt2880-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,rt2880-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink RT2880 Pin Controller
+title: MediaTek RT2880 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink RT2880 pin controller for RT2880 SoC.
+  MediaTek RT2880 pin controller for RT2880 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
index 4c87fe201809..61fcf3ab1091 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,rt305x-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,rt305x-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink RT305X Pin Controller
+title: MediaTek RT305X Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
+  MediaTek RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
   SoCs.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
index 71049a2b2779..ab20f67c47f0 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3883-pinctrl.yaml
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,rt3883-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,rt3883-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink RT3883 Pin Controller
+title: MediaTek RT3883 Pin Controller
 
 maintainers:
   - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  Ralink RT3883 pin controller for RT3883 SoC.
+  MediaTek RT3883 pin controller for RT3883 SoC.
   The pin controller can only set the muxing of pin groups. Muxing individual
   pins is not supported. There is no pinconf support.
 
-- 
2.37.2

