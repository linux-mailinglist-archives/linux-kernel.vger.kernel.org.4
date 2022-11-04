Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74851619026
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDFsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKDFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:48:23 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17072DF7;
        Thu,  3 Nov 2022 22:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv3J1IBrzkGa0LxLWVsszVBzhfdRdNjR+4v7mqZNel9VgSI453Bw/IInykDVMaQWevDVd+g8eXzm0SGwdAsbUuufmWPJU+ADr8P1F6XaajYFSWx7+XfCH1Q0vDEUy1l0737tY4fpFprHCN4hQwMbhI8AZG/f/7HF4CgQr+lsUzzhdpcLpSwGrniLvnEsC29MIQXorRbM2Z5DeaLBTYgVx4p/jXgYchLpyvymJHhpwT+VoNQScq1Bv+VclI4LQ5QQxo5qqL96YMOmEU4rz+dTEL0hBLCCh5Df4wV6SJbDwwZmtIx08sHYNDNa7QvsTd7dpQvSn3j2lEgc5sN46n3yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKjFpr57UTEnOKRUSTyZTdCGbTtR+Mc7l/+DuU+VV78=;
 b=g5GuyzumyRq/ErnfwVYsMiCcIo+O1JLl3scOSA/SUCv4L0eCpQdpQ9vdEf3iQWj3TCVttqz9N7AH7Gqix5Sxa8pn8T0sSmE07GBMRpnwDbc+fiYhoRWCmN75sglHfy7oe7FJ77pAtr78jN5O4YzFhqd4JGRYtUV8QXmGFfhAdjNjducI/VpjhUwkTGPanKPQWhKbyJ3PL53wOkFlsY6UjE+ux66z1Btt7BhdEShjHTXvcRgmkAOqnalRQD629AQ63LjQXmex0b5cPETLPcBPAGOB8pJ5RP4J0FI8BTn3Z2SyECb9V8LdsU6l1puwV2hqXY5oxDA/pIUNbcQWFo41Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKjFpr57UTEnOKRUSTyZTdCGbTtR+Mc7l/+DuU+VV78=;
 b=WrfjndVkLMiTSqhayBaZl3zxFhDHJNPW5QLb3gRnDoG7CjomvwNd67igO1E5T4LO+QPD1UagVhjgESex5M4kTWdgI4j/Z62a4T9EAs5h4P4U2aeLQ0Dq3XQNB2XOMn+nLUPppHDFsKcNKaGiq9jWBsMzi2TAE/cbXu2aUJhimi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 05:48:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 05:48:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx93-pinfunc: drop execution permission
