Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149473F58A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjF0HXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjF0HWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:22:37 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7E297B;
        Tue, 27 Jun 2023 00:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqPjHKntaAWgk2A1YefeBpbv0RXFnDtx0pbHTWHwot0EaQrzfXdkWHukivpDN8jBha7s3HZJpijecG+6f5a5wiLu2dL9v7BE7Zvx92V5mGnWqLtSSiKM98MtRyEEqKbJ5Pw0LTxm5BF47mn4g598opxN/U3QmK4gj+3dQ/nqc9rDPWI0KD6tPM+WN2vZicALn2+s7vU+B8pEcFlmZh8uG8sToc95XDys0pbl4U8SnUnCFZX9EFdH2ymYfv+boHi0b2ZPYACR+tozWfY/+MEV3GrBEenEdlTOi5hYOfrBs073WoD4wqqef5G+O0/D5AufWktLkUfS+kTwmu6wzwgcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMZXnkKBo4A1dquBnTEdn3tY6cHET5be9BRP2PQYBbw=;
 b=YMFIFTmrxLk1Q2397mqdl8d/AOUoOLqQiV/GpkarHYJg/NFfoBpY2sfsr7EniCnG7HvgkVA5LuQ9vco2iBW/CdbI8pGLk+tnvNuyF/PNfomRaPi+zLlQyCY/dP6iJhnCm9HZ+ZO1gBTeFRopFcwrBVNgFVbjOIVSiteETSZWxJWBAc4gJvM1y78J5ebT1R2jkE0nG2CKmBhyYm/uqqwVUy/QeLlouegXX5EvehCaezFyWS3MN5ApNHQb6O2bQIcBtj5Oj2KGBNwEMCY+ggB64Y92jQAvaanEZHI9Xo13wXuu5NHEXke2XqxvVEvgDIfguifhMMn7/+RoTFIua7K6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMZXnkKBo4A1dquBnTEdn3tY6cHET5be9BRP2PQYBbw=;
 b=d59ndZnE/EYTPxmnp7k0gwi+IaR2uetQUUfIAHZQgfUrmxwphidr2br8EEXAVB33zjcFZ2KW7PpyHr/KIgHJds1ftK7IGwAoZI45XQu7LP9d4Mi6uTR2AMZY59qSejX6QQjirmECFYZ6EhXA4kteshzulDdETSq+7C4NARBrch8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:20:02 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:20:02 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 09/12] net: phy: nxp-c45-tja11xx: handle FUSA irq
