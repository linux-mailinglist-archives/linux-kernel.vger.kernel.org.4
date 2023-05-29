Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF9714253
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjE2Dce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Dc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:32:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE000B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 20:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMvA4sg1yKnONkOUfHdpTSxnB7nZ9YLJlvByPAWto02UEykyHdu2q586lymRWhvhmXRm9zVsM0rifi8iDQ6NuZlH9A+iqJ0p0aaaed18YuTsyDp33UE6qm83f84ciV+2dzqtgDKtdPTJH9BODbWR8ecDknp8ECr0ZXFRO05p+4JzIaZ2Asls111/IcWTMnDArfftoKcpiBsGCn8M5+lp2/WWX3zaTulegjPvujsxnlcGEc1qwaxM7OQ1nlTaAmFSv8tuwnlA1CeW5IHIGzy7prsPbyoG0s1p5+4OFjx08wRTf+ofxTeG60Pu0ifGrIUN4XQL7pRpj8ckNJODReYtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WygF8UKVBDOhjT69LiO0Nj23hx2TT7EIU3V9qalOWNU=;
 b=E/BZ7gnrG+bDMT68RKYRdd3JsMaZan0Xax8adWcl7RKg0wjhQ9QnVwpC25ctTOoinn6ihfB0F6OjGQJbOO65U9HvolrcSCnnHH/aZPAzJ5cUn83JbCmJGzH1IQrBpxzneRFJW+LkjmZLfOI2T97p8pVIwqapKxHRQu7tKfgymJmGShH0rZwnnNo31cu90av3GS6DrCWoAFTTaBxGop0I8OmWPdiblMcY6XJ0Wk7Kul+vENAT5sDyAYXBdzPXbnvVxuH15q5XjYxcTtEoY32lNy5aHEUmJ4L6V/CI9iHqWMhenRMaUXuprggZ+4fHo4DpvyWhd5BYuu9MsOVUCCo8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WygF8UKVBDOhjT69LiO0Nj23hx2TT7EIU3V9qalOWNU=;
 b=RompO3PAvnkWE5hSNEYYBYTRuD6Q24k1tWufg6DBX/JEmGb4ZSFLlIryXgi8dM8tPML8azaLik++fbujlW0umLt8cWKBCX+vVz4U4F05IRAagG/ErWP/ICDjN+NARgAWIFq2TCzP/2kxQO3RYPumGpoM097PmwsgXQ+yI7bXfXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 03:32:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 03:32:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] soc: imx: support i.MX93 soc device
