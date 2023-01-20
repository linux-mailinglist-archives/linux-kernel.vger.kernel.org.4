Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DABD674EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjATH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:56:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF37442D8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5230253wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyHITZMuEPdmPoqCN4AhJLyjE6UKeJAy3IGmzplgigM=;
        b=lMTi6LoYMqN5uBJMYG4Aq5YyF3V5s+cXmVk5V8Vfs2AMpnM5xgqgG6wbACtRMc0U/1
         yroAFwFQAt21yE1jWphMCr0pfuGxrWmjrgHsvqRmOs/HlG75qaJ1CqYjXpJtKcenSGVH
         5dTQVUAzb01m1O4XtUYzjQsBibOiM4Hw2W2+h5olpvLTUZ/55EP9Qs2Wt5xSUtCQTLbR
         yyS5p9rDUyWXjTM2qwlm1nQOqZ5bZ2SfGx/j4E+RdiB7t3QT50/WFHRr6D4C9T7bAh7U
         GlJqKHhw+uv+otz/TMzPTqKqw9+DyPXMSjFzUwpY05f4AFrvulQ+t/XuPPXZ6XERA0Io
         Ay7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyHITZMuEPdmPoqCN4AhJLyjE6UKeJAy3IGmzplgigM=;
        b=tlHXdllDSAyoZiZ3YX9GkHpO3RY2mIeN29KY81Ua+VUTK3C1OkEtyTgokQ/Wt4xZX0
         DvZ29q6+bxnfg3jrAkoF3edFicTi7hBaCrM7Nxr/HzY3ncwuNob176ixAY7bTwhyIHH3
         P9rGMGG2rGLPxBK+EMVh048otOJvnLFiBgBo0kHFdCMShKeb+lV5j6fihcSt95G2/b7y
         Vk1xdYIJ7i+1QVaE6coGnn0TyyDRP4kq2W3yWF9+G8tnIFFzZ4a5oSVRT7+TGGPJjydL
         CsixD03F1+L/Bk4HW2OsOplsLc2xR7PRoxR3IY8KtrZsaiu8wIfeGPtqEEhXYy4PuxNa
         prhg==
X-Gm-Message-State: AFqh2kpkqU1whXM+Jilm6o+UUxX7R9VeHr+EckkYfbmQrTq7UwX0Ty1D
        CPLvcSSc2vkPUJdhGKNnfA+y5bNRQ/vOBxIK
X-Google-Smtp-Source: AMrXdXtSbV7lOd6Qgv1Bhrf9NWoxCd2EcR06BoREz+wznIpecUatJWh70gG1siNdzKsa3wzsezTDgg==
X-Received: by 2002:a05:600c:5116:b0:3db:1a8:c041 with SMTP id o22-20020a05600c511600b003db01a8c041mr13160767wms.17.1674201385390;
        Thu, 19 Jan 2023 23:56:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adfa345000000b002be546f947asm975622wrb.61.2023.01.19.23.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:56:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] dt-bindings: trivial-devices: document SPI dev compatibles
Date:   Fri, 20 Jan 2023 08:56:18 +0100
Message-Id: <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
References: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
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

Document existing SPI dev compatibles.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index b13f280f36fa..6d1dc1e2484a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -65,6 +65,8 @@ properties:
           - capella,cm3232
             # CM3323: Ambient Light Sensor
           - capella,cm3323
+            # Cisco SPI Petra
+          - cisco,spi-petra
             # High-Precision Digital Thermometer
           - dallas,ds1631
             # Total-Elapsed-Time Recorder with Alarm
@@ -169,6 +171,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Linear Technology LTC2488
+          - lineartechnology,ltc2488
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
             # 10 kOhm digital potentiometer with I2C interface
@@ -227,6 +231,8 @@ properties:
           - memsic,mxc6655
             # Menlo on-board CPLD trivial SPI device
           - menlo,m53cpld
+            # Micron SPI NOR Authenta
+          - micron,spi-authenta
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
@@ -305,10 +311,14 @@ properties:
           - pulsedlight,lidar-lite-v2
             # Renesas ISL29501 time-of-flight sensor
           - renesas,isl29501
+            # Rohm DH2228FV
+          - rohm,dh2228fv
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
             # Samsung Exynos SoC SATA PHY I2C device
           - samsung,exynos-sataphy-i2c
+            # Semtech sx1301 baseband processor
+          - semtech,sx1301
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion multi-pixel gas sensor with I2C interface
-- 
2.34.1

