Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9916D40F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDCJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDCJmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:42:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F84C13;
        Mon,  3 Apr 2023 02:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRMZXILoRnUvtYeu1VhK6MHDS6pMxa/wsInqMAJfZZ/ZghY7/hOq2vD6n5/34CRumSBDfN3KAqM8midGOC5xVtYxX3kAZzoMjlPY6z+NS5i84oMezBZpgg28n/Plw3jb1nvdG+tVckT9h7L0qbMCQl6GCdj6u4h8a036c4dGpLNIsIl4ve1BL5dpy6UEos2o9KCC5MBTTL75Acvan5DwM+5DtZCCrIlX0xbVITRCrJA+YB7vusoHTUDLtnMbeEF06XEG0kVimFE2DmrwlUQyb/bQBVFD/G7rm/LEYFon9A8nSQZ2UNgj+EMz0w3BAVaZcUQS/Z5dQoNRomDWVBMn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWdWY+TdMgL7FtRUJe87Wki/CC3f0QqxEMHgwvrkBMg=;
 b=MApIFF6w9P9nJT1WzIgqaa2HXUMeIkQE6XYQSdLbJdMiaHJiNocdGUW6X0c5tRhJtC1Bj53sVkHWo98j6Rdl8ZpBc5GSsA6TvDTM4EfV7PRFAQpXcfbt3fD9u6qC6k6nRGsY2VF2EAMMvwVQUbnf1Pj091urhWMEobjnQ7gQrBMkRGS/ckSXv5Hrt6FY7/EmNFs4lwv715YCEQvpePoCmaBqzmlkMcuc5dIrdTebTr+tSCgmyzErA+rImxoj3CcW/IC7kF9+ij+Z9qJPnNXt50Wt25TRqY+7eJHQ5P3NnhyCc7irg1719sSb5BuEcFLRVMNO7jRAOe+AxQSuKeC14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWdWY+TdMgL7FtRUJe87Wki/CC3f0QqxEMHgwvrkBMg=;
 b=O0tFh1DJ4v0KxqO3dY3u6ImUD/oCA7W0iYgeEZaiPzvaOhm0V+1EySqwOEzUN3ZeCLJGDVAXym+hiyY81OatIvdhT2PWpQGdPPPwr4PJNdnRKkVSCRK4OnBYhcRPnn5AF5DbhwIc9OpWdpx6/y4JOab14CkWMuc/NuVWLg2R2QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8595.eurprd04.prod.outlook.com (2603:10a6:20b:426::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:41:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:41:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/4] clk: imx: imx8mp: change the 'nand_usdhc_bus' clock to non-critical
