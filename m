Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFC705282
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjEPPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjEPPoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:44:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D123A7ABB;
        Tue, 16 May 2023 08:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itXCne8ifVvRC2B9qgDgiu5gLrUXM+aK7ENUSzBfvfbcWIfmLQCMjuyuuMQjWAnLznh7UjkWqoQyJGHg5SUUUfSCtFO2YIYufrkXsv+KcNH58gQBGiptsbSEGMC4LTGwAukXvcUHYhFLmp8snpMGv6U8vpm17nQ73M8INpSpQUFm5nEERGbnn0EIsrz+qZvcPpo0rzXKasWHWkbTy+2pDRHiGsqiabcqQEPVx6UhQTPBBwxCk7u/LPXmfWEQDHzbNY8t/u0RjkMMOpthA1v5riqfI8Al4wGv/P6PnWSuEjxupdVVYNuDoA+WXGtTq6xy8J6+MvRltDXkrTIjlzgrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f+b6cXeWjgCVkuK08UozeofpLH0pNg35r0cKFO4gSw=;
 b=OWzIn5YK0WyorsspmN0sjZ2SaYL/OgcEqUc4xDA1861mbIx0S+ZHVfTnQNG9ry1kzv+SYkqTc/mI6Cg1x0x1xgaCo5FWvVTgWEabd/1m4Xj4OdvdMnMhnjZM/FZhxMV+JtNcpTZsAzC/4m9h4dABieWWcPRuozxRt5s4qtczBf6zfP6v+BZV71FM1dEKmxaGYmXDhITf74NhsLDXA8+iZPwrcLr0N1PADF+8cTSNLSVkPKzXJymYJsUlDb6MG94xuYfbN6AQL3+yOwMBB2q+2BSyPLudkJX4/2JGO03DUlTe40m8fCbo/dsMZtMiQxJqYdPdgMXeCVKEEoVc7UJkGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f+b6cXeWjgCVkuK08UozeofpLH0pNg35r0cKFO4gSw=;
 b=ai9G4BWnmgbnGpA66mAbjpKFHncJaGQCf9uYd9cLDBj+L2jGSJH5+OqUbpUYDxiutRmzFrDLeGG2nOiTkoLpGROYXGt9gP0M+xPf/xGj1TKnISNAI9pxMKggBHBZVG4lHDDjKZnVVMWMuX17OBM3/vk2kVkxpP+GYR3sf/RswMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:44:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:44:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 2/6] phy: cadence: salvo: decrease delay value to zero for txvalid
