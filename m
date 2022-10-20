Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70F605C03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiJTKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJTKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:16:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3C1757B3;
        Thu, 20 Oct 2022 03:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0i6MJUbS2SP3vCKC7+aVuwtJL8sFl9TRD2dBLP+Yy5JxaOM2iNfpY6v+DZZMojbdmbn9Lk4vProaF/ZJi0DKqfo30BuCEeImrd7Y6Zt4bgNPTxAAwr1F37txZXwXJxgTUylGgPJ5+fCB+KmW7b+gs4XKdg8PRENhGp3bHGznMPMnAZKrzswGc4xSfOW+mZELYKki/7wkpUVE1PxQh0Ie12W3U2nHnjRMY+iGYxEfyspgoftmW+yDWLZf9o1UQh754xpIOLSGPQ8awqGXZZpxHfwWoYmzYjO6SKAAFLYleIphIE0uUtLWqVH5Z24qGZvcnakGG38L4Y8mjaAB0lxgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDiE882um76EXYA90pd2bddkHoXs+d3D8q5xiRQTmsE=;
 b=iUZkeUEmtumJzXDQIHW16ZNaI4qCZ+IOZU6PVGbfHg4iSiTvEMko+3yTBX0dU/i/47AvK3OnbT9rZictnwZOK+bh2SIKstpusgi4yO/M+bK4eQwQq6xOdrt3I0/iogb4CSkf2+pqty23us6K/FcxCD1FKYbGla/5mFq6xJVpHPD48F9RnatjxNVIXmS7Il4FVbYi6Ea2M4ryj2MwcG2WvT+WsSUb5srZmPu3k9HCRiSpdr1bYFaUvbCJHLv12NyyWhZX4y91WNU41n9NNhclFKSgOWqtG1McGBAgTzAu8pZEPGCediIKk1iZH9z601YePh6vemZC0eNg94o3xk2T4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDiE882um76EXYA90pd2bddkHoXs+d3D8q5xiRQTmsE=;
 b=jug6YKlABg+dtaa1bWZEgeJTm4d5GKz21YQqrctXjgEcOufFsignoUhu6nTJi20ObwBPPyCEInatesrWLHFij3nO+K992hAA+nYhPfjKkKvELfp+pEMYUpRkZrqA1uQQ7ojLu3iunEx/SOc9uaYUb7YC1k+cgxmYhuZq5wL5lIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 10:15:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:15:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 4/7] arm64: dts: imx93: add MU clock for mailbox
