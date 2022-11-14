Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4E6282D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiKNOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiKNOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:38:56 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB228E08;
        Mon, 14 Nov 2022 06:38:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWsQjlrFHuN5wGT9dateOMbxQG7xo2gDziJDY9bq90kQc/5NLQaZ6RSdj+hm2O9XdaI1rVn5mKApumrWR8SlFS57yBcETmz8h3ImlDwEuAg1YpQE8OOZxJ7fEbdFjpz8x3i+RgvCPcvXN1ovAJ/0IVNzCvhfynZqGBTWgngqKdqaRgxkqjVlnkgCw4IvU13PAa0n3VlpkNgTrRFlAHAeqMOe9pCcJBQ4DGEDi7/ylTtIxaJ1p2SH0dcSywrjbSd40ufoM5/SMhSW8AqQRYj61lYC1V5b/JVf4Q07Psh6lrunZdupNh7XSviUodGJzVxljqeAJOyi4WsF2f62AH6S1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACrouBeuN3ynQU2FOOJ/kAcuvOn2RrRvO25DFTdV37E=;
 b=ma9kDHIF5Dn7MwfEFZxIIQI4VyNzqGAKDimRWIoKGiGmr+oOP6OUxYEvNfldRCP1Ajfy48Fegun6yoj1oPCxm1+iTSJf5xXW7dENJ+3YRAQE8DryqH3xhvW9+yLO16FExaFL4Yng8/8WGYi6qVdloTwi1OwbxqyNkHQWWWGZ3jnCrkCjBcXHfbY6Bf/H907/AeYNX96AUGvQFkYdCQijV0yrL5lqtqTk7dxHqr0u0F0Zy30dDoADXH2B61AAiGrrehsKs+oCAz5gdtt/FgYDBT8xP4SWYY46DpyTo7NykpOHWpDspFdbg8DwZRMAPmIYJefSIQt2+Eq2wHhKeBJhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACrouBeuN3ynQU2FOOJ/kAcuvOn2RrRvO25DFTdV37E=;
 b=FK3DmU6NsCpcuwfsu0LVSC/tQawD4hrNKDZPUucQfJ74XN72O4W847zMpz5fTQ+UsseLO+mKjRLgNWUMvxI4khrr1VYSk0QJ+0VxNVPaXm71vyjf6elms4/E79LfN5XODevlYmGYhOIW3WGi3j7IivLmR57d02XcLfHnFkz+4VM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS1PR04MB9288.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 14:38:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5813.016; Mon, 14 Nov 2022
 14:38:47 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        saravanak@google.com, linux-imx@nxp.com, greg@kroah.com,
        arnd@arndb.de, sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: [PATCH v5] drivers: bus: simple-pm-bus: Use clocks
