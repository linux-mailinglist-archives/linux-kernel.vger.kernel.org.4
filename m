Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DFF6E766B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjDSJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjDSJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:36:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796E13865
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOytcvNbNv03f0sdNIV2AQBGRz5lWjcPvozrSKoVFS1KfxE2QCthtDgi1geuPPq3xR8/ZcMCDiQZqMujNgDARho2xGDLcp8Xp/UryRRpg8Cm+iTxDmC1Ix3UQqhKvnD9fSWrLA5uzcKfXIlqpnXj/8LnZqnZISGSfV1MPAAjAFxJNw3jIP8YlZwxFFo0Eee3MhugUAVtvwaKB7aog7jecFg9C7AgczK+8yqRBQTYgNhwbecPnownVkYel5QFM1tHA5P22HC0ReXO74E9QDs3BCXcdcRxylBd3OkXTjNlWh7xLH0KR1F4swNP6xg+ZQ3lbmbvfoGqnb2bPosb5vZUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNFUDXh4H3PcZ1p64BPF2/AMuCPCwF/IAeSQmpbOGM8=;
 b=B2r34Z3NCnIn4z6qfW1NQmxfPKPIIB7Z0KnJXI9dTblxJiC+1tvce4+B9Bzwkh8HLJC4hDEJ+mFvN5kHRkGkylHLNWmJ5mX1bGMb+iReYCIlUataeLsVXqU9rHPpA1QnbPLIVkqNl04HtT1XA8iFAqoAAYI9ezMCVhqapzu4jFFB7OrHM4w3C94yPZMGKTY2Ou6E0vL6gl57YNx5UTdiXaVILJDhAl6GiCvvlIe44oFXvlftYwHPzthAheWcJs9IQC8xNO8r37fYxOpgajSAClvFfF+ahVyxfbUYm6OZ5vVqTlYuL4gPX2DGWC1k50Svtc69c1DOr+LgT8hMk/uBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNFUDXh4H3PcZ1p64BPF2/AMuCPCwF/IAeSQmpbOGM8=;
 b=fDBcJ0EOQX1yyqmCMVDuc84ePMLb4WfOvf2X8i88cP75rb1M7CycH8dtS8D5FeFCBYp0OuorWboqidOf54TKT093IBhBxjnv0HlluexV31ynVOaRDBaEcyAyXi4oO8d9Prxi7ku74XaBvaoy/N3XafdESHsAFnH2F5L8nv9H47I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 09:35:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 09:35:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, rafael.j.wysocki@intel.com,
        vschneid@redhat.com, ben-linux@fluff.org, Pierre.Gondois@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: kernel: smp: ignore disabled cpu node
