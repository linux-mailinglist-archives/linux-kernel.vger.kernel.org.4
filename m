Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DF6CB4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjC1Dbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1Dbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:31:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E309270F;
        Mon, 27 Mar 2023 20:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkWBjyEB9rjcrxY7JCE6ElRVFLO9lD9daIoWAABEHVr1pcnq5mRxh0EownnNa0wwvmFLsHAwMZERBEwvkf6L5KI2kcuVZM5xcfYy4F7FvRewLNDHAD5bFDXss33zmGP6zPWppOUb/Gj92PdhXNTVvDI5yKrQMzbGObCROaVOtHPelIMb7P6315iDyRnoLQ+wPAlzrYNvY5qvNeScf8A/I3USK831+HqcBCIlc9AljG9apfFWlooRptVBeYcHYGhD7KztzUWlO4bz+HRXPiqr6Y9/S/DQuXc5TLwfMaFZc2PrQ65aU93vfQ9HkfaX/wUIYenwzCt+363juhMFLhIEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iKA58i2D54Rc45QCv8VT+zp2HMT9BxA3VPECTOwWjI=;
 b=fSMaUkogkyYfpSd6gB8h5vHqmeUR4K4v06RSzPQWBb9GoTrIRE6/Mu9OCWkXGIwh28vLyUMYbKqVmDtrZRT7Ho5+Et4CsOS0/srWJKY4Fuei/zaQLYQER5lJdDCThvKjUeTBcp2gw9FphjE8J1CpFg1KfBpiv/dwZnl8otmAiGGyga3dcOZXOXq+UkgVntT8wJkpJJMu85kFeW6G650kGsRX7wRkENzVvmIS2owcmCrW0rqtSAepVnre283c+3JubzIDBlBfQZPh0JuU3BlkYRD5AQdfb5caF6wGRGox6mszAzTvD5R9UoF8yDJ35z1aIm2FRjpVAG1SgEEtWA1Jbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iKA58i2D54Rc45QCv8VT+zp2HMT9BxA3VPECTOwWjI=;
 b=fWSRDkgQEyQB32kRRu8FO039s4iaYMREQ1yIbUBUXQuSWADhz1EUqEwev2k6MIFk7rWsHSMnk7DWuuflDXusS52RMj3EUzCDK9I02esKifsUPWsGdDsXX+Y/uBTii6ICZTNA7CimEk1uoaEp9p6IpVzfY970s3R0CDlF7nvO9xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/6] arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:35 +0800
