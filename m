Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E240705286
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjEPPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjEPPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:44:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F3903E;
        Tue, 16 May 2023 08:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW4ap3IEMA+Sf1A3RGAXRrLMK74J6qfW1iFDI4CYQcUEJxvzv83U3eGbHrBBJlkQcElSkoEmKHbKsuWeoEJELfPxJve9Npzz5wFRNkmU9+MsRERDLajYU177tTOMwtoeUV3OlaEPRsnyS0lHNAzQBPJu2YaIyfOGoB1n7AOS0X4S0wJUqnJrxasTHSrFpaTGmJ4weK16hOZc5yaJ+/V6dmUeTdfBEFeM7tbf3Dfyg+29CBEzviuA0HIJifrADs7iS2I/r3dUtCnqpgu7YAs2E32T+LtK6O/OR+66IyMrIgQmGCMJ53VNBYl7ixqRfkiZyHMdSLSf+9v4u43rlzsWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfyTBntrHhznKwROVl9ztuckaXm7F9o2ME94+C2yLKM=;
 b=g6KPMk/k4JTJ1OmVyG5kLCj5NdmqkKUdqM6knNa3N2LPxjVqkS57kDfHP4ijoaWAiRS/BAoVjYJtLsrwacffKqP7r51gvhl42dIolzf8dZt2sYkyCvXIKAheNtytpOCtQLv/eqWtkMd3YsZYQUExYh7akggrC8ZKZW20D23m5ywTsdO3Kzd2q78eJJW06lrLs8H+GopiKSnPBZvIItFbrGki3agL1qq97bmU51Cexlu98N4eC9tPLaj1LW34j/g4Fksk6P7lqoE58McXNBbjyu/u7AhCYweeuJoSwNsUcPdgilIlGD8HneF6dhlSkqnF1tDnS1EJwyyOphFQyAmDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfyTBntrHhznKwROVl9ztuckaXm7F9o2ME94+C2yLKM=;
 b=pQrk4gMjb9phdi2a7+MAY1GtZV9MtXVVPxNtPFJoD3wM/YblDfaKlQ6Rmf+/IydbkDLi/B4PG4hrPW9JZPU6bK+7HZctovTnIGaLehh59htIsTSA1Dl6gvKPHRTSbzYgImP9k0z6TjHWzp2gxdsc037/ztptxj/+0inx7V9tH6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:44:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:44:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 4/6] phy: cadence: salvo: add .set_mode API
