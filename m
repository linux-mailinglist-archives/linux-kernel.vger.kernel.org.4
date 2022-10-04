Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34C5F4288
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJDL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJDL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA629819
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so15017207ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=djq8t4QxKMBmEOxi2elhjqtO/Is16cDEASRN118TFbY=;
        b=QZMQW7IlxaliINrGlEAbcfMBnTtgPZxr6S5vZirizUlbA/BzTU6Dmez3Ovw+Qaotb4
         Z2MFtiLqWqrZkee0lsKoct2YOhLKh4MtygYrx3cBbSqja+EUN0j3wSuBrCPJoTbxD076
         g8Z8sKTIdgZDZlAPC5/6C0ogZvnj4XM7t4PeeN4xE7fAwZ50lmJ/vZiIU9O2UDQHUBjc
         QX0K908aPVDTQFpKYaT1Hkh3el8f7GwAJZ8Pd+qWTEskPdcEbyFrwfOth7FWb9lyOSpA
         yfUkYczgJak0m65FP8WGd7KmfnAKGKjcTh3CD86EydB/KzWV7C/nbexbwVmSL4fb18Sm
         vT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=djq8t4QxKMBmEOxi2elhjqtO/Is16cDEASRN118TFbY=;
        b=LPdUHNfuxsFJ0wn62WJH+Plxfsr7WjDGmDxrqXg023lfbcjBNsKSZt7tATlJ8eqTTN
         mWrFE8yJje5B6+CcOe+WGXtA27gs/e17lJPVpO9XTt3nv1AGhPn2R4PuO0QaDJUPddDt
         z1Z+Mt0mWYCv6es3zGa4nQ6rOsOX0BeUGpniY2Dx+HJZ4IhDbkC+6mhy4uEijk1lnZ9d
         D6h7lQVcPJHitWKSFmKnFbUatGNu0rQeXc9lEjbMxmyUoDBsifrrT8i8uc4l+SfsMfrG
         Afj0sP+l3XvQ4LSbZje1vh56Z1B/+cTvH6xkS9G9yDW7rol9+n7rsxAnU5jWM0F4efVj
         c1lQ==
X-Gm-Message-State: ACrzQf0KvUSY8I8M4yS43VZVd6xKRqdb/mc4VC9a3X9g9xeVCDdKXd89
        0KxBE5fnK8/yd96/psRNJm1wLw==
X-Google-Smtp-Source: AMsMyM4uExW7RGtfOlS/wpmkIJvTsmbYHmXwXvWdC/EpmN8O7KdZ9SUCcl16A4711lrNKfj4TffMJQ==
X-Received: by 2002:a2e:bd0e:0:b0:268:c03b:cf56 with SMTP id n14-20020a2ebd0e000000b00268c03bcf56mr8311295ljq.393.1664884611220;
        Tue, 04 Oct 2022 04:56:51 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:50 -0700 (PDT)
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
Subject: [PATCH 6/8] dt-bindings: iio: pressure: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:40 +0200
Message-Id: <20221004115642.63749-6-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/pressure/meas,ms5611.yaml        | 5 ++++-
 .../devicetree/bindings/iio/pressure/murata,zpa2326.yaml     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
index 4f06707450bf..7fed750fa3ff 100644
--- a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
@@ -30,7 +30,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml b/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
index d6103be03460..c33640ddde58 100644
--- a/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
@@ -33,7 +33,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

