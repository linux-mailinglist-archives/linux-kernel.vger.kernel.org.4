Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23B654B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiLWDDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWDDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:03:18 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3CADFB3;
        Thu, 22 Dec 2022 19:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxYITgFAFdqfA5rIotKmfgVn/UCVNhBjPZqJGEssDaVUb0yzfZC+duUOEq+a2PUuy6QD+tZ4bPu2PEkOpzKMKBFOXNNMWJLqk//eeSHnWmm4qrIhxLQyvW1LODZvLiuUVA7GbyccJ6ZK7+4FnicRLHHaq2h+GNGHwy5An9coGoEgvP6w0jlIKZrmZ7wx/GL+fP1DkR5YUp/33/+0BeGiAMQiRKASH1wsvz3v84YBL4PvzNp91yt47Ye68hJKv+LowevvH3vebL7K5sus0ZG/R64kc8PbM0NvsSNHIhpAH4/nbnYHIosNJCOgcNt4phjgC4MJXiCMEGYKuxLvV2VWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ineukoqd5bXpF459ghyQI35+JJv4U98j/vYXxyW6ge8=;
 b=ncXy09FxyxntJV0/MrO1OtDnrvHia0KSau2eyWf/0CFWMVpuJjIujUbTOvysPh2TlmL8w/R7hl7T5auCATlHXzUB4KHShmJJDl5aheog5Cd3CfflOkQd94y2++UoqvZG3MjBuYQoXdH0Vo4hLW65rcFXvEZYEZTqP/wE+XQfhOP/CbVH8ck6cGm3LQShrdWpX5QgLMnlU/JkeI0k3xEccMoe1DD17g8ZItfLeNlxsuhOj93+HPZmaD46ArmvnxaaVjx8CjGXXT3ycsXc2WH8Okqy43r8gQZmHTvOuWfIl5T70LwSboRaiWyKOWSfRCvwkAYHiY6ydukuc2hOWwMOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ineukoqd5bXpF459ghyQI35+JJv4U98j/vYXxyW6ge8=;
 b=kNhPmoG2VtkIAlY1NSY6hf7MXjG+Z9kRRNAV5J1gbBMbQNXjrVrvAa9J7ZcAtlG6TduzwXSRy1j+TDA8Dsdr9t8y0ciEjBnz2MKXLKGtPp0YBsoDg7Dq+dS37gSDCon5bB37My3HySJDpgSDYwFw9qvWHuLZ3sOS1f8IfEjNUuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 03:03:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:03:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: dts: imx7s: correct iomuxc gpr mux controller cells
