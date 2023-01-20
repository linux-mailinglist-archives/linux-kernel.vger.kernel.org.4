Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB07675895
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjATPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjATPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:30:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CEC64A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:30:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d2so5161977wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSUzHZD5LBKJ/g0Aj/l6k1M45nF+70c3QfWVTVNtyEc=;
        b=s0azl5fcwGm0b+MKCDTVQOHFd7Si70F6Gn9ADXnrY3sfUu1UZuBbpVYt4JONmM1o/8
         QtTTQkWVOV4208Os9+WQXmBjmRChaZpQqO8d1m+QswUS7RfLtEAvfYwXQlEwqunGwCW8
         QP1efwv2QGe9Wpy/xtDWO8FJiUWsG4ISaWiCZUQkSr1MqRfHUdftiFAVLTMT8ZDNpZ5U
         dkYz3jU7wmZ1CmnFq8IK3Sx2vL0Unpih639jKQLtu+aHDqbQsVLkyPa4AiiMw60999Ox
         Xu3cfybEsWLpoCDLSpjXR3lFqIB8gSnUET9CbgqBvAwx9edeq2538ce45ikLiWtWkqlJ
         dANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSUzHZD5LBKJ/g0Aj/l6k1M45nF+70c3QfWVTVNtyEc=;
        b=yxYfMXEnDXdIz4N81x2UqOobm5v9vOKU8W6kaQaVrbBIIvM7a6kqMiE9gS5RPRqElo
         0ceCcVjWXL2OHqwgXzbXRgfiXyyNQ2R0QarwbnJgC0kDClWlLz12+2+9lNW2uzKCzIN4
         42w2duXAKlnLxX5N3GqhsE/2WqVvYcgFYn+AEyiBThukwJcSe7DxEO6Sfpaw1U6bxH0A
         IzV5nXYf2u2EOIiOSMS9Tivb8mjCUjc0/LzbtfqTxzVBWRJaw68uttku6XeyCWGvnNxX
         Xk6Hp2XgIpo7J7faiGoUjRYQUn4vc3lnkmx+A6vGAuWu7+DV+0KrZ/rU0XSJxwZk1mZE
         0sbA==
X-Gm-Message-State: AFqh2kqGOCrsrjlSq1UjGMKs+SrH5fdm0LbeazPhFp+MGjSP7pYuUupo
        jHCOPfsjy3XP58acqOjyPwsKEQ==
X-Google-Smtp-Source: AMrXdXtjFXEFy4S+oOquTBe7z/6bYcrA51xEzgiLxJ73uN7p9eekRWSBewsGXzfVek6fmjkEbR7t4A==
X-Received: by 2002:adf:f2c4:0:b0:2be:3503:2dcf with SMTP id d4-20020adff2c4000000b002be35032dcfmr8215441wrp.44.1674228625836;
        Fri, 20 Jan 2023 07:30:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w5-20020adfcd05000000b002bdc914a139sm27656470wrm.108.2023.01.20.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:30:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: dt-bindings: samsung-i2s: drop unneeded assigned-clock*
Date:   Fri, 20 Jan 2023 16:30:20 +0100
Message-Id: <20230120153020.320270-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
References: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
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

assigned-clock-parents and assigned-clocks are coming from dtschema, so
there is no need anymore to keep them in bindings.  Their presence were
also causing false positives:

  exynos5422-odroidxu3.dtb: i2s@3830000: Unevaluated properties are not allowed ('assigned-clock-rates' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/samsung-i2s.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 7ae007591080..30b3b6e9824b 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -75,9 +75,6 @@ properties:
           - const: rx
           - const: tx-sec
 
-  assigned-clock-parents: true
-  assigned-clocks: true
-
   clocks:
     minItems: 1
     maxItems: 3
-- 
2.34.1

