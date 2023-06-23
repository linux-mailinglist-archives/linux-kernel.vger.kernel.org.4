Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184C73B1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjFWHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjFWHlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB671992;
        Fri, 23 Jun 2023 00:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH6Vn7MXnqrJY2NfZ+Wr75AE99ziaNEWqftkvySMwpA2C1mHaqMmEhtBXHvpPqVwp8Ar5+MlGdLh++VDoCeIUO/BT/jirI0iLkbnr1GF3ilZNtIn702iEqn5dairhsBQQ8TA9qsCGo4negsd5DngelVTDavWJzfWrJLkUYBmP5zVT0Nvn6Qr8oj+HqLoGA9z86g+abGonMM7pAvlYNE8rs9qqn2RlXtrj4mGv1Iw1F6nMEmC2euZVuRliQSOfntlKU1axc/eES9i93gH0uLGL2bO7RH+F7tOlEhOgCjKrmUDniM6FzrKkO/94E4xziEVSs1KINwiJRKko7B4x0KSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2oC3lsSWvOCZ/6CVulb1Dj0ixVRMyN+iU2hKy9BbCY=;
 b=n9QKts/ma/mCkCLyDy/p06eOnAnq2JD9MmkXH+3B7P0TVlCwAVXbfd4i2fs/GqyaEJM10HPaCTUGPKWeaJ1nRmtJPCYBVRqy3TuU6Kncj/0eClPv270oXRsPJs+Evpz8tIfbpBvMs539AglkUaTwNHbuDBHkyzeK7JtLpIDm0PlHIwf5m2Xml2rT2B0hw03wxfiTjC+A7qX/bFURbP9CK0OogRYfu/UD+kZXSPUdLG6WdfvtLHhZ/we5jfwl1crJPVKtO+M1Sq0J5synmFidIkALV9S4i5DdnBQKhrdohMWePYmyX9EZxRqtZ4AsYufqCQTaXomWAHB+uRkT3y9dGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2oC3lsSWvOCZ/6CVulb1Dj0ixVRMyN+iU2hKy9BbCY=;
 b=SvO3SzVRcOILqQupIH4BSeYA0cHnx0NoEOMfyJgFrwQKSi/reREj2qwXLdikCv1Gi08nqBrSgRNzW7bDrfkKzYSp/k8YBK7ya+XNCmjxVZbqMRr2l7dd9EFfqdsCTf9OX2ESIPjgtvBOt9H8dDCwJd8FJvZ5MNDKavKTcstDwHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:41:42 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:42 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 05/13] net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites
Date:   Fri, 23 Jun 2023 10:41:15 +0300
Message-Id: <20230623074123.152931-6-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a0d6e7e-cf6a-4327-881a-08db73bd49bc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfXsk9E0C8b3kmdIqiu5ZPoYAwCzCKWWkteHRGI5LMapbgV4uSSMXY12vSrRZ6io/1YSkrIcM+94p6k5uUgk50D4NIJ/7lbquW1PpGRmgkKM/qDe7wnlbs7mczTTbG1Icu+a+GvwSqyhVnkHdQkiUXqglvZ0G16nr4OdzlEHeDyPXpek/gHsTlGLJmQ1SVyf1N+tAmCqSZrt4bU/D8EhcRj9CfzYj5Hr6PcoNw9L3RHuDXky5EFYYZjpsYwTbuzkP6zqNqxy5TfpVcQtCFSrLeT6o5plPnvaxI0aXvy3n1vv6A9teQxnPnvK2jwj0kELH4AsMCdbCKdVzIer93FMpa7btW4dpuz073PhohInbEpQ/g9408vyNT/Q09Xvby6z0ZKIW2MEJxDQ+zcSAyXRKRf3TWv6FGZHGBtqQvh2aRmP/4A7wSXqesyVTitO98ftGUhBZ7L1ea1F6H0KGYOnLzTWoGN/p1SHWQiaBA067UGf/OK4JM4qw4QthOeVY3iz8CNsgw+a8LYQ8aD6Kv/waRs0Qzvob3zB2OmaamlPIGSOwz7wLJttWdXa8SvKPnThPxKtIBGeDqDXNwSKBP31wUbXTfn2xtJf9GbigLRtL7x8mbLiMIxDZd82pdmojc6X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(8936002)(8676002)(5660300002)(7416002)(38350700002)(38100700002)(2906002)(478600001)(6486002)(186003)(6666004)(2616005)(86362001)(52116002)(66476007)(6512007)(1076003)(66556008)(66946007)(83380400001)(26005)(6506007)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpdo69yvjtVD8nJBfNOmYlQsWsA0NJe2QR0TnjeUL7pKGPH4Zg0+ahHy+FmX?=
 =?us-ascii?Q?WMBB0E4g7MvBNL0KarDFhaBer9KyGJmbDOrN8rWKz65rOVE7W9Xcfu13qzsh?=
 =?us-ascii?Q?7o7u0wQ1RhmdRusoA/ypHi2myT89GRjs6hs4LO2YNIaaiUVMECO+jkzT3xPo?=
 =?us-ascii?Q?FQMZcMD+kroWmoIw58F9VdC+QC4XJNubC3LZsR7CB3ZkLAn9GIsQjHj21YI6?=
 =?us-ascii?Q?6FSNQXEtM1qF2YMlACGHa8qSW0ZvxmePDDZ4Y6zvPvF/bd4C4jj0sDn29qZb?=
 =?us-ascii?Q?zhOfkNniFV8OD88XainjyCL6utyMvkVlIWYe/cSPA9uWsaowtqZrZeGq8CBM?=
 =?us-ascii?Q?VRd7dFWDgdCHEuBktHqsfDh2Fr/bv9Nk00j4CQxx57wQistShbOMpSKSzEnK?=
 =?us-ascii?Q?qUD3272tTGyOMmSYos5X/HzGLpKUSPyJmQ/1+myoRbd1dDlTQ3QFZrgEaQSg?=
 =?us-ascii?Q?JnC768t9dk6663pZeUl4CWZnltNAIabKCUJl2JaYnNwbYMoZdB5K8jMX6OKE?=
 =?us-ascii?Q?oG3yq+gyCXb0Qub1sDfiV8N9+ysv6F/Nsh+g62+7w16Be1hgdeQrIyvHuw+H?=
 =?us-ascii?Q?Ql5lW9Xbw2En9o1prh0m2lvWTr1v3DHrUl+E8vvx9uDdgSP8JT+LjuTsg+Ja?=
 =?us-ascii?Q?2zjAPLhYUslh9tFAyfXgP1I5e35q4oqHN8NJH6xx1LCQMTG4nVGkIGijW+DO?=
 =?us-ascii?Q?YvIsIcBI8nCI5/tVzQEk2QfuU0ZBCPKbEnLYlEIQNDvBnoDwdxSFQdEt94da?=
 =?us-ascii?Q?mrkhLV768MAXTqZB/F9izKq3edX7CXrti/rccSyfxvTfV/7dN/8cdw6jgPYQ?=
 =?us-ascii?Q?rjz6Xf6jLwxjgVaanDZ3AL7EWboV/sh6fFbq/d8XtARlCZqKo1aotnkXeLuu?=
 =?us-ascii?Q?qv7Hrb0wsnNI60Vd+TCB8hi26RP+Lyk52M0dp2ioXBmorveUF4sZK82cLK5b?=
 =?us-ascii?Q?TWKqCoiaCIAp9/DDX5Cd+NUHiTbMNfZ9P36DJz5zCvDGEt5zw2MVmejN1eCy?=
 =?us-ascii?Q?/sLc6TEkn+F5sw0XUxnF2UV+oP06WwCJsyj8eCJ4IbfOhtItXFLwvXbt18dK?=
 =?us-ascii?Q?g7mPTfdjgzVuH1t9E82B3+Q4vM4iTyui+1Nf4O3tHJwMgK1sjtoW8ag1rjC7?=
 =?us-ascii?Q?nciu50RWT0YCe8pxVNkelOMHdmxZE3mdnFXMSNUwQKUzG5pGmX83AWjotKDm?=
 =?us-ascii?Q?LRyczNJtH6FjpodvI5lSwlpxNibUU2DHcW+xHs3Ehr4Utdyk+PYjo9B84cDe?=
 =?us-ascii?Q?91thuuz3shheRJ8iRzyOPvtEkAs3BhewTflH64lIQbEtYpK4Ensvv4wf2hGd?=
 =?us-ascii?Q?LoRVxj/kMMj0hPpEzGtQIaoXVQDZM9n78+Pop+8KEHSeGXERdMcA/PVDftWP?=
 =?us-ascii?Q?j+I1v+Xhaqgg2yPlSNun99v2Ii3btx0/4SkLlehVf/gxY3qezUS/pftAxfrd?=
 =?us-ascii?Q?TjR30g7BioGzI7xLIQROf244dBukHuOi0NYlEVnTFIuPcZcVgfLd/tqwce9K?=
 =?us-ascii?Q?bgjoN+32oYbG0pey0cs/dJUKMq3eKQlCTE4sNwArMFrrZlss8ZFkox55XCFO?=
 =?us-ascii?Q?U44R6MH4AT+G5NqJpR0TX5Eg2SY6m9EcsadT4qVvF/hCSuwleA/u6Lm8beGB?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0d6e7e-cf6a-4327-881a-08db73bd49bc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:42.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIUnw4Tp+PS63UG6BnDum36SvToFtkziVwzGsZXPPxaSBGblZzN+tQin02ze+Ww9y9sIHvpSvUdPbjwv3/WJQURCNe+m9/dV4oxDJMpiO9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect 100BaseT1 and 1000BaseT1 PMA abilites using dedicated bits.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/phy-c45.c | 8 ++++++++
 include/uapi/linux/mdio.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index fee514b96ab1..1017aeb0599b 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -976,6 +976,14 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
 					 phydev->supported,
 					 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
 
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					 phydev->supported,
+					 val & MDIO_PMA_PMD_BT1_B100_ABLE);
+
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+					 phydev->supported,
+					 val & MDIO_PMA_PMD_BT1_B1000_ABLE);
+
 			val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
 			if (val < 0)
 				return val;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b826598d1e94..82ed363f5268 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -332,6 +332,8 @@
 #define MDIO_PCS_10T1L_CTRL_RESET	0x8000	/* PCS reset */
 
 /* BASE-T1 PMA/PMD extended ability register. */
+#define MDIO_PMA_PMD_BT1_B100_ABLE	0x0001	/* 100BASE-T1 Ability */
+#define MDIO_PMA_PMD_BT1_B1000_ABLE	0x0002	/* 1000BASE-T1 Ability */
 #define MDIO_PMA_PMD_BT1_B10L_ABLE	0x0004	/* 10BASE-T1L Ability */
 
 /* BASE-T1 auto-negotiation advertisement register [15:0] */
-- 
2.34.1

