Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD06D3EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjDCIWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjDCIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:22:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB876199;
        Mon,  3 Apr 2023 01:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+QXsyV11H+GyQaNyYx/Lx+q66rcz3oR/ssOzEHw1CjzV2f4HXLRuQH3wOUWBQS2IKws8F/qd88oFyG3QjTfKbcuP3jDfsYDvNOK5qtuAOV+vyzZ6ecVTH4AvL+YuHZFDgeEfPnXErFTGNsOXvyafHGT/O9XqH/sx53sx5eNvcfui5tan54M0shLSoi+tIQVf5WOzNFu6iJZrKdvhFssHotO++JqQ3NrEB6kn1IH4W0NRReLDeyF6CnUdvMiZDllebb9KPhNxTP1aLpT+a5MqSRjs00vftQv5tdM2p1dMfHu26O014LrObEshGGhN/acGMBwNmK6nxrD0g6b/bt+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCW0g5JNBSvgPpTNessthHsMKD3M1mE1184E4qW6fy0=;
 b=CFjnCCy9N2bcQAx6mtHkxY4jixCzZxesmL4Y5qpBiMMRCX7pEGbVFpBVRbgRDmJkz6m3USP1Kx8SDcUillnKqgy1jFqW5B6E1gYtnWf4l66Ppo7kReJGWMtmvKGWYTuNFa6KmDc45y9PQmWEbcnIQbVqhIVz46AM07XH+wzJXPs9lHB4pADLif2nskTPBDVyh+CMF7lwhlV1k3dPx1SSpmqE9O5KjMzHzzUfalGDe4K2cg8IMzq7R13UjG3tC4+rzZDfMINpg9GqlyNahfUdJwRX9qcUq6YqjMqgQQgdog08Vdjg6hxyILeGA16HKWAEzrzWvZngHnI9b296jSq4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCW0g5JNBSvgPpTNessthHsMKD3M1mE1184E4qW6fy0=;
 b=LItbeeLiWOAUY6Pi5vIwX9ausDLJ1msjYAL0NWXnruTXQ8fv7ocFusoqiRQLts+5zOYIWtI2+opdNbAcSrAdn67wjL62xQZvHVHEMotjfTDqz8asnJD8xt22gSCpCBw8j9UVDAgg/UbVxYSdxePmJ3AHOspCiuX2gTauffpEweQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:22:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:22:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: drop duplicated macro
