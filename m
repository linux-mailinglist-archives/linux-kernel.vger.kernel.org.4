Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0474F318
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGKPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGKPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:13:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ECAA0;
        Tue, 11 Jul 2023 08:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJK6t2NmvC5OFnAJotMhK4jMeTS1VSxcFnY5AmQ1N1UCwmj4Z/dt7PB0J6CYAVl9rWaQxy+xHx0tNdb/vKuPUL9ePTJ1Nq/lOFBO5nLdd1p1wgdlbp4M7JGrfd4zKfdfqEwCznGefSCPUYF4aqFgXwR9tTD60M5/kOGQx2qeDtMjoY6xOgGk8YaYTLtxdefo+xUSKFVeYmhQW+INP6+HujVzgGLCg7+CE1EZ9v4R9o4W/ClUUwhqmhjIxG257BM125KBTR4EBKyoQLONdumHLg4abA8WiAJdDhrG6jQjwpazDJzhe5GHDVgr/JhvRymPVB1wgnoiJRU+2w4kn5u5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb3xlQ3SLtOOcQzKm6Vu2vLVYr7XyL3YFJSK/52IQ94=;
 b=nXj8mYgL31OHpOK3JHlLIpQmzrZLqfe7VtZnmmJ7jLJfpTNgOvoybXMGyOw7qpR1MAyQRFpjMclq1dOW57fI46xCSu+IXqenxza2ZSbr5HCJwirDCtwWkEhJmi6CG5x2GthArymrb5DUjOIN5N0pi1m/zX97f/QGDPsG5GwFpHC0krSJ/x0/dtcQIBj93McPMM5beqVq5XnOcFCJVT9SzML09cX/TduN5Kzgl4aU7nugCbLm+rNdeoFAVArb6nTyh8glv7jUf4pYaG9l/lC+YrMXs70gH8HAPqhlTf9Kpo0z2Gh1CCY1dDXUVMF0IMuGbzer4vC0bOo35Dh8HT2DDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb3xlQ3SLtOOcQzKm6Vu2vLVYr7XyL3YFJSK/52IQ94=;
 b=rNvOPyUn6HEM/d0xsRqXDnmUlVjMItJayFFDpKb3ocm0SdcJvfT8KV2hJa5Sy/bJ9dRQ1sOMN5HpNo7bThs1FEa2G4KuOnmBwt80yqyr1zGwJYT1atVc+EVw5o2RgxxfSv287S1yzi5yOWbxUYqWsySSqOqiyIInUPYhrP5cnZ1LNoT2xS4j7mEsk2ldywWfUZY3DfZeOlqb6Axs6cncrSDVPorDrBZoA71/BtRoHNR0Dmi+CiDKgzVje0uiN0a+F2zWniYrQ+J0pVCvR0VJ13HH7lr8WxATExvxhL1lAZKfMWzYq+tHZqjk0+MicyxaLH7rIAYpRtGnMj5GgW2C3w==
Received: from BYAPR08CA0041.namprd08.prod.outlook.com (2603:10b6:a03:117::18)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 15:13:05 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:117:cafe::81) by BYAPR08CA0041.outlook.office365.com
 (2603:10b6:a03:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 15:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 15:13:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 08:12:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 08:12:52 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 11 Jul
 2023 08:12:51 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in bgpio_init()
Date:   Tue, 11 Jul 2023 11:12:48 -0400
Message-ID: <20230711151248.4750-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caf6fda-7418-4d39-e278-08db82215369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEhS1otACDKg5dGOPQPB3DFJd/5hdehMsBZDTW+ci2MSLBmFOFelZ7bqb87dy039+kwMz9txOTSN2I6aGxigIRCmcHw5kQD8TEpKmdBghBq7EB+7EjmHfyJCSLQNQ+HMmugy3acOFb9BxfUPchDFlKOSQY4f8bzxhsEfYyeUBK2YRc0MCdFTOgYd78tTmcXHT/CZwO8+22G/rxhM2HTEtCNa27CBeKhCqfxzDjIqMyKKt/yHIDbuFO4k9POUiUBkdBZnZqEXfGWMtBqDahBP49H5aqsShdaB1BiTnbSTxS2rl6Za86aXHYJUgaV3tAu1QwvEq1KEpE0IH3liiFvN9n04Y+tkt3Lq4i7RM9I0xe0g/cl8TulHFdOtkG1s6tzfuah5L4A2ijD2P6WgD22CF4yGZECx7ckYNBeAFV3iFB9pK9BNnuz41Nw2TLXn/jbjJjc9o3LQdcNdn+yqilNfAJCikrGnrxlj4E/UtwPARtOs2HTb1L/Q+PvgpBsnfw58mYwCJEAy6E8kbwAdrNySgFK/j45GbDLWzCnou9OPGo3qpF563ncE7S07sLlek/mZL34OOhlq+09aO5XBUM4g5k3ZOakE/1o5iisFXmF9ow1bWU550bB6Sa3sDTsplpKvkMYsdsyGRhwLkh5TG12n9upGqXLfMt+pnBqKS3SJ3rPdnOWtsOATo+KYKbUgPCtM7Aa/tiTrNyx9RZDoJCSKXqCQbKKHojNDWdTe2Hu/G3m3z4GppzGkK9XQMb6YcklCagcdCvrrSGo7PRb8LaVVMg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(110136005)(4326008)(7696005)(6666004)(478600001)(54906003)(1076003)(186003)(26005)(107886003)(82310400005)(2906002)(70586007)(8936002)(41300700001)(70206006)(8676002)(5660300002)(7636003)(316002)(356005)(82740400003)(40460700003)(86362001)(47076005)(426003)(336012)(83380400001)(2616005)(40480700001)(36860700001)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:13:04.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caf6fda-7418-4d39-e278-08db82215369
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
The following 2 patches were approved in March 2023 but didn't make
it into the tree:
[PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
[PATCH v1] gpio: mmio: fix calculation of bgpio_bits

They needed a rebase and were combined into a single patch since
"gpio: mmio: fix calculation of bgpio_bits" fixes a bug in 
"gpio: mmio: handle "ngpios" properly in bgpio_init()"

v1->v2:
- Added the tags
- Updated the changelog

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

