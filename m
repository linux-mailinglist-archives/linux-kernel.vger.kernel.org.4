Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748967E823
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjA0OW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjA0OWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:22:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155B8396C;
        Fri, 27 Jan 2023 06:22:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so1213035wms.1;
        Fri, 27 Jan 2023 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PinM68VhN6u99TllUIHqNBM1Tt1cxF2CM8CRORXHJ8=;
        b=JV6oveLuhFH62jhk/uMBIiAvfXJ4dszJjC5+bNbd0DamtdKxwSIBxS2AJOUGVQldNG
         S5xWyDdkIcSS69MsCnDgK3mt5aFeYq6ve0sat4MF/jrcsf6OjAIepXsCvKb29brDKGB0
         QQLavrrskir4ivpzXu9dmQ9umFG2jHWh+mVECm3JlJ2HDhVpr4iR3fRE0+hdsKUWVCP5
         HVjEeNnWfReW+Ox/t1skKsB82w+TfzR7oc/L01RKkyOVMsP4GAbE8EVXPAO80V3S6aPB
         pNovXRTzmMvgou3bapmDeUnhrWlHExxdyR8Yt9E8Uv01JeeIBk6EowCvxd7Neqn242o9
         Gfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PinM68VhN6u99TllUIHqNBM1Tt1cxF2CM8CRORXHJ8=;
        b=rbs2jWZe5WyPeZ+2Y/cOKEdAdk3aygT1O5d+BwP8lhcuuVHR1f35yPwDx6ufCIn5dc
         PIvYB6CvRaoYd/qC4P2NPTxXGUqobm8iI7fAki7/r9uG3kDJMMN3OMv+9Qxu3yYWCrd0
         DtLToqZeq8ym2sl2fRNU3ZXeVVPPQnEDInWtpbXyOwZSWjb1DHK8AaMK33kKcibz8dD6
         4NgeitBpsMa+NBVXDTXqsbH7bY/R5B0RI9N7SaBotpqr+BVCGGnatLtoNB2MUoSSrq/k
         kOFf5cYT39Ppq7vLu0ARGhOcgogVTBGDgZ+XaQf/7c6HqHmZqyRl84mFn1tadm1MMl0h
         SSbg==
X-Gm-Message-State: AO0yUKU7wXALqfB/1kCfpatzf34c0qJgsJx0SZcoFYJMUdQkmd/4HNJU
        SAaMxQ1gylgyN5o71kE6F7I=
X-Google-Smtp-Source: AK7set9nHfr6dWXcQoqGY75YR4leV5N5V5+HcoQvKCYovRfHKx4ZovdnkYJB5VkD96F1SmMhhnEGnQ==
X-Received: by 2002:a05:600c:707:b0:3dc:3577:fdb2 with SMTP id i7-20020a05600c070700b003dc3577fdb2mr2743871wmn.5.1674829357136;
        Fri, 27 Jan 2023 06:22:37 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm4301039wrb.21.2023.01.27.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:22:36 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/5] dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
Date:   Fri, 27 Jan 2023 14:22:20 +0000
Message-Id: <20230127142221.3718184-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127142221.3718184-1-christianshewitt@gmail.com>
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPI-M2-PRO is based upon the BPI-M5 using the Amlogic SM1 (S905X3) chipset.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index e16b5fa55847..e935c92ab346 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -176,6 +176,7 @@ properties:
           - enum:
               - amediatech,x96-air
               - amediatech,x96-air-gbit
+              - bananapi,bpi-m2-pro
               - bananapi,bpi-m5
               - cyx,a95xf3-air
               - cyx,a95xf3-air-gbit
-- 
2.34.1

