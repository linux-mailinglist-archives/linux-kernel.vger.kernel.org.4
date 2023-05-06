Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96916F90CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjEFJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjEFJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:04:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4CA9E;
        Sat,  6 May 2023 02:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNBRVAVhvoWOyEYqONCNSsifZ/cEavjT317FVEuI6CXyE6dyPSesxh976NzOIbw+bd1xGc34wVO3M7b10fkqfnji2hGb3pgoJv7DvC/kfFbCULYUvUDdipQ9VVMKMeyAraB47LEaym6YTGwyvcfA3yKtRBzklMcn1qVh5s7oTzi1UAvw6nLEJD9iyoW+75IhCnly08SDg2zOkFnkvGraJ717yt/wtbFZwz6WZz11n9UyLqb58if7ZyQFLZ3W74AHHO9ecb+EdfPkCuTNHU+/qg0XbSPvwzeIRgh6Gqj219cm1FIpJ8Z1gFbDsqGrVFxOSfbsJGfL8muJ5Dur6TNS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENfcIroSXq8jTcZjxGcZxhRCCN56A6OZBBNzL6LyNFg=;
 b=SzSSaMfXPGGP8cDs3Q5tGV0gJI28W965USaWD2bm3JuF6wcrCHaSWwnFVaftOxjGB5d7wlAZLpUXU3wt14AVN7QgO7OplBuS5GCU6tn29CVbx3u+tc9l2zTUJN/VEV6ywVJXjLDEJ8ThIfmLFMnZJrWU+xKQdIuT01r2YisfxFk9LSk+BeDytHntbfu8T8B+Fu2PZDb9biMSKWzStu4r8oiHCqQcLn0m7MxGp4sFHonZCFRHQZF0IG2KkrMsQH6iNB4EG6h2n5ixeubO3KxvbxoYk0OVthi0mFkf5tvratQVyeG7Mzo+CSe0W7kAkJQndGKg2wSjgDnpw08IPeoGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENfcIroSXq8jTcZjxGcZxhRCCN56A6OZBBNzL6LyNFg=;
 b=eheerQq4BVJO9e88xoDOH4FpnKRsXev7Uvble4aXUqPrNUowib+sqMT/4e8L5Uylfz3qFI+05pzE1MKOnidWfHzPkNZEd0zPVm3Jw31UOrlkXDNW9eoLVKjB1CiSl6i7iGQ4505NhoeJDXcZayxJiXtuUXoRkksm5obGW2l00qY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7186.eurprd04.prod.outlook.com (2603:10a6:208:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 09:04:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 09:04:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: drop imx_unregister_clocks
Date:   Sat,  6 May 2023 17:08:56 +0800
Message-Id: <20230506090856.3599035-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3f2038-5571-46af-3061-08db4e10e732
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lZAVnWznsXl+kc0ZOVrSIJDexTkYdpEhmmJWaxCVqcpUR05aqSM65ie+GGYFGJEn3gNNnXacwXKWWDtA3EPz3wPhJwObqv0auUhUBwWfmrsK/FQi7Bo/SXQfxEpPLaSTlfbkw+JsfjM0LdmO6IDTtBALmrX9VFEiNffD3+67Vz7KUWCncBZJgDdMqbTJYA9tqhK9BF7FTpxnvcKoa+hjZ+YnDFKGCW5CYkq1FTk9RryPOL2tOPaVp9AwNGWbThPLBk8TxPmfxyo8aROJ2cObcrCQxLqgGyY3KwPKMQLvlToRQzhyGOLqXr/bILOFUeRnPidSc9Oq8VmcWJRdiQo3ZYQ22Rdf/3L2qiBpTUPx+7BYHedy4UEX0w2gStwN7u/hjH6H4ymRn4IYCtdNuFkLr0H5dooXh+zuIvjg5eC7mziW1Qx1CfUq1XOjqsAGaRcbWSpKvlWYN1KlCrl6dL48CHgxs0ch9H+EoNDv2T/sr70I+UUvqKuhQLIH4ku+5g81A8iADu+bmkFAUPo38pixhokVPTqrXZN46GHwfRCGQlKnedSsH56dqEmYFlmP9Rhas56QTI+/mbytMNlDS3mIruQeQMNpd1YQ3Zv6tE0mj70b6UDzTds1yfpn7D4yXZa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(6666004)(52116002)(66946007)(66556008)(66476007)(4326008)(478600001)(6486002)(316002)(86362001)(2616005)(83380400001)(6512007)(6506007)(26005)(1076003)(8936002)(5660300002)(8676002)(41300700001)(7416002)(2906002)(38350700002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owfZOi6y89F4VlmtI1owjaXIY+QtNMpC9NDGJ/yYv7m42nE+FIzJtZQikddo?=
 =?us-ascii?Q?4M9zzGSYJqz3zGC3pHDN1haVoRiTHjB8JlvqDbhNhIBhnS7RWZzn86VvqxGl?=
 =?us-ascii?Q?RXoTVwqaUnrda1OlmxR1Abog4uPAMDkLAaoZ1eFLxkWfPcDPede2uRqepNDZ?=
 =?us-ascii?Q?iGr1+eNUZ+ykw0nLG7OPa8l1TKYhvQ2Csy45P7n06HWqbAmefgaFNfPVTYPa?=
 =?us-ascii?Q?TBLc9OHMvvgSZTRSbvLBzyWbyrRSSla3oCUqT4045wR6Mltjzm8R1QamcwOh?=
 =?us-ascii?Q?DAUZX/fR9KS/I/p7IkcMRCXEab3yedsftbPQWeUtdw1ZoARu3FpX7dn8PQB3?=
 =?us-ascii?Q?td7wTr17cNxPVogDBUZoTiOIMJCaNb2T3wumE82wEd0pgwx0OER8e5nvdYX+?=
 =?us-ascii?Q?U5euW0mvs5eIMKvQZsOFrxBrUVYS4QjuCqXnFHx5B274+I1RPswCtMXnqqYb?=
 =?us-ascii?Q?WoQ/zCZab5db3pFZ5fVZ5FZeSW5F7jelMfDxo4xNhUP50r7KVSI1UZivhicr?=
 =?us-ascii?Q?Je4la0r1qG5vCha/VZCviIJBtJhx/mKl6FXFOctWIqs2+MMN7IdCGVxZx8xo?=
 =?us-ascii?Q?bkLjSmstSv2VPqKJRD5DjNhRbKTLjjHYlmHDtHAUVqe9JQQKz453+VUeSZ9m?=
 =?us-ascii?Q?3SLehzT/FqX1Gul9i7/3UW0ANzMNSeTa5wiI8gH21yh0pOQ8vKnrMj20nkcW?=
 =?us-ascii?Q?7fCgPYeOl0l4sbXHRgRkKntLAcYgxuDu6WQX1q4t+hsGGwnjmEMWaf+LADZ3?=
 =?us-ascii?Q?rf+AuzfqNo+DlN/AfudDPAibKtp7/UYb+KIChifuy8DO1FZLTiYgdcJ2sDdk?=
 =?us-ascii?Q?xI9m3nFA/JtHtEx/6vf8N76ls7vMmh+nkfdA96hnWWXvOndW5qN7kV5O2jE5?=
 =?us-ascii?Q?Wal04UjsLsZybqlfDWGqI6Axs76+RKzTnDiRhpk28dBm3ICPqKTdHXl3ERxm?=
 =?us-ascii?Q?+HKtO/Tp6VFgrhb1w5OIGA7L1wZrfhLxtMQ0vi19AWbQiqnVYhDrBdOIl6zT?=
 =?us-ascii?Q?l2BqlHu0ZdyJnpxvx6Iw6yzXOIvHpaFbG1uFR9a3VD5XP2iDeK6fH38Rq1Y/?=
 =?us-ascii?Q?TJiO42brb+/7V8odz6BLXizn0x7ToSecqUeFM16mPilJPLYethxZLTWhJUS8?=
 =?us-ascii?Q?DrzOcAZYfQS8uzAk9TW3ykuJi3ar5P6t88BW+SQ5os/60S26MksqlgOfTeAd?=
 =?us-ascii?Q?fjfzAbwQAcO1x0gbYHVSS5JFoCG2xECfcKrH++cxTI+2A3SXyN3+RnGDcpGz?=
 =?us-ascii?Q?4k5mf4JQub6bUF3f5nv+VWQjzRIxf6iPEsOlwowITpr9Q0pqQw5fTQOs9o8d?=
 =?us-ascii?Q?NPWH3h1C1eCLVJbdJbvuBorcc5AuxWNtnYOAq+kquAtDq6eyseFwkNaIr+Al?=
 =?us-ascii?Q?csVJilGxOWAWiRS1mi3S9d0tTgOISOpZDFzNfEBAbD1NEIAOGIIbVRZFTBFW?=
 =?us-ascii?Q?7JKCg+N3olwBUIeg9k0eNHdTLiGO555m1UmRwLiEamWClbN3hBhqBihC9f22?=
 =?us-ascii?Q?eENXFJ8oeyspNbBSqzMIZ2+IZ9PyS29aaelhCfWlrKaWkKuCAHfRNqE/CxJI?=
 =?us-ascii?Q?EahdeM4hOPC1ivFOEiHySrYAVSnfqLFrqfXfkg9g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f2038-5571-46af-3061-08db4e10e732
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 09:04:31.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U27lDA1adtV2uUtSfcx3FZJuxmxaB+ANkVjbt+H49hWBKTTkEqvgDFaMtG1koCA4hKz+UeDZIeezU0eAxgpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no user using imx_unregister_clocks, so drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 8 --------
 drivers/clk/imx/clk.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 19cde59a20cb..e35496af5ceb 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -20,14 +20,6 @@ EXPORT_SYMBOL_GPL(imx_ccm_lock);
 bool mcore_booted;
 EXPORT_SYMBOL_GPL(mcore_booted);
 
-void imx_unregister_clocks(struct clk *clks[], unsigned int count)
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++)
-		clk_unregister(clks[i]);
-}
-
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count)
 {
 	unsigned int i;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1031468701d7..af19d9f6aed0 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -19,7 +19,6 @@ static inline void imx_register_uart_clocks(void)
 }
 #endif
 void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
-void imx_unregister_clocks(struct clk *clks[], unsigned int count);
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
 
 extern void imx_cscmr1_fixup(u32 *val);
-- 
2.37.1

