Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E373B1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjFWHnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjFWHmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F99269F;
        Fri, 23 Jun 2023 00:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaznZdMYHqOwcIFp5rfvTV11TJ/fb0Kns9WQinQTxW1114j6F1zt7dEmw2G/+LmfMBGcL/xdeEy4xZo7CBsNZEj/jg0wtwnYdNP6MuQQqpVyECH+yEApGCPYCjClvVmymdijSxPeMH6avcbprT//OupBuKSvFgd8iN21aWIxhlZIWgZXoMk4AB0inMJw31L5UViT1Dv5JAimOSU1JSmnWbcyE7zz7dcAk+jqKNt9hw9xX7Ju4WgrNppro2Dkjo6a3n9IvYxD9KgI2/6wesqFD+bQAia3roOWGWl39Vn82aoGpo/UK/3NXq2NEfHJgGlO7Sy4B2r7v2kNeCwcRyZQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UQ4TRwkAvpf0GiLdn1ar/oso1mMU4I9FHYl7KaISY8=;
 b=ZzOI3rPteB/xkwUMsxYgrdy+wQ1HAGl7NUsccWJ1lweQWf6U/i253b0HXjyX1VEU6/Xo8iyKj4DJeZHDDxqi+T91f06bRuiwIFy1GUpjwlpwR5qry9zVGH2DTmqoDr1SGFKfpKcHuGTZHBNPdxO9B9BmW4JcHWocKWzNWHcQkO5Qg22RTIPufyk5Ty6iLvwD+lKqqKNQaHlqQRIFCAx9yLIczjGJKhq3LELssaCfkymEbmk2rzIrxq0Dkirh58sOIAFFJ+lupW0YKcq3bNEmnExEkrXR+9ifXrr/+2DRSRM01UgIpk2fGGBqU1m0G5CcnF8zsnETMO/wsnvfT+S8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UQ4TRwkAvpf0GiLdn1ar/oso1mMU4I9FHYl7KaISY8=;
 b=GtWXcWAP2RofPxIP2v8Q65I1EVXEvH5brNsXQH+QcbL+x7XGK9V0i7RnUHmOj+yfUfaAmdVSxTwzWqF3mMohxpNuxUVXaIRm0s00u6l07YuMtli4SrD2+C1yIqP1oKpV+Wnnq1LCAyD+bH606B8rtbIUzR67usZt2UeBfRGtn4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:47 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:47 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 10/13] net: phy: nxp-c45-tja11xx: handle FUSA irq
