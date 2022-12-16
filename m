Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8A64F006
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiLPRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiLPRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:06:58 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9876F23E83;
        Fri, 16 Dec 2022 09:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNAJndjEv3wVyzRHBkjMOW73tgGcNZMsNl2YevI7aHf/3bAUtd43ki8wJ778P5rbnae49NXj2hXRTCKJdgwbIreTHmET3A+1ZHtgIOeuTzXUTUyssm5rHrWy4qGKKw08bOQh6JCd5j447cqVy4t+7RuJcN7jawpP89UschNe6k268Q4JpimEFSgHWo445fDGK+WB4h5ipc5GTQev8nfWw0FEqArDEcsUjUYf6+ejOhR9c7eD6BH/ovWanXsPfEXUxI7a4wXYzBJokDQ5RSUWU0F5PqeboHxJJBjRITBQ5NFJUM9ttErv39dIZYqaXWg9xoZRNwM+bMyobKSNkaMyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDLpyPa+iEdMoMPJQgxacofWOFApPtbkmXfGb1h7+8A=;
 b=i19PgCHgTJoIwI9b+17qon39YikZvXEi5aRCdbuBVmI9CfYUDej0HxMmSJVCQ2T7rg/NGWYVV43B8Cx7gJnMfvdnNSrUz+5u3/SDV5XNRJbm7QOfhnAB9gyhOT1MkUXuoNU2KwpeMmZluqsf53FMsNlrKL0gogA3kDW10Z1pmDcP4x5jJ7H9i/6O/++fvuwlkJ5L7uOMZzA4+usr/lJUmLz2M5363WizWOjO0KGzgQyzHLA3jQR+J5+rTMpINrZad748h1yaEz4Rbd8JGpujhzSAipj7W23Zi/F7st6wIVt8bcicX6mfsC/YYljVcnIp4J/RSxbNNhXv915LNwW/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDLpyPa+iEdMoMPJQgxacofWOFApPtbkmXfGb1h7+8A=;
 b=R6PpXvzNUukBe3AAV9q2HlMdUDbNSttMJ+GaS5twhQHr8ZNW5o+iErgHYxpNrca5c8Z1u+DEs7iSDlT1yQRfVBSTmdNcnahmV4WTN1ywKrODgMwkgr07MK9bpiqk2j/VyjTZ7DRHWQK1IqwYZ52A2NEnQTowVqgGEMeeU+vuK4JMYVdxJKLAo9GVd1luiigtITCKpjH3DrnF6T7wozATgsQdFSbowJne8MVbpbDmfux3FCRE1qavOx8HFaRZx03EcUCp/lnhAO7byIvIxBDQ2whZqXvK+KbYWcpe0H6VcSbpZidStoRrOi6uHe2eEEFY5GrpopBTMmv4rAWD8GO4lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PA4PR03MB6910.eurprd03.prod.outlook.com (2603:10a6:102:e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 17:06:54 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 17:06:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3] rtc: abx80x: Add nvmem support
