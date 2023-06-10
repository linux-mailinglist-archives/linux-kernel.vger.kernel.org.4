Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62A72AED2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjFJUnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjFJUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:42:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299F3A85;
        Sat, 10 Jun 2023 13:42:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso21279145e9.1;
        Sat, 10 Jun 2023 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686429768; x=1689021768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hJFlrCte5GBR7MpsYIzaf+ErbhQyTaUpl+j1hGve08=;
        b=hAGLVXUPDF5zyNI17sP6N86ZIevxQyBN2PRxHG+BXQcTj+CJCRxJmBXJWVIbW/RGox
         6odcZPSmqTpaMgwsFcFJA9RpPKihrTA5F7KLJH5TuI4s0QlMpeRaqtUggy/0Zk43ofWH
         4gFihZMNwpaJyZmr+Kbb4Om4g0+yWemPhiw63/x1JMLepoFwqvccLGfhm+/cYoEXbf5X
         c4iSVQkbjRkUk1QWP4RbME58NEhBcUK80MKaq+W73JlPlGdTox3d6CIE/m/HXZdetro4
         UkwHDWB1djzvqd60Xekl0NenCKkppmD3ifKoAzCdGL0MoYqEHcPopwuW3AOcNAtV85Dr
         VMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686429768; x=1689021768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hJFlrCte5GBR7MpsYIzaf+ErbhQyTaUpl+j1hGve08=;
        b=buaa/PCF5Z3nYJD/TsAVOGbh2s5aLLGUcdzRICBZgrQWlb+t9W2lZHFOKk+/rh7Ohr
         4Maw8h9iIa/5crQWV1B/EWEiMZiaps6Gx8QwqqPqHKFdpzlLmLO1DTThWv1haU/XGy4z
         wqLcjzX6ISKyBmZRytaZmisjlk2Ki/4I5P/XzjYNjT/ZaELOWqwfLlTy09lqeUBiExs8
         dGXw6jBDfcDUB/GMC2VvTv4NmWoX9q79n7u+piQTarEIo6wOpWytYE3hCCx2TVZX5A7e
         1GQQbs+NboCpi8p7nhywJz3xkQTczPk1nlqCIMUhbBQDWuWxOYQVDIuRM/4oCVQTHlYs
         xx1g==
X-Gm-Message-State: AC+VfDztViOzOrqZO9JKvh2MBU+qlNTpc1GQ2/DnYcRxau9X+fsIwRSo
        N0SnbxRPOr4Z0QyYdTWoQmwIMu+sFi47tO2C
X-Google-Smtp-Source: ACHHUZ7VpOD/P9K1c9pzM/fet25ba5bKHkDD2WlG/ssQv8LH2i8o061I1aGWlrW6vmqAo8m/dVIn3g==
X-Received: by 2002:a05:600c:211:b0:3f7:ed1e:5a21 with SMTP id 17-20020a05600c021100b003f7ed1e5a21mr3426704wmi.38.1686429767895;
        Sat, 10 Jun 2023 13:42:47 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f605566610sm6547733wma.13.2023.06.10.13.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:42:47 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
Date:   Sat, 10 Jun 2023 23:42:18 +0300
Message-Id: <20230610204225.1133473-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610204225.1133473-1-bigunclemax@gmail.com>
References: <20230610204225.1133473-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

Add a binding for D1/T113s thermal sensor controller.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index fbd4212285e2..001faa37fc27 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -16,6 +16,7 @@ properties:
       - allwinner,sun8i-a83t-ths
       - allwinner,sun8i-h3-ths
       - allwinner,sun8i-r40-ths
+      - allwinner,sun20i-d1-ths
       - allwinner,sun50i-a64-ths
       - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
@@ -61,6 +62,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - allwinner,sun20i-d1-ths
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h6-ths
 
@@ -84,7 +86,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-h3-ths
+            enum:
+              - allwinner,sun8i-h3-ths
+              - allwinner,sun20i-d1-ths
 
     then:
       properties:
@@ -103,6 +107,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-ths
               - allwinner,sun8i-r40-ths
+              - allwinner,sun20i-d1-ths
               - allwinner,sun50i-a64-ths
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h5-ths
@@ -159,4 +164,17 @@ examples:
          #thermal-sensor-cells = <1>;
     };
 
+  - |
+    thermal-sensor@2009400 {
+          compatible = "allwinner,sun20i-d1-ths";
+          reg = <0x02009400 0x400>;
+          interrupts = <0 90 0>;
+          clocks = <&ccu 0>;
+          clock-names = "bus";
+          resets = <&ccu 2>;
+          nvmem-cells = <&ths_calibration>;
+          nvmem-cell-names = "calibration";
+          #thermal-sensor-cells = <0>;
+    };
+
 ...
-- 
2.39.2