Date:   Fri,  4 Nov 2022 13:49:42 +0800
Message-Id: <20221104054942.1696344-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 976d6559-591a-471c-904a-08dabe282bf8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NikK8fAeh1ANswSgpsLLzYRtvxWGlE7HJXpEAuFf+Pm90eT6DmqRGHFnX1Sl3E2zR7+9bfbxyJGQ0zG58cxIwFxXbso9DIeKZQ2ZLdgUs/ALoezacMkQoeiBOH6cc1i79HpbNpaqHrTipqzg+t2jlikVrLGdVUriv2Bfc5FHvWc7HDXGEVgmpdXV753yrJo4q17IiTaBNRJhwGC+Sl9GULDIrtS7UC+zcMHGaSd4IqolypbdKYxcSxGhKRe+2FtPIssjHdLTJjgGh+TUAv6ecJSgaAnglCvJkt9g+CTRjJ2YMbK5/KjBE9buzKTwRLXMQIF49YLNY4W98P8Kp2GncFj2ib5TptXaPiIMawsBcDXjQi/iPnUX9x7F4/yc7GGrmXULd8zdWslq8yYDq/UgkXRvD33+3YGn1IaGroISL3aiRR052UNxhr9XMi99/GpmC3H0rujh7Aui7+u8xBPr0PKo/i/zdbP1qNjCwW1VtQAr5SgoaqnJ28Y8MKsMAiCvUlJFoVffsOs8FShxwda8sTA8nZ4ai5PyJQVlfrE2lFe5Bp7XdcjBG656cSYTRucBZbVLRQQQ9r4SNJexfFECGkbURr7krmfeGR5USWWJIwCFnS7lPPoUGgfAY+5GtSHRKORzzWPx0rtaXmfF9dJH8lyReTi3ua2SMBHwKk4DDW/ovEbodzMeninDXggOAHPV8Dd5y2UGC3q3Q2nRbl4DIjawDTY4f0zQzC9q7f/f3bl1S/t9/ZgtTTs3ZgQpDwj/O1eJtCcLI9JG9QN+OIHmzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(2906002)(4744005)(5660300002)(41300700001)(8936002)(86362001)(2616005)(66556008)(8676002)(66946007)(4326008)(316002)(66476007)(1076003)(186003)(38350700002)(6512007)(478600001)(6486002)(83380400001)(52116002)(26005)(38100700002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwKNTKdF7izTZCpMxvNq/jHvfvai1aX/yAMw16wkpAp/cmmbRvzxuIUB3uUO?=
 =?us-ascii?Q?9usGWW/fk+71ABbe5RQ6TCcK0fcfm+iaWO1VFLhkwO71yn2MCtUDPpktIXZp?=
 =?us-ascii?Q?AmNNXskB4eZ5YtWZm6kGlGuisFn7z3ULkzUWnwCahcb4ThydfNfIgSzX6ajN?=
 =?us-ascii?Q?XxaXUeajezbur/DM0+v2f7V9y23o/iFCK5hnIY0FBW+rKJlWL3aYjRuuMVdc?=
 =?us-ascii?Q?YMeuhAdaqxWlP2u7ZBs/w3LU6CkGTX4lSXohETjS0i8s7e5p9Q4UC2ohBOTK?=
 =?us-ascii?Q?jfoITEaClSQCkkPu+qsD/5aH0YQRBvM5G0555fRpqwhTu+zFu5Exsx4pmB0l?=
 =?us-ascii?Q?llQmFhuEd0NPiijRYg3PbyLiGDAtYuiEaGDBHAND6KUZUI6AcTfrOLDszMfz?=
 =?us-ascii?Q?rFgmelZ24g8META21hz1MY+EwvyQqPzE9ZN2D73rnqyWdNoUKfenG8P6GTMr?=
 =?us-ascii?Q?jcKmnbY3SogJYU//JZVPowFIx/qXMQsPiiR4KFE4BbhMJ1sE6Fejn8tUSfRu?=
 =?us-ascii?Q?kSn+gLh/sr7SBSIL0lQ2ijs1QB3Jd+w3q3IfC4rvqt+1xhdCN/ootBL9r1RM?=
 =?us-ascii?Q?foz/W2pxUY+SHZfa8jBh52ubuzFvHhe0C8TzLNJKo/zckbtaSSNqFJASOeKu?=
 =?us-ascii?Q?+zyhNIOJlTubncLUm/j05WkTTdww/b2TvbGUgAyeReaArLzJ60ae+M/4MFgV?=
 =?us-ascii?Q?+emMSXCzx0c8HPXz929reRQXb7ds0ufD+PyPoAYT4o2rcVqNwJLF91gCvGt1?=
 =?us-ascii?Q?mZolYg+cJV/zcmGi8Ehu9n0XiOGv75fjjU2sScctPIh5DLNZ6CfCWnqS1vBN?=
 =?us-ascii?Q?r8roJq0yJhwZB4KFeQwVauUKyrvDwsNbMnm96uWht3zGF7C1FUd4FWW4tbms?=
 =?us-ascii?Q?mRdE+Am1WlFd818jLqp07Wdx7CaGY027Gv/F6Tj40vjTCBKQVgIIrFgR3aPl?=
 =?us-ascii?Q?lFu7ITmLTc22FJLYZI4RinYejhDly28TYZXeOCj9/s0J4T4rpKJVPXFNhhkt?=
 =?us-ascii?Q?6AaRP7AyDGbdNyXNcn0g1nRzLnliicNorFMwF9hJcTTJRNz/LQHXDVMPyoEw?=
 =?us-ascii?Q?HlVLhYUFghB3sIgh9ffHwOQT711k+xnFHISa522RhOT9XvyiqQnlFaz01FZX?=
 =?us-ascii?Q?1MkkMPjC6mn8eM5oyZzSOPiV4Cpy0/zc4KdKy5Tfw6YKhARI8RJUj1r1lRmD?=
 =?us-ascii?Q?iomJESsbdJm8rVTqcKn1PBG+A9SHtAAWKeJdRDZnvMh9jyD3O9SKlVgM7xYD?=
 =?us-ascii?Q?lbCKOzGknXuyQDSzwGSxXEqTBjJ2oo1TNgcvcxUObWrhh1zot5XTF798ihyB?=
 =?us-ascii?Q?Deq3i/9jtn767kjN22km6InwpVw16O9cqXAdUDX7Wc7nRsIZyxit3cO0Ft/C?=
 =?us-ascii?Q?EtVylQzSd2ecyR+QjD7kYYAzAXSdu78vFSqgh9+AfEYP0gSeJxnFgGAw7Ul8?=
 =?us-ascii?Q?No3irIRoG15LkF51vPJ4ixBmmoDWk/CwkYlR+N400umfPs094zyA0nXqz65w?=
 =?us-ascii?Q?bu6AODt1ftiYm0Esv6X9RedvPRLfYyW9hP8I9uoK7/GmuBee2/25P89iAR5J?=
 =?us-ascii?Q?IGNxo2cKgFKHcQ8Odewl5z2lBJe8JEYixn7adNmG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976d6559-591a-471c-904a-08dabe282bf8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 05:48:17.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1C2Kw7v8OtBRhQY3YoWiNRbO3kKvhJN24aZqqAWgUzRZd8md2zdNteI5wmXd1sGjv7S40GbPRyLN0sPrQkc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Drop the header file execution permission

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm64/boot/dts/freescale/imx93-pinfunc.h

diff --git a/arch/arm64/boot/dts/freescale/imx93-pinfunc.h b/arch/arm64/boot/dts/freescale/imx93-pinfunc.h
old mode 100755
new mode 100644
-- 
2.37.1

