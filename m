Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9767EEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjA0T4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjA0T42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:56:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F8EB65
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:54:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n7so5937759wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndc/iaR7jbpFClfbGd4ofgtC3FYEzqRlKdVRxlgp+PA=;
        b=gMwA6nngkfIZpPGhH4Lg/vrN9j2ELujkTuJqBUSU0s9NpnlZLPoQnnLWHJ+VMshPmf
         0ArZIdo133rszRVf0iJ2GO63/wyxGgraKhAkhxVfZ/Jt4p4yM8rodnooVDmEZLgrWw2m
         23R2CkmGjix/NtD0tDEvjzBwq/EDjm87xVWKfZElSSAhJjP/t/rsszjrU9B/+21CKGU4
         DOhc7gnw0m778fPEPCma2jSv0z4yRfhpBRchmtpriTsKcmpd90a5xrTIIRcBCmEH9fnQ
         fZEsDS/bvvYNstFae5exsHqllPmbfDrjUJnZUZpYarguFuMJ05V4vEeIk8xO7wyD4xjB
         hhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndc/iaR7jbpFClfbGd4ofgtC3FYEzqRlKdVRxlgp+PA=;
        b=PvEeo5iiGjPqLY3OaaqFBEprJXQXP+cpGU7FXHhbxTeeKB+pZRmva/cUa06j7n2qK7
         y3a5BYjTOgQYLPXU6WMziwH1z9UkyIdRhn50/Zuz1h6dvqkJojBQZfXsjzhXV8q9iQ2h
         QdHS4mCLXInsRTF8VCaOLAu6AfG5LVxfJuSL6kyHSQbBkX69iVnOmGOaN680FrEfFm6/
         z9m4sGMz016a4VpI7C5y84O3BQyuGdGPNRgsSNHPkaLpn+fU4IzdAEiaAs/e4wUqxo4Z
         o/2UD/cGPBvf5M2MAHVAejqmo+bv/WFWAtKgne0ghAwg8/T1b5lBFPXnxFHcLtVa7vUv
         2q9g==
X-Gm-Message-State: AFqh2krgixBS64HqfZ9n0MOe5DvyBkEZyftyaYyk+VWEzOXosq6OB+TX
        uo/Tz+VRlAbd8xvP/sF7HlnMqGbmMQ+WIzn3
X-Google-Smtp-Source: AK7set+pMclzg8jxiXChlpxrY5YQXujzRSx2mjUjSxo2KkccFdEEzPo3yaBlRtyHd8d+lw/pLZGQCg==
X-Received: by 2002:adf:a153:0:b0:2bf:b710:c0b with SMTP id r19-20020adfa153000000b002bfb7100c0bmr10540460wrr.1.1674848472491;
        Fri, 27 Jan 2023 11:41:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:12 -0800 (PST)
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
Subject: [PATCH 3/8] dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
Date:   Fri, 27 Jan 2023 20:40:52 +0100
Message-Id: <20230127194057.186458-4-krzysztof.kozlowski@linaro.org>
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

The MIPI phy is actually part of the Power Management Unit system
controller, thus it should be its child, instead of sibling node with
syscon phandle.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/samsung,mipi-video-phy.yaml          | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
index 415440aaad89..b2250e4a6b1b 100644
--- a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
@@ -35,15 +35,18 @@ properties:
 
   syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
     description:
       Phandle to PMU system controller interface, valid only for
-      samsung,s5pv210-mipi-video-phy and samsung,exynos5420-mipi-video-phy.
+      samsung,s5pv210-mipi-video-phy and samsung,exynos5420-mipi-video-phy (if
+      not a child of PMU).
 
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
     description:
       Phandle to PMU system controller interface, valid for
-      samsung,exynos5433-mipi-video-phy.
+      samsung,exynos5433-mipi-video-phy (if not a child of PMU).
 
   samsung,disp-sysreg:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -81,13 +84,10 @@ allOf:
         samsung,disp-sysreg: false
         samsung,cam0-sysreg: false
         samsung,cam1-sysreg: false
-      required:
-        - syscon
     else:
       properties:
         syscon: false
       required:
-        - samsung,pmu-syscon
         - samsung,disp-sysreg
         - samsung,cam0-sysreg
         - samsung,cam1-sysreg
@@ -99,7 +99,6 @@ examples:
     phy {
         compatible = "samsung,exynos5433-mipi-video-phy";
         #phy-cells = <1>;
-        samsung,pmu-syscon = <&pmu_system_controller>;
         samsung,cam0-sysreg = <&syscon_cam0>;
         samsung,cam1-sysreg = <&syscon_cam1>;
         samsung,disp-sysreg = <&syscon_disp>;
-- 
2.34.1