Date:   Mon,  3 Apr 2023 16:27:28 +0800
Message-Id: <20230403082728.3199849-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1e0b5-214f-4a66-0dd2-08db341c9a6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iNOIJa557nFoPS+Gfn6p5DTZElvtb/XUk9GBuL+whmkNThTxKOZrQJ0piJO4aHkgkA2dttDrJX/EG2qhMRS7SkkLiArf7qA5+6UtzoPiauu4Yh4ll4EME/uD590XfZFfj/H1XmifB4L6lBSrO0nPsR8G+5bonWXbe4rZYojM6Qr8h89exBG+1tCDf7yjjy5Wh2SRXJinm16Z+36pNLMzBvQ1bHEXQEI0kuAZR8qxZkRXS5KXY0Ul5INtaWJAkLOaEW7zLWq/FH9hsGSgo3m5tcFJX5eEIo9J7kr10beE5VhESt+jKA/yzpLvYeAGZLpBjbwo73juJUaoYJVLUuIuC865KHCMHfm53glm7NNRXV/0x+OzzCvhaKYsWFQj/fRbLzp7ANBWj45FX4nJF1JcHTOLNxor+JT5yuw3RqDnB0/ueZkXdnZYAs/D3E3h6fYtrNb8yIVxVmDTbCN1jZSSiagv1NZyxs/VmhhLbu/S/CnOdfQrpFghGbjS95KAlE7snbMFAtY7O0REtEgiwg/EXzVnZsVG+aF6jjoCXzhOOXP6Augp81eqTBUt7VdHEf07vamdxBsocprTK7ik8QVXwkkW4Q4Mgm4SXmLfhH+vkIzs6ksiz+tNUR92k55T12E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(86362001)(2906002)(52116002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(6666004)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(7416002)(38100700002)(38350700002)(5660300002)(316002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gjlpp33HevE1gP6hBO1YGai0J2IFPQsUV9L3cJk+NoBL46lohXUbMhvcIQ/m?=
 =?us-ascii?Q?a2J4wR2mm6iVaYgWT26F7Iusx0CyYkHQQzX8IYy7h7mjjRN7Sjz/ftLadrBj?=
 =?us-ascii?Q?RSih8dZvcK2zFNYfE5rj7JO+95/ooB/8tBqO52zekT2WAiFv5Pb/rSt1zZv3?=
 =?us-ascii?Q?aoo3Ii4rHZwABag0ypXQI6nK8YAGQMOhvAy3+d3J3NRSEPsivk2i57laGaeg?=
 =?us-ascii?Q?IApy3C8kY+PKfClhrJ/pTQBdbQuxmlPx0F4oqToowJXeiLbfdJ7R6sqpRLF1?=
 =?us-ascii?Q?3pNm9EtgIb8w6SPUr5XSdsmjlGjE/HpqZUDsfYyrwlnzHIFVoHNyXQ/cNnYe?=
 =?us-ascii?Q?Zzk1Lv0rD+Soqq99Pf8B2Hi2gbeTMLQgIzLlm+HNGesBtZaNaOICpu5+o+qz?=
 =?us-ascii?Q?Krh0/KmIam+TDjEj7v/aFcjLi9VYv/IFTXoC7++hH0wOpxUfPIKzqdHGkFVC?=
 =?us-ascii?Q?excnkYXwIjflf/U7mJKksI24txHhJ7yMrYm7mZccq2IJ7engZj1BZJKSjxAl?=
 =?us-ascii?Q?B/uGjB6tNiBem1ddblilHAYG0PCzEkOsL7CEGq7VuhCdQPVVdD/dfcU+bOVi?=
 =?us-ascii?Q?nNIkfLzt0mHemS9T3tAgqxquH/6+wG/+bjWUrx7StxqkU8uVBF1RRpT1BO3t?=
 =?us-ascii?Q?zHrxi5QAASj8P+DRPdk9NREMjzXXPzrVSx8YCe/pLfTwgO3Mjt6/olW7akC+?=
 =?us-ascii?Q?bx9ic349+cSJM+kF+46fYpeZer+/FY4C0p8RsJYSx7d/0zWTe4Q71dXVBQJq?=
 =?us-ascii?Q?HpPqzYrie1ZCFXSM+BvrmPMhzworhnaLJTVqoGxgu8rcNkhm+VXNUt2thE6+?=
 =?us-ascii?Q?KCFL89ZHQbM5f9C3y4g2JYabmaScYeLQTslsDqgTj1VWHFPfJuCsQtp/UM+o?=
 =?us-ascii?Q?39R+sLjNrS5pEx4FJ1+tQHCXQp09XZJgRMFO6rpjJdeaQUDNBl7bSJrTZgfl?=
 =?us-ascii?Q?EXMrqMDnoEXIroezftIF5RaW+8ZYdwnvhRxHM6Uv3GrXnIBusqxkvcoNj51s?=
 =?us-ascii?Q?AgTJtsYeysVIr6RIz2hSPlH3fe1e/rimfxNJqtkL3YyQ4SDro1MQKX6kSdaA?=
 =?us-ascii?Q?DmwkJhHG2vaqF7nHMhmEQqs9QtbVOxRbrtsmYkFj8kFP9AQobbzi1hM5FmJ1?=
 =?us-ascii?Q?MT/RqMOzp6JJoxpgVUTxkIoKduaxdCzOsNDGKvgwIINdT4Kmr2Q2YtHnk0/h?=
 =?us-ascii?Q?9bbzXF/upKCtxCcvaOJHvMF3RP+wPW5umFO42N2dCcOBapiDICN+KhOgR2d2?=
 =?us-ascii?Q?SVIwW8Ji36nxPDSjTm08keJupyUNugVBwG50BmCy0V4qhsQXkEwXLWS6s1GH?=
 =?us-ascii?Q?w/xCwZXBqKP+Nnpvgf4U8RA8tQ1E9nna6BRJqA598ZVHhfW0g6ERSOmoq+XV?=
 =?us-ascii?Q?DfjH/tmcuw/9obd/FLyyXNpOoXNnvpqYCylhvr7l+WHPrHWZlSvjzITWEJCy?=
 =?us-ascii?Q?7qOjm/FpxssYSVzBmPN1D81oIslBFN3R46yLfVG0JpZYG9Y+Q7/LOwhBE78u?=
 =?us-ascii?Q?GnBsx3ojeQgHG14Kr299GWYs0yCO6rW7PfXboo/SKVMKQorDnLTPBwzVwVq4?=
 =?us-ascii?Q?BvaDqeqFua0P+Eu40+eyAFocvf3q5ixEk3pP+BG+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1e0b5-214f-4a66-0dd2-08db341c9a6d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:22:46.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKH0TvZ8+oi8ZsthNKDCUwP/ZKZALyd/AiZR8wDHtB6syDtgvwtN7KEa8w8v3c6S0AKWKr4LBe8G01DszwlgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Drop duplicated macro definition

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3d94722bbf99..055bc9197fb4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -153,9 +153,6 @@ extern struct imx_fracn_gppll_clk imx_fracn_gppll;
 #define imx_clk_pllv2(name, parent, base) \
 	to_clk(imx_clk_hw_pllv2(name, parent, base))
 
-#define imx_clk_mux_flags(name, reg, shift, width, parents, num_parents, flags) \
-	to_clk(imx_clk_hw_mux_flags(name, reg, shift, width, parents, num_parents, flags))
-
 #define imx_clk_hw_gate(name, parent, reg, shift) \
 	imx_clk_hw_gate_flags(name, parent, reg, shift, 0)
 
-- 
2.37.1

