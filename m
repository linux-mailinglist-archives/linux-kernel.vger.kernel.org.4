Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEF6FAE4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjEHLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjEHLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:43:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842F3F569;
        Mon,  8 May 2023 04:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP+3T0ywmUZGWUHdELIZnEXTYxC6va1H1Eobur/Rf/RkBI5WnPfk0DohyzOplWTuzCQE7b7CBjSebiEI1n9Eo51bN2stizk+UxfZDuT5C6Y+3A3IOu8vLhm4ADW7l9efYDgEWAkUiCH/r8IgKgYTogjy4km7qc5Qx/xo8OcnHwZeWBwYI0BHk0PR0v1RDYFWlngEGqee/4f189oanGNe/1ruhMCr8g2ujoDxqaLCpSJH5p4NOfBA2qjxZv5sFte1qEJGiBEawHQhV0TEqocuCqt/MTc9UrQM4vgqMMOxSmQgmVKiqAE5YaZCFfQkQjEJg/QaIdVCMWHG9TGCZsx0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BESdbA+ftKcmQzOFH2sjQoMOdZz1HRDfUt+9L07uR4o=;
 b=EHkjSR95yxy5WxkoAElEvfC+iII73pZs0yhHAn2JO8DWqm4NR5J7rRyFllKH45lUq8B4mvObxuGnbQHGlWpI1iV6LvyV0b0MO791MGRrlZ/2cTc2M8Wx68/Z89tHpmki4JySmZ39mV4yEq27aAcPl/2+z6todgOJ4TA0DRlY3tAyp61nWX7QgXF5z8qsU8clfQryYNuGXdyONWWM/TxP1w8h1JtzhObEZCAJD75pb2dlfb3y2NX/w0SeqtVE82lLJWpF+FQyE/URitFy7tAeRJSa5hoEOI+9m9+nwe+G8s8mb+MgV9pkssLBOI3yumOjih0T90WxS6SuFU2VZC6AFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BESdbA+ftKcmQzOFH2sjQoMOdZz1HRDfUt+9L07uR4o=;
 b=El9dNY5KB3gHnseZxaMhuyrVUGO0DLx48iT5OjkXIo3cI2NCf/5IB8BKM2yxVynClVsOI0Ji6R3EQrN+8MWwf9Gee7GMNVYjrTwQbqEdMAwOC4HcZj6F+3YZcNLHn+c5Zv8VwicEGNur5BDT9XVhH7oUz/3vfcZLDADBk0hM6tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9632.eurprd04.prod.outlook.com (2603:10a6:20b:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Mon, 8 May
 2023 11:41:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 11:41:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] nvmem: imx: support i.MX93 OCOTP
