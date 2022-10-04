Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504745F4286
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJDL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJDL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C81CFCE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so15017054ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CkVLRt6oEZ54xF22urRfcES2f955CNvMgQuZB8MJX3M=;
        b=V+255m3zUgj9duoQq2iOXmX8d2fQw1ChL2ZkjolZ8LH3y5rX+qWCadCkwZ4hnu8fjG
         AqjF9WEMbWB3JWhnON4XbCkoazXaarunre1JRGUyG+uEAp1ogfHJnxy/IZjXDxeBANce
         pj7GTUmBlXSrV8WOCmBBCBLvDZrbIdwZ1Crgk0p7qduNecgHwCoTtxw7HJeuXVanbq6m
         IeeKJUx7JuxgF8CwMh8uU2Wy5XiyOTy0P+Yrma1az3Dirz/qGT4lMMMpS7KAkqm3XJXv
         Q1dLS6VNiF/yxLwP4MmjUi4IwwFm+LixjXHA7W9ZFgJpdcfnuZcVHnW1cQ/RltiUFNtv
         nFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CkVLRt6oEZ54xF22urRfcES2f955CNvMgQuZB8MJX3M=;
        b=uGqdQ1nqAbNNFN8f1M0iJcyj7X9Oqq17VAoFnUcnMTpj4AsJttntIq55cWMI9mqbC9
         M/esm21YFNL2FI4du2jty4sh9u1Yw5oQZk/Me7wYCFPuRvS1rR7v0Yc3GpkNNjVzPwoO
         Td0kZXsRF9tZTzasaHMYAFlXHCPxjGjPXI3TjF4otzbhrRM/tsHo7Rt8Cdt1JbGYJmP0
         ULz3KZRDEvsvWleF2gDFke9kV3ddz9E1eusVIL1+HYpWvAAC7Gqvxm0f7rRG8FeQ7kGx
         AVrI0HFJN6z1NnGTHzfuVllej21/QEYNMZ3vE775/nf/NjZO10cOqTFYNI0YNh1txQgn
         qVbQ==
X-Gm-Message-State: ACrzQf2dakVLzd3ZSPgxtS2fNjTKOD1TL4FM3JX5PYfZpVTcO09YQR4j
        Y7JZy9tbfVe2pbYsqAN0SgWpvw==
X-Google-Smtp-Source: AMsMyM52Uz3CLl59/iIWiiBHl8yzdccky+00QtKyUWTIWybkGAQ+P+yYRGj65BG22CuT2293jgfy4Q==
X-Received: by 2002:a05:651c:b13:b0:26c:679f:ea66 with SMTP id b19-20020a05651c0b1300b0026c679fea66mr8610289ljr.516.1664884607920;
        Tue, 04 Oct 2022 04:56:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/8] dt-bindings: iio: frequency: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:37 +0200
Message-Id: <20221004115642.63749-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices connectable by SPI bus (e.g. already using
"spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
schema to allow using all SPI device properties, even these which device
bindings author did not tried yet.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/frequency/adi,adf4350.yaml     | 7 +++++--
 .../devicetree/bindings/iio/frequency/adi,admv1013.yaml    | 5 ++++-
 .../devicetree/bindings/iio/frequency/adi,admv1014.yaml    | 5 ++++-
 .../devicetree/bindings/iio/frequency/adi,admv4420.yaml    | 6 +++++-
 .../devicetree/bindings/iio/frequency/adi,adrf6780.yaml    | 5 ++++-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
index d7f20b8518e0..43cbf27114c7 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
@@ -160,13 +160,16 @@ properties:
       2: +2dBm
       3: +5dBm
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
   - clocks
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
index 23f1f3b55abb..fc813bcb6532 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -70,7 +70,10 @@ required:
   - clock-names
   - vcm-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
index 2716c1e8fe31..ab86daa2c56e 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
@@ -104,7 +104,10 @@ required:
   - clock-names
   - vcm-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
index da7fe85ec92e..d4b92481af81 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
@@ -37,7 +37,11 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
index 3a8ea93f4e0c..f11391ab4b62 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -113,7 +113,10 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

