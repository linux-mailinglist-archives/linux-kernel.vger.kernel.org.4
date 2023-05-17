Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B054706DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjEQQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFF133;
        Wed, 17 May 2023 09:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiTBamQwjkD+VKljY396FyYKTwG3rhMlwRFZ5GwETtIhh4AhPdWyffd4oWlnnHKS5xMnsMszjL1nFOfTVzLlSlsdltHRhBAs4/fyIJt5ukG3IKEwUCek8KZniI49ePdmgZn6/5U0zYLb/xfJEPQIAYeZYmx0TXA/EjFrrcrKPRonWLB0fZlaaSNrEV7ZD6ANB5cQAHUSZWjKEX4yOu6BBrhJHhx8KBKGGj+aTYhHkWX1nA+s5Yh1gfYJPFwciBJIzErYW1mfTjsHdXAo87JOFPtolna+lXNcXyUSyMmP1amFsGdXuxlBYZVJuX9R/K+RDuTtX1qw9KfPB3eghWSHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEKcMWrG4j00kLtWuBqK7mtLn0v5TER+fvwsd9rWV+M=;
 b=hV3K0a+5ggV8mb/quxiRj5pIt5ChlddAVsWwf5MIbKoExJGvV1ICutYBHiu9OZfwAQRTsEzWLu2W3xA+Qjq+BQLG9mMNhenhUMlfJ0MDo56sgs5XwGwheV7A6oFGNf7ldqumRAd+6bGQL701icfyOge7F8zifGf/AYeRZmS+Be3u+tjPqGzuPWDpP7C28qtnoFaHt8WTM8deRlLYzLKy8ef6u7NSIjtx+Hx+oz3NHOvAlump7Vk5W64jtlF4iYaYmTN1aocBCCz3NrJ+qJvMHOt4Qk5woCSbHHsjaV6NC8WvdEGHBbvVIZirWJxymXud9f+j7hcpvHRUkaablPCSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEKcMWrG4j00kLtWuBqK7mtLn0v5TER+fvwsd9rWV+M=;
 b=YGXIMRGEKMvChBru5TndwUqlvfCKop3a7+YosdQkbV6jI3QPjLSOZl98oz9Ih55vjx9GQD7wYxDMWjNOd3pysWcrgBNRDvtKHTsPzhmTWIP7lFwwJg/+ZrVvYHo59UXUoSSkUi5EF1stlD07vpfsbygZmMFUxq70B2jK3MPNzC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 16:17:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 16:17:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 1/6] phy: cadence: salvo: add access for USB2PHY