Date:   Mon,  8 May 2023 19:46:39 +0800
Message-Id: <20230508114639.1525521-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd24e4d-1d25-43fb-37d2-08db4fb933b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYxh9DQuSBnHcloiSFVrxpxmAqU2VnysdiGAAPMbhtpN+Z2hOkLCj+GJjv0HK6KsBWejhkzP6uomXBzykDeYt/9PLWEDCAWUU2Drb8sL1VkOY9GT+HCmPcy7JIAkEzh4M8L5XzF1uWq9o0OToZHkLQTWsi9RjQ1pb4x2BpjJcZdN4dun+v+ntS2L7jhjIoHsNipPF4kwjVf8FnjLWno7hx0y83h30CuGikq5tUJA8EPCy4YK7SVTdRm3yw4X/cDbV8yHvms/BkDWKTwtGdU9OXcQzpqpQLUdBIuFBFlEp7FCYWfMAZyIfj1apu1Lke17GplzSkOPGiYqHbsPqiCgVVvwuyzkuLhVSS618KNZsAI1EC3WwTkga8/ft3rzsRM+fuuWSugsvSVNDsXdWFtNc5Qxw/am0Faye37JgGSrdH9NtsWr+rTCx4jwLf/8kcQhk/AxqH8yXR5Lbo4gaMXhwaA9d2hwckLLi91h0dhy6ZuE3tzwQKwbJKoPOCb0zq6t5CNBHqKoe8h+IZBIDdt+PgU6Iqaig5aXpm3a8n7efnsFZIrLmoZm4T/a3KP5aNqQjod2i3FuNL63A4uR08Sw6GTp8yoAHWBGgmg1qnFL2vcIebWHkyUtLZfnHO/UcoCR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(83380400001)(66556008)(2616005)(66946007)(52116002)(6486002)(1076003)(66476007)(6506007)(6512007)(478600001)(26005)(186003)(6666004)(2906002)(86362001)(5660300002)(7416002)(38100700002)(41300700001)(38350700002)(4326008)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfnVM5nWa24UdKvMlBYwHTachh5aXdSz/xMHgg4xj6GGRE1iNge+HzpnN7il?=
 =?us-ascii?Q?AuaUpxLgCvj7EX0UyshKofkQnhKpi7I3+A61yqQo9v5F55/aTYOuAfT8CoB+?=
 =?us-ascii?Q?jVO/+w86lMcbRyMbL4lGc05mdgWrbBpsQWnmRnQvvXVnqI5rLO9w7VHURNom?=
 =?us-ascii?Q?JxKF9HbajwYUmnJ58VfAWOaN3Gyj2mk+58hkCPbgKT6jHkyo0Ak2j07I7/fF?=
 =?us-ascii?Q?KroVBHGdHFI0HOEjr2kSwc0Fx7Hh2H3BtVSNCAH3W9jxepUabpT754E72d/t?=
 =?us-ascii?Q?H2vu5fvBDjPgmzU8GDk1SIcArWleN595FzLAtO0PXaIokXgXtXLdxRpRvlVY?=
 =?us-ascii?Q?taAgpWPIdsmwMWxKM133Nk+1r6gwGKiieXbgY7dOZewplbLGV9SGgYhIZocu?=
 =?us-ascii?Q?fD9+6+KIIAfwNCOupeG86Lb5AQpGngJYb36LxYrUwfUFQkoXuZ8vJTxI9uqX?=
 =?us-ascii?Q?8BT8uadl73x22zkW9fYxzNlQpup9jNs7QSTbvoT8Iq5SSJv2xRFAyyAJSqa9?=
 =?us-ascii?Q?pWLT6ZWNQNDSwIsYXgJ/eLYdJV69isesKOO/7KR3m/Ydg0UwGZJydoYg0HGW?=
 =?us-ascii?Q?X9uRMzruOq6RIy0SvFly9nnd/n6+mYCZunMNoNV2wYrR4Jq4Hzze1bsvcnbd?=
 =?us-ascii?Q?KyuoeXkl5E+fQlU9wZkVsKVtNnbvIFrTVN2ryxOFJUdRMm6MnqUQyZ2G/uiK?=
 =?us-ascii?Q?20JnpoJQ7h7mSRHbXCmIg0i3hzOQJaMZjXrbiDe2f00wIjBKxa19KoteGt9x?=
 =?us-ascii?Q?P72pkkDYEHjqHVdP1OyhLQViY6v1RKY3ahSqkUXiHZxupdtbCbnaKviL4CY0?=
 =?us-ascii?Q?j1DRii5xnwcoHW/CQH+PffcbkOssdggFKafXdakVxAxDJ6nuYIzhwVg78cAN?=
 =?us-ascii?Q?CK8qxb7ZvbSY2KaBeUlZsocT+P48YazKkt6BkyaxwiWn57P0i8zB07WxLyg3?=
 =?us-ascii?Q?W1/d28OBnG0XDA5Gikh2YSaHWkTOu3sisET9Hqs3fyN9MmmOiZMOrb1EmzwP?=
 =?us-ascii?Q?A7+2PakDXx6cbykjOBJWEwnkxZyVNF9sGaCQXjhBdmaxMpd0CnLp/o9xFMQi?=
 =?us-ascii?Q?FvryHpx+SRkD79+o7nJDWAOGJWGfl2HnVPfZeQnPs/LjP/bj7SQyPQ36kyDV?=
 =?us-ascii?Q?FOKHyhccnKZkfgQZVPCNPTaBO53HN6EBwJ6PmKLWc0Kljfnz3AGFSvLbLxVL?=
 =?us-ascii?Q?x6oh/prGSsm3DIXTGOThxYRt22d1u4CxYeB0KVxxC1ZVyLj+5+wP4iFanD4V?=
 =?us-ascii?Q?5YDGPEIuG/Sao4hfO6r5Lc+FrJGEEtakqSHuwY+Q7kv65bZS0ZYoaU7X+I+i?=
 =?us-ascii?Q?QZF321naxIhs74J9tBG85tZFTrXkHEISTgGrcLWhdmKEMfwLL70/pHBH+tU/?=
 =?us-ascii?Q?T3VYwskaiNH/loS/pcvWMaUO/F1mUVkhO+GRPvVWwKJzSxLuyzMvyNy5WVov?=
 =?us-ascii?Q?+kywcEFitbynMAnXqN4VfkY7/EBNtnJx30SoImfjjrw2q8Uw7CZ3ea9OsmRC?=
 =?us-ascii?Q?JIQ2sJyFcMtpRL4A1e6G70wRuOnvJSJGJ5AmXIqp+UFcuslHgPSG1bGrpTND?=
 =?us-ascii?Q?xzdi3xgC9fGe4mgeNcjbSPNUvnD4G4QZgbb82H9C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd24e4d-1d25-43fb-37d2-08db4fb933b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 11:41:45.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL2lmmY4L7ofryrsXlQIaE16xLFRcuKmmxmX0OoQH1HT9T4f0SPeABLeBtUa/RXkL7CnrpJP/W70R1kiPX1Kpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9632
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 OCOTP support. i.MX93 OCOTP has two parts: Fuse shadow
block(fsb) and fuse managed by ELE. The FSB part could be directly
accessed with MMIO, the ELE could only be accessed with ELE API.

