Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDC69F34B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjBVLMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjBVLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:12:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2C392B5;
        Wed, 22 Feb 2023 03:12:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so6024541pjb.4;
        Wed, 22 Feb 2023 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ9DYSbNtBd9DPjLU4U4sH7nNCDVV4pFgLMTLw3Ypkc=;
        b=mCP2sIrzT0l72A0togvSIYGMucC8MVq21zmCLnPzmT0A3CydfV9EU+ChGgxhF4AM4g
         WGJ+XJOcH4685GuPjhgv4ZyKxYicsKzKACf5vwstBKUxVouCkGqE/064BB/LlCkw58+g
         4pf8A5QhPnypsJqYbLTSb9NBPzvwF6x+xuDWeQxF5wFXdM3Nb1QeoNAQnDYdXiksQKlF
         roPfCPG3gid9SyCxxf3hbgeilVz/xCGCFKGqP9f1aWaNOURFTibs9uo5GxOR8VWmFcFv
         joqqbydp4PPAvLHWsspL1AQejxNOFMF/DkPsAqbzCDO9rqWYaxQQn6AnP11ivEO2o2j1
         PnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ9DYSbNtBd9DPjLU4U4sH7nNCDVV4pFgLMTLw3Ypkc=;
        b=DKLlJrAa8ZASyIzYcstoosY/51SqEA6+RaU4Jl5xWO86XGVTBxTDELkStuTJS8YIFB
         lmhZa5jvUTpS64398AA9HWG5bjDZ6SAR27xRo6Dv/jbsECKCqcgogrsYWgIIXm+mX29K
         OLb0y/Y9RqvUlZT26C5b2frh+CLd9+aO6SQHuAVri19xkxKyNb1XD0RRDS75Wp5oI8Yw
         n7UhRX0MOeIGZNhqHSxa/YCaDOlE2TZ821k1+hzWG6oINPlSyEngWjefc30Ov/TRl/O7
         Jw+bF4NG6OphFcI0E+j7kdMR5ckD2htN5IDWGGCI2AZsPfau9yo5sMnEVnGCIwdlmsBG
         leHQ==
X-Gm-Message-State: AO0yUKUHu6VHpf9dobniuepzhOCQU+qEVORvq477oFgnjD2iptve4WV0
        atGMpUwMh1Ne41J+bSchBb/XNWgw+7SR4A==
X-Google-Smtp-Source: AK7set8VK32EeAr175TT+eNn4od7p3eCIq1FJnE1yFuE/RAwOLqsg2DwJ4Cy5TGJTXMCYXVA7HhVlw==
X-Received: by 2002:a17:90a:1d5:b0:233:ab9b:f86a with SMTP id 21-20020a17090a01d500b00233ab9bf86amr7497976pjd.8.1677064361780;
        Wed, 22 Feb 2023 03:12:41 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm4763228pjf.28.2023.02.22.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:12:41 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 4/4] dt-bindings: gpio: Add Loongson-1 GPIO
Date:   Wed, 22 Feb 2023 19:12:13 +0800
Message-Id: <20230222111213.2241633-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222111213.2241633-1-keguang.zhang@gmail.com>
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for Loongson-1 GPIO.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
new file mode 100644
index 000000000000..e4ab49d48fae
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
@@ -0,0 +1,60 @@
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
+  - '#gpio-cells'
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
+  - |
+    gpio1: gpio@1fd010c4 {
+        compatible = "loongson,ls1x-gpio";
+        reg = <0x1fd010c4 0x4>;
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

