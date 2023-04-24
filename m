Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EACE6ED7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjDXWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjDXWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C80B61A5;
        Mon, 24 Apr 2023 15:22:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-95678d891d6so866781966b.1;
        Mon, 24 Apr 2023 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374957; x=1684966957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y52cCu1JdcwBFHQH5XmTxCTahyeTrmpWcgn3Dw6mTaY=;
        b=kOInZ2UvpTtO/2kmnodRfTzlU4WccSEi34uOI4mOFi3lwLs8/JuFwUgXEXYhQ+j7Mm
         P9sfsZq4C05sb4mOgoz2+arTpZpSs2kIBrDFiD2g9RDBwoCbB7RvpESELpx/pRadq4Lb
         vFd1BXhOWroZdMpeQPt21IUG93B8Qrv6/JN/m6uX57Ook+sR6YZHLTq3QAP19KxjhvIS
         hwamXP2387ih/Uq3TIBsiN+R45dwSVwRBxwP//LW1P0rMxnoKWlx2dhVpZkTubog01Ef
         UiCTV/3Nb97kgeyc1DzVfG8vJIey7GeCfbVtNW45HgCuoHM6E9iym/zC2y/cc2DF9kus
         fmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374957; x=1684966957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y52cCu1JdcwBFHQH5XmTxCTahyeTrmpWcgn3Dw6mTaY=;
        b=hHpEdxQGg7dL9R9RpLlwU8zo8JHkArR3QIIpQIEcOPNpjlbDLey+Ll243dt1NnCXy4
         5fLpQQG0ODO5EMUtdLw0qRHO+MgRmUdzlLYbq/FgVjzvwW7FZCj0Ip757uPEO1CfZKoy
         Mnbq9mP5vZIJHiChHfLbOO5ZeILQ9bJBpMQb0HBzPAvtkKx1qzsrURdOrpzR9NJKxN++
         kokvm4rPSiXUI/PXdxDpNBAPUvRqwL6orq0UNUTMvDmNYNBLw9bpd4cxursSghMPv1Zm
         6zuWwGK6weyFvmWsTQ8e89IWmSkUhyjAWb/uJVbQNqBfKGVfmx4hohvlYH9L5VJYOFsU
         mZcw==
X-Gm-Message-State: AAQBX9cY8/myuMvlQGmBBFu2nwHLRAGjNDfYT0uHbedBG4KQsjvzLnIw
        HtV+ElJNxv7t4BoYZJZQaxs=
X-Google-Smtp-Source: AKy350ZYzHE4cCuQ2OoEWKyom8YJqVR9raugB6BA4+p/HriXkdc+5Co8ISeqdBlH1kexRonye/wjQw==
X-Received: by 2002:a17:907:1c23:b0:862:c1d5:ea1b with SMTP id nc35-20020a1709071c2300b00862c1d5ea1bmr14507953ejc.8.1682374956610;
        Mon, 24 Apr 2023 15:22:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:36 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Tue, 25 Apr 2023 00:22:21 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
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

Extend the kionix,kx022a.yaml file to support the kx132-1211 device

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v3:
- no changes 

v2:
- made the device name more specific from "kx132" to "kx132-1211"
- removed the output data-rates mentioned and replaced them with "variable 
output data-rates"

 .../devicetree/bindings/iio/accel/kionix,kx022a.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
index 986df1a6ff0a..034b69614416 100644
--- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ROHM/Kionix KX022A Accelerometer
+title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
 
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
 
 description: |
-  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
-  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
-  KX022A can be accessed either via I2C or SPI.
+  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
+  16G ranges, variable output data-rates and a hardware-fifo buffering.
+  KX022A and KX132-1211 can be accessed either via I2C or SPI.
 
 properties:
   compatible:
-    const: kionix,kx022a
+    enum:
+      - kionix,kx022a
+      - kionix,kx132-1211
 
   reg:
     maxItems: 1
-- 
2.30.2

