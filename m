Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA335642B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiLEPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiLEPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:20:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AF1E727;
        Mon,  5 Dec 2022 07:19:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irXLbj5ancQfI8sJ83gXWHfra2ekYCaRdD3Skg4zF50PEv2RIxu63GmfaB2PB9p1gPWmSA3NHblIapZHKjd8bcLHy3aFgLTCstaWbsF8IUV790CWlOLIYP4VTT976xbuK4chxGFRQlQBzDsQmYfc6qahw+59806m6rQaMcguF84LMEatdt205IwnVZwTgafsKkjKuZaaKbfadgSRjproQ05DetGyPenYAQKC58DvfzwJY8WSVbF8RF1LS2nA3SvJrLy3FlrPnZk07D/tUqDn+qyeU2DoN+N3kLMrJ7Fl2PYjQF2xroZNzpyeKgIOm+7i1DlP6bkN97bTkxHEnzbsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMpOJlaaIv2sIBU5JuZtefqNnuCsX4jzCprkFxD3H2I=;
 b=gUjoljh/XWzJqYqMUGnysK+mmUrY9Qx501NnpdsWASVxghwA79z1QnhKbPZtn2oZEbCuvSsCzGy3gFj0O7ZwRTU3FNXelXSKt0veOwLfRzYDDZCOur9o/a6gKaCsOm0oFm65mkIGXWbgMagkxPMPQG0yy48l5hdHlAg9E7DvOvk138a/L/NtBnlhqKW3fil+PzU/ndV2/gjxN5y/HIjRtVDpYiIPYuEfXXPqrjSxoNI1ufMyVVxSiDPfTF+ZYFER3SQAy+rtU3Li2ENeR7GXsXLwnKX6VxaabR8FkXge6B/o7lLg/QGCOb63Hl5G0vrDGpIUwEVBBgFNcqp+LMNUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpOJlaaIv2sIBU5JuZtefqNnuCsX4jzCprkFxD3H2I=;
 b=UhZTLE3iKaRoQ1dxs3/VpHA1yYZG9DORYyexXttwDFcWtcQHD259JUACMyvB5qgvCOjhapBMUxXiRB4W08XUEA61X/uNMDz+u8+qn/NvRAlV/EkLGX6ZIsj9M+piyL9VYJix+EkhVBg7qNTCScR+YE1K/lOcq06dJY+ZlDbjER88HPK+mYV3Xx42rkhvLHwdCsxqXW7WUCU0jLK6B+NP38+oLwdPDvpP4+T2azQrSAOur+SACxsVzWdRRH0JdfDQ6JW1Mx3EQ2YtgFPIMwpF8L36WBWIhlS5SjaDznwbE1aj/kiJ6GAgh071Zwt3Y8eeKLIthVElV48pTqtRSpTp4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GV1PR03MB8814.eurprd03.prod.outlook.com (2603:10a6:150:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 5 Dec
 2022 15:19:33 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 15:19:33 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] rtc: abx80x: Add nvmem support
