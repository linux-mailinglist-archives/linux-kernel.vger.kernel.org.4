Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B16C664C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCWLPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCWLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:15:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784B2DE65
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtaXSeHptZtFe3NkcREbDc52PEEULN6TAa1/0rLj0Qsq/KBfLi1VGUIwK6JiQRZjrnC+rdbSiSQDS6hH0JY/3iLDle7JpZFhjIGBMHCxXJPwNqQDrCBWUpcdkDGlz92zGpzovzogm0gVeZRXMnT6qBHZ/cIEXTuwM2GUIu5bikG/S2RVMcBgQ7YukBbayKeib5hyRuZnvjBcho4B/4eUqeJ6Ea7lnxN8SSNRWxSFpLNOkQO0WuF539l/8S6TMbpkpR3LlAiusMnGdYQNgpWa/c6tkv7ePX9uNQ5JcZNxKvHo5SOC1Im5SVzNpeWS/6Mwd/v6OSe3FJ0rMt/cckOzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VERnEcrNZzX7250zMZl8ZwSmHC2TsmeKWodyAOm7jU8=;
 b=V7w9es1GWvQVGoe0rqrbIgluOhV/xgRT1yyqonXGYKXncEQ+pCyOUgKrd8H1HNnGt/0pVGt3UNB5vgSrgCD4fGbea5olhkeW3Wr4OwIWhuQmOGGqlPUDJvewCGr3D8BPc6W1l295KpcgmLYjsndgurTn2qoGAIT0NtSLjKOJPdDS2IcXM9T+b78BhoMP5DLyhuYihLKBrswJ34RarJjYG6TsRyms1sTZ5/OFsLeN/5bn91ULo3Qyw1B2ye63cU9rBNnQIMapOPJRr3FhbHgqfb2dP9rtVJQKuzDxAn5iV2XFez3A2NxB8rPB+1AyzgKAdpCERR6SnfQOAEJPRUmLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VERnEcrNZzX7250zMZl8ZwSmHC2TsmeKWodyAOm7jU8=;
 b=LpT1SdHGRLY4pMAOlwGOmwptXT8cKBXm+jvsLarVc6JKxpxtXrlE/X9eLLTt3aWoxdnqB8XPSe+BGTfeP2wlq8oiZLkz90iFi4auJ3L3oaXRFlnnnrY7WFeWI2D5WSElHqSZx3B7eZ0m9b4kd8tGCikN2vGJ8p7xH2HO2x/pwn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:14:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:14:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8dxl: drop clocks from scu clock controller
