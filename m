Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23E8654B62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiLWC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiLWCzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:55:54 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702E1A053;
        Thu, 22 Dec 2022 18:55:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0g69w/S5+t8pswpc57ztg3EgKROPPwI80t05qr0FvTwaHkeX7Z4oGyGflduKwpvhKz2UK7UXPWk1BMN86MmIGllXsZtJI7NF1NLQ1UwC+aekJCWqfEeo5felOJjsoq7o/KXxa9NWiaL1koWtDNrEl3x2igXSKwgP4Wnk/Mq2M9NyHCIBDj8w3c38nGKEUrdDEMvCvi99N87fLrnTJnRql3RsDflZwPjOkTFqgwIYorhiMFTY2qBvSoqYFmzAy7hYnVdAcJxk6oQmdRLxMXagYU1U4CSgXQreTo62snyoIwpglxh/Cg+jQlivWZfG85hkyzC+klwR2PIB9BeK4FRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifu1KEV0nNC8SXB5V8Dc9qUOc4bn9fWXTVAhpwmhMgI=;
 b=RmKE1JDic/7CbhQXubWRJ8X1cJvl2EWWOwMcx3cA0vo4oX5LGgRHwLxiytD516/STbC+PO5jTUkOPwQG9ECGaBgwFlWqa4omUqM2CXHSpnU5RXXirBpd+lEhLbLUKk38LubGiMldjDjNnpdA+Ccjhf0/A0YEsgCUlWGM7EInlETIVq2chfPLVUX5O77CAjBIXfIWasE9v8U9XzWjr4KHOu91y/uHY8lmBBa1jYTG0FB+OSLikDt8RmjKfvRjkBAuWB0Q5NEEfhiEg5l9epl/XbWMyaXSp9YUxH5JzWK5b2/wtURZ9bcnt2WUMWSR8k19V2X7mDzYqc5+x6qWL3O6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifu1KEV0nNC8SXB5V8Dc9qUOc4bn9fWXTVAhpwmhMgI=;
 b=KynRawrktUhDuGPF4vcbpP6fs1kplIBO+XQr5mWWToXSUfwz9vj3sGL6wO3MBq+Aey7NFexQkVfQ3kvINZTkciG655Pz5ySIUuvP8sy1TMEI9LVSScS060+76APCT4IHSH9gA2sG3Tmga2YCzj3pSYARAwEnsB3v4eXnsCtUpwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:55:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:55:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] arm64: dts: imx8mq: correct iomuxc-gpr compatible
