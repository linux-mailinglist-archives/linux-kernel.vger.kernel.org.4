Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126706F2FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjEAJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEAJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:16:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C3F1A2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:15:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a342f7c4cso467938566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682932556; x=1685524556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeUBY+RnRkv7Uj0pwjxAuaeSePuTuD/H6MTh8BP5FD8=;
        b=RWaUwP59XBK+63XwUWLfDvqxBKaSL3rDdDGMwLeKpEBwQ7lvLmoJfHED60WMr/srbu
         4Yyky5uTrOJN7dw5j1lru0fViJqe9u1l18BuZknA6LutocwXiorqhFfZJhl/FswqfNek
         evWwp3qoU66xKmE08Dpc+CAINLNHzg2vkGt2navJJ9sZS6ONZGS2W34vB9xT3K7aBzSm
         yuwGewFTogft2qWC2Su6i9F6fxLYtpcQ1Xq1cYPiJyiCJ4fkkN+iWbE9TM2ZYrq70M2o
         hIDw+neGnn7reT6A4w63Q4lzOful4kXtkHsLqC/QMCi1q57CIURV1wsN0CUL/+vq/G+x
         eXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682932556; x=1685524556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeUBY+RnRkv7Uj0pwjxAuaeSePuTuD/H6MTh8BP5FD8=;
        b=gBWy9HYVw742V89QxkikWJ5PEJGS6hXhKTDTHQd+pz19I7Ht2F4471HKJPdQegicfe
         Q0Haiewt8paX64UC5l1XmO+FG74TIm4wE55wHP7fW/08FQznPaAdd9ciNa4VPcqzl7Qz
         V22UCE4GTPire//VXLBuuj3rldoMqjvXPBPTfi20g1ukBuCavoloaTTLArCexYIrtK72
         JVrQQ7pUpMcrn5D3xymXSqDfNzORZR8PkVqVVm5Ru6EevE7kNClTIcTnzgRt0SQCQy/2
         vF+5UGUw1Dhh2jXI5jhauQ9fWsjzq78NORvIeWjjSDLrYHqGHJKjFENtcQOmJ3wJL+Cr
         +L4A==
X-Gm-Message-State: AC+VfDx4gH4f2szuyILT0rLtxhGB/+aY9N4k8cbNo+1akoBWxRxSBvpS
        vtQsR4wWtA3L8xfuPkrvPGA6iJnLeQGC6URETuE=
X-Google-Smtp-Source: ACHHUZ55kwe8/6XT20zB2ulgxQiEN/YYVlqI6VPVVzj5ewpfI6sgsU+QwJug5O/jMSyUuIwD5hMXrw==
X-Received: by 2002:a17:906:ee88:b0:961:800b:3f1e with SMTP id wt8-20020a170906ee8800b00961800b3f1emr3206640ejb.73.1682932556482;
        Mon, 01 May 2023 02:15:56 -0700 (PDT)
Received: from fedora.. (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id xa3-20020a170907b9c300b0094e954fd015sm14714266ejc.175.2023.05.01.02.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 02:15:56 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v14 1/4] dt-bindings: i2c: pca954x: Correct interrupt support
Date:   Mon,  1 May 2023 11:15:48 +0200
Message-Id: <20230501091552.847240-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501091552.847240-1-patrick.rudolph@9elements.com>
References: <20230501091552.847240-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only some of the PCA954x compatible ICs have interrupt
capability, but the binding advertises it on all ICs.

Sync the dt-binding with the driver and only advertise it on:
 - nxp,pca9542
 - nxp,pca9543
 - nxp,pca9544
 - nxp,pca9545

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 9f1726d0356b..e5c1070903ef 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -12,9 +12,6 @@ maintainers:
 description:
   The binding supports NXP PCA954x and PCA984x I2C mux/switch devices.
 
-allOf:
-  - $ref: /schemas/i2c/i2c-mux.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -63,6 +60,24 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/i2c/i2c-mux.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - nxp,pca9542
+                - nxp,pca9543
+                - nxp,pca9544
+                - nxp,pca9545
+    then:
+      properties:
+        interrupts: false
+        "#interrupt-cells": false
+        interrupt-controller: false
+
 unevaluatedProperties: false
 
 examples:
@@ -74,7 +89,7 @@ examples:
         #size-cells = <0>;
 
         i2c-mux@74 {
-            compatible = "nxp,pca9548";
+            compatible = "nxp,pca9545";
             #address-cells = <1>;
             #size-cells = <0>;
             reg = <0x74>;
-- 
2.39.2