Date:   Tue, 16 May 2023 11:43:25 -0400
Message-Id: <20230516154329.3155031-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1386de5-d168-49be-d1b1-08db56245eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0k18FkE86NtyNASDHnJ8cBkKPyd+nxzA/G2W2RxN9m2t8HCRX1BpN8F/oTRb3TO1OtcZqao3jJ9CRlWUMppBoxIpoRQcfBLCHTLV6CMf9rCHPEm3dzRWKBKTfYtEcSI56TpMroMXlUcAWtJHQ1BQ0R1HA1MQDOooNLiIEBr9TtuAVuLs/MLuXx94LPQyNbhdXkxLWpYjTf6jhdtEQbn9br7sEWZ4Sk5zWHmc5tdEiXY32ARQmSAWf8Sra7fB6CdKVbt8unuQSfmCT31r5LRkwVxPSFpnDX+Q1SUOcduQO4C57r7o5MB45t1S6M6lYjR87mGFUnHtygz/hHzqyoeTnVeSC4uU+/6AMAHa/cCUwKpHuWjSmutX/0vzTqbzku3UFYEobNey7cz9ZIsnl02GzVet4CAfepz0qbtwTSa7KjK8IzPunBjdIRVPoLCZRbFplOTun2yHeSoNPOS0eX4M7RoCwTl1Cf1eoh5o4ztG1muVqhAU2l1PtmzxvOhPJ6qAZ466GPH2KxGaqWjdtgdGxR1pkK27/8nrW0Yvb8GY9gcNNxKwpcIa+CWOxhFnrieE0lXLKOspkb5wh+3CDVta4Tft2jNuZ3d+JMXos20vS0CY3AcYPckvRxv9BJ47Jij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Efkoar4OANPP0gMQmGgDengs/pKTCr17FJm73aE5Wra62Ou7+TqHTO8CShO9?=
 =?us-ascii?Q?DFYLxtRr5hk9Y5CD4avOUdNkce+EqSJU03WOXGAdS+GqIrvbJVY9qugONM/T?=
 =?us-ascii?Q?TU8cRGnK9yv/6QPCt3RderRoUVzuI1AbcqXSZmp7qRxrTKdV1LEXq7y34B6o?=
 =?us-ascii?Q?W0LpAH/koGa1oZTd5ziyMWRxmKEJMpaYEoGr/geVpB/BYMz0u6uhpFjLwIDC?=
 =?us-ascii?Q?VdkpWecGmCDQLAUqFnekguCbkVZD+XEXYtbpqiyyFJ1rkg/YlEp36GlimA50?=
 =?us-ascii?Q?VdpMjZVmgz4CcymIyWyYnQCx5YxLTheU4BRjoghGdRltUX58p4gelHceSmYc?=
 =?us-ascii?Q?N9zq8KqT06VQL0LrhfGfpGGVk3rU02vqXtfEoiUhrplw+xBXgTq9rkemrjC4?=
 =?us-ascii?Q?V6JrIKBFyHFDX6qF4oUpbLt5SVz5X1cWwR7Tri0T4ptm8Ha8l0gh8K6Prr0x?=
 =?us-ascii?Q?IMNOjDn8nf85Bc567/RL3SjE9U2OG06QShW1aUzrwMpxx1kWqVh3x5OhfboX?=
 =?us-ascii?Q?jj1LWZWzDvwX7NWZcZuSub+669VIrr0T1Iy8jAYqxdYXPRbec5KhVsbQMsIo?=
 =?us-ascii?Q?Ae8hoLqWo24abLyXakQo1Vzicnc+KdHoS3JzWdWL62QBr1ScHAovUPuXdNMs?=
 =?us-ascii?Q?9PnJ79f0ArytFd6sAb4fSDwmN/1FDdbsMHT7a/U3GXdQY8WQOVVv6GBPCXXQ?=
 =?us-ascii?Q?PqVowg145eZler9fpR2M4BOnnrXzgCl+FWjP2pVCEUKkokUQv1rfTkAupOWV?=
 =?us-ascii?Q?ijW1IxBLp2caT8bY2ugejuVo4f7QxrDbC1SEQchA3kYTxCOf5EBHVK8w0NYv?=
 =?us-ascii?Q?syae10XFaPluu0qN1mLSg2U2H1mcnz/3oR8hfWs+IL+ctdUZbypFLHUDHZLh?=
 =?us-ascii?Q?j7aMjuTwtVgnwPowixuvs+cKDums/f7mUpsrLWoX3B0j/a3+S/b25+IFN2Gy?=
 =?us-ascii?Q?O7iKPbX0mk5HV2FoO1FtOBaicwE0pszsGKEwhdM9J4YNF+pUz82MELe1uaOf?=
 =?us-ascii?Q?CoWns0q53hnjQaeF48p0x6oZGnDd0lYwO6z6BqDQ09TltPbajjqSwYAvu14j?=
 =?us-ascii?Q?7mKqk1nlf/B++FqSD6rBliSsNjj8FW7mLqisNbcfUJITbyBTy0QQHVEJgCsb?=
 =?us-ascii?Q?kgTkAeozHSawyNtQfxIT0gNRmgbIwx2+RoqHRzMPDu+LOxP7P4MTZ2Uet+XW?=
 =?us-ascii?Q?Mq42tV7WTY5SSu00lxeknFub+MZaABEpEpQDvsoala4u8hRmaSdyHiQKeG8e?=
 =?us-ascii?Q?FIFN3urduOCLLENTtCdCyC66L7yZaGgb5b1Ddz4UI6duJUPHVIDi+lI49bAl?=
 =?us-ascii?Q?T9M1wR2G7HHZCQomYduC+mzoqsMDXUup34AB9Rq72fjjqknpNiNb0j7BUv0v?=
 =?us-ascii?Q?1G4ujjAyeVhYkt3m8gZpNCkh3SWBssPu+aMRHgCcrJpR7g+q011UvF9UTErk?=
 =?us-ascii?Q?qECoGRpgk4tfjCXT6hE9V2woDOA/DtJN6+FYUQK4yR0X0NCq3a3OcNMMHpJN?=
 =?us-ascii?Q?wlrbdAndX1NdnZImppYj0W4vTEHSr/9sjoVgVzaf8p265qIGI1abWpaXyt11?=
 =?us-ascii?Q?I2ajvIliQZlyEzHsA5Se8b0RkGrztZEDqnKCKcrv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1386de5-d168-49be-d1b1-08db56245eb9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:44:01.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deJTWQXou6iqkrOFooPuM1B9N9sGc0PtEsgtLNRa8V1bFldPQoQZmFDU4u1Xlx1hHLzEOINVZ7pnV57ACFY2dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

For USB2 L1 use cases, some hosts may start transferring less than 20us
after End of Resume, it causes the host seeing corrupt packet from the
device side. The reason is the delay time between PHY powers up and
txvalid is 20us. To fix it, we change the delay value as 0us.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 06c5dbdb700e..2e3d4d8fb8eb 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -89,8 +89,20 @@
 #define TB_ADDR_XCVR_DIAG_LANE_FCM_EN_MGN_TMR	0x40f2
 #define TB_ADDR_TX_RCVDETSC_CTRL	        0x4124
 
+/* USB2 PHY register definition */
+#define UTMI_REG15				0xaf
+
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
+/*
+ * UTMI_REG15
+ *
+ * Gate how many us for the txvalid signal until analog
+ * HS/FS transmitters have powered up
+ */
+#define TXVALID_GATE_THRESHOLD_HS_MASK		(BIT(4) | BIT(5))
+/* 0us, txvalid is ready just after HS/FS transmitters have powered up */
+#define TXVALID_GATE_THRESHOLD_HS_0US		(BIT(4) | BIT(5))
 
 struct cdns_reg_pairs {
 	u16 val;
@@ -230,6 +242,11 @@ static int cdns_salvo_phy_init(struct phy *phy)
 	cdns_salvo_write(salvo_phy, USB3_PHY_OFFSET, TB_ADDR_TX_RCVDETSC_CTRL,
 			 RXDET_IN_P3_32KHZ);
 
+	value = cdns_salvo_read(salvo_phy, USB2_PHY_OFFSET, UTMI_REG15);
+	value &= ~TXVALID_GATE_THRESHOLD_HS_MASK;
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_REG15,
+			 value | TXVALID_GATE_THRESHOLD_HS_0US);
+
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
-- 
2.34.1

