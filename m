Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A35611618
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ1Pgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiJ1PgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:36:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D698CA7;
        Fri, 28 Oct 2022 08:35:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z18so3403931edb.9;
        Fri, 28 Oct 2022 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N2PvASe0lDveH2nrSsLN3jw3tAnkKgsqkH381a4tLU=;
        b=YCYYEiC6ZP0u0OCAGXedVuxkRgYPDu9JrKNJ3TTR/WwjOHNbafSepLvJeNIcSBEyuO
         zKzmtO+5U2a4cWnKqgO4tBXRLtKolBdmnaoYVylT9NCJT+GnJJMCQDiE1UQYpAq/b5qA
         urdvcoADDKNZW6dh03OetTZSKwiAT1FFErC7VglOK2UB9uqIHsy/StLyj5GKkC+YZGNa
         dzDAujfC1DozPQxnEevnc4KxI+TAausumwg2GMmbhx6di7pq7zEV5gxoE82WW7LfMZKY
         5KAbY3wA0HlQfZ/bBYelRzsBN1fBZQA5qcR0EBpaJXM9O44cLPqpKUMSUvA7OjA66+8o
         +x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N2PvASe0lDveH2nrSsLN3jw3tAnkKgsqkH381a4tLU=;
        b=hFwqJjqYIhCl0SVeUKQ7926WDHyADd/mZuu4Kh1fZ4pzMg0riXziCJ5uj+qPlzufVE
         LwWXjqrVnvwZOx1sPKzhUqjkOntCstNMUoO3sbEy9WE9oIbGSf8yAHa/ca9IAu5wEhQ1
         e89nWBi2wd9xs0nQFJhYcQcFtLlWW41wk0A/FrUL32Te7EpcyS4TIJV0QxTSzWtWYIOy
         uSVYtuqXv6Yz3J6UlJ1bqxPE0nOxBCnLRsLemlnGTmz9g+Tj+RF3it023Km/AhsDYu6g
         RPxWh/1EW/1DBbNpVip9ppSJqQN/0oqhQRqeWUohf9K9N5wxGkG0n49mjYuGigQ50kWu
         hjnA==
X-Gm-Message-State: ACrzQf3LYuFtQptuYF4l2R2L5cOw/oC3vX4lWF64uM7KDOfRocXdeSzL
        VbMsuixeombrc2DAxy/4zeU=
X-Google-Smtp-Source: AMsMyM5n9VDoT6WVu6zsbXMqR4Ju5Gh2lQ1W0e1X2+x2OHEoWP+piB6GCKAgLzHS2DwFFqNC4PHfnw==
X-Received: by 2002:a50:cc07:0:b0:453:4427:a918 with SMTP id m7-20020a50cc07000000b004534427a918mr2913edi.121.1666971343130;
        Fri, 28 Oct 2022 08:35:43 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:42 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 11/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin controller
Date:   Fri, 28 Oct 2022 18:35:03 +0300
Message-Id: <20221028153505.23741-12-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The MT6765 pin controller has had a driver for a while, but DT
bindings were never documented for it.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 6f2cffe50b11..88a4c4ef28e5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -18,6 +18,7 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
       - mediatek,mt6797-pinctrl
@@ -150,6 +151,41 @@ patternProperties:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6765-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: iocfg6
+            - const: iocfg7
+            - const: eint
+
+        interrupts:
+          items:
+            - description: EINT interrupt
+
+      patternProperties:
+        '-pins$':
+          patternProperties:
+            '^pins':
+              properties:
+                drive-strength:
+                  enum: [1, 2, 4, 16]
+
   - if:
       properties:
         compatible:
-- 
2.38.1