Date:   Fri, 23 Dec 2022 11:04:33 +0800
Message-Id: <20221223030433.17345-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0086.apcprd02.prod.outlook.com
 (2603:1096:4:90::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fb6d1f-1ed9-459d-7a48-08dae4923b42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97L1CT1/dU8szDWMFNtJZ4FdjwAyGDUxkYdO3vZ+iObwPgqt9QeZjUR9nr86nZ+OlQ/SHw+lEDTvbQjEUAFEplT5UHmAkShcKep9WfI2mP11WS3kvvujnB76VN4kNnu7ZuzBURwNMnvT0JPp8D1TycDrm4iNaMRO7yCQcqtjR1UtyGvq7Eohmw+yn3ye3KvLsri+FBqzaAie0t88ZDgOEj4HrqcSxBkL4+fbXEdpd/hPBPsjbaaeDU0DztARCUUyBYr/SjUxeelcpBs0r/QVGSW7BTF1nNW3LJAkqKPcHScKXWVHLxQXoy1ycMmpCTp18NDKCn0aB7w8XjqTLUSPfnHCubegevpNNW4YIPyJaiwHMa3eI/HtpeArM6AYjc3mDyMtBmGsAIlW/wAR67vGEK1Ju/X7bP7BCoKZxHZIYHEZxFU8QTsxnlFn/Ofd03vRSV03FEYChcG4t8pq+TWxOS/BuD/dTgcKCPa3Kgx2ECZ4P7g/PfRVNveSULsiauFsg5D9cFjTzheF1ANUeHLIlwrnr9uVF3zc/R67iF6tes5KpaeT9PE6ntqkb7KKJux2xZlezp5JtiPb9uaqj/6976IozD+gP7ycYLsh0NkBc1bIEKwG9+N9EVPBN5KfiEi2wpFG1Ey0lB7veW3VH/ZlZr1P1HezwNDg9ArtvUj0BlgF/zYzjueqVNy3TOPiu8xHPtwe81s6Cbt2zdB5Ue7LsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(8676002)(6512007)(66556008)(66476007)(5660300002)(38350700002)(4326008)(66946007)(6506007)(6666004)(52116002)(8936002)(38100700002)(83380400001)(86362001)(316002)(1076003)(2906002)(4744005)(2616005)(41300700001)(26005)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sYght5WRdfmEMz6o3VkH9ES6FY9GOvMlcOeuYF3MDTRu4AHZ7OryFSMe4Uo?=
 =?us-ascii?Q?DXFIDTaV9TMYd31AZ5RtGqKKTXRdD9H2w2zOXcqAP9wloCoAVktOlF+yMnou?=
 =?us-ascii?Q?G3N/apkKOPZV7w22Mr0sdAnq55eXtjDtjkoByXQYu0MchKvq8o/els/dzLWp?=
 =?us-ascii?Q?8y0J+YoyMpVweh2C223snJioGD6Cphh5Irw7TJXD+aSEYiD3/nJeKfDmz+Mr?=
 =?us-ascii?Q?ts2k8hxhQJka1GJpD4W36p5Xeo/nUqysVnt28JNm0xF6x0s71/arw5C/oZ+u?=
 =?us-ascii?Q?oxcnMb64DXtEqjg/Jb54jPvuzGaIC4T7Qg4Z88tIkvvozNvc+DOxRHWcN2iM?=
 =?us-ascii?Q?SAYIYaXBwiM2nKbK15nbZlfUxQK0sEdoGPkWklSvLSNXZwqwJN5Gjtze08G+?=
 =?us-ascii?Q?mxqnSmgnb8hAlDSuhjXqt0fw7anQJlhWwd4tUmllLkdFU+NR9/SFea3cgbku?=
 =?us-ascii?Q?ywr0J3afAmWk8BMiDZIAyI4gibQpPrG3C+v8KffzJV21+eA174UozmOTVqLk?=
 =?us-ascii?Q?y5RTqBt0493SQouFVPZsWqnaOIZrSlKK0o/ttFNON4NxbJueUtbgRfgGCVBw?=
 =?us-ascii?Q?tP2Kfhkw5kkCwdwkXNy0Lhk6frXhXdOKi517n8hLOvG0/ON8dMLvIvLFYQ3g?=
 =?us-ascii?Q?aqHnuTj5QbXoSwYvfuDpzRbetLaBjXN0Wt7HflK79SVCKNCmFqm3ovnyy1Kf?=
 =?us-ascii?Q?+XsTl8zBjJlmoeEacO9T8fVzS+MJpWCNSWT3URJb9DZikooGQ/pKa31yDDgX?=
 =?us-ascii?Q?M7yrelcPGvz4DDjnG2dJGNTuVHAl0iNd7foCHvcwxlCwZatDvfaTvZuzhQVN?=
 =?us-ascii?Q?EPF183RNTidb8KdXL4kMGbba/Wrf/73pzOr+lL2DcyYOlUtxmpdp/6F9u7Xp?=
 =?us-ascii?Q?cJn7qoG6bWh6c3K2jp3XMbSPw2Cxq8HC0oo4WWqRYmt4NMsLjHvDrgZoTnmw?=
 =?us-ascii?Q?wQVUi1ewhiFe7p6lqa1b1nPHDr9zYZNA3aY8MiXVmZwyj77jlUgpQDyoc10l?=
 =?us-ascii?Q?VfmVlYif8zDAO9UqRZjfHeDuuXXLruEDIiVj7bja/C326iKtiTPGwCPB1eDB?=
 =?us-ascii?Q?Hnk3Mvcz1taJDjce0mNXWv2oP1EoyTEAwJpAByZdOId3BiE70jAnoH3F+zup?=
 =?us-ascii?Q?SdmwwzyoMGXVHtRRLdlu4fZXeQ8X5jRtEv4FAcZVJogl0Csw/H+Oe/czxHFC?=
 =?us-ascii?Q?cprzirumrZpG34Kb7pegTHp9JJQiPy8f+W/uFu6xfSJ6CpC8eam6q+TlKMTy?=
 =?us-ascii?Q?JTXKZcXORRO22whlxmbauWgi12aHrOLv6QWD/3l0f/fyKrfWQCDKEszPt8Vn?=
 =?us-ascii?Q?Gwl1neBgy0d/MUvt3ltDJg/mnaCtKLHvIRWjDGQS5+BbBI4Tjz1JD155baXe?=
 =?us-ascii?Q?CG+H/YaMhmd6FtKNcyq97kkdigLuKsT2lnWcJ3aGCb7TNnpILosqwq4zqm6v?=
 =?us-ascii?Q?kD3QnJ4r3mk1dbNMnwUYNoRs7OslK0Mza3UiD1Q5BhjeoJX3BNct7xj0oP3X?=
 =?us-ascii?Q?Ns3tefpDTiCdygas8D5IncGBdXFsKGXBuz9Ht7SFBGb1wuzge6dfe65j9FPC?=
 =?us-ascii?Q?qhlFRixU/2xpmltvk45z6Isstrh+1uKTwJ674Icg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fb6d1f-1ed9-459d-7a48-08dae4923b42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:03:14.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CslyLHI6C/9mBM8miFgNcAF02bYrTwR58iyd6RaDbJ06xseqhbwMS/mIXeG2k+36kICsai54MFYc+PkwPddXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc reg-mux.yaml, the #mux-control-cells should be 1

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 0fc9e6b8b05d..11b9321badc5 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -513,7 +513,7 @@ gpr: iomuxc-gpr@30340000 {
 
 				mux: mux-controller {
 					compatible = "mmio-mux";
-					#mux-control-cells = <0>;
+					#mux-control-cells = <1>;
 					mux-reg-masks = <0x14 0x00000010>;
 				};
 
-- 
2.37.1

