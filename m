Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE38748674
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGEOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGEOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:35:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871311700;
        Wed,  5 Jul 2023 07:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVdGt3xE+SBix9MOcEaH+6EaOcQCZYdy7HyVylsWeGjdt4R9M6lTYtgdlZA2ys8CqPi0dlU6dWdtOgc1iZoKrOcfeL9cMQL2T7DiB3AGPNP38iM6eirqgDIDNQsSm7nAD6SJRH/1PUvArT8Wa7+Y9t1RnMcUi2rAmxF+kR7rSeyICm5YUTLjN3Ut/eEY2CuRDsXezkzP3KQkYqmY7N+i3sdmSoOXpJqqevo/j+nSsBqs1kT5KiP0xcuulx5x2elqEtl88aHWL1RuoCOSA0+y28AfkawX7aLV942rbYuvRZ3VN42ZcG8JZKZE3/flIWASzTUY6m5q297rpCKV2crPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDfwI1aEwN2QLbQ8IW9TyzbFaKLc6wRCNC727c/ZjvA=;
 b=cAZFjQXP7BRm8bUDCUon74DddCS98hqcVK1FzMkJhcA82V4JkXe3LKlEdhZ1aZXQZ25xUSH7SviycX9f+oyXp82tDAZ6wKZdKykZl5cmpPNzqozsjMTcHfoKRdlbWaZ5M371MslYG3HjvOYexK6XIj9CVBOGTJXXJAuUrpU1ORUEa5wFjAb42SdbT409RzcK7ag2tx2Fuu93nQkYGAl4MBab5jDm1Hq3IpYrZxvADlTYBhddu7QguS8Vq2zKvS7HnX6C+gsw09aoovpaBDgq4/BSiuuz6+QO2p5riojP2MXgLmnWpqsdNExl1urdQ3Kz+S1mWYO4WhbJz1kigYTkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDfwI1aEwN2QLbQ8IW9TyzbFaKLc6wRCNC727c/ZjvA=;
 b=V3XfLLFduIv4eHB90RMIxUGq3zfarf45sZAnIqTiOyU5MhSIyc9xurCmeJObVjOkapYJQKz2BLvaXRsLM3SJ31fDGQ+/5y1GAqNha5Hsa2ZQSXYnmH9Bcdcl+HD6oX6wFw8fcSVTP5F5nWDKHXAwHAEa+7hfL6jJQKRXCkayffPUInAZyOvw++goQd2x5EW8KtAsM8gbqGnuobW4b/hNM94gggstegyxZqAeAWVyKSvxU12xl0ojze9Sf++Pi68bveZw8sAZ7wlfctpoHDbbrfyTULMRgX1VUcWprFm1koQlfUxAYlQRUr8p9jWKOVdqiR9Yj9oToTxMhD3rMZpGGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by JH0PR06MB6583.apcprd06.prod.outlook.com
 (2603:1096:990:32::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 14:35:19 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::9531:2f07:fc59:94e%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:35:19 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net v2] net:thunderx:Fix resource leaks in device_for_each_child_node() loops
