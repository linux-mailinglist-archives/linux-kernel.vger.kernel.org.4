Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40292714EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjE2QqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjE2QqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:46:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A620CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so649481066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685378773; x=1687970773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ1Pw000YHwunl4UOYUIH6XIIpBvLCqm0y/k6ZseuYk=;
        b=deTEIU+pyD3V5mnx/rrEaGu+++V8NuthSZVyNy3qg7qAW7v1bdiAuHp1Ykv4wUMdak
         sEITqWIa0GT/2rqYOvugqqALSSRd0RVUjiefeGQVIw0wLoa8e+hwbyx+2w1oNF//W7Un
         BXuQN9qcPNRjHieND/XpY8yaVCXqjH/bMXGpEm8E/v6SQuK2JCOB0KFrRcLdU/v7pTEj
         EI/mw2e4EWrFO1ixiI2qRQFfaNcig/KQNRdwTN6CbqtiM5EDCUzq8/hCPOICPWOAq9tw
         8Q6Ityc22xe4ekw1DhjSIKE7tu0Jvyv+2v80prncLc1QuPfo6T8PloejnKRJqziKOLJj
         KE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685378773; x=1687970773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ1Pw000YHwunl4UOYUIH6XIIpBvLCqm0y/k6ZseuYk=;
        b=TX0f2jAoxldgRm6+ROGu+4vOA/sbuCJonJZRDmDK82fphoPsFLO+L8AHlKo16IuVSV
         LoMVUGurNJ6XOqe/a3PpwFHpqZctGmp6IIEtIyqdYTliG1aBSDeXG9MOgiJKZWL36RUm
         LXM/3QESqTEq1XdU2KInz5S62gnqVi3T7df4iq0VDP8vdQzWjYzSuukSVVKDLBtfKQME
         0VqI/Vlcis7M6DuvWqATrCn+qcnxFjvGFusNa1q0ToenfH8zAazcAi2Yox7xUAxwhEjx
         4gasDxG9jo3TUzxq/+jZmhK3AL+Il9laHY8romdRmPbzliqylecr0/jPB4mKdpoqBNb8
         BpwA==
X-Gm-Message-State: AC+VfDzLFM5G2FfJzxiXbDJDoHfm5mTJHeq3dSDzkiqbI5Fqml+to1wE
        sFKDdzh6yTA8osZ0ylTL+EzDhw==
X-Google-Smtp-Source: ACHHUZ57TCu1nzyJyjSvhGgSy6JPiAeD/WueOUQpFY775HM6nWCxEeV9TIa9C/uSHQQiugl0GYTgpw==
X-Received: by 2002:a17:907:6093:b0:965:6075:d100 with SMTP id ht19-20020a170907609300b009656075d100mr14795453ejc.39.1685378772810;
        Mon, 29 May 2023 09:46:12 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f4-20020aa7d844000000b0050d89daaa70sm3248578eds.2.2023.05.29.09.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:46:12 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
Date:   Mon, 29 May 2023 18:46:02 +0200
Message-ID: <20230529164605.3552619-3-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529164605.3552619-1-bero@baylibre.com>
References: <20230529164605.3552619-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add suspend and resume support to LVTS driver.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884b..5ea8a9d569ea6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1169,6 +1169,38 @@ static int lvts_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int lvts_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct lvts_domain *lvts_td;
+	int i;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+
+	clk_disable_unprepare(lvts_td->clk);
+
+	return 0;
+}
+
+static int lvts_resume(struct platform_device *pdev)
+{
+	struct lvts_domain *lvts_td;
+	int i, ret;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	ret = clk_prepare_enable(lvts_td->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], true);
+
+	return 0;
+}
+
 static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
 	{
 		.cal_offset = { 0x04, 0x07 },
@@ -1268,6 +1300,8 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
 static struct platform_driver lvts_driver = {
 	.probe = lvts_probe,
 	.remove = lvts_remove,
+	.suspend = lvts_suspend,
+	.resume = lvts_resume,
 	.driver = {
 		.name = "mtk-lvts-thermal",
 		.of_match_table = lvts_of_match,
-- 
2.41.0.rc2

