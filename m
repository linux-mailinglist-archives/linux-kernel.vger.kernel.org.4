Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88B73B1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFWHlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjFWHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:42 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0621988;
        Fri, 23 Jun 2023 00:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVrK6tOiYGVGPLJcMBHnM7DQhv14BXvesTOlTDnDQmxzUwpTSdw9rdF4+kBY/ircZ0oLwtwCGC//GufxYDcOQOT5NertkLzil6k/ymzVORHJOxuqsVQ1+phwXQILmSCeyGQ0rI6LUdyTfq9vTfkB3ol7zprdL+/W10o4UEZTlBTeKd6Q7kAD9GIYxO56nREO+GCItZY/qk+MYywoHICxoFtteavrfvtI2NpN08W1po2f6RFb06l0Y34gcwJSMW2kGhMdtZYvEWHRXe5bJSJ3JthIc9FeQpT2TVO9aUESPuUy9yoVkmD7se4lZ0aJmkNem/iswcxqy9XA2XRLNSV1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=j2F4XOqPH7LDuqVNes/2I/nozKXgpjC8/71H9EC1MhSlk+ehbEK1TANT65k9T5BNKgqxSiNQWE3JzNcwWBpnr82eo5EdpwM9FLWWkyHFA580krAIZe6bcNw+jCMSULvryD88yTFXfHWTrp+TxJxy8TGyksrgJ+LYdpqyJmpjCP/giZhzIBv+1Rjmu0kTw2tzpqUZDYtguNEXiIMwnO/fW3+GAtV2s7qNpX2EiFSNNFoeZXsnSjRX/rb0daAXABhoboPEBz5rqB/PXhVboDGLmdYN2DXgNiCGW6AqFUXpRcr35BG3EBgNzXMrFCbY+Na+5X+Ym2vLsYeH0FrS6syiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=dm+ZWRlu1UUemrRlUpaT7Bxjdsu12ESVC+IrczW77/E5R/aG9ankafyhFHjEShqzcnEROskSr26gQRnhGAZBYvgkSapDpLHxTIojXVvre4nkyH5hlc4USQA2IL/scCVa580PBaHCnVbTk9yiPWkRKj9Ed48S+lywYi/uFvP+0tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:41:38 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:38 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 01/13] net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
