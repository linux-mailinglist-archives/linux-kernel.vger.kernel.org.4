Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F674E029
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGJVWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGJVWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:22:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12BC0;
        Mon, 10 Jul 2023 14:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POoDn1p1PiZJcUIdwtdV957NWBGXTQDP1ZxB4uNm6Un1L6ag83CVufxOuWAEgKj+eGCC3/y7K8SyZpmcj6cm+SSBueNrBiweVYdqxlJluR+hC+g1aNySLUmoO7jzRGUOJTrv7j6FWaf/dRwc+MWmdL9J1DXAxVvrgfJhakmNbVs9gJum+qgN1KRx6cAbCtE5HZKD7pm2mB7H99Fnc1JtEMEczzmmE/TNhKaz601o1MKoY6sR3RZCj8ritLqz39gSxGrKo4dor3a33GhfnKVnI6LwznsVBAWFctGh9t2CAEgVSMLz3pnV+3SPJhhro1jGIpwKL4lzZaVzCXY7xI3k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9shUzaxwBiDW9T+hRx6bOmG4xxq3BPz4R1KKHYKHVUo=;
 b=kPo4lQkTHkDMWKFdFuJXb06a045nPW0majy8Q3LAbgiw4nNHklqGMMFQXJopjxvIdiMNHSC3bO5u8zwp4UzXoFN+CDvBve+IJk2xT5AtbKrOrrVPBVt2q1sU4ySSI0I3JKrGQ0+O1X9IHoi3XcTzvCliGQCB2pvZW8jYECF7JDIo25XGqiSld4q3EZRRwpizW9MoGIkW7vKkTIM3Z0HeyK9BpHQLXNyEltpUwmZis2UOVFgeUQIVa7KJ0hFaMsecXw2RygFnGfR6snXSRlqp68ES36UfT5OOoB+h7Av6+lCR+cH0D/fpUISO3EaYcXtC15T23WD0OEEjA5wsrN8RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9shUzaxwBiDW9T+hRx6bOmG4xxq3BPz4R1KKHYKHVUo=;
 b=MlDe1spaWiHHXuOQ6yctJ7hP9YsZRhAqdbFpqyd/5jgo8G3e3WC6sIP5CSOjrzGvf+4gc3glPlOZIpdbfzxx3khwjIn491ZSMtU+ATzOWSSvDjEf+trSYODE+7LYnSpKhkGeP8PNkWOTfseAKGTT288g8l+ua1lyEWE9KV7kTeAdH3thi6mtOP3ajujzZnMxhD0k/A4gmcKLUzwXqbZbs1RgBeuT70fuUjuxOmHLPrkXuOqN0iXauJ8lcZQZwMW+8u3dBsiDil8h0Kmpy+eLQlND1kgw4zPTokspL5NKxxq671L/s88wc5zA2fwpCHXytuVpKeS+V+xiF7c6iMX26g==
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 21:21:59 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ae) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 21:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Mon, 10 Jul 2023 21:21:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 14:21:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 14:21:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 10 Jul
 2023 14:21:45 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Mon, 10 Jul 2023 17:21:42 -0400
Message-ID: <20230710212142.10566-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8ae50f-6752-4c93-7f51-08db818bb1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzpZLdsq42kP/P8PLotvHS8ohSUIv6pqHX1cYow5HHCfHGCbKmxTYzEbTVMWnkWCjpfC7tg20iqvhFqwT2SaGDXTqY3LvyAssC4cQ890GxTJ63p0oR7rRxOfIKXLdv6CXxyFQ3GOSrlRNveMWXxibw23Mw4ALmo3ToqGvQat19f/lPeVxsA39oKUdmPNO4xVKPs5uTgSGEjUxd4bhVN86x4HCdNF7xNFWXeOTGU+k2n5Qo1uayATdtJppi0A7OKbD1HmPkieA9xgvPGue1XUTjZ1ne6qSB1SkU1AMu3VaMAwJhG9KDb6fs3mAa3NpjFu1hlI7O9tXEql9fZoYpL2KIOEwsmMWdVVJdVTQn9eMh0HI4Mvi8Sk0Jcf7cWl/VoWNHQTlY5TbTLBQJmPqQ2cP03dTxJQ9l7bw83FjSwvtZCMqIhmsKab8SJgY2QwqUorX70sKlbEB1whiJ/wvjaBCjXeOTq/kzxo+Yi9U1Ztha3eF7URiU8WphqlFfa4XXE5LHNq0JYpJHj/il6P413O5H4cya6g9IF7FXp8hXCfy5XxnZjtl4br7QS+TMPxaBcQe1qdyVjR0/DKXZ/Bpy5UIgz5BGijx9vSAgBXjg5Oimt/Qp4aRKHK4Dsp8vyNg/NZUnVJwdvjEox8hQNe96erNZvi0oob5o8vT/h9LRjtS0CVKFnNoi6BEB4e5pys2pPTDMbHFsWC6Xf/c52pxwH0ZbNueHjvsy/xIsZETsGYd+KtRaqgb53tTmDVwz/bWzV+lsLLUpXg9MbqAiYjSxYR+Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(2616005)(36860700001)(26005)(1076003)(107886003)(426003)(336012)(83380400001)(47076005)(41300700001)(4326008)(2906002)(316002)(5660300002)(8936002)(8676002)(478600001)(7696005)(6666004)(110136005)(70586007)(70206006)(54906003)(40480700001)(36756003)(7636003)(356005)(82740400003)(82310400005)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 21:21:58.7668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8ae50f-6752-4c93-7f51-08db818bb1fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_init() uses "sz" argument to populate ngpio, which is not
accurate. Instead, read the "ngpios" property from the DT and if it
doesn't exist, use the "sz" argument. With this change, drivers no
longer need to overwrite the ngpio variable after calling bgpio_init().

