Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29973B1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFWHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjFWHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:42:51 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39D2D58;
        Fri, 23 Jun 2023 00:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwHaW2Nq9hrOJBPn+nC3m5fjzhpWpMOmZI7buBCqJHp7FztJIVoASxm/DezxA0aNP3NPzgQIKWuEMc7kuLFSMKA7LmziP0wpMto3cJ7Wzy7avpgYRkjyW8yv3nYe1rQw0t1kH1l3BwfppWGCuqzOTNfXTsiiynhR11cQ1ixVNan1iRxjfP6/bctczDF799qAm1JVqinfFn8DrSDg6Q9IMbg3kdfFMBsCMCAurryyvguh7H3kEClRDUFFAHBbKTUK6RHRuSf3/JeYOXgyeiDWapbc1Vz5vIROm1zzY/qcCKLTGFIJt40NEwIwvlYLY4tlC/pDvN9yh7QcCFSo8sCr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtuFjs/F/uhxiQCl/Rp9Lq2hVpLZM5UuhI34MWdoTF0=;
 b=ensoP5sYWNIfyhTrUaRcmRolyB2hqfIJZU+KDoamW8m5wqRc1DQ1Ixv5wcl24REo/f5PCCtX1bFbGYCSD03fhnPVoIi3yUL7mKEUgPJe1u5rofYAt1h6HwtqE1UMKGwAra2Jcw5x/n9VHeyEFh8iX83OPPXiDUda6fhOuQjJCMVNSavFg5TiWMh9l2H4YrKLvzmEZyp5/cKz9xm6gC9SjKfovtjY6Ak07EupcsazMnCEAvaHhyqf3/gBhgfvlFcFmVTPdEZD2i2CWsAS5+kE9KGPzuTXfO2/+mfzlveS2dCU5KQUyzwsMAOL1UMfQJHr4GHZi+d47Z6TwH69tkMoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtuFjs/F/uhxiQCl/Rp9Lq2hVpLZM5UuhI34MWdoTF0=;
 b=Ay7rxIT7wCdEzXoIqky6DkL9r2IjnYhUaFbWEn0PUMJvPhV2d8HEJXhnLRP7QXotyBFoe6J+D9HtaCWEBp7agiLQs82t/FJ5UftJ3Ob0yp9BAydNZJOpneHheB2hMofMX+3NgTuAZPyDSLWnWGFFYJisSnYC/XuggAFBS39UUko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:49 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:49 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 11/13] net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
