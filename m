Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578A6AA3FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCCWQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjCCWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:15:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501446A1E6;
        Fri,  3 Mar 2023 14:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn3JQZnKHcVBP7R6OQ75CAJmS3z1Ydw+IRk27bGlbdY/rscr/fuDmvoEj0G4pSjMlCe8J8KmL13degZVd6h9SudOcOvE8yOS0r5JdihqIeNSV3FLmXEI1ZNtMWkmcr7FnDw0va9LywxLwhGLnVQsK1U5cZ/n6zYix/TeuhN/Rf1I10PEyHtgoLbNZsBlaLuvXfyz0CL9QdHePNeslqbX8xhH6PAzGtWu4R2FXR2tacCgxNDNvhjK/U0TwWAsKIqBQ1LKGDhjnoIWkeJ52j/1l3Sw1+DWy4aU0Sg44SCYOUJmAWOY89S9U+2KnW+XrJ/lwICKo6FByUh/Vb9TQm7AlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO5Sx2qJDTYEBmN0pcaDlPzGVLrUHk+JLP/6jxoUmH0=;
 b=inqpynb+fdgY4b6b5/y8Z8iZw8O7GGxcPw0T7PgciF0tBjJJKij42salFfTnf5q44doxIwH4Fi0i+ek1kQ2ey6j7hks4oRRWxhYhHhTvM6lg28ab53uuWqkCVg+gxhwbFnjeEQzWvEcH7W4vpnU2r/vsxU9YLz5P9NCrzlSrrYNi4n78341xHHyADJdky6f1tKESvcUAWHC/NIoGXErsgE4SFWrjLb6KVqgSLfrkmU0nki8UxQA+BqaMpbsulhertVsLKeqEmzCDs+ilifzTenk8lAhCzHbeTWZXpr24Dq0KIYBlTqMgXr2XUP0S2oaINsV7r7lOIUOhExysVl0aBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nO5Sx2qJDTYEBmN0pcaDlPzGVLrUHk+JLP/6jxoUmH0=;
 b=dFSRjDpy3c32/c1t/9vC6S9Y4OGhBqj5BztDeJ5yCUQ/yXvNg3ri3FMIBdNFQsYFJxQU/8X184J0/1yIjRIOCHW7PbZy4mSp8Mdd2IKiDbVILZOaxU1ZodaSPugQSuDXITAarpimSjTDHJINLIz69hcZbHA4TLKzNRVJwKqzk4Ro5HlBsuCeOOVoNwW1R4TcapYE+c6072+8baV1/PXY/rCf4xhz87GAj/3lX5gDmHDfXjVLbwu94rgd/PqoENTy9AT1Py1VmNtA18xQHfbfiHmqsDdjSU0nVYy632to03RQNnGS0giBE3rqvEAT3MqV/4UYsNTJlMUEgDzaHnCbwQ==
