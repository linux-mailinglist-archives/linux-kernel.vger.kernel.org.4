Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEC60082E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJQHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJQHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:55:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767B5B50E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzvGdnPDDnALf4Y1Sy4vzK+xnoZyJXlZ1RD0WlLcnYXgINsuDLTYmIpOybp1OL0kqWe0bza4kpyj6wfJ4G+/84uySwaM17NAEmQGm0Rt3d3KU6aMMg3xlvzqJp8pFZqpxrY2XEdFESMKSviWuFaXeHT7gk+8/nYXhHXuhYc7SQwqGN/vYn0p94PTdZccvkLp1wz959XLXCAR+qhgyhdBtezLlc64Tm/mV86G8xB1EsTF5vlVoS+xUpYLk+nd5lfHhGrSV58co8K1sRl9XRM3HEIoYN+vmdC1b1Wl1g7UrozgROI9zs29P75XbPYGyD8X+mMCo+A4/d73C/sAeTJXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZs9EwRcvyBhiPjvrXkzBGtVv4YzM4h7cDGib0j0o80=;
 b=M3L2Uhugbg1e2fANcipVfGBZq2Szbzi7b36YEG/imVmt79GxURf6BOlLS+6tEl7N5GZTNXuPNOJfKUOXK8lHYEsEFOgJH9AH9wzXI53CuT0j/iDBhtOQ2thEKqC41zQHonCOX0f3QbSjPBDsk99PjAvpwqWt0hCzM/oZ/lN8hFRRYSrSJHBPPAEm9pXCEkOtX0ML+dHS9vHkmoCy6HEQMifA8/M3R2cIDK9GyRJjZcY50QEPHQ5CU5vDPb+0UUFEtrn13IcfrUbOKwgO7BCMJphsT7sfcuCllxuAfPZzYPjvA6ZZ42IaYTn+O7BSx6alBniabvrs8NnT6947Jc492A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZs9EwRcvyBhiPjvrXkzBGtVv4YzM4h7cDGib0j0o80=;
 b=ro8lgTX0pz6Ou4xVcge7Ev00tPsyzXXpAqJLEjWB9aG5UXeFCgm4lj504Z6ZGuR2+d9lBMJ2of9HBVWRHAt6aDLxAf73nlBDuKgVU1xtiwc8zQzGDS0oy0BB4LlqeIiIHJYhosaQI4PIUVC4SNqVvaC5I3ZHEA0KmRhPJm8sdGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8543.eurprd04.prod.outlook.com (2603:10a6:102:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 07:55:48 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 07:55:48 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lee@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH RESEND] mfd: Add Freescale i.MX8qxp Control and Status Registers (CSR) module driver