Date:   Wed, 19 Apr 2023 17:40:39 +0800
Message-Id: <20230419094039.3140521-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: cff194f2-dff7-4e79-59bd-08db40b96ede
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL1J+9Iyl2UHL4xVQ8xhVWnAsOzSr2c0984617tFuoa8rOExGOal+wnAZlMWAjlw3sZAzUNHhzLsb875YTd1ZUCrhISmT2MCOduaCeXg36iZ4Z3BbPyKbl1frWgNmubXBC8fLfiEdpyB5hI5vb61eDGdGKKI2bTutAUmuKMyh+1xmv/v5MQ3Jn38zNdyeXKixj4BVNUM/GTvrTHIQBZFQG1c98PV/swOqKfXETa9d6IONkxuurRM0bhNp7HJsHl2b2D8DNMIkrRVi/OP/DLy0CLKStAmqv6rn2OC/fvnxW8HPHK+yS2k4BoGGLQ+yDboWufttaAsELZEtIFb5ZUa1E/Pvki6MD1cYP7fhaR0jRd8XBU6inYKAJnRyyhO2zzUiLylF+hqrVtsk/vTopud10FaU3Xr559Z5pZFPo8KcckWjQYbAArNtDg9Yc9a/wdvERIFgwFHBI9zKJyrXHt5g+jc6ul2Ve0DGS4Yx2hKO9Ab64JdH2d4SvLBwBqiY2jxKNOKMnxRH1w0CWt6D5DsPG5DwAi9Kv6jsu9qWbIi1dcKKIyd14jzEfvSmRSs4pbN2pYtPFafYUqk+2TEYvvms73LFJa7K8o/SOGzUho+wpOT9FF1A62knr0z8GSVlOlZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(2906002)(4744005)(8936002)(38350700002)(38100700002)(8676002)(7416002)(5660300002)(86362001)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(478600001)(2616005)(83380400001)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErsS6iXQ4K3Y0gxMZwN6OCTQGY5G2NeS5E+5lZ8PmCctgEL9BzkuZfnexMRE?=
 =?us-ascii?Q?i4yYoK41ObSi9aZlrICe0qS1e46nUQ7fRiisg4n8YFsZPzO/21Ls8SMXXcpe?=
 =?us-ascii?Q?7ITK6pybxHtm8fhuYSr5Wx7k3dajzOnOCu1DYKKEYdqiJ4plXdAHkM1X7l7V?=
 =?us-ascii?Q?YHsoh/KK5+BNuPKO/KTYch0x2D7lWCDkDiewfgjT4nFF+ZN7XB7jyzuj8tL6?=
 =?us-ascii?Q?cJpr1QpvO9pcqFZdjbxGBBoAhtGXnOzYqONtYPNzgylbvBiXiMCxzGL0EzzZ?=
 =?us-ascii?Q?YdsspF3ThPj4UsMHKNZ3ApI7+yS06I5jkMWf2CCL43xlt2FxwChaqE1CwxxR?=
 =?us-ascii?Q?grou1Zdch3Rk8g81kLgUVWA1BdEYaxyf7POxv2Jb9ZnrQRkh1gh1z9xwXH+4?=
 =?us-ascii?Q?RnZCuJhqVuzhCgWFke6D9Oxvu3fGs+ASGt0XzHN78exOrExE3TTTKuSqYAqR?=
 =?us-ascii?Q?bOfhwVQCFRmJTEMCKPPppP2I/z+scGv/fNiQ958X5tYgjdBFQr6ySaIbPhqK?=
 =?us-ascii?Q?hN62pEC7XFHLRsIC6SrG17Hhxmpn5FhOq0Qp4XU4RSD1iBJa47Tsw8FqD4VW?=
 =?us-ascii?Q?aAiZZfGrorocs/a+HQnur9ULV9h2QhVOMIQNstkgy3r4sBHRrY30lnSIzhRi?=
 =?us-ascii?Q?TYIMPBP105puuqP7PMMZbLaTcPOYeBMVnqdUz+Li0xOITQKPhWpoz3hQqlqi?=
 =?us-ascii?Q?pdIHQAgFTrMWjiB102Y9LXt/1ayFQfFNt07p5sE5lNenwJnaQI8Nt02pccbv?=
 =?us-ascii?Q?xE9EYWZrOTSyGvsq+C6SPqot0Wbj1kZ0mdhkGi9nCQUdVXtKvpGOieGad02j?=
 =?us-ascii?Q?CXBgl84eqJQ9AxEDmIDAiB/RP4XdWG14FTfv2Pn2VCN8QHworiJQC4Fq70f+?=
 =?us-ascii?Q?ksgc09pFD9eVuZAjTEhKGJVh2VpRv43HSrnfd22bXiAAuW0Vjg5gtAoo91DN?=
 =?us-ascii?Q?R+O7YuOWEEJNWsUsGw2wIzLolH9zUJE6AX4ITaNPUfObH9ZgEBISTNARrc6v?=
 =?us-ascii?Q?ZTUBoUp9BxNzPvWxvkdSxpLrV5KZqQ4Vbl5oQY5HWss3Wtp7IQ/AjTqzXFBa?=
 =?us-ascii?Q?lki9JYlH8z+6PPI0m6odbO6Q9rROkyF5dIj7aybMKtSj9qElvHs/cHOyLZqQ?=
 =?us-ascii?Q?Ok+9D0PvuN15PDDrIP9p/Bua+J+/onzhJzTRCzbALXXnJFTbzwDP7nYWoMxp?=
 =?us-ascii?Q?0NOwmlKCdDuq3Zf7WNeJhLfMJHBLV52qAOZg9D4RLW83kbPyJYxlUYdEYI2C?=
 =?us-ascii?Q?dTqXVuV71jQB2AI8SiRtQ+1KCEH0ex+XUKvIuS8VSWtCegRExtZobRHE4wYW?=
 =?us-ascii?Q?itT5TC/KWfhAVrrUL20wQ40YipQrgtYVomA4jdkfpyy9pPiBLcWvcQJXyop8?=
 =?us-ascii?Q?Fo1qAejEIqANE7gQaDvv8el4Se6bpd00KDemQCGkAHaDaSbAreTUilyPCScJ?=
 =?us-ascii?Q?e3oZIl4Xf1UHe3iBmZKWVmHRBrlYFWksLJfYjs0uVEQjI9uP/qY+xHq2nQmZ?=
 =?us-ascii?Q?y/V/rWBn9tduPZhNKuCIUxWbLmMnK91ssy/0cUxyaKhoVzJPPAjFZz9H20er?=
 =?us-ascii?Q?YnkLkKIXYgYEnvUIVXHjoD2WpoLgLBqRa5vsb1q8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff194f2-dff7-4e79-59bd-08db40b96ede
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 09:35:37.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CZjAB2Ni8SgYIMKCAs/u7eUe4QED6SVFGiZEyr0ctXmPGxEDOPWuGyV2H80+2RSqJgvh2C56HCkg8R5yPL6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If the cpu node is set disabled in device tree, we should ignore the
node. i.MX8MP has some variants, which have one or two or four A53 cores.
The current imx8mp device tree use the full feature SoC. With such
device tree to bring the variant with one or two A53 cores will cause
issue.

The firmware will update the status property, and kernel will check the
property before bring up the core.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d00d4cbb31b1..aa1d678adf4a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -631,6 +631,9 @@ static void __init of_parse_and_init_cpus(void)
 	for_each_of_cpu_node(dn) {
 		u64 hwid = of_get_cpu_hwid(dn, 0);
 
+		if (!of_device_is_available(dn))
+			goto next;
+
 		if (hwid & ~MPIDR_HWID_BITMASK)
 			goto next;
 
-- 
2.37.1