Date:   Thu, 20 Oct 2022 18:16:59 +0800
Message-Id: <20221020101702.1867188-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fcab10-e874-4c33-aa15-08dab28413a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9BQOOiJ57wmcNXE5dPum9aKKoYfFdlfdt+9aFEEyEC43T8BOr46h0ealH6g1P1tueUafQGQdEgdUPxrxmqaazllorWBLDR8yVUwEUr0+RLrz1E7xc483YaZXLDmSS1UqyUqKiSnw8P2AZEZx3ryc3b07ISCNW6t7U9tva13pfry8U+yxdWzk7JxGgkg1BtPwLpRVea4+FBGI87lyzFFrW7o1nbczV84CQ/3dPMdnKir1fGNjcMf4kwR5mzbmFhrI8r9Utg9bjPF3aVqvyv1evBb2mjPCWqpOlYn892aKF44Bk37cf/sZ8c+wNotZfTpZ+wW+qXDoRz9mSUxIEXRidYWMgtBfo2oQM3Hwd6Ce8epTaVE6CFDG/BIwCJal8nVNARIqwZ7Y00m7KTM7TVxsyO6UHL5as9NI2Terhl/Qty3BbxbwKqM+yMBktbY+HPsT0LFedWY7jQ9KmkH5lnWTWBwlpqrAYwdPGWVdz2GPr77zGTrOrjyPtqPbDLNgWnrPfzNap4aq7tF0AdGqaWL6tVwVicA63bSIPY8s+ipmNAe3MFtovqVkdDdUU/pyZZOsqRNc7P3potKMsoeqR9jBl/7RWX94U/viSqzySlzvF35gEWn1LHS3Ty7OWMN22RHif9zipFcgJCAZgYAtt+0qsnStKiVx+CdPAApztdXAKAZRDHqWAP7dQjbJPTb3BfE2y24ozHgXPy/dwCJmNnm5eBe+MkVkOKAnnT7R40TDtCGdrkHKuG/B0AuJoOz/yD50l/dfBJAAavQoq2OPDmbKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(83380400001)(2616005)(186003)(26005)(15650500001)(86362001)(38350700002)(54906003)(38100700002)(5660300002)(1076003)(4326008)(66556008)(8936002)(41300700001)(316002)(52116002)(6506007)(6512007)(478600001)(6486002)(66946007)(66476007)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwFRyk7xopyFoH/MKGhfazf/V8P//hrDlL6FSR/ils6beVsrX2UgTbyf6Y6z?=
 =?us-ascii?Q?L3LJNNLdZw3Hm20dMTIOuN8WqIUZE6dYm5BLoGQFg1LjPuMoE16wGRJ1a+1j?=
 =?us-ascii?Q?hULyA3M2P9gj6UbpiKqAvYVgZAlRqidfh9JvUXnZulQrunv7fgzKPvVQFf1k?=
 =?us-ascii?Q?L33DP+akUd0u38XmTKW53d5w1r4PQs1kQTVUtD1jJ4mNK4WCRsan4rQdGr8E?=
 =?us-ascii?Q?2pGdGZFdmBYUwO73OCWjS+wxKRbxv9Sv91muEozwXo/84ZcB7QCLie0KjOyp?=
 =?us-ascii?Q?itY3MZ88jJ+fN1ilEjJqJAzjP/xytrjGRp9CA36q6K5uCYgDUcOmt0mEkfLH?=
 =?us-ascii?Q?DUcgZR0SAhCx9usOL4bEoyLUYDemzeNtkbwYowFtOUCWhM2XdnmotN2MZ0Nw?=
 =?us-ascii?Q?tFROU9QeR7drZiCkMBEYnZtZK8dS6YwXMW4Cmo+dCfBlUovKlfeUYod6pTxA?=
 =?us-ascii?Q?HlLPXQvLuijWnVOdbrDKNBiauOOP5Mr4obkrqInJ7xDzIQnecsMTae4OekqI?=
 =?us-ascii?Q?NW+zPP8BsK4f6Zatf3XBm3i0zsF+GKJ52Vgj8nuzBV0Lk3lPpu7CPMupyvaO?=
 =?us-ascii?Q?f6UjrJIIbLH2J81cxfcf0nzqhbIlcA57I2irXK/9mG0Io5jzU3BDdbiWAgQo?=
 =?us-ascii?Q?ENI6cJhz2CqhJ655p/hBd9L23Hii6SrsU0V+iQVAverhdJfvE4cIhc+jKQ2d?=
 =?us-ascii?Q?UDsLwLKhSOP+8LaKajJlwbPniMItB+uZFXYsBJH20StCasv2KToBaWGzx3UW?=
 =?us-ascii?Q?b29/FzWTnUHdGKisbTvTLNllTBU0+MJl2WFmKiub56/WX345DF26eOa+QGel?=
 =?us-ascii?Q?IqXql4XTsmCOJS6nCP4has4WY4jVCLk2eXXPDe8vOhanKlyreMd/eoOzIAVO?=
 =?us-ascii?Q?6eZHkHS/+nofsMsY4zJl41c0CFKx3PLRHaTc4AQCa2wp9/bBScvbPOfHWfHj?=
 =?us-ascii?Q?JGnibcm5TkjRji6rJohYJlgSH/9jSYP7DaFdOZvC9rtMxZoD+0BTUF+QBrIF?=
 =?us-ascii?Q?Ofy8J8WzU2SJafY2RNRYsnmhw5JfGpV9OnWFhUrSBx2q64ftJNhuLy2AuH1f?=
 =?us-ascii?Q?21nJxaOiG6uHnanif3pKSvUQ1jPkvvFAJuqdMm9yNXi8HggOJsvgV9zMp1ui?=
 =?us-ascii?Q?xK8FLp/h1wVf0y0ivKAuOjl0eBhZ+PbuTM/fbTaozhXRC+wTnjHGrubD+FMt?=
 =?us-ascii?Q?Q979M6QXOXKxAEp25HM05jWU1p0Q9x517TIA83KKMo77agnhV3akZj2Etugm?=
 =?us-ascii?Q?wQ15tDlrKsigAyT35Agi7Jo44l06tDXu+tAlAxi2pBmohKFolgNz1+akOrGz?=
 =?us-ascii?Q?Gog/CP0giKRC1C0nqc5drohDxzZiYTGLiUL2TEd9sP78oJV1T15CCCCJ5YNb?=
 =?us-ascii?Q?QdH1VkNmAPKqpLgJkCBOQylUNpmVwcyfjojwV4+9fEKjnzc1QWTqxs2kfmsD?=
 =?us-ascii?Q?TY3bb29EPzPLphmfL044OP/tMcDZm6SVX7/TsEbJ2hReMfH/W2WlNxX93KVh?=
 =?us-ascii?Q?Y55483A+MVUL6hjD2nC83Zh/TVmaAPl+rR91Vvub4UsDrDwCeSUTxQZfwcWQ?=
 =?us-ascii?Q?zp/QLYqkAsU4U4+7bbrAWo/B4Th6l5WcGGlLxkw7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fcab10-e874-4c33-aa15-08dab28413a9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:56.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTHrhVfhtU1xTD4rIlwKPkLyhwn6WRJ4+VvcPRjtMA7pCGSqqa94/nsbDY8wY3q1rk9SoVAZCmrVv7gDAOaU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add MU clock for mailbox usage

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 2d983e6ee734..c886ad0f6499 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -135,6 +135,7 @@ mu1: mailbox@44230000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x44230000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
 				#mbox-cells = <2>;
 				status = "disabled";
 			};
@@ -271,6 +272,7 @@ mu2: mailbox@42440000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x42440000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
 				#mbox-cells = <2>;
 				status = "disabled";
 			};
-- 
2.37.1

