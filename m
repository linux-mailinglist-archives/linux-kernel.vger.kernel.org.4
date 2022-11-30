Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84163D899
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiK3Oy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiK3OyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:54:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4830562;
        Wed, 30 Nov 2022 06:54:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1UQCTnpfh3M0qHuwdXr7KV3EYRqVFs5XWEA3gLwqoRLUXfhNb8p1/QWW+l+hEKsFrqnC+Yo5LOxITIEOeRpcoRTlbQ0sPt8ZNIWL+vfcJje0cwF8vOYzRQ54eF2q+srQpHbQPiCyQE9yy+4J5FmJEthAgfAUQoqmI+KH/gqjDzdlIku1Y0oRyZpu+TT0HxhYBpQZH8o+BOEMqPT/1m42UEq+AmhdGnSCdL+s6RTkYDRy50UxIf44x3m60pgJ/IjzcU99mANWnlyUK4ghWXCLbTyxfiF6URLUlbBxA24UdHbHy2Q1PeqbnO2fMnrhPQ3dcCwa3HLKuy5iGZIRMfk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYJBL61NeW9NugbAjHaTgl9zvmtDgQXLX+kSVqGhLVY=;
 b=A8dwErGcsH9acgKqHssSjN9CrCM8QwyghGdv+h1m7uQ48uYM1QsbGLPJLSVbfT+VqlKiOJysxPohBdJhZcdppfljm2xW56Yznw0s7Mflh4FlMYaqLJgwBJ/RQi72IwsSL1fUQTFh+u+8xMcVYVov41FuZwgwtlcRT00fGdLPtX2vDIyGZyCKhyCQhqCxImVFREU4RkZulCABTfyOpdzD1kaWC9gJRhiqQrM7TSzvOWxxN99P6fNjaK88gTvUaPp0JfOSE8eJBhP8E6vYjCBdpBVNMykZ/7rxZ3x5TZvJPtk8pEkQD/I0jCqyneuSkQstpSdSSF7T9YcIdCAke1DbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYJBL61NeW9NugbAjHaTgl9zvmtDgQXLX+kSVqGhLVY=;
 b=If9cIeY7LDuz2nBv5FcnFpL8t8Xo1KILiESYbJvd/mk0hcD7HbWSOTqUo7B6sTF9VCMic84rZ1YjG5uev5Xd6d9GOdU1sl0GvTwD4POju/iNs+TtORYoIQCtfL/CvM40v98Z4orVuYgzWjjnI2GHILK/TGCYcRk/EmQhYQUBWVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by DBBPR08MB5977.eurprd08.prod.outlook.com (2603:10a6:10:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 30 Nov
 2022 14:54:15 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Wed, 30 Nov 2022
 14:54:15 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v5 3/3] iio: magnetometer: add ti tmag5273 driver