Currently the ELE API is not ready, so NULL function callback is used,
but it was tested with downstream ELE API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Merge ele & fsb compatible to use fsl,imx93-ocotp

 drivers/nvmem/Kconfig         |   9 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/imx-ocotp-ele.c | 175 ++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/nvmem/imx-ocotp-ele.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index b291b27048c7..e7093726b28e 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -82,6 +82,15 @@ config NVMEM_IMX_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-imx-ocotp.
 
+config NVMEM_IMX_OCOTP_ELE
+	tristate "i.MX On-Chip OTP Controller support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  This is a driver for the On-Chip OTP Controller (OCOTP)
+	  available on i.MX SoCs which has ELE.
+
 config NVMEM_IMX_OCOTP_SCU
 	tristate "i.MX8 SCU On-Chip OTP Controller support"
 	depends on IMX_SCU
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index f82431ec8aef..cc23ce4ffb1f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)		+= nvmem-imx-iim.o
 nvmem-imx-iim-y				:= imx-iim.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP)		+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y			:= imx-ocotp.o
+obj-$(CONFIG_NVMEM_IMX_OCOTP_ELE)	+= nvmem-imx-ocotp-ele.o
+nvmem-imx-ocotp-ele-y			:= imx-ocotp-ele.o
 obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+= nvmem-imx-ocotp-scu.o
 nvmem-imx-ocotp-scu-y			:= imx-ocotp-scu.o
 obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+= nvmem_jz4780_efuse.o
diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
new file mode 100644
index 000000000000..af9ce0ce4792
--- /dev/null
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * i.MX9 OCOTP fusebox driver
+ *
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum fuse_type {
+	FUSE_FSB = 1,
+	FUSE_ELE = 2,
+	FUSE_INVALID = -1
+};
+
+struct ocotp_map_entry {
+	u32 start; /* start word */
+	u32 num; /* num words */
+	enum fuse_type type;
+};
+
+struct ocotp_devtype_data {
+	u32 reg_off;
+	char *name;
+	u32 size;
+	u32 num_entry;
+	u32 flag;
+	nvmem_reg_read_t reg_read;
+	struct ocotp_map_entry entry[];
+};
+
+struct imx_ocotp_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct nvmem_config config;
+	struct mutex lock;
+	const struct ocotp_devtype_data *data;
+};
+
+static enum fuse_type imx_ocotp_fuse_type(void *context, u32 index)
+{
+	struct imx_ocotp_priv *priv = context;
+	const struct ocotp_devtype_data *data = priv->data;
+	u32 start, end;
+	int i;
+
+	for (i = 0; i < data->num_entry; i++) {
+		start = data->entry[i].start;
+		end = data->entry[i].start + data->entry[i].num;
+
+		if (index >= start && index < end)
+			return data->entry[i].type;
+	}
+
+	return FUSE_INVALID;
+}
+
+static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct imx_ocotp_priv *priv = context;
+	void __iomem *reg = priv->base + priv->data->reg_off;
+	u32 count, index, num_bytes;
+	enum fuse_type type;
+	u32 *buf;
+	void *p;
+	int i;
+
+	index = offset;
+	num_bytes = round_up(bytes, 4);
+	count = num_bytes >> 2;
+
+	if (count > ((priv->data->size >> 2) - index))
+		count = (priv->data->size >> 2) - index;
+
+	p = kzalloc(num_bytes, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	mutex_lock(&priv->lock);
+
+	buf = p;
+
+	for (i = index; i < (index + count); i++) {
+		type = imx_ocotp_fuse_type(context, i);
+		if (type == FUSE_INVALID || type == FUSE_ELE) {
+			*buf++ = 0;
+			continue;
+		}
+
+		*buf++ = readl_relaxed(reg + (i << 2));
+	}
+
+	memcpy(val, (u8 *)p, bytes);
+
+	mutex_unlock(&priv->lock);
+
+	kfree(p);
+
+	return 0;
+};
+
+static int imx_ele_ocotp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_ocotp_priv *priv;
+	struct nvmem_device *nvmem;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->config.dev = dev;
+	priv->config.name = "ELE-OCOTP";
+	priv->config.id = NVMEM_DEVID_AUTO;
+	priv->config.owner = THIS_MODULE;
+	priv->config.size = priv->data->size;
+	priv->config.reg_read = priv->data->reg_read;
+	priv->config.word_size = 4;
+	priv->config.stride = 1;
+	priv->config.priv = priv;
+	priv->config.read_only = true;
+	mutex_init(&priv->lock);
+
+	nvmem = devm_nvmem_register(dev, &priv->config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	return 0;
+}
+
+static const struct ocotp_devtype_data imx93_ocotp_data = {
+	.reg_off = 0x8000,
+	.reg_read = imx_ocotp_reg_read,
+	.size = 2048,
+	.num_entry = 6,
+	.entry = {
+		{ 0, 52, FUSE_FSB },
+		{ 63, 1, FUSE_ELE},
+		{ 128, 16, FUSE_ELE },
+		{ 182, 1, FUSE_ELE },
+		{ 188, 1, FUSE_ELE },
+		{ 312, 200, FUSE_FSB }
+	},
+};
+
+static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, imx_ele_ocotp_dt_ids);
+
+static struct platform_driver imx_ele_ocotp_driver = {
+	.driver = {
+		.name = "imx_ele_ocotp",
+		.of_match_table = imx_ele_ocotp_dt_ids,
+	},
+	.probe = imx_ele_ocotp_probe,
+};
+module_platform_driver(imx_ele_ocotp_driver);
+
+MODULE_DESCRIPTION("i.MX OCOTP/ELE driver");
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_LICENSE("GPL");
-- 
2.37.1

