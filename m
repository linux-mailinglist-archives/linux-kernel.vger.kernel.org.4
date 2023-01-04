Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0B65D10B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjADK7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjADK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:58:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175191029;
        Wed,  4 Jan 2023 02:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5kv2hzB3tfZqGnObEb7c/AKw13oAuSxw9qvpcX45Y4+ivnv1gNeo7G3ShDonWEUvCoJMbF5kLvoM8sAU91tSbdtg7vW5QT+oQ7ijEWI/cqWH+qPXHB2L0AWLIrRPNuo9lvMLlaPWkCFffpGSJhGbwx5649NuD7QgoQvdz/VJZP4sRySB9T+yD4rjSkFt9+N5SzSB55QVMY9425OL8ge1tRaUkNSkKYSjIsxQItKEDa5yUAUCXB8Pf38IoZU1vPJA97ms/LRobLElcX3uHVE38O2acNEWmCeSIfGXD0gJigff4GocEBDseBN6VaPqSmetoj74bOUOgePTPhYJqZM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx5POOxYPa4u7U2QSeAc3Poj/OCV+88KhztoBMWZzwQ=;
 b=Uf42XsfOwGVe/o4TMVWwrkUh82sCJnG7aUIBsW4YLJfgWXI57GCpfkTY+mhoVx8eRFTjkJguS82HWNKx2S/igsHlXdTvVBmbPweWDJNQAHTJozHrT1q/mlo07VlND+hI80KZCgqgYS/rg/7uuulfTucbGPDgzRIytcWzdosuF4g81dGF5r8JgI2QKllrY4UM8wh3U/Bb2BFlx0lSjSRZ2i9ymekEHfw3Cr+ol9nLbWEMAg+uCDrBjhVZNSbL+xdZ3iq/zmHD4fdNzhGZ4lFOH9qJrbAPSLusVAJvYfjUkpXleXjzwWS5xY9XesvIXdi9OkkQ02+sLUB3AeSNgzZK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx5POOxYPa4u7U2QSeAc3Poj/OCV+88KhztoBMWZzwQ=;
 b=MfFG1+jSML2Y9ScXZAxyM15z3I161AQ5/bsm+5xrKtNqyJoR72CCKTBfQfiyqm+W9nALCYl95E1gCMAu6wMB7E188Y+hDpszIWTzrvmod/5uBTXGFjCbPMzJROnB3a33m1yTPFBUEEq9BskcbO/CHELHB8TODV7ucQ3VBmNldNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:56:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:56:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: defconfig: select i.MX ICC and DEVFREQ