Date:   Fri, 16 Dec 2022 12:06:43 -0500
Message-Id: <20221216170643.2953920-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PA4PR03MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 47522fde-53f8-434d-12a8-08dadf87edcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj8iH/CZzcI/kN2G2xMZOJJKGqToEOx+jGUzFib0GcpygH67Y+Jb8Iojaua9C5van/xHr8MrpjwAe9gqFBQZcW0HlTRFIcrEpJsZRH5Od/bywNjXWXvDCWRWVxlnRZOq/gT93Qya83bn0cO31YBaUPSHc+KODE+qC3wOucZdwCKHtjsG50Q3oqcGUj+ksMSlyFPVit+rDajlFDnFP6i7FYdk/HHJrCDGOa3SWH142wPXl7UIOGvfn6uHiQZRZa5FJoV2stH3pCOxtrC+NuWmUG5+cTnDR9Bmv6TZMr8vtIFDqId0trBDHKfGcQje/EuLp0Ffei12CnnWwV+7gD7fEzw8EfDz+73mmsWW+jy65uflUSX/Im9lrc2UzrcAcmXOGYJ/RPJWzX4W6YUgXA8gDrMmumQTywJzDfaPNhGZU8x/+Swvzk5Vv44iyBnJeybGVVijUhVheCaq3AJMvQ2jeMKUmpgWHuoXRrs+hsKeobXLj91XclFJEbim1Cf4RCMOnlIVwLE/d+n7Jg9bcVI0Jy/Lm6HncmU28V1f6yNa3j6EQWiVCk7GfUdws00/6ic9UnUn+hZUMNKSJcZs8uCruYCU17vrEDxJux0r1yxFZoW3cRuJeRXmylExpWr+P/4L6+Nav4TSo6o3IlflyX4OfOaALw8TwdVdqxM2cW8g7V7rCDqi7pxVJIQW2HhVoiJfV7hHdHscPUCL1MnzJGcu7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(366004)(136003)(396003)(451199015)(52116002)(6512007)(2616005)(1076003)(38100700002)(38350700002)(6506007)(36756003)(83380400001)(107886003)(6666004)(6486002)(186003)(478600001)(8936002)(26005)(41300700001)(316002)(110136005)(2906002)(86362001)(66946007)(66556008)(8676002)(66476007)(4326008)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CbJYBP2V+E4JArYZNVg+cEu6jwP7NvGjPt7zY+5zI9y4ozk7J+8X8oZjHUza?=
 =?us-ascii?Q?838p3KYybcIpbb3wvfntmbyGz7leYeOr18rRmTTLQpjIPCKFB/jW7GVMRNVu?=
 =?us-ascii?Q?LNxacpo4B2D8YMIp5xcPvavWvQXlELIAx4OloSqJkdA7AbBYN/exSvVIeyvS?=
 =?us-ascii?Q?qKYwqzSXUUlAYeMhIxO3FG8IKTl4TOwWeCvuIZYvklTBz/Q+476thhJ4d2YD?=
 =?us-ascii?Q?0eSio/XNgRat/hTf6bCllZS4UKajBgaTqsbB6qOkswJC2odQ8RJZPQOnoUBO?=
 =?us-ascii?Q?Y9olUYa/gn6RaYuRzNGHGcVKIloFiC/m8lBZKHgfJYxIHRZfVyNvBX8zczpW?=
 =?us-ascii?Q?WrqCHtM3mbEQbHm8/tNCnmnxEVDR2GLnAuQXSK0RMHz1lNSOp1fN9fW/RbWb?=
 =?us-ascii?Q?wOBlSUdhOwCsduQ0LcJO8Kmaakzag//u3BkONNY1uNRjheiLpLNYwLWOw6xZ?=
 =?us-ascii?Q?qii0VHdHuBjTS4sY21YrL4UPQgmgbnz/CDlcJ9TLO67MointJIixD3bCKwEN?=
 =?us-ascii?Q?apUe7sqMozjA4actHBGJGq1S6ahNwq1OCKD5h7GdsOUrDV2sIOq31bvomoG2?=
 =?us-ascii?Q?TDqqJo/dj5pGaity4Zb64QD7zearWisqvgIoN6E9nUaS+lvjg+QzPrP1hCRQ?=
 =?us-ascii?Q?R8IwuPyjhNNPIinfeMPP1jFYhSpuISrKz5/69knPw0PCBaQR5duRl6NxSQZc?=
 =?us-ascii?Q?On62InSZ3bfTkPORT2dNHu8/0K0lJsG/MBj2DADjNZNHcF171ji3ajeiK4ak?=
 =?us-ascii?Q?Z70qgjiY7LTVkCUWrOuuAlgPTIyE7O4OHmyky4dCCe1aIuAtoOn9ehnvIFmH?=
 =?us-ascii?Q?VoEDF87trQ3Atc9N1XTQrZAYOl1g1sIVxNDUjqtk/KTgTiS1rabp3RLJmxYq?=
 =?us-ascii?Q?xpdQY6MSilVG8upu5zdr0D/1IHappvzlf/1tOyZN3l7c1NXtddNgZZt032ng?=
 =?us-ascii?Q?qyWuLAAmsxuWxoaun9AmDEzi956srYqDv4dm8awciJ5fWntRckbWbXSBd/9j?=
 =?us-ascii?Q?wA7BiaR4Blnd3Fvisb7txSAOig46pbqQkA+1zWOFXjSJgKhm2OfMG3NVu4BN?=
 =?us-ascii?Q?IVbsKdKZS6iqClimwRn4JSmjBny+FSIauGOn98VljDgy9ywJpdGL6i4e5q3J?=
 =?us-ascii?Q?itbeqi+glIUf4XJNZGw4Q05s9nMPxWx1sMaDFhSGc5U68nRYoAWJ1NmY7xcS?=
 =?us-ascii?Q?0PhZL5BLf0yNIo6ERGOPKTfjNdL91D0tALbWllntZybkROQ+UUR9qMBnWLd3?=
 =?us-ascii?Q?wxG7xUsPsIP0KxKLyeoWMw3yBSkY4fjh+bAYaFCH2mZNeqKeiI/LDvBHTe7M?=
 =?us-ascii?Q?a+ROprNwjrv3kGV1YAHD1eHVQonQqyR38DE/6OzJcbtYokTLd//QL6iznmox?=
 =?us-ascii?Q?XO4YpPO8wu528FX/FTcq/qrnKhjt3UPHZcXxEg6Edin7NMV+f8YRZFEFImzr?=
 =?us-ascii?Q?tcCaOU9xRpuM5S5+cqJyPWcrfd/WUrSuTfOwCrivwoBIVuQILDK57s43bDRl?=
 =?us-ascii?Q?vSngRFOnijqJ3/Dem2Hsq8/oCuqV+iiQYH/6cZVec9zhLI0BSZVBEV1Ka50q?=
 =?us-ascii?Q?Kt6vzg+pBJy8p2rx106bwYRh3032tcPnVFb+AHbh5AiWuvss8mv26rkJOKdD?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47522fde-53f8-434d-12a8-08dadf87edcc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 17:06:54.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQhacuiz+FwGTZvIWU5lD5+B+P4uA6FTN0pzgyHJ//AAFo86/ZptaebVKzNvEPTYLSGWcDRUOuHmPjmCmtFcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the 256-byte internal RAM. There are two windows