Received: from BN9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::34)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 21:58:19 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::99) by BN9P221CA0019.outlook.office365.com
 (2603:10b6:408:10a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Fri, 3 Mar 2023 21:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 21:58:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 3 Mar 2023
 13:58:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 3 Mar 2023
 13:58:17 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Fri, 3 Mar
 2023 13:58:16 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Fri, 3 Mar 2023 16:58:14 -0500
Message-ID: <20230303215814.24783-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DM4PR12MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdf0e3a-e258-41bd-6377-08db1c326635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa6kuEyngJQ+OrTLP5/oGv64Pnogay56Hu6b7sPYdfCcGZ7W4L3cRERdW8PTdAQC17xWtWRMFsnXS/BEjletluME6+HzeaLZ0vwWbGmsp0ur1vqlxG2rmPcHHWBQKITJUljSs13fm53/Dkf+0Am9Y1XuBCzrlwEXEabUUGSxhBrctwgPdF/hFVkc2nym5Iv6v8vELV8k4OGoo+d2AQrHwuwzB9Y8ew6AHUw9r9QbPprx1PkOWkUOIRf1pReD4xiKjSMm/lcsUqVqP1yfRlKAU6MEyHq3qU8myeZJLZ9N/EBC0eIoo6CBhyvZQffC2dMiNO8MDjf2WGGshu3V5oCf2VYO2VyC6d4YD2+opzzM2utukDTOJMrPZ1uN4fSqhwbDl/b8RIl3gVgWjlNhWC5mBVaED/Ct4oD3rYcQPx0CkV/5oQ1fNKZzeSnOhSg00yE/ui6Eun/wJc2UU+LMaS/1DDhlUDFZPptNzSaOxFBtwQhLntTiDl2AEzbCF9Qp7Y8u2qZroMryjHaD/bE2/MycFZdBIPisijinjcxE2X1OhownGIAHWkMcu3azAjCFsLqh/EK68UgNMdfXHGd+DNdBmLoqpvLR3EeQ6c8XsuESwTyl4ZNgno37kHNIRTPftjlelCVZeVVwTwi8UhmhqbzUmxSKLXojnPuoLTBg4PanqG2Wdw8/YQVpWVqz/J/XFAsPoJFqRQ9fUoswLTLTN1HjTya5j1p2B8FaFu8XYuQByWo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70586007)(70206006)(8676002)(110136005)(83380400001)(8936002)(316002)(36860700001)(41300700001)(107886003)(5660300002)(1076003)(2616005)(478600001)(26005)(47076005)(426003)(186003)(336012)(7696005)(40480700001)(36756003)(82310400005)(82740400003)(7636003)(2906002)(356005)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 21:58:18.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf0e3a-e258-41bd-6377-08db1c326635
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_init() uses "sz" argument to populate ngpio, which is not
accurate. Instead, read the "ngpios" property from the DT and if it
doesn't exist, use the "sz" argument. With this change, drivers no
longer need to overwrite the ngpio variable after calling bgpio_init.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/gpio-mmio.c |  7 ++++-
 drivers/gpio/gpiolib.c   | 58 ++++++++++++++++++----------------------
 drivers/gpio/gpiolib.h   |  1 +
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..c9f9f4e36c89 100644
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
@@ -614,10 +616,13 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->base = -1;
-	gc->ngpio = gc->bgpio_bits;
 	gc->request = bgpio_request;
 	gc->be_bits = !!(flags & BGPIOF_BIG_ENDIAN);
 
+	ret = gpiochip_get_ngpios(gc, dev);
+	if (ret)
+		gc->ngpio = gc->bgpio_bits;
+
 	ret = bgpio_setup_io(gc, dat, set, clr, flags);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 939c776b9488..17b63f52fda7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -647,6 +647,28 @@ static void gpiochip_setup_devs(void)
 	}
 }
 
+int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
+{
+	u32 ngpios = gc->ngpio;
+	int ret;
+
+	if (ngpios == 0) {
+		ret = device_property_read_u32(dev, "ngpios", &ngpios);
+		if (ret) {
+			chip_err(gc, "Failed to get ngpios property\n");
+			return -EINVAL;
+		}
+
+		gc->ngpio = ngpios;
+	}
+
+	if (gc->ngpio > FASTPATH_NGPIO)
+		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
+			gc->ngpio, FASTPATH_NGPIO);
+
+	return 0;
+}
+
 int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
@@ -655,7 +677,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	struct gpio_device *gdev;
 	unsigned long flags;
 	unsigned int i;
-	u32 ngpios = 0;
 	int base = 0;
 	int ret = 0;
 
@@ -704,36 +725,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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
-		goto err_free_dev_name;
-	}
-
-	if (gc->ngpio > FASTPATH_NGPIO)
-		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
-			  gc->ngpio, FASTPATH_NGPIO);
+	ret = gpiochip_get_ngpios(gc, &gdev->dev);
+	if (ret)
+		return ret;
 
 	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
 	if (!gdev->descs) {
@@ -903,7 +897,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
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