Date:   Mon, 14 Nov 2022 22:39:16 +0800
Message-Id: <20221114143916.1162000-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS1PR04MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 5188f13a-fe52-4669-9f18-08dac64def21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQjnk7W+gFXnrJGAKjL6UodObjoK7RzuY9otnykjHUHKAfEIpZfz+pUDnQMHqYXkuWhSMWGrz7qux/mUx0YriPZVUPy2skkDbzhOsTErTuve0I8oV9gaK9L8bvgedgdxHFLzdkxtvgyjv5N5+WO8hvcRqteK7V9d3lFHdma/ApCx1UuE2jzzZ09koMZjwfMnX7QvIJ35/A+/bJECBPlW/Xrg9cz0qUcauVunlVcMTZiouphptqHTbiw514Ms1gDajzM8NHQGw1OoeuEkA3/2dFHJH6r2jtmn4m/nDUqBi/K5zTBM7Q/UkQsjNaD3rqMn6O5Q6oL/NHAEoBAo1miP8v2YuzumR2Zy7fWCzAinfKkT78Lq50q2GCHiYxWGff8zd/B5PCX8flbvJLwE7h97kh6Uz3aAjz+MP4pkEFgsbij3CRAJHa6DYsHcCplLC4HbTDwpbjty6ofCDerVJmb3tcAPPd9yM5B/PCuPHqOBsMrz9vxgGQ4nA1G5utoveJAoNvHSssGKwSpdqPFIqrlMAcwcWeYc7oDIlcrBmTWMzKj078Q2sTMH24a+g1fF5SDa7ykwRHaoNJiRKrC83sV0ntmHezaArHVBfgYLNNlvZn5dYHALGHQP5Wo9OzhS7W5vJr8tI3QjFC8b2Stzb44tCWF/ngBR0HSNZXD50bVYbqkZCv6i7BwqQAbwZGZI9wqzv+c+KbhBGMxhnjaOFubpyY8UqDjJTsRUk4ZSuAxeNCK5041c0/CvounUZgpXJjxG1FYyvD7h4mlg6rmab71VDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(478600001)(6486002)(66946007)(66476007)(36756003)(66556008)(8676002)(6916009)(316002)(4326008)(83380400001)(38350700002)(38100700002)(6506007)(6512007)(6666004)(86362001)(26005)(52116002)(186003)(1076003)(2616005)(8936002)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V1sPeltp9fxmwRiMP090FUJBT0MBLzRzU12H0TJfwgXU8OPuZ3QHhH71mPqO?=
 =?us-ascii?Q?csKKvuq5oXZtGqLLHuoegRmbHLrShkYXcryxFHMW9yF8XEmoRJk3H03KZpgG?=
 =?us-ascii?Q?dmjWTgBvC5nG5p2qYzfxt+7yRulgAAKDLI4NBXtbwx7E1GYU2DTBe2AvGGwe?=
 =?us-ascii?Q?voR3k3x0Z+/2tE5s/7j7dNVVmf2vXcW3Aqw/voXzgyom3WNEfQrsQw7T4Ug5?=
 =?us-ascii?Q?0JdgWgotL1+PgJ2rpVgd6QCcEAcAV44CbfPk0VHm+jmFm1QcEeotRhq8C0ZG?=
 =?us-ascii?Q?U19nvEGpYNRpXGsKFRtlayOFSHLGcI/8PRokNDk5fN2xrMoj+GLPkCYQYXT3?=
 =?us-ascii?Q?HmcEmdEahhgxF1wtpbIKkDjn3Vjh5CQa+AZEwZGc2OQRPir8frVpoguIwQbm?=
 =?us-ascii?Q?1sM/O3OTWE1f9YQRNF25H2PJ+BVNoAXNgW0aqrxyqGlxq/P2j3Kz8Cna9XA+?=
 =?us-ascii?Q?cAbShBwTRtyqCG9uWXx2+lA0+cAHMF2o1y0Vp1gNZHK3vqS9zKTJJo64QXRp?=
 =?us-ascii?Q?8Gz+fLZRwjOPmYZ73iz25Q/4+hacONLHvhEFeflrJygpyVEnM/wAt8869+7p?=
 =?us-ascii?Q?IrcJ6otckPQ6LtB307BzkjTZXS51n3+nwNrFixbhbABLBGbUeuUCHYTKnnBo?=
 =?us-ascii?Q?jf9Q1wfYA9NSZZ3vPwpyCTXAwSD+VNeaxmR7eZITyl9Q+vY3YubBuukYVZql?=
 =?us-ascii?Q?AZK0sQkBf04UfBxLpooXNct/I9BgUVMMWFMSkeadQ0XUgqx7cxpbPYA65M2d?=
 =?us-ascii?Q?gI5xggdPqfdcVcwY70urO/K9tKB41GZVwC3dfyktEd6nvH/mBiJcsHsbRi2Y?=
 =?us-ascii?Q?M8avoN+6TQuVJrSnEkyYJKYKQv2xyg5mCDATQ3hcYlq+pfMWhLlqT3Ft8akK?=
 =?us-ascii?Q?M9cQL738cRjWC5PWufEhRsdiESTAzohvDAYpO20vxI8tyDTUYttWypz2TXb0?=
 =?us-ascii?Q?JKX2qQgI8LwQswBStTOifuzibch8t+lHswo1zyKGGIkqsH040yu9tv1i3PzR?=
 =?us-ascii?Q?zw4ChhpMBr9Sr6OdKaFy/aV+Jcr+pOkZkB4Fs0j0qIkgLvdy4LLe/xjS/rE4?=
 =?us-ascii?Q?NwI1mndVWtmXrRe9fSAVLjnLIPVzj+JeXhM8Vuz0sWFpOR0oG5i/zm5lL+FY?=
 =?us-ascii?Q?w19MFFqywJ9pKl9ozoBXMPlqDgtNkjY9gDf5X0enF0bwDR5cVubHHQFN0xDj?=
 =?us-ascii?Q?SeK9zmPmX2SlPdi7WH8GI/gmGEdJADNgWUUW/i+bgx6HT1khF7vg+mxCyGX6?=
 =?us-ascii?Q?RDzJjrfUAQx/InRW8zz4mq6LONDLw+kgMgu0mukeW8LD+bXGHtb5ka6vWqi+?=
 =?us-ascii?Q?wld8xgyeBZvEBXErkxLuUmVJlrccE0L7HSuAeCyyIOvwf9ANBiXKD45jXl2W?=
 =?us-ascii?Q?kw06g0lkLj5Y+O1euFuyVRW4BnUv/yasBQYLnFufzaEtYYU8e7kcy8b2Bj8O?=
 =?us-ascii?Q?vHVtC09jK1bdz7pD60P1/44fBrh1Qmen45mYoP4KbZXMYGYAVjipNTmftW04?=
 =?us-ascii?Q?iE6bQ1Y2sHdEGBUWrOFUBs7zVrgBVeijDTsB6+CFPOomlOQHpK31whmWa5n1?=
 =?us-ascii?Q?teYmf3LMwkq7EfMIQT4zNrH190rWXNqOuRk10Pyn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188f13a-fe52-4669-9f18-08dac64def21
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:38:47.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84fPkkdOq3ns/d9gZxnmgQmur3o1HJXTKtY2PI5/z9wC61Z9boR5VX+aMIjmlSgtzgSDz40mZxU4Cnq3r3uaNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple Power-Managed bus controller may need functional clock(s)
to be enabled before child devices connected to the bus can be
accessed.  Get the clock(s) as a bulk and enable/disable the
clock(s) when the bus is being power managed.

