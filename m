Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FB73F57E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjF0HWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjF0HVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:42 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D222120;
        Tue, 27 Jun 2023 00:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNcywkGKTbNeArAxHyV1lrNJYKBbZdWDZ39Neax8JfSWg9El2/lNfulO4e3yZNg/4dFXCSzW/a6FF4dYgNdvauYQoSFCYMatmM/0YPKb0wQDrxSBo0Gc6P5JRcTtfRk8C9f3oPlpb3raro6wR0+xkT8NbH7Wd3ybh+Y+yJJewd0mVOwiCzb0482E2VjgkCBg2pczWmbCfPPUdfXWy3seDw934ELIVdosI1vFtROGou/EVhjVHHjzE3CAa47dNoYlEOgac0rhScHqGHJ+VazvhXPsY4/T68+HIYM5wbGbZU2DDPaCizBHrFSGrhwfprjiqBbV69BsPxCq3hNKhJwidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=ZYEEfzxyhn65XPwHx4KkW4w5wS222v8dC5rQ/LevWDPiJKA1yxsxHj1xKz9KUbyHd0fRjWrWcWl2J0WgKO8ti+WFiZgOwoQOwP3mnZwZfyg4JVw0m3kRwmHFIpZkTX6t3RZYsMj4bE6SVYqsKrmOL+zNIs7fR9pjLXwqqV4hXwKW0WJhCur5BmOzBjhJO9eXmaehGDQrTYbDqolGZehuLSFWanKHwOIBA0m3fGcQhSPEVUHzxXRLOJRkEZ01FFl/VMgK9MhpsdEQiAUkPUKWCOOmKSGPPXqrhNLTZG/YPaTmsylZS7nGqowndH++bcov3/WGHcdbtQ1MDPEkIL3FvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxMfKSZjw9iJJALUQPrHA+AaTIEfFkPKjuaWkV4v0zk=;
 b=fOg9sS4pTEH55w41yfeUbqnhhFPCfh6s14Aaddt7nu7218zHgN4AN5vYdZdyXlUmbCWqpkyxlbz6wMMj7fiRS9+W6bnmIjRgO8huejFCvnit0OYnW7R5nParTLg1rPhacbSCpH0H9m+jA6gptkJfDiypOVYiKizs7uZxXnOpKIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:53 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:53 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 01/12] net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
