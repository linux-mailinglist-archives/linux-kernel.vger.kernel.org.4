Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A5620694
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiKHCSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiKHCRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4C2D1C2;
        Mon,  7 Nov 2022 18:17:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUdo65Z6SAMmrWKAHlITjgQILbWTjjJdp0lgCrpFpxsotNttesSVKnWpyUNRmrv09hV1dCbzZXfgVYxJO5exL48OIZvnLBVi4uBS+3K3V+3dBhiRG2kSx0oViQ+ePTgYzV4Lw6tpRKJ7OrnJ1k6GIf9rGB6MFSlBfX5jZJGAnxnRFkjeCaR8x1G0VsEVqfeOv5YUP8z+TBtU9OrH5Z70BdAM9tBADfYBwvlvZHjxMqviKSJlucIB028H8MAVBlGQhtO51gUuxBG2LvAeRrrwQd3lQ/1v+pBF6ii0buH1DPBf0mx7SwWRs0aKTn7m3Avx6icy9+x5rTjRfGwsXG/yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=K4xmWqKZpPaPEilzLRk6g7fPh7IhBI9m+vJY0XQBqkCaQlQSUUVX1gfp+tBg7JzuwWhaH5YKmCGg8wL/uHc2tIXh5DYvLATcomjam5yp0muSD+9fNrb/MjVjkCjJY7a2flNDi5LGj9oL33AZD4O96viMOrPEfQomqan5dupaQ38I9CZF2jlLbuhKEyPciN2rRU+lfysEeZUkXZXwS7XaXP6X/7HTfOm5iRaqk7cytVRUmtEeojNzvgB8pySQwpBuZscfbJkGKZdKp58qpYPAbsHjvhXxv3iKzV97wchcMzuJfJpdKJMCMKzdb9dmv3dwdZjABdid/uOz15+NPCgHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=NjkLmkT/ORH1QpwpvNEeltt0J4CvLinyjZxiagAUNn5ahEhmpgVpB76BkwazkSjSNs3Y39l9AOaD11CuJDeg3m3ZMjJ9oGcBWr98jOXZjKm1cDn7i1nuEd9Ua7lB9UPQPquReLxkpx9/jie5Mf84diZ5aIz8hTcN4neoioczJTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 07/14] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Tue,  8 Nov 2022 10:18:13 +0800
