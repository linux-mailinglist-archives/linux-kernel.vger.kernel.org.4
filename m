Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A26F7FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEEJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjEEJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:12:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B449191F8;
        Fri,  5 May 2023 02:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK5TgYDFrnOXqe27lVtWMBApjO7gpTtMgisPHSFC8JtHc7uB4oyyJQYB++EErrCAU1AcPJWpzQ64qElX7Q7VwU5WrZFE872AytO6asW5joqDq2hkARx2A649N1ldfBay2jxx5bqqoRhqWdzSen/lQ6zQ02I2nxnmjJJHMABALPfXzVBVy05JxF1Oqc/JbXaI/nIOkC8p0ivS6BxS8K7A0Mb95J7HiixkyiA03lWAr/jaQvf+YnRm5klCmdc62/JttHp65ZvevA8j9CEHy3nZUvQf91OOJlXovxC8iI8xSWvt8VotGNzSYWENKa8xH5HEjduDQwslSPU6O9LmKWbadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQpvwvMEt/w+CxaW4UdaMomVOJLvxjcQAfzxgjm8Ss0=;
 b=Idabf6mr2WCYhMg4cKpItgqhFlxp+oZBQWRH7RDaOy2GNQouqIKgUSuIzsN426/nm258CF/RzoGVVJ8lrPxaEKjP1TJATtaxSHgZFTX3Cke0S7/9XUTm15AvxWgsyVhoJvnoXi08GJAgp6EMlxbtt7AFJyouIG6DpkezD/7iUow9xPXu7/yid3QlyHgRXvW6crPFbznrukcgHxM2r6nFP0nECnDOOMEdAO6Z3CLhSSuyh3jKnlP/5eJ7/AihQ8SoHQZRdBYInFe4oQVL96EruKMlWQnxq58AG776zTlG/MpTh5+m96J9ijajDdj2E95pyS4+fmqrNCGT0/rCQG5JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQpvwvMEt/w+CxaW4UdaMomVOJLvxjcQAfzxgjm8Ss0=;
 b=OtSCy2xR0kVYM11oET7U29tIlQlYt/ao4zvovD8KiomsNg/a2lAxI3hP/FU4/wKmulSE8o79cmONh+xewVNW2v3cVpLzlBtrTCDhvzM69RNQg7fcW337aAgYqje6bwNbIhN5BSPcJB3kAR5ibuvoDGNk3uPrs+OZmXmrd2mkz1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Fri, 5 May
 2023 09:12:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 09:12:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] nvmem: imx: support i.MX93 OCOTP