Date:   Tue, 27 Jun 2023 10:18:50 +0300
Message-Id: <20230627071853.106215-10-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 958aacac-758d-4988-abb6-08db76deec2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXdj32GxVdS7+qItIGPiPytY2GgG43SNrd+CKfb6d8SUHF3ZMj7EOUF7plN0+30V3vD7B+5jTefntbdufxJyaScWnJCyf1QlK/Hf4MMmT1E1+xfjD3P5IhBaEMgVSkG71zoSDrZOW1ZWQkP4vwKMicRkVc0kU4AAuWJSxZwIj1+yrY+D4pwJ/Ic+r5J/hHjhaimMxzdrOsqieouL5hh6YllRfz6i9wc8ToUK2ikmEIS6g6yp2rB796I4BHyDPPjO4uE0XPv3OTnjjRFEenVXqMNK1G9W1QrczuNxJPocKTy6gXw9DCGj8Q6H6ZpMoq+Cucwhw6qfhLMpx5I2ypm+JvAjUbIofiuhCtGQjOHCWk5iFE8+z8bOTaiDeCW1CQ5GxtK1JG5Ywxd2q2tIGURDvXj//dnu7Y8AUjlrJbJ7Mrl3JR+fDoX5290BGcDXnw/WJP/VUmPfk6M1XDekciy8WzowrwSope98ceOawRLkDQUIq+DXHyOsGX0v4uYCNDQd/ejI18qD/kFjAW4fC5BazX7BJzHPd/usFri+4ocA/Sfvul0Wu4o8S/i4/m+pNhl8OweOCoHR5d+dWHYHbt9eAzEAswm8JcC5QsCZCSDLHQJqWKnco//SUBI/smzsTnPd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7dghVr/38oVT70WfBTycfIZh+8bf8prrt6XnGM9FO8mG5rUmoiiNIYGI4MS?=
 =?us-ascii?Q?aWhR38rHa8mXwVWZWtUkYgVKLVZJG+J982kOve70O8usnq3piqzZvgCwlBl9?=
 =?us-ascii?Q?hh6LJcTF1PnBj+vz/RbG+jGvDbmrINFvJroxPxukyMP+VINDdfuQoi+P6Tvd?=
 =?us-ascii?Q?+Mcizxg8jZ5PjTtmW5HOSXK8LX1orq6GPrp1WvFg6whjUoZTPKAQXr7KhrDO?=
 =?us-ascii?Q?LOj7L1YnjWuzxa+r3oUDZBIZ1htPIkrM53Yc9WP7cu8R6n6GDDxoFYgLQ6mT?=
 =?us-ascii?Q?4fIUUHAWDS/TdrYIbkKNevtAue3zrydez/7QxnNb/zHBWir2iYeLDoAlbGEx?=
 =?us-ascii?Q?h78eAxo7nwPyHHM69Rd1B3AYr5orqeNvblqxRi5PX78UHn7PdTGCiN09AtOr?=
 =?us-ascii?Q?i0OY1ozRfWCdooJwHK7Q5ro/DPSslBBClNYW2w3yR8WjyBcCZ2fEjByyHfzz?=
 =?us-ascii?Q?JrXc0AIoZPwAQN5fSJzZp81BwftHprq7HAdmaB3vTxN0LWoQZHOmBmhkmwZ8?=
 =?us-ascii?Q?VcYK/rCQxe/iHN0jFe+mKnINAhEnFOeE5X5bglr+YoCpKhX4gQQnzpz8Ov5j?=
 =?us-ascii?Q?acucj7FIPl1a231WsoZt4rW5Oit/CS0EobDaK9ORlMKfHpfUzwhSblcYuDZI?=
 =?us-ascii?Q?4aIzHUt2x4nYxDALTRJ6aT3ooz3zM3Tz5rDz6j/cP/qR0mXUt75Jw09aBqPd?=
 =?us-ascii?Q?2W4A/5j3AvIdrS+fAl9uD7RO1WjE6QlljJqmpgwxfZSsWhvhAfJVKqFaWha0?=
 =?us-ascii?Q?wQmGzXNcgzYUxA/6EN7NcmN1Td/T/dphzGxWik/+5hFYzdCAOCemVYLRSDyl?=
 =?us-ascii?Q?nSRvINklE7rRMZsUJlWT0MWVZswH5l7K/c2LjqA0ed1wwYm2jXYhNo3qNjId?=
 =?us-ascii?Q?4z+kMIETijTPk8fn7YGlvH5GfiDdJBWpWivIJ8vlXBMs/+jjxF5MrWSXKdBW?=
 =?us-ascii?Q?EnRsXuyHaFarKpcW9smwKxJ89qwxd9sM/AJtVBkxx/XON7nWN1abHeI827sX?=
 =?us-ascii?Q?JC3PKMmhp7GcTEWRKKE2/3bFGVM/kixgL6s95Vjt2q0DKDrS04swAFAo3CCX?=
 =?us-ascii?Q?2Mig+cEyCmKBc6ZRNdfiO4vOOhSpc+Jvk1C7J1cchsM0Qt6FKMWcXU5sUMDF?=
 =?us-ascii?Q?Ib9SfD+slMPq7LZLA7zlpLKwTcb8nAHvwD/AnL9C6nvkv/w8DqZGzrODMHY/?=
 =?us-ascii?Q?XkajkDj4qRk2d0oYTVj7QwQ0EbcMEiZs89b//JzQSAI3nmYf8o7eI9Ga8uEK?=
 =?us-ascii?Q?mExl2zTstBgeBy/e/q2C3lrTuSREHDbMMOUzlstSRAkLxUyRNuGY+/FHt070?=
 =?us-ascii?Q?N9Z8wRsFofVfLIBfofBRiWA6ydvtKEQ2gQdDFOfQ/yilJb3TnKK5oKfeKKNx?=
 =?us-ascii?Q?IfHrJAHqrxw6SJEaulI1xYPJygd7knztvwaUeHafmcEmEKdDY5hEmYWfbPXu?=
 =?us-ascii?Q?Yvz3Ld7N5W29GWx53sSXklSiJjNcZjxXOzHvN+Q5siH1ufE9tJw5qaPC697d?=
 =?us-ascii?Q?YoandlEwlSFFJgriV+/8OPSTNAFTkhMIXWnu9Vqiup7gVirJZKdVWOLT7ONE?=
 =?us-ascii?Q?ANRXuBymPQVsPkikscsFZZZroK6i1hI75woahQY8L91qNt9A8JeqSZ7Lm+DE?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958aacac-758d-4988-abb6-08db76deec2b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:20:02.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YoG+xD+rKR7wEgq6Y4HJtWn8b3N3Tu6X+0HAi5lVslW5/YhtJ1qtx67MUYe9vL/Hqm/SAwgvgDGKcnRPnZiUlErt8qmUilMhJv3oZbVRHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

