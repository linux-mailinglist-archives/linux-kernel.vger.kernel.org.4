Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DDE63FB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiLAXCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiLAXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:02:28 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348618E2A;
        Thu,  1 Dec 2022 15:02:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0uXwZzBUN25dPsewEZ2Pd5TsLvjOqwdgOepmwA4f0cqIdIHDUP9jR4Z1L2b+deEikmC2NX5UQU5U0/OmIsvFQLSPZBKztUEZ91MR8vZxUcYrNCntpobY7rekWKi0cxTLWacNSk9a+KMZA2Bv4z/yCgjCeAgEjv8GdhUKEUyWCOeF58MGw51EM95qFsESAp3dGvXUpY0v7vTGP4xiJ4JAOAQAAFn0PXg6MvBja0jqFe8WkT2jRX719buuCkvXrimP1GUS/ylMva7q7OHpwjF7qOG0YjO0PIV3CQea6EIY7X+HG0Uy/rjxuUs+FeS3MjCMYFVZKKlaNShPH8pddvqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uygglLeI2ghHDnOP863OfzhEiSSEE+coqex2NqCUr2Y=;
 b=kXgY/lJXsVVGKkHRNnwk56yVY9nvEAPQw3Ce4AhRyf4UJpaVMPa+0CCnaEx/0SoKAcIHfi8a5lNsqcBAYTTPe7bpDvEoZLeV+uzFmRELzC8VoAKXmLJTPR6seaWYFXtYecCalHGtmWNkxxoMti2f7V8JaM1Eimiiy5JyUrkAwDi8kld0KryFmo46+irCc/hEHnNZ/uVhE4q58VJzvRwe+cFxa5GAx1aNxZi9G6YROMbCfC+D8ZEfeSBDZBwjqcYxggT4DWJaTyKM1+/8AjBaNTnQlBB10WkE19EP6xNZ46dwefm2xMIp2PE9hcKrLj4MQ/JgWR6Wv/KS0wAYe/jOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uygglLeI2ghHDnOP863OfzhEiSSEE+coqex2NqCUr2Y=;
 b=TD6KsK4lW3j6oafGa6cI2sAeXWCvIOVVDC0XIMZHhRVl9c46S1NtliSqj+rVeTzU/qYVYb8jWTFNtyHugjfTgKl0uW2LY0/BG682WtZshpwD9nJRQLKT3DKeApge20Rc5lxo5IuJ5D2mG4gbKFRjXJAfn3cwejMXeshRc0wJpzM1Sm8w5vwsS10M83GIZK6voHjGCPxB9qPZPasBWa7qJgHlN2yGH2UL9Bkun5lg0sJjNmPu6OkQWt2YvkSZQcf6kRRfMTsmQl1TKVlg/+8XdDbflU9oz5sxGFGoaZgCV1VUKrMDq46r246+u8SXC+sI3H29LgUaO7nd6/lfNQtmDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GV2PR03MB8608.eurprd03.prod.outlook.com (2603:10a6:150:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 23:02:21 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 23:02:20 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] rtc: abx80x: Add nvmem support