Date:   Wed, 17 May 2023 12:16:41 -0400
Message-Id: <20230517161646.3418250-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb388684-c823-4156-035d-08db56f22ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq4Je3dphvY1ewZiVSwcNLOkjGe2Hd2rfXaYXav75m2gV3IFsSMiuw4w1gLIVJEcEDU5v1AJfsrr4afpXcpbx/B1jFwHs1RkDnyRbEToJkJvzxzsb+z6hKpmrxBrvyliw4reGL4pQIlA5wVlzoB9MJfZW5iqPi9PxIznPIJQT7JxOMKf6AExZ8PkmY3bgEXgZ7qZz4ztpxNcT6yZ6ZnagAKRWOs1T9qBbPC+AnrCw4h+Qv/vkC9YmAFFSul4RWxTRDiJs+qm4vGgSzbZzUWEHeFLBW4/Cw1BXCdEA7wSxUm/eE59i198UAhlrn+C/JY+Yhd8/HtBgvhlGuZRsbofY8RceruZJ3Z4fe//daD9AnOb2SKRc7py9gpZQlVIkUQt270SpFfYkYjDfJWcoNoCF0hHImdJsSjTl+IgEDQ3PbeqlYykhyt72fbjjWXMJtp1BdUdWm4gQ9l3rHIHdDuJfTg+MuZVagN1omIYCUfLFtH59zSJ18lc0z/6nu//IlkuA71s/udPp9uy7i3/TE5DNXnr2wBxIFyURfGtBosgY34Fg0ufZDTiEQhmlM89HQ2k3p/GEhvnriYr1rC+JUwfA94/eY2BmFccmohPLF1ALQ6JH9g/nwbYpHRyceABV8Fw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6916009)(316002)(66946007)(66476007)(8936002)(66556008)(4326008)(8676002)(2906002)(478600001)(6486002)(41300700001)(5660300002)(6666004)(7416002)(52116002)(26005)(1076003)(6512007)(6506007)(186003)(2616005)(83380400001)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nvvw9yEHxR0MNgvExHvx9dJAcpozWCcmm8zNOh52KWqhvtYg7ugH/cVgSsxK?=
 =?us-ascii?Q?uuCsONRfUUwlH4q7WaoUSHqD6jMTzf8PtX0hndVOHJGXMHAiR4aWBXxxfFJF?=
 =?us-ascii?Q?S/DdmZP2bgy9rDHV2HKT3LEqyUGTnYyKpB5kDLKruY9pTUcZ1F/2OvRMdsOb?=
 =?us-ascii?Q?qdl0LjVyEQzsEZVn14T+dq5HDb0g9WAccj9ChdLBI9rLhXeUTexppiRZj7uo?=
 =?us-ascii?Q?la1IMp9B5UCnXKBD2aaCzEf3EOk0WDSWnbknrip4x8rXwrOktCIRYlGWw/oQ?=
 =?us-ascii?Q?CaZbAoRuKm1CBzkrZ1uXF/N0ThDIfxwf6hLZQhgzDuBn9wnMq3hrad5AynPZ?=
 =?us-ascii?Q?1vMmk83XLjk8R778j+w980NiecIK2BI3kqWNP9mHdnd3vDlkh7QTt3WVE/JQ?=
 =?us-ascii?Q?tvN0RGFbQM5EVu0IiUnFDHbut60ImGQgMQo7LOfD3AL8XIHF6buDMB3JuCDA?=
 =?us-ascii?Q?Xvh+ggFOYe+l8A+nGpxhkZDLciwHFFaTQKXKPjHmfjdjTTrz9DgabR3CVcrw?=
 =?us-ascii?Q?60I73HKKQu1RPORw2cX9RuvYlFQjCPW0rdY4/PQ5wqnvPQDDxGlyO5j3dAh7?=
 =?us-ascii?Q?qbb9kujZJHLiuUW4Tz+XHW8qwHBhJkq0diJal1exqQsrSKnBscvmYB9nDd6S?=
 =?us-ascii?Q?IY0O2GFYvv5ftZ1QsSYKO4upjyynbWO96Pf/Dz3grjE1MX2yo9/bS7W0qY3d?=
 =?us-ascii?Q?J+V7j0CHigQI2BDt0c9ATTP2E/fy0neP/9asLuoSN6UwojuwLF6fnOZA90c1?=
 =?us-ascii?Q?kfEAwH6UODzHphMuhiFUyQlZ04C+8I/PXlIdZFmhFah/uNmLDwMLg9/8EaZZ?=
 =?us-ascii?Q?B5HilNLTeU63smfanReF2dCGvRUskrJDNin6bwrFOTlZHgA+GaV2VQxGcsxg?=
 =?us-ascii?Q?hGwI+riccHy+O5CpcT+XrNh2jvun0LUfQc0q3PID3xx4LxY/9poKhq7lOsgc?=
 =?us-ascii?Q?iKdtVLDeuQEdM3yKvZyM6WLdRtxWIU7B4EM0NUAN1akVlmwktCwVkRIHb7SG?=
 =?us-ascii?Q?I1GHC7xPgKN9iMHJ/CLU0QYI4bmONslzBi8j4tBPaj3zfaFboR35Z+Yr4X9y?=
 =?us-ascii?Q?HJwmWHpqFZnsUdVGr0XgdgN3saqO0almhMZRdQ1zh2kTpE3++FbkU1/BFjHS?=
 =?us-ascii?Q?ESNG/hc5PHgId7Y0tZE5AzV9ukapjreVHyX7ZaD2aq1fc3s42q6u+sEyQuwE?=
 =?us-ascii?Q?n9ivzehEFkn+VH4LmANHv4T8kKtbqw5ennJ7POIrUvrbRQUpO9MXWKMH/G/c?=
 =?us-ascii?Q?VU7rgp6XKneB+7Twu+AfFlTFRy45JsQwLpLWvmg8px+z+jpE4FK15QQtAUsL?=
 =?us-ascii?Q?lv/SmFY9CyIbbmbYVuAEo5qX5snAXhKky9RduzeouJ2hpl1fSloUCgrivcJY?=
 =?us-ascii?Q?nlIGHOJPWNmx4EBNwv5YyhT7VDETiJh86TksOEHj86tE0B4jo4qVTHcjJLvb?=
 =?us-ascii?Q?QB49d2Vee2W0eH+P1TiNenbhNOyygaL0AtkMNcRWAEG21h4LyFl7vpSXPR9p?=
 =?us-ascii?Q?QLn+W4BqpJohj8jmdZ3axjKb8jEryeyq2Gb/1c9oojsgBPBd1m6FIW3hZ6/h?=
 =?us-ascii?Q?4K2a4EDAHSJDaAnA6fk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb388684-c823-4156-035d-08db56f22ae5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:17:10.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9B0QlGHfZfzhuUGAF5ViSm+mONkLg1jZeFj6FvcXEFJQaaZ2BT9Yj3ZSWuuPMkEkkKwbK4DQyqRAX8E9opuOw==
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

