Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94067EE88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjA0Tnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjA0TnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61DB18A93
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so5946789wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXcEOV+ikhaaev3YUpdV3LTjyGNwDAC89LChkvoW52Y=;
        b=ECGkYC22kGhYCVIAgJfs1kwNkbHusNO0OIv7monN00IxJ/o2bSlbuNHUJze5Ozrt/M
         ujaHYFsD/x9rlkGuD+eWGdVwmMPJM4zpZD/SkU7AtFYhB2aQHfkN35l5Zw9ykEasQDBX
         7zihqPGLiYXL432GMeBiWsG5IKcqyRrynqy3bSa7f3VShNqilVQ4CMz6eV1ALCYNpLrP
         wepGiVaixK8VgQAjQUC6eWm7qUnwtBj4RaodXkl3Q0YEhL7QuRNtbs1T57/gXikIz/n0
         BI7ydf2oiSjn0OoOnPtaMh+wtpBVpw9s2XgkClagH/8gU6K1DrlKCcdlliWnqWq/Nkbs
         rTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXcEOV+ikhaaev3YUpdV3LTjyGNwDAC89LChkvoW52Y=;
        b=DJCAygjTxNQbLKuqGFtqqooPAcF7O5qg93Z7UFIAKxM5PHRz4UGRotNKdDGJxGNij0
         EY4VFRBc4r6ssNYohraPSQFC21RvU+PsHHoazZ6jjYheBywXJC8yXVe4wqkp02xyTjGC
         Wr01/8Ta1o0ZHLTnQVJhro9Dd1tm1NibGWL27e3slCC/qNyjeqbGzT0vO+WyCKAq2uoR
         +1iGWNxejppkhZXV1SViYiD7wdwKFQqxcc6COP64teMCpD9tQVlJqcm7T3sMMZjK3IJm
         zlCOdA2EJLVZ/iEYG7IZZOEFWZAIJFocnHbWZNhVhuiepUMyhCiLKNDBjC7CZDZtb1Q1
         OMZg==
X-Gm-Message-State: AFqh2kpbKxCzpLR0s0TG9GTxEmPprBqzYWA46QC4Mc264uSQElxvDruv
        xbsDrLzTTJHAEmphMPoZzshHaA==
X-Google-Smtp-Source: AMrXdXtnxP2pNNbbdNfNhQSvTB/2VE/w9WDZOg/rAZpkuBD5arji3hv5ReYPbhPestFCp0q1weUkqw==
X-Received: by 2002:a05:6000:8d:b0:2be:3a6a:f565 with SMTP id m13-20020a056000008d00b002be3a6af565mr27343065wrx.38.1674848470759;
        Fri, 27 Jan 2023 11:41:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/8] dt-bindings: phy: samsung,dp-video-phy: deprecate syscon phandle
Date:   Fri, 27 Jan 2023 20:40:51 +0100
Message-Id: <20230127194057.186458-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
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

The DisplayPort phy is actually part of the Power Management Unit system
controller, thus it should be its child, instead of sibling node with
syscon phandle.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/samsung,dp-video-phy.yaml        | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
index b03b2f00cc5b..3bee3f8733f7 100644
--- a/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,dp-video-phy.yaml
@@ -22,13 +22,13 @@ properties:
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
     description:
-      Phandle to PMU system controller interface.
+      Phandle to PMU system controller interface (if not a child of PMU).
 
 required:
   - compatible
   - "#phy-cells"
-  - samsung,pmu-syscon
 
 additionalProperties: false
 
@@ -36,6 +36,5 @@ examples:
   - |
     phy {
         compatible = "samsung,exynos5420-dp-video-phy";
-        samsung,pmu-syscon = <&pmu_system_controller>;
         #phy-cells = <0>;
     };
-- 
2.34.1

