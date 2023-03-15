Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD416BAED8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCOLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjCOLJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72D8B053;
        Wed, 15 Mar 2023 04:07:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso3226778pjf.0;
        Wed, 15 Mar 2023 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9Xe7G0mUprolJIwH6MJzsVRZJv7ADzG9ZALSt3qn7I=;
        b=bnlcAHsnJ4trii4aCzzIEel+4/5DQsER6/JTZL5KRxvcnFIvy+SHL0ICtnSnNvLA6G
         Qo6rtncYrZnNuagheheDLAbDFfQSrPW2CwEvkEcow494V0zxgnnYIAg5yx0JqFo8r0fu
         BjjNrAt0yyNOg0i+FrIRhcjUg7cQLV8n0E+PDHc9tHBsvQXQxmYocWj+iGduLVQzawnY
         Bd78sI5+psvQjm3jSilslwd1O6vkJ7R+qDYksjRyhcZC7xQbiNxiYyU6vMhIaAktGYg7
         9EjktWCLeOov+70/Hftb/eoI9eshHpi1a/+6xmxJrj2vIxbmhndClulTsSywPbQvTJ4j
         KpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9Xe7G0mUprolJIwH6MJzsVRZJv7ADzG9ZALSt3qn7I=;
        b=bzT8fRemRi4vtWxo0It+A0psyzYu9PyeaQXj6574Hd9GnzbBSH3eaRso6rqK4F+RMf
         OucQDZ5dGL5V/lKFpUE8TVKsvfrYsFda2cmczu7cGsGHatvjUW9iyyCYMt7egs4ZL4Sz
         fEgpnDqQC46cBpi2fBntgWavAKX81d224WiSML0cszURjy4VjJ4BlNDkIKOaXuvltvS/
         wXJ2ayh9qavwL7qZPVMXI+zo90MLJtEqG2gaADsceN8V/LErOhs0YiC7qynszHOcele5
         UCQrGu4jvY48oQ3fQ0bAcoW+YW+yDKAWbszluIJv3ygqaEYoivbk5qywsTZoV7he4D9B
         pNhQ==
X-Gm-Message-State: AO0yUKUiYkPpv7FHJm76mpdixZPeVUSvGCMvUh9cw6Hie+JxHMfmnIM3
        SqTRMFad6O/ITmxgBb2MtjGRwJyo15KJOQ==
X-Google-Smtp-Source: AK7set9sqKEiYZykBR5KsaGrFDgczaih/so64Py9emYlckhNQJ57WA1xmCZS8OAdFvUMLn7DhqaBpA==
X-Received: by 2002:a05:6a21:328a:b0:cd:5334:e240 with SMTP id yt10-20020a056a21328a00b000cd5334e240mr46959597pzb.5.1678878439968;
        Wed, 15 Mar 2023 04:07:19 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005892ea4f092sm3337489pff.95.2023.03.15.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:19 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/4] dt-bindings: gpio: Add Loongson-1 GPIO
Date:   Wed, 15 Mar 2023 19:06:50 +0800
Message-Id: <20230315110650.142577-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315110650.142577-1-keguang.zhang@gmail.com>
References: <20230315110650.142577-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 GPIO.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V2 -> V3: Add Reviewed-by tag from Krzysztof Kozlowski
V1 -> V2: Use the same consistent quotes
          Delete superfluous examples
---
 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
new file mode 100644
index 000000000000..1a472c05697c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/loongson,ls1x-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 GPIO controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+properties:
+  compatible:
+    const: loongson,ls1x-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  ngpios:
+    minimum: 1
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - ngpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio@1fd010c0 {
+        compatible = "loongson,ls1x-gpio";
+        reg = <0x1fd010c0 0x4>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        ngpios = <32>;
+    };
+
+...
-- 
2.34.1

