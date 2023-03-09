Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC06B315B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCIWvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjCIWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:51:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBFE4C5E;
        Thu,  9 Mar 2023 14:50:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A476144D;
        Thu,  9 Mar 2023 22:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6891C4339C;
        Thu,  9 Mar 2023 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678402248;
        bh=z3LXcJW+sEBhmEZPY8ualsCbQ2lqWkL1B6hI4RYGoAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/huSY6Tk3xFD3nSML276xY1+bAdQsv1uAJXa4YOLzLXQrq6LLzMdzLyu8+L1+6mI
         rSt2/P3uwGrYYQEhM2XN8XviPow5lY3kopYU0EIT7RXINO8c6rXHY54IjVQsSOam4y
         W/kCYw1DJtvdYvB0euDGSc31kRBmh7ZxGILjL6pkd/6zZS2YVDVvKEHu/geofzWHFt
         TSDJhqYUnihK7KzVRCshCTGR5zDeDH9pUigE4lJW2W6LM29i6VoyV4EPhF9KI7YQHI
         p75OBuTDkgi2hVY2WaAfepOsM+WI48QgOO+98qMc0Jc7sJOUcreJBL31/GiINr55gO
         Gb0Da6njfhlUQ==
Received: by mercury (Postfix, from userid 1000)
        id 6C08D1061BBD; Thu,  9 Mar 2023 23:50:43 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 10/11] power: supply: generic-adc-battery: add DT support
Date:   Thu,  9 Mar 2023 23:50:40 +0100
Message-Id: <20230309225041.477440-11-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309225041.477440-1-sre@kernel.org>
References: <20230309225041.477440-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds full DT support to the driver. Because of the previous
changes just adding a compatible value is enough.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 7bc54566664f..436e75d226ed 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
+#include <linux/of.h>
 #include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
@@ -170,6 +171,7 @@ static int gab_probe(struct platform_device *pdev)
 	if (!adc_bat)
 		return -ENOMEM;
 
+	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
 	psy_desc->name = dev_name(&pdev->dev);
@@ -284,10 +286,17 @@ static int __maybe_unused gab_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gab_pm_ops, gab_suspend, gab_resume);
 
+static const struct of_device_id gab_match[] = {
+	{ .compatible = "adc-battery" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gab_match);
+
 static struct platform_driver gab_driver = {
 	.driver		= {
 		.name	= "generic-adc-battery",
 		.pm	= &gab_pm_ops,
+		.of_match_table = gab_match,
 	},
 	.probe		= gab_probe,
 };
-- 
2.39.2

