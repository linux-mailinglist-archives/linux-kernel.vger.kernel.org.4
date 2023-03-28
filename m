Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A16CB4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjC1Dcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjC1Dc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:32:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E53595;
        Mon, 27 Mar 2023 20:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv0izM+QKf5F8opFEW961jw8I87tUcCXDNjr/5uODxl3OIlFgVk4yXysY2Vgg6zeKEDmK+2IHlb/nbJ+PGkzA1BJwTjJAQVWdpTxC7kBNUGle3zFxCzh/qfDnh0WsW86XUz8ye82BVzvRq5d/EFSXbW5JA3RlvNxCuNp7oyoAcAaYIZz9pIsQUyFiJMGCVnZaBdajnkY/Wd+hiycmYyZ9raf6aApF1Bde0nG4ZioLqDWs07/qG5atZac9KKcyPqVookjoB0eij5UHKAS0sel0qXVZ0LBdUnCnbNB6emzyy8seBBYIkyDQFHSBwifp3GtAx+WwFI8NfXDgtJhOdNXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YY2E/d0rCtJEzmvCtTibKFm/i7vicOvzf3mfYWnMzJc=;
 b=Uj+0VWFFI64FHEzV7kHDBtk9DxodbXuX3cDpiTz18k2BGaNmG7kLNsgQeBlRx0WWbQtbtmQaTPzgaPFW84b/2K7i7V3ZBtglbzXLxmvm3wq0ZePcNjJsm+yrOiIAU4CbhF0ALoISAUdEMDbqhpeGcLeUkKegGmPtyD+BJjVYKKlz7qhhgYs+bcOSBdgnCbBYXaxzhBujs9rYNwuspEWmquoCT/A+QMaqs7SJZRyiVed3YZMSgG7BmLKp6wJIUxVe85NWXSyiXOgSm9fbJ4P6VqNHD1rS3LIgzLsTIHSA/23hU7ozX2zvhguzA1SZJsJwOcxCoeQeEYq1q85ZB4w2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YY2E/d0rCtJEzmvCtTibKFm/i7vicOvzf3mfYWnMzJc=;
 b=ZTuDsf/dvaqGjAPM76OhbQYd8GjtlzDEQFoFjSG7cuxQRaxAq3KCdIdb/+8Qjv7XZhoTm8Pv7fCE4YerhS8cdTD6WJJgdz6vNUuxKFtzgcD6dEqXEtc9RV9VMVHwAxXSZ0W/+vLFVpONjI5CHFc6TsnsdbxmJylm1fWOqFfH48Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/6] arm64: dts: imx8mm-prt8mm: update pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:40 +0800
