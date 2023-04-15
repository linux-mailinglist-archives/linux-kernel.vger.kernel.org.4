Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89976E30AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDOKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDOKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:41:21 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C584C3F;
        Sat, 15 Apr 2023 03:41:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76073fb4511so43234539f.0;
        Sat, 15 Apr 2023 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555279; x=1684147279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmntWpj6jP3zgjyFhcaEHunbjz6jl27uym42Yw7yqu8=;
        b=OTI5anciovy+M1VMrYZU1itc+2zkRp5DYwYEQay8ttnHEIKbP7jOpC1gsfgNfV+vje
         +G8E6KtQ+tG6+oEaq3yHmmO07tm3smwptmIUTLFJjCX4iif+EKwtzRyZom3NXYfOZtKv
         q3i8J+UD5evCeOrpmjl/Vca8mYJNZk1F+wEp6TT4FuSa+C6ewErLul+wE/aQHxRIPxfe
         feY3zw9wNN0g+QsQnGXf0pPMcyGHuIWKZ1dN/VLeR/+cSY6yJCLwZddAfW9vycYe0IeO
         jmmYFDpJTC9kRDQoghuoGeDgMjr3/u5Np+SwuLi3KP7s99qtB1I1lBv8W/EUfFrsidhf
         JJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555279; x=1684147279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmntWpj6jP3zgjyFhcaEHunbjz6jl27uym42Yw7yqu8=;
        b=Mj+4Br8IF/R24h5nB3rjbJcNfvdbjPgMpjgxPeuAKWtO5DfJvFFqLsKcS8dG/j5NS5
         zx1TsiJvwXwkrougEbz6Jk0JB1uNcQ4YJAyzE0V5vVoRd573Sj7IrWhYsC/fwGVkqxGp
         BLmCYqzMK7Jb0npzLaC9B+U7B5oXD01RcQogJ2JBJD2CcEl4b3Ls8993inhEZpKvIDFg
         8F1B6y+SJVRNwPwQLtziQtRbbZmbfdRlWpufp1MsAYW2m12T5wwNO4plYskCiApJ6pWU
         JrA1bADP1tXWNpdGxPFQuMlXfY/bG22Yk3bKj8HRzZFwBNsn0wyam/bH0kVEnhnuH9KT
         fEnw==
X-Gm-Message-State: AAQBX9c8tgB0+vmkKTF/ey9FskHKSHcI/+Avxum6Jen72sh6YaiTPakM
        TNk2BatMSCeAO7ejm4HBpx4=
X-Google-Smtp-Source: AKy350ayS6i4RghyIc+M6inuQv9IS4zgwE+8h2GAFI+nvRgtrERdR90ywrSJGsJfVAO9nTyuFzQ/fQ==
X-Received: by 2002:a92:da4f:0:b0:329:67e2:e360 with SMTP id p15-20020a92da4f000000b0032967e2e360mr5260428ilq.31.1681555279322;
        Sat, 15 Apr 2023 03:41:19 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:40bb:6fe6:ddbc:cc9a])
        by smtp.gmail.com with ESMTPSA id bp11-20020a056638440b00b0040b38102b79sm246536jab.82.2023.04.15.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:41:18 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Sat, 15 Apr 2023 05:41:00 -0500
Message-Id: <20230415104104.5537-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415104104.5537-1-aford173@gmail.com>
References: <20230415104104.5537-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
having an entry in the device tree for samsung,pll-clock-frequency.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9fec32b44e05..73f0c3fbbdf5 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 	struct device_node *node = dev->of_node;
 	int ret;
 
-	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
-				       &dsi->pll_clk_rate);
-	if (ret < 0)
-		return ret;
-
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
 				       &dsi->burst_clk_rate);
 	if (ret < 0)
@@ -1823,13 +1818,18 @@ int samsung_dsim_probe(struct platform_device *pdev)
 		if (IS_ERR(dsi->clks[i])) {
 			if (strcmp(clk_names[i], "sclk_mipi") == 0) {
 				dsi->clks[i] = devm_clk_get(dev, OLD_SCLK_MIPI_CLK_NAME);
-				if (!IS_ERR(dsi->clks[i]))
+				if (!IS_ERR(dsi->clks[i])) {
+					dsi->pll_clk_rate = clk_get_rate(dsi->clks[i]);
 					continue;
+				}
 			}
 
 			dev_info(dev, "failed to get the clock: %s\n", clk_names[i]);
 			return PTR_ERR(dsi->clks[i]);
 		}
+
+		if (strcmp(clk_names[i], "sclk_mipi") == 0)
+			dsi->pll_clk_rate = clk_get_rate(dsi->clks[i]);
 	}
 
 	dsi->reg_base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.39.2