Date:   Fri, 23 Dec 2022 10:57:00 +0800
Message-Id: <20221223025703.15784-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223025703.15784-1-peng.fan@oss.nxp.com>
References: <20221223025703.15784-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: a237e16d-8b53-4157-0c86-08dae491332c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN0+uGY/RP/r1crVZ3WoTXu47dYlOQ/FU0cvstWqykIAC813Rm9WGLTdyBl1pDtNwYIZC3QMtYkpqGKlhl+/1h1SjZdNmCnnc47tlfOmJ3vfWCoVf59HdCkRQ5mfR9036o3BZCitjkhN9E8kN1wtsBY+ZBfE6Yig5JN/CioIxeDA6MuwIRNadLqgtTLbV+I+wQE7s2xAuUIlycT6fMGhxsE/d0QzjVvrA9rUgajjKZwxvbg7Cxqudw7/mso6cQVZGuL35+ohoA5TOYe8XfvmxNfmgDCcoSIi2/njHcN07usNa7/bi0nJST5LBZvQYuZ+00M21Z8ymeGG6ce1ORBlbGUmaxy6mK9QAZr4NJ1FXUod8whqM95EbB0le57o1YMLwodi31N/G5lEWOw39X40UXYsNp3CMHdK/+LEdKM4oXuh13Axwn04XheMlht8Tw6o6Q2JuF8rvq9hJoFnHdJ3ZqmG+CHu6KmplQroEOte4eY0+jngKp/C0smc//RRvVEiSqOJIbjInni1QD44tj8g5L1dlF52CJJJr388+/6Is+ODxBaRVjk4kOnZacTM+kZgZHpW1RwLStzAg7tYd83e6uRmnhYObB3zfa8wYA68b4OQ9Qzmxo31yJvx2I6RX8x67o4XeS1Si1j55jl6CZL/hCiABv8jpAK2rSI0jqYq+Rs8JQthjrV4yN83Ly4Z9i0Xo4xnoPzaTPnLAnbrebOghHUiOahTdWvQWPM2vvV0iGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gNuSfLkaRjYjHj4V5wZaWUXNyZspZ/vBinT+FT3J+/9CcRVNNIueD0JKgHg?=
 =?us-ascii?Q?K0peyOC/YKbpaC4nG0qBEyWZyeme9c/jJWz0bIxnDtRBYaZQY3v/9bwT4onx?=
 =?us-ascii?Q?Vep+IiN7bR4woEoeDT/UIopqItoEMUNBm6y6brkl+bkvEb1mlwOm2p49oUVJ?=
 =?us-ascii?Q?cW0AbgNBN8SXh+il9QWJxq1R4tTjokicVHnmbZ4v6krOOEt420RXmB0re50y?=
 =?us-ascii?Q?2FPvi7ENUeDYSckJbH16lLeJLc1iHMxtEP1bBgMv3f/TlXUflUyHJDaQEdAa?=
 =?us-ascii?Q?yrMRC4qyA1h5+pGjDqta3YDGFirR24upTiQ/nhnRGdjvF1IhQjwYFKGtw7hO?=
 =?us-ascii?Q?SejDIpM49ucmwuTdaorMed8pPMv087r/JFfdK91XjPlJ0G5X/D35oZHdm+w9?=
 =?us-ascii?Q?mlVerjm4Ox6ieKKvEu3258mE9vDxgCrJto7mtmEzLjZS1dF6o7Yg6sYV31/D?=
 =?us-ascii?Q?/i8QZbS+YY1tfqqLLWAQ2FKXn6bkWi9Tdl9b9Palf6/w4uOB1xldBOuJhvB/?=
 =?us-ascii?Q?5OSqTW9LBgP1YHerMkw4+T+c93HhG8Wgjd+LzqbeNE9GCvx/3X9bVUAC25V3?=
 =?us-ascii?Q?VkzZjwHmRtPDlZJZ/4REelfpdlKxA52yNZmmcFX4m5z5B2U28yPr/LU2wGFQ?=
 =?us-ascii?Q?iUlZFICO638m3LCYplvlmkXeinzi4SrqZR08H4KKMhm2FiZTpC0M+Qg/s0vW?=
 =?us-ascii?Q?Gl0nWjUioqPFAsG0ZCBpz/Yc3KcG2HjXzROFWr3ZrQp9QxuwhF/cKUxqSllS?=
 =?us-ascii?Q?w9q0J3Q7lja+T+7JHTUT4c6vujIewqtGDQDmaju8BJisZ+njCNTC16izFM58?=
 =?us-ascii?Q?K7CxBiu6ph1yIJ52OK+/Rym4KsNKTYHkuTKIRbIjEaOgUffiMI7CKt3y9sgE?=
 =?us-ascii?Q?vxDmNKbE0Ku9cGvogjZYF1jYyyWPzrsIGrivUADbPZRiGBMJgrCLFNqVlO5M?=
 =?us-ascii?Q?8ekBFNwDNJg4pqck0SWRWbPVik5dMgGH83qnkHMTpNbqaGBM3TeI9xZlwmTy?=
 =?us-ascii?Q?CKc9mZmEZFP/VzAmcNOdFQ26cxyCgpaea2Owu7B8/EqDzrSwxsNYC0+jzTqY?=
 =?us-ascii?Q?03f4vJEqJ0kpPOABQ3M+YDbkdpks7vH3KEkQYZr0tN3lHczttNs6tep4AzM9?=
 =?us-ascii?Q?MgOEU9vPNZVYlcAFvLigPvkNDSNzepCb+HgckKGLmm8PwrBlXYPkJKCDkgOI?=
 =?us-ascii?Q?bNNYYpCW2DVh/kkXyiOLQUJYUTb7wN7ff6yxpRdgjyqlIVTFO3LbhBtxabrI?=
 =?us-ascii?Q?iU00EKmeLPB2H+ogCuFbuZE6dItnJEEATMITCcKTzpdv4iE7HeoktPCBzPxX?=
 =?us-ascii?Q?GKnxIzjaiX8dxPROFKWtn64yENizH9Gvz/iy3xsmsNzH2h+Tl/v1sKZIkJ//?=
 =?us-ascii?Q?Xd9kG2Nh5jpyVhNyxueGMteS2OgfNQQCAKf2beZz/aTxqyCEcnrKI2jPFMdV?=
 =?us-ascii?Q?7o6Crt0UbPRziiBdI4VNCCwRwh7F4QuBroiu4aodkCDs1R7kBr7n2HGpxyNb?=
 =?us-ascii?Q?lPLrCNpDTub6fEy/lg0y6uI4QmnLcwtqY6F+WWwI8Pk4pDsoEG4AZu8VUv13?=
 =?us-ascii?Q?/QSTKhwuik5oRZxBJ5yxnWIizXFo+pcfmqbIckxI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a237e16d-8b53-4157-0c86-08dae491332c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:55:50.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wc7myhzpw6P25sx/cRtp4OqczJYMh4XdM/qdfq/JaG5A7aytd0nRSJCJUU7Sh1DCMVMZGL3sodVVCtrr11BDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The IOMUX Controller General purpose register group are unique almost
per SoC, i.MX8MQ is not compatible with i.MX6Q. So correct it.
Also update name with syscon.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 7ce99c084e54..6971c47d11fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -575,8 +575,7 @@ iomuxc: pinctrl@30330000 {
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr",
-					     "syscon", "simple-mfd";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
 				reg = <0x30340000 0x10000>;
 
 				mux: mux-controller {
-- 
2.37.1

