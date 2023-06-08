Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938D17281E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjFHN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjFHN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:57:57 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C168269F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:57:56 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C9A688062;
        Thu,  8 Jun 2023 21:57:52 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Jun
 2023 21:57:52 +0800
Received: from SD-Server.starfivetech.com (183.27.98.122) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 8 Jun 2023 21:57:52 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ASoC: starfive: Fix an error check in jh7110_tdm_clk_reset_get()
Date:   Thu, 8 Jun 2023 21:57:49 +0800
Message-ID: <20230608135750.11041-2-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608135750.11041-1-walker.chen@starfivetech.com>
References: <20230608135750.11041-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.122]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the check for devm_reset_control_array_get_exclusive() return value.
The devm_reset_control_array_get_exclusive() function may return NULL if
it's an optional request. If optional is intended then NULL should not
be treated as an error case, but as a special kind of success case. So
here the IS_ERR() is used to check better.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
Fix the following issue:
https://lore.kernel.org/all/ZH7t6Nc+NTcGpq%2F3@moroto/
---
 sound/soc/starfive/jh7110_tdm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/starfive/jh7110_tdm.c b/sound/soc/starfive/jh7110_tdm.c
index 973b910d2d3e..a9a3d52bdd2a 100644
--- a/sound/soc/starfive/jh7110_tdm.c
+++ b/sound/soc/starfive/jh7110_tdm.c
@@ -580,10 +580,9 @@ static int jh7110_tdm_clk_reset_get(struct platform_device *pdev,
 	}
 
 	tdm->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
-	if (IS_ERR_OR_NULL(tdm->resets)) {
-		ret = PTR_ERR(tdm->resets);
-		dev_err(&pdev->dev, "Failed to get tdm resets");
-		return ret;
+	if (IS_ERR(tdm->resets)) {
+		dev_err(&pdev->dev, "Failed to get tdm resets\n");
+		return PTR_ERR(tdm->resets);
 	}
 
 	return 0;
-- 
2.17.1

