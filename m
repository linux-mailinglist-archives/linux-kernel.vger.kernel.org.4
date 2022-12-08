Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34A646CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLHKd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLHKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:33:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C467DA6C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:31:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so1336024lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5ptnyM8tU9KK9vuHrqJhLp9kBHzmtP8NOjNL98W6O0=;
        b=Zqdk9FLKb1U+056szYPwGwZZOCtduYqr9pYvnZ70agJ8neRKwJbE/0KXoVf9PGud/3
         WUUDU/fEZhoXXFg7hf9+IhzSsBiP64yONaa7u5T8aNsgIJdYGPQuba+HXXhMaeC6D5H1
         Rzilnv2cjG1wKqajm+kC9DBF9p2SAL4WDD6JNKqCfElln9GeZVsjaVwzyTVyYJgeipEM
         Csnc1Cy9CHiwtzHyu5sOypvruVbwF4Dckt6L8lOKrui5Ts4xiBE0rlgNDnP/yJ71x/Ep
         QUzxoCtns51f5ylw3SjAEvbdbMCGK16oDkOSKEiYp88amzXcDBhw+o3cDnWsXTLx/n5r
         A1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5ptnyM8tU9KK9vuHrqJhLp9kBHzmtP8NOjNL98W6O0=;
        b=g8Lit3R4B2Jp+AWcb8QlucFGT0Ao/XFHcDkYvSEkgqnODvSSzlLkG0PGZAG0h3Y+nF
         nC84xGV/NYg2pEKXELxww7h98G+O7Qm2Afz5unCOgOVPQ49pCBc6UpFXImk6LG6rX1I9
         eKhg856HXTjG8jOm+mZ6r3CJBEiwiSVJ4rcMhq8KPDSMtYpOp9/JEba8bNMfBs0EJc3A
         il2ZDmVz3Qvy39ageWJuu5e5soFG6YyDL3GBDBhVKPT32vS966MLUM6ZCMhA4Zn198dp
         HK95IyqZjm4CP1ti/D+0yByAsvXMz4cq9/+pfk4TYSO3D2Tl4NlA76xYjz7tQSstq9Ec
         7NYg==
X-Gm-Message-State: ANoB5pkBAmOh5WMr0nqMVLRoMH/IG7UWVQmHVSWJhFBQgUFvt/vT755v
        Yk0LmBivXO4IKKoCrmUQ/Hpgzw==
X-Google-Smtp-Source: AA0mqf5tpHiPpZHCEhpkHs1cV3jMDIzMzb1k+nZXnOkFjY2FhmuCd2fWYcDhxvNhmKNesC4O0TZ6CA==
X-Received: by 2002:ac2:4acc:0:b0:4b4:10ca:5240 with SMTP id m12-20020ac24acc000000b004b410ca5240mr34308930lfp.482.1670495495875;
        Thu, 08 Dec 2022 02:31:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a2eb0f2000000b00279e5247dabsm1699580ljl.18.2022.12.08.02.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:31:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 5/9] media: dt-bindings: chrontel,ch7322: reference common CEC properties
Date:   Thu,  8 Dec 2022 11:31:11 +0100
Message-Id: <20221208103115.25512-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference common HDMI CEC adapter properties to simplify the binding and
have only one place of definition for common properties.  The common CEC
binding expects also node name to be 'cec'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Fix node name to cec.
---
 .../bindings/media/i2c/chrontel,ch7322.yaml           | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml b/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
index 63e5b89d2e0b..af8ada55b3f2 100644
--- a/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
@@ -13,6 +13,9 @@ description:
   The Chrontel CH7322 is a discrete HDMI-CEC controller. It is
   programmable through I2C and drives a single CEC line.
 
+allOf:
+  - $ref: /schemas/media/cec/cec-common.yaml#
+
 properties:
   compatible:
     const: chrontel,ch7322
@@ -40,16 +43,12 @@ properties:
       if in auto mode.
     maxItems: 1
 
-  # see ../cec.txt
-  hdmi-phandle:
-    description: phandle to the HDMI controller
-
 required:
   - compatible
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -58,7 +57,7 @@ examples:
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      ch7322@75 {
+      cec@75 {
         compatible = "chrontel,ch7322";
         reg = <0x75>;
         interrupts = <47 IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

