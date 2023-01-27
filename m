Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1928967EF09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjA0UA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjA0UAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:00:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5D457CD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:58:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so4252485wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIb/cqDE0QEdwTfTF/AFA5NuBZabL9Ys/KRcfgHJZQc=;
        b=oWy4sZ6gIKCFHxueqjpfjKe7DWfnAojOvONIwiYwpzZjX3rAx+9uwf5lJcI5Wc4qVs
         S0N0v1tHTL2B5q4M/5cO/f0ScgXOYMCdakGInGdLbInpOhUhgWfA0FkK0xyAKLbE1DQ2
         yfQ8gf8/ZiJAwBTvXAoIbI0e3rtuiD8qYAmp500vi4R0C+hoRDdgiyKgNM64HAbuNseE
         tNXLhH4lveMQhsXkqUVlqEL8JnMCl+WgR44T0ptAAZ0cgaCZb8WJFo6J2A6olqMiawcR
         DQ/W0CoHs9+Akt1Lmv8RocRaZZOXMjA/qsF0SJTWFo2PZS/+/NM9JxKVen+S2s3Y8x0C
         Zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIb/cqDE0QEdwTfTF/AFA5NuBZabL9Ys/KRcfgHJZQc=;
        b=USLdPpyU6KB5Yw+VY+Mag6HD78SQjTOWD1iPmGzFba/7dCbnapGr1KXLt4Z5sjO+yt
         2aCf0R/PNqyH9bGxyJod4EYiuHEqvetuHCT0vcJlSm8YQCxhReTM1wnQqXzWJ3a0FJ8Y
         Okr/FXTzlLdtGoFZMibD77ie2Nhd+pylm+x1j6x1RXW9uUxmqATEunZy7dT7S3x81sVL
         n48lBKZ5I2ntnDVFc/thEQs9yvMVn7yPWmrt1LMm8ysaRylgnsXKVwg8+qTDzsqU/AFx
         OiCcYA+C4qxs4nnAZA/j3B5SQXOlkt52k4Hcnn7LAPHMEvq27RFhXzjmOa1jgg9uM4Jn
         +N9A==
X-Gm-Message-State: AFqh2koaaXuOUEhcUSSBV90cy+ZIsVVO9SfhL7qStmOQoVg1+ApPIT02
        sOL3jmHD/uNLXP19HT2GmkWGqW6le/y5YrMQ
X-Google-Smtp-Source: AK7set+5hEuWwLlJU+DMSAa4vo4DuOo9ZWE2X/CfhREFzZJPOEdmPS5UEkTnICoYP5XRtrhkaCWtag==
X-Received: by 2002:adf:e785:0:b0:2bf:c09e:e7bc with SMTP id n5-20020adfe785000000b002bfc09ee7bcmr7659575wrm.7.1674848476372;
        Fri, 27 Jan 2023 11:41:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:16 -0800 (PST)
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
Subject: [PATCH 5/8] phy: samsung,mipi-video-phy: deprecate syscon phandle
Date:   Fri, 27 Jan 2023 20:40:54 +0100
Message-Id: <20230127194057.186458-6-krzysztof.kozlowski@linaro.org>
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
 drivers/phy/samsung/phy-exynos-mipi-video.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
index c1df1ef3ee3c..a7f67857e5b2 100644
--- a/drivers/phy/samsung/phy-exynos-mipi-video.c
+++ b/drivers/phy/samsung/phy-exynos-mipi-video.c
@@ -298,7 +298,7 @@ static int exynos_mipi_video_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	unsigned int i;
+	unsigned int i = 0;
 
 	phy_dev = of_device_get_match_data(dev);
 	if (!phy_dev)
@@ -308,7 +308,10 @@ static int exynos_mipi_video_phy_probe(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	for (i = 0; i < phy_dev->num_regmaps; i++) {
+	state->regmaps[i] = syscon_node_to_regmap(dev->parent->of_node);
+	if (!IS_ERR(state->regmaps[i]))
+		i++;
+	for (; i < phy_dev->num_regmaps; i++) {
 		state->regmaps[i] = syscon_regmap_lookup_by_phandle(np,
 						phy_dev->regmap_names[i]);
 		if (IS_ERR(state->regmaps[i]))
-- 
2.34.1

