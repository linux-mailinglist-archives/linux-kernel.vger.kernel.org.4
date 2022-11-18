Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EF62F3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiKRLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiKRLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:32:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E617898C9;
        Fri, 18 Nov 2022 03:32:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so8155060wrq.3;
        Fri, 18 Nov 2022 03:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGBvDsZvz4SS5lSwvnc1CIkXz2KLisopDlJ3Cu1rcIY=;
        b=YP/gPDU3lcbMHuuY2uV6ZvvqPZGkkS4qVJJUzx3HIZlKhMDppFc+8vPlgQwDBUKjjK
         m8hel4EOVFOgB4hfHIaj8kqPYXQZzV6Wo8HyvdgEti4wHMLg/a+OpFrUmSRevai9gofv
         ICQR+B7gGLUCkLdPXzEosSFEYHRnou8J9VU+KdeHTPu6R7WC4pAHu9pXJL6EianYPBVh
         jqKq7yuY7C1o1rFJ0ja3lD/aV13Fx4X+mYmypAylu6fNnGNVKWgFeuQhnDQqF4ZvGgAi
         45y6MZoQ9yOVeDJHWKeT2lLbW9INChQnmwErfwDjpsUlpMlPPVoBseYg2GdpLgVV170A
         XS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGBvDsZvz4SS5lSwvnc1CIkXz2KLisopDlJ3Cu1rcIY=;
        b=RiS0eeq5XvDnRQt7C3SgIoTWnwKGKZOn9dC/OYEJExbKrmFpKYYyxVSEr16jZKoAzK
         F7BZb07DGD0SQwNnVPpBdozP6XULyAmryDM7LxySlz8OQjCZwlDg1c7ACOocbQSfGeue
         RailHmzyrPW25XTMKllKzKVvmXVvnJIIZANGTxiOIXPq4Ifewe4eGkcFl1SSaqQEtBrz
         Vi8/94+lCOsIE+mk6Ci/xYtcWjvBtx8BOX80vuvKNYM4XscKqCbyRqGH71BML3vtssYm
         gM4b9GrTtu65nIjWVlaprFOZTTUQM+ZI/luRuliDl8m0jHol6NoT9T1ShT3Qn6aB289s
         wcFQ==
X-Gm-Message-State: ANoB5pmB/FpJNgPG+kBsbRsWP64DIrLN+DfhNezz7OVbaY4Yu+2192Kh
        zpc+LpbEcBxN2cKiGyC3Zmk=
X-Google-Smtp-Source: AA0mqf4hjaom4oDUOVYUd8J7wjeXechldZmbUMgyoa9JCnYpRDSa/3Lj1UIECEFQ7og93YshAWpfYQ==
X-Received: by 2002:a5d:6dc8:0:b0:236:53d3:5a48 with SMTP id d8-20020a5d6dc8000000b0023653d35a48mr4063565wrz.66.1668771128909;
        Fri, 18 Nov 2022 03:32:08 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm9894817wms.5.2022.11.18.03.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:32:08 -0800 (PST)
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
Subject: [PATCH v5 5/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin controller
Date:   Fri, 18 Nov 2022 14:30:26 +0300
Message-Id: <20221118113028.145348-6-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118113028.145348-1-y.oudjana@protonmail.com>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
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
index f26584af5c8c..c2238a86b7fe 100644
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
@@ -59,6 +60,41 @@ required:
 
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

