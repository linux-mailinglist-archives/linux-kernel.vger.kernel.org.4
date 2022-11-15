Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2462941E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiKOJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:46 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965B23151
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0QGR/utIV8l2BDC4QuPcaghINGXW4n81dHc/QhHMFSHE07mbBHeR2hrsSCvBVMa8ZAVkxWttmsE3RQx0B1jewdxraz9kzdaHk76TtcbRY2NLGhIxD4Kc8FUg+hkORu8YbHiUdgl1CLkfhTyHwHOvUX7svldVtYnzDm27CVhQz6SJfVsZWXf9nGlSyBFOPcOPExfISeLCxdhMxoesJged9BHRj0r7jD4MoTV7krFRQ/izPnEHA4EQG3lYPdC4Vwa/jZei+q/aFVsZEHrSfCEVg/ECbg2Q2k/xjFWEm/VAHcfcFZt7i0qagfGzqdzh6J0DMCKSyXtQhnfTvtbbru9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=ZeB3nYWcqh797kYiELTHPnJ1uhJRKh/iqo6uaiC/KKsvzwIluoPJSrGQKeCfnWJ7yEehcHZ0Kkg91k8QaGDbGbdzfV4SCQnn4tHbZqdHqQ+HduKmET2kCGuBhqu2UJWg9PZzpwt+/YxXv+kAlA2V42MVYNcvv15MN4GBJlGjhB3mHS62wHtLrlUizMFVKmcrGcbJrYguD6QmznsvrPh0UhrHE/WsUPi/KC/YaLojMMbLWRrOTjvhYCqZIM/ZHcTpVViWOFElJohyDP6HLtOLr8f6UBBpcPrAwCq8LGXwbyHBbnvApFAINMJU7dvocC3aBE6nKvI6aayceyH6u9Bbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=KhKCFrw3odofllkmEZLaq6NZ+n/hC+QqurhBzA13+mrdOEuNKtWdQYjBaq+5iZUXGEVRWhb6afpWiQYleXdYEIEDUS9OFom/qsL1c/Fi2AKUpA990kNluL273u+wtGmRmJlTs7w94SPUTYotX+NtBruAJdZqPdY3Q7xs5kTTgp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:16:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Tue, 15 Nov 2022 17:17:04 +0800
Message-Id: <20221115091709.2865997-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ce2824-0cf1-45cb-24dd-08dac6ea06cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +nHAA58xoXIC0WU6ZRFJH7/WUTVRtVaPXn1ThZh1dNZLEqYOCzOzNTCx8mxPPmwkVVLA4scOwGpN4GxQuBjgZ0WrLdtx05kRsbiRuSM8xNcjIf7CxmLoNl5bMJh5PnJLK63KWOZPbwLPyl3QNBfvoZIKvq6upM4rnizZDzwpxH/eEqC1+lzwGzANdh1NW8XPUsH36nXkx0obTu++5j0HI4SOzMkEyK2dNREpX2T5RZs58KsVMHPcVCOEeFOUXCH+nqLvYbEuSm5F/9ky2Zx+/ybuXBkBzDylyCdVlB8GVLJ5lnrqaJ54FJWrLB9yY8qMnyer8Rz+O28hFeXZHekHQ+3YYqutRQb2k2SfdigN4/PK6eChizsoE6o1jTo0/H3fM2XDYOJq9Lsx3Clvx0+iL6X1SP/3uN2Z50r8oreNpz0TNcKiw+2yrX+H5euHBgxR7g6IEe44tVgXCjm3NVSiFiiOF2g5gZ2FH4pqAr5Bw1edKhA/XZyqnuAO4NhsjLfKqTYijFFlxjFPk/DXZr0xAgh5lH1AUBXMLXUqT16O/gHnEKtsjiIyNuG/sxH3SVHYpCErj7DvnPZ5iC9afoyVzok0ms2Fn4lmvG3Y8S/raPwNoHUn96G9/lYJEZDmtzPhf1JKGpOhhnWEBpXv/tlL9nO49dhXCQmsw+Wj7AWrjCg0/iZGYe0h5nIDrl3HK6acx3eQLKhS3gk4hsgcjCaSaYJnXPnwLiMbKfkERTvjNwb1pBbE6D9peo7vy0d0sjvq11M+Gfv9H02I0RRTLNJaht4uUegC7mPUDaSu/aLrRgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(478600001)(6486002)(66476007)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?we+BFuIT6pQ7+4LU+zQllOxVxpf20ePCLBpgNh+FQxifoalDlzgCFoFtfhY+?=
 =?us-ascii?Q?dpEPLjkvsfwWTaAMt/M+fa0NCBXMH2F4+mKPblyQvUKrqX5dSI+Y6Ow3imP6?=
 =?us-ascii?Q?TSb7H+RqU5W6kS72MF5dDzOslYRc1Soah0ldndOKFIpkimVvj+aCcHAZWY+g?=
 =?us-ascii?Q?exq7QpAypB22xZMohjVRAIcDOsXT6YEOxCERCIwztRO3G6Sx3nKQyc9cdDEz?=
 =?us-ascii?Q?DCjHKuV8OjlIk7yTqXTITPPsY54WLT16F289bjkPCB5eunZg3a4SOdf0DxVG?=
 =?us-ascii?Q?RFzp07f58ASFgpUFRSn2amuPGU8cCM3L+Gz0nT1pHk0H5voG0V6+KM9Q2/8W?=
 =?us-ascii?Q?GmB7sHd8rwTuvwJNa9f7hSV17OOk6hc1dd9XKs+RYfYoec1d1XkVimgRoMdw?=
 =?us-ascii?Q?IpWizXiXG1iGtkn2Z08BKL1HkZfAGvYjYq2OkGlB3GeRKbLkY9c3grkfjIjN?=
 =?us-ascii?Q?u1mgkybKIbV4hfkPphPw/g6prWZnR6ZBM5hdaSR80RqzqhL88cKmrpfFfyxj?=
 =?us-ascii?Q?KLyxIKY05Iu0Kd+UwYyV+kdo29kZ1CAAtnWSiY0x85iK7oExug0HOUEmSauq?=
 =?us-ascii?Q?waKL9oNZwwsQEfqkXvJ1msHC8jg9BPw7r7ddDB6Si8owFF6vJA+id1j4OfIU?=
 =?us-ascii?Q?CMCvCadeAjNou+NXDbto9qtLdXkWxtM/ZDtyvZ/6tmIUXqQKLW4Imdg8AXLj?=
 =?us-ascii?Q?rIvuU5ZZkT6gI7Fh7wb+UCUjlyLZWUPXB3viV7RBggK1THPT3XfowcpJnMkp?=
 =?us-ascii?Q?uLjWjQO1vnilVr9KMJMaYTsGIgTZc/sQYNIStbiuk30/nUr9M6R7WR9s+XOB?=
 =?us-ascii?Q?mrudyNACb8FA7OEHbu5CDzh07btNzOZ+CuVvj/d+2BmCoJChhAluJYTcAWpz?=
 =?us-ascii?Q?KzDkuFTSktYo/e+SPS+3+yBJdZLV9AUAVbmlYf4z5ueNo1lPPB6AEM2cEpQS?=
 =?us-ascii?Q?8B07QLFL3ZCTSpieiHPlye5OhC9LMHQPdwtupmiJAx6qP8cn9qoOlP6iXq+h?=
 =?us-ascii?Q?4AxHuUSQ4zepMYpQV4sl03w3FqPVVBacmTOJ3bFWdowD1OevrbpWA9JPpvWk?=
 =?us-ascii?Q?AuSiMr7QWblPp99jHUgtEtREmfTDQt8OTjX2c2bvEI3EizeDYcNusD3lEeMq?=
 =?us-ascii?Q?VVwAQfyHEzU3BdGbUOaVDCnvmvpRFEtRGifp+gkbhwp+chCXM0Ea6aRl7zq+?=
 =?us-ascii?Q?Dk/ufCsPbrXaIH8ODfm1fbz5qL0vJujCK6mv7vWf47sRMx1ivsuKMX2FEFRM?=
 =?us-ascii?Q?lQ0SKAFjyVVjNillFtM+0+TSjaQcajUdmsdXDFjRNInvZrCS1okXea6Rb++D?=
 =?us-ascii?Q?Y5/q8IxtVHFyAFPLUa+kU1xvrSjpMK+6gquN45LcACRL8Zg5f9n8U7qJNg0C?=
 =?us-ascii?Q?1XE1Ce3s/2KTGcNRGdHhvBEx+xL23zVMfSN80U6alLLFkK1PrtLED76kUgJN?=
 =?us-ascii?Q?+i0d/abZaCWdB1hn5lmvpwYIJOxL0E2ke7auYgbhuhisIn/xAP1MXS0HJAsp?=
 =?us-ascii?Q?iX+f813iMWLTBHs68/WcV71MZyRauAfdYfcOpTEytw1DjSfjh9c+qOuGLhSp?=
 =?us-ascii?Q?ETz/TqZ4mbzfeoZumMX32WtrFsWZ1uyWHKugr6ND?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce2824-0cf1-45cb-24dd-08dac6ea06cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:06.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zggRh++EFje3EUas5VnJsLFaQj+4i46lyTjY3Zo0ooBePTi2i+HRBvsgZwjY89+AnBz8gWYT7t1fXASRxmTULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
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

