Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F01712841
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbjEZObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbjEZObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47A9187;
        Fri, 26 May 2023 07:31:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso1500433a12.2;
        Fri, 26 May 2023 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111460; x=1687703460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+yqAgEVRVUUB3f5eL90/ZY0oOly65J84Yw/HEeUjmc=;
        b=ooPFcAWnZ/mUrcrLFs7lwlZcCRAPr2FI1Z6G8d1M4rM7loUiF6CMNiBWVDVIwEm4Du
         HD0zjKT+FlNa/Xs3HeJZ8waZG86qaN9tZ3AWoS0ZUwpAvxhFsYWDITZryo82fDGRapZ5
         q17shjmAIpbwRke2BnKvrIDiG1um4diFP7peLuRpCzQsFpouSVI3zbqXnsTlwX+AxqzU
         3c6zACTfPdNd9EgTuoEODjVbPfgzDd0KdTaOVK3zo6RkguSKWgy8/iHTGAxkqs5k2ux5
         Jm+na/w5Ch8q79daBTckpZt956+sARmw/FlcqdxVPJinE9H61+zfeShGB6qV3Rx2gXZU
         PI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111460; x=1687703460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+yqAgEVRVUUB3f5eL90/ZY0oOly65J84Yw/HEeUjmc=;
        b=BriSc7sqz+bSn3lr4X/JvIfxFVftJD4bvQUNwvJCYadcqkRvcGCqlj4q0/1B+BTx/j
         Ym9MsjhkxVt3jFxQHsjrFlDzA0AjrIVTqgTCWOdPfAFWoCalrvkv1fSMBylcXtMUYfke
         S8CJvFCxOlJZRo2LptSqHtjRIDQKWIhK2XPAMLWwvq7EnlDwYy+86VJ6P9QydKVB75OY
         z+K7xaz+5hbmIaTPh5VfB8XcBy6ct+5shVtkkiPLMXicLARY5F0takRLrU5y38ZJt1Dd
         1XXdYHxDiq7pG4QnCap64QS6uZl2FB6qFA8b6AunvXFwt+VuF11//UYyGHfLiqtU/CS6
         Y6Vw==
X-Gm-Message-State: AC+VfDx/C1xkvTS+dmFkyR61+3gCBjWbtic00E17BsAcBE1phEkKjLns
        7wfCfeLywOt6HkP5Vs2nBaY=
X-Google-Smtp-Source: ACHHUZ4MwOsLgckWhVgLA8e3ChKua4/C2BOQtBrq0UmdCaX3yMJuNarzXqAbEUPvQcF70VmDoThMLQ==
X-Received: by 2002:a17:907:9306:b0:96f:aed9:2535 with SMTP id bu6-20020a170907930600b0096faed92535mr2120955ejc.9.1685111460160;
        Fri, 26 May 2023 07:31:00 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:30:59 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Fri, 26 May 2023 16:30:42 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v4:
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

