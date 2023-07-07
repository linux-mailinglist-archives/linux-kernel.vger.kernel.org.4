Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653374A9BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGGEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjGGEJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:09:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152B2D67
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkNsfmQNw9da33dmgg2ll8VVvGHLpqtg2MUKfcsI5hknLFXUR9+kqnIC/5vBR7/n2IA6xuJ0AtUZvWI0dSyoJZeCmmulKncVdK2m+Kap41/RT1L6ENCBW8wVxLDRkJoZvCyfG+ug0hy0D1oXX88hrIh40V6vi/VN+yBnXnLL3npPJvIqfGJ3zdlbQzc51BGlw2U5KoMorneWq5hjeo5gcyCtRkZVtwPzjiccx6EPHLK0ZE0E1/Ns8j53crTRv5FcSpAglsZmPtZZKHs84kXgjmYJwXu6LeEXIhsRsO4qf8cQ6Zi15Vrspf7hop7hDuN4MQWW5rkuAd54DcPuT/bxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sls+Na2mUCbEQBglYboXwewsLAk1nUfvVEOplEK5ZVg=;
 b=Yo1EmnU9PvMMixFve8FGKkuFcckuSHb7b/n0MBhNc0pDwOlp4yrbuhJ3u/Us6IgV1hdpbBiaByYSVrtL0vk5BfGkNTbNZgTypQQB/Xq9DuO8mBpQzWeD3+AnUwwqd2Rft8M+5W00+ikm19h89YgyDlfcdtVP/Qqn5sCmHU17xm2SJOjFQQc0xZtavHAEjPYf+BfqP+vzZe8P2BqfgpI558B4/VdhwtmYUZOzi6u0trQrleTxilmqxnowDcpXfK+TOrcHI+o5gxJ8i5INYZz7/kHYqivVlU4JgJUxL9Fc7YTYKuboNeRk6fD0k7TK/qLo5CmjVkDN1Jt19nw7utLApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sls+Na2mUCbEQBglYboXwewsLAk1nUfvVEOplEK5ZVg=;
 b=fGbAgGqzk70ZWbWtlelaXkdeHlW+36opAyyRrblpNVT1PsaxsvRGV9kxx2fBEfsV0olrm0sK5jQS8NdW/6mWCGe63N9Pjko17FZ1SwPleMvDGxn5SU+bpmbvb+LIiWDt9v20Stc1szCeHBSZcTmWAIIvBARWMF1lmlIpJaZcwvUSiGZOBZ9+HGlvRSHE2UK0NpVHV+F3XdLK6oredu/SSg7uzqHwR/KdRGnNPzy6yIwhxi/n1IgyNFrnNAyJSqKE8bwHSXDpGHle6kMbyUBgIImQibifwr7rPeDbAFoQ+k5G+uqmuyF9/VRZt9wTCldZLhk38RREB1rX1qrMBM4NnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:07:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:07:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] mtd: lpddr2_nvm: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:19 +0800
