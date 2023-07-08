Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260374BC4F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGHFwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGHFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:52:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E271985
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:52:36 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id I0rxqTlyvRB5SI0rxquFMX; Sat, 08 Jul 2023 07:52:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688795554;
        bh=EGyCQ+d+OCqRwxDpLY5KNbRs5E578htE1W8st+IJ468=;
        h=From:To:Cc:Subject:Date;
        b=Dui6EM4NFd593PWVsaO0qpmZ9aFC5da/oWzPekGtAcOsAuhiR0ldfmxWXbDN9oQ8O
         WKT15IGBP4I8q7bYNfiCn9ro0y1zyKrY2gQu4dHQmtq1izRrYuHIu8PGmmMRq4lN9M
         1FlydBmKeggC44TLVoUj5Tl2PSA5x4/tlp54ruLRdDpvg6FDdnfj/O+S9kZHxpUg5Q
         XtqVuez2vfFnllirHeczZeVwubOkiDhzr/wBzzvjaTg1v7AuYTFA/GXTDfa1sDKf8i
         PI+EiChH+RP9KNqqie1j+vlcQKP1gAl3S8UcixzTwIkWCvvtXiUC1Lsn+iayRMQ7Ml
         8+Qqxy2uJS+Bg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jul 2023 07:52:34 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: lan966x: Use the devm_clk_get_enabled() helper function
Date:   Sat,  8 Jul 2023 07:52:31 +0200
Message-Id: <25f2ab4c61d4fc48e8200f8754bb446f2b89ea89.1688795527.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_clk_get_enabled() helper function instead of hand-writing it.
It saves some line of codes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/lan966x-hwmon.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/hwmon/lan966x-hwmon.c b/drivers/hwmon/lan966x-hwmon.c
index f8658359a098..7247c03e4f44 100644
--- a/drivers/hwmon/lan966x-hwmon.c
+++ b/drivers/hwmon/lan966x-hwmon.c
@@ -334,24 +334,6 @@ static struct regmap *lan966x_init_regmap(struct platform_device *pdev,
 	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
 }
 
-static void lan966x_clk_disable(void *data)
-{
-	struct lan966x_hwmon *hwmon = data;
-
-	clk_disable_unprepare(hwmon->clk);
-}
-
-static int lan966x_clk_enable(struct device *dev, struct lan966x_hwmon *hwmon)
-{
-	int ret;
-
-	ret = clk_prepare_enable(hwmon->clk);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, lan966x_clk_disable, hwmon);
-}
-
 static int lan966x_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -363,15 +345,11 @@ static int lan966x_hwmon_probe(struct platform_device *pdev)
 	if (!hwmon)
 		return -ENOMEM;
 
-	hwmon->clk = devm_clk_get(dev, NULL);
+	hwmon->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(hwmon->clk))
 		return dev_err_probe(dev, PTR_ERR(hwmon->clk),
 				     "failed to get clock\n");
 
-	ret = lan966x_clk_enable(dev, hwmon);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable clock\n");
-
 	hwmon->clk_rate = clk_get_rate(hwmon->clk);
 
 	hwmon->regmap_pvt = lan966x_init_regmap(pdev, "pvt");
-- 
2.34.1

