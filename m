Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4B675893
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjATPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjATPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:30:26 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C0C652
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:30:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d2so5161882wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuVxCSRKQLNd9GgHEZgvIYxMnKDSeW8InDAdMgr5zKo=;
        b=vEo7y196UmHH2AcUarKpqDKid/Y8IQovAOBy70QKBeuru3MA4/Lrq4W1ZIlPjMWBbx
         JzVNe4vLkufAmIAjnyjlQm0480nLGW74Rrowz9XFXsRblQ9qCf1I7ajzzT4tZqekoUiX
         najS9Zl1WiXcAcd5CX7q4BqxqdSIENheyiSm8mfn+W4n+JEfOAZiyUJsr9PTtaTFdUpj
         +QcU0ooNWCeS1F2aZRf2v9s++sj1SniItwkRCO7vPfRaLg8X0N5320l4UQAIvYdkvd9J
         W0x3GKtRdBJ6krbIKaUmuJXebzcLT38LU1/0jYUMzbz6hd3WFYZM6n8PRchDJrxzZjAk
         VAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuVxCSRKQLNd9GgHEZgvIYxMnKDSeW8InDAdMgr5zKo=;
        b=nFTkYi8EJ9DIlW14EUhO6AzJfFHAtRN3rV01u3Ug9Hj0UXu6jkkmKSq1YTWsLiG3mo
         48EhPrhdGhH4V+dGNIo5EFDl7HNfqmRI4IB0Qn3r+J90GXjNAeFPQK+LtUpT2WqxmwrM
         yYgFKflpCxOONzLnwC1lT3v6cTsNaM160yV9VL0oZ4br+M/dqB1vjSE7zpMInUjyu2Ei
         p1MAANgFXROSr3y+b7bM7hTT4IuIK7dOkqrnhcSMTiTyWtgCekZ38sJo0DbAdLQUvfSp
         k0MXZnQPf/3QaPhIezP5EjfMiz5NZ26t8YjoCL5y8Uz55nBVwdZ9decGsQV7nFCxp0ME
         Wvjw==
X-Gm-Message-State: AFqh2koMxva+eoGMtzIlgamvEvTKVH2Ylz21/7/R0/b9yXJYUTadIqvK
        hrKteZ6TbC7hma+2X9dkO2Q+Uw==
X-Google-Smtp-Source: AMrXdXuDedGGPCSe3AnMnFgzhlNaMnZo41l2cd67+nrDKJOM0Ns+kQBgKLcaTxjfW8Fmj1xQCQz/Uw==
X-Received: by 2002:a5d:6a4f:0:b0:2be:596a:2029 with SMTP id t15-20020a5d6a4f000000b002be596a2029mr2694330wrw.29.1674228624063;
        Fri, 20 Jan 2023 07:30:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w5-20020adfcd05000000b002bdc914a139sm27656470wrm.108.2023.01.20.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:30:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: samsung,odroid: correct codec DAI phandles
Date:   Fri, 20 Jan 2023 16:30:19 +0100
Message-Id: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
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

The order of codec DAI phandles is reversed - first comes HDMI (always
present) and then codec (physically not present on Odroid XU4).

Fixes: 97709d365bbd ("ASoC: dt-bindings: Centralize the 'sound-dai' definition")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index 7b4e08ddef6a..7774543b8819 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -43,9 +43,10 @@ properties:
     type: object
     properties:
       sound-dai:
+        minItems: 1
         items:
-          - description: phandle of the MAX98090 CODEC
           - description: phandle of the HDMI IP block node
+          - description: phandle of the MAX98090 CODEC
 
   samsung,audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.34.1

