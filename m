Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8973F57F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF0HWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjF0HVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:51 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5CD26BD;
        Tue, 27 Jun 2023 00:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpVIW7tpYxlhVEu17YnuG3bQurawgmwIQWdUSrkAtmHFHujkoKOh2HzrKAX5c005pky7/R1vDltU4vmBST38oW4TsQmcgxQlt464kN94hrim8JBGrBEkSxM/S+Tlf/qGXJd6zbdBEIENduQ6zaQF6fRgqcxuGM+eGIX4J2QHHicoJf0Gpjf1fKaXCHUz0KUulFJ6mRAjWuhC4J6jGy+aFHU4TYQWn6fvhnq/H3U91gUl5TBEXitpMxfcwyvagb/qGw3Tpns/v1sYraRDUpER2eMR/fd4+GCscYFWvBnzRE7pEy7mm4E7Vtunjx8519HxTuVaWIdv3zYx79iASqpSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzsk+mHGXhbZw7I/759xd9x+ML75II/ApusXCe27GC8=;
 b=YzqIG94apeItDopC7l1ok53o0H9ySRjyDZ5UcVYOI5LooGFHClwbqc9C2hVDi6e3JliaRSYGHNTI1mITJyzDFduQ4QsCubkAscw82oQ3dasff8SxORvsUlHiIYfJigawdcXlxtZrx8WCFpyeU/GTl7CGhWeu3pErLXMUBFeym1Ja/6TKOCHw162ndQhiA3KZYTWzAxThYdrCsLMvLVRpbuKYXRdEmvdAuMGy2vPTuQo55LjOGUdduc8pqeeD9podUCxwWYAYjKO2BRaUvr2NgfPJ7mJ1lL1/0KfkH0A7QJ58fXsTvqFGAkV0RU8MV6O50/GiQMhikLJbaVymXiXRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzsk+mHGXhbZw7I/759xd9x+ML75II/ApusXCe27GC8=;
 b=Q6HRSs4gwsWmbXjHIo/5+w2wo0WxvFab4cGJDz51kds8qtHS0nCeEI3LaLTNuvmaNPAeDJv319B7PeJHyDOndG9d4CP/jO3ufMrk8NSS9ZZZGvrge8ci1MTlh5iRAnTIxGKOernbmw1Qs9ar+kMztx5zCic5s6rp7W+y2nnKvdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:58 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:58 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 05/12] net: phy: nxp-c45-tja11xx: use get_features
