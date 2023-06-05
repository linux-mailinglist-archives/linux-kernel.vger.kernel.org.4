Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38EB72278F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjFENex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjFENea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:34:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B2E8;
        Mon,  5 Jun 2023 06:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBiJNhIoR9Jy4EOlbZ3uXaLNux4QzFMVH9ts8VVfVtCUUJvgnU5xFaaUSsUkLksDIw8HaDrjevNMAuI7qTRyoltFLHO1+sg7SUIVeazX8HFfeoLHQlqWwtVlrjeNFyR9QWVqOtZEzmjJiLAPBR20usZy7JJEPJxCpOqKFQmIXs4PRlF1FQRgf4cgxdHwYFlljCKgVZWTtU0xwvhtc11CY/BfifG8kaFnRBJbrUhPp0e2TwsG6QFNTcTCWe/WSDnoojcIBFELS8YtLNLthQ/FHe0LfHYM+yqNTbvScQeL35TWdlXEt8uXjOh0kEGMY8BTef51yttVN6o4oqAkXtJIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ61PGA2AClj9yS1c3hiobXhiP6mUloFqFvghw2TFyo=;
 b=WpbhdGPkvgT4OcL8HvWigwFSIjdcD+DknW54mMrUJHb01PZMhfYxL1T6CF/1lPm+ijiKwdWjTXT0q30fEq2OBEY2GktKxLaDYO/F9wkX1yN4+WxiT+aTCQ9UUl606B+5uWGfkzSqT/7o9yT9WPWjX8kifV8yr9G6VK8SOBiXyF6ZupI5USw6rNSiQ84ZKpbLc0Ww7qwI8drq8Z/XC3B3bynVp8lvJSyPyhHdgcIuUKvZiKPLsaOmYzGakBkIyabblZtLENK1IKUehdIkETJffPy37PFmjr4jkT2+42IjaF+bHmsk9wod16+BmMEZCCMK/IUJ4Gqk4nXnxHUf33j8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ61PGA2AClj9yS1c3hiobXhiP6mUloFqFvghw2TFyo=;
 b=HcSBGBGapcc3nbXV/HkCD0Py2cm68ccjYKnXNdnF3kMoYzGu0ma7EARqiVMvT5KyNWZ9WCBccCz/9LOPJtfa4ht4BcpOcTBp8ChXSxY8s1fAggfeY/ukWjH2hzj53PAk+GuQZNVTVtdjH1NywwzrKoEReV1rBgHci9JOnwJYChdKByC+ik3PEyI1D1qEpeCOzatWubVSW1RZHTWHyBWXMYKgmh3wjurbaT8Wjcw+Bc99h1PI860DBF3Z14r9o0NU4Aj0hStGhZHRAp+MY8mDrm8MOdTDjRBShBi1RW1E/ePVQUmj8bCoK0LYcaTgOwLkc8guGjdoGyj02VlcSv81jw==