Date:   Thu,  1 Dec 2022 18:02:08 -0500
Message-Id: <20221201230208.713118-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:208:a8::41) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GV2PR03MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebf2714-a1fc-4ff6-d96d-08dad3f018e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xsPRPbaP2vRzxgJb2NplEBTSpgLdW56/DR8LaqChBzPnkQoEXHBwXcn01iMLqKNFF88iTXknnzxxoSOoLxbWI/FoOAccgVXqWo1YGfFHfPyCBkCJfSYvpv4W2pWsGAH1dmxBXVryLfiP18kMETQk2R5ZmFXZNvaw27kA/tnL5jsCNRtwmcrrDn7YpXEfOWjlRBHdn8P7Qq4Rg8Z5cWqLOc8Bn6v5DV35ygdOCDicHiqWnfeXFXlRNvzsQ2rnSmt3U6QQjMLLYZQE1mHb+Shsp/9+Cx0OKt9iAAJvdmr+GAAvizyxCZWjN6fSuhi4mzeXHYxspU34KPEFfUhcflL6l7cUn3FoVTrpzVBKl9/gECpJFB2oQj2rOPeKnumjGqGqflATz9urzUiP1PDa/I8AwajoEJdpqny6G2RekMXJEObGLNCDhUoCh0jLECx15MXFyjAR1kA1Qn7LXZ1m7rekLiYYW+iR8l2wLdY9pLjHEq0SvstEmKM4yAiN9zyT9Txxxx2QLXRgvRhlnLc8lahNGrk9OKTOQkpjABNXiqJrgm2iXzbPeWRtjW3CJgWJyC4+IsN9v+FBgMK0jSxjT5M2asw1SM0dfWdd/E0iW4Xx5YYWTHyPMJ6sKolt4E52U/2rRfqdpRy3jrYw5UFewBWnyIuAHJxBOSRxjAd9WUsyXWjL9kypC6gcXCXXfNkKvJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39850400004)(451199015)(6486002)(86362001)(6512007)(6506007)(36756003)(6666004)(2906002)(52116002)(478600001)(107886003)(38100700002)(1076003)(5660300002)(2616005)(38350700002)(186003)(4326008)(83380400001)(41300700001)(26005)(110136005)(8936002)(66476007)(66946007)(8676002)(44832011)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VAkT4ic0BEcLhjFtIP3+Zr/RvxnHi42JGEMUujGfaKO+1gdQGy6RchRaavL+?=
 =?us-ascii?Q?FScIGSxyjGZZPM5M3bSZF7hlcUA4y35BtsUMSxpenwAnpIz9LRjHr31KvsFq?=
 =?us-ascii?Q?6tAEIzFqyoKn3/yS9x46PUdbOjQn8f5/HcidxY/V4RnjyCutkuZpE0IC6/B3?=
 =?us-ascii?Q?EluIT8P00xr6BQe+A2EiSXb7qmiMPwgchTGG12nZNsmDnESC7MaXpGGvaUug?=
 =?us-ascii?Q?M0yLAvUANZtwNlGpzPc4b9aiAQfwIK1Bit8ZozfLZ+7Qxep6lPQ2hNsQa5xs?=
 =?us-ascii?Q?FoP5HForesDUp1wfRdWW0z9dzlEZGAORKQLhi1eaZkYkFE/m4jz9khs3SWF6?=
 =?us-ascii?Q?zuWiQvBKssgcBRB1ksAWzojFBk2iWfmR1WdcaZz7BNUBh7WNp7tbUUY5Qkg8?=
 =?us-ascii?Q?E81z/TgVrXdWYL36R35vv76H6dF5GuBlE8qNJCXbS3uAnpBHUO2UESxCjB+H?=
 =?us-ascii?Q?eqToANMruOL/nicqhcrvBwDHporkfgC1RLm8hdWy68m27jOpFaWMhEbHvi7x?=
 =?us-ascii?Q?xn6N3lrT02qTvqYKvCqNZGgysNbT1rzbt20dGZASu9S0PnzjR8ZSAy/GtqYM?=
 =?us-ascii?Q?zcdP7Qr4pUmnf7yiX+4vyux6VcOIm/vHj6lKPeo6U38OJdGMBcY96trleMhK?=
 =?us-ascii?Q?HzEkVo4KkX5NZVKQqBtqYvXkPIS9vcwH7BUREZlkyjQD0WH7MJScgk8CRBsH?=
 =?us-ascii?Q?B6tDTfKKv+HXNhWMxoTF44JKMLEXvu8lvuZkotnVn5AbJUJjLmqZme2Q4fPX?=
 =?us-ascii?Q?ldcf3HHoGsCi6ZZ5F3r9FI6wKjdRLaWzpClbwKEbTrwkSGrIK7QQ5YDCB3rk?=
 =?us-ascii?Q?nr91i2snbN4L5312brZnkXtR8SkWSTRrR/nBGgzFuq9A72LyJZESDGYRWx0F?=
 =?us-ascii?Q?V9aZ21s0+VdmHIgHuZixomDVuW/9ehldlpcGQS4qhzwRykSzT1HLcJ7+Cutq?=
 =?us-ascii?Q?NhLXqUsOWsQ0ODorRBQDIBlV2lDPZvKwTyauz2bEWSCZS5oif2SAaaIYT2+l?=
 =?us-ascii?Q?bJECXZ7A6KqQGWSx02Q01AwnDVbQ4QbeOAYgFRSUdXGdpm/FM7oLroRE/cVZ?=
 =?us-ascii?Q?oOq/FM+Vbqs5HilJCck8w4QJCZTsLGlU3UNgg/C9vCj7DiEEusmtwSjGQQHF?=
 =?us-ascii?Q?8r1Ml6+n7+Mw4RvC9XkdBOpe/79rr6IbhY1fBdbyhiwd/TvJ0ZiCqbZkz/V7?=
 =?us-ascii?Q?9rTb4llYuU1YgzoxuOSbklXolv95I50+n4cD4zLtQlAJpPRBL1kUtjh2V3vC?=
 =?us-ascii?Q?VVvXArEVt4L08xY0u2pVBC1RdFGwzcsqRFUTQFAjfNCW48AixIM0OdFgUDM0?=
 =?us-ascii?Q?TPR0xX30U+g2aA3Xb20w+aLQK0ngjkeswYgLuQpMk2k1qpADi9WD68EwJFEc?=
 =?us-ascii?Q?xvpJyLA1SDhjO4gQ53kmSvDIet6WlxJq/If4vh53YvwxSWmTFirqoftk79tk?=
 =?us-ascii?Q?JxTSLThbV07JYlmWwUg8RaWNiZBZYVIbpNLXxlRGd0b2xWH0PqHyg1o67+XO?=
 =?us-ascii?Q?nbzI8uLkHtd7800SymIJSpFjVdxIQqU4iTdH0sUpy6Mf6eMCbwToEy1r0nPA?=
 =?us-ascii?Q?CEudS83zGHeUejF++sLuZi+4An9C2iBd/+sgiQ4Dja1U8VnWrizuSL/9xIwF?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebf2714-a1fc-4ff6-d96d-08dad3f018e6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 23:02:20.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN1bZUvLIcJBwRgyUfsSc3hfF8qb410xkOCGGE5cokZI2oSbg/793A9Nf2i3S/7/shcv0Ai53GpKSUqeQeXwNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8608
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

 drivers/rtc/rtc-abx80x.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9b0138d07232..6e4fadbe7a80 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -87,6 +87,16 @@
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
@@ -673,6 +683,78 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
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
@@ -824,6 +906,10 @@ static int abx80x_probe(struct i2c_client *client,
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

