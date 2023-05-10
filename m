Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC16FDF96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjEJOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjEJOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:05:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB80468B;
        Wed, 10 May 2023 07:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYShYMqbuaiTOnJireJhDPZMp909XxkGQRLsI4PxPd5DvxvDGjjK0bq4gHYkSsoKJCQuFGoRXO6rE/HDdV4TZ+F57Nlq4rooVtjBxM8jfgt9YWbg09tgYrdm5eu/iIQBqnSIhOjPXwHKUz/0j/mkLLRcvadyakBdWl7UjL8XGYkMYdXX20U9a4Qzh6rBwYVi9vgfzCfKT3qTftXrpjs2odu4sj8mH2nfGESsdgcJCWViv4ptqa9WjLJltLD5UbPwYrLWoV4AV/0tdS2ZW6ureqJMto5dpwhQT3U8RxFwMK+GbprUBxLORvoyBZkN1FHwxIbfdWjY9Ql1IpMlx8lkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpZ8mIMbagpHr+SmuoP92YIIfhaSGoVJyzZWWHbCPko=;
 b=Hvojqe4g77tUXNV//BFrfk+/o6JyA5Gj66VX++mF96vnXoNgHo4WfuOfoXjoAtisRbvXd720wR+4ZG4bWp5AXwOnztDdqhWwFUFtdl8LvXfbC8xnNNz19FW+lrbgpm2F2GcoXxAesc93qruH3RkVXzcoQOFOqX+LFkrM3S1icVyYkSimi1GwhpRCQktW7svrzP6p81XvLwfo9FLfek/MHVi+F/1SMhAFKWjuH0GoWP3JJrBTPw9Az3/1ZLhh85TW5zlhN3sgGT3hBPX+ByqLk79whBOalRgxAACbR+OG9nEZIitBw5CnHP7+tyfHjhgiUII2v6OlnWcyFpqRr2LHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpZ8mIMbagpHr+SmuoP92YIIfhaSGoVJyzZWWHbCPko=;
 b=EyG291+8bgkXEc3354lU+40cjWbvOPrRZb0OISm94YXolXmTGdNHb4MaUGS3AkOZlXWs3lR6lusq7N1WvFdoof25vvJV7mvs9RF+lw67wByPJbXz8thmK+K0+4Kn6SGDaPaf/LF3U7PcSRJYSzNcLCp5+PdNJAfqBdGR3SmStzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 14:05:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 14:05:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
