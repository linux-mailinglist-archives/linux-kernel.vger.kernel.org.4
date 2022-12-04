Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34765641ECB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiLDS3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLDS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:29:29 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83913CCF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:29:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so15347877lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryJoqPUtDVrF6ZMuGugpVvxdT6Olzct3tNuDLcoDxHw=;
        b=IfFkxwrP2J1yEUneey53OCR0QJMYN7AzZLeaCBqufcp2eaE4MYqTHjtFVJYQhKFAGq
         CS5dL2cp1T0WrQl2ZmyrY4UhTGKIs8hm+R0sw5rumVaswUPmoSGfp0NQFUxwtbllt8+u
         XAhbonsl8ib/T9GefJ6b3q0xb4S01g2gXehEpQmFcSkH4vBfvn8ZJHlcQDxiK+oGxepR
         hBk+Mujnls2YCaYsqvN2Ek9vwuGtD5hq5RsXRKpKtof3vu0oYVgTI95GbFK/sc43hlzC
         ErsbXezeV//52O9fCKNc1nCaUNLbGlbWEc1N3D/Q3Ughd6BS7soYqwCOWSulvuIJ507h
         qRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryJoqPUtDVrF6ZMuGugpVvxdT6Olzct3tNuDLcoDxHw=;
        b=bUjl3vAp5i+vse+nVCDviMugo7NCLu+AeWjuuzyos8E0oA4gV+0ZtI9y40LuU55D2W
         C1+QFBlC4FKkrASlMuc/4uzOrR0v6SlEFUQyR9v7nYakHtgZkgOFp/HJYyKTuiwpa7hX
         NGzt8iSoTgNdR8DBaMph5fy01QEKS0XcE3c9DtS8788E53pSnpUdsv2bh7jG+1Kr/jxb
         BCHgsVvbHX71JsqtJOmiu9T2d9omNU5S44i9DvDUIw2Qv4YaEs3cmWGzveCb4m/AJNT8
         QJpUC0ty+IVdL5RDwsddi+N9gtQE9bz85VMPRCJ558+J+F+s0awB2RKk4GRCwosXuO4K
         N2Pg==
X-Gm-Message-State: ANoB5plBFmH9c9taaLcwW/sRfxquxTQkCEWtl7tmq16x1xioLlCVwp/y
        voffmF0JuXJf/O7Fnfvu+QjxFg==
X-Google-Smtp-Source: AA0mqf7nxPRzYRU2hJOcxiFhlwNOAUgO8BwHiwE2ub621XQoE8wygLtenUJp9XS49uHrcaozZgRRpg==
X-Received: by 2002:a19:6903:0:b0:499:8e29:2763 with SMTP id e3-20020a196903000000b004998e292763mr29560291lfc.137.1670178564112;
        Sun, 04 Dec 2022 10:29:24 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b3b2a9f506sm1838996lfr.4.2022.12.04.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:29:23 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/9] media: dt-bindings: chrontel,ch7322: reference common CEC properties
Date:   Sun,  4 Dec 2022 19:29:04 +0100
Message-Id: <20221204182908.138910-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
References: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
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
have only one place of definition for common properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/i2c/chrontel,ch7322.yaml   | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml b/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
index 63e5b89d2e0b..50937bf5ebda 100644
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
-- 
2.34.1

