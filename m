Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1EA5F4289
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJDL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJDL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B5240BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k19so1481226lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sAksLRSTBpIX5Idm9PSytUBYqco/yvgpYmCooGsVRBk=;
        b=CLxvrhc4qOsB4L8p7ekMsM+MubH5VYK9f9SDJRH5QF5gLdGWNLjj+sADlcwhbfAAPL
         s0ZcMoyT4zWzD+s4ef+1RcIAshRCJo9CYob4E222PAu+pDNWm+MFcDSTjLIIWWIoxxbs
         HwYFkPMa0FGJtuhDz8ch1X4juuuTkqoxGj59VVuX9r6JStu/W65Billb6p2n9EuvbHaU
         SiRlXlELB5m4HdkZU29WS9R0EXwQLpXr8/eKdYovMwXD+eD6kadgWnPnCN8gOFNAAB0G
         HyV1Rnztd2DA30TbTtIjP3k4gFl0w+yePnu9yZy65ZUAaz2Ixs8yM15xnDomzdOE9QkT
         NADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sAksLRSTBpIX5Idm9PSytUBYqco/yvgpYmCooGsVRBk=;
        b=XvBrjYtg3wwPHNaz6lPWgmpJRa4FXGMgE7Ch7/Ul00lzp80yBlc2Av3cLkCSpcW6WV
         dlWH8Wxp4Z1RpUGuF3pQXTNUjRgvwL734RrJ+vCgfqWh/ae4WdobzAMo9QAAoWaDveZ/
         2MOdT7sIQlmsgr1jjO/MvjTTkbwT0T02/N1ARXl1+gR+f7TBtxjTpdBqdTptJG6BG8QD
         nkxL1K7hfN9NLbRJtE94PVcKFLcYr/dCXoCno4IUSccxZ2TI1R4pEchQBMA7lBuy7Z7N
         s9yUZdbweJo/5aveVlCzwOTwVQ7lHE66H0llWmdDyjAnfK0L47UU6GIMOtawV/+c8/wZ
         ylxw==
X-Gm-Message-State: ACrzQf0jXBeFO/4UQ+aH84pLYUrurt4X6tKcWFY0LdR+rKIFgIuB29kY
        xAzcHOWix9JCWraX7y6gwojQbQ==
X-Google-Smtp-Source: AMsMyM4BT9AZ/MQjlPeoZdVC4GyxjWlEVvasTULnuQzJpO/CY5vTc1I6fl7KtOvzdN7rbJBTA8Zsbw==
X-Received: by 2002:a2e:a791:0:b0:26c:4fad:957 with SMTP id c17-20020a2ea791000000b0026c4fad0957mr7772516ljf.263.1664884613519;
        Tue, 04 Oct 2022 04:56:53 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:53 -0700 (PDT)
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
Subject: [PATCH 8/8] dt-bindings: iio: resolver: adi,ad2s90: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:42 +0200
Message-Id: <20221004115642.63749-8-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/resolver/adi,ad2s90.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
index 81e4bdfc17c4..b24e5a202a48 100644
--- a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
+++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.yaml
@@ -33,8 +33,6 @@ properties:
 
   spi-cpha: true
 
-additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -43,6 +41,11 @@ dependencies:
   spi-cpol: [ spi-cpha ]
   spi-cpha: [ spi-cpol ]
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
-- 
2.34.1