Date:   Tue, 16 May 2023 11:43:27 -0400
Message-Id: <20230516154329.3155031-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3173e04-8ec3-4ea1-8ad9-08db562462f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddUo5WTzshj+rejvbS6vcA1xgXXMmjY4VhE66cVUTnQ9h26doizT4/2JVrEHyBJb8QXkRUnjVQB+N17HWJcZFNlawMZo+5kkOFlseGmKOrb1BRdrzwaUS6HdmdQGqbKmuZqy0RPg5f70A1SAKXpew+R43nSjvm+lBkcZDY1PMN+Y94gHbc16d4jvhU9BI+NVxnvVfqPoFjhiQyo5vvQGP9/pFPX7IOUXrCG+wLs/qLR+ZWy7LMzPc8RLG5WNr9XYZPiL4JNJIPWxrAUmqeIl4mFLfoPf6wWIuSQ9idxV0eHP2sVRmyhnr4foaIxFE5ZqDbazKOOGA7vou61CA37REOyz1rLfBNPNPf70tpzyfIMZFT8Eawu7DHZzNrDRFoqy+lvnK1HzsBGBbLRjb8glTQgYuOHocpMQyQfqJOYfjDm/n2nBWBN4aPrDrdLO/iwv01vYgGl9LARURfDYKVLkbFpQD0Kr65RuEsKRuDqNQpIeRIm9BqqOYUGXYUqfgCCNr0yWhEqpAOD5dWJLKavC/vQ55TBiCiZupXLnZxcZ2CIN+K5wkfiPwnlNmECNz0UJUfa7wo3Zf2D7tSpulew+HGxKoQBF9ZjsetGczeChA7hobG3j4mbN711Gv+LRkrlaUBhleDK6upA4Imk3oa6vsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(1076003)(26005)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGFnlBLvXqbhG8qGxCo6Ari8QEudM7dYm4+0GHXl8+0++1ex5C0XfrRuXgtj?=
 =?us-ascii?Q?pYzzkj0W0fJQK76oQ4UjcfLucSyabLpd5YbJ67i2yHPCsVNunX0OneLGcggo?=
 =?us-ascii?Q?zzF3iTxfMneuHObvJWIlQCrNw93AqsmSr1AaiSVu5qJwkPTaopMx2cSGopk5?=
 =?us-ascii?Q?bTT90dJsRZkfVQSrHUz4co8J6lKS4evHim5sLN1mxkaxCV1Udp4jyvrM1O7Q?=
 =?us-ascii?Q?XyfrmfDorA4OGT37kgjvjao41ADa3LQ1F6Qbw1FE7lZVRkQlfpWXUT4f8dCQ?=
 =?us-ascii?Q?gbnUiPbAGmpFzpNWoc89aByNx8g2iwjDv/J9MhJ8MpLPJOITpedWtbqzjRqt?=
 =?us-ascii?Q?5YiUpIgXqQtUQr4QCTIoISV8Cl0y54jbDsfovtp41nueVFj8+6YasSI8Sory?=
 =?us-ascii?Q?o7SiyEszOKwrIyXAsirTZPmhjULFsgG9sjeh1qwbCXTGf/Hb86qQ7MRzJS3n?=
 =?us-ascii?Q?lW9yMoRS1IJP2CIBFxOe/iqIgbJTI9cRqYoF4Q56gXuG9wrU74X1jR8NzJDN?=
 =?us-ascii?Q?fD3xTwpoaTmZUC0xQUXejtOqTDzKQDrNGvl9wve/1og5povKsChqiI/fjizA?=
 =?us-ascii?Q?rzqUQMMZwXGDZxf3uhRdf5BSteaMVIJ3FHop431Zcyc9J+YGWOi3IJI10eKO?=
 =?us-ascii?Q?/N4mrCUacp/E7KE8gzOj5FsAF2KN/7PSm8t9WntQlRWEugquziDSLJ7ze1Gz?=
 =?us-ascii?Q?LRpgaYVEvxUfiNSC/Yo0NS3m1u6A2o0SW7vx8j5zsGVH58m07L2yJdpR40hB?=
 =?us-ascii?Q?XGKNQ13LfxXkXHFWvl91ia6DsOrlcs0IMnsdVNRGKu0PghcmYegHy0mxqEJU?=
 =?us-ascii?Q?c0hcPKZTVGw6+vb8JEpmxX6WeZWAf10d+LN4v5K9MogPG0J8Hc03ELAX2vrR?=
 =?us-ascii?Q?fDmf2gjapSSWQCi4Q7IhCsmvEIdXKchPcYX5/fk+Wrud57LcmQ3kAlVIucHZ?=
 =?us-ascii?Q?OrulkGTeANNkhmSG0szLbSWoqHBHD8U5rZndxQg83QnLpwFp5IcEdrg9bct9?=
 =?us-ascii?Q?XgFAS4TAI5UezrzlLu3VCb19gsKEO6w5P4+iz7937xa8PMin+8K5ibHzAtpy?=
 =?us-ascii?Q?Hfjo0ThInfdnEZaD9Bnaymc8RV+PDKjHWEjkjSAgwDCmD7g6q/58K2bNhUZ5?=
 =?us-ascii?Q?BNQI6IYord2raNYrz1Atv8nboPmiEb09nq8qhfEfQMv1Ww7O+mzD1mLZvX/u?=
 =?us-ascii?Q?lgPCO8oOh9Wepjve2eaVL7yuQrdw3vvBSjVItddI2WhX6q+k25hVxBIfGkWh?=
 =?us-ascii?Q?vd0zxszcga7iqkaeP75cdlwggsnljHtAcMQrwCZ0+iUVvh6xpYyqneqFzX05?=
 =?us-ascii?Q?/V0wE6ybeEEmLZ8jotbX5RBn5j5rWUUww8+6yEskSkopw5L3VmIOgl+a6FfR?=
 =?us-ascii?Q?mwRBx2YLS2DnCWWJqQgEMPozTErdzD2kDBxkv/gAmsxvqDvJhe0+jXLNVpm6?=
 =?us-ascii?Q?NjfhJuPD8Gx9kWlkc7SDrd6fSm5CjLtsN23O8kN1vZG5Evkp00typKiqqeNq?=
 =?us-ascii?Q?kmr5ZmYg8uiQwONaqWlkhw2O6RgEde2hE9I3966mrh5aFrzWTscuBIflaVSX?=
 =?us-ascii?Q?vTHvt0CDwN6hhwlIhd9u/B6ixXZcxYWPbl0THqnG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3173e04-8ec3-4ea1-8ad9-08db562462f6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:44:08.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Ilp+MrW5i0QkyeJmv7oMbvghcvAMINCkaP4m+24MRXtBqJK3SqVFuy6xKXKQ2qpAOQkQC4wUotb6i8n7Z7Vg==
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