Date:   Thu, 23 Mar 2023 19:19:51 +0800
Message-Id: <20230323111951.102620-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 983261cb-393d-41c0-8707-08db2b8fcf37
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wG03vpdK/Nf1EldznU7kvMiyUozihhPGrTg+FXDhPiXdmIFAexSuQKX6xejLD17BM0OMKf9m3Wd/NbmT6pPqrjJu5NqDwDbehTIjNzIB9RXWGDQH1NBHwWvZP2tuu2ryh0+lj69fXSRdX9XmEhubpBKEGqpZJ0cOVIqIn2ihbpvcNBFdz5RI9PZaodm0CWAzGqbKfaE/+Gi7XAzt0RvLTwLb11KYjQ0/6Rn3CvosXFnPKjoQ/SwqH5n3HViTkBVEqPxGUZs7JgvK3MCDmeCJMPDbikKJMOqPGYt9BlbFrNbZtU1wi/bCMJzezmldW8bKLZdCRt9crZ5I3tMB0f2xQIkOAgp1akwhIIHB013w5mz0Nzk8ITpz5wW/r5ep0XVIXV8yUXLZyf4VB0GNFR9p6jh+4xqZ91A7vJ3LD7qpN+q1MdG5Cq6vAFvY7Yf1hL2pqWpUYjhEIFreKxcHEWslOh64Y0n5UGvrVZsDFiek5UMPehaYlNEZXExEhMNY08IVo9BwBQgnYyPiG+n7FZ2tmPJVquRwzx4HXC1zXK+TdX+uqVgGIZ4y2uViyPjBaFhbrPgc93Kbg1vtUD82t365xnC6khBIlFJgHT2RV64SojIz+7v4rbGLaS92+326F4kr4G7w++eDwcpfY1UAdGAgc5VARkL/UHgJf/eKWXkx5aTnELNCtO5KORskUibZg8BuJ9IzTyGK34b2BMHUQehrPU1FHBmUNjmfsiGzxkydYC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199018)(4326008)(66476007)(8676002)(66556008)(66946007)(4744005)(5660300002)(41300700001)(8936002)(6512007)(6506007)(1076003)(26005)(316002)(6666004)(186003)(2616005)(83380400001)(478600001)(6486002)(52116002)(86362001)(38100700002)(38350700002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?apBXKPzSOUJXlE35lQowewX3ctptt41+CjHdVWl3JAV/i/Z7FTdA+SjeHR3a?=
 =?us-ascii?Q?VCGV2FM3PtP1g6D8wb6rAqMt/w6foDho3brwdalFu0+QMVixuIe5JEt1Qnuu?=
 =?us-ascii?Q?6FN1el2W218QCu4meAsNfeJqMxgyj6+r4YHWni364fvafj38oHzeD1QASmW/?=
 =?us-ascii?Q?rVK4P9BIcZjSUuf1OjNneFhLNyRystmByy10NNGKJt0VM3WsIrcx7/tmc5rv?=
 =?us-ascii?Q?Lb0OhaE7hseKmjldEQZ36w0JF00+LsbwQpPzo9D06OqowAnPJ5Uu3j9JrQ9E?=
 =?us-ascii?Q?L10f/9kq597jjx3qUi1frcp1LJMQPdEGUrOH6z0JzHTTFc+Mx4oGN6lRq6m5?=
 =?us-ascii?Q?0symP+ZJ4rZwID/nAIluh2tjN9palmyM4G7/co2ovqKCuays88tisOAFWkoJ?=
 =?us-ascii?Q?fdzg6FDeluW7YARC1LgT7gap2SAnfqOf1gdmze6SWTzwxKAN656Aykig/b5U?=
 =?us-ascii?Q?1pR76tqB48+JTyQFWQapvrQKu92qZ6PpRHPN2Iz1bzSejk5Gp9B61NKktNMB?=
 =?us-ascii?Q?NGoi9oPvHT8SzukRDFLTjfunIiNx5VGXyLTCQsixgdw7C3PMrRQME2nW25cN?=
 =?us-ascii?Q?YzryNopMdEPcfOXGqKUzTrvg4IYDS5DYvBaRyeksVup9Zr2EpAyeR5aGd3kp?=
 =?us-ascii?Q?vFb6pWbRKLYN5fOcrIRxWygYj52RXZ+LO/hjQDaKAt0ZzFDNA6bhsf9cNa1Y?=
 =?us-ascii?Q?CrP4aPz3X1uN3FyE7e5NuoqIiEA3XVlKH8kXk85F/FsEl2vz+08tPkcWWfNo?=
 =?us-ascii?Q?Ai+rpq2AZFMP21eg1rBQqo7+Mjtn5aIbRWQ5D+ziMtSwdDz11ybjDzrX+XFB?=
 =?us-ascii?Q?2k3hH9UPJFq393QGOwfJOC0pycQF4wmfCf1M015Y8TJKMmQDI4Z3EiliNn5B?=
 =?us-ascii?Q?x5HaSOukZIVGq9ER9ALsQ1/VS8Y1aMIbffZ9v/v1DbE07VQXvd+1zAK1Eppt?=
 =?us-ascii?Q?RmSWQz9uB/JsapvK2CI+Jrjkq7i7D0oc7y6w8+xUz2JCVx4GkM+eB/4Z4/S4?=
 =?us-ascii?Q?8igMpRzEOyfvUsZPgXVRa4+BS6hcaoTuN0XGtFa21USPfT3aGW+RpM/RpQON?=
 =?us-ascii?Q?87b7Oyt2dQfdJWi2Hm/C9svImr1gFbCLr0IHft9kBMwTE4jS0cB/zUgSvPO6?=
 =?us-ascii?Q?OTMMQ5Y9asPSlHbRTQZTnaLkhPHaoAUu0+mFJ3mlAf7nAhLCcZL0Mq0/m1r3?=
 =?us-ascii?Q?s1Yw9zF+puIMyvWTaNZdyuuSyS7kOSF3n48Df7JaeLxk0LZiUCjNROoh/iTX?=
 =?us-ascii?Q?Oot2CrsF0R5cWo8+1hI9+ktXP0CP+YvAgeax/boghifcx7nv9dpoHfNQYdQ2?=
 =?us-ascii?Q?ySMjLpeGUmeekAwXmf7L+qrihiL4uXasiV5+dAlnPq3Yq34KasDwcilPsB5b?=
 =?us-ascii?Q?8Ou0BvNZBfa7bDWItvUzjlqcYw4STRM9H0LKlL0T+kawCGRgvAwNwOw16bbo?=
 =?us-ascii?Q?MDOHnz9TREqvkndpkTeAjt6GfXGTnknRrJuH8gIcp2SUnOm54+dr5tqSCbFs?=
 =?us-ascii?Q?vMxsWlENQ+JQv3aYoOwg3bqdG1LafhRvr/9FZ46sdB8h2NnPawUBEGbaWtgW?=
 =?us-ascii?Q?s5DLbUQeQcCJh2CaQANiXHh8Bn/RAbId/lFZOEsu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983261cb-393d-41c0-8707-08db2b8fcf37
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:14:46.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDga9laeWXQ7caMDoWjpdj55rDAjFSpLLlHg8tzWlmrx4mEk2jomHU/PlLmqajf1fjtwKpFqw3A9G6xx9e7lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clocks and clock-names are not documented and not used, drop them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 97d7df0813a5..70fadd79851a 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -130,8 +130,6 @@ pd: power-controller {
 		clk: clock-controller {
 			compatible = "fsl,imx8dxl-clk", "fsl,scu-clk";
 			#clock-cells = <2>;
-			clocks = <&xtal32k &xtal24m>;
-			clock-names = "xtal_32KHz", "xtal_24Mhz";
 		};
 
 		scu_gpio: gpio {
-- 
2.37.1