Message-Id: <20230328033640.1930104-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a40f3ff-8ccb-4c95-3c32-08db2f3cf1bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYxpKN5x1KBKFtShIRKHlIcVbSCa9robf6AKOuwQmmcchSITNTCOll3seonau0EXZ1yRxbhPNymSYVKy8XTZ5FASETtsEGbKL/yuvSTqG73WTe7hMP+jO/eykj1NCfaTUSgJCrbVwaWfvL9Jk0DoEhXCGQksHLwpN/5mOWFFpKaW5pVlpfYID4RLQqUv4e5qkj0CBfvgtjVq3LLKN7Dwap7AKujksLPtPKBav7P/W1PFdletgGreymeQgVQLY24Z0cswG3B7Jx9/TmN1XxRoywTfbBneTjaAUYzoc0tCqpNvm239AFB3Gt20BlaNlMdEvvDbVN2Fvtxe9/IQlzZ1pM8yP/GBFEscd2UztwdOgzC8U3ZFs7wpQGN6TzlyyyDTRF7nCU5R3rDHVr9CUCoZAvOmcKnjV7V9deLogf7emzTXokTc/ivzvDE8iXOJYgQDkVWXGFS9HNArdJfCG/kXBJzvWP1sgYMRh2Qr+uWRx2WX4aV83xc0bF2AzrVbcld4u6vpLKHCh5zushZoJt9E1rnBwmNSZ5dyfzWnHxpcMprzprqoCDfgT8gbMmbO6AMkjFLUolz22vB05LmFDuMZQBeRyxkzgjHGmOCinufZQ5zfkWL5vCIhjhhOxWTLA8i7UnJSUThfgLU44XG9nL/K6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(4744005)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPqyGq52fY0GIX2hdH1Yapwneoiti5yA36BbqDMM400JmPhCns8l/L8qCjiE?=
 =?us-ascii?Q?eHyl0E8OhhRBQujHPWsLmSmQKhSJ2WCjqII5bc5tVbgYZeIDNiOn14AO+tkc?=
 =?us-ascii?Q?vMoETS4J294Wr0Jy77tHph04saMWH12L9hXnNDHwogJ727e3ObJmuymELLkl?=
 =?us-ascii?Q?13plSes7J5ysIHTCmQbURskN7kjGDeRET0b9IMEtg6GzfuJeXhwSlSRhaWra?=
 =?us-ascii?Q?XKOid7f05w0mC1P4E844cdQDRICqGWCIzMjjoXDsCQ6ske0ttks9eZ1YMb80?=
 =?us-ascii?Q?zV8XEMKgnan5cUJG/Jvwb2HuBwXXuvUwtmeEjhyTdwB7gKSsZgsiDsdO6qHA?=
 =?us-ascii?Q?qioprbAl+LA9ZTaoChNNMZVV/ZdIMBW8l1egyAHqNx2iaNDtw5Ut7APBsZ+M?=
 =?us-ascii?Q?nt8+AWzlaB12cgVkc8wHBMDiVPtXXHv+ele85dkP+EDyGBhHzOvTH9c9Stcb?=
 =?us-ascii?Q?kcergj6z2mTzwqY85ndXLuvNP0boa1iRza1+RZ22ej0ZROiOEEEDgGLfYoEd?=
 =?us-ascii?Q?Za+g+Qn1avhHHEwi00sPiaDDoth4LQ3Wd71RSchNdTT54SMoZ1ZmBgcjATzv?=
 =?us-ascii?Q?y5WjKCa79b0Bxi5VO3yXLEIcQIF+ERSVnxyGSpGeVnDWv75i+ep+e/9X/r3n?=
 =?us-ascii?Q?iL1VA/+25v/0hZPTyhnxhfDMQscggB1hTKIGMqIpLw5LRlXDkVSrp5skcMot?=
 =?us-ascii?Q?GgCPVAbloAbTcnetz1UlbXWYYHiqlXOw9C9ZETNpN66HCypaDVMWKRfnUFbj?=
 =?us-ascii?Q?5tJtQUNrLz2on7eiYXqqlaP20IlAkYoarliBDvRy50ECLajPZMEKW1NtMEXG?=
 =?us-ascii?Q?9MpJ4YzbeCDfeG8N0VCjW/iEbgThv4GHj7TWVbgcwP5/N8hn7+iqSXSGijDl?=
 =?us-ascii?Q?xTfcv4VKEbA01tEcPpNzu8I7q6Cs1cQfRbmDmExeLq3pOU2iCu27X4KuTYgt?=
 =?us-ascii?Q?F0V7S3HRXUGf7hC5mbMf8D5PacKp+T/f0X7vWPoquqhmAtEQpd0yIvpL+9/Q?=
 =?us-ascii?Q?V64vwA8G7l+t3ewxaUAyMrPvcs1v6lpguc1WRsrj2b0aR8J6c+tjdsI00AoP?=
 =?us-ascii?Q?12PU1TJh1ZCVMbAjEQsMCu8mlmKsmClDrehn96NEd0+Iz4SmXzylQPu4m40f?=
 =?us-ascii?Q?i43iqBlCX/nB/X3jalaPBaqSpV1jfRWtRi/5PuoIkANiH28dSKX6lN5oc0OS?=
 =?us-ascii?Q?pI3M62gAwtqES3ynVUOK7WQduhyZIRw+0iJqYNUoJ1XvbsERXMyiud691FTo?=
 =?us-ascii?Q?WfLfheOgghfd1lJv1detZGJfoeH91Zm9OIwFexUwonNrPolyND3ywhn+FRYQ?=
 =?us-ascii?Q?DOYk9NW6mvS0hJI0ZPfHUeTLW7a5DAzO/0qygjiR7p1d7A1QQvL6Rfl7bbr7?=
 =?us-ascii?Q?gTgJL5VpbIgzOH9jkxEgvSFUdeLrfphoG6c+oHWcOlKaChcBpvuM5+pZ7zH6?=
 =?us-ascii?Q?IXpULlX8lejA3CwXhphsPn3M86UPoHk09CeUG42zv9yS/ybaZmk2qF5Zhhrg?=
 =?us-ascii?Q?Malije0otYxOnl9VALL6xa1s+nfAu0kUtvSvNiM4uHUbF1LLSWBEqpvG+tgV?=
 =?us-ascii?Q?MKEN5RbqZ2FCvtYQ/D5SV42PMsuij96w7kjD4O9/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a40f3ff-8ccb-4c95-3c32-08db2f3cf1bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:40.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH9JJwdvI86/Wtjvr94G7wGLYaDyiFTHCAYGLn9hS67RkZAzcyvBWuxf4VJxosdlZ5k8by3Z9e/QTULDgTOkxQ==
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

The dtschema requires 'grp' in the end, so update the name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 8fef980c4ab2..1443857bfa5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -389,7 +389,7 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2grp-gpio {
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x1c3
 			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x1c3
@@ -403,7 +403,7 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
-	pinctrl_i2c3_gpio: i2c3grp-gpio {
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x1c3
 			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
-- 
2.37.1