Date:   Mon,  3 Apr 2023 17:46:33 +0800
Message-Id: <20230403094633.3366446-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
References: <20230403094633.3366446-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: d875c08d-4c36-4cb6-7ce8-08db3427a6a7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5It8WeQdgyX2wnreCkFwtWI5F3vF32NCpFwVCCyL314oZptwKqa4/u5o1K1xHTAUPc8kYH6CKO7+xboN33bsCTwyIvRTyxI/yhZl2W426MiXe+ycy+2TaOR3T2VklYvgpG5QSqQ/BKjGQrEG3l6F1g0oaiJoBO9sCgVzSJ8DDTC1OecgaOsV6w1pBBiO+Xzg+M7tGcG/2k6sL6mspvvLVftuYPZxv8Ub3/kIdi+8tsnC10AlOY7t23BqSEFn8/JdNElniNoZ/F4d6D4lSYIsEcKp7xozqGTyIMl+apamtPmzf51sXEvjk8ce1mTNw9c7YnSNbm0zMylIAymxtt+EnA9RYFAznhJ6ZEVYFC+pIkS4DQrMPeXV+AMvRjGQSnXx95MjVw3a9l058/UNAUimasrTuTbx5INVtYNQg8y0z0Fzm8XhmVxx8OtGk5ITcCtPSpWwvC8xs7bIbM23KcZsVcvJKDvWqP+jng91LwD5vS/GL9Gm/lkpHz7qQT5Gs2En+hP8Fd6ItBh0Wl0ctbaQcTBcQnfV2RI2+hzJjkXPptCxld1mWIj7iMfRJZpa6YDa70vB3Ur83xrqAGw2NgdpLtHgqDYXjBdlPWCR3OUw0e5mWhCZCR4IJNzD6SGDMOwnXb9qRmMjn0w8LFP6ltlnjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LHrD5TxXUb+zNeoPMcAMNNNb3nTYHCv9HtOVqE6wpjJF2Ro1ZpJcT2w/FHvA?=
 =?us-ascii?Q?4ez7c6UOKORyZslTgfKHBHmtLS00MBgoDUCrXKsQyu1xjw79gLxb6/luQOGs?=
 =?us-ascii?Q?sGw5epVJkv+e6afwHlSVl6+fqhtH/jSbDmc0/4ZVnlImjzVA94wiG0OBpW5r?=
 =?us-ascii?Q?BQBTImV/8OXJGssm9YWA+ZKL5JVovyy9ggieDsvhRUh7wNjsuQwfuw42hmmc?=
 =?us-ascii?Q?Y+wpSN2MC+sIIPVtIZkIk2LIZriz0mzRXG3gdwEF3bK+P/1obz+aLKVHpOKq?=
 =?us-ascii?Q?CU5v6Ts6eOrlr5xcEZ7LAuEDqiowFXGdoKqwg0ZTs9SS5w7gyjldLIo1XAsI?=
 =?us-ascii?Q?z4KydrZMTga9jREow/e3sbFmzQ0znIiDfhEz6WqORm4UncvLwBtutHNVTkyC?=
 =?us-ascii?Q?eZ1loBnnM1YOWaQN3kc9943iDHHLotBpRNFkStS4ZrlyEv9VJX54at/OcLcX?=
 =?us-ascii?Q?YMt0vFBwe8G82sWiS7DF8rfRgK5X6roYQCfNVKQVfxvK9KIAzDw9CzOcVnFM?=
 =?us-ascii?Q?esZYEyJgAYUpHyjMdIhGQfF2wvLww1VKlZRWDy/DZVP5HBMrvmi81NsagXhZ?=
 =?us-ascii?Q?fJ/spJA3ultt8/RFqiJt9vM7jSaHvg4oVRz0BOS0kjTKeOVu9KvrFP0vhMP5?=
 =?us-ascii?Q?m+hzDYPiGiNz/4FDRKjYP9u08a8KY1IIbtgN6U7d3xOHbbri4tVSS1345qBe?=
 =?us-ascii?Q?VvntIKEMPNHvwmCXzcWW+9deT2uec1cary/GjYpnWR6VTOSJ9L7tPcnDmezU?=
 =?us-ascii?Q?IM5yErrYkzmeHrFYz6dCmz7DfReMaGBDEHKbG9xuSx+w1F04i15o7CN7HPh2?=
 =?us-ascii?Q?2i3KotWz3jNewILx1e80Ni3yjLRMQJ9i/F4VL1F3B/rjGenRnN9GkX+cr0z3?=
 =?us-ascii?Q?/jPWbTyQiY0Rr/6gKZjORB0Z5twVHJx07m3PbqI3p+PlJdtZtSOSt3QEnkdQ?=
 =?us-ascii?Q?W8r9UjV7JCPnVAP3Lza/ZkhGI0Ys2GwAXkd53NuOD9X6hEu984HmCKS2qtrv?=
 =?us-ascii?Q?KxnHO1gWEMxhrX4+lgVas294GvZUWiUXLJwAk6JAjdJo4Sy6CRF5UOVGnPqF?=
 =?us-ascii?Q?nRpBbLVHFPM2X+yHr3rM1KB2XJDEFVoRFAV9+plzR+CtoTHDIIn66DkoZajo?=
 =?us-ascii?Q?DnUVsJ50tsP9Uu1JuRT7IFSsfUquU8dFjT+byoWn53gjfsEPg8Txqk7Vxgmz?=
 =?us-ascii?Q?rZ1/5qQzrVHbw87iVSHb0HqB7oOviLjHJdnSbSV0jbodMIRUzs6xkMEMxV0v?=
 =?us-ascii?Q?aoMfKHEXaWh4fo/brkdC3avv7yql6bawLyIfJKMBhmOYW/6/cd23pygqkUT4?=
 =?us-ascii?Q?Bz8AeR9OpglfHu6coNCRSo4KYROl/drq/bw4Hr0EUlKeO7kZRPZJJZ4Dlb6G?=
 =?us-ascii?Q?Yd9nbnVf2lWJAuf19jUkCSkhP0nolMLfpUNblGsXTKxLUsX0TZ3r57vmhaEL?=
 =?us-ascii?Q?3lyQuS5Y0dXZ702gWZqCpEw5EA5eeM6KcBUorwH8DhLm6a8tajXiJ0235ThZ?=
 =?us-ascii?Q?eCcm4bE05Pwwb+iNtZSjsfm7j3hyS450q+lE563EG81ob2NSRjukWDmyCELJ?=
 =?us-ascii?Q?GazMrd+cOFXH9FQUuRZUrhTbk1J2Mtfy21weAMtg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d875c08d-4c36-4cb6-7ce8-08db3427a6a7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:41:50.9737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GugvNQXeD+iU/KOsOWuSbaYTpmvyrg5XDxewUlleikIad7p1uKygW8BWUbqEzUTL4shsZvJXBFbeToPmWIkT2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8595
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3: None
V2: None

 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 8dcaeb213277..f26ae8de4cc6 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -538,7 +538,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
 	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
-	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
+	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
 	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
 	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
 	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
-- 
2.37.1