Message-Id: <20230707040622.78174-15-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baa1dbb-a169-46e3-36a9-08db7e9f9da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRffRDcYrPtJPwfappE4iiezeEYre92QO7QZvGjtDtmf7E/OS7/KpqLVKD+qg8ida6y3HmAfsv7QMJMoS6WXwTAA9MSQlVgU8nCEr0dj4tz+nY3/RWUrqn95A0BlItQNjpK01kdS/UuRXriUn0/qeWTIgxZSrEeNFpvfYOQxyWpzLHC5z3L0pRG7HOuB2sPCaXA7byKxBZZRPV3+du/JvOMwiDUYcL9a0E1Zv8xSTtbSXW99HoK9xn0EiTlksTQPQ2pF2cRduTO8hbC5PvFBytbYSOHk14Cjn4+3U/eLlkj1cq4gmC7dN59Y2na2b17GuBFSQ9TDNwHPxhe/MdovATr40nePGrFiOde1cmqmMZsFb5c4oN7NlyfDLlgQ0coTYWoJPeLqIsePGXxOBfFVqyXbHvN/mVqEWo6JgKgJHMucz5gO8ojCX/6/auz9NbMFp9iLurhTzTCyqxGj5UsJ4aNLHy6Jfe2zgZQ4LRgG7BEmABUq8lmXBxVIiJQwrYRlEKZT+GpohdxD7j9lsMKs7qw9WFYcwRK3lxZ5vwx+6jegaEWQFzSsIKpQXMfRvZKGCdu46yVl2iKp4yiz6OfjTYzxOSK+llvKGlcock8EKBf+WLp8XHIUeX5wjG23Vy4V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0m8R2xXVeNyPaypWwtbsMXuwTXF/M6rCRaZgvLovrElHzR/tRpR0NBCDEe4+?=
 =?us-ascii?Q?C6/goHN5dPe8XNcWVCpZOV+4Pm/Tm3tSdwbQMFAneIb0YXeVMKgoh/yyvr10?=
 =?us-ascii?Q?gJ4M6WsYTn+X23NSC8DJgyEY6pLfECEFhnAS0wXieFjfVsAcOx2mm201cmrp?=
 =?us-ascii?Q?9bSfMVXmmtYE51/YFDJwRe6StPzBTIUE3PthO8rPIl4iXDASes2EzOH/ExMJ?=
 =?us-ascii?Q?2kqtdC+PLjUWDDC/wuqIEEgErmBzt0lgIEreKNFPas3iIJnPn2ATbnCnAc+l?=
 =?us-ascii?Q?xJ98Gt0Equahir0fUUcDizu9ZiJAHZ5keKUvpttVJYEe8dKLC2pEdod11/3L?=
 =?us-ascii?Q?CLjil2mcoCv0GK72Ac2VusCgyZN7VoZeOvkd/TCbmqonJg35z87Jc0j3G+/T?=
 =?us-ascii?Q?jYAFjaFQ4jH/blOyUYiFAXRS1WiXtjMBWQU8azP/OdVSrYB7y/d5/TiCb+mc?=
 =?us-ascii?Q?W8v35g3LjLEJTCVnMstZFJktQRggec9uhDJyYL9Hx/1BIMxNM2JADJ3nFyly?=
 =?us-ascii?Q?7+hTH6hyXdo8MwJCiGeYrZfaFwN7QqhB57IHcgfbQ+Dtwa2aoCmKTZjnU64X?=
 =?us-ascii?Q?VT/45XeLP/C/tODO59iheBVZS9nrpXGCuf1EcAcLfHPJUmHwlWanLXwxnSxL?=
 =?us-ascii?Q?WgWbVgP+41/7lDXRKOmok5vPL3QJ4my8xqNJF/F/JVdg8yUSxJMtV9ARJC06?=
 =?us-ascii?Q?qVnwHoCB8xuw2lzpbuO1cazJXaj4WLsig6KwBuhXm8wqrIjSAwOY6z3AYBCF?=
 =?us-ascii?Q?m+J9EoOyNoosmeCFmGMMh29bFH2qUYvlL3Z2gB6DaP2zELdxl5r4SD6OK91U?=
 =?us-ascii?Q?oG+5lIZc+gByztoIoSUCX/IJZL6Ks9ybFJLghNeJzvWYed+tLL5mtn64G/yW?=
 =?us-ascii?Q?+vkCYvdvJR/1nwC1jUovMaHgpYQ4Sx9tWD8oqobUTkzL3DhDS2WN03/v/8F0?=
 =?us-ascii?Q?2mrp/MVuC5Yn+HEK0jjogkZNFa4jGU0k6HacS6FRbOdnFH3dnWEyn3qA7Tqa?=
 =?us-ascii?Q?MvCZ7RWlrJ++Cd1O8NN9n0WWPCem+rFF8aw9fONIrPss/LAMbACgorBiJ2hf?=
 =?us-ascii?Q?n9fI7vTZBaG/a/hWOrUxh+XZy6JDDy/PJrYdfTweWDTcp0bhN3aC07NB4hEH?=
 =?us-ascii?Q?zbLVeJhvBsLSudzUoK8PlAr5x84L61yVifWYCb74JR3TvOLILsABuE/GVW+a?=
 =?us-ascii?Q?FtwrsQ/maKMNiEU4W776SpCTTTvHPVf80kVnZlCNfA5NZc1axnXEWJTYTSAk?=
 =?us-ascii?Q?uCWNY4i0NMmbD51L5bYhhrHeSFoDLZKfQD1Z5idBFqRphQbZtbOHzrHtFlQd?=
 =?us-ascii?Q?RF0ABnMvgyeVKexF+i0ZDauC2/WRVURCay1z49T6bUSZXYwppkmXGb/+T0Vi?=
 =?us-ascii?Q?b0IgLCvOJgLv6slYxcCPeXD9EU7A8/A7AgrAiLXwa5bC6cztkLby0I2EuLLI?=
 =?us-ascii?Q?2jpXhqO9Rdga+9o6yHmAzOJ9MGw4Y9W2fegXRJl3QWfVPyneScuehRA6An01?=
 =?us-ascii?Q?EZ2xI/rrJs8HRMJi428FSA78mWWg/+uUMGlCy5fTBuvu0g2uynTtW8WMVsj/?=
 =?us-ascii?Q?VvhsKgG2vuPxNg0m/2CEObgHMDyN/woN+JeruG7p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa1dbb-a169-46e3-36a9-08db7e9f9da7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:07:01.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw+rCn/BVsTD3bPBkCk+WNOgYBcwS8n9S5yY4eOFeuqfjX8f2CtncE1gIod6ScMkoEtrV/PKDt36KAm7t16lcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/lpddr/lpddr2_nvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
index e71af4c49096..f4e5174b2449 100644
--- a/drivers/mtd/lpddr/lpddr2_nvm.c
+++ b/drivers/mtd/lpddr/lpddr2_nvm.c
@@ -412,7 +412,6 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
 	struct map_info *map;
 	struct mtd_info *mtd;
 	struct resource *add_range;
-	struct resource *control_regs;
 	struct pcm_int_data *pcm_data;
 
 	/* Allocate memory control_regs data structures */
@@ -452,8 +451,7 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
 
 	simple_map_init(map);	/* fill with default methods */
 
-	control_regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	pcm_data->ctl_regs = devm_ioremap_resource(&pdev->dev, control_regs);
+	pcm_data->ctl_regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(pcm_data->ctl_regs))
 		return PTR_ERR(pcm_data->ctl_regs);
 
-- 
2.39.0

