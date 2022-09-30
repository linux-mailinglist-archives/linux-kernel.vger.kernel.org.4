Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB95F065C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiI3IYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiI3IY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:24:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD21129E1;
        Fri, 30 Sep 2022 01:24:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lx7so3645063pjb.0;
        Fri, 30 Sep 2022 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=jS+l3dIGKbArOyuWAe9VWLB+9jLBaurWIwoqS5nKuX8=;
        b=Gtd3BT7EJKCuKw82inp4gINpe1F3cv9JvLqP7vH060hkioNT5dDYVdpX17ImOSavyO
         p/aveQYLbt0YOMnHcO2qJgODIzszyASKw54tF1yUk2AAHQYQv40lXKpIt/CnM5gNJkby
         mwVu3a82LvRrZCfI4IzkEmQ+CA0qaPFD/04A26YpIA93qmoklwhQK3rrwyu8vlZlo5+n
         uqRL0K3RNfooC1f0y4xpYll6PAE1HVa7Ma6EK86GzxmoVGUJNlxw9HJG6CPqqm4p2fSk
         zDjcjnPvsjjhva1zq/SeWNLI1zm8BvfJ82VdBNkecwhlYajVtQS6xP+mqt0FF+JaoHzz
         fEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jS+l3dIGKbArOyuWAe9VWLB+9jLBaurWIwoqS5nKuX8=;
        b=Fpb1p/BqqRjUQN+4PrV7CxlPa1ZODEqFLZ3RFZ7YJiTQ3mSKzQ911BZIrJQhND9JT5
         pYjYqgRzwu4LhIvlFofwIG9L1tAJ+neCNWnLorLfxl3IahwTdOeUfEKbGiYKbODYBnnJ
         QNYOLGC5cVS2NhTpgMGQWZEkYdCiXjdJZkpEBaIn547pvJNUOIVrmw6+bgnAmXDZZ6ZS
         +jg20bx9gMZEF7RCGXWkjHhfmcuQtmXsf2zCkPhhrQBrDwXAR1faaUoL9i+Yc3nueRhY
         OBhcEBaGyzo9qBoeyPvm0R93Ub82BsCM6tk7QskoDVDLBor08BW9kOMbqW1mMSAEetCB
         5zZg==
X-Gm-Message-State: ACrzQf3QIBRYbHQHjpUjtr/4gfocQXiS5ND8A8YeLqPn6QMO+0CUupGj
        k7/GCgjf0H/wVvMRAza9ey8=
X-Google-Smtp-Source: AMsMyM4io8gqopHHzVVMNCtcfVhtrD7kfVgdDbxZ1JSbkaSsu14LDbnk/vjrkrMQR3yg4moMKtQKJA==
X-Received: by 2002:a17:902:bcc3:b0:178:639a:1a10 with SMTP id o3-20020a170902bcc300b00178639a1a10mr7679039pls.159.1664526268625;
        Fri, 30 Sep 2022 01:24:28 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 63-20020a620442000000b00540d03f3792sm1132083pfe.81.2022.09.30.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:24:28 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/3] dt-bindings: gpio: Add compatible string to support Unisoc UMS512
Date:   Fri, 30 Sep 2022 16:24:05 +0800
Message-Id: <20220930082405.1761-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930082405.1761-1-zhang.lyra@gmail.com>
References: <20220930082405.1761-1-zhang.lyra@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

UMS512 use the same GPIO and EIC controller IP with SC9860.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/gpio/sprd,gpio-eic.yaml          | 33 +++++++++++++++----
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  7 +++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
index c288a8dd44c8..3b7d338d44fb 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -42,12 +42,33 @@ description:
 
 properties:
   compatible:
-    enum:
-      - sprd,sc9860-eic-debounce
-      - sprd,sc9860-eic-latch
-      - sprd,sc9860-eic-async
-      - sprd,sc9860-eic-sync
-      - sprd,sc2731-eic
+    oneOf:
+      - enum:
+          - sprd,sc9860-eic-debounce
+          - sprd,sc9860-eic-latch
+          - sprd,sc9860-eic-async
+          - sprd,sc9860-eic-sync
+          - sprd,sc2731-eic
+      - items:
+          - enum:
+              - sprd,ums512-eic-debounce
+          - const: sprd,sc9860-eic-debounce
+      - items:
+          - enum:
+              - sprd,ums512-eic-latch
+          - const: sprd,sc9860-eic-latch
+      - items:
+          - enum:
+              - sprd,ums512-eic-async
+          - const: sprd,sc9860-eic-async
+      - items:
+          - enum:
+              - sprd,ums512-eic-sync
+          - const: sprd,sc9860-eic-sync
+      - items:
+          - enum:
+              - sprd,sc2730-eic
+          - const: sprd,sc2731-eic
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
index c0cd1ed9809b..a1ecb2b96a76 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -19,7 +19,12 @@ description:
 
 properties:
   compatible:
-    const: sprd,sc9860-gpio
+    oneOf:
+      - const: sprd,sc9860-gpio
+      - items:
+          - enum:
+              - sprd,ums512-gpio
+          - const: sprd,sc9860-gpio
 
   reg:
     maxItems: 1
-- 
2.25.1