Subject: [PATCH v3 1/2] phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt property
Date:   Wed, 10 May 2023 10:05:03 -0400
Message-Id: <20230510140504.2164565-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: a76def96-6d79-400d-ce22-08db515f991c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWMFvgLEQnj8rgNhXL+bqqura0d1luGWLQI7ILX5miRveuYZiU9XUkosmafqfdc29tYu2qG7NZQT2bid+pJOHq3F8QXfTROhKB4tRacVnDjFH0BZMfdb0u0nb2ElsuZf8WKFnJiJ/1ufKcVgLOT40EwzD2p3xkW+dHbpsbo/BGGbBCHatiQvBkoLro4Tn3TMGk+rEP3GJ+1aqKLYIw03xcIc0AkgODK8Y8aH/A82DnH8ss5Zy6OmMr9Xqb8pde6eKjoc0aQfBsvu//lMg0CmXD1iDYb8Q2CHRNJVjziXZb0AZEKfpHzbmI9usN6dRM6DfAuZie8l8jPdlfQhi3rCXv95sCrcmXvbGKTqXmKLvVa0YiYB2GLDQ9m4ySpE2LyH5MWYTR3ATrRl7A6zEyVGJInLVjD+TB3cSYSGZmHjG7YgFfIjukXkUIO45NsrDUW0aXeJskJM4aq9tIzv8/luXG4QPUvZjxdzzzcT0hqOvFZbrhwJoulaPCZFG5eBtG5EHmghjjm3HMfS4rg7uLvIXvkU84sNvb1FzlzTB6bQqIn9eFyK8b5Hsk9sXnDRXkwJSIjXlrziUIzEpa2WoyfOe2hk73bKr9jwArlKSQTgGeSc22FN2hYfWRRqMMnmEFKTBPlZdXP0MwODhU9sfDp5kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(5660300002)(7416002)(8676002)(8936002)(41300700001)(316002)(6636002)(66476007)(66556008)(83380400001)(66946007)(36756003)(6512007)(6506007)(478600001)(1076003)(186003)(6486002)(6666004)(52116002)(26005)(2906002)(38100700002)(38350700002)(86362001)(2616005)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpiU6PT1Fd8kyDgKAjKB9iO6RgmGloKyLDHjpWZOLhpWm/OpWXMXfCLuryK+?=
 =?us-ascii?Q?7juezvgN0HWZTol5a2dl952o2cI8e2jAYt1EMDgYrQRD91ME81qtSfhlOS8O?=
 =?us-ascii?Q?gT29WbijzsPOLaehzzzP8FTa+Lj9t+4EyR6P2auCBlcePFIA4pk1bx8TwHA0?=
 =?us-ascii?Q?DHHYPwldhyo6y+zCDnFOSPYfkileY2KK+tlYvLvkbS2+JbJEWecRWS4fCgWS?=
 =?us-ascii?Q?xSug1g8/qnSW+D8xe+/J5n7K467f1hvkZ6ISlN+BlwWf1UEBn8V5o7Wd4p76?=
 =?us-ascii?Q?8rYMXS96sXKrdfU3wMmr/WS9YvOMUYqTgJaUsmveFKnS6U19z63+kvYfgZTo?=
 =?us-ascii?Q?/q9/X8oC/QAZ3oOLWSrR1HWCi1F8+c2gzAxEBQXfnkv3IskfCGPq2XMGb7kc?=
 =?us-ascii?Q?ICQXIicedg/Bc4ylOEqAh2NHZcgQxWIsaXwTy/jfr0q8/8HR+RBUHKEUrz6o?=
 =?us-ascii?Q?gOUqtAzr9vob/5ZxoRT9uAOXsFqkrV0n4xCKcHiW10A7uIfuTDKMbYdMxdN8?=
 =?us-ascii?Q?lIncJ85HRWFApiaHPc18wPy0PhXKTnjGZU6GZ2pAmnt3pTfefFYu397ccBnw?=
 =?us-ascii?Q?4x4QEabW1qAlU5ZGHXLdaWO2aqBQOb+hLd1infSSVEQITJmoiIXk5Q9eIn2X?=
 =?us-ascii?Q?zLSGmCX+E0R5dy+sk42FlHILWZq6B8s5lVpBPqgdIhzEIc3pTDY1EC0Lo5ce?=
 =?us-ascii?Q?Zfdiny/rTRl5T7J9TDElNi/lJSI0c+wTrS14pha846wEsIA/WP5nTU4vTRyU?=
 =?us-ascii?Q?8LSTowwdMAffydm6IrTgXWtYjeeU9QdKDActFmF+S8elxt9viiX5FXQ+jyHc?=
 =?us-ascii?Q?FzOvr1Pgt0ZU7S9+PfkL8vgqbXxIdOEXE06sL2myHBnPEA5cQiVcIYOKEsei?=
 =?us-ascii?Q?6U+eskgcZqSnhPPtDoaHyBJV3jWf62E5ne3TTUsDuLNBcqEEAmAET25oXGaR?=
 =?us-ascii?Q?YpJECfcH2QVlH/hu7rOtnSQuAD2/lTNw3XZGaG+/NHmSTYGY7053Hrvq57Kc?=
 =?us-ascii?Q?KgomOwPVcR2vTHWOHXVC8/KWKOuMmB2pRksMIK8HnMT/ayidx1IBBgUiPbfE?=
 =?us-ascii?Q?wfnKjxxl49MEYnXlN8ku3Tzcq6qUIJCHJ/W/iDaREYaSWYgpNhrKOBfb72dh?=
 =?us-ascii?Q?Yis7du86YqD5BxiEpM6hc8ZC4gAUpxyR2o2Sq4xdxaaanw7izDT7QH+haJmm?=
 =?us-ascii?Q?4tPq89F3XtILESMLYJvom/XJfzQhhwfe58xsz5k+a56tAwKGEB/N1bsd4NZZ?=
 =?us-ascii?Q?3jTMs1LM7H4tcM8110+3QhI1F7g86+X7aLVVWzlP8IQsGsHV1Z0OqYVVIrdr?=
 =?us-ascii?Q?P6OSd8PZmQVxJwDv9jofGV64dVfD76v5t+kpK7qYGPPuJ1R3YfUrSorJSlJE?=
 =?us-ascii?Q?jtHESTIonOqdlpsgjAfdQ8y6dm3MqTqexRDw41m4h0VLehq5v8udoHFf1M87?=
 =?us-ascii?Q?K+wp9dWPhF0+yoIGbsiLYno5SwLjnl2F/vI3ARid1dRU+/CMsJWoi6axjEbC?=
 =?us-ascii?Q?7HycJmNYCM78AdBt2px7UYH6Nq16g8G1XpsTPDrpVHArhZTdYMW1azXzgUX1?=
 =?us-ascii?Q?lEPBFYns7vWdlCyIV64=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76def96-6d79-400d-ce22-08db515f991c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:05:23.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVXPNL5VwlgqmChMOc8d/Xvo/JS0lsLt2KCusLPYFQW+4wjkJp/+p8wYprcnK8Pzohlb58obRptweqKk1cGjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cdns,usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add cdns prefix
