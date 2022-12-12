Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9364A4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiLLQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiLLQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:35:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A5B485
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j4so404543lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4Qp2j2FvyF4l/C9cf93kEmmbnhWdpKxZ7O93BScdO0=;
        b=BZ/MRDpTZyHahdJHX0LVHOvolkQQWaaSaWzNJthVkFgQ4+FJgComqCsXbbLcy1tljE
         XgxMukoAMNin7jVQt8FiylDRQgyHywOVmZzzN2O/qpwhNpu2/9zOeS9okJKWRBvLD/kw
         IOnfq1XdEEAr9tQ9T9j6WQ/k1dxCU2QzV1eccA/828dDmnhf8adzWAJ50+DDUHieNnn2
         gm2/sFCG/hMFxFt3LxzcZjQANmYhnXLda1FPCeF0HPAhz2JF/5VzU3h/RihqPb24vHka
         rwo6xbUx/nnPQ0ibRlvg6h3PR11+RryKZyN2NUsfyFdtPOZz1P9fvLq3l2IQbr+rDsxP
         +prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4Qp2j2FvyF4l/C9cf93kEmmbnhWdpKxZ7O93BScdO0=;
        b=bF2yMdRKZoOplt7zfRYq0tWyPkRV1J/eBPXSMpMQwDbKJvOGbX46Irgfhkfd+rOQIO
         yc8yeHvdTP5ILXsWL1vqcA1diX5OYm/kJ9ssiFF4J/bCMyb1GEEhM8ry5qPET7RVQ8yV
         7TwUfCE03fxclkJms6CYdzs1J2evRbv/o6SXYKCRMyU23d5lVJyqAtH+9w8Al8HYq7mC
         kiwiBMqOGnRqZucOL/xvNgaABN7tRSz79iIWsiB5wa08smvuuRdrKYcTpAfEV/z2SR/Z
         8WU48L2sDMU6ihMO874ZUEa8G7LMqfqzm4KvxZfOURhwtjxZG4P6DgtRKA5vq0EQOYQB
         9Jzw==
X-Gm-Message-State: ANoB5plncMj9H7il1hPIqHpo3ZR8v3Q/kK6VLD5rZEpc5ujINR04/uGK
        +STatQQ5kcwW72nOTbb+kKrUDw==
X-Google-Smtp-Source: AA0mqf6fPunqgfDWC+m/U0oyL/I01xQegsw1STuWR+amZ/xep2rr9um0cUib/I2PjfLCXo0BvLwr0w==
X-Received: by 2002:a05:6512:224a:b0:4a4:68b9:19fc with SMTP id i10-20020a056512224a00b004a468b919fcmr6685294lfu.36.1670862938382;
        Mon, 12 Dec 2022 08:35:38 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25b10000000b004acff58a951sm29209lfn.133.2022.12.12.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:35:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] dt-bindings: watchdog: qcom-wdt: do not allow fallback alone
Date:   Mon, 12 Dec 2022 17:35:22 +0100
Message-Id: <20221212163532.142533-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
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

The compatible "qcom,kpss-wdt" is too generic and should not be used
alone.  Mark it as deprecated when not prepended by specific compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index e76364c52fc7..3e0b30a817d6 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -31,9 +31,10 @@ properties:
               - qcom,apss-wdt-sm8150
               - qcom,apss-wdt-sm8250
           - const: qcom,kpss-wdt
+      - const: qcom,kpss-wdt
+        deprecated: true
       - items:
           - enum:
-              - qcom,kpss-wdt
               - qcom,kpss-timer
               - qcom,kpss-wdt-apq8064
               - qcom,kpss-wdt-ipq8064
-- 
2.34.1