If the "ngpios" property is specified, bgpio_bits is calculated
as the round up value of ngpio. At the moment, the only requirement
specified is that the round up value must be a multiple of 8 but
it should also be a power of 2 because we provide accessors based
on the bank size in bgpio_setup_accessors().

The following 2 patches were approved in the past but didn't make it
into the tree. I combined them into one patch since the second one
fixes a bug in the first one:
[PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
[PATCH v1] gpio: mmio: fix calculation of bgpio_bits

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/gpio-mmio.c |  9 +++++-
 drivers/gpio/gpiolib.c   | 68 ++++++++++++++++++++++------------------
 drivers/gpio/gpiolib.h   |  1 +
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..74fdf0d87b2c 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -60,6 +60,8 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/of.h>
 #include <linux/of_device.h>
 
+#include "gpiolib.h"
+
 static void bgpio_write8(void __iomem *reg, unsigned long data)
 {
 	writeb(data, reg);
@@ -614,10 +616,15 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->base = -1;
-	gc->ngpio = gc->bgpio_bits;
 	gc->request = bgpio_request;
 	gc->be_bits = !!(flags & BGPIOF_BIG_ENDIAN);
 
+	ret = gpiochip_get_ngpios(gc, dev);
+	if (ret)
+		gc->ngpio = gc->bgpio_bits;
+	else
+		gc->bgpio_bits = roundup_pow_of_two(round_up(gc->ngpio, 8));
+
 	ret = bgpio_setup_io(gc, dat, set, clr, flags);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 251c875b5c34..7dac8bb9905a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -700,6 +700,40 @@ void *gpiochip_get_data(struct gpio_chip *gc)
 }
 EXPORT_SYMBOL_GPL(gpiochip_get_data);
 
+int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
+{
+	u32 ngpios = gc->ngpio;
+	int ret;
+
+	if (ngpios == 0) {
+		ret = device_property_read_u32(dev, "ngpios", &ngpios);
+		if (ret == -ENODATA)
+			/*
+			 * -ENODATA means that there is no property found and
+			 * we want to issue the error message to the user.
+			 * Besides that, we want to return different error code
+			 * to state that supplied value is not valid.
+			 */
+			ngpios = 0;
+		else if (ret)
+			return ret;
+
+		gc->ngpio = ngpios;
+	}
+
+	if (gc->ngpio == 0) {
+		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
+		return -EINVAL;
+	}
+
+	if (gc->ngpio > FASTPATH_NGPIO)
+		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
+			gc->ngpio, FASTPATH_NGPIO);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gpiochip_get_ngpios);
+
 int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
@@ -707,7 +741,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	struct gpio_device *gdev;
 	unsigned long flags;
 	unsigned int i;
-	u32 ngpios = 0;
 	int base = 0;
 	int ret = 0;
 
@@ -753,36 +786,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	else
 		gdev->owner = THIS_MODULE;
 
-	/*
-	 * Try the device properties if the driver didn't supply the number
-	 * of GPIO lines.
-	 */
-	ngpios = gc->ngpio;
-	if (ngpios == 0) {
-		ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
-		if (ret == -ENODATA)
-			/*
-			 * -ENODATA means that there is no property found and
-			 * we want to issue the error message to the user.
-			 * Besides that, we want to return different error code
-			 * to state that supplied value is not valid.
-			 */
-			ngpios = 0;
-		else if (ret)
-			goto err_free_dev_name;
-
-		gc->ngpio = ngpios;
-	}
-
-	if (gc->ngpio == 0) {
-		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
-		ret = -EINVAL;
+	ret = gpiochip_get_ngpios(gc, &gdev->dev);
+	if (ret)
 		goto err_free_dev_name;
-	}
-
-	if (gc->ngpio > FASTPATH_NGPIO)
-		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
-			  gc->ngpio, FASTPATH_NGPIO);
 
 	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
 	if (!gdev->descs) {
@@ -947,7 +953,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	/* failures here can mean systems won't boot... */
 	if (ret != -EPROBE_DEFER) {
 		pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
-		       base, base + (int)ngpios - 1,
+		       base, base + (int)gc->ngpio - 1,
 		       gc->label ? : "generic", ret);
 	}
 	return ret;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index cca81375f127..8de748a16d13 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -217,6 +217,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
+int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
-- 
2.30.1

