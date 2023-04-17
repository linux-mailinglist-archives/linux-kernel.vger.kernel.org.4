Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7136E45BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjDQKvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjDQKuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860C1BCB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:50:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fw30so10104173ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681728496; x=1684320496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQjiFUEIJDjfqi+ARn/tIHmaD12+fSYJi9sMYr55uiM=;
        b=I9Y3T36BBRuRQ+/oQY4MWx4wBUFhZkopeZ12O0Y0UAOuBPp/i3K/C64DhljaIA2GNz
         xgNfQsUaBggZ6cp0Giws4PXqabHS4u6jMnMdcLvAo82fT50FHW5JNcSkL85ta7u3iaKT
         luFhXTlfk61eldL+XlemltgVWR8oEDWmFkKwDHcIvczeHgCGIUjTNqanX6jyYLPcS6O3
         blW4bzLLPKw8P4ngHfwLRCkJcyen8+ZKuaOOi0sByswQPMoLfPrGy41hzFMKgT49q+R7
         jCGMj/0jYYvsW3VFfL0yeyDwKCEmUuYuMpebGfXE8YiaUFSNyiJDM/emARst83vNvAoi
         DrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728496; x=1684320496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQjiFUEIJDjfqi+ARn/tIHmaD12+fSYJi9sMYr55uiM=;
        b=EiJNfDRxRmMD7KyBaYjdJesaSiksNkCdnYlK15hZc32KlZncIipdbuqL6adOOQ9oJQ
         QZjghZh+nWtn7TGJg1TMp4dshSA69/UuApFzmQG+zgbBxd7p/k8/IKQh+Lq9qeXqqA0u
         ZGxuYU531+x3hT5BegdgVFM4br5egTZMtfXk/0cyNVcC9UCIEOI1OM7/Z065F+8xe7Su
         7UlN4zErULxqTzHCI8fdi5XK9BIug125SqMaWwkBtTnbl8ybTwVlVLflRtSm0DngczZx
         K3EkBtpVDP17/EX/tixr4viddKxm0eVYk6SXC5B0ekFIDqT8IT3ok8x5oDcCwNEOzvns
         0qFA==
X-Gm-Message-State: AAQBX9fg9fWmDHESbc8Mvy81DMSWdQ4M6wbbq9ZtNxZD0kpNPo9R+7cY
        WHmvHrUG9OWwWRl6KPlrs+cDZg==
X-Google-Smtp-Source: AKy350ZMrdnrUy+vYTn4CdbdKdQutI35CFLJ32XsZnlzzG3UWXkA4nZ9ggotZUMn8yAXfOdEcEJVmg==
X-Received: by 2002:a17:906:30c3:b0:94e:e1c7:31b4 with SMTP id b3-20020a17090630c300b0094ee1c731b4mr6782472ejb.48.1681728496197;
        Mon, 17 Apr 2023 03:48:16 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709062a1900b0094f614e43d0sm1953842eje.8.2023.04.17.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:48:15 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/4] dt-bindings: i2c: Correct interrupt support
Date:   Mon, 17 Apr 2023 12:47:57 +0200
Message-Id: <20230417104801.808972-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417104801.808972-1-patrick.rudolph@9elements.com>
References: <20230417104801.808972-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 9f1726d0356b..93ffa67d0d9c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -63,6 +63,24 @@ required:
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
@@ -74,7 +92,7 @@ examples:
         #size-cells = <0>;
 
         i2c-mux@74 {
-            compatible = "nxp,pca9548";
+            compatible = "nxp,pca9545";
             #address-cells = <1>;
             #size-cells = <0>;
             reg = <0x74>;
-- 
2.39.2