Date:   Fri, 23 Jun 2023 10:41:11 +0300
Message-Id: <20230623074123.152931-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4129872a-cb61-49be-4d27-08db73bd473b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuanLkobmcXgC89q4sCh+1Nt9gpsB5ZODrfkrEHGUNOinUVNgM83kCZyPW1ZhfBeZR6XETk8ILHRiedaA9qEYo3D/zOTIz1A7pqzVA957UUKh4iDdtcgHZ/HiLjjFH3bMdMQEe/UGYViPCOcIKYghp1Xcyd10mxxHE/AdHK630eVT9eiWQvtUzl3Rt4kD4B4N99FUYCge1DMyCU9UP2eFtAhevpoJ60hy5CTPlBHmG2GKiV0lYBLXM5RSrmMtf3/0equgFg36vpRVUfgUOI5KgpBk967CIJCr2RfRvxyaK9pRrC2qTwXJ8Q4AWvmhzSTu/NdMHKJUCW2+5AN4Io7TqZToqnuu41zB9KVHobHgKfnOQVXNZup50NZoMEkOsljAMC4EmQNqZhAUWSxDau0JQUk5VDLn4wRlp7jW9Zp8GzQyzjZxbnOoeu13geyLA9vZT0UCAW19MSkvk8r89fbQxOJNruIooiG2aNSg9VG/7OGu023of1ujU+CaiIC9cQxGvNp+qoupBpsWNO2oHvfGdZ/m97ieIx5dkte4VYPw4ddFXaVO1ZROItineT//WopPkVhDAcVZLKSqKz9sxmpT37Ra2L7z6oS1bL8mN/zgBJ3jH6gscaxMvEgwz+f3K2B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(8676002)(316002)(8936002)(6486002)(52116002)(66556008)(66946007)(4326008)(66476007)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(6506007)(1076003)(83380400001)(2616005)(5660300002)(2906002)(7416002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+9N/TxgN/Pla/Y6C11Mn/Eh8TrRayts3FLhfTaLdTtQShpPWD/iZqHaROwC?=
 =?us-ascii?Q?Wprp7zp4iuuP2cJ6eTHNF7dU4qd2R4KenWzym/LJW1cx+QIHkbTvZIxQN37e?=
 =?us-ascii?Q?nbAJD/TsNFUTJ8PJEOKKLH0afxA9SRpRg6MaWhurp2oFwj+iJxM7Zfd/m62J?=
 =?us-ascii?Q?cAuYqHxxmIlGf3em4Vqf280YY36+87vWne6hjr3DTCRaTe3YyF4Jj3vtSOju?=
 =?us-ascii?Q?oL9MKWNIhsUhXRkQmJb6dUPh7YTkX4RNLP0GagAyO1bodXbrubxpbYazAfXd?=
 =?us-ascii?Q?kCv00Eb3dGFCEHRPlWEY9F6+EY9NhIENggNth8w9fpHcMMZhi+M7OH05e4yY?=
 =?us-ascii?Q?ahDEMqjK7lMutL8cXnX4WKvdup/dD+pDVPm1z0QfGEC/0nfLlN9177Oo3pHE?=
 =?us-ascii?Q?YhjyY+9qsx58JE2BX5O5QoKWTgOeOdOnXsPKPBsZJUuFh09T3kn6M5uwLRSb?=
 =?us-ascii?Q?taLO157vplGTNdr8QUznIhiCtilFPiqRwk+VCsjcgRZZ4Z1JJbWgjkZx/VjF?=
 =?us-ascii?Q?rj88WnUQR/ubtzEb2UXYiLMGVGPrSEEwAew2EorfO7sfNjNvKxaeEwfl29Jc?=
 =?us-ascii?Q?ZfNmZ//dFoPgaXKNqVTnQCKiPOdJTrMLg6T3KRc/e1NOSSUgi4vjLYg85oIh?=
 =?us-ascii?Q?EISZOsiS0Zv/UxT4GogQxGMn/yf6kcr0yQrJiE/v4zkzLxrc5DNmJCwelkCg?=
 =?us-ascii?Q?IsEuozDK6yzhyWXXB9sc318FMqyOxS6j8QbMOeIJQxjm0mToIIZIOJ+0GT+J?=
 =?us-ascii?Q?6ktiIn9TvgIMGrC/Wz883v0QiBjfoSew/akl4VluIFWmPYRaupFWgnC0JwdT?=
 =?us-ascii?Q?Lmae1QhXm2pfpdnSamDQyNnplJUK+On+si7uXbQXPLcf08j1suVgSjbSYVoY?=
 =?us-ascii?Q?GCLteULzKqPnulC6iYeWZoBvGqEaVCzaLUMQTB+RVXQruqP8dJ2wb8KAfYH9?=
 =?us-ascii?Q?FQ94OBsl5Vm6jeyvv8TcI9AGGX/Qi8e8gfQAz8cdBtMByzKxcOkuP0gAjy0A?=
 =?us-ascii?Q?1WGnLT1h7CPSXWEPIoP2ZhyQMyYTfEWrYrkqsgm6hGXbbrcbrbr2yyl2Jyc7?=
 =?us-ascii?Q?7AfQ92q+EgvZbYkC8kwboLwPvvBMBaOse5lONTT0ojjKxK8nO6zDftY4Oj9F?=
 =?us-ascii?Q?kIc8TZEeLrt7t71matwBDZk9flP30sKJU9kQHpHnvzMqBfeZ7RiNT9YaH/Eu?=
 =?us-ascii?Q?XGbi42NiZCGRZa3bGaJSJk2qv4Hu0tm3pHGXOrHPGzXaTgpZ7Ase1XmqDrwR?=
 =?us-ascii?Q?LlqU0gYYnGg2JftmEbmtp9nFHwvwcHn/BvwPy5vJzhJ+OP6I8+ml/P+EcT5n?=
 =?us-ascii?Q?om9ovYwUKOsPcIY4ZbKTQlRq9B515Em7qWKi016sCMtpulFmRlouq/Bwc+oU?=
 =?us-ascii?Q?N6dMsPJ9AdfLp/lc00RcEI/bdRc8y4EIS9/9T6RdXlsWxjzArqB060MN+kbL?=
 =?us-ascii?Q?M3OpllJVo3Ul7rXymWk9esOqpvbp8A+iqJHL0zBdprBQ7crKxy4UsScteeXp?=
 =?us-ascii?Q?FHZjw9Ki2Soxib35+Z84E0Q8LW6xOCI4fYPw6D0kXAcFxVwl6y3eCGjvFXbj?=
 =?us-ascii?Q?ORoDaKshNaj6WijJkmqjNjJWUtZN6MjO5nIj34Cf9oKT3eEGiQpaUvIbBqrQ?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4129872a-cb61-49be-4d27-08db73bd473b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:38.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNSqX4G+znOC7LUE1KNeKgHXfIPrCK9zoe9rOpHCnG/sTvheayni9Ce0Ski+IInLQL5KQGCSFm3CUISlLzs5AVmgT0BIcMe9qFZF8JuSh3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the custom implementation of master/save setup and read status
