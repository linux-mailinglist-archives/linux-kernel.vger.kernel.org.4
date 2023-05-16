Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3B705288
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjEPPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjEPPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:45:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A493DD;
        Tue, 16 May 2023 08:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InHkSrgoAIlxpInZPBtkwjxmXTWYQL0MKh5mQlyLKnVibd0J2+Ne/udIJKy+AF9SLkFfhjELWbj1j+jLXa5gmYjn+VR8YW1Gd/kcVfyWthpwn1/FGWGe7Wt8SEzbeNkr/EdjH5G74uLpwYjVRQYi333W1UrkGADa9cGFfDL7UQmmCyQxmLecYqL9vAkBpLB3SxU4bYJytp6LUi84mSRW1rCX81gxy4XQXut6bFvBr+T7AKF6vy2wXICp3Vkk3j4wyCff4solNPdpkcCNMup356vRxM6kjoLEJ2iJndL62XOhBuDyQeP3o8C01SWlzusg6+drpCLoNeO+pJojHbyQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/lVlNOphIqwV7gd7B24SUtjQSIzYP4wwfRbeZNUMHM=;
 b=L27rZj6zG1leNJ/Vl077rMVSrGg89WCF3Tvnpk+tdyyOshQhaWEzH04zLZUfbmlL3jMPXSuCg9YAO2yYUdq5sVX/0X0Ez7LSw9XvJMm7J8CI1lZtVG2KIDXskjk3S9XaSsE5xuXn+R5zARslavyZbznyDN6nT+anIzaKvapVqxKKziQ8T+dViaZNOkslUtNEhdQdp36dVgORzMvizi8vyZavkaekKWxVX/P3FRXCsIGUHnZnXjdvKCbPK3sb7p7VnT1Ws1lqAMjmh8CDRiOKKU5hYLaoO+KNqDSTxe7dldjBoB8aooZbpPpw4OGVuyeFrV5/niBCNTsrEizOuVNqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/lVlNOphIqwV7gd7B24SUtjQSIzYP4wwfRbeZNUMHM=;
 b=s0G2Z+Ur0iBTqtad+n7oVTa+kIURb6qF25rnsNPKcG6mQMA2e88rEWmKLgxTZeZJlGDvswtoe6+heSWef0vCpDds/VJ96NTgjtgQMym+P5mGdoYjhWMxxz9rbpadsa08zxic5h2jZTr+A/MLfMMBVpRVMFjNI2R871hp5kaX/UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:44:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:44:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 5/6] phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt property