Date:   Mon, 29 May 2023 11:37:10 +0800
Message-Id: <20230529033710.4098568-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
References: <20230529033710.4098568-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 97949180-f691-421f-bd6d-08db5ff55087
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8YwaAWaamd337L0C+RvKXMN3ojjQ1JhH4GhBmec4yN1XZqMiuDUdOSL6mXN1hNfBWo9MtCK6cs5fJW4AC8yROfi3BDO2ys81geaL6kJVF/20NL/ZRsZbGPrQsYrYVwb+t6ulz7nWEPHYSZERK/uMQuGv3wTJfJ9FUkLHi3L+B1wj8Vk+P2PE8IO8KzR65CvlrR7mQERX3j4Wuj1ra6qiSo/U2Jy+LHkG49atQ9SSMZ28l+4hpRr87dl5C1IOS9Su1fQJ/zIVAOH6wDhLiOEZ4GoqXhpkKm09DBv5l9OWMDz2dh4aL4TKcmZ6v986vL40BpE2lVKna+T1cN34pKmXqco+1/Ck2DtVzgYOGnaXpRBluUK3U0K3UgTPDJsDCrrzn0V1BtCtJM9G2yOMS0Fdr2Cmtl6HtxGjXSbAAFfzjdK+05j7fJ3DrLTJ4bKWs3iUx7Wc9m0Sc1SMBNIt92isjsSQKnh1gNgV+Dbu1uKwWgt6uGGaEIz1zvhqxB2QL81GlBw4O6lv5ZP+7LU0IPTQdEF1Lj4yQauosf43UqhQ89QQ+HWQzgoDZOd6ImGLZGB+wdL6u8yMYRMZkXtg3+fevv8RUkZg0g5p8WAbhsJXi2bDdf7F+m0jOg9Ejd9FhcS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(66946007)(4326008)(66556008)(66476007)(83380400001)(5660300002)(86362001)(52116002)(38350700002)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysjKQJU8q9uPlzeTU6jgzMi8nrHrb3rV+I/8+X4t2eKl9ILXWFyeoS5yLj6+?=
 =?us-ascii?Q?5njYQq3vjgPsPODlcJ1pOo6KPt6i3D1OIaPpzG3d31BYCSaz2FANJoke1ll3?=
 =?us-ascii?Q?VaJESUBx6UdSkEfAP7X2N+r+dAlhHfORghajr25NZyzk7fKc/+5mHqUuXA4d?=
 =?us-ascii?Q?oGfMZD22QvrtSLHmQMwGljxlPK+XdKTsIXD3WvnJuvAgo5JfrMsglY7CJk+/?=
 =?us-ascii?Q?rldDquKLiT6ddyj/tvsW7ggL8hl2ET4tSIMYa28yHR7akDNDcdA9vZqSurSp?=
 =?us-ascii?Q?xd6kzsWVuC2GS0JtZbtjVam2LS0B1XtqgZnk4VqpOtVjWJQwSHfltCcq+YXX?=
 =?us-ascii?Q?G8H7s3+Ytaa8h5srwE5MjeueE2O6S8yhAgWZri2EeGsuMNpPtNvWMb9Mpk75?=
 =?us-ascii?Q?ksz3oJf21/qIyMF41lBO7X67G4hg476bgoH7NjLTHYfQFfC7q3vYOwHKv3s6?=
 =?us-ascii?Q?nai1bCRf0Hyl0RZ0rrCaO8nC13KAisPnEpvsguWez1VLWVJDOHwvTcUc0CuX?=
 =?us-ascii?Q?wTnQttUgfTqaoBgLpukVS0hYCnlbUNpcV3kf/EMEwykObESG2z0YNwhcHKGm?=
 =?us-ascii?Q?nedCbS9v/5RjzJ3n77IQOKLNr9KXf0qxq+VajOAtK2UNGyV+6ifVz30OE7OT?=
 =?us-ascii?Q?lDyQab8ZgBOb1oQMRlW+FS5P8g09h4xlkIObY0Rrj+Y5Tlb5qIe+Gm6uYru5?=
 =?us-ascii?Q?DXdckf9gYCE1b1JxJrQOYjVqIhKrO+BAtvtpXrsB2lh2lzPT8IP0ImrPhaS3?=
 =?us-ascii?Q?SUgUCXDBVLoZBPicaDtk3F810U/ga9UTPf4bN6iMXcuKJIlvHW6zigDfQEg4?=
 =?us-ascii?Q?ePdx4kA7ROUICFXsaxWNEm/rDBxv69KToVsY674J8RWJaCytDr5EI2nan6jS?=
 =?us-ascii?Q?eltvm7LYJIjiGk3weXkaVjXa3/ePGQk4DXqSZXUH/Ub0RJ57P8KRk5/lFrSR?=
 =?us-ascii?Q?vQBqFDrdXQR0zrabssMuzStFq4y5JRh56cBKIYWlAZ0lMeHHKiJZPgwbhtTv?=
 =?us-ascii?Q?4IVTnGUEsyiNt8kObURuDZgjxEiV8XdZ/rzH3X/C9Vx9WlLFMgk0UbP8ro27?=
 =?us-ascii?Q?DIGXnVQ+rQTZpRk6Zvx2OHlQ0LuVVeEqlxxad/gIymJnza91Nd4Y6eX2/nsH?=
 =?us-ascii?Q?dit0/F2wWgXhq1+JTo+w4f0AbqNOkgM1ewDeLd5oxLLrAbpotmVwCyoG9604?=
 =?us-ascii?Q?H2CkepHvmql68zP/uT2oeqf5jsUl7FE8uX2leUOq48XRXZRHwnIaLeVwcCuh?=
 =?us-ascii?Q?mgMoj3sXJeT183JVHfxjsFpJSKu4UWg6youivzL+BsO9IFjlK5UBGKGdbKzO?=
 =?us-ascii?Q?hkqALIxhSGY379PnVhKu8sP2/4rTRbA+RTTtpDx7SpkrHpDRGq1zjqY9VR8V?=
 =?us-ascii?Q?LMlg4HDSTbtmjzsg8Y4t2DlpLAH7wUooYtvRYVnMRaCh7SfaeAdNGkR54uny?=
 =?us-ascii?Q?OZOyy86LLn6OzybNd2ByNu4Akyad6/E2MymFTHMIf/9/hcrrpXTvIZ39mXbG?=
 =?us-ascii?Q?mi13g19IuWsEnKNJ8Q6vXMb3a/9Kz8dvS7CCguhGmmo+2UTz4FFCDRdJroYx?=
 =?us-ascii?Q?bl7E4pnl2mBF20NLp4Ob+iKOF5cM6YDMEUjxw13t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97949180-f691-421f-bd6d-08db5ff55087
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 03:32:22.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7ADwiLtEjyoHc3b+B2ZLCHWCS7vDlvSqWutno5fXV9bDMhNkhUMtURBE1ofBmUNXkFPad/QhKPKLiMuHE3JDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 Device Unique ID(UID) is in eFuse that could be read through
OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long.