Received: from GV3PEPF000000E6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:1b) by AM7PR04MB6822.eurprd04.prod.outlook.com
 (2603:10a6:20b:108::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 13:34:23 +0000
Received: from HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::208) by GV3PEPF000000E6.outlook.office365.com
 (2603:1026:900:3::f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Mon, 5 Jun 2023 13:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT044.mail.protection.outlook.com (10.152.0.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.18 via Frontend Transport; Mon, 5 Jun 2023 13:34:22 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.55) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 13:34:21 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM0PR04MB7060.eurprd04.prod.outlook.com (2603:10a6:208:196::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:34:18 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:34:18 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] clk: Add fixed-clock-nvmem provider
Date:   Mon, 5 Jun 2023 15:34:10 +0200
Message-ID: <20230605133410.15076-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230605133410.15076-1-mike.looijmans@topic.nl>
References: <20230605133410.15076-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bc47089e-a980-4211-bad3-8966176cf36c@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0224.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::31) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM0PR04MB7060:EE_|HE1EUR01FT044:EE_|AM7PR04MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: c93a96f6-065f-4da1-e86b-08db65c992d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CY/yvrqTKD9ZlM9d9fzwgy2K0COMO06vrQcBfIIhTu8PKaiim7NazP2/G6SztG7TL1GCKvDblXd+GwgITP4wxwfChYUQuWPJit6/ld9kSilUWN49+IP34e7hSjzQF3km7mJWuZ/WzeD4muL0gePGIH59FDIhXgY71n+GwPcz0b4ccK4f3OkIPBLL1JyTs7FGNfMLFafY+V37CBsrgqhxR7C4XFLn7STmBcolqMXmTu1Ex7mjee+kv5lOAuOEIFiLgzu1Sz05TrQZDSrGcXtkFlEpP05Gc9RyEuRVSk43j6dk6m8lOmOCmwbkEj+GrOh0F9k45b9ASyR6nPxVoJGgIgy5+AhS3HBoviZUYfkZztL5EgsSL3O1aE4DsVW4Za6y7kY6ivoND+fYDWlRWgKFKpzaV8LU3NYv4gz2ixeTKE4eUR4PXk8Nnj7sA6Nds4ifS8qNm0qMYI7swSOkEeG5V6zpG0IoW5aWmbK+0IudCELzadvUryBbQjqsmxzKf0jFlwGJl7Rwhff7dp3eIl5vKKXdEXSMTImcV9GOoLjlYo0unpV5SfWpfnK9/Pi9u0oXyzUxc4jSCOFmgQfC23sgsp+LS3ZtJhB89QpUDs3FrtSIy6cMbEyvPNYhn+cTrzQd
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(83380400001)(42882007)(83170400001)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(5660300002)(38100700002)(38350700002)(4326008)(6486002)(36756003)(6666004)(52116002)(2906002)(6512007)(186003)(6506007)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7060
X-CodeTwo-MessageID: d1159a22-0655-44ff-8e20-6627f1453321.20230605133421@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9ef3dcfa-9c0f-4008-2d0e-08db65c98ff5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSf1uikCymZB/ON+5KjZn9BD+E+co3Vb5SBS45UvpyK882SUPkJEppGNJHCu2JD3kBTrxy4rshd9aTJIYfUkUJDsK2k5HR0+OQcAtkhfohT7MZ30RjXFR24A4PaXrtzis7dZnpoWNJv8gCDjfxRXE/99wtSne1HyCT+/gvOT2BpP2JtxL6s1d27gqTBWzi/VXQFXGxKDZskINa9DXOfT2WCD+qPlUCCZ4lKh91OA3AQWfs1IaWQwn6ipQTQBUxPxzCcT8/yctm2uf7l7aU+YbPRkp9E9FnhSwjshUMBxu4k0NHpZCRil9x9ur/TqxeAlkC/0AgN1QIy1VczDM39Q4STbt2irDGN29mgj0u/7R9L3Heq8rUniI5NAwKJ4Nx5Pw4ZNJjgnyHrTBt9eDmXXqvEHDnHZFmj359wx4FciWrMm/eCxhwrX+EN5WTR6e3P5O/QzAhUVpnXspBv+Dcw/5LKvB2FH8vYxNqLh/FRv4j+bzLpiTTLNW04AYo0IrCgLIyrgWm6ZcURyCdbnaIZmeD6r6UdFS5ZvHMDKjDOir19XH3TM4qLZubz+WGCG18XtJw77IzjMry22f78XEcKmndaM5zwarn0BivpwgG1+xTwnn86QQebFQhfUTS20GpkJiQ0v/juyXgfEWsPUYyQ2bVqCco5kN49KfUXgr8wMWAb3Tx+tjpWa9UreY2ZYEN1/94aldlHekYEiAcdrTTr2Bw==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(346002)(376002)(396003)(451199021)(36840700001)(46966006)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(42882007)(15974865002)(83170400001)(336012)(83380400001)(47076005)(6486002)(36756003)(6666004)(36860700001)(82310400005)(2906002)(8676002)(8936002)(40480700001)(44832011)(54906003)(478600001)(5660300002)(4326008)(316002)(41300700001)(70586007)(356005)(7596003)(7636003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:34:22.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93a96f6-065f-4da1-e86b-08db65c992d5
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a fixed-rate clock that retrieves its rate from an NVMEM provider.
This allows to store clock settings in EEPROM or EFUSE or similar device.

Component shortages lead to boards being shipped with different clock
crystals, based on what was available at the time. The clock frequency
was written to EEPROM at production time. Systems can adapt to a wide
range of input frequencies using the clock framework, but this required
us to patch the devicetree at runtime or use some custom driver. This
provides a more generic solution.

Because this clock depends on other hardware (typical NVMEM provider is
an I2C EEPROM) it cannot be integrated into clk-fixed which uses
CLK_OF_DECLARE to initialize.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v3:
Change compatible to fixed-clock-nvmem

 drivers/clk/Kconfig     |   7 +++
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-nvmem.c | 113 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/clk/clk-nvmem.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..63f165473481 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -447,6 +447,13 @@ config COMMON_CLK_FIXED_MMIO
 	help
 	  Support for Memory Mapped IO Fixed clocks
=20
+config COMMON_CLK_NVMEM
+	bool "Clock driver for NVMEM provided frequency"
+	depends on COMMON_CLK && OF
+	help
+	  This driver allows a clock frequency to be provided by NVMEM data, for
+	  example in an EEPROM, by fuses or other non-volatile storage.
+
 config COMMON_CLK_K210
 	bool "Clock driver for the Canaan Kendryte K210 SoC"
 	depends on OF && RISCV && SOC_CANAAN
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0aebef17edc6..aef1361e5085 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_MOXART)		+=3D clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+=3D clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+=3D clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D clk-nspire.o
+obj-$(CONFIG_COMMON_CLK_NVMEM)		+=3D clk-nvmem.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+=3D clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+=3D clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+=3D clk-plldig.o
diff --git a/drivers/clk/clk-nvmem.c b/drivers/clk/clk-nvmem.c
new file mode 100644
index 000000000000..19aad5cd222f
--- /dev/null
+++ b/drivers/clk/clk-nvmem.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fixed rate clock that reads its frequency from NVMEM
+ *
+ * Copyright (C) 2023 Topic Embedded Products
+ * Mike Looijmans <mike.looijmans@topic.nl>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static int nvmemclk_retrieve(struct device *dev, const char *name, u32 *va=
lue)
+{
+	struct nvmem_cell *cell;
+	const void *data;
+	size_t len;
+	int ret =3D 0;
+
+	cell =3D of_nvmem_cell_get(dev->of_node, name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	data =3D nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/* Abort when all zeroes or all ones */
+	if (!memchr_inv(data, 0, len) || !memchr_inv(data, 0xff, len)) {
+		dev_warn(dev, "%s invalid, using default: %u\n", name, *value);
+		goto exit_free_data;
+	}
+
+	switch (len) {
+	case 1:
+		*value =3D *(u8 *)data;
+		break;
+	case 2:
+		*value =3D *(u16 *)data;
+		break;
+	case 4:
+		*value =3D *(u32 *)data;
+		break;
+	case 8:
+		*value =3D *(u64 *)data;
+		break;
+	default:
+		ret =3D -EIO;
+		break;
+	}
+
+exit_free_data:
+	kfree(data);
+
+	return ret;
+}
+
+static int nvmemclk_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	const char *clk_name =3D dev->of_node->name;
+	struct clk_hw *hw;
+	u32 rate;
+	u32 accuracy =3D 0;
+	int ret;
+
+	of_property_read_u32(dev->of_node, "clock-frequency", &rate);
+	ret =3D nvmemclk_retrieve(dev, "clock-frequency", &rate);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to access clock-frequency\n");
+
+	/* clock-accuracy can be provided by either NVMEM or property */
+	of_property_read_u32(dev->of_node, "clock-accuracy", &accuracy);
+	ret =3D nvmemclk_retrieve(dev, "clock-accuracy", &accuracy);
+	/* Only abort in case of deferral */
+	if (ret =3D=3D -EPROBE_DEFER)
+		return ret;
+
+	of_property_read_string(dev->of_node, "clock-output-names", &clk_name);
+
+	hw =3D clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+						      0, rate, accuracy);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw),
+				     "Failed to register clock %s\n", clk_name);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+static const struct of_device_id of_nvmemclk_ids[] =3D {
+	{ .compatible =3D "fixed-clock-nvmem" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_nvmemclk_ids);
+
+static struct platform_driver nvmemclk_driver =3D {
+	.driver =3D {
+		.name =3D "fixed-clock-nvmem",
+		.of_match_table =3D of_nvmemclk_ids,
+	},
+	.probe =3D nvmemclk_probe,
+};
+
+module_platform_driver(nvmemclk_driver);
+
+MODULE_DESCRIPTION("NVMEM clock driver");
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_LICENSE("GPL");
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