Date:   Fri, 23 Jun 2023 10:41:20 +0300
Message-Id: <20230623074123.152931-11-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: 4339118c-1a11-40da-4095-08db73bd4cc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+Vm1TlzL2dCjoNuAsVuPHaBxYJZNSZWMzpO90+Fxs8tHdG1yNJzwCUtxsY8g/RbQrGU+c0PRyGhx6hmQwd04+sds5IH52oJ8Zw/CoFBaodCthEJ9Q8tYRVublPYlwGX4Y5uWxQ0veDlqSs5w0MUULhR8fdxNyUxOPreHvE+yn4Cl28VjcWDf/CqI8jAW0ZpV3mPfYAG6h7Y3SnZxEok9g0tbYSuPL85Afv7RDkKjt36JemG2roC/udTMKhc+xIL9fxOS90hyVAmakiNG04eviZH3yfx7eoSq5R4jSPWP2QtZQVErZofXtwgEqTeO9ELFFnnZM3MWfMH6yE06glNsGOfjMwfgjKR4meD3MMOTVGgDEZTL9DPqagg8816REgGnmXjTB+Msh9/Amo7kcuAs0SIed8TdEOqss9ucmUgYriNKe9nmcNcMuLeTCuWS5rEzEAElpyakAn7BSAk1UqdyexEmTmRFs3k2Ko3zChlQjbqPF6GpHnZHRltBp79lq3pcnurNW2JQbHhlg3XwvxXXbSAS2n4Nm156m5aNvALAHJs+CsdJE6n7e7zep/1++DBviwgQjrbnTULr0NvVTc10yF9Uueu+PMEDzJTfWbj0V4EQylEL+hd1gZwADbYcw6F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+r+Jg7d2Cxw1Dur2GTH7X7B1rJIfWHiU1cT1u8F/y7wooFwfBgxFVaW/P+P?=
 =?us-ascii?Q?hSUKJjZChsh3fNRDK4/+2oTLFiZQtCtp+mXqGby75aVxJJ8bESpMfEfiuxPo?=
 =?us-ascii?Q?KWBbdNQ2mUpIfLlcYX7ecLJQJmT0s96l8lOTsQIvWsfC8YqxbQtel0rTRdy8?=
 =?us-ascii?Q?e5RmBpUksrEdUUlwihU+v8fJGv4TQ617sLQVs/WZyTO5RMzdCywZAKcOGQJl?=
 =?us-ascii?Q?z8jsYh+Bd/M8aYoUpjVliYuXzBOQS+4JKvwhsW8fYppvZIfAr9LNvMTYRDgU?=
 =?us-ascii?Q?lVG7uJyHYYol40M3mNbBLwNBACDUcpESCaRKJxc+B1TX77bYAaJbhaTLS9el?=
 =?us-ascii?Q?7HSC7/7X4+VTC+K5VjLWFDicCIj6ISBwLkAfbZTqxy/bIGi6A/pa5KY2I/h7?=
 =?us-ascii?Q?JyQprMWgfHfbIWIee6Sw5HPIE+3g1ayqQzpfYEdRrS7iTmULUYL1Q9To1Gau?=
 =?us-ascii?Q?6+//C/JbqohrtcaTKkib21nWsqKX4q0UGHCZbuXnSbiinckIUvgIzprSsNH9?=
 =?us-ascii?Q?09DHll0rssmk3EOC3IPwLdDjfIRngowouRzUk7QTRP3mxttaYRIU1C52PyxH?=
 =?us-ascii?Q?dUGCK24XI5WU33/ynGH7xxsvENeIukKaMOQD50q3ejHR7sqHPTpkecUao/0T?=
 =?us-ascii?Q?3Du/8Fns7WgE6h/ekAGy2WNPRyllVOHT7TVQGLi9QjNnCxg4cRrEYGLee4DG?=
 =?us-ascii?Q?fWNSVzJ7/QzAi2D6ADPVYXeBax7/A0nzExJlA9gmETQZ6dnKNehX2anXdrt3?=
 =?us-ascii?Q?X+KsLttBUMLHMzpJveKIJV1RBTRspd+gr/GcSd2b2aFH/4iAtbFmzovZawzG?=
 =?us-ascii?Q?MIXSVMvOkmPj0Va6jaRp1fys7h49GFKcMaYKhMOQ3ohs/OeOId//n3aEBZ+X?=
 =?us-ascii?Q?XCd4Tx728xWoCjh+mhclB8InZT0y6TtNKj+8yU+eNd2T178tKT+Trp7KPA8C?=
 =?us-ascii?Q?kNOK8wdHC+dRDx1J25h3IPh9Y1HTvc9x+fYww4ar3IrdZ5OBiq6BGQjIv+Da?=
 =?us-ascii?Q?T6pYER5lEeggU+dwiDKITHcr8l1MTHXKhUV8tcVplIozMnDqtWGuq1FpTOTX?=
 =?us-ascii?Q?OnCIcIUm6AY8vAHizt5r3MU8f0DsAWimKZ4xv6EuybwXz4/4fBhiiuLVfGe/?=
 =?us-ascii?Q?gHn8kXr8WUUsVu5/elE72HN3P5fvgs3aIe7MpMTs5H7sUYyHG2HxdPDblV4s?=
 =?us-ascii?Q?0ChW5YpkWRkDJ4t2nYxy2dZK7uFD2ecYd0KKpqn3XRsnmGdHr5G/nolWKIbD?=
 =?us-ascii?Q?r+iRJRPwNCZVkQCooFo+DFhemQGA6M/b3ysby0hyUccmn2YZk1cjyi4ZoU8J?=
 =?us-ascii?Q?HbGXm8FChOU4Q1q4RJ5TpeHlWJFWGDC4ElLgnk/+C/EiJogXeJRpph3T9Xa+?=
 =?us-ascii?Q?w6DJUzxyGLegS3fh1GZoYIFu/U9wWwoEwyLsutfZUgbS8aX94BBLMdEm8umX?=
 =?us-ascii?Q?8bDvSWSjKx/ZyFbX2eY4RIWJJzGufrerxWTsOao4mUbpbIsxy2JwW0o+m6aC?=
 =?us-ascii?Q?cA9AheMHyByV3ixT027PoaGBj1V+JtqRhM2DcQqFeTvQdYkwqPlGL44fjF8x?=
 =?us-ascii?Q?hmQ0MNkEJdrQ7LPJfPMGbiMizjWJSdKLxPzZijZvLN2AyHx4CF7Z/zP6Ppic?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4339118c-1a11-40da-4095-08db73bd4cc3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:47.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPIbvyEnVYzNqCGFAHD6286iLAiMM6ZsINE5cWB48apYrr2V8X/KIBtIt+tSe3esK8HrGh80NZyb+ApQuD1HrfKCIkg2WdmIZ3Vbevw0VoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TJA1120 and TJA1103 have a set of functional safety hardware tests