Date:   Wed,  5 Jul 2023 22:34:56 +0800
Message-Id: <20230705143507.4120-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PS1PR0601MB3737.apcprd06.prod.outlook.com (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|JH0PR06MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d67199-ca64-4752-65c0-08db7d650e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3O64Zkh2fSYrS+MhkAba21q6V6gboSSykO7zn1AQtNsa9urh7pmxCPev7NHzxvTqd1UrW5vwubvTyYY6ZNPl+7MjZd5bFkQ89r6MuN87/xfWIF+crcC6OGYjEasc8NCLYtLs6kg21fbQtI/VNlJO0Zqg5KPvY0eo5PYZ0tMLVggBM15Yq1o5Jdh0rYoBg9M4pN9H1cuwmzq7MdkVm+92+Ea3+InXNXCJq+iWUP9ZpG+jDGUrSEyWf9kE8KXJbgOuZGzrt7mV99guKn73pt8z3KmUVHBMZoS3DnIn0qvG7D4th77DQZWTyj2nX2eBNw7Og/d+/CqgUZ28GaiLHYFGV4IyLWcjYMfJEWb4tbECu/E62BjcI3Gso6Q4apewIb0pexvipbF3gRDeMVHkB/JCJ0o8U3OxOilF2J8fiF+pnJfY4OJjzC/52/5qzOhCwOxi25A+JmCeBCKB6AJv+Xv+hqoTsVgwRptnaC0Dw9FTMXTeVUdhbVz8lZP6ZvtJPdZzBKbPjsNmL9bQMm9BSOVq3tlPTXF5zl6Xe5YQMUafdn8AVxA/yplW8KjME3ChMIoJyw6PMqM21z1ZSJY24MUGeNqsu0gLDXO46xSnV2RZJ9mjWbKusuq1KPa5EQzkfVy/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(2906002)(8676002)(2616005)(86362001)(8936002)(5660300002)(110136005)(478600001)(6666004)(52116002)(1076003)(26005)(6512007)(6486002)(107886003)(6506007)(186003)(38100700002)(38350700002)(83380400001)(316002)(4326008)(36756003)(66476007)(66946007)(66556008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YriYSgCxkO8upNSU8q6n0e48Irng8SvFGHz7TIPGEcIL2ufhsHp5ch1Mjrj?=
 =?us-ascii?Q?l0N80/aGdSr0gAVJ69FXW+bOX4R4JVhyxWdsmXJ3yIwWuzDETgMmaN/v/BBu?=
 =?us-ascii?Q?toPwd+RpFfVMWmnTLRFhtironl/XZgqozKyLt5bcWR7XrVbMZ71iQ8TmHr0c?=
 =?us-ascii?Q?aqNpURfSWDjWnNWUdyQtDcsl71RNlO3dNY18IQPiCttdBH84+Cth4VjryvKk?=
 =?us-ascii?Q?iXj0iX/DgaC4JjkvKar160EmOIh+XNI+ZQjC1EreR9vJrvW1rAwRX+QODBzC?=
 =?us-ascii?Q?/UlBXbh9VC6vqek+HtGkqVSeBwPDeY78zFelm/e5JPlW5anlHHphs9U9Zgm1?=
 =?us-ascii?Q?dv9yNFZdbw6tytXUMeU2Axj49biQ+scZXE+y93DODRhYuGAbq8OS33kLroF0?=
 =?us-ascii?Q?60gH2kiCl0bqFpCyRoAuaYfzgQ12vGR1f0JRjnN76mDeY9JKtoD5069/SrIr?=
 =?us-ascii?Q?JMLDMDP8Yu5UtFJGd/+Wly4AJ2/rhP6NXJufacivRV1lB4bPtBZT23mTlK6q?=
 =?us-ascii?Q?Kf23piPnotlE3SFbrbem7/cPKnwLGd4yge5KYt3rHSpwIZJkbMt2OVQA+eU3?=
 =?us-ascii?Q?BG+9NqOjuSlC+a88snTXLTdQsrnfFN+LJ5YPJ7K8oVRiurNkhNXPV5Tt+E0u?=
 =?us-ascii?Q?zz9yQ3PhPV/R7HR/jrYG559pOANxUwtPXS90jia7P2vcMO03EyThISe6k2Jb?=
 =?us-ascii?Q?3qLWPO7S9Pl+QvTsKzX/cS59bow1iGMpUiMxUiBTNw2ni4+ikSZebj20gKWy?=
 =?us-ascii?Q?wNKX3P5+JAHR2yLWyD2ZSGECuxy/rRoOhZcZ3PLw6ua1m5VvnXfW4dl6IobW?=
 =?us-ascii?Q?1Vp4iBitFXnPY/28aG+++EK9zh+NCiguz8oeAJzbQScmqgeSIE8/NKRG5Gnv?=
 =?us-ascii?Q?xNEmIGw+wkQnGOp71y3V07WwRaqX20Z36UPr9P0QSBnCnWZwbnl6npx7bKrm?=
 =?us-ascii?Q?KbiGMim0oJdycfw3y3cftSPoBMiVbnrxAmj2OSBTYCbx1jfoN2ut9yCq9z+i?=
 =?us-ascii?Q?7ONy4YXF5vEcz80BgA3BDn3sG2pKESQLu8tUV48j/LKIJfJEhxSCJhslaOoL?=
 =?us-ascii?Q?+29OhG3dBeUdCGDA1bKTc0/iPbdtU+oRhZkWFn8CuCYSnXeLzDrivBMs9XH+?=
 =?us-ascii?Q?LlETX4xKGF8O056zmrKeTFD7wzsx4pGTBIa+3zOePrGo4xWo8DbvXNlAd+Qu?=
 =?us-ascii?Q?BrsqZD3avqicyeeH8jLmt8fMuCceIg0Lq/G9tviOQgOBwKTTOrheh+NMFfKQ?=
 =?us-ascii?Q?E1lpr8qX4JYJBGu7L/OZoHa+LLv0uB6SUV1A1LPl1QS2ZcSYhWkyDe9t9leW?=
 =?us-ascii?Q?OeNd81L4X5BfewNqY26wsGhbf6wiV5MVKgPJVt+RLCtW40CTG5mxnmWIQc/4?=
 =?us-ascii?Q?NPOQUj+onCq4mbiK24jmRbhpY1zu1XLfGtz7UrVBFnCamiVCjqGPXVKNyiVS?=
 =?us-ascii?Q?hWnMa2xtcXyEt9Vq5QlaOv3Wygpic+pzCg3iaQTCipMyaAxt3ZP5KNN3m9F+?=
 =?us-ascii?Q?cU7WF2653DQxaYdNoC4m9j4YGJ/f8MOPJ/sVOX3aEBAZuDP7Jeq97DcvE2D9?=
 =?us-ascii?Q?w3aBhbqGb5VGvr2YC6SQZmwsGVFKcBCCMC90o3d/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d67199-ca64-4752-65c0-08db7d650e72
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:35:19.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZz3RPWUwLtvslYw6mjSKaPRvDcdmb+7jjDF0qjyQy60N9s57Rk+U/P0NbeATZf3NmdD6E1LCGdUZJG7a9iFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_for_each_child_node() loop in
bgx_init_of_phy() function should have
wnode_handle_put() before break
which could avoid resource leaks.
This patch could fix this bug.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..dad32d36a015 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * cannot handle it, so exit the loop.
 		 */
 		node = to_of_node(fwn);
-		if (!node)
+		if (!node) {
+			fwnode_handle_put(fwn);
 			break;
+		}
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
@@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		lmac++;
 		if (lmac == bgx->max_lmac) {
 			of_node_put(node);
+			fwnode_handle_put(fwn);
 			break;
 		}
 	}
-- 
2.25.1