which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
address space) and 128 bytes at 0x80 (the "alternate" address space). We
use the standard address space because it is also accessible over SPI
(if such a port is ever done). We are limited to 32-byte reads for SMBus
compatibility, so there's no advantage to using the alternate address
space.

There are some reserved bits in the EXTRAM register, and the datasheet
doesn't say what to do with them. I've opted to skip a read/modify/write
and just write the whole thing. If this driver is ever converted to
regmap, this would be a good place to use regmap_update_bits.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Use devm_rtc_nvmem_register
- Remove ifdefs

Changes in v2:
- Fix building on non-arm platforms

 drivers/rtc/rtc-abx80x.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..3f15f75489ed 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -87,6 +88,16 @@
 #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
 #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
 
+#define ABX8XX_REG_EXTRAM	0x3f
+#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
+
+#define ABX8XX_SRAM_BASE	0x40
+#define ABX8XX_SRAM_WIN_SIZE	0x40
+#define ABX8XX_RAM_SIZE		256
+
+#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
+#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
+
 static u8 trickle_resistors[] = {0, 3, 6, 11};
 
 enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
@@ -673,6 +684,69 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 }
 #endif
 
+static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
+			     void *val, size_t bytes, bool write)
+{
+	int ret;
+
+	while (bytes) {
+		u8 extram, reg, len, lower, upper;
+
+		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
+		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
+		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
+		reg = ABX8XX_SRAM_BASE + lower;
+		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
+		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
+
+		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
+						extram);
+		if (ret)
+			return ret;
+
+		if (write)
+			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
+							     len, val);
+		else
+			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
+							    len, val);
+		if (ret)
+			return ret;
+
+		offset += len;
+		val += len;
+		bytes -= len;
+	}
+
+	return 0;
+}
+
+static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
+}
+
+static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
+}
+
+static int abx80x_setup_nvmem(struct abx80x_priv *priv)
+{
+	struct device *dev = &priv->client->dev;
+	struct nvmem_config config = {
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = abx80x_nvmem_read,
+		.reg_write = abx80x_nvmem_write,
+		.size = ABX8XX_RAM_SIZE,
+		.priv = priv,
+	};
+
+	return devm_rtc_nvmem_register(priv->rtc, &config);
+}
+
 static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -824,6 +898,10 @@ static int abx80x_probe(struct i2c_client *client,
 			return err;
 	}
 
+	err = abx80x_setup_nvmem(priv);
+	if (err)
+		return err;
+
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
 		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-- 
2.35.1.1320.gc452695387.dirty

