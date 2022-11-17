Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3862DA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiKQMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240027AbiKQMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:13:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F147330
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:13:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so2483267lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QovtdL7BP1h09phxGHQZDMWqvkgGdhA6FAPrdwAQwIY=;
        b=msBzi3o4FOprNhhufGIQzsDbSw190/zGjGEJk2af23OoiteXJOMOvsx43btiImNDz0
         FFkO+fjtQcqthSEbuA9ORWG2S/QTGGYyuXKWSBpt1ZfyH0AyuwdYRGVCXYy7hKqMHivF
         eSp0/k7ltt1i7aC3GSuUef0V93qTFgPACXKiiOVTC0tX7LcgU9rOYk0tD9wRAsh0+Ge9
         FUVr1qLpjAw9B1usqq7ZYO/eVUh5F4MUTTbVahTLZcesgpoE1WmNLDQZlgKog3F/0r+C
         GM212jEORbn34mrlVtS4xOkeo9B1ffUi7Ye3TJo0/y8K4FUne6NFlH620YyufBRmQmj/
         5cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QovtdL7BP1h09phxGHQZDMWqvkgGdhA6FAPrdwAQwIY=;
        b=tzkGlzWLsl/GTiAWpvjT+axd38U8V3feF+KMUIeY+YrWIJxMa587C9Ay1s593OoDds
         9U2m3KNrqHqhq09OifakLfrJcVlfSpKg7tFZNmKjv+/PoX93/8X/guQLjPfnEvBnmmN3
         wg75ciHbAHkWxBBXpP+YxV95DSzb5S/vu8o6nw44nTMD6+wJxkAUVN7GDbCCAIexbvlR
         yK/ea/5DMpp+G41XeK1lFcXjzwEcruzBVAaKlNSUum1XwU9VuqZ/dV7GV+1ScyIH0dbS
         U/8Cq928GyVbBA1qB27aMuwtp/EA91CxWy4be6BUGzvyvsYixrtF2pZu1gnfB+78afRH
         JIvg==
X-Gm-Message-State: ANoB5plgz2ooq7n5BTHNnjzIU7MqYCqvV7kZqkXIDvFu0DeKzROU5kUi
        eDLzRWO4xSQieDJycuBYUhSVpw==
X-Google-Smtp-Source: AA0mqf4APpNqBPzjGJhG6F1VrAaSfE31C9oCEqDSSi3aH8ioYbkyL4pH1PWqvn4qQFTFyM1rxgkjYA==
X-Received: by 2002:a05:6512:3b88:b0:4a3:9533:f4c9 with SMTP id g8-20020a0565123b8800b004a39533f4c9mr836327lfv.615.1668687192074;
        Thu, 17 Nov 2022 04:13:12 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b0048b26d4bb64sm125133lfe.40.2022.11.17.04.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:13:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Date:   Thu, 17 Nov 2022 13:13:07 +0100
Message-Id: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
changed to take sid argument:

  Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Issue is caused by commit 22f1d06f4f28 ("dt-bindings: iio: qcom:
adc7-pm8350: Allow specifying SID for channels") from Bjorn's tree.

Unfortunately get_maintainers.pl were not used, so IIO maintaners were
not CCed.
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index f1522196042d..bd6e0d6f6e0c 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -299,7 +299,7 @@ examples:
             };
 
             conn-therm@47 {
-                reg = <PM8350_ADC7_AMUX_THM4_100K_PU>;
+                reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
             };
-- 
2.34.1

