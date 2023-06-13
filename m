Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056F72DF48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbjFMKXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbjFMKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FCB172A;
        Tue, 13 Jun 2023 03:22:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5185f195f05so2078436a12.2;
        Tue, 13 Jun 2023 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651772; x=1689243772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FXuqC+S/sLlbvyTkIE7BNkk8lsvrfguA+UNlwNOHa8=;
        b=YLetkW2DLs3ov5xbEiUXhjqUcx28UjZ2gqhBIktz2H5tkL/EKEtOtpUaMTqbmYP0ge
         lxpOXzsbuOehxZXidNwExpm6UvopcKQtuLgZ47Dlb/RkNXKeRGSaglwYN7sDSr/y/lM2
         5Sm71grGt/FKiYv3oAG9Wp4qPfuj5UCykejhUJEGPbLza7UO9/8N+Aw38nxcsC5AkFm9
         TJ6zb+a9cy5xe8a/96KNUgDQKRXjMhi13aWRRZ6vnptPNMW0+yR6rz3Ai/yOmFn+05zr
         kbZ76okNf2bdtAhZ2Z3oOy54ukNxDSCiuqnblAArDTlJrrzgYdtpHyzTNk6VTneZhnnp
         fsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651772; x=1689243772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FXuqC+S/sLlbvyTkIE7BNkk8lsvrfguA+UNlwNOHa8=;
        b=Qwh3dahMGhJBWZt9pgYFp1QsQ4CgiPJjwIv1YpeC4OcoZK7JkJ0AUMG0SeMp4QdZdB
         eeoRAeLHHJonNlmctCHtMXZFjpQE/LbA/oOC/XwMlO/E9GkM9g2nSBXca6N8dWiI6W5S
         0jtwc2IwFSzyQQRpZuOd5rlJfCclUBThXgvVgHHpziG6+HcFm1E2MaYaGoBMx4VsHuI3
         vG9UOfIi0cjRbGI3O55yeyw/9bA61LV+kPE7tiC/Sa421c/aFUTmN7ZyHldpsKbibJ8f
         5ba3vAo0vtU1P2AB8DaoHFURz1YzWEZDKnumRU5TDidZZEBOs1a7oBb32rVlYWP4mYka
         lnTA==
X-Gm-Message-State: AC+VfDyQ5ZHNL4NHCRjQjlj3v0dD4xxiH+FGwmM/rVPANGaEVZ/PlkfU
        iSRbZW/p7YEXw73D6/exLC8=
X-Google-Smtp-Source: ACHHUZ6e6zh8rpAJK9lD/cMlmKuQ+Al/ZRZpjpAL8GcsLsg8U/cxo2fj8ZQwrxKZP3nZlgQWxf71lA==
X-Received: by 2002:a17:907:7da9:b0:973:8cb7:4d81 with SMTP id oz41-20020a1709077da900b009738cb74d81mr13092660ejc.49.1686651771747;
        Tue, 13 Jun 2023 03:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:22:51 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/7] dt-bindings: iio: Add KX132-1211 accelerometer
Date:   Tue, 13 Jun 2023 12:22:34 +0200
Message-Id: <0d6051ad217f91c7de0883c4ca1516bdacc343ce.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
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
v6:
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

