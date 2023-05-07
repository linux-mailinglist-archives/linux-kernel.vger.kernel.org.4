Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A070B6F9AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEGRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjEGRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:39:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FE1161E
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 10:39:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965a68abfd4so700597366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683481168; x=1686073168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmm5K3twSnfjvRXl95GP6fEhhk0gKbIZpn9atiJ/Snw=;
        b=CwPBinCLIofyk3epCVgKgKfO53ghgPMzBdbJwR5ZB+86/yKvQlEZmGPlX3CzqzWmLL
         b0mlvCvIt/uOHrL+evHUh8IsPPj07dkjwcspXHnBhLYKeU4bualuyXfUXYqD7UA5xDQy
         T2VIdujQOOYfWfR7HlCnDd/qauTJhz9Tkh9rITIrPYQlwk24qpltWjCENKr8Jjl1p/ZI
         k6Uv9WlRi0V9r8Lo3kuE9rpfhjg2aef2MsCLKbOR7c5FKvOnZKbg6MYVI3WObJ/2stGA
         SxacU8OYAM+TXyg5XV/0qKzjXwN0sG7lZQldJD+x6i+YE7ktd0XXxzEGnL5TnAVP4+4G
         2GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683481168; x=1686073168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fmm5K3twSnfjvRXl95GP6fEhhk0gKbIZpn9atiJ/Snw=;
        b=BkFhQXBC0DjNt2hadphu/8wzoPdrykZXRZ9FQ4l0vRxbrWFFo5UoWyW2mVQFoTiPy9
         X0Pir+P3ugZyZB33aC1DYsxS5/D8Vy5KdswxvlsRgS3LDBh8XMCDzwUBFuP9sHQpQfO+
         sU7w7DGKDX0ITXjUBedGuwiJYrw7u5xCqAZgkcrHKg+18e3j72pLv/jaNFQrB2vhm2/+
         f1kPvMNF+0OPgQPRbxNe4nPzSmor3tMKhUmwpDc+5e11OygodEJREMRS5EeVxvPUU15Z
         Ip+9ENVTvWSsZgDrsc83NgsqDxhMX+HXxTOAy1wx8PwvY4lH9JizZKakHuqhd56iO479
         Debg==
X-Gm-Message-State: AC+VfDyfoFFWPM+jokFIKyYCA1NsH6JdUVp13BCBodBJ7gwnuxrcORYS
        l0ec/fl8H+V8OSKXgnOc6b5FbA==
X-Google-Smtp-Source: ACHHUZ7PR0FDVgBhOkmOCM+AZxWT8KIlI8Y/m9OAoqRSqctbKxwBEQrJfGg2XDvdwoBGMa6ANXB4hA==
X-Received: by 2002:a17:907:9454:b0:953:291a:6705 with SMTP id dl20-20020a170907945400b00953291a6705mr6561472ejc.17.1683481168684;
        Sun, 07 May 2023 10:39:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id gz6-20020a170907a04600b0094a90d3e385sm3912065ejc.30.2023.05.07.10.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:39:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: iio: semtech,sx9324: reference common schema for label
Date:   Sun,  7 May 2023 19:39:23 +0200
Message-Id: <20230507173923.263741-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference iio.yaml schema from dtschema to allow already used
label property:

  sc7180-trogdor-pazquel360-lte.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for dtschema:
https://lore.kernel.org/linux-devicetree/20230507171219.232216-1-krzk@kernel.org/T/#u
---
 .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b3aa2ebf9661..48f221463166 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -13,6 +13,9 @@ maintainers:
 description: |
   Semtech's SX9324 proximity sensor.
 
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
 properties:
   compatible:
     const: semtech,sx9324
@@ -167,7 +170,7 @@ required:
   - reg
   - "#io-channel-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