One example is that Freescale i.MX8qxp pixel link MSI bus controller
needs MSI clock and AHB clock to be enabled before accessing child
devices.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4->v5:
* Fix build warnings when CONFIG_PM=n by using RUNTIME_PM_OPS,
  NOIRQ_SYSTEM_SLEEP_PM_OPS and pm_ptr macros.
* Drop Geert's R-b tag due to the fix.

v3->v4:
* Drop unnecessary 'bus == NULL' check from simple_pm_bus_runtime_{suspend,resume}.
  (Geert)
* Add Geert's R-b tag.

v1->v3:
* No change.

 drivers/bus/simple-pm-bus.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..7afe1947e1c0 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -8,17 +8,24 @@
  * for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+struct simple_pm_bus {
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
 	const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
 	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
+	struct simple_pm_bus *bus;
 
 	/*
 	 * Allow user to use driver_override to bind this driver to a
@@ -44,6 +51,16 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 
+	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
+	if (!bus)
+		return -ENOMEM;
+
+	bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
+	if (bus->num_clks < 0)
+		return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
+
+	dev_set_drvdata(&pdev->dev, bus);
+
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	pm_runtime_enable(&pdev->dev);
@@ -67,6 +84,34 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int simple_pm_bus_runtime_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
+
+	return 0;
+}
+
+static int simple_pm_bus_runtime_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops simple_pm_bus_pm_ops = {
+	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */
 
 static const struct of_device_id simple_pm_bus_of_match[] = {
@@ -85,6 +130,7 @@ static struct platform_driver simple_pm_bus_driver = {
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
+		.pm = pm_ptr(&simple_pm_bus_pm_ops),
 	},
 };
 
-- 
2.37.1