Message-Id: <20230328033640.1930104-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
References: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: c652e064-475c-456a-07e6-08db2f3cfcb4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rI1QXnQdVZ2QwF1Mb3G//Ws7vCjQOaxOfGKqtZn5Gf01kHSzh/vrgttC2I+nuK4IwGcfghYX0TMxkjbshn14HEvZvdtLOB8/j7l0Q0QlsHFxejvwdfPFm9b5EN21z/qfluyh8BBjbpMK3fYdWE4h3Fih2M5754bSmioPxLhEG2t4gKLQnn7+VNFRHdyKw5kHO3104UjDsE2uEBDaMQyGP5Nen/MErVE71tKtYkx6P1TskuMAemoMPfWpM5ga5gHp/KHly5vQgS1PeDFztNWRyzDQ+//nvbAyAP2qHUXXSY3FDc8VDPpnxEa90pOOVbGrBO/YxIYWCSSoJFbLc5H2rbu6PInyj4a4VRxkqkcyIx0SNB8msqMQ566JI8aqLXgDRKkDKl/WfHj0APWgGb26kApYQ2lHl8M/2SrM7P44zqv6vBYHwBFUrgi1u4+YGxWwTF2ERbKyJIBcFQjzWPv022U51fZIXtbxfID6eKUP2oPt60G9euVx1P50c+3UPIunP/sr2ONPHe0COFEWf0mRIVu1sO7H3Z+WifwfTxq80SFjk/E3PGoIkNs+2jeGlZSkrNeuhtY7MRTULei0QP16aLlbPH+UIFCBvAwheQFUdmKZQkJJnWGbCp65UdQUSRltc9ZfZal3Xq1oyp7N/ya5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0yCsDsa5XBgXWi//tJPd62V9bOfejyNPe5z+b7TRQxGGzA2PfvB5yX3fN3q?=
 =?us-ascii?Q?26YlpAKbOfewjBR4L8op+WVSYqBXeod93n+UZyhYFD/0jTQU052yturgqCgl?=
 =?us-ascii?Q?b3dEHnKKhj+7wM/zJQC5sKaadZb7byr48FZRx5pv3ypqtYFqOMP/XA6MvIXk?=
 =?us-ascii?Q?k0BtxYqf6Mb4twwV7IiOyoctvpPV19sGWexQKCF0Yfh2lLdQCdpA/8yL5yPW?=
 =?us-ascii?Q?kt+g3H+BDUIdxY/2gASYMs9sxIosYLBx3l4cau38xlEnThmFlr59lcI6vmn4?=
 =?us-ascii?Q?Yt35oKC8fnt8IjwfeDAnCsb0B0/BA1CHZWYhRqje3LwpQXXL0ucmDxJYzlbH?=
 =?us-ascii?Q?q4D721hiUsRXQncE9uhkMIo9oS8NBD4TP1BZ7xv0xRf6jzvJ3QaCbcYP5cTu?=
 =?us-ascii?Q?3iwRza/OrONGA4oZ3KOABEkwUklTv3i5sZmHlJ8B8YhRfGuHhjrNdcEzomlA?=
 =?us-ascii?Q?A/01bxG6z+T1B3aWENEG0Ypj73FN8F7qUEqxCPrPkvGXykTmQilR/iodm0DT?=
 =?us-ascii?Q?3V/U58rDyA52GNLbrefjjq0bGPzvqC3SJCYMqYyG94yXEH9swy1mVM/RMUs5?=
 =?us-ascii?Q?rIMmLXsf8QXHo8HEojfVXGiWt9YSVlxoOOJyVHfvETlJyxQo2NzwtmhvS4+n?=
 =?us-ascii?Q?X7JT+yWbKRMqBgAXa4HVp9ZVQKpDSw0qqjXS81UwYWUPTdnEFdkr9evIeJtg?=
 =?us-ascii?Q?O4hFowThOjt9ZYGKsF8S9fIf5xTLZWuq0oGBT52OBnSiN0e26tyEuVXZKLgi?=
 =?us-ascii?Q?mH7QU/TSSUczO7wuLMR4+An6hPU/4D91DcY5JJJaE3Fim9DFelQyGLvkJ78o?=
 =?us-ascii?Q?ePMa4W7RdY/BY/VJwhT0cGpXELyDuiaVGHxx3iZ7evLQ9ehKPdxRlubKranT?=
 =?us-ascii?Q?xnk9owtBZTZpsbtqhmug1C5JZyf2acJfrIJvYI6m5GfsTL6RdXJ6LGSsQio1?=
 =?us-ascii?Q?mK7s50OZnXt817ix1SlOzCOsXMfHMrrVvcFo5d+NYDPI3MDNVshbKmXr4LLU?=
 =?us-ascii?Q?AllpSux1kagBJ3K5eazLS4G0fIhvlieC4R9q/+rM+NVvN3mD1q0MzD3rtDo2?=
 =?us-ascii?Q?pj4j29ikzob5lKwyS1Os14WMjIoqU0CYoyJ/5OJMCYaUfoiFgAuNGrNfTGEk?=
 =?us-ascii?Q?6+W0AaXPppu7PTSMRwEzZb49m4vOSljKPQ/NuMoEGmXk42/aBUd97DR4Sujt?=
 =?us-ascii?Q?YFSffsOXPwiKWIDnOqlWCLgOyhIsOmMmHXh4rb/5eQULqn+4rOeWUKKD72VQ?=
 =?us-ascii?Q?fPQ3vvclnmbMloAfNMjAIgN3rga9TWZpRScivT+mfoGUhxXlJb1ibqqvKCHF?=
 =?us-ascii?Q?8BNUeVaRfDujrbwBroA6gGHM+I246ZFGy+oxvKDSA2J7rxFX+7/E0IVS23Ws?=
 =?us-ascii?Q?Vtm3bvEeFxKNl1egaqt0hVKeGia/ux1C+7CQDLcALmn6UWGixeUMoflqKSWC?=
 =?us-ascii?Q?KaiKXG4OzKhBHO0IzrDHds6gIOoBPQ1j7u70O5AEryzqbEpiADl5fVhwj8Zv?=
 =?us-ascii?Q?gPTecrw7sSXnJUK5WMnlrAHwdXoeQOAPAMKaPO6ff7LeqgHnpYXkBXQYYopL?=
 =?us-ascii?Q?9xFiaWWOsfone3O9UxIc93iEtoSa6yEQCPpVSH46?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c652e064-475c-456a-07e6-08db2f3cfcb4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:59.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpmgqpnF66scnZkSE9+b+bSoUudTmO5MWOsbBFhv09JCGkMclQXf0oJ3UXH4p8MBAPA1aKhxgR1DsjWl4eE/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dtschema requires 'grp' in the end, so update the name

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
index 9fbbbb556c0b..1eb1fe7ebde8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
@@ -264,7 +264,7 @@ MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
 		>;
 	};
 
-	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x194
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
@@ -280,7 +280,7 @@ MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
 		>;
 	};
 
-	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x196
 			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
-- 
2.37.1

