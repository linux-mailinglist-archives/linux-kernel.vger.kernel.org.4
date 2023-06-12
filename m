Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622D972C840
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjFLOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjFLOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F1295E;
        Mon, 12 Jun 2023 07:22:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9745c5fed21so650625966b.3;
        Mon, 12 Jun 2023 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579747; x=1689171747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqXKgMUVfhFQ3jrryQo34Vgw2KkPViTowe9k/ofYPGE=;
        b=TL3IDQ3i9aXTJ9klybo1JPWK51KfKulbEjxSJTkoRzO04WOulf3pbPFqu7o5VQ5Akw
         0ipjr04OkS0aqkeA9iWQbt0Ai5UTgUsyV4DuHFUm+w8hi6KyQma10HbSz4n7MeHm3qse
         mj0sgk+uuXYJDgP/j7kyimJeFYq8YoE/kSYly7PKHBIVPReWODbrDLwAwSQK5+hEo5NN
         3ihSNTNY6Qk8HjeqUsSJovBmUOUsjfQTzOqS3dsWly5kL/rXKcdURXHD/D4q29F3XXxm
         3fq0VejwqJhn5mexsl9x5CU1+VTUeCYFfv+LkPYbv9wouDmHiARw7OERJs4rpwlbabAI
         uvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579747; x=1689171747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqXKgMUVfhFQ3jrryQo34Vgw2KkPViTowe9k/ofYPGE=;
        b=eUghvX6sq9qG40y3YvZ2EWrekjirCI54WhVJIvDx7S7Ctavj3tabthzXRPNI8LLOhe
         AVbbqHXzCGLCvucVI7yfWz9AYXGD9hrvcUQZOgsrRiIfdn9giNNEj1Bl+Q7rIhB4a3Fj
         8KDBSciNRzmIJIJr5bkwPnu1auZjAlEE0NJ0XALm52t3KU4gbKnVwVFuHmA8G7OYJrwl
         xWNRL1cMPmM1HV5OBEwIgkvLGLhTR92wHgwDote+u8JsSgU3fTiK2fmy56HZnL5GdN3D
         fEpnEIEx2WFffLPK/10YOqY5VpCIPCIn8o2ea6j8Nz6gRUyMoyXKkRhG5pX2KoEaN4W/
         7buw==
X-Gm-Message-State: AC+VfDyiDoRFzPTedasjufgFIC2mHCz0mkef58hTjqrPwTdk3jZkNGer
        UW7Wdjmytj4xkAkaIxzuLsA=
X-Google-Smtp-Source: ACHHUZ4hiobWyXLXvS2vAOtQZkUrzz3O5rI/0t8INMyyv89C9uPikXJuxdMwyfbKOYaro6fjZGmkmw==
X-Received: by 2002:a17:906:99c4:b0:977:4b64:f5e8 with SMTP id s4-20020a17090699c400b009774b64f5e8mr10094238ejn.57.1686579747022;
        Mon, 12 Jun 2023 07:22:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:26 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Mon, 12 Jun 2023 16:22:04 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686578554.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686578553.git.mehdi.djait.k@gmail.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
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
v5:
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