Date:   Mon,  5 Dec 2022 10:19:18 -0500
Message-Id: <20221205151918.1264917-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GV1PR03MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 546f6b2b-2ed2-463a-e0dc-08dad6d41cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UqDRaA9LffRRusK6O5tm3unfU44KJhN7NYl3A7b6KFWzflwZqYVgwE5druqJc1jBG7SFlOVgXDDa1+E9axQlQtgVx1E9BiEuFbcL675+/x5Y3YL2Ejw/G0g5oEeWriPAKad0RwTWQjqsZs4gS8mSrIh10jvTpBQmLQ/ERnUhxy5Pd4bgsp3OFbqBVNW3KtrNu7eMptrcOQyQJCevuXW3DzK61+5wVaaDgJF6kZv45nnG7O9jPq5L+9NDCHKsbhYsQ1TqYgHGvx2o2luLlbSuuxO7t/hwxiGMHdmxyfp6SwY1mSaPRqLMGl7wkmKjjPQKCczP53ei/piJl9X1TJBlAxt9CbDxX0UFMzoaVwWZKiXwSnxg9yEz+mi2Vvo41OqoQz3ZUN7pC+fr5oK6USCd/lC36EJoJg5uwpfPVY87qPQl/3d5UBxWjmgLdUVmUB6JwD37Ph9xbb4tmt6zuW+cJ/4+2yrydQAMF5wq1f29Tt+KplwVR3lHDceE0vVpdESBhzkQwVxkkrWxkojb4R2Gq5oTPwpLoc6c4imV2V4CupI9F3zMG1vVQgZpin09DkQZyryWKP6z/JLdMATVm5pJyJLQm4yf+6Ay8Rqwxole7exZx+TItKiDD3rJLF7GVPfUDHNxU/rwvm48O7W561/0iYfmRDabzKjhqstfGDS4b3Xf0iBM0kPBsluHZ9PEijYthAEBydHaQICjUVc4cKz8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39850400004)(136003)(451199015)(86362001)(6506007)(52116002)(478600001)(6486002)(36756003)(38100700002)(186003)(1076003)(38350700002)(83380400001)(2616005)(5660300002)(44832011)(41300700001)(107886003)(6666004)(6512007)(26005)(8676002)(4326008)(66556008)(66946007)(66476007)(8936002)(316002)(110136005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BfohdNzQcBEnri/E9AMUxKaE3ct7N6bQ81XFkwpemoteDNgfgmzGvcc+iMKX?=
 =?us-ascii?Q?xL6wKz5B1g5UNhL08t+dd0XSx7kUmobDjkUhFD9AFgU1tGtsqHjN89u6Kai+?=
 =?us-ascii?Q?VcOmMtcRHNJ9hgs1JqKJeJZZI3vM/wM15VXnno2ypkWtW0MyFGd7qXO6Pd8y?=
 =?us-ascii?Q?/IT43xpzeTDzjvbOmoeCE2nZ2hWpPDAzeRxakr43P2NELQVPtgo6yu3j9lA0?=
 =?us-ascii?Q?0ozmwpTV5y5tVZa7Ro8ZBt4HB0R4mj3/ioCJIiV09BoEh6urrhqwRlDWlZm+?=
 =?us-ascii?Q?Smxq2KK/3lxCq6zrM2lUY4Vnkrf3wFa4UrbzK/H1vUBQWz0+0ymwgRNSBNf3?=
 =?us-ascii?Q?GOGwsB31DOEJpCWJOXkgTmjnPo2ZLSosLyl2RF5wFHVTTIZv6JxRJhqAmfoN?=
 =?us-ascii?Q?podT3krTJc2KnrcMmJ/SnVt6BMigG8LrXG2+d5x6dOb31WwTaUgH7LsppaPe?=
 =?us-ascii?Q?/uK5lIhBeeTmVxsRxhDnN7LrhXAXr8KfemTWytiRDH6TfqRzd9scyZwD0a4C?=
 =?us-ascii?Q?JAulNT1Jr+oqbLu0DicmOvbaLkB9ykYri5De7ahjycgv83hk6UxrU/xh4DtV?=
 =?us-ascii?Q?SQ2o90czo8QnfaaqiZ0RtKY7vBYCuV5qsHMiI8gcWMDnE+IwEFaoAMOQ+sy7?=
 =?us-ascii?Q?T2Vz7uFOGXnVwm9/rG6PlwX7stZQxbqAlajNvfubr5Fq+bcNNzEmvFZoUaKL?=
 =?us-ascii?Q?inV5dqZkIhGWSbkEbdU6P6eS5MClHC56p2hy2LsfjYBOb6ZirUPNaZFzrwJz?=
 =?us-ascii?Q?l59bM7k39+BQrfKFuSTQcxZZ2+Q8L8m+BapsSb9Dd7tq8nWqzOLMLCjyVLq4?=
 =?us-ascii?Q?PEt4099wcwfFiGXlOqC/7o+4nIloEP/5oNhbOHVxKWln7Xml0qzC788AE4Jx?=
 =?us-ascii?Q?f5opQC5xNocu8/oTiCudN+TUssZFn7EkqB/mXQad4YhYEo1NhFqOwCOM9Cgb?=
 =?us-ascii?Q?i7BFihP8dJpz05evyyf/XUjrEMWo7+1uqrde6G63yKiKF4vHtHz4fBuYi6sW?=
 =?us-ascii?Q?I7yaxpcqibxc1hWQ5ji4WmiwjcO29kBnA0/AZ3fykeLDOOz5iZsxjPHj0Lyo?=
 =?us-ascii?Q?0vjOUxO5QVwvgy0TkXfSCWgMmAAiSSEhJCyg/YBGVDbDyAMAnv1OyncK7uQJ?=
 =?us-ascii?Q?sXhnxN76Fv4mVAFlbTT/dIKKF8MRFMDT4lCSAsmW2sYS0EcDYcqu2kzaejPk?=
 =?us-ascii?Q?2uxrEHVrmGyZFYdFcFAs5FNMEaq+/ZiQb+tR7CUz2XPB+LdfCJmVWaSXP18Q?=
 =?us-ascii?Q?slKwDbxgrp5sjaKyc98e0uf/VqI9hkF421HaBddXOU9S7tWHJP3oH8uwVvfz?=
 =?us-ascii?Q?w42RcNWiw1LG011zCewiTFg8l3XPqgumzS1ShnZMNR5pRSPaWIFUglpK5k1O?=
 =?us-ascii?Q?JrwZY0bRmzEE7purzhZswDHC/gxelZDYsIfqMS7huwugILUCs+lFnc/yvX39?=
 =?us-ascii?Q?ZCKsDkMtrE/3oGhhFBsOdcik6GEFkZwMfdd7tAIuCEO7zBkCPz/V5vlqIRZm?=
 =?us-ascii?Q?dynCxBahpb0jfOFwpAHM3Gfq70c29mpwVZBF36kuOiCzdvpMyux8K9GMNjXt?=
 =?us-ascii?Q?lCkdyA/yWcdf+n7HAP3aHFLR4rWQRX0mSfNq+6EGcrrhVhBTOfzRn3ZKGTjb?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546f6b2b-2ed2-463a-e0dc-08dad6d41cf3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:19:33.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdcfCpLQw7nP5T+lHRYUblsIrL9l276xV9+XBefHV+CMXqbVj87TtqJXuc3KShIcHxgBzyoum/r8aNQSS1I2cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8814
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

Changes in v2:
- Fix building on non-arm platforms

 drivers/rtc/rtc-abx80x.c | 87 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..e606bf126dc3 100644
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
@@ -673,6 +684,78 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
 }
 #endif
 
+#ifdef CONFIG_NVMEM
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
+		.dev = dev,
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = abx80x_nvmem_read,
+		.reg_write = abx80x_nvmem_write,
+		.size = ABX8XX_RAM_SIZE,
+		.priv = priv,
+	};
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(&priv->client->dev,
+						   &config));
+}
+#else
+static int abx80x_setup_nvmem(struct abx80x_priv *priv)
+{
+	return 0;
+}
+#endif
+
 static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -824,6 +907,10 @@ static int abx80x_probe(struct i2c_client *client,
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

