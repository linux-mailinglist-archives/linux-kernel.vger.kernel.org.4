Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5773F6D1832
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCaHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjCaHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:11:11 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04BCA35;
        Fri, 31 Mar 2023 00:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeMXRDEbHZHmk7Cg0YTbyWJmTTxKNChoh6lEgEsgCb1c2z6P9eOiynDB+5HR+QGoB4uZYJMm/S0wmtxSMxIBvU1lPAcD8rFbKhUwpT46GGCuPbUS8KVqp2ywb3SIhXbYhT9xeFUGNxGEK4vD3l/D5y4WxbtqCi5SqBeg5dBeFznhtNpc/Ivmf7Ki+rvt21jbKjD3y78XErfggPIw7GTzHimxhXu1IkdMDCgQJ6TSQ84+dM5Icfg9o2o8wah8jQrVo+ZUbIYEBBDV/5L1hyh7tKHwTpYkCb1WtJLyBvdw91rPWzKPe3UH7xR4wvMWBSV4hDR4aHRT01AR1J6tIidv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AxxwbyzYLGj9lvep3Y9GH5/tQSwUtKjgI3ik13F+pg=;
 b=lixfZIaSycmVDiTZKbqYbowtHxNOJ0nvYFmYUNdpI7+nv37xANidShj9ahC+yqNKlMjJoIpQTKZ2r2ApBb0WTEM7nEsa07wvFZjllzAiaWoVpFREMFPWgYPUgCZ/U52XKytp1WsPh2fem6cMcrrnh8Fi1wxbQxo+/2IVXRFye39Kip4tltXsq2tO46U/MKS8uGZy/idJd8zIKywwjDBV3j55FfFmckYz8pJrzctzkvdpCQvlSpxl+zoLZLYDDGGfVFFZKMFIUun9/UcA20ZKyin7o5BGkZZbwUDtzgtE4JG5KCNPAgNUwOdJ6U3gxmwBZjixy+DY0STJ2JPypsor3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AxxwbyzYLGj9lvep3Y9GH5/tQSwUtKjgI3ik13F+pg=;
 b=dEWYkbYqVYxabwUeXzqQDH1Sz8K9DIZgvJM7gVQLwJSUx8qP1XcuYfXmk/HHiZI0HGJpIRmB3VbachenTI2u9U1+8Dmsp0Y0hua/cPOC0LbeQHS7A5KuEUn+gDeiumFZW+JXrbrx0iBbkqbWD3K5vCxzkGTdqF3UBVdiht2ri3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8632.eurprd04.prod.outlook.com (2603:10a6:10:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 07:11:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:11:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mn: add sai7_ipg_clk clock settings
Date:   Fri, 31 Mar 2023 15:16:09 +0800
Message-Id: <20230331071609.2483024-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: b257c322-131a-4c47-a45c-08db31b71789
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yr/x/1wo0APLQ1EjT/drU2RC9Z0EEbaMadI95qp+hnuYoou4slHqyheFiZUoXqBoZzuvLZsdqM+TxBroic/8cjRDh0Weg7h5wYk63WlBddblPbpJ7NWDY22ZOUBzIwWuHfYaD9zHeDiou6SzvUNTTql6FC3eehsNFJ+lXM8ZkSHlV1OwDZJ8g3Zy9kGieEqZ4caViv7k0n5fkqIhDD4GuNbftSLtkr3xbziM8WAaAirpu5xazpA5LYqrQ8PdRZEP1qWodP7EuUcnwu9WTZMLcA+y2EvuvgT77HRcZsBLzHv6iL1i2cQFNKZuSsI3pbOjTz4HGNSaVbceTUNXgXb2+1ILwzd4b2QIaZdk9hqfvsD8Kmp41gCPgLuVtja8EVbX79EfltBHPkKpVIySudOxiPtHly1pz3wDxcJcBTYClaZymn8sh8/rxCEsU/JqHdMagaBXMU4RchPwT6+kFRB2I3O0a1t1wz+b2BfMZFsZq9N5+46G9wMW9nbIi6rTT4FnSddoZdnaye59M+LNCZ/3p62Hn8/TM4a/cV8srxYzsHRBYo6dpn9QWWLlv2top2zbKIKcvDPeVUeIUXzB9XufvOut3sSaXrjzeVFpZwsS9c14qQZYJKH8cFn5NTYJdm2v6H0t9EGVxswj1YvLWF0pLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(4326008)(54906003)(316002)(8676002)(66946007)(66556008)(66476007)(6486002)(52116002)(478600001)(8936002)(41300700001)(5660300002)(7416002)(2906002)(86362001)(38100700002)(38350700002)(186003)(2616005)(6512007)(6506007)(1076003)(26005)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZud6WQGV0m9vm39yK6Jzla1xQxkTdkVmdqyXk33KhOaviUmhletonXa5wp+?=
 =?us-ascii?Q?JgsgBt+QYmScb4NOxuJgk262/FH+Dp2VvWTuf8TAD9W53YR57O/KLj8rUNpi?=
 =?us-ascii?Q?MSf65+1/jiw+i1CjvZTgsFDvpLB1rZ/+cH57pc2H8jlpjdU0lKMmcXffATS1?=
 =?us-ascii?Q?hHkCQbKGUzybnsDoCKpD4c8GYSasvorereoBCvNJETukb14u1r12m4cOKmRf?=
 =?us-ascii?Q?NfLfdOvQnHewvtJaF3h8YUstNsiW/aqedGSuI/NuhPEETLV9SoYGwh4RxnZj?=
 =?us-ascii?Q?2/yx1VzZHo9Jix2OEC5VXs2wEZkFYIbz4vZSClHMrtEesJGSDEDdfTDMsWOk?=
 =?us-ascii?Q?b4qO53paN6Qk2gpNQAlnBbpDByWny79OfxuM/SS1bU6r/474mgfjUvZCagx3?=
 =?us-ascii?Q?6zvjHE2P6eCHcxT+g/MqPTl08XpYB/EVB0MD784T+pJo13ZQ4zOQ5UvLHC5A?=
 =?us-ascii?Q?ITZM1H6HWeBkOmpPikPy9uDQqAqx650G6Ljkg4O8t21w84heFFd6FiVibIse?=
 =?us-ascii?Q?f2kfkm/UmADBdCA59PEvZoJyha54yU9B1AixaWK2ShiE0Axa95yAH3bJVAMZ?=
 =?us-ascii?Q?iDpACUgNBuJ3APU4Cx9maM5WBw9+RfZ3ID5M4kwxTzHtCyTBHMDdNT0S68QY?=
 =?us-ascii?Q?AfMcxojeLBvAr4+XHXD8MI508CuN7cW7x2Q3hJMZ9qkpqjm9GeEQtZiLVvIB?=
 =?us-ascii?Q?AV8OjbjqlOSqciAG5BY6hUd4v9GRLYk1lROk0RzWZrh3ERBe6BeG2MU46Q2e?=
 =?us-ascii?Q?saOpGpy9BpYag6pOuK33vz+dGw+VhSleXg9tIlD6d8twjnM/uRDkoD1e3A3t?=
 =?us-ascii?Q?Re6QIL6ku3CmzIne40eKB8ydcnCPGUtRRkw6FqOwtxvb73jDuU01CJIA0jf/?=
 =?us-ascii?Q?yMyx4wLpIH98dF1/3c1wwE8qYwg5byLCf8O367pKE2rw+TGMIiA6EGWJBECB?=
 =?us-ascii?Q?uKrZZaFbGHh5QVPuKlOQEH9nAoWYyE6OjWVUKUH37Z8oGmyF+YzXt57hlrwL?=
 =?us-ascii?Q?dR7fh6thSWMYvXzxdfxK0ToNemvkqtHQkgVR8MEpoOjMU298Q/2gbpNYyVSt?=
 =?us-ascii?Q?kvwVSoTq8Cwh1FezcM6d539m5KdqyyXp1LOE632S/GlvpDiVul3bHl8RUXYj?=
 =?us-ascii?Q?jCSvzgD3G+QXx2XKUkVgvB4x3eq52vykVx4MZB73r3xB0872nK+M+K5+NcLa?=
 =?us-ascii?Q?hoLhlPcNlIjej/wwcMp76qWsm39NzXPgHeMMrEkbxQZhz/ngULOhKO+PJxfv?=
 =?us-ascii?Q?Oj/LHh6fb/9IQ8H7y2ZBDpLfMEP94jABadwkxueYXHIW0o0o5Qbq40D6JCfB?=
 =?us-ascii?Q?m4VtUGyMCPteB1hwdcXXqR6ulwhamxP6V3RNFJsdhk/YPgc9q0HMQfes4Tt6?=
 =?us-ascii?Q?4pRhaVqrwhwnL6AKUDqj+6Oysy7mEuAK8mI/vWlk4ctxLH25YKbSI/m/KAzb?=
 =?us-ascii?Q?uAkbtQB51WI8+VJ39wumgkEKlTNRj1d+OZOqXEjW4grGaNeaezoKiOcpS6If?=
 =?us-ascii?Q?WgetSY6SiWA8gYxXgGV0RXYdW3+nTpgu8Hj2+ftwNxZRscIGbuyqP9UNO9rF?=
 =?us-ascii?Q?+PMtcxeLsJVsnf6xh9AEBNQZpysHkU4jB6n59dxO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b257c322-131a-4c47-a45c-08db31b71789
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:11:05.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh92kE+VqcyccHvsnIzaOtaV3eBYKd3IIL2fYvIQPnnOxVw+SeGx4K5/jPrk9O2phSJaBPySG4volvgqySREvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

Add sai7_ipg_clk clock settings, fixes use of SAI7
interface on imx8mn SoC.

Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index a042ed3a9d6c..435af18bf2bb 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -583,6 +583,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
 	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
 	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
+	hws[IMX8MN_CLK_SAI7_IPG] = imx_clk_hw_gate2_shared2("sai7_ipg_clk", "ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
 
 	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
 
-- 
2.37.1