Date:   Tue, 27 Jun 2023 10:18:42 +0300
Message-Id: <20230627071853.106215-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2dcbf550-fa7e-43e4-9b56-08db76dee70c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqH4rdNBX4Y+szMXbipApF0VMRjekSniY8aMy2BqEJgUkJ2Dhoyb4GqdFVhnW+pwfYpj+TaLvRpLaV0S4UHvJAhIquqJmFsxrluXVBh6on+scoDlpzl04JCqWM2lbou4SXJW4EehlMkmdFPmO2w+WtbWFSBW4txcMC8Pu5rwxbwFAFkyncSRol3B/nbJgJrnSgPUJz0A7c3HtnFO+1k1f74MhHapRFMdf2SPE3gH+XzAaBx5J9vE34MQLVHioiSsPZQ4Rj1viNUeKkZPiST/mpxE9gp8UqQ5ceubstegA9Q4RubuD3yQvJ5c/qXf4Ax7x5svSdbcQluHzmH/MrrBYeynwnuYHGPX+5mF7p2cR8+Jx6/1p+BDcfI/PEBv1rlJ+dAoE8ZCAmR3gn5CJIUWAT/FonVG2S+xge/YXwAhVIoa5W9EcF/scHPtKT8DitQjca49VuaHCKDpDBBue+rfCtIxqaMVvDkpSQvf5CycCuFgiLWHzLvNSa1DoGd9SERcI3AGOyXi89W6CryqqWvpzEkc+Xp4+i9MaEKxLJmGcrObEldeQrcVafPIS7QW8UIiNr1XAFuQcrpTdkKdSm1lG4Pl/WNr5uZJqpMdkyeba+ttUiHcQ1W2yJMFTBdOTL01
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ap41qdAwv7Krqw3OfdnlH7OQm8UNROxfDhImildkL6pV+eBAZg+o0WKj9Ozm?=
 =?us-ascii?Q?1LH/eYj4OEM+tDbMvyYtEjfjhEUzxyPmZDbSL3nnAGJkyXBIGIP2wBv+KiBb?=
 =?us-ascii?Q?dc9WCvX+u1twPvg9e7epJjC0C0kV+7sJyJ+oxhtNllE7KkH4DqpwxlVB71KC?=
 =?us-ascii?Q?hjdBnJNF5C3MiMqtKkO4NMLGf5rrfVlYtyEW8y6r+M22BdqexZR2dTcHskgf?=
 =?us-ascii?Q?CtSXXRde11fssWe5Kwi7/j16CL34DbpZ9Yqr1/U9MEsjKVDEQCUTmAi2Aibh?=
 =?us-ascii?Q?umhXLar5vXx5pvzwU9PxArNP6TFzHosXAEeprteQwnryebmC/EgUFe3wKJpo?=
 =?us-ascii?Q?ZyWXBJ27DZAhSbeWr5E6C3LOZ3mK6B65mZcAxw2FwWK+9H5X/fby5C2kcZc0?=
 =?us-ascii?Q?WX43Mkn8YBrToEujyBFL1GD+qdhsQSt5aAcBuERSCjrrsiuNS71qZdpQlS50?=
 =?us-ascii?Q?ow/T7XGyBSM2LUHpFKgXdxhXcquARcapfOmU3LeQWY0vFNLep/N6blnO2tUN?=
 =?us-ascii?Q?2F+3lgtUvXu/1bbSlWbYcPqbPgeITs2LAri1JtzfoBnbIMKArPTB0BddrnGe?=
 =?us-ascii?Q?8Vm2gOi1ja/aWRfquMRctL24gyGtbB2TNWZDfLgciTDJICoqCBngbLIhYpGT?=
 =?us-ascii?Q?GRVDhwPh9nNMzPHh4Mfry/7cgCunesJxxg1TFJBDa10qzWJ0sn5Hh+Jx5SdE?=
 =?us-ascii?Q?cc3kOn0DJCAFq26aX7CjuIqbwzlOSRJoJxzAasBixYk7XuD7QHr8n9nQ3yRw?=
 =?us-ascii?Q?/qR14ku63nL5jv2wPWX54g1gjDXca4INtUpEufGTPOOIq4ZpW+G6kyHcUHNB?=
 =?us-ascii?Q?3K2x6EMBsktflKV3iJAM++Qcj1301mbvK5+0b+xVaOgHRH+DEgcVXnQ1525d?=
 =?us-ascii?Q?KUUKv+xsPq82q0hmV6eCOasQruftobqWHO4szC1K0Z97OsX3Xrx9zc4rLg/T?=
 =?us-ascii?Q?gfZVjuuITtrRxtlOSSuC0LKPmRjUE0NwPe+C+Me8wpdZiv4knZuEcPU3cfGT?=
 =?us-ascii?Q?It9R4uyKjuvB/HurrxYyr6bnZ5C+5oQV0eu2u0xIhZuGN2aeEEALhdeRJc/Q?=
 =?us-ascii?Q?XZaPiXW4Bmcm1OLDzsvvBj/IK8GhFpCwkQ+B+pi+OEbFZnmLBCO7zDPsfJOP?=
 =?us-ascii?Q?HJuTO74VgAiPBd8lEf8nE4Y5SdHl27wfKsUhhq0HPgmYDoYMQnkWn7k4vl/W?=
 =?us-ascii?Q?fHAmATY/ir5QS0Vj29zAEApJfgyc8D1UMygq19uLipbji4S90f8oZm2bVYJu?=
 =?us-ascii?Q?Qzc3yXyZMo5JpS+tmlZuGom9/2KkFsGwf6y98mdO6aAJJq8V0JV4x10cqNGO?=
 =?us-ascii?Q?MCfHI5K2hC6qx2UDnWVtKW4DcsQ5fWmHN2CbnRrnCgRphAI0LIUJN8W6By2L?=
 =?us-ascii?Q?g40evs1V1bSh1Ud0n67XgPlbauBuqjArzzb46GqwPqono3TdSqVeDW8OZ2RH?=
 =?us-ascii?Q?pLQFI5u48iB1awZoy+uMLSArZvbPmbPBeDexZTrUmJ+tXAoJ+NiDXUFxXvyd?=
 =?us-ascii?Q?S+8Aew9j4YnFUWiSkWwO47JUgD62j/SzoJ6NDZWHyZzWAUB1POtH2u6/cAme?=
 =?us-ascii?Q?QN41F2nHnSXSUDv01n0X6AFdBVvSIhn3Hdz06kkq8T3xUkSeQruKE+sNjbqM?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcbf550-fa7e-43e4-9b56-08db76dee70c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:53.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nh9qZcJ5j4uOYNuLLxT2xNEIQPRFkhKRVcFl5GtekiXI/sU4MPyJ2sSOhoRuVZGVSB5qMeZuTZclzvXXxf4hLhDQksiP5HkLT4jeYYnmMfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