Message-Id: <20221108021820.1854971-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 53692417-1108-4731-c32b-08dac12f6747
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DxHQ4lHBHIFUkj2MtCgt6Wna808Hg0n0p6hFsQNf8TQpFAPeBJ2GRkOgHmrAeD3udXMCbuHAE+3+gqscW4jisruydXLDhgmHSxeynHWfiLM+q1JyEgtRz0llAWUNfrhCC5yOmRLZwkawi4GDfJxU/aK23gtqADzJdpDDANvTqpfr/iIy8v+hFzaKX5fX0oTycUN87B8fv8ijTsIPa5cGl93KSocA5T8RlbDjrQz2EMFWHeJW9LaWTWz0giKs4Sta6S0AYUFDkClEqD1wPeAA67q27W1kCKvkx2qKktmNeooAeUnxSMcBJZDK/t23QWYHivebatUvEfaap8ansGAiv4hMWEUtXqavhRBDnaFI6t2n0W1DrTZTYm4zJpfPwV0JC9UKEeOthTCKxeXKbIErPiv2CbOL3nsnLvNMtFvyMsuDdABbA5fyYnTzMmojkuqXYhPVTzNf8FjqWUvANxNz/PmpXqRvNZJrxCoJUySx254nEV0I4SOAO7KiA+a/dM6mIU8LpAM70/zuVJwUpyOHLExp+a8N66TPNGYPEHltcM5O4Wm0sX5Cnzek7hX4fD4ee54kqSK0MY6d8Sy7uxWdGt/nsjaz6nBvQ3oS7qWyusAx56BNVQxGTyF15T2bcMWxOrHbWIBS1zD0lUye0B+ao6ii6fdHAy7dxpmnQ4YlEjMt27mVa9p92DfKH00/TwOcqYOeiNT5YrmKyvC6Gy1Zya/fo6/ZvPThHsB7Mij7yljOO6x3q+AE4uPoNpeVXzewBdxHXC9yI53UbzT3n2dAvtOPMK+9G93I5TIpojHqpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVCOYnDqXPfxSJCLqYiEFU/T+p8cujhh1f//L9WiK1cXgIZDlQax4I6FG6KQ?=
 =?us-ascii?Q?xrDKrG8DHQOW6uZO8L3kkxjYs3GCKeHeK0LxHApE4RwFiCS/fid8sWPzfmVq?=
 =?us-ascii?Q?B9CtRFCs3zvpY3jnEVBZzws9PCve1mFqQ6GmeevzUkF+A+8FPPBQvBVxgkgp?=
 =?us-ascii?Q?Jog5+i7Ch1Dvc5zoo12J10Xxwu+VlZEni1jEG789gixN8NrxBGsRUc3JP84g?=
 =?us-ascii?Q?LP33VBoglM96Q3NTEQPDO7mSc8mJCuCQEr2mm33lIe1s5TMkEWsoXavjHtEk?=
 =?us-ascii?Q?WXYPQa/zlF600XkEwN4JNJ52CZkSyMKPwQoD2wNZ1KV5B8y8FpHL7msxrS22?=
 =?us-ascii?Q?PYdtbmaLBKy0lZhZ0eC27iOCEs8WrGC3ZxyiKQIzmpKqD/mqmNrgvZ0CDL/f?=
 =?us-ascii?Q?CGdBOvMxzLHtCsUHy0l2byMJVfV+N30z3e1OOJZEtTyhzIkfJRqyZwOjAWf7?=
 =?us-ascii?Q?PBOyV9ZEXBWW/meS124gBiOaJ4TEqpS6cUz2uBXbhk9gnTvRhvXNqfhW+cB+?=
 =?us-ascii?Q?P7Xlu7tuPTtTbWfbXE2Mi95Gb80OGYm5PUwSHempm0+jsQSJaGO7AhWL1ket?=
 =?us-ascii?Q?w6i4c1CZWrv4ob5Iwj/d+YcVVHIJvoMKtQQYXRWIJ5Kcp8TvaAloefe0dSX/?=
 =?us-ascii?Q?uBmUDO5YIFE/brYceNmYVz17sCn6/pUn0/gzOxQpNC9gooDFNIqnVCfH8973?=
 =?us-ascii?Q?vo4fS8ISPPYuXEBXpAXxN+3h3LYq7tTLk9bRyvNahvxtDH+rVtBXFglF/1mr?=
 =?us-ascii?Q?QBewtPwZncwTWVvSPuTSU0mYiu5BzMEcb4ZMHWyjzI6GYk0VHEjTH6zrH8Rw?=
 =?us-ascii?Q?9nxDANOUmOpZDTCk2Rr36l6HfAMeAyAjMWW15LonXWx8Vvdev2CvJAnMp6yS?=
 =?us-ascii?Q?z4SihVFkl/B0JKENxZcjkqZ3tJqZsx8cg+b5v/M4Xj6OLb7Q3o4VCgCszbPe?=
 =?us-ascii?Q?tW6xVCE9nfoqchF/pnlhzTXtV4VPeQDVW7CuDZCDI6iGy2p4xwp5y+iqTjmy?=
 =?us-ascii?Q?+gVPhSCfiGJTPjN5XjHBDc7MryN3FxD9JxPUE7NQw52nKid68QxAYrPzvwRZ?=
 =?us-ascii?Q?0cf1vX4+KydXewIoQ0AOTG8vPW0mTA7Y1T8yk7Nw/c7RcN6CsrUYOyuOPNXb?=
 =?us-ascii?Q?ZIggZWoWqKxaNItdfwUn+J9v5vw53mVQi/etDQn3Jx/YvFZZuVEGfDRNtzBG?=
 =?us-ascii?Q?7Xt8V2Xm3MVydYfgu9DME9aqssqiCRU+FMCFDAXyX4nfIfZ4baP+mA57IBMP?=
 =?us-ascii?Q?UoTyyBhjYvcOXgxxlPJvRdYB6LbqxU3XiaBx+3e9YptdsSZQZx7BSQk1nH3U?=
 =?us-ascii?Q?glbuaLyc73HdGh7hjCZ9/cPFFeAJlW7YWEq1+jA/gPciE0R3zL+9FD1adlQB?=
 =?us-ascii?Q?l6OYGOeIKxXvkpVFzDaP+P+8UvofnAvHG3mzNzYbDiYbDYOPZyKQ7FFkaLmr?=
 =?us-ascii?Q?fETZXpmXcD3EB5gxWeAVECtUq18nuB1ApjxRmTtXGU6dOdxRUVcZx58jBy8H?=
 =?us-ascii?Q?jc/HYpWZU18oeuk4Xveu2dA1CGRjEmkwBm5jw5Nq5qtU6hiMPRpBMK/D3TPi?=
 =?us-ascii?Q?X1ZJFfKRX96/+sWuOSw4uEw0Qgd2Gnef43e512lw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53692417-1108-4731-c32b-08dac12f6747
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:37.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU6+KfmUYi1XgaABAq+ZEPb3IFjUxMWtbAw2BQhZOBgFBR6QMUnXP3PkbX94q7g9x5CsL7RWob82FgVooBmyyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
BUCK2 is for A53, which is handled by DVFS, so no need dvs property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4eb467df5ba7..a5a7d74ec1d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -47,6 +47,8 @@ buck1: BUCK1{
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <750000>;
 			};
 
 			buck2: BUCK2 {
@@ -56,8 +58,6 @@ buck2: BUCK2 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
 			};
 
 			buck4: BUCK4{
-- 
2.37.1

