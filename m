Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798276BF595
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCQW57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCQW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6131E32;
        Fri, 17 Mar 2023 15:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AE9AB82712;
        Fri, 17 Mar 2023 22:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D3DC433A4;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=N/S690ZAfx+m44tSOvrZoNkOK1xJvdzfGkZgNi3dgws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VswMUGcxgfWv4TOP00DaedZgrnwtVJBRfWwQmr0i8uWxrQgcmQp339wQ/U7Ubj4Wg
         nJ62zapeKYtfmiGq/rGrMRZQSI/qjoV7fsI4tqtkJ9Ri94J7N/ezHt/s4xYstZyVk+
         bLpI33G4dHDiJTIBwRBccKJZQKo8sgY/isj+sLUpmEnZpsLXwAjhvVTIVi+vVOM+kG
         0NVG2gWLd8JfvhEyhHidYiq9mJZSJI0BuM8TJBn0cyJKhIaq9R/xWtE6E61OgqG/uD
         itfnxKIL9aOyTaojyW4NyYFXCFJjNzJ2aw7B4PnD8Ln/efSyNv9BSvnw03Ce4cplND
         X2olSzKygppsQ==
Received: by mercury (Postfix, from userid 1000)
        id 9AB651062112; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 11/14] power: supply: generic-adc-battery: add DT support
Date:   Fri, 17 Mar 2023 23:57:04 +0100
Message-Id: <20230317225707.1552512-12-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds full DT support to the driver. Because of the previous
changes just adding a compatible value is enough.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 0124d8d51af7..e11ad43ab968 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/types.h>
+#include <linux/of.h>
 #include <linux/devm-helpers.h>
 
 #define JITTER_DEFAULT 10 /* hope 10ms is enough */
@@ -175,6 +176,7 @@ static int gab_probe(struct platform_device *pdev)
 	if (!adc_bat)
 		return -ENOMEM;
 
+	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = adc_bat;
 	psy_desc = &adc_bat->psy_desc;
 	psy_desc->name = dev_name(&pdev->dev);
@@ -288,10 +290,17 @@ static int __maybe_unused gab_resume(struct device *dev)
 
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