The overall logic is similar as i.MX8M, so reuse soc-imx8m driver
for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 With patch 1 included, the soc_uid_h moved to patch 1 

V3:
 Update commit log
 Drop uneeded {}

V2:
 The ocotp yaml has got R-b from DT maintainer

 drivers/soc/imx/Makefile    |  2 +-
 drivers/soc/imx/soc-imx8m.c | 57 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..83aff181ae51 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += soc-imx8m.o imx93-src.o imx93-pd.o
 obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index be26bbdac9fa..cca207b90110 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -26,8 +26,11 @@
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
 #define IMX8MP_OCOTP_UID_HIGH		0xE00
 
+#define IMX93_OCOTP_UID_OFFSET		0x80c0
+
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
+#define ANADIG_DIGPROG_IMX93	0x800
 
 struct imx8_soc_data {
 	char *name;
@@ -149,6 +152,53 @@ static u32 __init imx8mm_soc_revision(void)
 	return rev;
 }
 
+static void __init imx93_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	soc_uid = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x8);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0xC);
+
+	soc_uid_h = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x0);
+	soc_uid_h <<= 32;
+	soc_uid_h |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x4);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
+static u32 __init imx93_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *anatop_base;
+	u32 rev;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	if (!np)
+		return 0;
+
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+
+	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
+
+	iounmap(anatop_base);
+	of_node_put(np);
+
+	imx93_soc_uid();
+
+	return rev;
+}
+
 static const struct imx8_soc_data imx8mq_soc_data = {
 	.name = "i.MX8MQ",
 	.soc_revision = imx8mq_soc_revision,
@@ -169,11 +219,17 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };
 
+static const struct imx8_soc_data imx93_soc_data = {
+	.name = "i.MX93",
+	.soc_revision = imx93_soc_revision,
+};
+
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
 	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
+	{ .compatible = "fsl,imx93", .data = &imx93_soc_data, },
 	{ }
 };
 
@@ -225,7 +281,6 @@ static int __init imx8_soc_init(void)
 							soc_uid_h, soc_uid);
 	else
 		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
-
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

