Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082CF6BA2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCNW4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjCNWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B713D08E;
        Tue, 14 Mar 2023 15:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91C0361A4E;
        Tue, 14 Mar 2023 22:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C83C433D2;
        Tue, 14 Mar 2023 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678834542;
        bh=N/S690ZAfx+m44tSOvrZoNkOK1xJvdzfGkZgNi3dgws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvbWa7eCqEKLg4IJ91SFCgqT06tl3rTZuOkHyzTmVezFaPF+XoLLo1lp2ortT6Ng9
         hMReff1R278albuSjAIppVpPwdEkj4bf8f2ZsM2aOUQHDicdHIXj8aFRqO/2g/iaMJ
         73uVUvU/VgZR20pHK1idCgvBTLgt9mJtFR5t7dho8A2TK9a8MM1qsgawghgMSpBQ8A
         r52TPBf4XAQuRdJ20RyG5h49pEnd7j4A8+GpArIiZBa7b67UVXDTLfTGuFLa++zwXa
         37m64E6p/zL1GQ4ufHlVl0U9STftDgVTdeTjfGu0un1OGCtJA/rDXkhqT7NQcPFiyU
         saD6SezaxHbNQ==
Received: by mercury (Postfix, from userid 1000)
        id E93B810620B2; Tue, 14 Mar 2023 23:55:36 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv2 11/12] power: supply: generic-adc-battery: add DT support
Date:   Tue, 14 Mar 2023 23:55:34 +0100
Message-Id: <20230314225535.1321736-12-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314225535.1321736-1-sre@kernel.org>
References: <20230314225535.1321736-1-sre@kernel.org>
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