Date:   Mon, 17 Oct 2022 15:57:02 +0800
Message-Id: <20221017075702.4182846-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 382cffec-8129-47f2-1aa4-08dab01500ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSJm2WVbbxR9U5pvametWs4v75mjCFECk7sPXFdrnl5qqE5QsIkywa/lQQ03870ZoBUdmOS/rghP/G0WeIG+FK2/MaEu/CWWAYj0w78OGOr+ee+J9w5MGZPVWLMufDDpNdNVHuI+zp4xp5rM4n9mQe4wmbXqyv5R64EPpH/aAYZPAbXs91pm7a/xhRYCuDRQiD+NPDN1UxlC7nNQWvAssMnxLG4k4MB9zpRzx/JrHoGjwa5gKFw+Elp54czYOV43zyOD4SMOyXe69XOWbEDHD+N79nlrGgW9ThDXdS2qdo2dbOdBOjn5WXDme0ogz/APB1G2KlMzINNXYn1wvdGXOlrTPQpdy2mEgv3i1azEsDiCRG0HNLG3REnIT14qA0oUchho9qwS3pAHCQ3rVbXrMy3esQUOEFp/mGUAeeJYT8GakOwE3zBzs2fju5hMrphMzvLIocgM0SVbPsK4F+UR9eR24AjW2hhKooTwuQ6Rvr7oYaIxRGUZnRpRkj6QU+086tTHrY7p50pl8aBP7RVQY6au7GJx7Ko9MVi5Oe/Rsuy2Bt+Pkvf3ZDe5q6VrD0aWPt+J2vLCh3k1k93af3jWFjnYJvngwa19XfslACv9ZRWjU7Gg50dPtcRla2DRPubFJlJyoWNa5QpuHnCUj35ciJvj/4E8nqw/Na0K7xCNzMpRQWOJmnAMq643q9IdCqzhjkjl4mc31461Q/7yOOieL6QtqVEUgYj3YLwoH8n3AnRpxghIqaYtMrAKYwuS7t8a275T5z5+La+rp/z63062Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(38350700002)(6486002)(478600001)(38100700002)(2616005)(186003)(1076003)(316002)(8676002)(4326008)(66946007)(66556008)(66476007)(6666004)(6506007)(5660300002)(36756003)(26005)(52116002)(41300700001)(6512007)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2m5/yZvFN6il0IFj+WqrHn2OBE3KHQVu8y6tY5y6m7ohAOeU/rLIf3ngKTM?=
 =?us-ascii?Q?HknDF9W5HDfhHKbGZfF2DRgGFJsReN8Lvtz+pS+Mmm4++IYFaXmXltbu88XI?=
 =?us-ascii?Q?6+AOI0poizUDR1bo8yE+UBtd0PFhltUB2EICND6BDCkvVsBR1/4eCh9bIpvS?=
 =?us-ascii?Q?2R8rnlC3qn1bnLJOrCBGzuWUZ5NbuOtz0bCa3B65SzBSnLZ8eJL5bTJ3TsRH?=
 =?us-ascii?Q?tXpewS4n4xQMehXMuC67W/FEfMQZdKDhUFozBEKMT8IgCjw0Ex+irqdG+e2w?=
 =?us-ascii?Q?4UjE5aaIzdYUD97V7+J+ljiuhbOm9D878hijxnQVw15suyWaEPTTgAkTepAB?=
 =?us-ascii?Q?5J9VQQydh+BHiSwlzH3QuwdUbCLgmdlPxQb6OlI3FTT5y+wSQcGmvFhFbgip?=
 =?us-ascii?Q?ip12VJuULKrjxVJc2T64G4z3HEUWoQuTBHk8QgnzsDVI3sKD+F+oVpPcg6K4?=
 =?us-ascii?Q?Pol3+zba1x3tWrv8amMA8gqlViHFeao2wA+kBsOx1Do7Hxm+OwC3paFzmOD+?=
 =?us-ascii?Q?cvSsJtMilfj7MFiw1+MEfVrmNmXWDqnQbclIxdf8XGKTs0PHkC+4e1Ch5RdN?=
 =?us-ascii?Q?U/jEhQilBjyN+ZLTPcDteR6jBIfFMKsg7rsWeXF3KtDZagnhZYNS80COat0q?=
 =?us-ascii?Q?l4+voNtQPUOppw6E/O1+6PSUIj5rLKdWZlqcF5NPWmu9kSA7KH13SP1O3MiQ?=
 =?us-ascii?Q?JtOJ7C7ipFbk1thdimhGG28KR0wPU6mDAfAU6QBlfTS1yH4vnQKb4crAvw88?=
 =?us-ascii?Q?1g+6usG+IZgh+17DaGeQ7OZ1LkmdwDw0+QzWttr73svGjcFq3yNR+nqEA6Rq?=
 =?us-ascii?Q?EqVv3DmvkCgckW0J0pOu9itA4KlCcpXzhYhuYVhEbEBI+8zhJCSjDzK1liKY?=
 =?us-ascii?Q?Km9CI4r56AZmJ86EUAOzekSYypZxjJhXFwM1jpF9XH0K3x8JNHDZzykm0h6w?=
 =?us-ascii?Q?gaJtPAvJt7UU5cBtuDjcCa4Zlp8QU5PZpViiOrXOpXYeGcP7hpcuX/0qRXhR?=
 =?us-ascii?Q?AtwFsuOfvXrSYTvceVH6/y0A7VWkNwpNSzWN4+GHVOSGRl8+ghiOKBb0etsv?=
 =?us-ascii?Q?wDYs5JmA0boDGizsITWNGxWsP1epoSwvOBU8HYnRKvwTNY56Me5YciS6CoXl?=
 =?us-ascii?Q?5giHxs6xym0oawiWtQrY7c+ogP4qVRlWFfFzJ8mLjD4RNVbktHsh05hzJKiw?=
 =?us-ascii?Q?HnQkTiF1C6gdtZJGKTnB/w++Qa7kpPdkFnpl76ZeYvGgAdP0ytudryNsEtMI?=
 =?us-ascii?Q?LNtUw1OUs9xIEw7J/wxDUSh3q2JAR3hY3JmdSdi4yNostMm9LtQMcG0/V5UL?=
 =?us-ascii?Q?n12NKBEGLI6jym+XHaGeIdDjXqwrxhwub7Dmp/rjKCbdgrb9E8QG9w/ZMQS8?=
 =?us-ascii?Q?q5b+JX0CR29L+OWHZC7fYxC1Yq7oziOzfWqehHT8wWi0YQi6hOPysfHClstm?=
 =?us-ascii?Q?dBZe89VIyWVybn/fVqQY1ofDOsV5bUkdQuQQZCScFFYHJ+eTEgf3RLYXo7ji?=
 =?us-ascii?Q?U1VNSYoXASqBcBjBvt2a+7Z/cbqggQaTKb1w7CQI+EttsdPWdgmpWgLRWrsl?=
 =?us-ascii?Q?1VcoRAUG+SdfO7jdM71/hjIGWpmzUrRiZnNa4N1x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382cffec-8129-47f2-1aa4-08dab01500ef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:55:48.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lH1QvqqCDqgrRNHOACYacIjBnSdhR99Gneeep09ElDWL9Ubv9HA4lgqQEqXkC9qVLalfuQJFpJ9WZWUJeUFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8543
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qxp Control and Status Registers (CSR) module is a system
controller. It represents a set of miscellaneous registers of a specific
subsystem. It may provide control and/or status report interfaces to a
mix of standalone hardware devices within that subsystem.

