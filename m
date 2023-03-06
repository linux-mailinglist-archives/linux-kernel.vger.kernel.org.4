Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309186ACFF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCFVM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCFVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:12:56 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6D1FFD;
        Mon,  6 Mar 2023 13:12:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RupxDsJlGlLZU6TvEPnXztcJRCoM5NMZkAYPhVn0/yMapJEy/m/YXhZcnYtg4tnoE6t1kfuMnZKDZYmj5Y/OpEdhv+8lriGvO3oxa44H+G0aIqWpBfc/yxlC7APo0G+S6fPzKQ6b1Ek7XpeBwexPew2KI9GoMXD/gu+qXmMr9GbHoZBNfp0r+SPDdfTcTduwO85A2gPSaFj7sQiTruD9FWyinWFdRPQALwA7ovp08K23nF9IeWCfhlLURObE0kbgxaTVq03bmkGojzYBAOEJXqnKd8LqaNXkBqs0ruLnC4tKQLw2nMqaYR8J/6EyqXB04EAzP7SWicpRHgAJt1tKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uAF/S/KWZTG3o+mQBCAR1j3+4hVaVKaKX9ALWE4Av0=;
 b=Lu19JxSXmSLc4CAxgKBgqoIhvdnKml5M0hqa6U9/sQfvUVq7M+ilqHCYDQ5Mx1H1oPMh0mri1/6Z1XdlZ5GRvE/ffbnplTiXinaYQicIo02eHJNtIZOkXFcZvodnDLyOl4OHgltWHuTqHMDIPxnjDpRErPgbrRdoHlFy1LAY9Q0I0y3o4feVea//sv/qfNgJuKXqsKCbVjdgZ3kWQSkpL0KmxeoW+RtiZtZYdZhIuisY1u9crWm9QbowAjgoSyeN7FEouFfFKRbwTdbVy+/JCIWauZWWYeGklrji3LfoJ7Qa81ui9Q6xpTE96w//6Gp7V89xV9SYJlzkSAJvXi7t1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uAF/S/KWZTG3o+mQBCAR1j3+4hVaVKaKX9ALWE4Av0=;
 b=Yl1FL9/qpSKxG1vdr4vuwVxWlx2M8EjZRUUg4VXW9FGwZ51FXHm0WJ7+rkndd3gyVp+54jfWU8BjzxTNCH7qwcU8HGWYh4Jc9w6GrFDYnZXuE0mv6og9rasg3AII0JZPmYAfI98/OBAOqCfylzJpzO5bl6U+tGj5rKXeuISiiMBJUzNk5HLagoFpxrF6Hnqiz+Lu+XlELyz4Q08PmqjKwY4JOO02eHDcRztvA/HOpkfAPK2LJGD17O3adJVNFanBXDn+QF5dQUxuGDda+A/9xPG2tQfS/tPAB4euxbtFWKIEbXNVOR2KdyNWNjmNasKSmLsfiSRj2QHSC3oaBwb5Pg==
Received: from DM6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:5:1f4::45)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 21:12:51 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::16) by DM6PR02CA0104.outlook.office365.com
 (2603:10b6:5:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 21:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 21:12:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 13:12:40 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 13:12:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Mon, 6 Mar
 2023 13:12:39 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Mon, 6 Mar 2023 16:12:37 -0500
Message-ID: <20230306211237.14876-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d93442b-e076-4864-04fd-08db1e878baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdhw9W6zg6zMgSBEjMxpE6MACnzmSYvJH1E3wgV+zzW0PC3WbBKpTUrjIAZ5NA+TSkk7VIyhM1EvqqZNgy7wmY4TQ4RbBZXJwsOHUdCrJ8wzFxpz842iuvXM5c1RhBl+dtGOWYb//xQI4uquSO7E98mMaVfpl4GQ8cTdD6bowDipFeO6I8UFjjeV6jnak0VkG7+ltnsz28OhlMevfB2BW9gDF7BZTTRVg7sNj/Ri+OpE/OpbW5A4R9dvrB4yRogZH5s0Sz+zrAkTZDIjDiPHlSKsL2tozDTYRIljAATufbZIUAsjc0wo8ykGRkaSY6JIRaF0cxg+O4Z8iqUcs6+AxatG/SxQQWzsWyKV7LRiGnJecyFmba9AdQ9nr69sFSxA/ef/aNv8ogYKlSw1TTRz+WrGbaQDM48iDUcEjFBIwrWGjJ+E4uyHh3GWpkdtTO4sp74vai6MvK/onMvLpgiVQ21bsxjQdVpag27WtXkqYlJtPd4kH1jAm4ZtGsredTMfTn/XbnlOpn/T9/k8u+xEtGoBwVDrkT/umAMAAM1HJuivEmlC2gJrrRmVbSGMubtpnDi6trPwVPlNKf9GO6VPC0wIbkqrLYKy237bJJxHFAM6rNg0UA56MxanYpMclk3Wz50XEII9Aua+1FMPWVR4b/QoXDNFh6qopt+SVlIi3hkouEzKmERMdk4bP9DkYVGJ
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(1076003)(107886003)(36860700001)(47076005)(36756003)(426003)(82310400005)(83380400001)(7636003)(356005)(86362001)(40480700001)(82740400003)(186003)(336012)(26005)(2616005)(41300700001)(70586007)(4326008)(8676002)(70206006)(2906002)(8936002)(5660300002)(7696005)(478600001)(110136005)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 21:12:51.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d93442b-e076-4864-04fd-08db1e878baf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 939c776b9488..1964ec64e356 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -647,6 +647,40 @@ static void gpiochip_setup_devs(void)
 	}
 }
 
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
@@ -655,7 +689,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	struct gpio_device *gdev;
 	unsigned long flags;
 	unsigned int i;
-	u32 ngpios = 0;
 	int base = 0;
 	int ret = 0;
 
@@ -704,36 +737,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
@@ -903,7 +909,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	/* failures here can mean systems won't boot... */
 	if (ret != -EPROBE_DEFER) {
 		pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
-		       base, base + (int)ngpios - 1,
+		       base, base + (int)gc->ngpio - 1,
 		       gc->label ? : "generic", ret);
 	}
 	return ret;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b3c2db6eba80..c38cbf1b753b 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -207,6 +207,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
+int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
 
 /*
  * Return the GPIO number of the passed descriptor relative to its chip
-- 
2.30.1