From: Peter Chen <peter.chen@nxp.com>

For NXP platform design, the PHY can't know VBUS well, it causes the FSM
in controller seeing the disconnection at L1 use case. With .set_mode API
introduced, the controller driver could force PHY seeing B Session VALID
when it is at the device mode (VBUS is there), and keep FSM working well.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index b9866dc146ce..41616f786321 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -92,6 +92,7 @@
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
 #define UTMI_AFE_RX_REG5			0x12
+#define UTMI_AFE_BC_REG4			0x29
 
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
@@ -105,6 +106,9 @@
 /* 0us, txvalid is ready just after HS/FS transmitters have powered up */
 #define TXVALID_GATE_THRESHOLD_HS_0US		(BIT(4) | BIT(5))
 
+#define SET_B_SESSION_VALID			(BIT(6) | BIT(5))
+#define CLR_B_SESSION_VALID			(BIT(6))
+
 struct cdns_reg_pairs {
 	u16 val;
 	u32 off;
@@ -124,6 +128,13 @@ struct cdns_salvo_phy {
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
+static const struct cdns_salvo_data cdns_nxp_salvo_data;
+
+static bool cdns_is_nxp_phy(struct cdns_salvo_phy *salvo_phy)
+{
+	return salvo_phy->data == &cdns_nxp_salvo_data;
+}
+
 static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 offset, u32 reg)
 {
 	return (u16)readl(salvo_phy->base + offset +
@@ -273,11 +284,29 @@ static int cdns_salvo_phy_power_off(struct phy *phy)
 	return 0;
 }
 
+static int cdns_salvo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct cdns_salvo_phy *salvo_phy = phy_get_drvdata(phy);
+
+	if (!cdns_is_nxp_phy(salvo_phy))
+		return 0;
+
+	if (mode == PHY_MODE_INVALID)
+		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
+			 CLR_B_SESSION_VALID);
+	else if (mode == PHY_MODE_USB_DEVICE)
+		cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_BC_REG4,
+			 SET_B_SESSION_VALID);
+
+	return 0;
+}
+
 static const struct phy_ops cdns_salvo_phy_ops = {
 	.init		= cdns_salvo_phy_init,
 	.power_on	= cdns_salvo_phy_power_on,
 	.power_off	= cdns_salvo_phy_power_off,
 	.owner		= THIS_MODULE,
+	.set_mode	= cdns_salvo_set_mode,
 };
 
 static int cdns_salvo_phy_probe(struct platform_device *pdev)
-- 
2.34.1

