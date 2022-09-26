Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454525E9696
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiIYWK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIYWKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:10:51 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Sep 2022 15:10:50 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E82424BEA;
        Sun, 25 Sep 2022 15:10:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id DB4A476C;
        Sun, 25 Sep 2022 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1664143473;
        bh=CDR6Nc1HJ3HrNLUivgZzZK4lWe4CdY8NiCIvRyY7wPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTPILTcYXW6rOTV0eXNuD7Kga8L+uRxCo3xIFsRj3foTO3NamsRwcCJmc7luTZSz3
         bXIawduJ4URGSxnb4jYnYnh7UcpSXximJ8Zp/0hcYXaPzhoJByxf4/yF/lrsX9Vf9j
         J6BRQO4PtmjIhn9zZKFQ45hIHcM2ZC/PAuiNRCd0=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: [PATCH 3/3] regulator: userspace-consumer: Handle regulator-output DT nodes
Date:   Sun, 25 Sep 2022 15:03:19 -0700
Message-Id: <20220925220319.12572-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220925220319.12572-1-zev@bewilderbeest.net>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to adding some fairly simple OF support code, we make some
slight adjustments to the userspace-consumer driver to properly
support use with regulator-output hardware:

 - We now do an exclusive get of the supply regulators so as to
   prevent regulator_init_complete_work from automatically disabling
   them.

 - Instead of assuming that the supply is initially disabled, we now
   query its state to determine the initial value of drvdata->enabled.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/regulator/userspace-consumer.c       | 43 +++++++++++++++++---
 include/linux/regulator/userspace-consumer.h |  1 +
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 8ca28664776e..81752458f75e 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/userspace-consumer.h>
@@ -24,6 +25,7 @@ struct userspace_consumer_data {
 
 	struct mutex lock;
 	bool enabled;
+	bool leave_on;
 
 	int num_supplies;
 	struct regulator_bulk_data *supplies;
@@ -102,13 +104,32 @@ static const struct attribute_group attr_group = {
 
 static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 {
+	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata)
+	if (!pdata) {
+		if (!pdev->dev.of_node)
+			return -EINVAL;
+
+		pdata = &tmpdata;
+		memset(pdata, 0, sizeof(*pdata));
+
+		pdata->num_supplies = 1;
+		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
+		if (!pdata->supplies)
+			return -ENOMEM;
+		pdata->supplies[0].supply = "vout";
+
+		pdata->leave_on = of_property_read_bool(pdev->dev.of_node, "regulator-leave-on");
+	}
+
+	if (pdata->num_supplies < 1) {
+		dev_err(&pdev->dev, "At least one supply required\n");
 		return -EINVAL;
+	}
 
 	drvdata = devm_kzalloc(&pdev->dev,
 			       sizeof(struct userspace_consumer_data),
@@ -119,11 +140,12 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	drvdata->name = pdata->name;
 	drvdata->num_supplies = pdata->num_supplies;
 	drvdata->supplies = pdata->supplies;
+	drvdata->leave_on = pdata->leave_on;
 
 	mutex_init(&drvdata->lock);
 
-	ret = devm_regulator_bulk_get(&pdev->dev, drvdata->num_supplies,
-				      drvdata->supplies);
+	ret = devm_regulator_bulk_get_exclusive(&pdev->dev, drvdata->num_supplies,
+						drvdata->supplies);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get supplies: %d\n", ret);
 		return ret;
@@ -143,7 +165,12 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		}
 	}
 
-	drvdata->enabled = pdata->init_on;
+	ret = regulator_is_enabled(pdata->supplies[0].consumer);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get regulator status\n");
+		goto err_enable;
+	}
+	drvdata->enabled = !!ret;
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
@@ -160,17 +187,23 @@ static int regulator_userspace_consumer_remove(struct platform_device *pdev)
 
 	sysfs_remove_group(&pdev->dev.kobj, &attr_group);
 
-	if (data->enabled)
+	if (data->enabled && !data->leave_on)
 		regulator_bulk_disable(data->num_supplies, data->supplies);
 
 	return 0;
 }
 
+static const struct of_device_id regulator_userspace_consumer_of_match[] = {
+	{ .compatible = "regulator-output", },
+	{},
+};
+
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
 	.remove		= regulator_userspace_consumer_remove,
 	.driver		= {
 		.name		= "reg-userspace-consumer",
+		.of_match_table = regulator_userspace_consumer_of_match,
 	},
 };
 
diff --git a/include/linux/regulator/userspace-consumer.h b/include/linux/regulator/userspace-consumer.h
index b5dba0628951..7eac57ede8ad 100644
--- a/include/linux/regulator/userspace-consumer.h
+++ b/include/linux/regulator/userspace-consumer.h
@@ -21,6 +21,7 @@ struct regulator_userspace_consumer_data {
 	struct regulator_bulk_data *supplies;
 
 	bool init_on;
+	bool leave_on;
 };
 
 #endif /* __REGULATOR_PLATFORM_CONSUMER_H_ */
-- 
2.37.3