Date:   Wed, 30 Nov 2022 15:53:56 +0100
Message-Id: <20221130145356.1129901-4-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
References: <20221130145356.1129901-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|DBBPR08MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bfa1cf-8be2-4db1-86f9-08dad2e2bffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXP3sqlY0ODqHLlJ5hxw4TVHg1vYWMffXM0Djtce42Sb2NLbhjMKqquggl5ld27VucAlSMm47dTJBqnLvPiULCq/2gmXYNhr9Yp+tcZrssw1oWKH+EtrF53VnF9M8lADFmF3/doDH2wTmKeeLAB1nhw/Y3MIIhWd9EBM2z3JPsX8fJMW32gtL5gT5/8MiHKoiuQmdSuI/dSDTqmvixVGEy8AoGceMxijztTK1wsazLe3P+sKjo8YX3zIyEKjJ5g3blJU/wP5xndk62P2Tqjo4GodVayn2MacApDvlwQQp++hiRQmNsUho2gGHx6lSlb2hhejgwSwbqxLdvTpmv/GNs/SU9JEbhlLppvTJmsxNpP8bJ3S+pVnB0MAWxC0TKefVOzYcIgxSUc2oJ7qKKXAPIkMqQtalWI/TR5kuGfhYQX7QWhcRfU563eIHE3fFWkzW9/CH/A/oREufRKsOS/El6CF3LrrLO4slxYn62a5U3RtyT4CCqu252WVrhfL8bmiUGaE2qyj8B1icGNhfOt3fEKVG0eZ2F2i6/BI+rfI3bzaqSMXcYV/fEod7CYBxgXKIJt6rq87DjNrMLlrb+YClddCVxSh87SE1R3Ro+tllLE/KPICUQePtGsfyNm/KIbBXns0Jh9M3axhN1JhAD9KFKp4KxhrKZQ0L0/z5tniX8JO84dpiFnzQK9FBOZ3+iLgHaQuQvd5zgvqivJlofqhfHV/ZvLoLjbcs5hox7KNBBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39840400004)(346002)(136003)(396003)(376002)(366004)(451199015)(52116002)(478600001)(66556008)(36756003)(6486002)(26005)(38100700002)(38350700002)(6666004)(6506007)(66476007)(41300700001)(8676002)(66946007)(86362001)(4326008)(316002)(44832011)(54906003)(30864003)(7416002)(5660300002)(8936002)(6512007)(2616005)(966005)(186003)(1076003)(107886003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlcGegswF9jNzfNeoW5fNBpsKmKzUE+vmJnVMTjBoeAl8AJmX9DJY78SYNY8?=
 =?us-ascii?Q?uapzd+hkAKMjOJ3RfWE5cDSIo9nS4KlI2x/1nXi9HlG+8xlSWrbJ/1Pqme80?=
 =?us-ascii?Q?FoBM/xQSSOkC+5v9ZPUx6cU7dNJOPqTxuBVX7UqgVjPgWcb3UW5MzYsx3CFv?=
 =?us-ascii?Q?SvjiFPOyD2fN60CSSy3eMsG4yOJhoqflyYt810Y0bvNaO6Yu7LEvtyzl8/cH?=
 =?us-ascii?Q?0kxUFYXRlaO8EbkXupeyqGemm/WANyttffGbg/L5QYsyxGWH7J8lsbldITAV?=
 =?us-ascii?Q?MYmAzgkuleI4xfeqbmXq6iq28AXsGAT7n/vwS117yUfukZNeA8acbgXXgcGj?=
 =?us-ascii?Q?hQkv3f/6II1A7urxHbGJ40YaZblkCBo2Gpwx8xdOzSknX+ru25ZOZOv1P3J4?=
 =?us-ascii?Q?QXa0VSwtZ8jy0EYBjA68j5Gwd/ANn//65ciLm/muwLjKEP0Sb/7TOdlPzlOL?=
 =?us-ascii?Q?Rii1Y2Vm+m5jvFHdKYUKHTJvQtq74LgSMYiI48Le2C/GaGVGQDp4LH0ydR1J?=
 =?us-ascii?Q?mhI7HteEiqhEaFIOiScMoZXel2qdUCL7OYn8o+UESyQ3IdI2H4+Zc3DRJGt/?=
 =?us-ascii?Q?G07/MIue5WP7XBZkK2Hvbx3w35Rij/ao/4P03D5jhNL+RKhv81da90JlUSey?=
 =?us-ascii?Q?YKrcPxu7FMa8mTWQNxb2DedLHhEao8AryCLCVIHdn1YHzUuIGH+4JDBxBtxh?=
 =?us-ascii?Q?kqD2HIXq+NUWZzcwPH+o7pI7oQDLZFSH3Ut6XODt9OMd/FJteCQCSZKxPY35?=
 =?us-ascii?Q?9+PAgiGumbAWM8BPaIoWnXaCvvyaNenwn2btITDeUjHzuPJbrPbPCHB7qTDt?=
 =?us-ascii?Q?sw0sA3Ojw16NJfFehvjzqurm5Vsnud6NIr1hMSE5EWGEbkebjXd3JFM5JGoj?=
 =?us-ascii?Q?G5dWzek43WW+YwLojx1/zrbinKFZt+TQDJM2/jNJLdKcc/enZug2jU4q9BIp?=
 =?us-ascii?Q?fMcRZsDIZlLytzLQ/L1Kg1oer58MNNSh3aQqjtZJOnDEbCxhSlSxsoAPPlpj?=
 =?us-ascii?Q?5SlVID0aeg+19BZYyuFQGIT82KjQD20F/bsM8oIbWlTJUevMZZ1owGz9uruT?=
 =?us-ascii?Q?cp+u9CjfKJmfVLnSZmozTAB0HLMbB4fqKKt/v4gU5ZYZ66lLrstUBR/Qo0du?=
 =?us-ascii?Q?sAWpZBcSmJCAWIu8i7R/wRlXik8slNXPZNgbEUfXI3qflPP+a3WkC0+CkvZg?=
 =?us-ascii?Q?p7eWDY5FslKlydownrlqIItqHDJovdZ9tE96q4GnxA81QC/Sz4CFaQHFLpF9?=
 =?us-ascii?Q?DobmC4PKckgE4ygM7VGJimf6rAw+uP53O9n/822ePGL+/WZzkLlQ27eOI8Kl?=
 =?us-ascii?Q?ou61wKPDIUvosccqJ7B4mBzPo3xQYkmDnOmwyL0YpKOq+rr0WRZY+RDqr5k4?=
 =?us-ascii?Q?7+8m8VVDs9MtvoBHpJ5zCa22ZGjek5v6JgNqj5OmqLjNT0HUQPDENcxboiYA?=
 =?us-ascii?Q?qKbHUqbzVyijtZu2WGyCj9/ZEW3gW8aMxJHE6jcG5JVacInozpj6+xOcPMIh?=
 =?us-ascii?Q?0g84Lh2NenPCE9DVa/S6d6eRi8LpvMjlW+RiuHaHiPHfRAfVkoIjV4uiQnp3?=
 =?us-ascii?Q?KBR7USZkcbJKQ3D2IuuB/8//b4IX6GYJTluJbQ1+QmUspq1XRLJVrJhhHE8M?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bfa1cf-8be2-4db1-86f9-08dad2e2bffd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:54:15.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5T8LTfpQVBhtNKHQeqhI18rcSoSkTs4fV2OMPqln+w1zgd3ePDBq51cQRXsh7MplJvnJ6vWPPMqUlMqC3W9TEXer6+9LNFpzizcfuWW9y/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
Additionally to temperature and magnetic X, Y and Z-axes the angle and
magnitude are reported.
The sensor is operating in continuous measurement mode and changes to sleep
mode if not used for 5 seconds.

Datasheet: https://www.ti.com/lit/gpn/tmag5273
Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
Changes in v5:
 - Fixed dev_err_probe
 - Removed unnecessary '&' for function pointers
 - Removed warning for device tree reading failure as Linux should not
   validate device tree.
 - Added comment for device name
 - Added tmag5273_wake_up() and improved comments
 - Reformatted pm_ops
 
Changes in v4:
 - Renamed struct iio_val_int_plus_micro members
 - Simplified tmag5273_write_scale()
 - Removed unnecessary  != 0
 - Fixed regmap max_register
 - Simplified tmag5273_read_device_property()
 - Fixed some line breaks

Changes in v3:
 - Added include <linux/bitfield.h>
   | Reported-by: kernel test robot <lkp@intel.com> 
 - Added include <linux/bits.h>
 - Removed <asm/unaligned.h>
 - Added missing "static const" for tmag5273_avg_table
 - Documented Device ID
 - Fixed index of tmag5273_scale definition
 - Clarify TMAG5273_MAG_CH_EN_X_Y_Z as an index
 - Removed unnecessary print
 - Introduced tmag5273_write_scale() and tmag5273_write_osr() helper
    functions
 - Use of match_string()
 - Format

Changes in v2:
 - Implemented suggestions from review and cleaned up probe function. This
   results in changes all over the tmag5273.c code.

 MAINTAINERS                         |   1 +
 drivers/iio/magnetometer/Kconfig    |  12 +
 drivers/iio/magnetometer/Makefile   |   2 +
 drivers/iio/magnetometer/tmag5273.c | 738 ++++++++++++++++++++++++++++
 4 files changed, 753 insertions(+)
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea7acec52f8b..9d20b5780051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20618,6 +20618,7 @@ M:	Gerald Loacker <gerald.loacker@wolfvision.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
+F:	drivers/iio/magnetometer/tmag5273.c
 
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index b91fc5e6a26e..467819335588 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -208,6 +208,18 @@ config SENSORS_RM3100_SPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called rm3100-spi.
 
+config TI_TMAG5273
+	tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to add support for the TI TMAG5273 Low-Power
+	  Linear 3D Hall-Effect Sensor.
+
+	  This driver can also be compiled as a module.
+	  To compile this driver as a module, choose M here: the module
+	  will be called tmag5273.
+
 config YAMAHA_YAS530
 	tristate "Yamaha YAS530 family of 3-Axis Magnetometers (I2C)"
 	depends on I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index b9f45b7fafc3..b1c784ea71c8 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -29,4 +29,6 @@ obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
 
+obj-$(CONFIG_TI_TMAG5273)		+= tmag5273.o
+
 obj-$(CONFIG_YAMAHA_YAS530)		+= yamaha-yas530.o
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
new file mode 100644
index 000000000000..8c1038618948
--- /dev/null
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
+ *
+ * Copyright (C) 2022 WolfVision GmbH
+ *
+ * Author: Gerald Loacker <gerald.loacker@wolfvision.net>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define TMAG5273_DEVICE_CONFIG_1	 0x00
+#define TMAG5273_DEVICE_CONFIG_2	 0x01
+#define TMAG5273_SENSOR_CONFIG_1	 0x02
+#define TMAG5273_SENSOR_CONFIG_2	 0x03
+#define TMAG5273_X_THR_CONFIG		 0x04
+#define TMAG5273_Y_THR_CONFIG		 0x05
+#define TMAG5273_Z_THR_CONFIG		 0x06
+#define TMAG5273_T_CONFIG		 0x07
+#define TMAG5273_INT_CONFIG_1		 0x08
+#define TMAG5273_MAG_GAIN_CONFIG	 0x09
+#define TMAG5273_MAG_OFFSET_CONFIG_1	 0x0A
+#define TMAG5273_MAG_OFFSET_CONFIG_2	 0x0B
+#define TMAG5273_I2C_ADDRESS		 0x0C
+#define TMAG5273_DEVICE_ID		 0x0D
+#define TMAG5273_MANUFACTURER_ID_LSB	 0x0E
+#define TMAG5273_MANUFACTURER_ID_MSB	 0x0F
+#define TMAG5273_T_MSB_RESULT		 0x10
+#define TMAG5273_T_LSB_RESULT		 0x11
+#define TMAG5273_X_MSB_RESULT		 0x12
+#define TMAG5273_X_LSB_RESULT		 0x13
+#define TMAG5273_Y_MSB_RESULT		 0x14
+#define TMAG5273_Y_LSB_RESULT		 0x15
+#define TMAG5273_Z_MSB_RESULT		 0x16
+#define TMAG5273_Z_LSB_RESULT		 0x17
+#define TMAG5273_CONV_STATUS		 0x18
+#define TMAG5273_ANGLE_RESULT_MSB	 0x19
+#define TMAG5273_ANGLE_RESULT_LSB	 0x1A
+#define TMAG5273_MAGNITUDE_RESULT	 0x1B
+#define TMAG5273_DEVICE_STATUS		 0x1C
+
+#define TMAG5273_AUTOSLEEP_DELAY_MS	 5000
+#define TMAG5273_MAX_AVERAGE             32
+
+/*
+ * bits in the TMAG5273_MANUFACTURER_ID_LSB / MSB register
+ * 16-bit unique manufacturer ID 0x49 / 0x54 = "TI"
+ */
+#define TMAG5273_MANUFACTURER_ID	 0x5449
+
+/* bits in the TMAG5273_DEVICE_CONFIG_1 register */
+#define TMAG5273_AVG_MODE_MASK		 GENMASK(4, 2)
+#define TMAG5273_AVG_1_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 0)
+#define TMAG5273_AVG_2_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 1)
+#define TMAG5273_AVG_4_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 2)
+#define TMAG5273_AVG_8_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 3)
+#define TMAG5273_AVG_16_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 4)
+#define TMAG5273_AVG_32_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 5)
+
+/* bits in the TMAG5273_DEVICE_CONFIG_2 register */
+#define TMAG5273_OP_MODE_MASK		 GENMASK(1, 0)
+#define TMAG5273_OP_MODE_STANDBY	 FIELD_PREP(TMAG5273_OP_MODE_MASK, 0)
+#define TMAG5273_OP_MODE_SLEEP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 1)
+#define TMAG5273_OP_MODE_CONT		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 2)
+#define TMAG5273_OP_MODE_WAKEUP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 3)
+
+/* bits in the TMAG5273_SENSOR_CONFIG_1 register */
+#define TMAG5273_MAG_CH_EN_MASK		 GENMASK(7, 4)
+#define TMAG5273_MAG_CH_EN_X_Y_Z	 7
+
+/* bits in the TMAG5273_SENSOR_CONFIG_2 register */
+#define TMAG5273_Z_RANGE_MASK		 BIT(0)
+#define TMAG5273_X_Y_RANGE_MASK		 BIT(1)
+#define TMAG5273_ANGLE_EN_MASK		 GENMASK(3, 2)
+#define TMAG5273_ANGLE_EN_OFF		 0
+#define TMAG5273_ANGLE_EN_X_Y		 1
+#define TMAG5273_ANGLE_EN_Y_Z		 2
+#define TMAG5273_ANGLE_EN_X_Z		 3
+
+/* bits in the TMAG5273_T_CONFIG register */
+#define TMAG5273_T_CH_EN		 BIT(0)
+
+/* bits in the TMAG5273_DEVICE_ID register */
+#define TMAG5273_VERSION_MASK		 GENMASK(1, 0)
+
+/* bits in the TMAG5273_CONV_STATUS register */
+#define TMAG5273_CONV_STATUS_COMPLETE	 BIT(0)
+
+enum tmag5273_channels {
+	TEMPERATURE = 0,
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+	ANGLE,
+	MAGNITUDE,
+};
+
+enum tmag5273_scale_index {
+	MAGN_RANGE_LOW = 0,
+	MAGN_RANGE_HIGH,
+	MAGN_RANGE_NUM
+};
+
+/* state container for the TMAG5273 driver */
+struct tmag5273_data {
+	struct device *dev;
+	unsigned int devid;
+	unsigned int version;
+	char name[16];
+	unsigned int conv_avg;
+	unsigned int scale;
+	enum tmag5273_scale_index scale_index;
+	unsigned int angle_measurement;
+	struct regmap *map;
+	struct regulator *vcc;
+
+	/*
+	 * Locks the sensor for exclusive use during a measurement (which
+	 * involves several register transactions so the regmap lock is not
+	 * enough) so that measurements get serialized in a
+	 * first-come-first-serve manner.
+	 */
+	struct mutex lock;
+};
+
+static const char *const tmag5273_angle_names[] = { "off", "x-y", "y-z", "x-z" };
+
+/*
+ * Averaging enables additional sampling of the sensor data to reduce the noise
+ * effect, but also increases conversion time.
+ */
+static const unsigned int tmag5273_avg_table[] = {
+	1, 2, 4, 8, 16, 32,
+};
+
+/*
+ * Magnetic resolution in Gauss for different TMAG5273 versions.
+ * Scale[Gauss] = Range[mT] * 1000 / 2^15 * 10, (1 mT = 10 Gauss)
+ * Only version 1 and 2 are valid, version 0 and 3 are reserved.
+ */
+static const struct iio_val_int_plus_micro tmag5273_scale[][MAGN_RANGE_NUM] = {
+	{ { 0,     0 }, { 0,     0 } },
+	{ { 0, 12200 }, { 0, 24400 } },
+	{ { 0, 40600 }, { 0, 81200 } },
+	{ { 0,     0 }, { 0,     0 } },
+};
+
+static int tmag5273_get_measure(struct tmag5273_data *data, s16 *t, s16 *x,
+				s16 *y, s16 *z, u16 *angle, u16 *magnitude)
+{
+	unsigned int status, val;
+	__be16 reg_data[4];
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	/*
+	 * Max. conversion time is 2425 us in 32x averaging mode for all three
+	 * channels. Since we are in continuous measurement mode, a measurement
+	 * may already be there, so poll for completed measurement with
+	 * timeout.
+	 */
+	ret = regmap_read_poll_timeout(data->map, TMAG5273_CONV_STATUS, status,
+				       status & TMAG5273_CONV_STATUS_COMPLETE,
+				       100, 10000);
+	if (ret) {
+		dev_err(data->dev, "timeout waiting for measurement\n");
+		goto out_unlock;
+	}
+
+	ret = regmap_bulk_read(data->map, TMAG5273_T_MSB_RESULT, reg_data,
+			       sizeof(reg_data));
+	if (ret)
+		goto out_unlock;
+	*t = be16_to_cpu(reg_data[0]);
+	*x = be16_to_cpu(reg_data[1]);
+	*y = be16_to_cpu(reg_data[2]);
+	*z = be16_to_cpu(reg_data[3]);
+
+	ret = regmap_bulk_read(data->map, TMAG5273_ANGLE_RESULT_MSB,
+			       &reg_data[0], sizeof(reg_data[0]));
+	if (ret)
+		goto out_unlock;
+	/*
+	 * angle has 9 bits integer value and 4 bits fractional part
+	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
+	 * 0  0  0  a  a  a  a  a  a  a  a  a  f  f  f  f
+	 */
+	*angle = be16_to_cpu(reg_data[0]);
+
+	ret = regmap_read(data->map, TMAG5273_MAGNITUDE_RESULT, &val);
+	if (ret < 0)
+		goto out_unlock;
+	*magnitude = val;
+
+out_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int tmag5273_write_osr(struct tmag5273_data *data, int val)
+{
+	int i;
+
+	if (val == data->conv_avg)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_avg_table); i++) {
+		if (tmag5273_avg_table[i] == val)
+			break;
+	}
+	if (i == ARRAY_SIZE(tmag5273_avg_table))
+		return -EINVAL;
+	data->conv_avg = val;
+
+	return regmap_update_bits(data->map, TMAG5273_DEVICE_CONFIG_1,
+				  TMAG5273_AVG_MODE_MASK,
+				  FIELD_PREP(TMAG5273_AVG_MODE_MASK, i));
+}
+
+static int tmag5273_write_scale(struct tmag5273_data *data, int scale_micro)
+{
+	u32 value;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tmag5273_scale[0]); i++) {
+		if (tmag5273_scale[data->version][i].micro == scale_micro)
+			break;
+	}
+	if (i == ARRAY_SIZE(tmag5273_scale[0]))
+		return -EINVAL;
+	data->scale_index = i;
+
+	if (data->scale_index == MAGN_RANGE_LOW)
+		value = 0;
+	else
+		value = TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK;
+
+	return regmap_update_bits(data->map, TMAG5273_SENSOR_CONFIG_2,
+				  TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK, value);
+}
+
+static int tmag5273_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct tmag5273_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = tmag5273_avg_table;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(tmag5273_avg_table);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MAGN:
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			*vals = (int *)tmag5273_scale[data->version];
+			*length = ARRAY_SIZE(tmag5273_scale[data->version]) *
+				  MAGN_RANGE_NUM;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tmag5273_read_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan, int *val,
+			     int *val2, long mask)
+{
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	s16 t, x, y, z;
+	u16 angle, magnitude;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_RAW:
+		ret = pm_runtime_resume_and_get(data->dev);
+		if (ret < 0)
+			return ret;
+
+		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle, &magnitude);
+		if (ret)
+			return ret;
+
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+
+		switch (chan->address) {
+		case TEMPERATURE:
+			*val = t;
+			return IIO_VAL_INT;
+		case AXIS_X:
+			*val = x;
+			return IIO_VAL_INT;
+		case AXIS_Y:
+			*val = y;
+			return IIO_VAL_INT;
+		case AXIS_Z:
+			*val = z;
+			return IIO_VAL_INT;
+		case ANGLE:
+			*val = angle;
+			return IIO_VAL_INT;
+		case MAGNITUDE:
+			*val = magnitude;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			/*
+			 * Convert device specific value to millicelsius.
+			 * Resolution from the sensor is 60.1 LSB/celsius and
+			 * the reference value at 25 celsius is 17508 LSBs.
+			 */
+			*val = 10000;
+			*val2 = 601;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_MAGN:
+			/* Magnetic resolution in uT */
+			*val = 0;
+			*val2 = tmag5273_scale[data->version]
+					      [data->scale_index].micro;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ANGL:
+			/*
+			 * Angle is in degrees and has four fractional bits,
+			 * therefore use 1/16 * pi/180 to convert to radiants.
+			 */
+			*val = 1000;
+			*val2 = 916732;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = -266314;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = data->conv_avg;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tmag5273_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct tmag5273_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return tmag5273_write_osr(data, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MAGN:
+			if (val)
+				return -EINVAL;
+			return tmag5273_write_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+#define TMAG5273_AXIS_CHANNEL(axis, index)				     \
+	{								     \
+		.type = IIO_MAGN,					     \
+		.modified = 1,						     \
+		.channel2 = IIO_MOD_##axis,				     \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		     \
+				      BIT(IIO_CHAN_INFO_SCALE),		     \
+		.info_mask_shared_by_type_available =			     \
+				      BIT(IIO_CHAN_INFO_SCALE),		     \
+		.info_mask_shared_by_all =				     \
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_all_available =			     \
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.address = index,					     \
+		.scan_index = index,					     \
+		.scan_type = {						     \
+			.sign = 's',					     \
+			.realbits = 16,					     \
+			.storagebits = 16,				     \
+			.endianness = IIO_CPU,				     \
+		},							     \
+	}
+
+static const struct iio_chan_spec tmag5273_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+		.address = TEMPERATURE,
+		.scan_index = TEMPERATURE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	TMAG5273_AXIS_CHANNEL(X, AXIS_X),
+	TMAG5273_AXIS_CHANNEL(Y, AXIS_Y),
+	TMAG5273_AXIS_CHANNEL(Z, AXIS_Z),
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all =
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available =
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.address = ANGLE,
+		.scan_index = ANGLE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all_available =
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.address = MAGNITUDE,
+		.scan_index = MAGNITUDE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(6),
+};
+
+static const struct iio_info tmag5273_info = {
+	.read_avail = tmag5273_read_avail,
+	.read_raw = tmag5273_read_raw,
+	.write_raw = tmag5273_write_raw,
+};
+
+static bool tmag5273_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg >= TMAG5273_T_MSB_RESULT && reg <= TMAG5273_MAGNITUDE_RESULT;
+}
+
+static const struct regmap_config tmag5273_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = TMAG5273_DEVICE_STATUS,
+	.volatile_reg = tmag5273_volatile_reg,
+};
+
+static int tmag5273_set_operating_mode(struct tmag5273_data *data,
+				       unsigned int val)
+{
+	return regmap_write(data->map, TMAG5273_DEVICE_CONFIG_2, val);
+}
+
+static void tmag5273_read_device_property(struct tmag5273_data *data)
+{
+	struct device *dev = data->dev;
+	const char *str;
+	int ret;
+
+	data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
+
+	ret = device_property_read_string(dev, "ti,angle-measurement", &str);
+	if (ret)
+		return;
+
+	ret = match_string(tmag5273_angle_names,
+			   ARRAY_SIZE(tmag5273_angle_names), str);
+	if (ret >= 0)
+		data->angle_measurement = ret;
+}
+
+static void tmag5273_wake_up(struct tmag5273_data *data)
+{
+	int val;
+
+	/* Wake up the chip by sending a dummy I2C command */
+	regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
+	/*
+	 * Time to go to stand-by mode from sleep mode is 50us
+	 * typically, during this time no I2C access is possible.
+	 */
+	usleep_range(80, 200);
+}
+
+static int tmag5273_chip_init(struct tmag5273_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_1,
+			   TMAG5273_AVG_32_MODE);
+	if (ret)
+		return ret;
+	data->conv_avg = 32;
+
+	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_2,
+			   TMAG5273_OP_MODE_CONT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_1,
+			   FIELD_PREP(TMAG5273_MAG_CH_EN_MASK,
+				      TMAG5273_MAG_CH_EN_X_Y_Z));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_2,
+			   FIELD_PREP(TMAG5273_ANGLE_EN_MASK,
+				      data->angle_measurement));
+	if (ret)
+		return ret;
+	data->scale_index = MAGN_RANGE_LOW;
+
+	return regmap_write(data->map, TMAG5273_T_CONFIG, TMAG5273_T_CH_EN);
+}
+
+static int tmag5273_check_device_id(struct tmag5273_data *data)
+{
+	__le16 devid;
+	int val, ret;
+
+	ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to power on device\n");
+	data->version = FIELD_PREP(TMAG5273_VERSION_MASK, val);
+
+	ret = regmap_bulk_read(data->map, TMAG5273_MANUFACTURER_ID_LSB, &devid,
+			       sizeof(devid));
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to read device ID\n");
+	data->devid = le16_to_cpu(devid);
+
+	switch (data->devid) {
+	case TMAG5273_MANUFACTURER_ID:
+		/*
+		 * The device name matches the orderable part number. 'x' stands
+		 * for A, B, C or D devices, which have different I2C addresses.
+		 * Versions 1 or 2 (0 and 3 is reserved) stands for different
+		 * magnetic strengths.
+		 */
+		snprintf(data->name, sizeof(data->name), "tmag5273x%1u", data->version);
+		if (data->version < 1 || data->version > 2)
+			dev_warn(data->dev, "Unsupported device %s\n", data->name);
+		return 0;
+	default:
+		dev_warn(data->dev, "Unknown device ID 0x%x\n", data->devid);
+		return 0;
+	}
+}
+
+static void tmag5273_power_down(void *data)
+{
+	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
+}
+
+static int tmag5273_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct tmag5273_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	i2c_set_clientdata(i2c, indio_dev);
+
+	data->map = devm_regmap_init_i2c(i2c, &tmag5273_regmap_config);
+	if (IS_ERR(data->map))
+		return dev_err_probe(dev, PTR_ERR(data->map),
+				     "failed to allocate register map\n");
+
+	mutex_init(&data->lock);
+
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	tmag5273_wake_up(data);
+
+	ret = tmag5273_check_device_id(data);
+	if (ret)
+		return ret;
+
+	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to power on device\n");
+
+	/*
+	 * Register powerdown deferred callback which suspends the chip
+	 * after module unloaded.
+	 *
+	 * TMAG5273 should be in SUSPEND mode in the two cases:
+	 * 1) When driver is loaded, but we do not have any data or
+	 *    configuration requests to it (we are solving it using
+	 *    autosuspend feature).
+	 * 2) When driver is unloaded and device is not used (devm action is
+	 *    used in this case).
+	 */
+	ret = devm_add_action_or_reset(dev, tmag5273_power_down, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add powerdown action\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, TMAG5273_AUTOSLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	tmag5273_read_device_property(data);
+
+	ret = tmag5273_chip_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init device\n");
+
+	indio_dev->info = &tmag5273_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = data->name;
+	indio_dev->channels = tmag5273_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tmag5273_channels);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
+
+	return 0;
+}
+
+static int tmag5273_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
+	if (ret)
+		dev_err(dev, "failed to power off device (%pe)\n", ERR_PTR(ret));
+
+	return ret;
+}
+
+static int tmag5273_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmag5273_data *data = iio_priv(indio_dev);
+	int ret;
+
+	tmag5273_wake_up(data);
+
+	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
+	if (ret)
+		dev_err(dev, "failed to power on device (%pe)\n", ERR_PTR(ret));
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
+				 tmag5273_runtime_suspend, tmag5273_runtime_resume,
+				 NULL);
+
+static const struct i2c_device_id tmag5273_id[] = {
+	{ "tmag5273" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, tmag5273_id);
+
+static const struct of_device_id tmag5273_of_match[] = {
+	{ .compatible = "ti,tmag5273" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tmag5273_of_match);
+
+static struct i2c_driver tmag5273_driver = {
+	.driver	 = {
+		.name = "tmag5273",
+		.of_match_table = tmag5273_of_match,
+		.pm = pm_ptr(&tmag5273_pm_ops),
+	},
+	.probe_new = tmag5273_probe,
+	.id_table = tmag5273_id,
+};
+module_i2c_driver(tmag5273_driver);
+
+MODULE_DESCRIPTION("TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor driver");
+MODULE_AUTHOR("Gerald Loacker <gerald.loacker@wolfvision.net>");
+MODULE_LICENSE("GPL");
-- 
2.37.2

