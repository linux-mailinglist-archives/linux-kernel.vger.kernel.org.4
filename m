Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1976F9AA8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjEGRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjEGRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:39:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2E11610
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 10:39:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965e93f915aso475248266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683481167; x=1686073167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyN3my6pVhEGVixKUAIlJ6GSpWGmj0Uky9C8ha5UUIQ=;
        b=iAI1Q9/gb5IplcO2oJhRf+dZBeQPMNHRW/ee/kVYEqgc+uNQJqQnE5qFmcZ0woWq1M
         Q8Fs8hXGqHjUVeAYNVjWStF5sMrZL18hGj0iA65e7pcJ05ogZ9XPsadzO+U44ESjuLuI
         2X5Msxt5B01/BbY42F4n0dEi0M8r6Gp4GKBCvNYGuCz9cWQ5xBYmZLvji7gUVChEVZie
         9dR4jmW1t+cozt2vJPylBUwVyC+RyHypK4jCmO9NLnVRK4M5Rp47XVXy+xQ27SnySaTB
         f36WUu1Pk8W+Q0bS7SBSiNmqk8MvGUgcQsQ4HWPEFdDsYsi3wzoc2xndNYjlDW9JjF/A
         BE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683481167; x=1686073167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyN3my6pVhEGVixKUAIlJ6GSpWGmj0Uky9C8ha5UUIQ=;
        b=XuD/EXlKXA64QT/Nk8UfVNDLiid4MrUUajBx1vJWQk6gC8bHRVhrNvERUBPaV0pbaF
         jR1vTofYFEvIX7pKdfoxFT6IIlW9rzmrOWSXRIrRxr4iUg7WvkPN3fM6N4eLckyJCT5Y
         AAIDYpx1emgbNDQ0zQ5DYbiiSs9Q+mTRnbgEyr6DKzmBIHzkYl+9Fhnjdxx9I1USNUFv
         fFrHQ3x7LRp4yUvZrDQdhddmSvsM3oY49fupA1BdA3bicPYELNTJ05CRFyS4q4AM7ynu
         PINhh4OnieX1OuhTPuG8nbaEZ4W8xxoHPwl67B5JTU7tMzDEDHcTwU8gdoTtPRv56hCX
         7Zvw==
X-Gm-Message-State: AC+VfDyeF6dZRL0+BKmyJEHzGtGIu5G92HXq23GmrEnS7lzu1+0pi9S3
        zVBKygICKoHE3ORvIweFqchg8g==
X-Google-Smtp-Source: ACHHUZ7GJLOwJf6cE+kPB40KyYIjQFUpyv2YKiiqX51hfSn8PueOsRoxJjrSaysOtD9V/hoX8T4guQ==
X-Received: by 2002:a17:906:db02:b0:94f:128d:63db with SMTP id xj2-20020a170906db0200b0094f128d63dbmr5955890ejb.17.1683481167590;
        Sun, 07 May 2023 10:39:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id gz6-20020a170907a04600b0094a90d3e385sm3912065ejc.30.2023.05.07.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 10:39:27 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: iio: semtech,sx9310: reference common schema for label
Date:   Sun,  7 May 2023 19:39:22 +0200
Message-Id: <20230507173923.263741-2-krzysztof.kozlowski@linaro.org>
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

  sc7180-trogdor-homestar-r4.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for dtschema:
https://lore.kernel.org/linux-devicetree/20230507171219.232216-1-krzk@kernel.org/T/#u
---
 .../devicetree/bindings/iio/proximity/semtech,sx9310.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index 5de0bb2180e6..775555d147bf 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -15,6 +15,9 @@ description: |
   Specifications about the devices can be found at:
   https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
 
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
 properties:
   compatible:
     enum:
@@ -102,7 +105,7 @@ required:
   - reg
   - "#io-channel-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

