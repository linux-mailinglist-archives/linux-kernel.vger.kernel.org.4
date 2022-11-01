Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19861458D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKAIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:17:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF6EE0D;
        Tue,  1 Nov 2022 01:17:19 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1jY74lwVzHvXH;
        Tue,  1 Nov 2022 16:16:59 +0800 (CST)
Received: from localhost (10.175.101.6) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 16:17:17 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <chenweilong@huawei.com>, <f.fangjian@huawei.com>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH next v3 1/2] gpio: hisi: Add initial device tree support
Date:   Tue, 1 Nov 2022 16:24:41 +0800
Message-ID: <20221101082442.263448-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.31.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HiSilicon GPIO controller in embedded platform, which
boot from devicetree.

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
Change since v2:
- Drop wrong use ACPI_PTR/of_match_ptr
Link: https://lore.kernel.org/lkml/20221028022453.163186-1-chenweilong@huawei.com/

 drivers/gpio/Kconfig     | 2 +-
 drivers/gpio/gpio-hisi.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e034f752e7ce..71a7880af59d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -310,7 +310,7 @@ config GPIO_GRGPIO
 
 config GPIO_HISI
 	tristate "HiSilicon GPIO controller driver"
-	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	help
diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index 3caabef5c7a2..55bd69043bf4 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -221,6 +221,12 @@ static const struct acpi_device_id hisi_gpio_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, hisi_gpio_acpi_match);
 
+static const struct of_device_id hisi_gpio_dts_match[] = {
+	{ .compatible = "hisilicon,ascend910-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hisi_gpio_dts_match);
+
 static void hisi_gpio_get_pdata(struct device *dev,
 				struct hisi_gpio *hisi_gpio)
 {
@@ -311,6 +317,7 @@ static struct platform_driver hisi_gpio_driver = {
 	.driver		= {
 		.name	= HISI_GPIO_DRIVER_NAME,
 		.acpi_match_table = hisi_gpio_acpi_match,
+		.of_match_table = hisi_gpio_dts_match,
 	},
 	.probe		= hisi_gpio_probe,
 };
-- 
2.31.GIT