Date:   Fri,  5 May 2023 17:17:33 +0800
Message-Id: <20230505091733.1819521-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 967f7cc0-31fa-4ab2-116b-08db4d48e137
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKNTQSlvs87Jd1eFnuNm0U3layP2tixKxjw0iBqg/HaFQ5dzBG9nw3qiZixXJgox8lm4DrJm9LZr4hcfwteRtcm45OpKDTIPM2NxcKvE0CJbH95skZrqOi4J4DJ77XaUJ8Xy9dMAQhEy17M7+Gb3aXd+n8R5STFvewxFtLrPm9G2ogwR/1nRb63rQjU9UqP35oWYpIJyk0Mfrv1owlH5KA7mSJpsajRAug3OhGbECyG6wvTCble+pe2JomgbnPyVrEgXPQZ48uWw21mQ+J0Mla/PY01BH+zRaCwtYjtyDNUAav198Jc4zC6LfxO3bMrqsQialFX5UkDQ4zYbv6ZqqLap6gHPkvVI6gPBTS1bGurqZIaK+rPGkdrZksF17yfjYvPZzkHmUepyNkC7wUAeoB6a0i1bHs8CGEa10mKZk/bfYFTeLjAGV/8U8SYxIx8UJrQCQsdUwIw4J0npFtVXRpe+m/Vpw/NnYbbn0A2O+4X7i26CVjtDoSMNmd8y7CbGADAgIaCLYcZ15fqPq65dg/hjR8PsGrfzIzO8HoePLkzDSExET05GWstR9mxhGv6m6fVGp/0L/9PIRZVQiZv7VhtBheXEi2zIun86502wlxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(66946007)(2616005)(478600001)(83380400001)(6486002)(6666004)(52116002)(66476007)(316002)(4326008)(66556008)(26005)(186003)(6506007)(6512007)(1076003)(8936002)(8676002)(7416002)(5660300002)(38350700002)(38100700002)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YPD7Kc7Ra2C3l+x7WZcrYivUkyZZbZNlSPlUCQoKt5ltrNopYjbA+gswSppP?=
 =?us-ascii?Q?QKIdsmryPIxvhMvNhEPWhavYU/QSLh2rJoueSIA5ucHlJqr162Qw8KzrTfiE?=
 =?us-ascii?Q?TTPum7ya80w/rBYGNTYR130BQr5xIXha/e2Z7U7wYSr9siRglVN8dDz8fMO4?=
 =?us-ascii?Q?PkJ4XWJrW3F+76vv3+80iLxV8fD78kO8/CIKmIGxyhmEetVTTwGAmIPGVUJT?=
 =?us-ascii?Q?W7S0aBfjK88jsZel/2sIYY7bqVQ1f2MXXNrjR/h1wDZwX8Y5unl09bWGhdWT?=
 =?us-ascii?Q?R96yw5dcZ9ELZi/ZnZRE/I60LUU7OsCTn3L26jXunoxbEJAIxzqhogKKIHQM?=
 =?us-ascii?Q?QKgkAliw7O7kzzrPC5i4cUdKiUkPX8j7fh+YQMKlI88WGGVl0JbG9pQgR+jm?=
 =?us-ascii?Q?TRo0sSbDBejBWwj03vlAGjrJ2NC7gP5h4v5jTGLhsPHq58v7O8rG8h4q04ol?=
 =?us-ascii?Q?H4Ovs5TKmyN6NGkjysYHtVZIrEctfafGeLDnAjJALNNKc1QLvNVlxC75xvQs?=
 =?us-ascii?Q?T+36NqpN2TkL6wTdnu2hc3LX/ZQpWhZxMrLn0YIwFityKcR6zyfDuHfl5IF2?=
 =?us-ascii?Q?7SBW10WD4ehz3I2fImBxwDUt0+3kVb9uLxyKAtwh7euNP5PnZCnMAREk8zlS?=
 =?us-ascii?Q?GJWUFQ2VPx/eqnlePbGr8MJXYOXdK/JzYLW0k8p99/04GHFnrqHNa5KyIPB/?=
 =?us-ascii?Q?4kB+Lk5bMYLfOOnJLYZh2mnOcDywFxuV5WHYXPBzsTszEaSTu0ExLHqluazS?=
 =?us-ascii?Q?XG7mSpG/OcAO6erWNuqVrhfSt7ov2zfbiz5GfTU7sL/RZYD3/S66YqwSm+nC?=
 =?us-ascii?Q?cAJomUCEPCBjtpTn+CTolHdyLi7q1Swsra06fysCxGoyN9HF9tVY8cLbnExT?=
 =?us-ascii?Q?p1PPsrsVVCU4ZBJUlyokKGiJl1OJaATDG6U2LLX3d8iuC/eWjYz1To+mco0y?=
 =?us-ascii?Q?N1tgaFd3KKeBpV6dUaJWroXaCuYBn6EYAI3TMbzVNgLfwiWzLbCMogQCckyN?=
 =?us-ascii?Q?njIjiTtLB01HZ0YaOHpLUV2ogNrKw0Uz7cyjGfqEFqRyqdPdBvrjGBCBWlT7?=
 =?us-ascii?Q?uYuf40jy6obBMCQh748XUAS2yr8C3M8hn0cr/6NY6gFAbL0DH9B0siv4A6iK?=
 =?us-ascii?Q?ZjIjs2WksDDNnR9bymSyJluNFmXcjajybV6updyCBYR8LbLeNQsaFQldoeW9?=
 =?us-ascii?Q?OCDC1aLgvyJqAxpUx5k6EP+mSS5wNVKGKiRVi144SYWLlsJy63jz5POx4Y3r?=
 =?us-ascii?Q?xi1B+vQvrvpnUZIxCxUrPQ6niyPdr4N/AmnqnrbccLjJSM/MMDafNBVNiIJl?=
 =?us-ascii?Q?tN4VNdwcN/t+5z2qHSL8No6omRneuFTO8EnTUICHaG3ydWiiV6Emsh5F4a8z?=
 =?us-ascii?Q?SMgjNuy43Qg7QiwBSuq92p7vRLnHnka9QVPkeqWg6lH8wdKPdJwR52dMeM6c?=
 =?us-ascii?Q?lcK9dtlSIlIAa77MJoizqyEwkCXnFzSC8iatYWUBJ+kNM4OTjiBAs0wxLykr?=
 =?us-ascii?Q?bGzr3LEOxfPQckOf/BH/DJRA+naGFa3V+ATrlSTnwLB4xt8WSQRmvllaqB2+?=
 =?us-ascii?Q?bOGKCJW/VQq7GKGZ+VEFkVn0rge2L/AkmbbHGzco?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967f7cc0-31fa-4ab2-116b-08db4d48e137
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:12:41.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc7HfBHgiiNBOZ8S9WRcgahYYZgqCShDOzmqU+iuTGKE2N7axn7TOZane7G9ZvDtTP8B/JMMRlEMMU2iLKEcvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvmem/Kconfig         |   9 ++
 drivers/nvmem/Makefile        |   2 +
 drivers/nvmem/imx-ocotp-ele.c | 183 ++++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
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
index 000000000000..a8d2aa7488de
--- /dev/null
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -0,0 +1,183 @@
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
+#define FSB_FUSE	BIT(0)
+#define ELE_FUSE	BIT(1)
+
+struct ocotp_map_entry {
+	u32 start; /* start word */
+	u32 num; /* num words */
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
+static bool in_hole(void *context, u32 index)
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
+			return false;
+	}
+
+	return true;
+}
+
+static int imx_ocotp_fsb_read(void *context, unsigned int offset, void *val, size_t bytes)
+{
+	struct imx_ocotp_priv *priv = context;
+	void __iomem *reg = priv->base + priv->data->reg_off;
+	u32 count, index, num_bytes;
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
+		if (in_hole(context, i)) {
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
+	if (priv->data && (priv->data->flag & FSB_FUSE)) {
+		priv->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	}
+
+	priv->config.dev = dev;
+	priv->config.name = priv->data->name;
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
+	return devm_of_platform_populate(dev);
+}
+
+static const struct ocotp_devtype_data imx93_fsb_data = {
+	.flag = FSB_FUSE,
+	.reg_off = 0x8000,
+	.name = "FSB_FUSE",
+	.reg_read = imx_ocotp_fsb_read,
+	.size = 2048,
+	.num_entry = 2,
+	.entry = {
+		{ 0, 52 },
+		{ 312, 200 },
+	},
+};
+
+static const struct ocotp_devtype_data imx93_ele_data = {
+	.flag = ELE_FUSE,
+	.name = "ELE_FUSE",
+	.reg_read = NULL,
+	.size = 2048,
+	.num_entry = 4,
+	.entry = {
+		{ 63, 1 },
+		{ 128, 16 },
+		{ 182, 1 },
+		{ 188, 1 },
+	},
+};
+
+static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ocotp-fsb", .data = &imx93_fsb_data, },
+	{ .compatible = "fsl,imx93-ocotp-ele", .data = &imx93_ele_data, },
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

