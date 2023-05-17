Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F47706DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEQQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEQQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BFA5D1;
        Wed, 17 May 2023 09:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Gd8gxS1WJVIRh0ViPpcsd+g7AkgC9aWR78quKCZuH8YKrgsDwihHDG5PPR+4BZ0PYnFsp5rZc21rU20DQBcRsXv9LQMf7BGilzRUfCZS1D280QZWAoa0xlmGUmdaS/uoSs3huHaje2GCvlGD7TF4206w/rEZGMFD8uvBRb1qt7gL6nGxDNd4CCTBEKkQ8De78OxXCF2nnvrLHvgwHsehPLVg2hFD3x7v2/kr7WP2cBt/UlajlKwTe3Fe01ATOVhQA4doNdyx2bF5N3LYSh4MzVXvPgRUaw69rjo2VKzHEVTX0cL8Al5uSYlaus/3jIk+6Wjcw7p/bPwxMAnrMjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f+b6cXeWjgCVkuK08UozeofpLH0pNg35r0cKFO4gSw=;
 b=Fdyrts62xNqWd5NrThZVOtckM7O4SYTta1dHNlUc6Nk4wS1VKDH7+OBxGYobN44wHZTjxpsxUsef5g8cclwGduxzMkinQcgWPvi4jgCkiYUN0pgVE6KZUdj7SN0BgP6/p5RB7l8r9KS+ODWCz6op5IKdKrPkTBtGgzyWG22fqxwcxmxHWMpH/g83UtXbXTd38JVcD2XVJIqxfXX619OTJiAfnsO+AnIOnp4XLvAa8dtff2SNonoImXB2856Ip4chFtRHXrFUYjWGanu+SohiJCXom+sGSNTrYY0g9I17B8Y8QeIP8XRImMzLPqDmlI4slavDFe6Z2FSs/9AzrLcz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f+b6cXeWjgCVkuK08UozeofpLH0pNg35r0cKFO4gSw=;
 b=YiQoJnhI2/J98wFY8z5uQVuHjwbIjI4us0QKflETNx8t2YycDP3NIEq9mzWDlMqqX7Yj7aNw8xiEprR+H0nQukMm2OQeVfmjKB5ObHd+ivtxSsBYrWCAky+HczAVVs2M/IWvcT45xJiBJScSS+EIKIbuVmjeukqhN2Ryd8hlISQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 2/6] phy: cadence: salvo: decrease delay value to zero for txvalid