and use genphy_c45_config_aneg and genphy_c45_read_status since phylib
has support for master/slave setup and master/slave status.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 77 +------------------------------
 1 file changed, 2 insertions(+), 75 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 029875a59ff8..41b8af0547e4 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -19,13 +19,6 @@
 
 #define PHY_ID_TJA_1103			0x001BB010
 
-#define PMAPMD_B100T1_PMAPMD_CTL	0x0834
-#define B100T1_PMAPMD_CONFIG_EN		BIT(15)
-#define B100T1_PMAPMD_MASTER		BIT(14)
-#define MASTER_MODE			(B100T1_PMAPMD_CONFIG_EN | \
-					 B100T1_PMAPMD_MASTER)
-#define SLAVE_MODE			(B100T1_PMAPMD_CONFIG_EN)
-
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
@@ -988,72 +981,6 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 	return nxp_c45_start_op(phydev);
 }
 
-static int nxp_c45_setup_master_slave(struct phy_device *phydev)
-{
-	switch (phydev->master_slave_set) {
-	case MASTER_SLAVE_CFG_MASTER_FORCE:
-	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
-		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL,
-			      MASTER_MODE);
-		break;
-	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
-	case MASTER_SLAVE_CFG_SLAVE_FORCE:
-		phy_write_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL,
-			      SLAVE_MODE);
-		break;
-	case MASTER_SLAVE_CFG_UNKNOWN:
-	case MASTER_SLAVE_CFG_UNSUPPORTED:
-		return 0;
-	default:
-		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static int nxp_c45_read_master_slave(struct phy_device *phydev)
-{
-	int reg;
-
-	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
-	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
-
-	reg = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_B100T1_PMAPMD_CTL);
-	if (reg < 0)
-		return reg;
-
-	if (reg & B100T1_PMAPMD_MASTER) {
-		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
-		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
-	} else {
-		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
-		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
-	}
-
-	return 0;
-}
-
-static int nxp_c45_config_aneg(struct phy_device *phydev)
-{
-	return nxp_c45_setup_master_slave(phydev);
-}
-
-static int nxp_c45_read_status(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_read_status(phydev);
-	if (ret)
-		return ret;
-
-	ret = nxp_c45_read_master_slave(phydev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int nxp_c45_get_sqi(struct phy_device *phydev)
 {
 	int reg;
@@ -1355,11 +1282,11 @@ static struct phy_driver nxp_c45_driver[] = {
 		.features		= PHY_BASIC_T1_FEATURES,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-		.config_aneg		= nxp_c45_config_aneg,
+		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
 		.config_intr		= nxp_c45_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
-		.read_status		= nxp_c45_read_status,
+		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
 		.get_sset_count		= nxp_c45_get_sset_count,
-- 
2.34.1