Date:   Tue, 16 May 2023 11:43:28 -0400
Message-Id: <20230516154329.3155031-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154329.3155031-1-Frank.Li@nxp.com>
References: <20230516154329.3155031-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c710f7-60e9-492e-686c-08db56246505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fs2Eb62SXSnBpiqn3JIxT6ST2wUK6LPexJeHly8AfLejfzn2ykEeQ44je1erpZ6VnR15K4Iu0nDdRoUs7MYubGpjojl99iFBlm6uoTES3QqBYbysXMHFLuQlMJUB607zv3i5AVO/JZPj4tI6sa8p5nCE6n3mGn4snCCwld+bbhNkYZdNnVjjFKUu2LNpAzcrRSvkReYXOrSWfTzDU79efhaak8ZjHhWE5JB/tz9qmq8/Xjh7oGZhBrAbtHqkpdG2VOClb/I1STgCbzy/EHTEFanzJEvHtU672i9/gBxO4DHtbT4Z7eCj6tIpAfDXMHWhRJbnDLNFCawFix5rLKM2j3HtQVh/7ADsADpK3A6R3bFpTa56X3D6uWu9Tr67zg2UHB/DhZ00vkaZXgwW/E/fm3Lx5aYKfYkyPY2cPAv6i3EVM0GzL7lxAsWUzBSjWOpIyogo81tbNPbB/pNxC91pQNOP5yyEcyqUm4PcwfkRy+P5VClXtUeipvonX4dUZklEI0yu/1znANNd64PZhnWbCl+1JsDBNejM3dxnTLIGjMPPDQfTubcEg/1I3xPSUYdKnXM9RN3Hc/Y54GIVdS0sMiy79HNCWCzGVEEmZfOSTOSHLtqdwF8dZHmuPATbe4Kk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ydWo0A525b5zZA38kos5qbMyTsmwM9O9vhEO6qoalB9IuyNzTJgbL9V9as6?=
 =?us-ascii?Q?6xEXVm3oytvIZmdvRVSuExhwq+L4xFpzyaOW4JjgrXk5buUqU8VOibbRHNw8?=
 =?us-ascii?Q?4rd4LiF+kNsCWQbDb98Gxd0ff2qBM1fJSqJSuUImvh3TEy0OQp5UC+ipj4Wz?=
 =?us-ascii?Q?5c04r6EOOcQaDnFOFhCK1HLLDZKPOXiHMZ6W1L1+rTpfBpowmBleCiaz3Q1c?=
 =?us-ascii?Q?/OyeEVB5X2MfibMGPR2TIgRgUWZGP21wHHCnemQzow546BbynYxtIe1uZXUW?=
 =?us-ascii?Q?3orqxkOjXK0C6OXsU/8IWPfTkkyn6KXe9DPDl/d0vJ1tNdPOEVabyhYXDQMD?=
 =?us-ascii?Q?p1ATdzECbjh1v9S1xwPBZqQU7Ta5G1giNDwxDSlG8Xcx6JJNiy8DA+JN/vSt?=
 =?us-ascii?Q?nWj968UhwJRelDd25IfsPngQ/c5pX4wXRZkF0ukJfwVIppd9l97tU9DOmtwA?=
 =?us-ascii?Q?aLR/cPeykHBwlvhMlCkWr0O0yh2PcK/ctgM17/85tJTIln53mKVDbKcS1ClI?=
 =?us-ascii?Q?VueF3fgVRWvSAfTZRirswKccjtTAWVjFGFiQZWh6f4L0QEApYWVQvDUv259C?=
 =?us-ascii?Q?cvK28odUS2mkUs9c4MpWroBFHmOCp+PgXe/9spGa/dfB4VeeYUmA7OqXfXku?=
 =?us-ascii?Q?R4DpUuRRGPEo6zHh5kiBfwjS5pn/GMMrqI9wSAseqKtqA+po4683f3BepGBx?=
 =?us-ascii?Q?1Ql+UaOf9SKdEtPAydK6bbaL+HQnPSlBQPMz9tdI707RXAR+mFL28u1lQVls?=
 =?us-ascii?Q?8DChA8jKFWAHR8JYeFpHmuJdzSRvnctccejLsfbbJEG4urNHwX2rWEc0mc9q?=
 =?us-ascii?Q?k3AzuFLw7N0LwPHgdWlLje9wM1vHdgZwvObf0qHBbs5keFb/JmwHDffSrRiy?=
 =?us-ascii?Q?d5YnMOW+4WWm5RrfipAD9GWcDF2yCMdau5u2plsq/xony5e7SoT0xxaptouX?=
 =?us-ascii?Q?fVUidTBOeGlrZFKZHW9VYnvBEwPluiyu0zIeNw4qA4u27rr3cX0+N2KX3OvD?=
 =?us-ascii?Q?L2TwOOClqB7vXcXRY+FNUClbIN6F9miiuml3yrJuk+/PWIg3DtiwaCf26LJ8?=
 =?us-ascii?Q?unF9TBDZmqCbB2c4wV/PoPM3dDbENYXESsa6BLf3mrT267/N2wPlcfKpWIcE?=
 =?us-ascii?Q?8PNhmhRJvp0eJOEocdNPco5jkQUmGq6g7WKkeuCpktREcb/RitIqupBWhBVb?=
 =?us-ascii?Q?sMgB84n30RBvACK/Z4m7OfzdKaFLSl75W8G6REE/RAZAnT56IxBur7MttalB?=
 =?us-ascii?Q?SU0EifgRgXyf3yPT6F9tC2XYq2s/nhihzWfKC3bU/gayqOcKSdvEa6xSMNUJ?=
 =?us-ascii?Q?Uqzz1MbEkklTB3egmuIE91g3R3gk1hbANi7Aqtfg9QyZeXIsxlJTdH7Q6Sej?=
 =?us-ascii?Q?xh12uzG2fb6TT07KiebRhoa/ontUMONf8uk055F6hXFw7P4SGi5NO6yOgR+c?=
 =?us-ascii?Q?+qIOT6IZF/UDV7GFwFJN6PyHWAXijeWdTk/nUe/hYlnFgnyLRVUJhaAhviW+?=
 =?us-ascii?Q?6pVM89qzXSHjOrAIqxmxumgmvgnAooxa1VWCLKZObbJ3CJjTnaMDocLUG9Sd?=
 =?us-ascii?Q?MNyCM3Mp+Jw/3XXZbWpr3swsdnENweEg2DJKMIX2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c710f7-60e9-492e-686c-08db56246505
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:44:11.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpRW5rfuFDvZj982nVhmw8THT/yy05hoo3shv3MwFyfU2CmAjtUCpJzTD8nyeImSG+FiiErB5eEaPsH4wTANcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
 drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 41616f786321..881e122f93c2 100644
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