Date:   Wed, 17 May 2023 12:16:42 -0400
Message-Id: <20230517161646.3418250-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517161646.3418250-1-Frank.Li@nxp.com>
References: <20230517161646.3418250-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: bc523e6e-c651-4331-6a7d-08db56f22cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYaH0m4tckogfYSuvIa2a02Rkmk36KdsQLbbzYBeJNqSUrcA5sEi2HC+MA85kRN9wJ3+sSKUaU8cC059M6ikkWaDpPphpG99sdVPoooAZEHjuYb0pAidU+SFYs8aq7s6uY/d1CrGYzTDu7BkOJSYjD5LsPjxxxX0UCIzJsWiKUKiIVtoCGossg14h8veTmsRizR2+Xma9q2x5fwGlPyUe84Ag3I9YoWHjNnPli6O0zAsOQiFT6et8Fa7SPs5I1QZgfcnZZ6c4oXOe3oZ8st0paXXsEKKGlpqTyi8OKY4HYmNke2CeJdJo7SfWy/Oa+Xs3i+pQuf7DRAg1WYPILIpcQF8PujDQyQsL9AyLz/PGwg95P3i4vUFeZgIF8XxhY81W7sAHMmtR16DVToQEiQc8JpkQTo1qiGJBs8VSPTlHuxA3Qt0Lz/g2ymBNSpqERGznFZs5sWi9uhJGtOhSku0sDW2VFc/WKq8QsbOkcehb6aCvzG8/rsyAn7cnYufUkxJe0eG+koUSytuF6gKqLA9vVPGBWwof7oZTQBUn6WCf1KXfIAIBgwk2XfeiBz4ilMPXRvjf6myvGk/JnLfd7eSfGOjFXaDDPgcXRDLktVCq+/W4qRoT0Kk/cO/jb7pmLQc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/a267PRgOjtBC9XOnJFAzXXTBjTQeHMrUf4lwNCTYY+cVjN4nCdrl85bnYP?=
 =?us-ascii?Q?cYRn80n8CjTkoHkkb+ARlFEvWz2Stm5TjetvsHy9YgrOVHQkcaipJMFN6qGs?=
 =?us-ascii?Q?wK/X3fMQg42xj+NEAUASZojjwgNBd0TvD3d+w6fonXJjwOl9j/d/5yJGGy4o?=
 =?us-ascii?Q?tb93YFZEssS+cCVHZk/QIOLN+LRRBjwm/sair/oQ9zc6ShhJ4tyEE37R8xn/?=
 =?us-ascii?Q?yGKpg+NZ4sluK6Wz+fGIA6yGvFOxkcpB2cHxMBvkD1l6WHfH7tLurDTn/Ab6?=
 =?us-ascii?Q?ugc+fZvBSlSOM31lSy9PuoWktAC9QZ/CEdAMEIKvgZ5ppZvcGUocLdon8trj?=
 =?us-ascii?Q?G51zrarHzvQMRmSNmtWS3kQBLAiwWIXSjDbM0aTK71zP56pEsKU8CVTkss+1?=
 =?us-ascii?Q?Oz/XAqX0agEjCKYmJ+ZxnUNUHkH96OMrZX45j0AaqByOr6z2WH6WOTfSk/q0?=
 =?us-ascii?Q?0m1oWcaXktXQZjWBSvnveo60Ra5NDKi0xj0aEDSOZg/XqWXBJSliWeaWpoK1?=
 =?us-ascii?Q?yFSpi06GvNFLYsQ4A2peCN+rUGdxC3L5AWHpTJAO6balMXz2eihTcTaW6Wuw?=
 =?us-ascii?Q?etQUEPtW6YZf8iT6ylr5hvMPs3xuXpbPyipzqHxGaMl40dmvGn8peEpuffh6?=
 =?us-ascii?Q?AL6Hm+hEDE0JGgJJSVXqrmvtJ8rVTYO0FklkW3U5Do69DHdh4CG7c8UbXth0?=
 =?us-ascii?Q?zEz1AFKe62WD55Q8B7TCtTKigvvBP4//eNM4v0pR0nN+VNQe5Yhby+InI293?=
 =?us-ascii?Q?N9ZmDO8WZclwRGPN+4oZYaORhyKcZQOf5DlhNL4F0wbUXB7SQwbLKcYDQJ9O?=
 =?us-ascii?Q?/YrIFv9GFAqqTTL1mmuHn0FLF1wLe7AuCFhO9NfNHfeTKs9AIHdG1N4LhERv?=
 =?us-ascii?Q?dndsBCN6XF1D0pkKE+BxNJqeFe+iSFZt6gXrB07LiPFUt0rqQq6UrI6LXBSu?=
 =?us-ascii?Q?I9yfy1oaCtTsiQ3KVYXPM+Is4S4GoumDcoQwqVFofPAxCiYlJugIh1bVFmIP?=
 =?us-ascii?Q?ZsYUOvUVNlko/FV+dR+JubKTSzFPBi9ipcN6vxC1XN5UdPoUlLTT6SYeTZqo?=
 =?us-ascii?Q?tr8ZlNatsQFBk8v9RdBhwnbD9TbAiIPAoOA/bbte1Lb9C1optd/5p1QlBmzs?=
 =?us-ascii?Q?JlLGFhqRiOezmpCoFcqZuHePEwf/Pp+1++jD34ESngBBlz49W7aefdBWxXqT?=
 =?us-ascii?Q?D8T6TWM8k0HZFBYJRtwiNIObnmnUdoHXNdOSn/nQdc/TitjcEm2RzOf8EKI8?=
 =?us-ascii?Q?HrHEpPWHaJPvRl+WD02J+fonFrVVjLe5i3k4IJ/+LwabX/SLOxYxKQfvdBU5?=
 =?us-ascii?Q?S8MgZrLXSMsFzXfoOKvTSYNAGenMnkzuCs923dz7icX4yhz/pfpARsH/eyJs?=
 =?us-ascii?Q?kOXp7GJOmQ9YUgSaJuf0gVqzoBrnSoeHjjJlGk/uuXvhygD2P7Tl0QuQNxSq?=
 =?us-ascii?Q?i6a1vIA/fObFEhL6zWERdG7rq4xq3JtCCi6wga6zLIeg//aEhp7M1U3hcAnn?=
 =?us-ascii?Q?F5f/f/Y6JhFXdLvMFNPSVT9/BDenIk3lTT/3fiQPkRz8sRx+Mug4s7eXBk9f?=
 =?us-ascii?Q?Ta64WmP10r0S2LsgLuo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc523e6e-c651-4331-6a7d-08db56f22cfd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:14.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrA+YBdfx5oiUquRVuUZdJr60DZlZiWI2DYCLfucPiUzDnilmWi1TeJiZya5VWkSWRZEG/T8XRSFJzdo20zbgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
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

