Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540755B982F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIOJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIOJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:51:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05F7326;
        Thu, 15 Sep 2022 02:49:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g4so16877167pgc.0;
        Thu, 15 Sep 2022 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=karGxf6tDVJtMGdp6ovW9u+dUHbs4aPAGfkYDrgwDj5TT+GvOgg4dTIWyTz1ED7ij0
         bfeR0Qp3CAQu//asFXj9+okTLaUmIex3ffhd6CuNyS2zUj6XV1E8m7IuyEw3gcm9Ttn4
         WbidfEi5z7T3LroMMpCfWI0kzq2JTSEGZtg/d4aZk+A09YWpArLN3wVO7TuFxMrtbmuT
         VhkJr7R1fFhVOX9pQ/EdY8mTKY7EsEPf7bDqytIzgqsf8th34IGU7pdhTMSGZ/XTNUpB
         cJ14KTRyBiGc9iQhsIQ2iGuGeQtqJmLImtD37VzIoKniTjXjwC56YkX6HnjDMCaXJV2I
         NVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=dsVo/1mTwqLlh1Q4sJyHfaRKeq3JVo32EoVerPRCtwPR1dczm+XG4vNePIawqE8OJA
         aypA0e7Bv+A9856tt/b6+8f75dclJ8UauHtqAH0Oe2JiDHve3RBonc878phiS/V4IRNm
         Az0LE9HWEttJYknfL1sMpbfTkmZ09Oc88vJIwiv4GeY/KC1HtzX0hsOnEPltcYzt2/wO
         Vy/d36X496sr1EBQo+GXiSK3RRBiYTl/2TLdN2ECijDDxb5v2jv+NSSE0ZfeuwdNkFlY
         6HaItILAMU3qFvCeKIj+fZfWLQaamK0fDLOOemHdmJtyjSUKnzhJYqhP/YjBhGYer/+l
         s0Xw==
X-Gm-Message-State: ACgBeo3EqnAOltNsad+09rLsVl+//FyslF8R3YUUp6KqNM2/PHLhplAi
        dd69XDGH8TXBJ+c1XpXhemU=
X-Google-Smtp-Source: AA6agR7rP6II6rBPfeu9hDGM5xx1njOwHISVNlhJeHqrJ5o7bqrc/mGE7ZkOKF566mvV5xM7tX85HA==
X-Received: by 2002:a63:2c8:0:b0:439:3806:32f6 with SMTP id 191-20020a6302c8000000b00439380632f6mr12044018pgc.217.1663235359590;
        Thu, 15 Sep 2022 02:49:19 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-177-189.emome-ip.hinet.net. [114.137.177.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b00176675adbe1sm12669010plh.208.2022.09.15.02.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:49:19 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 3/8] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Thu, 15 Sep 2022 17:47:31 +0800
Message-Id: <61ca6fd2094d67b3e3ee9aa9a0426774fa01589e.1663254344.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663254344.git.chiaen_wu@richtek.com>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
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

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