The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-managed
bus(i.MX8qxp pixel link MSI bus). To propagate power management operations
of the CSR module's child devices to that simple power-managed bus, add a
dedicated driver for the CSR module. Also, the driver would populate the CSR
module's child devices.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
The Freescale i.MX8qxp CSR DT bindings is at
Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.

Resend the patch based on v6.1-rc1.

 drivers/mfd/Kconfig           | 10 +++++++
 drivers/mfd/Makefile          |  1 +
 drivers/mfd/fsl-imx8qxp-csr.c | 53 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..966a250d7910 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -499,6 +499,16 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_MX8QXP_CSR
+	tristate "Freescale i.MX8qxp Control and Status Registers (CSR) Module"
+	depends on (ARCH_MXC && OF) || COMPILE_TEST
+	help
+	  Enable support for Freescale i.MX8qm/qxp Control and Status Registers
+	  (CSR) Module. As a system controller, CSR represents a set of
+	  miscellaneous registers of a specific subsystem. It may provide
+	  control and/or status report interfaces to a mix of standalone
+	  hardware devices within that subsystem.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..5c3c13d7ce85 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_MFD_TWL4030_AUDIO)	+= twl4030-audio.o
 obj-$(CONFIG_TWL6040_CORE)	+= twl6040.o
 
 obj-$(CONFIG_MFD_MX25_TSADC)	+= fsl-imx25-tsadc.o
+obj-$(CONFIG_MFD_MX8QXP_CSR)	+= fsl-imx8qxp-csr.o
 
 obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
diff --git a/drivers/mfd/fsl-imx8qxp-csr.c b/drivers/mfd/fsl-imx8qxp-csr.c
new file mode 100644
index 000000000000..3915d3d6ca65
--- /dev/null
+++ b/drivers/mfd/fsl-imx8qxp-csr.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+static int imx8qxp_csr_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to populate sub-devices: %d\n", ret);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
+}
+
+static int imx8qxp_csr_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id imx8qxp_csr_of_match[] = {
+	{ .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
+	{ .compatible = "fsl,imx8qm-lvds-csr", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx8qxp_csr_of_match);
+
+static struct platform_driver imx8qxp_csr_driver = {
+	.probe = imx8qxp_csr_probe,
+	.remove = imx8qxp_csr_remove,
+	.driver = {
+		.name = "imx8qxp-csr",
+		.of_match_table = imx8qxp_csr_of_match,
+	},
+};
+
+module_platform_driver(imx8qxp_csr_driver);
+
+MODULE_DESCRIPTION("Freescale i.MX8qm/qxp Control and Status Registers Module Driver");
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.37.1

