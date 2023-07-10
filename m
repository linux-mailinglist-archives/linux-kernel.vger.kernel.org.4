Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD274E06A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGJVtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJVtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:49:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A980D2;
        Mon, 10 Jul 2023 14:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMeoIQoC1pUgRwRgoi99mtyac3oJtTM/Ez8H1M/32ucvucSsE7D3Krx1wtpwBk7Q2bExr/bcI3sgCsQulus1kiNITpKG2WaF9hFLm5HeoKtODqkDuZ1pgOhl2Mc4BqYmzu3eC5DDLv9dUQ+0JoT/y3AORHEOCn3drR4FOsA0I3wH3FlQ7UFi8OyzshMQ7A0D/YI2hP+hUMrLfxXVModYtkPFvjd/sL+8XiMoKkQU+r6M3E5O5uBGZzXnIGA2YnnouZ1AgZM6C8wHLQLf2lrIA3M8t3qFUY9veVjcwsl8hwlg5DB/UOGypzNpoovcm+dR3IT/iIKdk9MSpZF79snfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLt4BoP6//Oobo0SvMd5UFKQqCNQPs1ruXlU1MbzY+8=;
 b=h+ddi7LmNT8B7KSwpiA2p7NIzl6JHLuPrAd8lzi2HU4WcRa+bIdbIyWDEhuZ8zvb7XLL/2hTvTRAai8kq/2zNN8CEWQ/XCBJDpfQbkhjp3QQJc6LhwUOf461p0zcDRJtAHgrGcqO6QXnbdXD/K1TXq0TAtjgx1FkZY11SEgBTrWJjVmOEvBqzIzPWsTVV9n9Fu2lJV+zyDKHbh+uzRWxYPbF6VnxFNsViPLpsaSe7/U8XTKeiiqquq9U2FKUItUtruYrHEnCGG1LbTZqwNvkjNEjhtDGN8G42gZPDCiO4js5LOwP/dwtMBj3ChQAB/rXy3N/qTe1V8abG/aIrX14bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLt4BoP6//Oobo0SvMd5UFKQqCNQPs1ruXlU1MbzY+8=;
 b=sF5upXlR2+T+oRr4Yuov7T32Ake1cQVsBqBpMHInPgJ6h3GHm8XyL3U6CN7xzqjYkxPNceaHUeQxyVYEWHK/9lbUqK+v1wSp9KyZOGuOBGJZKiZyxjbRPHooJNZ747sWvrbaivDA38qnAWA8lMMhaOppspFIKdHk5azduAbUKvglkS/x6YXWrK/W1hnynziUWuMBPstdWXHFcvv1+tXxRE6yEXooHrl+03Ji07IQyqVqZ7yoynC5J5DL0b+jx41uWLxDrdLc4f/1M7WUTad8amGd8CHK1gfyi7FYFDSHMk5PKz69wpan5Kvxq/oe4CZIYn4iPHVXxGdrIh9F4jA6Zg==
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 21:49:28 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:41b:cafe::80) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 21:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 21:49:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 14:49:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 14:49:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Mon, 10 Jul
 2023 14:49:12 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v5] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Mon, 10 Jul 2023 17:49:10 -0400
Message-ID: <20230710214910.31892-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dbdcab-a3ee-4c65-124f-08db818f88d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: At/HRRXI7/LRhqlSnxgNfF2AocVT4ONgzaS5bNlwhvoUXM/E9e5qAaMJP5P/scJVlprtVfBE1x3jFNsx6OXJ4JKjwv4q742FLEir+WiJ1I8H/jnsPeAXYmgJbAiCZeQhrXBOSzYw2XFPXMn/MLd87dVRA1Xi48DGLd0UtCGR8iq7QWgKrJvnDOlGxcUiPrb2WVIaE5i5V1FAnhStvOIvK/516WkhggNZEcatQR6d72Ztf5Zt8z7CO6eo+plKvfZG4ie05GJQqr+QXzXRD3ILcN1vnL1iU9Dqn4f/v8gGSFhppj2UtmXrLIUReZ/t7tOx2eBEFem6wSTnvJWYbDmz0wQh3P3wHUxBP/IuzHq1lY4DyZaIsTu4icyqPOE/Vj3oTxqGkYuHG1jUCFBMlZ8UI3utcQymabI8Imy3f8PUi017krcB5IeNarN9KPbaxqAiPvUCql5wqJIkFYEeu7OyheEj+hI2Bki4cZxocRh2rBenLUzFjcyZ8NBZEdaQSuKHRlLiUHtoIYGLh+IrSdlVMzFqZP/fMB5Cplyg9ls663GPTLDLXvgS/MVywK42AqGTiJQR3HnD9fhj66fvxg0fTCte2dKmul6PzUoPozgk0+sFN2xoeB8tcs9vfW1qZJmjzcQs7+j97HtMkd3BJVwvl3wc1O37msuRu7F6i7C2DfQibOwbvlbMvQuJbXMKLlYYP/6V/dhcD/jZ9sdx4NY6kN1g/tO0xdBIHG1qV84BJVf6JbQ7Aa2H9PJiTSX2uZ5Y
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(478600001)(110136005)(54906003)(1076003)(26005)(70586007)(186003)(107886003)(336012)(70206006)(2906002)(82310400005)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(356005)(82740400003)(7636003)(86362001)(36756003)(47076005)(36860700001)(2616005)(83380400001)(426003)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 21:49:27.7491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dbdcab-a3ee-4c65-124f-08db818f88d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-mmio.c |  9 +++++-
 drivers/gpio/gpiolib.c   | 68 ++++++++++++++++++++++------------------
 drivers/gpio/gpiolib.h   |  1 +
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..b52a3dd511ca 100644
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
+		gc->bgpio_bits = round_up(gc->ngpio, 8);
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

