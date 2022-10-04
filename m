Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F495F4287
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJDL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJDL4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23D2B24E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn8so1595824ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DsQgmXA7UbLknyyT7b+mvq0JGpkzpgAolizOzOWF2Fw=;
        b=GtTSsAkttFYOl9LXE6InT2E4mV9ojxT2XV57bS6cuLHHZNX/Zu0OSsHnN3MUghbWVX
         Um3Cs3HY1xoBdqyRKv6eaGGBGo2k/kf3E2fHz0xIS22wayVYRzF6kjatxGDFoMFRiGSl
         mD7MsRi9hHoxsxCYv4fI6BxXS/wy6UX9MIGX0XbAhWz1lHmq++nMoxzuXK2y0jVr4ni8
         UBEquRcNtXWQ46xXiaCXT2aN/NgZ584ZSI6viiGBcXZr8vOSVB3xK501A8oneUSAg7f8
         ly+t0SiYOVRuKCeM+FX6lDpZkm2UVBTRikmhUftQj22RGOJTBOGw2bSgOt0kZmFA3iN9
         aOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DsQgmXA7UbLknyyT7b+mvq0JGpkzpgAolizOzOWF2Fw=;
        b=7lQXz9xyvpPWxANcTDgqqYImLwUxc+6gAj2t3bOz2GAxCEbwOwlpX3NW6JjquBpdzS
         hCw2JnLI9OiL1DcMYEdLxHBvmXx+4udP3jh8EiawQ/VIaE+NiKgCUUreU3FwUI96GpYg
         KACgC7LnjH935X5iz+R6h/ylQSWJeRo570msUzf1FQjb/1x3MYTKp6cyw/fkHLug20Bd
         GmTNdCeeStOrV1E05irTeqsOB+JFwgkqornDGRyThSCEw3d6pQEtRU0qo2x0a6gBUOVU
         Bhzr45r+GUvLLQze4ZLhl3YyqE87SW/CqM0whoZ2ITLiltObykScTfjDDWSA0norsDap
         VLdw==
X-Gm-Message-State: ACrzQf3LvqXwlvLMtN7HUpnT1TC/yIvD1F9/k7P4fPqbKsP8MYCG8gWl
        foFtVE7nGKBN+px7AZ2Yk2xVtQ==
X-Google-Smtp-Source: AMsMyM7lE9ny5lPGYQDKgn0ZIaftf7U2RTdy+XrMhKPHLkLBTBxzJBi1Y+8QBxslEHmMFpLDRx6pzA==
X-Received: by 2002:a2e:84ca:0:b0:25d:77e0:2566 with SMTP id q10-20020a2e84ca000000b0025d77e02566mr8543337ljh.78.1664884610081;
        Tue, 04 Oct 2022 04:56:50 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:49 -0700 (PDT)
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
Subject: [PATCH 5/8] dt-bindings: iio: imu: adi,adis16475: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:39 +0200
Message-Id: <20221004115642.63749-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
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

For devices connectable by SPI bus (e.g. already using
"spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
schema to allow using all SPI device properties, even these which device
bindings author did not tried yet.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
index a7574210175a..5dbfae80bb28 100644
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -79,6 +79,7 @@ required:
   - spi-cpol
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -107,7 +108,7 @@ allOf:
       dependencies:
         adi,sync-mode: [ clocks ]
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