Date:   Fri, 23 Jun 2023 10:41:21 +0300
Message-Id: <20230623074123.152931-12-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9af62496-79e2-420b-3268-08db73bd4d5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfzLZJoSVdUpvonZ3WVdeDRMvDaP4rMtgSgbPe3QOD7s1AyvD7Sq0Y+lXyvQVlb2nj1WJM8XhFAQ6lTS4rUhdUerX+104zzr3xs/1SRH20IdkEqTgoQqEjLCoggcjGi99yeSEI3X7sl5OfMfdyHfcIrNA6BdHwnya4M4x4aa4y3K9tPBN8c1pdgqAP0NuKb3JdExqAQSFxrx1hAszkMQYsEhWs2GwSuGT8Mxagk8QUCBU2rcHOK7dxDLDDRwo5mqIA40Zc6IqsB98tyEvIeUtBkusjri6wNp03a4anfaqcwnj2jbZR1coxjHOCc5/dBM4lWPAu85F8sHyTbidMtGhbsd4Zf/Y35Haz3luvjloC3SrqdzPxNN4UQIxYUHHcVHAYtnGAK6ViB8QNX5alZJPREn6J3JoIUOkXCe/D2hg7yxm/64gJG5HmV/l35R4DNo20O8G5YZiJdUSDsPbtWU2zyUYZU90SBelE8A4wfMUHxKqWDidy4GzC7FfJdwTwQXgI/XS9wXlrbaLaGBFsTkm7IBvddtZLr01nevxQy7oWNBFKL2hZmcE+lZJYU8/t9JTtpoivSgUgVO+1CjrGc5fge0p5wCQ6xP0sYczw0vHiFjrh3FLbYmpnpcYwP1gomm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptctBSPWXZpJSkTWrqOHfSWXokAtaavX2PGE1Fv1C7W/G99g5oZhd2G48C/s?=
 =?us-ascii?Q?IH2rC/EfAeO7KAKMcOv2q2FG0hWiHCAO3+5d57SEWxIxaF1oam3NaHX8HYrJ?=
 =?us-ascii?Q?D20c0cSa8VWn6zmRVNZ9IWKOK/OBodwpkedK6k7t0hj5vZAn7fA0R+gHON1s?=
 =?us-ascii?Q?X+5YgJlCnHVHpHKptKqLXjs/sXwRvqrkxipQrZ95ozSA2oHLheU9z7KkRh+N?=
 =?us-ascii?Q?lpc07XINOB0f06Ictu1Bw7+BYyFRBfT8cWXQMlDZMhdgDu+EB93xDffL0xei?=
 =?us-ascii?Q?TNXDt+cNukuxi2st37Rvy7qP921FZ+xZfbX51n2wOIEia1w5/7FTvE15KtTZ?=
 =?us-ascii?Q?2DIfkn98YkdDR/4OyWG1H7M7Cz9KeqJC+2RXf3vzxqc6l1o/kDOTcksd56kt?=
 =?us-ascii?Q?w1HATcP0S9/Ugw6p7qbj4dgLbHXQunkAojrBzekDw1vBIql47MqOmCIiMa0s?=
 =?us-ascii?Q?hNsV6mpNS+OOcQ6b6Gg+SJDOuJX860s4qKJ8DYMXzffSuwYtCOGKUUNd6ZTi?=
 =?us-ascii?Q?YPTsu4quOFVw03pwkLWTquWTgSj+TiKAvXKnlXBwoBR71D1UbFPbep5W/oVl?=
 =?us-ascii?Q?kXoCE7ZM6hMxgC1+b8HSAtyOnR29pPhANUx1fB1zr6AOrLy2QCAHHUU7RPvz?=
 =?us-ascii?Q?YOOKIHSuXRn/M5+eB47a6FB4VGFazD/gzzTvRiEB1vlLF7ec8Qs2Xak5w0Jk?=
 =?us-ascii?Q?H7mRLxNUk3yBaaikcFtpjV2yozw3kiuhok2G/gGvDDWRgZmxzX72Lv4mWedT?=
 =?us-ascii?Q?/1rc1CM92yRRR/XTKKcNu2PdEn1KBPpBpBXMhgxdhLOiv/5toVnqXq4n6oGd?=
 =?us-ascii?Q?sUFceDcU7Db65lV4RMjiJyBTfsAANcwApaEvkv8wCTO+pWVtnq5YHpPEJ06L?=
 =?us-ascii?Q?l5bGwzd7mHY1ePWb33c77qB9j8mdiTlGM4C8YOJHCqCDNeZlPyWC/HQj1ucl?=
 =?us-ascii?Q?ItYccougC69aXYFR/xDJuFZFLtCGbOu08WokaDhQtRX9ea0XTAINl9gSaSLh?=
 =?us-ascii?Q?DsFk0y+pY2CMJj60L9E5h6Lo/ykUBjvzEcUG8yUY85RATFkqGAdcA8+z96k5?=
 =?us-ascii?Q?HzRc3VCi/7qhYFQ6hpQLa8l3QFnjuX1vx68JKVvtzHlsj396cQcweqeuO7uT?=
 =?us-ascii?Q?b8cqYtBit0UNajPPUBRjxlMdSXox8ff5perE2jsYsM/yON2O7VirXLWsW1r/?=
 =?us-ascii?Q?c1GJMdhrzkhqb/EQ0A1FcCy6d8lGQBnlMJt4XytKW3Pqn9B4nlB0BGxsZBpT?=
 =?us-ascii?Q?qKr3OqPWnqAlk7imySwe2ynpUrzQNIFojFP4Snpo2rbvWDQkIZl6i869FY3C?=
 =?us-ascii?Q?rAhoI2jYZfDE5YmopKDymjBPB61GlsTWT8PWF51Zy60I1iztJH/5H/UVuPO6?=
 =?us-ascii?Q?cFxo6xlKFcJQv47JMNVFJiZuA+26YBHJFIpWXGNxrSdAXu1en8clh+fkamkE?=
 =?us-ascii?Q?u2HlvdODhjQqzE8J+clo3DyCWqwIjprHhUHPzni8YXvwwEK6Xko1xOMEYflQ?=
 =?us-ascii?Q?p6aJ6akmgse1taxlK/+v/uuiHUCcKy4Uc//oqcgtLVFsFEhhyo9ycFXX/nUU?=
 =?us-ascii?Q?kQS56sHLg3WKzmxn5KDiNinblGwIA4PfOSi1/r6esGsP9Q1c4dsbAYYfUmIL?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af62496-79e2-420b-3268-08db73bd4d5e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:48.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHoQ+qe9QiuIMRNMZaQIe9UvlZjAPuUUNiYkQG/MqVLRIXObeLgzGQK+TqsQILlVivsyiLdBsEusFieiOp12TrUuxMpO2/HH/4K/+5thIcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For TJA1120, the enable bit for cable test is not writable if the PHY is
not in test mode.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index a826c845ee7d..8097ac8d6962 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -145,6 +145,7 @@
 
 #define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
+#define PHY_TEST_ENABLE			BIT(0)
 
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
@@ -1258,6 +1259,8 @@ static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
 	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			 VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
@@ -1299,6 +1302,8 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 
 	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_PORT_FUNC_ENABLES, PHY_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
 }
-- 
2.34.1