Date:   Tue, 27 Jun 2023 10:18:46 +0300
Message-Id: <20230627071853.106215-6-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ee8034f-4f83-48ed-be3d-08db76dee9b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMmMa4EAJLoe2WuTODKA0oPfjwTtA87YLPhykHA5qumwDDizV42YWvsufIStpokqJpc992qas3IOnXWQS7fZvFYMWBSqk7YkVGHBT4sQbpBQ2jlwLi+vVGkfeo7uhlGxye+X53nlwT8xdgWvRt08h+tukhq3TRtcoCS3dRh8zcRPmZDN6uKt9q8c9Y7scXrW8Afkl5wh4Ufx6OGmDlojuSMb9wP+TzsF1RTWm23+6SKf/7BHk14RbVCiDNzC7L1AkkMM/SNnKaOArOtE/hJVnxRm+hlsiI5NuIAnLbE/GvQxL6g6xi1gYL/jg28EGqfNsxPLmBGgV+D1qx7ln0Bf5+AzbN3kePxxnL0gBe+s1NPlEEZGL8Iv1zMvRZZAlOyXVbwe63t1Y2cG7GpabhS4OX36KBgU0FN+HzRMsM1heeMQM3rB+XnGZ5XFWlxJGID15nnUCzyHDpcmZIxUa8/APz73QizIwZpfrXWQz1xI3l0acMN/N9KD8rbHI4otDuZtpWqgji8ZS+lbzLxAlf95oeNrHChrw521A7H3QjG18E867FVfPL4dscnq41zO0+HP3eWB6qDz9LIj+zUeyXX8IVU8JoYYNbTr2cy/sckj5F0YfvVCr96aWbe0dxgj0Dez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4NFDOlBnm0PlJBBPnO32S3gmDW3D5kgoz+IZ7zf/jh9Sarh416ecAY2mBiNK?=
 =?us-ascii?Q?2pu/JEChoKx5uB0wGMMaZKaS1j15FAYC/+Sof5LksSfS2hUwxT00xW1N4wdu?=
 =?us-ascii?Q?l5bsBl68rFkYQ3ePwlwFC2n6M/G+PYQpSzAZxxNlqXp5ZRq6l4xtUT/lOL6k?=
 =?us-ascii?Q?IM9WDs123squhhFMZ/QPs+X2XgoNiejQYdV6/EJpAcXAOd5fyDeG8yg8Bc0S?=
 =?us-ascii?Q?yZpykmRoz0/06KcuFfF/DO5eGZvvkvp4aeeCjMY8fcbrnZewQR6HRk+5SqWE?=
 =?us-ascii?Q?4ZpSrH0rqOmr6TU05PWsNFAYKmiwgEwMaFgIiHeh7KkG6YLuoH0w4WvgsJp8?=
 =?us-ascii?Q?xp687JZ/NWI4gkwmb1hlIyYRxew6RMBUXrlyvxVQ194QqWC9Diy7p28xGm4l?=
 =?us-ascii?Q?nhBipVtIL93keK4qAW02aYH2yN9wB6cDcdfbPNL/KmndW9J1SnvNmNv3Q///?=
 =?us-ascii?Q?eS40ENDxMiu7MbOk3Hqk3gLNFjVb1hFRuC30Rbj3tp5IKzbyhavQE0mD5BdJ?=
 =?us-ascii?Q?LnX94S2WLUL8xq9BD8JkvxQAcjZ1o47/rdAZ4JcLiOghXYqwWBg7K8NlIGhP?=
 =?us-ascii?Q?bmsmoE0sU0HLaQQ92x7f+Qfz/G3Vjb8RoOBFMKLX+sJirXDrJBXQPW+LHl2E?=
 =?us-ascii?Q?prAwxbQVD7NqSKl2zEtXF3BcdcmbFGUMDkwLsrE0pttIoIIQ9jSukYTrtNfA?=
 =?us-ascii?Q?KyyMGe85Lm/CVXYfp45cDlNOr85mtpz3WWI51TSZfkRYfkBdAsuc346VW6/H?=
 =?us-ascii?Q?FiRtEl2d5yGJRRXXJRmsGdr0igXHPzRrv2CeEXGUC43kB74CPI4tfDWUVd3R?=
 =?us-ascii?Q?fkOA7mfp6mtdadtueusDlyFI/jvVh1rysMiq3J7mEMnME2UkvMcVieoYaYef?=
 =?us-ascii?Q?AbGi6KCofuHXE3b0DPRmbJXmSnzRpocrXF0rvsUm9bI9j3fxot7s/6YnltIl?=
 =?us-ascii?Q?6Qc8n7asEmZripprH9w0OrnddmL4kSKkAaj/1REd+x/2rT/G9XVXif/gfzWV?=
 =?us-ascii?Q?XNEifiX+A9Zd2NvaY9yh2wckWm4viHOg6UZl1JVtkcfQXiKef25f0EGMxbfs?=
 =?us-ascii?Q?D7AxZek9w2wSATuVAAs6Obb2IUtkMKynorrMWkbCT+9lWspObFT31HJEUZ/S?=
 =?us-ascii?Q?0vVb/L1FGelw94wWnFMjY0pf/FgNakYyv81ODuSQlRI3Vc6OBhElovylHSry?=
 =?us-ascii?Q?PiNlpWaBUr3cuq2SksEgUH4j8LFNltyG+HGLfRksFkvKkg93qG8U00DCOvx/?=
 =?us-ascii?Q?qfNKQPoO4+JnGr2oaVR53696RSMCDwurGbSfPsu+vBbUfiKfyrrRwdsbi1Ue?=
 =?us-ascii?Q?9Khc6gCL+c+UH8P82GTkTXJ1FZ4iKzyDxNpnKxYGwEfGbWD4oOhkvzyfjlv0?=
 =?us-ascii?Q?7tC3XT7XRcSr+oKtjUcwRkh+7UVonQxPO0t5BtR1m/0IoayxgqZ65IPD0Mbv?=
 =?us-ascii?Q?Qud94CZiwj46xbujUf9GNVKFwaNP3m39ud4Bws4iJDkVybiXISbOXZ82wJEQ?=
 =?us-ascii?Q?odpK7KtmXmUKGp5JSTgiAjlaPuMaUrV9+/3gk3jJns15IjISnFFPN8XzBbNk?=
 =?us-ascii?Q?l5AEYqClnHyk1FZTtO9wQQDomljLzryTGiVbxovt93St60rgWKalUSw2f/Fo?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee8034f-4f83-48ed-be3d-08db76dee9b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:58.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHDkevAv1hmFxxSfWK3FonOt0RhGotDRl6YMjXv7zN2Tj7Lgj2+Zua/p28EIvdGshvtywuRqgB63MQiv08Koee+BLTc905q1knHn2yYMDHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY_BASIC_T1_FEATURES are not the right features supported by TJA1103
anymore.
For example ethtool reports:
	[root@alarm ~]# ethtool end0
	Settings for end0:
	        Supported ports: [ TP ]
	        Supported link modes:   100baseT1/Full
	                                10baseT1L/Full

10baseT1L/Full is not supported by TJA1103 and supported ports list is
not completed. The PHY also have a MII port.

genphy_c45_pma_read_abilities implementation can detect the PHY features
and they look like this.
[root@alarm ~]# ethtool end0
Settings for end0:
        Supported ports: [ TP    MII ]
        Supported link modes:   100baseT1/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  100baseT1/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        master-slave cfg: forced master
        master-slave status: master
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: g
        Wake-on: d
        Link detected: yes
        SQI: 7/7

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 162886cce08b..11fb5a4f47fb 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1353,6 +1353,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	return nxp_c45_start_op(phydev);
 }
 
+static int nxp_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1507,7 +1515,7 @@ static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
-		.features		= PHY_BASIC_T1_FEATURES,
+		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
-- 
2.34.1