Date:   Wed,  4 Jan 2023 18:57:54 +0800
Message-Id: <20230104105754.1219877-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a6a863-b0b6-4ac3-30ad-08daee42573c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgXE30Jj4yetxDzi/tT6bAaEObS0BIoSyBjvF8WBkxoTOKhi7O1EhAk3Ex7MZmV3E25OIK9hI75cXE2d09vxWLrn4tGOXcZvVASo2KW4BIZ7RFmIPP0c6JBzrMGQI/lpeJr1tdiKahHIpujCczT0e2MA85LWLjd4QjsMbPos6rFCtUoRMyd9X0ySFSk1OI1lsXK7rbvIMnNd8EM5OCu3vYsHvj2NyzbcrSvhiVwm0gammsyNSHW0PgAGnNSRZL5FQfkKAaDWr16xay7D89w716/J1YUmFUFnNdt2jDR6exDnBwzXItQvM1mVP7kcmeO31N83KH8JHmRnUX8Jo6DhDUazz/N9CogCO+Dc3w/l/HKmJ1chLOxYbRap1RVBT0Dkh1p7zbv1IvTv/zepG/8SZAd+n9G9KcLMQOvdMZ/Aa9ARnzfj9fpl1iXn/Y/GdCDq11zFIrstlYS0wivtqL0ULyyMEqgUMLgmWZ/sajar+YJS6PoYKlEUMfONHAdml4phVi3t49NRRelnEI9m2ODpWjijfQaLGBA/haAymNvH1RtgeZ8OYEiSWCZgUft1DzyQSYiVuhOwXP6FBtSRxMAylw2cO/wOVv4irI6My7IRfuY6X+cv7Y0cbyFIgD09noBvyBlWvLNMpxj/HEH3KFOBuL1Krd2SAy76J55DbyTCZNpAaHCDKPEUciV8aGSbhB1FGdY6IxGJxsR34p2yY+Qorg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(5660300002)(2906002)(8936002)(41300700001)(4326008)(478600001)(8676002)(316002)(66476007)(66946007)(66556008)(52116002)(6486002)(6512007)(26005)(6506007)(6666004)(83380400001)(1076003)(186003)(38100700002)(2616005)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oEy2tnltE9l/jOJI19d4D15AzMwLz/4YWf6SOM38O9AvPfuDr8GFMhL2Ggmm?=
 =?us-ascii?Q?qQ35zEc14X30fyBMpF5k5ro13SXJdazKsJSlfgyBJnN+Q9XoonNjMCEuwMMN?=
 =?us-ascii?Q?Zg2MHA80kbYnP1Ne98LscL9uCT/v7rlngF/TtQ3XuKp3JP4MOCRIBo7X4mn8?=
 =?us-ascii?Q?kW1bh/18Cg/8bUPAvXc8LBUOW4itVrGf+5IxZkCIfOlseljgZdzMOERGNZ+E?=
 =?us-ascii?Q?QlxZnFQ55XWPMgbX3548Ox+21Z2euH99JVCNmUUsXkcLPM+8+1Bn54PfwqFR?=
 =?us-ascii?Q?1nS/BRHdG7z/9O6Z64uoQbTW7poTzzVrYjFtOJwAu3pMbqFHgESAnp159L/v?=
 =?us-ascii?Q?g3z5xwzObJhIZQhB4d7VriGj2tF/tjMpCKb6G5SBrzeiqC4JdQmhqdwusM42?=
 =?us-ascii?Q?FpEZHXQn7W7bLdDReA+y/sPxbUGYMklUYJY3QQES7JM7O2jrWp+9p7WsBYjL?=
 =?us-ascii?Q?VcRs5RT8XhFrHJVW66B+1UMtjZi2dIOt6W6X3h8kO5gxNP3ulEreAduxy0YT?=
 =?us-ascii?Q?VKtXdQ6ZOcyvojD+zlKmfJhmedIkNkIiEpWSsTWpnHOa+HIWMk9q7HrpbLf6?=
 =?us-ascii?Q?BEd0AFZmbtEx2l8YkIVSXb2FaXN0frJuQvWiq1C+KiWIcx+fmyQue390BpGV?=
 =?us-ascii?Q?2YtgRXmsq98cLpIywUjdWNtXnuO3ZAWsCuuBjD9mQX+GLI/4hNwznoO8JNHR?=
 =?us-ascii?Q?RzaZaDvNzPcU26WfOOeIvQxkzmqcN91sqEKse7bxPIs2X38N8M2x4STF10wl?=
 =?us-ascii?Q?e38H8w/Bzz1WENeNPmCaNrZpPVZe5O79kheWc6LACKry5MsiwudMOvBYR80f?=
 =?us-ascii?Q?Jfuyo4tGTxkDUpsSY9akhw5AMPcWlDhxP92sC3/gac4MzEaQ0IJdzNIixDkS?=
 =?us-ascii?Q?DvMVgVfSy7Myw0T+85C3ErL9zhn6pLp/xFUN02zxgLj6DhyIZ83McMGtY51E?=
 =?us-ascii?Q?WOcFxWnnTsvuZtaBiwQwvBYSvSkR954tp76N7aW0vmoPFCI8MJ9Cm+dLIEno?=
 =?us-ascii?Q?y3LQ4/37ur9r8kf9WW9T0GjXYGVH+1i6iYbjif1TLAtmOaZU9aBHkwhS9VaW?=
 =?us-ascii?Q?LP9q7eR6AMVMp47jhD01vZQ92kJYRNTQvOIzzJ0gnRMUgZGnerKWP90kXCAa?=
 =?us-ascii?Q?QMh9ZJRbWi+gRDxlT9NXsdA2Llm6wPJHOXhIlDWYIoCtJBar26cpLFwF6m6p?=
 =?us-ascii?Q?/1TIRt5xJ+RX5q9UnK/fNTuGXS4UWEa/xYclrLKd+/xfjeqyfFYTKsSbio9j?=
 =?us-ascii?Q?xKz9AYYjKGAvMr8tfivH3BXh+S9Pm7KGEsSdKZTQmh8C2cd0Q7YyMkMFMcZq?=
 =?us-ascii?Q?LAvSO8pldyNC7Gv2aXHlioW/ypVxlrz0VM+zyZIeGaHhVxAyvKRDEqUfCezG?=
 =?us-ascii?Q?8FTyLutYUj3/34juB4Q7NZM1kuJkFCYWOYhqt9Btr7RPlgMmSR7+VXcrG4Wa?=
 =?us-ascii?Q?wKHblHIfH59So5I+69rLGJPIqlA4yigO10P9Eb1ywfow17S1AJ1ZXXjUWRsk?=
 =?us-ascii?Q?pTs1CnL8Qceq592NS/Mkk8QAbZ8+xT62rFBz081+WGeuaSMA+e8x+Mp8e2D8?=
 =?us-ascii?Q?mDDAPMfKUIV25okoeq5CgRFTCPypMXlSMprlE6ro?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a6a863-b0b6-4ac3-30ad-08daee42573c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:56:33.0455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eaboj0e1OXPCL1NzgMTFxOsJBX+HU09d/CgCTDbxlQf7tPaC2JESdSNjbH8D2A8F7D18ULVjCl3VIxbS7a1Zeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX ICC and DEVFREQ driver is required for i.MX8MP normal boot,
because the BLK CTRL power domain driver requires QoS configuraton.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..12109952c999 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1202,7 +1202,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_ARM_IMX_BUS_DEVFREQ=m
+CONFIG_ARM_IMX_BUS_DEVFREQ=y
 CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
 CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
@@ -1321,11 +1321,11 @@ CONFIG_SLIMBUS=m
 CONFIG_SLIM_QCOM_CTRL=m
 CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_INTERCONNECT=y
-CONFIG_INTERCONNECT_IMX=m
+CONFIG_INTERCONNECT_IMX=y
 CONFIG_INTERCONNECT_IMX8MM=m
 CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
-CONFIG_INTERCONNECT_IMX8MP=m
+CONFIG_INTERCONNECT_IMX8MP=y
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
-- 
2.37.1