executed after every reset, and when the tests are done, the IRQ line is
asserted. For the moment, the purpose of these handlers is to acknowledge
the IRQ and not to check the FUSA tests status.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 79 ++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 0567a366af37..a826c845ee7d 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -29,6 +29,11 @@
 
 #define TJA1120_VEND1_EXT_TS_MODE	0x1012
 
+#define TJA1120_GLOBAL_INFRA_IRQ_ACK	0x2C08
+#define TJA1120_GLOBAL_INFRA_IRQ_EN	0x2C0A
+#define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
+#define TJA1120_DEV_BOOT_DONE		BIT(1)
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -39,6 +44,9 @@
 #define VEND1_PHY_IRQ_STATUS		0x80A2
 #define PHY_IRQ_LINK_EVENT		BIT(1)
 
+#define VEND1_ALWAYS_ACCESSIBLE		0x801F
+#define FUSA_PASS			BIT(4)
+
 #define VEND1_PHY_CONTROL		0x8100
 #define PHY_CONFIG_EN			BIT(14)
 #define PHY_START_OP			BIT(0)
@@ -262,6 +270,8 @@ struct nxp_c45_phy_data {
 			     struct nxp_c45_hwts *hwts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
+	void (*nmi_handler)(struct phy_device *phydev,
+			    irqreturn_t *irq_status);
 };
 
 struct nxp_c45_phy {
@@ -1162,6 +1172,37 @@ static int nxp_c45_config_intr(struct phy_device *phydev)
 					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
 }
 
+static int tja1103_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	/* We can't disable the FUSA IRQ for TJA1103, but we can clean it up. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_ALWAYS_ACCESSIBLE,
+			    FUSA_PASS);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
+static int tja1120_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       TJA1120_GLOBAL_INFRA_IRQ_EN,
+				       TJA1120_DEV_BOOT_DONE);
+	else
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 TJA1120_GLOBAL_INFRA_IRQ_EN,
+					 TJA1120_DEV_BOOT_DONE);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
 static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
@@ -1193,6 +1234,8 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	data->nmi_handler(phydev, &ret);
+
 	return ret;
 }
 
@@ -1599,6 +1642,21 @@ static void tja1103_ptp_enable(struct phy_device *phydev, bool enable)
 				 PORT_PTP_CONTROL_BYPASS);
 }
 
+static void tja1103_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_ALWAYS_ACCESSIBLE);
+	if (ret & FUSA_PASS) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_ALWAYS_ACCESSIBLE,
+			      FUSA_PASS);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1103_regmap = {
 	.vend1_ptp_clk_period	= 0x1104,
 	.vend1_event_msg_filt	= 0x1148,
@@ -1663,6 +1721,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.get_egressts = nxp_c45_get_hwtxts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
+	.nmi_handler = tja1103_nmi_handler,
 };
 
 static void tja1120_counters_enable(struct phy_device *phydev)
@@ -1697,6 +1756,21 @@ static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
 				   PTP_ENABLE);
 }
 
+static void tja1120_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_GLOBAL_INFRA_IRQ_STATUS);
+	if (ret & TJA1120_DEV_BOOT_DONE) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      TJA1120_GLOBAL_INFRA_IRQ_ACK,
+			      TJA1120_DEV_BOOT_DONE);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -1761,6 +1835,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.get_egressts = tja1120_get_hwtxts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
+	.nmi_handler = tja1120_nmi_handler,
 };
 
 static struct phy_driver nxp_c45_driver[] = {
@@ -1773,7 +1848,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1103_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
@@ -1797,7 +1872,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
-- 
2.34.1

