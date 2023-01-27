Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC267EE86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjA0TnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjA0Tmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:53 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A2717CD6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q10so5912808wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhTZHhvTWH45tyGI0x4uU2VUFxdCNkd8qxpKaMX6L7Y=;
        b=e2dWa8i6qb8eJW7sdxfl584eKltFPVaJgKseQk3WtgyJ2cNt2DYBn4SO9SH9qgJ2Qo
         CuzoNnqcjvgl61vDlxJtdCpGstjCbazcEZRpImRp4VnaoVkjfCuMcZ8TPq4++jKBaC/0
         KZIA+CrKB1cgKIwsSE1jviGl4AJ+5sSq6pC5hpH3Q+0JmpqV8HUyY29YAUKSa+oyzJzt
         Cygsv1TnrWb9rsyGZIgMh1B2aaiWNuOMsLIFQUXdDDby4m2iKqeUs1Fjv6ZFAtfwKgTV
         6H2u7SyKE2n7W8C9Obf+NdVoZgPWNsK7QxuYi1B0LaeynW+OypgQPfNhM8DcTTiNdwOu
         //8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhTZHhvTWH45tyGI0x4uU2VUFxdCNkd8qxpKaMX6L7Y=;
        b=jW4yqKWrrsT4Ge8msvISMr7CBwKp6fWULeE9KQPxF/vc8WE1DBOc1XJ6jqWfPoTej9
         Z86nlocX/6cTe0TmnTjEPPGpKXEnbnymV+VgMIS1VN8XXVMvYRYxxyq4w+CG18DGLIcV
         gDn06GsVPCxgZcOgzwCPRByM+OHHXHAXopSkudDvdNJjn4I5wWxBoWL7cp85Q6WBSBM7
         yJI4k4rej550ai1i3SgBDc2rgmZebbMivzXC4E5OroMeXpB9zJWREvi5nN5nHyAC2OtR
         Guq1O/R4mDEMEhTHbgp6Qq8NtmlzfRwMog7Kn/rSfoMxBGcoLJggc8DZzxbBaLleylx2
         3iJw==
X-Gm-Message-State: AFqh2kpFXuQ/qRxv6EwnD//Tp6sFgcJnBtJKzdNa96tkK9ZEm/K6gWXU
        gtC0mul/Lu2m1emcGIZfgAZOQsU5+3UhEQ/p
X-Google-Smtp-Source: AMrXdXs/PEB2tM0xo4K7W3J5nfYXPFlm8AtlFcItNJ0CV+x2XgfOEpsh96Tz7hnOXLSKgop7CBJGFA==
X-Received: by 2002:a5d:4ec7:0:b0:236:6c33:2130 with SMTP id s7-20020a5d4ec7000000b002366c332130mr30059728wrv.68.1674848474651;
        Fri, 27 Jan 2023 11:41:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:14 -0800 (PST)
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
Subject: [PATCH 4/8] phy: samsung,dp-video-phy: deprecate syscon phandle
Date:   Fri, 27 Jan 2023 20:40:53 +0100
Message-Id: <20230127194057.186458-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
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

The DisplayPort phy is actually part of the Power Management Unit system
controller, thus it should be its child, instead of sibling node with
syscon phandle.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
---
 drivers/phy/samsung/phy-exynos-dp-video.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos-dp-video.c b/drivers/phy/samsung/phy-exynos-dp-video.c
index 2b670ef91deb..6069fedbd8f3 100644
--- a/drivers/phy/samsung/phy-exynos-dp-video.c
+++ b/drivers/phy/samsung/phy-exynos-dp-video.c
@@ -83,8 +83,11 @@ static int exynos_dp_video_phy_probe(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	state->regs = syscon_regmap_lookup_by_phandle(dev->of_node,
-						      "samsung,pmu-syscon");
+	state->regs = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(state->regs))
+		/* Backwards compatible way */
+		state->regs = syscon_regmap_lookup_by_phandle(dev->of_node,
+							      "samsung,pmu-syscon");
 	if (IS_ERR(state->regs)) {
 		dev_err(dev, "Failed to lookup PMU regmap\n");
 		return PTR_ERR(state->regs);
-- 
2.34.1