Change from v1 to v2
- remove empty change before #include 
- Remove dts change from patch

 drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 23be27a747a9..ab7eca515059 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2019-2020 NXP
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -91,9 +92,19 @@
 
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
+#define UTMI_AFE_RX_REG0			0x0d
 #define UTMI_AFE_RX_REG5			0x12
 #define UTMI_AFE_BC_REG4			0x29
 
+/* Align UTMI_AFE_RX_REG0 bit[7:6] define */
+enum usb2_disconn_threshold {
+	USB2_DISCONN_THRESHOLD_575 = 0x0,
+	USB2_DISCONN_THRESHOLD_610 = 0x1,
+	USB2_DISCONN_THRESHOLD_645 = 0x3,
+};
+
+#define RX_USB2_DISCONN_MASK			GENMASK(7, 6)
+
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
 /*
@@ -125,6 +136,7 @@ struct cdns_salvo_phy {
 	struct clk *clk;
 	void __iomem *base;
 	struct cdns_salvo_data *data;
+	enum usb2_disconn_threshold usb2_disconn;
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
@@ -261,6 +273,12 @@ static int cdns_salvo_phy_init(struct phy *phy)
 
 	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5,
 			 0x5);
+
+	value = cdns_salvo_read(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0);
+	value &= ~RX_USB2_DISCONN_MASK;
+	value = FIELD_PREP(RX_USB2_DISCONN_MASK, salvo_phy->usb2_disconn);
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0, value);
+
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
@@ -315,6 +333,7 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cdns_salvo_phy *salvo_phy;
 	struct cdns_salvo_data *data;
+	u32 val;
 
 	data = (struct cdns_salvo_data *)of_device_get_match_data(dev);
 	salvo_phy = devm_kzalloc(dev, sizeof(*salvo_phy), GFP_KERNEL);
@@ -326,6 +345,16 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(salvo_phy->clk))
 		return PTR_ERR(salvo_phy->clk);
 
+	if (of_property_read_u32(dev->of_node, "cdns,usb2-disconnect-threshold-microvolt", &val))
+		val = 575;
+
+	if (val < 610)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_575;
+	else if (val < 645)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_610;
+	else
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_645;
+
 	salvo_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(salvo_phy->base))
 		return PTR_ERR(salvo_phy->base);
-- 
2.34.1