There is an offset for USB2PHY in SALVO phy, add offset parameter for read
and write API to cover both USB2 and USB3 PHY control.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index e569f5f67578..06c5dbdb700e 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -15,7 +15,9 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
-/* PHY register definition */
+#define USB3_PHY_OFFSET			0x0
+#define USB2_PHY_OFFSET			0x38000
+/* USB3 PHY register definition */
 #define PHY_PMA_CMN_CTRL1			0xC800
 #define TB_ADDR_CMN_DIAG_HSCLK_SEL		0x01e0
 #define TB_ADDR_CMN_PLL0_VCOCAL_INIT_TMR	0x0084
@@ -109,16 +111,16 @@ struct cdns_salvo_phy {
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
-static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 reg)
+static u16 cdns_salvo_read(struct cdns_salvo_phy *salvo_phy, u32 offset, u32 reg)
 {
-	return (u16)readl(salvo_phy->base +
+	return (u16)readl(salvo_phy->base + offset +
 		reg * (1 << salvo_phy->data->reg_offset_shift));
 }
 
-static void cdns_salvo_write(struct cdns_salvo_phy *salvo_phy,
+static void cdns_salvo_write(struct cdns_salvo_phy *salvo_phy, u32 offset,
 			     u32 reg, u16 val)
 {
-	writel(val, salvo_phy->base +
+	writel(val, salvo_phy->base + offset +
 		reg * (1 << salvo_phy->data->reg_offset_shift));
 }
 
@@ -219,13 +221,13 @@ static int cdns_salvo_phy_init(struct phy *phy)
 	for (i = 0; i < data->init_sequence_length; i++) {
 		const struct cdns_reg_pairs *reg_pair = data->init_sequence_val + i;
 
-		cdns_salvo_write(salvo_phy, reg_pair->off, reg_pair->val);
+		cdns_salvo_write(salvo_phy, USB3_PHY_OFFSET, reg_pair->off, reg_pair->val);
 	}
 
 	/* RXDET_IN_P3_32KHZ, Receiver detect slow clock enable */
-	value = cdns_salvo_read(salvo_phy, TB_ADDR_TX_RCVDETSC_CTRL);
+	value = cdns_salvo_read(salvo_phy, USB3_PHY_OFFSET, TB_ADDR_TX_RCVDETSC_CTRL);
 	value |= RXDET_IN_P3_32KHZ;
-	cdns_salvo_write(salvo_phy, TB_ADDR_TX_RCVDETSC_CTRL,
+	cdns_salvo_write(salvo_phy, USB3_PHY_OFFSET, TB_ADDR_TX_RCVDETSC_CTRL,
 			 RXDET_IN_P3_32KHZ);
 
 	udelay(10);
-- 
2.34.1

